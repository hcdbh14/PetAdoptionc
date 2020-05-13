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
    [networkManager request:(@"GET")];
    
    // insert whatever URL you would like to connect to
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://sonarsystems.co.uk/DeveloperTools/Tutorials/iOS_SDK/SendData.php?varGET=hello"]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *task = [[self getURLSession] dataTaskWithRequest:request completionHandler:^( NSData *data, NSURLResponse *response, NSError *error )
    {
        dispatch_async( dispatch_get_main_queue(),
        ^{
            // parse returned data
            NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            
            NSLog( @"%@", result );
        } );
    }];
    
    [task resume];
}


- ( NSURLSession * )getURLSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once( &onceToken,
    ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration];
    } );
    
    return session;
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
