//
//  ViewController.m
//  Attributor
//
//  Created by hcc on 16/7/23.
//  Copyright © 2016年 linbao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;
@property (weak, nonatomic) IBOutlet UILabel *headLine;
@property (weak, nonatomic) IBOutlet UITextView *contentBody;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString * title =
        [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle
                                     attributes:nil];
    [title setAttributes:@{ NSStrokeWidthAttributeName: @3,
                          NSStrokeColorAttributeName: self.outlineButton.tintColor}
                  range:NSMakeRange(0, [title length])];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (IBAction)changeTextColor:(UIButton *)sender {
    [self.contentBody.textStorage addAttribute:NSForegroundColorAttributeName
                                      value:sender.backgroundColor
                                      range:self.contentBody.selectedRange];
  }
- (IBAction)outlineSelectedText:(UIButton *)sender {
    [self.contentBody.textStorage addAttribute:NSStrokeWidthAttributeName value:@-3 range:self.contentBody.selectedRange ];
}


- (IBAction)unoutlineSelectedText:(UIButton *)sender {
    [self.contentBody.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.contentBody.selectedRange];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(preferrFontChanged)
                                                name:UIContentSizeCategoryDidChangeNotification
                                              object:nil];
    
}

- (void) preferrFontChanged{
    [self performContentAndHeadlineFontChanges];
}
-(void)performContentAndHeadlineFontChanges{
    self.contentBody.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headLine.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                               name:UIContentSizeCategoryDidChangeNotification object:nil];
}
@end
