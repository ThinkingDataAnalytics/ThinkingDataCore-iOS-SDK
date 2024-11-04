//
//  TDSettings.m
//  ThinkingDataCore
//
//  Created by 杨雄 on 2024/5/21.
//

#import "TDSettings.h"
#import "NSObject+TDCore.h"

@implementation TDTemplate

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [self init]) {
        self.templateCode = [dict[@"templateCode"] td_string];
        NSDictionary *customFetchParams = [dict[@"customFetchParams"] td_filterNull];
        if ([customFetchParams isKindOfClass:NSDictionary.class]) {
            self.customFetchParams = customFetchParams;
        }
    }
    return self;
}

@end

@implementation TDSettings

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [self init]) {
        self.appId = [dict[@"appId"] td_string];
        self.serverUrl = [dict[@"serverUrl"] td_string];
        NSNumber *timezoneOffset = [dict[@"defaultTimeZone"] td_number];
        if (timezoneOffset) {
            self.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:timezoneOffset.doubleValue * 3600];
        }
        self.enableLog = [dict[@"enableLog"] td_number].boolValue;
        self.enableAutoCalibrated = [dict[@"enableAutoCalibrated"] td_number].boolValue;
        self.enableAutoPush = [dict[@"enableAutoPush"] td_number].boolValue;
        self.encryptKey = [dict[@"encryptKey"] td_string];
        self.encryptVersion = [dict[@"encryptVersion"] td_number].integerValue;
        self.mode = [dict[@"mode"] td_number].integerValue;
        
        NSMutableArray<TDTemplate *> *templateObjectArray = [NSMutableArray array];
        NSArray *templates = [dict[@"templates"] td_filterNull];
        if ([templates isKindOfClass:NSArray.class]) {
            for (NSDictionary *templateDict in templates) {
                if ([templateDict isKindOfClass:NSDictionary.class]) {
                    TDTemplate *templateObj = [[TDTemplate alloc] initWithDictionary:templateDict];
                    [templateObjectArray addObject:templateObj];
                }
            }
        }
        self.templates = templateObjectArray;
    }
    return self;
}

@end
