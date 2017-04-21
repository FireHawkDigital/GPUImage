//
//  GPUImageKoleidoscopeFilter.m
//  GPUImage
//
//  Created by Throwr on 21/4/17.
//  Copyright © 2017 Brad Larson. All rights reserved.
//

#import "GPUImageKoleidoscopeFilter.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kGGPUImageKoleidoscopeFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 uniform lowp float sides;
 
 void main(void)
{
    
    // normalize to the center
    mediump vec2 p = textureCoordinate - 0.5;
    
    // cartesian to polar coordinates
    mediump float r = length(p);
    mediump float a = atan(p.y, p.x);
    
    // kaleidoscope
    //mediump float sides = 4.0;
    mediump float tau = 2. * 3.1416;
    a = mod(a, tau/sides);
    a = abs(a - tau/sides/2.);
    
    // polar to cartesian coordinates
    p = r * vec2(cos(a), sin(a));
    
    // sample the webcam
    mediump vec4 color = texture2D(inputImageTexture, p + 0.5);
    gl_FragColor = color;
}
 );
#endif

@implementation GPUImageKoleidoscopeFilter
@synthesize sides = _sides;

#pragma mark -
#pragma mark Initialization and teardown

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kGGPUImageKoleidoscopeFragmentShaderString]))
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
