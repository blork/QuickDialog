//
// Copyright 2012 Ludovic Landry - http://about.me/ludoviclandry
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "QImageElement.h"

@interface QImageElement () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, retain) UIImagePickerController *imagePickerController;
@end

@implementation QImageElement

@synthesize detailImage;
@synthesize detailImageView;
@synthesize imagePickerController;
@synthesize placeholder;

- (QImageElement *)initWithTitle:(NSString *)aTitle andPlaceholderImageNamed:(NSString *)aPlaceholder {
    self = [super init];
    if (self) {
        self.title = aTitle;
        self.placeholderImage = [UIImage imageNamed:aPlaceholder];
    }
    return self;
}

- (void)setDetailImageNamed:(NSString *)name {
    self.detailImage = [UIImage imageNamed:name];
}

- (NSString *)detailImageNamed {
    return nil;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformImageElement"];
    if (cell==nil){
        cell = [[QImageTableViewCell alloc] init];
    }
    [cell prepareForElement:self inTableView:tableView];
    
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    //[super selected:tableView controller:controller indexPath:path];
    //[tableView deselectRowAtIndexPath:path animated:YES];
    
    if (self.imagePickerController) {
        [controller displayViewController:self.imagePickerController];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Your device does not have a camera."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


- (UIImagePickerController *)imagePickerController {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		imagePickerController = [[UIImagePickerController alloc] init];
		imagePickerController.delegate = self;
		imagePickerController.allowsEditing = YES;
		imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
    return imagePickerController;
}


- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
	
	[obj setValue:detailImage forKey:_key];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.detailImage = [info valueForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.onValueChanged();
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
