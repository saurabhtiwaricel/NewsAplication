
#import "ViewController.h"
#import "NewsArticle.h"
#import <SafariServices/SafariServices.h>
#import <WebKit/WebKit.h>
#import "TableViewCell.h"

#define NEWS_API_URL @"https://newsapi.org/v2/top-headlines?country=us&apiKey=3e57d784fd8144d4b4a67fe0feb2bdfd"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.articles = [NSArray array];
    [self fetchNewsArticles];
    
    // Get the current date
        NSDate *currentDate = [NSDate date];

        // Set up the date formatter
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE, MMM d, yyyy"];

        // Convert the date to a string
        NSString *dateString = [dateFormatter stringFromDate:currentDate];

        // Set the label's text to the formatted date
    self.dateLabel.text = [NSString stringWithFormat:@"News of %@" ,dateString];
    
}

- (void)fetchNewsArticles {
    NSURL *url = [NSURL URLWithString:NEWS_API_URL];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil && data != nil) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *articlesJson = json[@"articles"];
            NSMutableArray *articlesArray = [NSMutableArray array];
            
            for (NSDictionary *articleDict in articlesJson) {
                NewsArticle *article = [[NewsArticle alloc] initWithDictionary:articleDict];
                if (![article.title isEqualToString:@"[Removed]"]) {
                [articlesArray addObject:article];
                }
            }
            
            self.articles = articlesArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    [dataTask resume];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
        
        // Get the current article
        NewsArticle *article = self.articles[indexPath.row];

        // Safely set title
        cell.titlelbl.text = (article.title && ![article.title isKindOfClass:[NSNull class]]) ? article.title : @"No Title";
        
        // Safely set description
    cell.descreptionlbl.text = (article.author && ![article.author isKindOfClass:[NSNull class]]) ? article.author : @" ";
        
        // Load image only if the URL string is not null
        if (article.imageUrl && ![article.imageUrl isKindOfClass:[NSNull class]] && article.imageUrl.length > 0) {
            NSURL *imageUrl = [NSURL URLWithString:article.imageUrl];
            NSURLSessionDataTask *downloadImageTask = [[NSURLSession sharedSession]
                                                       dataTaskWithURL:imageUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (error == nil && data != nil) {
                    UIImage *image = [UIImage imageWithData:data];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.newsImageView.image = image;
                        [cell setNeedsLayout];
                    });
                }
            }];
            [downloadImageTask resume];
        }
        else {
            // Set a placeholder image if the URL is missing or invalid
            cell.newsImageView.image = [UIImage imageNamed:@"placeholder"];
        }

    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsArticle *article = self.articles[indexPath.row];
 
    NSURL *url = [NSURL URLWithString:article.url];
    
   
    if (url) {
      
        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
        [self presentViewController:safariVC animated:YES completion:nil];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}





@end
