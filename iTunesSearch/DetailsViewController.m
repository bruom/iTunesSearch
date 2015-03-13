//
//  DetailsViewController.m
//  iTunesSearch
//
//  Created by Bruno Omella Mainieri on 3/11/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end


@implementation DetailsViewController

@synthesize midia;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if([midia isMemberOfClass:[Filme class]]){
        self.navigationItem.title = @"Filme";
        self.tipo.text = @"Filme";
    }
    if([midia isMemberOfClass:[Musica class]]){
        self.navigationItem.title = @"Musica";
        self.tipo.text = @"Musica";
    }
    if([midia isMemberOfClass:[Podcast class]]){
        self.navigationItem.title = @"Podcast";
        self.tipo.text = @"Podcast";
    }
    if([midia isMemberOfClass:[Ebook class]]){
        self.navigationItem.title = @"Ebook";
        self.tipo.text = @"Ebook";
    }
    self.nome.text = midia.nome;
    self.preco.text = [NSString stringWithFormat:@"Preço: %@",midia.preco];
    self.artista.text = midia.artista;
    NSURL *url = [NSURL URLWithString:midia.urlGrande];
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:imgData];
    self.imagem.image = img;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
