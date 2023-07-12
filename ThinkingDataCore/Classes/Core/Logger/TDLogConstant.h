//
//  TDLogConstant.h
//  Pods
//
//  Created by 杨雄 on 2023/7/11.
//

#ifndef TDLogConstant_h
#define TDLogConstant_h

/**
 Log Level

 - TDLoggingLevelNone : Not enabled by default
 */
typedef NS_OPTIONS(NSInteger, TDLoggingLevel) {
    /**
     Not enabled by default
     */
    TDLoggingLevelNone  = 0,
    
    /**
     Error Log
     */
    TDLoggingLevelError = 1 << 0,
    
    /**
     Info  Log
     */
    TDLoggingLevelInfo  = 1 << 1,
    
    /**
     Debug Log
     */
    TDLoggingLevelDebug = 1 << 2,
};


#endif /* TDLogConstant_h */
