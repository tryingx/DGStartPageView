//
//  DGStartPageView.m
//  DGStartPageView
//
//  Created by Gavin on 16/7/27.
//  Copyright © 2016年 DGNICE. All rights reserved.
//

#define MainScreen_width  [UIScreen mainScreen].bounds.size.width   //宽
#define MainScreen_height [UIScreen mainScreen].bounds.size.height  //高

#import "DGStartPageView.h"

@interface DGStartPageView ()
<
UIScrollViewDelegate
>
{
    UIScrollView    *_bigScrollView;
    NSMutableArray  *_imageArray;
    UIPageControl   *_pageControl;
}
@end

@implementation DGStartPageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self configure];
        
    }
    return self;
}

- (void)initData{
    _imageArray = [@[@"闪屏1.png",@"闪屏2.png", @"闪屏3.png",@"闪屏4.png"] mutableCopy];
}
- (void)configure{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainScreen_width, MainScreen_height)];
    scrollView.contentSize = CGSizeMake((_imageArray.count + 1) * MainScreen_width, MainScreen_height);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    [self addSubview:scrollView];
    
    _bigScrollView = scrollView;
    
    for (int i = 0; i < _imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(i * MainScreen_width, 0, MainScreen_width, MainScreen_height);
        UIImage *image = [UIImage imageNamed:_imageArray[i]];
        imageView.image = image;
        
        [scrollView addSubview:imageView];
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(MainScreen_width / 2, MainScreen_height - 60, 0, 40)];
    pageControl.numberOfPages = _imageArray.count;
    pageControl.backgroundColor = [UIColor clearColor];
    [self addSubview:pageControl];
    
    _pageControl = pageControl;
    
    //  添加手势
    UITapGestureRecognizer *singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1;
    [scrollView addGestureRecognizer:singleRecognizer];
}

-(void)handleSingleTapFrom
{
    if (_pageControl.currentPage == 3) {
        self.hidden = YES;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _bigScrollView) {
        CGPoint offSet = scrollView.contentOffset;
        //计算当前的页码
        _pageControl.currentPage = offSet.x/(self.bounds.size.width);
        [scrollView setContentOffset:CGPointMake(self.bounds.size.width * (_pageControl.currentPage), scrollView.contentOffset.y) animated:YES];
    }
    
    if (scrollView.contentOffset.x == (_imageArray.count) *MainScreen_width) {
        self.hidden = YES;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
