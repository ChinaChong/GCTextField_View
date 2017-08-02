//
//  GCTextView.m
//  NashaClient
//
//  Created by chinachong on 16/8/25.
//  Copyright © 2016年 ChinaChong. All rights reserved.
//

#import "GCTextView.h"

#pragma mark - 计算长度(中文占2,英文占1)
@interface NSString (JudgeString)

- (int)stringLengthOfBytesConvertToInt;

@end

@implementation NSString (JudgeString)

- (int)stringLengthOfBytesConvertToInt {
    int strlength = 0;
    char *p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

@end

@implementation GCTextView

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitInput) name:UITextViewTextDidChangeNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitInput) name:UITextViewTextDidChangeNotification object:nil];
    return self;
}

- (void)limitInput {
    if (self.characterLength && self.markedTextRange == nil) [self limitWordCount: self.characterLength];
    if (self.bytesCount && self.markedTextRange == nil)      [self limitBytesCount:self.bytesCount];
}

- (void)limitInputWithCharacterLength:(NSInteger)characterLength orBytesCount:(NSInteger)bytesCount {
    NSInteger limitValue = 0;
    if (characterLength) {
        limitValue = characterLength;
        [self limitWordCount:limitValue];
    }
    if (bytesCount) {
        limitValue = bytesCount;
        [self limitBytesCount:limitValue];
    }
}

- (void)limitBytesCount:(NSInteger)count {
    NSString *temp = self.text;
    NSInteger currentLength = temp.length;
    int currentTotalCount = [temp stringLengthOfBytesConvertToInt];
    if (currentTotalCount > count) {
        while ([temp stringLengthOfBytesConvertToInt] > count) {
            temp = [self.text substringToIndex:--currentLength];
        }
        self.text = temp;
    }
}

- (void)limitWordCount:(NSInteger)count {
    NSString *temp = self.text;
    NSInteger length = temp.length;
    if (length > count) {
        self.text = [temp substringToIndex:count];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

