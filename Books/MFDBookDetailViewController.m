//
//  MFDBookDetailViewController.m
//  Books
//
//  Created by Adland Lee on 6/3/14.
//  Copyright (c) 2014 Adland Lee. All rights reserved.
//

#import "MFDBookDetailViewController.h"

@interface MFDBookDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *copyrightTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, getter=isCreating) BOOL creating;
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButtonItem;

@end

@implementation MFDBookDetailViewController

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
    // Do any additional setup after loading the view.
    self.cancelButtonItem = self.navigationItem.leftBarButtonItem;
    self.saveButtonItem = self.navigationItem.rightBarButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateDetails];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    ALog();
    [self.delegate unwindBookDetailViewController:self];
}

- (IBAction)saveDetails:(id)sender {
    self.creating = NO;
}

-(void)updateDetails
{
    ALog();
    if (self.creating == YES) {
        [self setEditing:YES animated:YES];
    }
//    else {
        self.titleTextField.text = self.book.title;
        self.authorTextField.text = self.book.author;
        self.copyrightTextField.text = [self.dateFormatter stringFromDate:self.book.copyright];
//    }
}

-(NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
    return dateFormatter;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - Creating

- (void)setShowing
{
    ALog();
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setCreating
{
    ALog();

    self.creating = YES;
    self.leftBarButtonItem = self.cancelButtonItem;
}

#pragma mark - Editing

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    ALog();
    [super setEditing:editing animated:animated];

    if (editing == YES){
        // Change views to edit mode.
        self.navigationItem.leftBarButtonItem = self.leftBarButtonItem;
        self.leftBarButtonItem = nil;

        self.titleTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.titleTextField.enabled = editing;
        self.authorTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.authorTextField.enabled = editing;
        self.copyrightTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.copyrightTextField.enabled = editing;
        
    }
    else {
        // Save the changes if needed and change the views to noneditable.
        self.leftBarButtonItem = self.navigationItem.leftBarButtonItem;
        self.navigationItem.leftBarButtonItem = nil;
        
        self.titleTextField.borderStyle = UITextBorderStyleNone;
        self.titleTextField.enabled = editing;
        self.authorTextField.borderStyle = UITextBorderStyleNone;
        self.authorTextField.enabled = editing;
        self.copyrightTextField.borderStyle = UITextBorderStyleNone;
        self.copyrightTextField.enabled = editing;
        
        self.book.title = self.titleTextField.text;
        self.book.author = self.authorTextField.text;
    }
}

@end
