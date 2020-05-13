#import "NetworkManager.h"

@implementation NetworkManager

- (void)request: (NSString *)method andURL: (NSString *)url {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: url]];
    [request setHTTPMethod: method];
    
    NSURLSessionDataTask *task = [[self getURLSession] dataTaskWithRequest:request completionHandler:^( NSData *data, NSURLResponse *response, NSError *error )
    {
        dispatch_async( dispatch_get_main_queue(),
        ^{
            NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog( @"%@", result );
        });
    }];
    
    [task resume];
}


- ( NSURLSession *)getURLSession
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

@end
