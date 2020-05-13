#import "ViewController.h"
#import "NetworkManager.h"
#import "Movie.h"
#import "MovieCell.h"
#import "SecondViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> {
    
}
@property (strong, nonatomic) NSMutableArray<Movie *> *movieList;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

static NSString *cellId = @"movieCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self sendRequest];
}

-(void)sendRequest {
    NetworkManager * networkManager = [[NetworkManager alloc] init];
    [networkManager request:@"GET" andURL:@"http://x-mode.co.il/exam/allMovies/allMovies.txt" completion:^(NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Error %@", error );
        } else {
            NSError *err;
            NSDictionary *movieJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            
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
            if (err) {
                NSLog(@"Failed to serialize into JSON: %@", err);
                return;
            }
        }
    }];;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondViewController *pushedVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SecondVIewController"];
    pushedVC.movieName = _movieList[indexPath.row].name;

    [self.navigationController pushViewController:pushedVC animated:YES];
    
}

@end
