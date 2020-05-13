#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

- (void)request: (NSString *)method andURL: (NSString *)url;


@end

NS_ASSUME_NONNULL_END
