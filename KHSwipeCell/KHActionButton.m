//
//  KHActionButton.m
//  KHSwipeCell
//
//  Created by Khan on 15-1-28.
//  Copyright (c) 2015年 Khan.lau. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "KHActionButton.h"

@interface KHActionButton ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy, readwrite) KHActionButtonHandler handler;
@end

@implementation KHActionButton

- (instancetype)initActionButtonWithTitle:(NSString *)title color:(UIColor *)color handler:(KHActionButtonHandler)handler
{
    self = [super init];
    if (self) {
        _title = title;
        _color = color;
        _handler = handler;
        
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setNumberOfLines:2];
        self.backgroundColor = color;
    }
    return self;
}

+ (instancetype)actionButtonWithTitle:(NSString *)title color:(UIColor *)color handler:(KHActionButtonHandler)handler
{
    KHActionButton *button = [[KHActionButton alloc] initActionButtonWithTitle:title color:color handler:handler];
    return button;
}

@end