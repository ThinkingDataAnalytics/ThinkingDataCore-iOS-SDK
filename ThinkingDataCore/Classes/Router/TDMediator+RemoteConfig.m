//
//  TDMediator+RemoteConfig.m
//  ThinkingDataCore
//
//  Created by 杨雄 on 2024/3/6.
//

#import "TDMediator+RemoteConfig.h"

NSString * const kTDMediatorTargetRemoteConfig = @"RemoteConfig";

NSString * const kTDMediatorTargetRemoteConfigActionNativeInit = @"nativeInitWithParams";
NSString * const kTDMediatorTargetRemoteConfigActionNativeGetClientUserId = @"nativeGetClientUserIdWithParams";
NSString * const kTDMediatorTargetRemoteConfigActionNativeGetDefaultValue = @"nativeGetDefaultValueWithParams";
NSString * const kTDMediatorTargetRemoteConfigActionNativeGetSystemConfig = @"nativeGetSystemConfigWithParams";
NSString * const kTDMediatorTargetRemoteConfigActionNativeIsSDKClose = @"nativeIsSDKCloseWithParams";

@implementation TDMediator (RemoteConfig)

- (void)tdRemoteConfigInitWithSettings:(TDSettings *)settings {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (settings) {
        params[@"settings"] = settings;
    }
    [[TDMediator sharedInstance] performTarget:kTDMediatorTargetRemoteConfig action:kTDMediatorTargetRemoteConfigActionNativeInit params:params shouldCacheTarget:NO];
}

- (NSString *)tdRemoteConfigGetClientUserIdWithAccountId:(NSString *)accountId distinctId:(NSString *)distinctId appId:(nonnull NSString *)appId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (accountId.length) {
        params[@"accountId"] = accountId;
    }
    if (distinctId.length) {
        params[@"distinctId"] = distinctId;
    }
    if (appId.length) {
        params[@"appId"] = appId;
    }
    NSString *userId = [[TDMediator sharedInstance] performTarget:kTDMediatorTargetRemoteConfig action:kTDMediatorTargetRemoteConfigActionNativeGetClientUserId params:params shouldCacheTarget:NO];
    return userId;
}

- (NSDictionary *)tdRemoteConfigGetDefaultValueWithAppId:(NSString *)appId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (appId.length) {
        params[@"appId"] = appId;
    }
    NSDictionary *dict = [[TDMediator sharedInstance] performTarget:kTDMediatorTargetRemoteConfig action:kTDMediatorTargetRemoteConfigActionNativeGetDefaultValue params:params shouldCacheTarget:NO];
    return dict;
}

- (NSDictionary *)tdRemoteConfigGetSystemConfigWithAppId:(NSString *)appId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (appId.length) {
        params[@"appId"] = appId;
    }
    NSDictionary *dict = [[TDMediator sharedInstance] performTarget:kTDMediatorTargetRemoteConfig action:kTDMediatorTargetRemoteConfigActionNativeGetSystemConfig params:params shouldCacheTarget:NO];
    return dict;
}

- (BOOL)tdRemoteConfigIsSDKCloseWithAppId:(NSString *)appId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (appId.length) {
        params[@"appId"] = appId;
    }
    NSNumber *value = [[TDMediator sharedInstance] performTarget:kTDMediatorTargetRemoteConfig action:kTDMediatorTargetRemoteConfigActionNativeIsSDKClose params:params shouldCacheTarget:NO];
    return value.boolValue;
}

@end