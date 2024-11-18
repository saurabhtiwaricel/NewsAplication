//
//  TableViewCell.h
//  NewsAplication
//
//  Created by Celestial on 14/11/24.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelbl;
@property (weak, nonatomic) IBOutlet UILabel *descreptionlbl;

@end

NS_ASSUME_NONNULL_END
