//
//  ViewController.m
//  facebookLoginferg
//
//  Created by china on 15/10/27.
//  Copyright © 2015年 china. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)facebookLogin:(id)sender {
    
    //  logInWithReadPermissions:@[@"public_profile", @"user_friends"]
    
    //  logInWithReadPermissions:@[@"public_profile", @"user_friends"]
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    
    //   login.loginBehavior=FBSDKLoginBehaviorSystemAccount;
    
    
    [login
     logInWithPublishPermissions:nil
     
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in%@",result.token.tokenString);
             
             FBSDKProfilePictureView *view = [[FBSDKProfilePictureView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
             view.profileID = result.token.userID;
             
             [self.view addSubview:view];
             //        [FBSDKAccessToken setCurrentAccessToken:result.token];
             
             
             //             [FBSDKAccessToken setCurrentAccessToken:result.token];
             
             //             NSDictionary *dic = @{@"profile":result.token.userID};
             
             //             FBSDKProfile
             //             NSString *idssss  = @"/me&fields=id,name,email,first_name,last_name,link,birthday,picture";
             
             NSString *idstr = result.token.userID;
             NSString *idssss  =[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",idstr];
             // http://graph.facebook.com/121474911525306/picture?type=large
             
             FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                           initWithGraphPath:idssss
                                           parameters:nil
                                           HTTPMethod:@"GET"];
             [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                   id result,
                                                   NSError *error) {
                 // Handle the result
                 NSLog(@"%@",request);
                 
             }];
             
             [[request initWithGraphPath:idssss parameters:nil HTTPMethod:@"GET"]
              startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                  if (!error) {
                      
                      NSLog(@"fetched user:%@", result);
                      
                  }else{
                      
                      NSLog(@"出错了");
                      
                  }
              }];
             
             
         }
     }];
    
    
    
    //    if ([FBSDKAccessToken currentAccessToken]) {
    
    //    }
    
    
    

    
}
@end
