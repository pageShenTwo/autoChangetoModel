//
//  NSObject+prototyWithModel.h
//  ajs;fjl
//
//  Created by JBT on 2018/4/19.
//  Copyright © 2018年 JBT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (prototyWithModel)

/**
 根据字典生成model文件

 @param dict json数据
 @param modelName 生成的文件名字
 */
+ (void)prototyWithModel:(NSDictionary *)dict modelName:(NSString *)modelName;
@end
