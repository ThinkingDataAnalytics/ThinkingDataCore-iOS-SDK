//
//  TDMediator+Strategy.m
//  ThinkingDataCore
//
//  Created by 杨雄 on 2024/5/21.
//

#import "TDMediator+Strategy.h"

NSString * const kTDMediatorTargetStrategy = @"Strategy";

NSString * const kTDMediatorTargetStrategyActionNativeInit = @"nativeInitWithParams";

@implementation TDMediator (Strategy)

- (void)tdStrategyInitWithSettings:(TDSettings *)settings {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (settings) {
        params[@"settings"] = settings;
    }
    [[TDMediator sharedInstance] performTarget:kTDMediatorTargetStrategy action:kTDMediatorTargetStrategyActionNativeInit params:params shouldCacheTarget:NO];
}

@end
