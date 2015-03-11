//
//  MusicTableViewCell.h
//  iTunesSearch
//
//  Created by Bruno Omella Mainieri on 3/11/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nome;
@property (weak, nonatomic) IBOutlet UILabel *artista;
@property (weak, nonatomic) IBOutlet UILabel *album;
@property (weak, nonatomic) IBOutlet UILabel *tipo;
@property (weak, nonatomic) IBOutlet UILabel *preco;

@end
