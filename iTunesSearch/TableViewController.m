//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "MusicTableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Musica.h"
#import "Podcast.h"
#import "Ebook.h"
#import "DetailsViewController.h"

@interface TableViewController () {
    NSArray *midias;
    NSUserDefaults *useDef;
    NSString *termo;
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"iTunes Search";
    [self.botaoBusca setTitle:NSLocalizedString(@"Buscar", nil) forState:UIControlStateNormal];
    
    useDef = [NSUserDefaults standardUserDefaults];
    [useDef synchronize];
    
    [_tableview setDelegate: self];
    _tableview.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
//    if(useDef==nil){
//        termo = @"Apple";
//    }
//    else{
//        termo = [[useDef valueForKey:@"busca"] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
//    }
    midias = [itunes buscarMidias:[useDef valueForKey:@"busca"]];

//    _tableview.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[midias objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    NSArray *media = [[NSArray alloc]initWithArray:[midias objectAtIndex:indexPath.section]];
    
    if(indexPath.section==0){
        //TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
        Filme *filme = [media objectAtIndex:[indexPath row]];
        [celula.nome setText:filme.nome];
        [celula.artista setText:filme.artista];
        [celula.tipo setText:NSLocalizedString(@"Filme",nil)];
        [celula.preco setText:[NSString stringWithFormat:NSLocalizedString(@"Preço: %@",nil),filme.preco]];
        NSURL *url = [NSURL URLWithString:filme.urlImg];
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:imgData];
        [celula.imagem setImage:img];
        
    }
    if(indexPath.section==1){
        //MusicTableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"musicCell"];
        Musica *musica = [media objectAtIndex:[indexPath row]];
        [celula.nome setText:musica.nome];
        [celula.artista setText:musica.artista];
        [celula.tipo setText:NSLocalizedString(@"Musica",nil)];
        [celula.preco setText:[NSString stringWithFormat:NSLocalizedString(@"Preço: %@",nil),musica.preco]];
        NSURL *url = [NSURL URLWithString:musica.urlImg];
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:imgData];
        [celula.imagem setImage:img];
        //return celula;
    }
    if(indexPath.section==2){
        //TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
        Podcast *podcast = [media objectAtIndex:[indexPath row]];
        [celula.nome setText:podcast.nome];
        [celula.artista setText:podcast.artista];
        [celula.tipo setText:NSLocalizedString(@"Podcast",nil)];
        [celula.preco setText:[NSString stringWithFormat:NSLocalizedString(@"Preço: %@",nil),podcast.preco]];
        NSURL *url = [NSURL URLWithString:podcast.urlImg];
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:imgData];
        [celula.imagem setImage:img];
    }
    if(indexPath.section==3){
        //TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
        Ebook *ebook = [media objectAtIndex:[indexPath row]];
        [celula.nome setText:ebook.nome];
        [celula.artista setText:ebook.artista];
        [celula.tipo setText:NSLocalizedString(@"Ebook",nil)];
        [celula.preco setText:[NSString stringWithFormat:NSLocalizedString(@"Preço: %@",nil),ebook.preco]];
        NSURL *url = [NSURL URLWithString:ebook.urlImg];
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:imgData];
        [celula.imagem setImage:img];
    }
    
    return celula;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *details = [[DetailsViewController alloc]init];
    [details setMidia:[[ midias objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:details animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (IBAction)buscar:(id)sender {
    iTunesManager *itunes = [iTunesManager sharedInstance];
    
    NSError *erroRegex=nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[a-z]([a-z]| |\\+|\\(|\\)|'|\\^)*$" options:NSRegularExpressionCaseInsensitive error:&erroRegex];
    
    termo = self.busca.text;
    
    if(![regex numberOfMatchesInString:termo options:0 range:NSMakeRange(0, termo.length)]){
        UIAlertView *termoInvalido = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Busca invalida!",nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [termoInvalido show];
        return;
    }
    
    midias =[itunes buscarMidias:[termo stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    //[self categorizaMidia];
    [self.tableview reloadData];
    [_busca resignFirstResponder];
    [useDef setObject:self.busca.text forKey:@"busca"];
    [useDef synchronize];
    self.busca.text = @"";
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, -20, tableView.frame.size.width, 18)];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 3, 16, 16)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 2, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    if (section == 0){
        [label setText:NSLocalizedString(@"Filmes", nil)];
        imgView.image = [UIImage imageNamed:@"filme"];
    }
    if (section == 1){
        [label setText:NSLocalizedString(@"Musicas", nil)];
        imgView.image = [UIImage imageNamed:@"music"];
    }
    if (section == 2){
        [label setText:NSLocalizedString(@"Podcasts", nil)];
        imgView.image = [UIImage imageNamed:@"podcast"];
    }
    if (section == 3){
        [label setText:NSLocalizedString(@"Ebooks", nil)];
        imgView.image = [UIImage imageNamed:@"ebook"];
    }
    [header addSubview:label];
    [header addSubview:imgView];
    [header setBackgroundColor:[UIColor grayColor]];
    return header;
}



@end
