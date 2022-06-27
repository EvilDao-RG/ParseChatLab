//
//  ChatCell.h
//  ParseChatLab
//
//  Created by Gael Rodriguez Gomez on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageText;
@property (weak, nonatomic) IBOutlet UILabel *messageAuthor;

@end

NS_ASSUME_NONNULL_END
