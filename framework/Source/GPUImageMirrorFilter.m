//
//  GPUMirrorFilter.m
//  GPUImage
//
//  Created by Throwr on 21/4/17.
//  Copyright © 2017 Brad Larson. All rights reserved.
//

#import "GPUImageMirrorFilter.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kGPUImageMirrorFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 uniform lowp float sides;
 
 void main(void)
{
    mediump vec2 p = textureCoordinate;
    if (p.x > 0.5) {
        p.x = 1.0 - p.x;
    }
    
    if (sides > 2.0) {
        if (p.y > 0.5) {
            p.y = 1.0 - p.y;
        }
    }
    
    lowp vec4 outputColor = texture2D(inputImageTexture, p);
    gl_FragColor = outputColor;
}
 );
#endif

@implementation GPUImageMirrorFilter
@synthesize sides = _sides;

#pragma mark -
#pragma mark Initialization and teardown

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kGPUImageMirrorFragmentShaderString]))
    {
        return nil;
    }
    
    sidesUniform = [filterProgram uniformIndex:@"sides"];
    self.sides = 2;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setSides:(CGFloat)newValue;
{
    _sides = newValue;
    
    [self setFloat:_sides forUniform:sidesUniform program:filterProgram];
}


@end
