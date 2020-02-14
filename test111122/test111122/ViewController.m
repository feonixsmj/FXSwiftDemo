//
//  ViewController.m
//  test111122
//
//  Created by FeoniX on 2019/4/19.
//  Copyright © 2019 FX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate,UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textView.delegate = self;
    self.textField.delegate = self;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
     NSString *name = @"伊宝贝🌺🎀👒";
    self.textView.text = name;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSString *name = @"helloسسسسس🌺🎀👒";
    self.textField.text = name;
}

//- (void)textViewDidChange:(UITextView *)textView{
//    NSString *name = @"helloسس";
//
//}

//NSString *insertString = [NSString stringWithFormat:kATFormat,name];
//NSMutableString *string = [NSMutableString stringWithString:textView.text];
//[string insertString:insertString atIndex:index];
//self.growingTextView.text = string;
//
//[self.growingTextView becomeFirstResponder];
@end
