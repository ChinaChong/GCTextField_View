//
//  GCTextField.h
//  NashaClient
//
//  Created by chinachong on 16/8/5.
//  Copyright © 2016年 ChinaChong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCTextField : UITextField<UITextFieldDelegate>
@property (nonatomic,assign) NSInteger characterLength; // 用字符长度限制
@property (nonatomic,assign) NSInteger bytesCount;      // 用字节数限制
- (void)limitInput;
@end
