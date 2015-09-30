//
//  Communicator.m
//  PTS1
//
//  Created by Asheesh Agarwal on 9/22/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "Communicator.h"

@implementation Communicator

- (void) communicateData: (NSDictionary *) data ForURL: (NSString *) url completion: (void (^)(NSDictionary *)) completion {
    
    NSURL *remoteURL = [NSURL URLWithString:url];
    
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:data options:0 error:NULL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:remoteURL];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:JSONData];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *) response;
        
        // ToDo error needs to be checked and displayed accordingly.
        // In case of success, show success message
        NSDictionary *responseData;
        
        if(!error && httpResp.statusCode == 200){
            responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"Response: %@", responseData);
        }
        
        completion(responseData);
        
    }];
    
    [task resume];
}

@end
