//
//  Photo+Flickr.m
//  Photomania
//
//  Created by Yuhua Mai on 8/5/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "Photo+Flickr.h"
#import "FlickrFetcher.h"
#import "Photographer+Create.h"

@implementation Photo (Flickr)

+ (Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photo *photo = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", [photoDictionary[FLICKR_PHOTO_ID] description]];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
        //handle errors
    } else if (![matches count]){ //no object
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        
        photo.unique = [photoDictionary[FLICKR_PHOTO_ID] description];
        photo.title = [photoDictionary[FLICKR_PHOTO_TITLE] description];
        photo.subtitle = [photoDictionary valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        photo.imageURL = [[FlickrFetcher urlForPhoto:photoDictionary format:FlickrPhotoFormatLarge] absoluteString];
        
        NSString *photographerName = [photoDictionary[FLICKR_PHOTO_OWNER] description];
        Photographer *photographer = [Photographer photographerWithName:photographerName inManagedObjectContext:context];
        
        photo.whoTook = photographer;
        
    } else{ //just one object
        photo = [matches lastObject];
    }
    
    return photo;
}

@end
