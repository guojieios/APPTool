//
//  APPTools.m
//  checkNet
//
//  Created by 郭杰 on 2018/8/23.
//  Copyright © 2018年 郭杰. All rights reserved.
//

#import "APPTools.h"

@implementation APPTools

//计算文字的CGSize
+ (CGSize)calculteTheSizeWithContent:(NSString*)content rect:(CGSize)rect font:(UIFont*)font {
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize size = [content  boundingRectWithSize:rect                                        options:
                   NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                      attributes:attribute
                                         context:nil].size;
    return size;
}

+(CGRect)boundRectWithSize:(NSString*)text size:(CGSize)size attributes:(NSDictionary*)dic{
    
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect;
    
}




///MARK:根据字符串返回高度
+(CGFloat)getHeightWithStr:(NSString*)str width:(CGFloat)width font:(CGFloat)fontSize{
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    CGFloat textH = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size.height;
    return textH;
}
///MARK:动态计算宽度
+(CGFloat)getWidthWithHeight:(CGFloat)height font:(CGFloat)font str:(NSString *)string{
    UIFont * fonts = [UIFont systemFontOfSize:font];
    CGSize size  = CGSizeMake(MAXFLOAT,height);
    NSDictionary * dict  = [NSDictionary dictionaryWithObjectsAndKeys:fonts,NSFontAttributeName ,nil];
    size = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size.width;
}





#pragma mark - label 富文本
+(void)labelAttributeLabel:(UILabel*)label text:(NSString*)str arrRange:(NSRange)range colorHex:(NSString*)hex font:(CGFloat)font lineSpace:(CGFloat)lineSpace{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    if (font) {
        //    attrStr添加字体和设置字体的范围
        [attrStr addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:font]
                        range:range];
    }
    if (hex) {
        //    attrStr添加文字颜色
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithHexString:hex]
                        range:range];
    }
    if (lineSpace) {
        //        行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpace];
        //调整行间距
        [attrStr addAttribute:NSParagraphStyleAttributeName
                        value:paragraphStyle
                        range:NSMakeRange(0, [str length])];
    }
    
    //    return attrStr;
    label.attributedText = attrStr;
    
}






//验证字符串是否为空
+(BOOL)validateString:(NSString*)string{
    
    if ((![@"" isEqualToString:string])&&(![@"null" isEqualToString:string])&&(string!=nil)&&(![string isEqual:[NSNull null]])&&(![@"<NULL>" isEqualToString:string])&&(![@"<null>" isEqualToString:string])){
        return TRUE;
    }else{
        return FALSE;
    }
}

#pragma mark - 获取UUID
+(NSString*) uuid {
    
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    
    return identifierForVendor;
}

//浮点数处理并去掉多余的0
+(NSString *)stringDisposeWithDouble:(double)dValue
{
    NSString *str = [NSString stringWithFormat:@"%f",dValue];
    
    NSInteger len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        return [str substringToIndex:[str length]-1];//s.substring(0, len - i - 1);
    }
    else
    {
        return str;
    }
    
}


+(NSString *)notRounding:(double)price afterPoint:(int)position{
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal;
    
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
    
}

//格式话小数 只舍不入
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(double)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithDouble:floatV]];
}


//格式话小数 四舍五入
+ (NSString *) decimalwithFormat2:(NSString *)format  floatV:(double)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithDouble:floatV]];
}

//调整行间距
+ (NSAttributedString*)setWordLinesWithText:(NSString*)text Space:(int)space {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:space];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    return attributedString;
}
//改变label某个字体大小颜色
+ (NSAttributedString*)setLabelTextFont:(UIFont*)font Uicolor:(UIColor*)color  TextStr:(NSString*)str NsMakeRange:(int)start NsMakeRangeLength:(NSUInteger)length   {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(start, length)];
    
    UIFont *boldFont = font;
    [attributedString addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(start, length)];
    return  attributedString;
}
//舍去小数后面的零
+ (NSString*)isNsstringZero:(NSString*)str {
    NSArray *array = [str componentsSeparatedByString:@"."];
    if ([array[0] isEqualToString:@"0"]) {
        NSString *a = [str substringFromIndex:str.length - 1];
        if([a isEqualToString:@"0"]){
            return [NSString stringWithFormat:@"%@",[array[1] substringWithRange:NSMakeRange(0,1) ]];
        }else {
            return [NSString stringWithFormat:@"%d.%d",[array[1] intValue]/10,[array[1] intValue]%10];
        }
        
    }else {
        return [NSString stringWithFormat:@"%@",array[0]];
    }
}

#pragma mark -将日期字符串按指定格式输出
+ (NSString*)dataFromString:(NSString*)date fromFormatter:(NSString*)fromFormatter  toFormatter:(NSString*)toFormatter{
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    
    [dateFormatter1 setDateFormat:fromFormatter];
    
    NSDate* tempDate = [dateFormatter1 dateFromString:date];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    
    [dateFormatter2 setDateFormat:toFormatter];
    
    NSString *currentDateStr = [dateFormatter2 stringFromDate:tempDate];
    
    return currentDateStr;
    
}

//时间格式转换1
+ (NSString*)changeTimeYMDFormat:(NSString*)time
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    
    NSDate* date = [dateFormatter dateFromString:time];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}
//时间格式转换2
+ (NSString*)changeTimeYMDHMSWithNsstring:(NSString*)str {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[str integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    return currentDateStr;
    
}
//时间格式转换3
+ (NSString*)changeTimeYMDHMWithNsstring:(NSString*)str {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[str integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    return currentDateStr;
    
}
//HTML格式转换
+(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@"\n"];
    }
    
    return html;
}

//移除view上的子控件
+ (void)removeSubView:(UIView*)view {
    for (UIView *aView in view.subviews) {
        
        for (UIView *bView in aView.subviews) {
            
            if ([bView isMemberOfClass:[UILabel class]]||[bView isKindOfClass:[UILabel class]]) {
                UILabel *b = (UILabel*)bView;
                [b removeFromSuperview];
                b = nil;
                
            }
            
            if ([bView isMemberOfClass:[UIImageView class]]||[bView isKindOfClass:[UIImageView class]]) {
                UIImageView *bImage = (UIImageView*)bView;
                [bImage removeFromSuperview];
                bImage = nil;
                
            }
        }
        
        if ([aView isMemberOfClass:[UIView class]]||[aView isKindOfClass:[UIView class]]) {
            UIView *a = (UIView*)aView;
            [a  removeFromSuperview];
            a = nil;
            
        }
    }
}














#pragma mark - 将图片保存到本地
+ (void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    [preferences setObject:UIImagePNGRepresentation(image) forKey:key];
}

#pragma mark - 本地是否有相关图片
+ (BOOL)LocalHaveImage:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSData* imageData = [preferences objectForKey:key];
    if (imageData) {
        return YES;
    }
    return NO;
}

#pragma mark - 从本地获取图片
+ (UIImage*)GetImageFromLocal:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSData* imageData = [preferences objectForKey:key];
    UIImage* image;
    if (imageData) {
        image = [UIImage imageWithData:imageData];
    }
    else {
        NSLog(@"未从本地获得图片");
    }
    return image;
}

#pragma mark - 判断是否开启通知
+ (BOOL)isMessageNotificationServiceOpen {
    
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 8.0) {
        // 针对 9.0 以上的iOS系统进行处理
        return [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    } else {
        // 针对 9.0 以下的iOS系统进行处理
        return UIRemoteNotificationTypeNone != [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    }
    
    
}






#pragma mark - 寻找控制器
+(UIViewController*) findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    }
    else {
        
        // Unknown view controller type, return last child view controller
        return vc;
        
    }
    
}
#pragma mark - 获取当前控制器
+(UIViewController*)currentViewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [APPTools findBestViewController:viewController];
    
}






@end

