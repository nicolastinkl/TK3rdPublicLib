//
//  MDPostPhotoViewController.m
//  OwnerApp
//
//  Created by tinkl on 22/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import "MDPostPhotoViewController.h"
#import "UIButton+Bootstrap.h"
#import "TKClassMacro.h"
@interface MDPostPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *button_cancel;
@property (weak, nonatomic) IBOutlet UIButton *button_sure;
@property (weak, nonatomic) IBOutlet UIView *view_bg;

@end

@implementation MDPostPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imageView.image = self.postImage;
//    self.view.backgroundColor =  [UIColor colorWithRed:68/255.0f green:68/255.0f blue:68/255.0f alpha:1.f] ;
//    self.view_bg.backgroundColor = RGB(240, 240, 240);
//    if (IOS6) {
//        self.imageView.top = 0;
//    }
    self.imageView.center = self.navigationController.view.center;
    
    [self.button_cancel MDClearColorInfoStyle];
    [self.button_sure  MDClearColorInfoStyle];
    
    if (isHigherThaniPhone4_SC) {
        self.view_bg.top += 86;
    }
    
    if (IOS6) {
        self.view_bg.top-= 24;
    }
}

- (IBAction)cancelClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sureClick:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
