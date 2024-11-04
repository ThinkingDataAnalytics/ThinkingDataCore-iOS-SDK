//
//  TDMediator+RemoteConfig.h
//  ThinkingDataCore
//
//  Created by 杨雄 on 2024/3/6.
//

#if __has_include(<ThinkingDataCore/TDMediator.h>)
#import <ThinkingDataCore/TDMediator.h>
#else
#import "TDMediator.h"
#endif

#if __has_include(<ThinkingDataCore/TDSettings.h>)
#import <ThinkingDataCore/TDSettings.h>
#else
#import "TDSettings.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TDMediator (RemoteConfig)

- (void)tdRemoteConfigInitWithSettings:(nonnull TDSettings *)settings;

- (nullable NSString *)tdRemoteConfigGetClientUserIdWithAccountId:(nullable NSString *)accountId distinctId:(nullable NSString *)distinctId appId:(nonnull NSString *)appId;

- (nullable NSDictionary *)tdRemoteConfigGetDefaultValueWithAppId:(nonnull NSString *)appId;

- (nullable NSDictionary *)tdRemoteConfigGetSystemConfigWithAppId:(nonnull NSString *)appId;

- (BOOL)tdRemoteConfigIsSDKCloseWithAppId:(nonnull NSString *)appId;

@end


NS_ASSUME_NONNULL_END
