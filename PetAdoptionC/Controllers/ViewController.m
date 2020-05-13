#import "ViewController.h"
#import "NetworkManager.h"
#import "Movie.h"
#import "MovieCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> {
    
}
@property (strong, nonatomic) NSMutableArray<Movie *> *movieList;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

static NSString *cellId = @"movieCell";

- ( void )viewDidLoad
{
    [super viewDidLoad];
    self.table.delegate = self;
    self.table.dataSource = self;
//    NetworkManager * networkManager = [[NetworkManager alloc] init];
//    [networkManager request:@"GET" andURL:@"http://x-mode.co.il/exam/allMovies/allMovies.txt"];
    
    NSString *urlString = @"http://x-mode.co.il/exam/allMovies/allMovies.txt";
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"finished");
        
        
        NSError *err;
          NSDictionary *movieJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];

  
        if (err) {
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }
        
        NSMutableArray<Movie *> *movieList = NSMutableArray.new;
        NSLog(@"%@", movieJSON);
        for (NSDictionary *movieDict in movieJSON[@"movies"]) {
            
            NSString *name = movieDict[@"name"];
            Movie * movie = Movie.new;
            movie.name = name;
            [movieList addObject: movie];
           
        }
        self.movieList = movieList;
        NSLog(@"%@", self.movieList);
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.table reloadData];
        });
       
    }] resume];
}


#pragma mark - UITableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _movieList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier: cellId forIndexPath: indexPath];
    Movie *movie = self.movieList[indexPath.row];
    cell.movieName.text = movie.name;
    
    return cell;
}


@end
