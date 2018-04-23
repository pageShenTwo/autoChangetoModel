//
//  NSObject+prototyWithModel.m
//  ajs;fjl
//
//  Created by JBT on 2018/4/19.
//  Copyright © 2018年 JBT. All rights reserved.
// 根据字典生成属性列表   需要不断完善  现在只增加了NSString,NSNumber,NSDictionary

#import "NSObject+prototyWithModel.h"

static NSString *const computerName = @"JBT";//电脑名称
static NSString *const userName = @"jbtspj";//电脑用户名  如果不知道可以在终端中找到/User/yourName 就是该name填入上边就可以了

@implementation NSObject (prototyWithModel)

+ (void)prototyWithModel:(NSDictionary *)dict modelName:(NSString *)modelName {
    
     NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey]; //获取项目名称
    
    // 获取当前时间并转换成相应的字符串
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSArray *dataArr = [strDate componentsSeparatedByString:@"-"];
    NSString *dateStr = [NSString stringWithFormat:@"%@/%@/%@",dataArr[0],dataArr[1],dataArr[2]];
    
    //@property (strong, nonatomic) NSString *name;
    NSMutableString *strM = [NSMutableString string];//.h文件
    NSMutableString *strM2 = [NSMutableString string];//.m文件
    [strM appendFormat:@"//\n//  %@.h\n//  %@\n//\n//  Created by %@ on %@.\n// Copyright © %@年 %@. All rights reserved.\n//\n\n#import <Foundation/Foundation.h>\n\n@interface %@ : NSObject",modelName,executableFile,computerName,dateStr,dataArr[0],computerName,modelName];//拼接.h文件
    
    [strM2 appendFormat:@"//\n//  %@.m\n//  %@\n//\n//  Created by %@ on %@.\n// Copyright © %@年 %@. All rights reserved.\n//\n\n#import \"%@.h\"\n\n@implementation %@",modelName,executableFile,computerName,dateStr,dataArr[0],computerName,modelName,modelName];// 拼接.m文件
    // 实现了plist文件中的7中类型   如出先更多请自行添加
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //[obj class]  是该属性是什么类型的值
        NSLog(@" key,obj ======= %@ %@",key,[obj class]);
        NSString *code = @"";
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")] || [obj isKindOfClass:NSClassFromString(@"NSTaggedPointerString")]){
            code = [NSString stringWithFormat:@"@property (strong, nonatomic) NSString *%@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
             code = [NSString stringWithFormat:@"@property (assign, nonatomic) NSInteger %@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
             code = [NSString stringWithFormat:@"@property (strong, nonatomic) NSDictionary *%@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFData")]){
            code = [NSString stringWithFormat:@"@property (strong, nonatomic) NSData *%@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSTaggedDate")]){
            code = [NSString stringWithFormat:@"@property (strong, nonatomic) NSDate *%@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")]){
            code = [NSString stringWithFormat:@"@property (strong, nonatomic) NSArray *%@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (assign, nonatomic) BOOL %@;",key];
        }
        [strM appendFormat:@"\n%@\n",code];
    }];
    [strM appendFormat:@"\n%@\n",@"@end"];
    [strM2 appendFormat:@"\n%@\n",@"@end"];
    
    NSString *savedFileName =[NSString stringWithFormat:@"/Users/%@/Desktop/%@.h",userName,modelName];
    NSString *savedFileName1 =[NSString stringWithFormat:@"/Users/%@/Desktop/%@.m",userName,modelName];
   BOOL writeState = [strM writeToFile:savedFileName atomically:YES encoding:NSUTF8StringEncoding error:nil];//创建.h
    
    BOOL writeState1 = [strM2 writeToFile:savedFileName1 atomically:YES encoding:NSUTF8StringEncoding error:nil];//创建.m
    if (writeState && writeState1) {
        NSLog(@"创建model文件成功");
    }else{
        NSString *reason = @"创建model文件失败";
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
        return;
    }
//
    
}
@end
