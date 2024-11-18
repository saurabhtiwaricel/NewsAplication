//
//  TechTableViewCell.h
//  NewsAplication
//
//  Created by Celestial on 16/11/24.
//

#import <UIKit/UIKit.h>
#import "TechViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface TechTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelbl;

@property (weak, nonatomic) IBOutlet UILabel *descreptionlbl;



@end

NS_ASSUME_NONNULL_END
