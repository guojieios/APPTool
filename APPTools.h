//
//  APPTools.h
//  checkNet
//
//  Created by 郭杰 on 2018/8/23.
//  Copyright © 2018年 郭杰. All rights reserved.
//



#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@interface APPTools : NSObject

//计算文字的CGSize
+ (CGSize)calculteTheSizeWithContent:(NSString*)content rect:(CGSize)rect font:(UIFont*)font;
//计算文字的高度
+(CGRect)boundRectWithSize:(NSString*)text size:(CGSize)size attributes:(NSDictionary*)dic;
#pragma mark - 根据字符串返回高度
+(CGFloat)getHeightWithStr:(NSString*)str width:(CGFloat)width font:(CGFloat)fontSize;
// 计算文字的宽度
+(CGFloat)getWidthWithHeight:(CGFloat)height font:(CGFloat)font str:(NSString *)string;

#pragma mark - 富文本
+(void)labelAttributeLabel:(UILabel*)label text:(NSString*)str arrRange:(NSRange)range colorHex:(NSString*)hex font:(CGFloat)font lineSpace:(CGFloat)lineSpace;


//验证字符串是否为空
+(BOOL)validateString:(NSString*)string;


#pragma mark - 获取当前控制器
+(UIViewController*)currentViewController;


//获取uuid
+(NSString*) uuid ;
//浮点数处理并去掉多余的0
+(NSString *)stringDisposeWithDouble:(double)dValue;

+(NSString *)notRounding:(double)price afterPoint:(int)position;

//格式话小数 只舍不入
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(double)floatV;
//四舍五入
+ (NSString *) decimalwithFormat2:(NSString *)format  floatV:(double)floatV;

//调整行间距
+ (NSAttributedString*)setWordLinesWithText:(NSString*)text Space:(int)space;

//改变label某个字体大小颜色
+ (NSAttributedString*)setLabelTextFont:(UIFont*)font Uicolor:(UIColor*)color  TextStr:(NSString*)str NsMakeRange:(int)start NsMakeRangeLength:(NSUInteger)length;

//舍去小数后面的零
+ (NSString*)isNsstringZero:(NSString*)str;











//将日期字符串按指定格式输出
+ (NSString*)dataFromString:(NSString*)date fromFormatter:(NSString*)fromFormatter  toFormatter:(NSString*)toFormatter;


//时间格式转换1 -- yyyy.MM.dd
+ (NSString*)changeTimeYMDFormat:(NSString*)time;

//时间格式转换2 -- yyyy-MM-dd HH:mm:ss
+ (NSString*)changeTimeYMDHMSWithNsstring:(NSString*)str;

//时间格式转换3 -- yyyy-MM-dd HH:mm
+ (NSString*)changeTimeYMDHMWithNsstring:(NSString*)str;

//HTML格式转换
+(NSString *)filterHTML:(NSString *)html;

//移除view上的子控件
+ (void)removeSubView:(UIView*)view;

//将图片保存到本地
+(void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key;

//本地是否有相关图片
+(BOOL)LocalHaveImage:(NSString*)key;

//从本地获取图片
+(UIImage*)GetImageFromLocal:(NSString*)key;


// 判断是否开启通知
+(BOOL)isMessageNotificationServiceOpen;






@end
