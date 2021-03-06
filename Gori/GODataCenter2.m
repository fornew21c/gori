//
//  GODataCenter2.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 7..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GODataCenter2.h"

@interface GODataCenter2()

@property (nonatomic) NetworkModule *nManager;
@property (nonatomic, strong) NSString *token;

@property (nonatomic, readwrite) NSMutableArray *postList;
@property (nonatomic) BOOL canNextPage;
@end

@implementation GODataCenter2

+ (instancetype)sharedInstance
{
    static GODataCenter2 *center;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[GODataCenter2 alloc] init];
    });
    
    return center;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nManager = [[NetworkModule alloc] init];
        self.postList = [[NSMutableArray alloc] init];
        self.canNextPage = YES;
    }
    return self;
}

- (NSString *)token
{
    if (_token == nil) {
        _token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    }
    
    return _token;
}

- (BOOL)isAvaliblePageRequest
{
    if ([self token] != nil && self.canNextPage) {
        return YES;
    }else
    {
        return NO;
    }
}


//오토 로그인 확인 메소드
- (BOOL)isAutoLogin
{
    NSString *nowToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    if (nowToken != nil && nowToken.length > 0) {
        self.token = nowToken;
        return YES;
    }
    
    return NO;
}

#pragma mark - RequestMethod
- (void)loginWithEmail:(NSString *)email pw:(NSString *)pw completion:(CompletionBlock)completion
{
    [self.nManager loginRequestWithEmail:email pw:pw completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            NSString *token = [(NSDictionary*)respons objectForKey:@"key"];
            [self saveToken:token];
        }
        completion(isSuccess,respons);
        
    }];
    
    // [self.nManager loginRequestWithUserID:userID pw:pw completion:completion];
    
}


- (void)signupWithID:(NSString *)userID email:(NSString *)email pw:(NSString *)pw repw:(NSString *)repw completion:(CompletionBlock)completion
{
    [self.nManager signupRequestWithUserID:userID email:email pw:pw repw:repw completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            NSString *token = [(NSDictionary*)respons objectForKey:@"key"];
            NSLog(@"key:%@", token);
            [self saveToken:token];
        }
        completion(isSuccess, respons);
    }];
    
}

- (void)logoutCompletion:(CompletionBlock)completion
{
    [self.nManager logoutRequestCompletion:^(BOOL isSuccess, id respons) {
        [self.postList removeAllObjects];
        [self removeToken];
        completion(isSuccess,respons);
    }];
}



//포스트 리스트 불러오기
- (void)postListWithPage:(NSInteger)page completion:(CompletionBlock)completion
{
    [self.nManager postListRequestWithPage:@1 completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            NSArray *list = [(NSDictionary *)respons objectForKey:@"results"];
            [self postModelListWithData:list];
            //다음 페이지가 없으면 self.canNextPage = NO
            
            completion(YES, self.postList);
        }else
        {
            completion(NO, nil);
        }
    }];
}
//포스트 디테일 보기
- (void)requestPostRetrieveID:(NSNumber*)pk completion:(CompletionBlock)completion
{
    [self.nManager postRetrieveRequestWithPostID:pk completion:completion];
}

- (void)postModelListWithData:(NSArray *)dataList
{
    
//    if(self.postList == nil)
//    {
//        self.postList  = [[NSMutableArray alloc] init];
//    }
//    
//    for (NSDictionary *data in dataList) {
//        [self.postList addObject:[PostModel modelWithData:data]];
//    }
}

#pragma mark - private Method
- (void)saveToken:(NSString *)newToken
{
    self.token = newToken;
    [[NSUserDefaults standardUserDefaults] setObject:newToken forKey:@"token"];
}

- (void)removeToken
{
    self.token = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
}

- (void) setMyLoginToken:(NSString *)newToken {
    [[NSUserDefaults standardUserDefaults] setObject:newToken forKey:@"token"];
}

- (NSString*) getMyLoginToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}

//수업신청하기
- (void)registerCreateWithLocationPK:(NSUInteger)locationPK
                        studentLevel:(NSUInteger)studentLevel
               studentExperienceMonth:(NSUInteger)studentExperienceMonth
                       messageToTutor:(NSString*)messageToTutor
                          completion:(CompletionBlock)completion
{
    [self.nManager postRegisterCreateWithLocationPK:locationPK studentLevel:studentLevel studentExperienceMonth:studentExperienceMonth messageToTutor:messageToTutor completion:completion];
}

- (void)loginWithFacebookid:(NSString*)facebookToken completion:(CompletionBlock)completion
{
    [self.nManager loginRequestWithFacebookid:facebookToken completion:completion];
}

- (void)wishToggle:(NSNumber*)pk completion:(CompletionBlock)completion {
    [self.nManager wishToggleWithPK:pk completion:completion];

}

- (void)reviewList:(NSUInteger)pk completion:(CompletionBlock)completion {
    [self.nManager getReivewListWithPK:pk completion:completion];
}
- (void)registerReviewWithPK:(NSUInteger)pk
                  curriculum:(NSUInteger)curriculum
                   readiness:(NSUInteger)readiness
                  timeliness:(NSUInteger)timeliness
                    delivery:(NSUInteger)delivery
                friendliness:(NSUInteger)friendliness
                     comment:(NSString*)comment
                  completion:(CompletionBlock)completion
{
    [self.nManager postReviewCreateWithPK:pk curriculum:curriculum readiness:readiness timeliness:timeliness delivery:delivery friendliness:friendliness comment:comment completion:completion];
}

//plist 가져오기
- (NSArray*)getSample {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"locations" ofType:@"plist"];
        self.locationList = [NSArray arrayWithContentsOfFile:filePath];
    
        return self.locationList;

}
@end
