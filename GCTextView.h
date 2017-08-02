//
//  GCTextView.h
//  NashaClient
//
//  Created by chinachong on 16/8/25.
//  Copyright © 2016年 ChinaChong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCTextView : UITextView<UITextViewDelegate>
@property (nonatomic,assign) NSInteger characterLength; // 用字符长度限制
@property (nonatomic,assign) NSInteger bytesCount;      // 用字节数限制
- (void)limitInput;
@end
