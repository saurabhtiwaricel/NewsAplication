//
//  NewsArticle.m
//  NewsAplication
//
//  Created by Celestial on 04/11/24.
//

#import "NewsArticle.h"
#import "ViewController.h"

@implementation NewsArticle

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = dictionary[@"title"];
        _descriptionText = dictionary[@"description"];
        _imageUrl = dictionary[@"urlToImage"];
        _url = dictionary[@"url"];
        
        _author = dictionary[@"author"];
        _publishedAt = dictionary[@"publishedAt"];
        _content = dictionary[@"content"];
        
    }
    return self;
   
}



- (NSString *)safeStringFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key {
    id value = dictionary[key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    return @"";  
}

@end
