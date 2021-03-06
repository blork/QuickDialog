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


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QRootElement.h"
#import "QuickDialog.h"

@interface QImageElement : QEntryElement <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImage *detailImage;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, readonly, strong) UIImageView *detailImageView;
@property (nonatomic, strong) QuickDialogController *presentingController;

@property (nonatomic, assign) NSString *detailImageNamed;

- (QImageElement *)initWithTitle:(NSString *)aTitle andPlaceholderImageNamed:(NSString *)aPlaceholder;
@end