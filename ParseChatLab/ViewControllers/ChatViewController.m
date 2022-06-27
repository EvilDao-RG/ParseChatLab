//
//  ChatViewController.m
//  ParseChatLab
//
//  Created by Gael Rodriguez Gomez on 6/27/22.
//

#import "ChatViewController.h"
#import "Parse/Parse.h"
#import "ChatCell.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *chatMessageField;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (strong, nonatomic) NSArray *messages;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    [self onTimer];
}

-(void)onTimer{
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    PFQuery *query = [PFQuery queryWithClassName:@"Message_FBU2021"];
    [query orderByDescending:@"createdaAt"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.messages = posts;
            [self.chatTableView reloadData];

        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (IBAction)didTapGoback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapSend:(id)sender {
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_FBU2021"];
    
    chatMessage[@"text"] = self.chatMessageField.text;
    
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded){
                NSLog(@"Message saved!");
                self.chatMessageField.text = @"";
            } else {
                NSLog(@"Message failed! :(");
            }
    }];
    
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ChatCell *cell = [self.chatTableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    
    cell.messageText.text = self.messages[indexPath.row][@"text"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}


@end
