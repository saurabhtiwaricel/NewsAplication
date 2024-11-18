//
//  TechViewController.h
//  NewsAplication
//
//  Created by Celestial on 16/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TechViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *articles;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end


//@property (nonatomic, strong) NSArray<NewsArticle *> *articles; // Declare the articles property
//@property (weak, nonatomic) IBOutlet UILabel *dateLabel; // Link the date label from the storyboard
NS_ASSUME_NONNULL_END
