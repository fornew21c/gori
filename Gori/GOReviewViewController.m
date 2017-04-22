//
//  GOReviewViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 22..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOReviewViewController.h"
#import "GODataCenter2.h"
#import "GOReviewTableViewCell.h"
#import <HCSStarRatingView/HCSStarRatingView.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "GOReviewModel.h"

@interface GOReviewViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet HCSStarRatingView *curriculumReview;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *readinessReview;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *timelinessReview;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *deliveryReview;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *friendlinessReview;
@property GOReviewModel *reviews;
@property NSMutableArray *reviewsLists;
@property NSMutableDictionary *reviewUser;

@property (weak, nonatomic) IBOutlet UITableView *reviewTable;


@end

@implementation GOReviewViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    
    NSUInteger pk = [GODataCenter2 sharedInstance].selectedModel.postID;
    [[GODataCenter2 sharedInstance] reviewList:pk completion:^(BOOL isSuccess, id respons) {
        if(isSuccess)
        {
            self.reviews = [GOReviewModel modelWithData:respons];
            [self makeData];
            NSLog(@"count: %@", [[respons objectForKey:@"results"] objectAtIndex:0]);
            [self.reviewTable reloadData];
            
        }else
        {
            
        }
    }];
    // Do any additional setup after loading the view.
    
    NSMutableDictionary *averageRate = [[NSMutableDictionary alloc] init];
    averageRate = [GODataCenter2 sharedInstance].selectedModel.averageRate;
    self.curriculumReview.value = [[averageRate objectForKey:@"curriculum"] floatValue];
    self.readinessReview.value = [[averageRate objectForKey:@"readiness"] floatValue];
    self.timelinessReview.value = [[averageRate objectForKey:@"timeliness"] floatValue];
    self.deliveryReview.value = [[averageRate objectForKey:@"timeliness"] floatValue];
    self.friendlinessReview.value = [[averageRate objectForKey:@"friendliness"] floatValue];
    //self.reviews = [GODataCenter2 sharedInstance].selectedModel.reviews;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,70,70)];
    titleLabel.font = [UIFont systemFontOfSize:17.0f];
    NSString *tmp = @"리뷰 ";
    //self.reviews.count
    titleLabel.text = [[tmp stringByAppendingString:[NSString stringWithFormat:@"%ld", self.reviews.reviewsContents.count]] stringByAppendingString:@"개"];
    self.navigationItem.titleView = titleLabel;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeData {
    NSLog(@" 리뷰카운트 at makedata: %lu", self.reviews.reviewsContents.count);
    self.reviewsLists = self.reviews.reviewsContents;
    NSLog(@"makeData: %lu", self.reviewsLists.count);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GOReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[GOReviewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
   
    [cell.reviewerImage sd_setImageWithURL: [[[self.reviewsLists objectAtIndex:indexPath.row] objectForKey:@"user"] objectForKey:@"profile_image"]];
   
    cell.reviewerName.text = [[[self.reviewsLists objectAtIndex:indexPath.row] objectForKey:@"user"] objectForKey:@"name"];
    cell.reviewerCreateDate.text = [[[self.reviewsLists objectAtIndex:indexPath.row] objectForKey:@"created_date"]substringToIndex:10];
    cell.reviewCommnet.text = [[self.reviewsLists objectAtIndex:indexPath.row] objectForKey:@"comment"] ;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection: %lu", self.reviewsLists.count);
    return self.reviewsLists.count;
}

//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:NO];
//    
//    [self.reviewTable reloadData];
//    
//}



@end