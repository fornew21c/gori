//
//  MainVC.m
//  AMSlideSample
//
//  Created by Woncheol on 2017. 3. 31..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "MainVC.h"
#import "GODataCenter2.h"
@interface MainVC ()
<AMSlideMenuDelegate>
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    NSString *identifier;

    switch (indexPath.row) {
        case 0:
            identifier = @"mainSegue"; //메인페이지
            break;
        case 1:
            //identifier = @"loginSegue"; //로그인 페이지
            NSLog(@"%@", [[GODataCenter2 sharedInstance] getMyLoginToken]);

            if( [[GODataCenter2 sharedInstance] getMyLoginToken] == NULL) {
                identifier = @"loginSegue"; //로그인 페이지
            }
            else {
                identifier = @"mypageSegue"; //마이 페이지
            }
            break;
        case 2:
            NSLog(@"signupSegue");
            if( [[GODataCenter2 sharedInstance] getMyLoginToken] == NULL) {
                identifier = @"signupSegue"; //회원가입 페이지
            }
            else {
                NSLog(@"로그아웃");
            }
            
            break;
    }
    
    NSLog(@"git Test2222");
    return identifier;
}

- (NSString *)segueIdentifierForIndexPathInRightMenu:(NSIndexPath *)indexPath
{
    NSString *identifier;
    switch (indexPath.row) {
        case 0:
            identifier = @"firstRightSegue";
            break;
        case 1:
            identifier = @"secondRightSegue";
            break;
    }
    
    return identifier;
}


- (void)configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0,0};
    frame.size = (CGSize){40,40};
    button.frame = frame;
    
    [button setImage:[UIImage imageNamed:@"menu@3x.png"] forState:UIControlStateNormal];
    
}

- (void)configureRightMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0,0};
    frame.size = (CGSize){40,40};
    button.frame = frame;
    
    [button setImage:[UIImage imageNamed:@"menu@3x.png"] forState:UIControlStateNormal];
    
}

- (CGFloat)leftMenuWidth
{
    return 240;
}

- (AMPrimaryMenu)primaryMenu
{
    return AMPrimaryMenuLeft;
}

- (BOOL)deepnessForLeftMenu
{
    return YES;
}

- (BOOL)deepnessForRightMenu
{
    return YES;
}

@end
