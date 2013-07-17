//
//  TUViewController.m
//  TUSplitSyncPDFView
//
//  Created by stky on 2013/06/28.
//
//

#import "TUSplitSyncPDFViewController.h"
#import "TUSplitedPDFView.h"
#import "TUSeparateBarView.h"

@interface TUSplitSyncPDFViewController ()

@end

@implementation TUSplitSyncPDFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // 左側の枠を作るビューのインスタンスを作成する
    UIView* leftFrameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 2 / 3, self.view.frame.size.height)];
    
    // 左側のTUSplitedPDFViewのインスタンスを作成する
    TUSplitedPDFView* leftPDFScrollView = [[TUSplitedPDFView alloc] initWithFrame:self.view.frame];
    
    // 一画面テスト用コード
    //    PDFScrollView* pdfScrollView = [[[PDFScrollView alloc] initWithFrame:self.window.frame]autorelease];
    
    // PDF文書の１ページ目への参照を取得する
    NSURL *pdfURL = [[NSBundle mainBundle] URLForResource:@"TestPage" withExtension:@"pdf"];
    CGPDFDocumentRef PDFDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)pdfURL);
    CGPDFPageRef PDFPage = CGPDFDocumentGetPage(PDFDocument, 1);
    
    // leftPDFScrollViewにPDFをセットする
    [leftPDFScrollView setPDFPage:PDFPage];
    
    // rightPDFScrollViewのインスタンスを作成する
    TUSplitedPDFView* rightPDFScrollView = [[TUSplitedPDFView alloc] initWithFrame:self.view.frame];
    
    // rightPDFScrollViewにPDFをセットする
    [rightPDFScrollView setPDFPage:PDFPage];
    CGPDFDocumentRelease(PDFDocument);
    
    // しきりのビューを作る
    UIView* separateBarView = [[TUSeparateBarView alloc] initWithX:self.view.frame.size.width * 2 / 3 withView:leftFrameView];
    
    // PDFScrollViewなどをwindowにaddする
    [self.view addSubview:rightPDFScrollView];
    [self.view addSubview:leftFrameView];
    leftFrameView.clipsToBounds = YES; // 左枠でクリップする
    [leftFrameView addSubview:leftPDFScrollView];
    [self.view addSubview:separateBarView];
    
    // leftPDFScrollViewの設定
    leftPDFScrollView.minimumZoomScale = 0.001;
    leftPDFScrollView.maximumZoomScale = 1000.0;
    leftPDFScrollView.bounces = NO;
    
    // rightPDFScrollViewの設定
    // 拡大縮小禁止にする
    rightPDFScrollView.minimumZoomScale = 1.0;
    rightPDFScrollView.maximumZoomScale = 1.0;
    
    int opt = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
    
    // rightPDFScrollViewをleftPDFScrollViewのオブザーバにする
    [leftPDFScrollView addObserver:rightPDFScrollView forKeyPath:@"observedPresentScale" options:opt context:NULL];
    [leftPDFScrollView addObserver:rightPDFScrollView forKeyPath:@"observedContentOffsetY" options:opt context:NULL];
    
    // leftPDFScrollViewをrightPDFScrollViewのオブザーバにする
    [rightPDFScrollView addObserver:leftPDFScrollView forKeyPath:@"observedContentOffsetY" options:opt context:NULL];
    //    [rightPDFScrollView addObserver:leftPDFScrollView forKeyPath:@"observedPresentScale" options:opt context:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
