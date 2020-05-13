//
//  secondViewController.m
//  PetAdoptionC
//
//  Created by Kenny Kurochkin on 13/05/2020.
//  Copyright © 2020 Kenny Kurochkin. All rights reserved.
//

#import "SecondViewController.h"
@interface  SecondViewController() {
  
}
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    
    self.movieNameLabel.text = self.movieName;
}
@end
