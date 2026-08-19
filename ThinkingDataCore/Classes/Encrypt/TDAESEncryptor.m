//
//  TDAESEncryptor.m
//  ThinkingSDK
//
//  Created by wwango on 2022/1/21.
//

#import "TDAESEncryptor.h"
#import <CommonCrypto/CommonCryptor.h>
#import <Security/SecRandom.h>

/// AES-GCM IV / nonce length in bytes (aligned with Android SDK).
static const size_t kTDAesGcmIVLength = 12;
/// AES-GCM authentication tag length in bytes (128-bit tag).
static const size_t kTDAesGcmTagLength = 16;

// CommonCrypto GCM oneshot APIs are in libSystem but not in the public headers.
extern CCCryptorStatus CCCryptorGCMOneshotEncrypt(
    CCAlgorithm alg,
    const void *key,
    size_t keyLength,
    const void *iv,
    size_t ivLength,
    const void *aData,
    size_t aDataLength,
    const void *dataIn,
    size_t dataInLength,
    void *cipherOut,
    void *tagOut,
    size_t tagLength) API_AVAILABLE(macos(10.13), ios(11.0));

extern CCCryptorStatus CCCryptorGCMOneshotDecrypt(
    CCAlgorithm alg,
    const void *key,
    size_t keyLength,
    const void *iv,
    size_t ivLength,
    const void *aData,
    size_t aDataLength,
    const void *dataIn,
    size_t dataInLength,
    void *dataOut,
    const void *tagIn,
    size_t tagLength) API_AVAILABLE(macos(10.13), ios(11.0));

// Legacy GCM oneshot (iOS 5+ / macOS 10.8+), used as fallback below iOS 11.
extern CCCryptorStatus CCCryptorGCM(
    CCOperation op,
    CCAlgorithm alg,
    const void *key,
    size_t keyLength,
    const void *iv,
    size_t ivLen,
    const void *aData,
    size_t aDataLen,
    const void *dataIn,
    size_t dataInLength,
    void *dataOut,
    const void *tag,
    size_t *tagLength);

@interface TDAESEncryptor ()

@end

@implementation TDAESEncryptor

- (NSString *)randomKey {
    NSUInteger length = 16;
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    for (NSUInteger i = 0; i < length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex:arc4random_uniform((uint32_t)[letters length])]];
    }
    return randomString;
}

- (NSString *)key {
    if (_key == nil) {
        _key = [self randomKey];
    }
    return _key;
}

- (NSString *)algorithm {
    return @"AES";
}

- (NSData *)keyBytes {
    NSData *keyData = [self.key dataUsingEncoding:NSUTF8StringEncoding];
    if (!keyData || keyData.length == 0) {
        return nil;
    }
    if (keyData.length >= kCCKeySizeAES128) {
        return [keyData subdataWithRange:NSMakeRange(0, kCCKeySizeAES128)];
    }
    return nil;
}

- (NSData *)encryptData:(NSData *)data {
    if (!data) {
        return nil;
    }

    NSData *keyData = [self keyBytes];
    if (!keyData) {
        return nil;
    }

    uint8_t iv[kTDAesGcmIVLength];
    if (SecRandomCopyBytes(kSecRandomDefault, kTDAesGcmIVLength, iv) != errSecSuccess) {
        return nil;
    }

    NSMutableData *cipherData = [NSMutableData dataWithLength:data.length];
    uint8_t tag[kTDAesGcmTagLength];
    CCCryptorStatus status = kCCUnimplemented;

    if (@available(iOS 11.0, macOS 10.13, tvOS 11.0, watchOS 4.0, *)) {
        status = CCCryptorGCMOneshotEncrypt(kCCAlgorithmAES,
                                            keyData.bytes,
                                            keyData.length,
                                            iv,
                                            kTDAesGcmIVLength,
                                            NULL,
                                            0,
                                            data.bytes,
                                            data.length,
                                            cipherData.mutableBytes,
                                            tag,
                                            kTDAesGcmTagLength);
    } else {
        size_t tagLength = kTDAesGcmTagLength;
        status = CCCryptorGCM(kCCEncrypt,
                              kCCAlgorithmAES,
                              keyData.bytes,
                              keyData.length,
                              iv,
                              kTDAesGcmIVLength,
                              NULL,
                              0,
                              data.bytes,
                              data.length,
                              cipherData.mutableBytes,
                              tag,
                              &tagLength);
        if (status == kCCSuccess && tagLength != kTDAesGcmTagLength) {
            return nil;
        }
    }

    if (status != kCCSuccess) {
        return nil;
    }

    // Payload bytes: IV || ciphertext || tag (same layout as Android SDK).
    NSMutableData *combined = [NSMutableData dataWithCapacity:kTDAesGcmIVLength + cipherData.length + kTDAesGcmTagLength];
    [combined appendBytes:iv length:kTDAesGcmIVLength];
    [combined appendData:cipherData];
    [combined appendBytes:tag length:kTDAesGcmTagLength];
    return combined;
}

- (NSData *)decryptData:(NSData *)data {
    if (!data || data.length <= kTDAesGcmIVLength + kTDAesGcmTagLength) {
        return nil;
    }

    NSData *keyData = [self keyBytes];
    if (!keyData) {
        return nil;
    }

    const uint8_t *bytes = data.bytes;
    size_t cipherLength = data.length - kTDAesGcmIVLength - kTDAesGcmTagLength;
    const uint8_t *iv = bytes;
    const uint8_t *cipherBytes = bytes + kTDAesGcmIVLength;
    const uint8_t *tag = bytes + kTDAesGcmIVLength + cipherLength;

    NSMutableData *plainData = [NSMutableData dataWithLength:cipherLength];
    CCCryptorStatus status = kCCUnimplemented;

    if (@available(iOS 11.0, macOS 10.13, tvOS 11.0, watchOS 4.0, *)) {
        status = CCCryptorGCMOneshotDecrypt(kCCAlgorithmAES,
                                            keyData.bytes,
                                            keyData.length,
                                            iv,
                                            kTDAesGcmIVLength,
                                            NULL,
                                            0,
                                            cipherBytes,
                                            cipherLength,
                                            plainData.mutableBytes,
                                            tag,
                                            kTDAesGcmTagLength);
    } else {
        size_t tagLength = kTDAesGcmTagLength;
        status = CCCryptorGCM(kCCDecrypt,
                              kCCAlgorithmAES,
                              keyData.bytes,
                              keyData.length,
                              iv,
                              kTDAesGcmIVLength,
                              NULL,
                              0,
                              cipherBytes,
                              cipherLength,
                              plainData.mutableBytes,
                              tag,
                              &tagLength);
    }

    if (status != kCCSuccess) {
        return nil;
    }
    return plainData;
}

@end
