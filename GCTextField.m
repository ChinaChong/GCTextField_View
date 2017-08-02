//
//  GCTextField.m
//  NashaClient
//
//  Created by chinachong on 16/8/5.
//  Copyright © 2016年 ChinaChong. All rights reserved.
//

#import "GCTextField.h"

@interface GCTextField ()


@end

@implementation GCTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addTarget:self action:@selector(limitInput) forControlEvents:UIControlEventEditingChanged];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addTarget:self action:@selector(limitInput) forControlEvents:UIControlEventEditingChanged];
    }
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

- (BOOL)limitWordCount:(NSInteger)count {
    NSString *temp = self.text;
    NSInteger length = temp.length;
    if (length > count) {
        self.text = [temp substringToIndex:count];
        return NO;
    } else {
        return YES;
    }
}

@end
