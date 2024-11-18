//
//  NewsArticle.h
//  NewsAplication
//
//  Created by Celestial on 04/11/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsArticle : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *publishedAt;
@property (nonatomic, strong) NSString *content;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;



@end

NS_ASSUME_NONNULL_END
