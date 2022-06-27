//
//  LoginViewController.m
//  ParseChatLab
//
//  Created by Gael Rodriguez Gomez on 6/27/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}



- (IBAction)didTapLogin:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [self lookForEmptyField];
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {

            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            
            // display view controller that needs to shown after successful login
        }
    }];

}



- (IBAction)didTapSignup:(id)sender {
    PFUser *newUser = [PFUser user];
    
    newUser.username=self.usernameField.text;
    newUser.password=self.passwordField.text;
    
    [self lookForEmptyField];

    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error");
            } else {
                NSLog(@"Success");
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            }
    }];
}


-(void)lookForEmptyField{
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    if([username isEqual:@""] || [password isEqual:@""]){
        UIAlertController *alert = [UIAlertController  alertControllerWithTitle:@"Title" message:@"One of the fields is empty" preferredStyle:UIAlertControllerStyleAlert];
        // create a cancel action
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancelAction];

        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
    }

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
