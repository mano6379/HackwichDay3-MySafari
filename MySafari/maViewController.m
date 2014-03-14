//
//  maViewController.m
//  MySafari
//
//  Created by Marion Ano on 3/12/14.
//  Copyright (c) 2014 Marion Ano. All rights reserved.
//

#import "maViewController.h"

@interface maViewController ()

@property IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *comingSoonButton;




@end

@implementation maViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.backButton.userInteractionEnabled = NO;
    self.forwardButton.userInteractionEnabled = NO;
    
    //insert webpage into UIWebView
    //assigning url to a string
   
    self.myWebView.scrollView.delegate = self;
    hideNav = NO;
    mustShowNav = NO;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myWebViewTapped:)];
    gestureRecognizer.delegate = self;
    [self.myWebView addGestureRecognizer:gestureRecognizer];
    //this above code is for scrolling/tapping to make the IUTextview nav bar disappear
    

    NSString *urlString = @"http://www.google.com";
    //takes the urlString and converts it into an url
    NSURL *url = [NSURL URLWithString:urlString];
    //takes the url object and calls to request the NSURL object
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //the viewcontroller calls the loadRequest (NSRUL object on itself) and loads the loadRequest into the "myWebView"
    [self.myWebView loadRequest:request];
    // Do any additional setup after loading the view, typically from a nib.
}
//when the "comingSoonButton or the "+" " is pressed, the UIAlertView object, "alert" displays with the message "Coming Soon".
- (IBAction)comingSoonButtonPressed:(id)comingSoonButton {
    
    //"alert" object is called with message, "Coming Soon".
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle: nil message: @"Coming Soon!" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    //the "show" method is called on the object alert
    [alert show];
    
    

}

//when the "Stop" button is pressed, myWebView stops loading
- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.myWebView stopLoading];
    
}
//when the "< (back)" is presssed, then the "forwardButton" is enabled
- (IBAction)BackButtonPressed:(id)sender {
    [self.myWebView goBack];
    self.forwardButton.userInteractionEnabled = YES;
}
//when the "> (forward)" is pressed, the user can move forward
- (IBAction)onForwardButtonPressed:(id)sender {
    [self.myWebView goForward];
}

//when the user presses the "Reload" button, myWebView reloads.
- (IBAction)ReloadButtonPressed:(id)sender {
    [self.myWebView reload];
}

//this is a UITextField Protocol and it: Asks the delegate if the text field should
//process the pressing of the return button.
- (BOOL) textFieldShouldReturn:(UITextField *)textField

{
//this sets the text in the "myURLTextField" into the string object, "urlString"
    NSString *urlString = self.myURLTextField.text;
// the method, URLWithString creates and returns an NSURL object initialized with a provided URL string
    NSURL *url = [NSURL URLWithString:urlString];
  //if the user types in a string that has prefix, "http://" then, pass that string and create and store in the NSURL object, url.
    if ([urlString hasPrefix:@"http://"]) {
        url = [NSURL URLWithString:urlString];
} //else, create a string object, "urlString" A string created by using format as a template into which the remaining argument values are substituted according to the canonical locale.
    else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", urlString]];
    }
    
  
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
 
    
    [self.myWebView loadRequest:request];
    
    self.backButton.userInteractionEnabled = YES;
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -scrolling 


BOOL tap;
BOOL hideNav;
BOOL mustShowNav;


typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
} ScrollDirection;


- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    
    NSLog(@"%f",self.myWebView.scrollView.contentOffset.y);
    
    if ( self.myWebView.scrollView.contentOffset.y >100 ) {
        [[self myURLTextField] setHidden:YES];
    }
    else { [[self myURLTextField] setHidden:NO];
    
    }
    
    
//    ScrollDirection scrollDirection;
//
//    if (scrollView.contentOffset.y < scrollView.contentOffset.y)
//        scrollDirection = ScrollDirectionDown;
//    else
//        scrollDirection = ScrollDirectionUp;
//    
//    
//    float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
//    if (scrollDirection == ScrollDirectionDown && scrollView.contentOffset.y > 50 && !mustShowNav) {
//        hideNav = YES;
//        tap = 0;
//    } else {
//        hideNav = NO;
//    }
//    
//    if (scrollDirection == ScrollDirectionUp && mustShowNav){
//        hideNav = NO;
//        mustShowNav = NO;
//    }
//    
//    if (scrollDirection == ScrollDirectionDown && endScrolling > scrollView.contentSize.height - 50 && !mustShowNav) {
//        mustShowNav = YES;
//    }
  
    //scrollView.contentOffset = scrollView.contentOffset;
    
    //[self.myWebView.scrollView.delegate DidScroll: scrollView];
}

#pragma mark - bring back text field

- (void)webViewTapped:(id)Sender
{
   if(!tap){
        hideNav = NO;
        tap = 1;
   } else {
       hideNav = YES;
       tap = 0;
    }
    //self.myURLTextField.hidden = NO;
    [[self myURLTextField] setHidden:NO];
////    //[[self navigationController] setToolbarHidden:hideNav animated:YES];
////}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//  
//    [[self myURLTextField] setHidden:NO];
//    
//}




}
@end

