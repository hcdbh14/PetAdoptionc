#import "NetworkManager.h"

@implementation NetworkManager

- (void)request: (NSString *)method andURL: (NSString *)url completion:(void (^)(NSData *data, NSError *error))completion {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: url]];
    [request setHTTPMethod: method];
    
    NSURLSessionDataTask *task = [[self getURLSession] dataTaskWithRequest:request completionHandler:^( NSData *data, NSURLResponse *response, NSError *error )
                                  {
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSInteger statusCode = [httpResponse statusCode];
        
        if (statusCode >= 200 && statusCode < 299) {
            NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog( @" \n 🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹 \n %@", result );
        } else if (statusCode >= 300 && statusCode <= 500) {
            NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog( @" \n 🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻 \n %@", result);
        } else {
            NSLog(@" \n 🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻 \n %@", error);
        }
        completion(data, error);
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
