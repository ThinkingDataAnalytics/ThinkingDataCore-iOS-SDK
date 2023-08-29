//
//  TAContext.h
//  ThinkingSDK.default-Base-Core-Extension-Router-Util-iOS
//
//  Created by wwango on 2022/10/7.
//


#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TAContext : NSObject

#if TARGET_OS_IOS
@property(nonatomic, strong) UIApplication *application;
#else
@property(nonatomic, strong) NSApplication *application;
#endif


@property(nonatomic, strong) NSDictionary *launchOptions;

@property(atomic, strong) NSDictionary *customParam;

+ (instancetype)shareInstance;

- (void)addServiceWithImplInstance:(id)implInstance serviceName:(NSString *)serviceName;

- (void)removeServiceWithServiceName:(NSString *)serviceName;

- (id)getServiceInstanceFromServiceName:(NSString *)serviceName;

@end

NS_ASSUME_NONNULL_END
