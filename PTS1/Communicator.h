//
//  Communicator.h
//  PTS1
//
//  Created by Asheesh Agarwal on 9/22/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Communicator : NSObject

- (void) communicateData: (NSDictionary *) data ForURL: (NSString *) url completion: (void (^)(NSDictionary *)) completion;


@end
