//
//  GPUMirrorFilter.h
//  GPUImage
//
//  Created by Throwr on 21/4/17.
//  Copyright © 2017 Brad Larson. All rights reserved.
//

#import <GPUImage/GPUImage.h>

@interface GPUImageMirrorFilter : GPUImageFilter
{
    GLfloat sidesUniform;
}


// Sides, either 2 or 4
@property(readwrite, nonatomic) CGFloat sides;

@end
