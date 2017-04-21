//
//  GPUImageKoleidoscopeFilter.h
//  GPUImage
//
//  Created by Throwr on 21/4/17.
//  Copyright © 2017 Brad Larson. All rights reserved.
//

#import <GPUImage/GPUImage.h>

@interface GPUImageKoleidoscopeFilter : GPUImageFilter
{
    GLfloat sidesUniform;
}


@property(readwrite, nonatomic) CGFloat sides;

@end
