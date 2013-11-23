//
//  MI6LocationToAddressHelper.m
//  Genetec.MI6
//
//  Created by MoAir on 11/23/2013.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import "MI6LocationToAddressHelper.h"
#import "CJSONDeserializer.h"

@interface MI6LocationToAddressHelper ()
{
    NSMutableData *_responseData;
}
@end

@implementation MI6LocationToAddressHelper

@synthesize coordinate;

-(void)convertToAddress
{
    // Create the request.
    NSString* coordinateString = [NSString stringWithFormat:@"%f,%f",
                                 coordinate.coordinate.latitude,
                                 coordinate.coordinate.longitude];
    NSString* requestString = @"http://www.mapquestapi.com/geocoding/v1/reverse?key=Fmjtd%7Cluubn90bnl%2C22%3Do5-902g9f&callback=renderReverse&location=";
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",
                                                                                requestString,
                                                                                coordinateString]]];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    NSError *error ;
    NSString* responseString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    NSString* jsonString = [responseString substringWithRange:NSMakeRange(14, responseString.length - 14 - 2)];
    
    NSDictionary* responseObject = [[CJSONDeserializer deserializer] deserializeAsDictionary:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                            error:&error];
    
    
    if (error)
    {
        NSLog([error description]);
        [self.delegate locationToAddressHelperdidFailToGetAddress:self];
    }
    else
    {
        NSString* streetName = [[[[[responseObject valueForKey:@"results"] valueForKey:@"locations"] valueForKey:@"street"] objectAtIndex:0] objectAtIndex:0];
        [self.delegate locationToAddressHelper:self didFinishWithAddress:streetName];
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end
