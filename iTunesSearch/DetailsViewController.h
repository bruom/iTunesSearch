//
//  DetailsViewController.h
//  iTunesSearch
//
//  Created by Bruno Omella Mainieri on 3/11/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Midia.h"
#import "Filme.h"
#import "Musica.h"
#import "Ebook.h"
#import "Podcast.h"

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (weak, nonatomic) IBOutlet UILabel *nome;
@property (weak, nonatomic) IBOutlet UILabel *artista;
@property (weak, nonatomic) IBOutlet UILabel *tipo;
@property (weak, nonatomic) IBOutlet UILabel *preco;
@property (weak, nonatomic) Midia *midia;


@end
