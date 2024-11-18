//
//  ViewController.h
//  NewsAplication
//
//  Created by Celestial on 04/11/24.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *articles;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

