#import "ViewController.h"
#import "NetworkManager.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *petList;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

- ( void )viewDidLoad
{
    [super viewDidLoad];
    
    NetworkManager * networkManager = [[NetworkManager alloc] init];
    
    [networkManager request:@"GET" andURL:@"http://x-mode.co.il/exam/allMovies/allMovies.txt"];
    
}


#pragma mark - UITableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return petList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellId = @"petCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
    return cell;
}


@end
