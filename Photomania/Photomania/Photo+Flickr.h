//
//  Photo+Flickr.h
//  Photomania
//
//  Created by Yuhua Mai on 8/5/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)

+ (Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary
        inManagedObjectContext:(NSManagedObjectContext *)context;


@end
