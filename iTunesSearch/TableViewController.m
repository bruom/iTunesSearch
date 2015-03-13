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
    
    useDef = [NSUserDefaults standardUserDefaults];
    
    [_tableview setDelegate: self];
    _tableview.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    //[self.tableview registerNib:nib forCellReuseIdentifier:@"musicCell"];
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
    if(useDef==nil){
        termo = @"Apple";
    }
    else{
        termo = [[useDef stringForKey:@"busca"] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    }
    midias = [itunes buscarMidias:@"Apple"];

    _tableview.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    
    
    
//#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    //self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 0.0f)];
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
    
    long row = [indexPath row];
    if(indexPath.section==0){
        //TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
        Filme *filme = [media objectAtIndex:[indexPath row]];
        [celula.nome setText:filme.nome];
        [celula.artista setText:filme.artista];
        [celula.tipo setText:@"Filme"];
        [celula.preco setText:[NSString stringWithFormat:@"Preço: %@",filme.preco]];
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
        [celula.tipo setText:@"Musica"];
        [celula.preco setText:[NSString stringWithFormat:@"Preço: %@",musica.preco]];
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
        [celula.tipo setText:@"Podcast"];
        [celula.preco setText:[NSString stringWithFormat:@"Preço: %@",podcast.preco]];
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
        [celula.tipo setText:@"Ebook"];
        [celula.preco setText:[NSString stringWithFormat:@"Preço: %@",ebook.preco]];
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
    midias =[itunes buscarMidias:self.busca.text];
    //[self categorizaMidia];
    [self.tableview reloadData];
    [_busca resignFirstResponder];
    [useDef setObject:self.busca.text forKey:@"busca"];
    self.busca.text = @"";
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (section == 0)
//        return @"Filmes";
//    if (section == 1)
//        return @"Musicas";
//    if (section == 2)
//        return @"Podcasts";
//    if (section == 3)
//        return @"Ebooks";
//    return @"undefined";
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, -20, tableView.frame.size.width, 18)];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 3, 16, 16)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 2, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    if (section == 0){
        [label setText:@"Filmes"];
        imgView.image = [UIImage imageNamed:@"filme"];
    }
    if (section == 1){
        [label setText:@"Musicas"];
        imgView.image = [UIImage imageNamed:@"music"];
    }
    if (section == 2){
        [label setText:@"Podcasts"];
        imgView.image = [UIImage imageNamed:@"podcast"];
    }
    if (section == 3){
        [label setText:@"Ebooks"];
        imgView.image = [UIImage imageNamed:@"ebook"];
    }
    [header addSubview:label];
    [header addSubview:imgView];
    [header setBackgroundColor:[UIColor grayColor]];
    return header;
}

//-(void)categorizaMidia{
//    filmes = [[NSMutableArray alloc]init];
//    musicas = [[NSMutableArray alloc]init];
//    podcasts = [[NSMutableArray alloc]init];
//    ebooks = [[NSMutableArray alloc]init];
//    for(int i=0; i<midias.count;i++){
//        if([[midias objectAtIndex:i] isMemberOfClass:[Filme class]]){
//            [filmes addObject:[midias objectAtIndex:i]];
//        }
//        if([[midias objectAtIndex:i] isMemberOfClass:[Musica class]]){
//            [musicas addObject:[midias objectAtIndex:i]];
//        }
//        if([[midias objectAtIndex:i] isMemberOfClass:[Podcast class]]){
//            [podcasts addObject:[midias objectAtIndex:i]];
//        }
//        if([[midias objectAtIndex:i] isMemberOfClass:[Ebook class]]){
//            [ebooks addObject:[midias objectAtIndex:i]];
//        }
//    }
//}

@end
