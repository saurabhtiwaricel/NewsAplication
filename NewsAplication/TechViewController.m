#import "TechViewController.h"
#import "NewsArticle.h"
#import "TechTableViewCell.h"
#import <SafariServices/SafariServices.h>
#import <WebKit/WebKit.h>

#define NEWS_API_URL @"https://newsapi.org/v2/everything?q=apple&from=2024-11-15&to=2024-11-15&sortBy=popularity&apiKey=3e57d784fd8144d4b4a67fe0feb2bdfd"

@interface TechViewController ()



@end

@implementation TechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize articles array
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
    self.dateLabel.text = [NSString stringWithFormat:@"Tech News of %@", dateString];
}

- (void)fetchNewsArticles {
    NSURL *url = [NSURL URLWithString:NEWS_API_URL];
    __weak typeof(self) weakSelf = self; // Avoid retain cycle
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf; // Strong reference within block
        if (!strongSelf) return;
        
        if (error == nil && data != nil) {
            NSError *jsonError;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (jsonError) {
                NSLog(@"Error parsing JSON: %@", jsonError.localizedDescription);
                return;
            }
            
            NSArray *articlesJson = json[@"articles"];
            NSMutableArray *articlesArray = [NSMutableArray array];
            
            for (NSDictionary *articleDict in articlesJson) {
                NewsArticle *article = [[NewsArticle alloc] initWithDictionary:articleDict];
                if (![article.title isEqualToString:@"[Removed]"]) {
                    [articlesArray addObject:article];
                }
            }
            
            strongSelf.articles = [articlesArray copy];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView reloadData];
            });
        }
    }];
    [dataTask resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TechTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TechNewsCell" forIndexPath:indexPath];
    
    // Get the current article
    NewsArticle *article = self.articles[indexPath.row];
    
    // Safely set title
    cell.titlelbl.text = (article.title && ![article.title isKindOfClass:[NSNull class]]) ? article.title : @"No Title";
    
    // Safely set description
    cell.descreptionlbl.text = (article.author && ![article.author isKindOfClass:[NSNull class]]) ? article.author : @" ";
    
    // Load image only if the URL string is not null
    if (article.imageUrl && ![article.imageUrl isKindOfClass:[NSNull class]] && article.imageUrl.length > 0) {
        NSURL *imageUrl = [NSURL URLWithString:article.imageUrl];
        NSURLSessionDataTask *downloadImageTask = [[NSURLSession sharedSession] dataTaskWithURL:imageUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error == nil && data != nil) {
                UIImage *image = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.newsImageView.image = image;
                    [cell setNeedsLayout];
                });
            }
        }];
        [downloadImageTask resume];
    } else {
        // Set a placeholder image if the URL is missing or invalid
        cell.newsImageView.image = [UIImage imageNamed:@"placeholder"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsArticle *article = self.articles[indexPath.row];
    
    if (article.url && ![article.url isKindOfClass:[NSNull class]]) {
        NSURL *url = [NSURL URLWithString:article.url];
        if (url) {
            SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
            [self presentViewController:safariVC animated:YES completion:nil];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

@end
