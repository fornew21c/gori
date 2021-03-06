//
//  NetworkModule.h
//  NetworkProject
//
//  Created by youngmin joo on 2017. 3. 14..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(BOOL isSuccess, id respons);

static NSString * const BASE_URL = @"https://mozzi.co.kr/api";
static NSString * const SIGNUP_URL = @"/member/signup/";    //POST
static NSString * const LOGIN_URL = @"/member/login/";      //GET
static NSString * const FACEBOOK_LOGIN_URL = @"/member/fb_login/"; //POST
static NSString * const LOGOUT_URL = @"/member/logout/";    //POST
static NSString * const USERDETAIL_URL = @"/member/profile/";//GET
static NSString * const POST_URL = @"/post/";               //POST - MULTIPART
static NSString * const POST_LIST_URL = @"/post/";           //GET
static NSString * const GET_DETAIL_URL = @"/talent/detail-all/";           //GET 수업 상세보기
static NSString * const POST_REGISTER_CREATE = @"/talent/add/registration/";     //수업신청하기
static NSString * const TALENT = @"/talent/";
static NSString * const WISH_TOGGLE =  @"/wish-list/toggle/"; //wish toggle
static NSString * const REVIEW_REGISTER = @"/talent/add/review/"; //리뷰 등록
static NSString * const TALENT_DETAIL = @"/talent/detail/";
static NSString * const REVIEW_LIST = @"/review/"; //리뷰 조회

@interface NetworkModule : NSObject


- (void)signupRequestWithUserID:(NSString *)userID
                          email:(NSString *)email
                             pw:(NSString *)pw
                           repw:(NSString *)repw
                     completion:(CompletionBlock)completion;

- (void)loginRequestWithEmail:(NSString *)email pw:(NSString *)pw completion:(CompletionBlock)completion;

- (void)logoutRequestCompletion:(CompletionBlock)completion;
- (void)postListRequestWithPage:(NSNumber *)page completion:(CompletionBlock)completion;
- (void)postRetrieveRequestWithPostID:(NSNumber *)pk completion:(CompletionBlock)completion;
- (void)loginRequestWithFacebookid:(NSString *)fbAccessToken completion:(CompletionBlock)completion;
- (void)postRegisterCreateWithLocationPK:(NSUInteger)locationPK
                        studentLevel:(NSUInteger)studentLevel
              studentExperienceMonth:(NSUInteger)studentExperienceMonth
                      messageToTutor:(NSString*)messageToTutor
                          completion:(CompletionBlock)completion;
- (void)wishToggleWithPK:(NSNumber*)pk completion:(CompletionBlock)completion;
- (void)getReivewListWithPK:(NSUInteger)pk completion:(CompletionBlock)completion;
- (void)postReviewCreateWithPK:(NSUInteger)pk
                  curriculum:(NSUInteger)curriculum
                   readiness:(NSUInteger)readiness
                  timeliness:(NSUInteger)timeliness
                    delivery:(NSUInteger)delivery
                friendliness:(NSUInteger)friendliness
                     comment:(NSString*)comment
                  completion:(CompletionBlock)completion;

@end
