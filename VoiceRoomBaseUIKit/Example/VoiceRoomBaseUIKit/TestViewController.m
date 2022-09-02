//
//  TestViewController.m
//  VoiceRoomBaseUIKit_Example
//
//  Created by 朱继超 on 2022/9/2.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

#import "TestViewController.h"
#import "VoiceRoomBaseUIKit_Example-Swift.h"
#import <VoiceRoomIMKit/VoiceRoomIMKit-Swift.h>
#import <VoiceRoomBaseUIKit/VoiceRoomBaseUIKit-Swift.h>

#define ScreenHeight UIScreen.mainScreen.bounds.size.height

#define ScreenWidth UIScreen.mainScreen.bounds.size.width

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [VoiceRoomIMManager.shared addChatRoomListener];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:self.view.bounds];
    iv.image = [UIImage imageNamed:@"bg03"];
    [self.view addSubview:iv];
    VoiceRoomChatView *chatView = [[VoiceRoomChatView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 33 - 220 - 60, ScreenWidth,220)];
    [self.view addSubview:chatView];
    VoiceRoomGiftView *gitf = [[VoiceRoomGiftView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(chatView.frame) - (ScreenWidth/9.0*2)-10, ScreenWidth/3.0*2, ScreenWidth/9.0*2)];
    [self.view addSubview:gitf];
    VoiceRoomChatBar *bar = [[VoiceRoomChatBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(chatView.frame)+10, ScreenWidth, 50)];
    [self.view addSubview:bar];
}

@end
