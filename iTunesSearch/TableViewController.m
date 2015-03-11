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

@interface TableViewController () {
    NSArray *midias;
}

@end

@implementation TableViewController

NSString *termo = @"";
NSMutableArray *filmes;
NSMutableArray *musicas;
NSMutableArray *podcasts;
NSMutableArray *ebooks;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableview setDelegate: self];
    _tableview.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    //[self.tableview registerNib:nib forCellReuseIdentifier:@"musicCell"];
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
    midias = [itunes buscarMidias:@"Apple"];
    filmes = [[NSMutableArray alloc] init];
    musicas = [[NSMutableArray alloc] init];
    podcasts = [[NSMutableArray alloc] init];
    ebooks = [[NSMutableArray alloc] init];
    
    
    
    [self categorizaMidia];
    
    
    
    
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
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
    if (section == 0)
        return filmes.count;
    if (section == 1)
        return musicas.count;
    if (section == 2)
        return podcasts.count;
    if (section == 3)
        return ebooks.count;
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    long row = [indexPath row];
    if(indexPath.section==0){
        //TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
        Filme *filme = [filmes objectAtIndex:[indexPath row]];
        [celula.nome setText:filme.nome];
        [celula.artista setText:filme.artista];
        [celula.tipo setText:@"Filme"];
        [celula.preco setText:[NSString stringWithFormat:@"Preço: %@",filme.preco]];
    }
    if(indexPath.section==1){
        //MusicTableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"musicCell"];
        Musica *musica = [musicas objectAtIndex:[indexPath row]];
        [celula.nome setText:musica.nome];
        [celula.artista setText:musica.artista];
        [celula.tipo setText:@"Musica"];
        [celula.preco setText:[NSString stringWithFormat:@"Preço: %@",musica.preco]];
        //return celula;
    }
    if(indexPath.section==2){
        //TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
        Podcast *podcast = [podcasts objectAtIndex:[indexPath row]];
        [celula.nome setText:podcast.nome];
        [celula.artista setText:podcast.artista];
        [celula.tipo setText:@"Podcast"];
        [celula.preco setText:[NSString stringWithFormat:@"Preço: %@",podcast.preco]];
    }if(indexPath.section==3){
        //TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
        Ebook *ebook = [ebooks objectAtIndex:[indexPath row]];
        [celula.nome setText:ebook.nome];
        [celula.artista setText:ebook.artista];
        [celula.tipo setText:@"Ebook"];
        [celula.preco setText:[NSString stringWithFormat:@"Preço: %@",ebook.preco]];
    }
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


- (IBAction)buscar:(id)sender {
    termo = [self.busca text];
    iTunesManager *itunes = [iTunesManager sharedInstance];
    midias =[itunes buscarMidias:termo];
    [self categorizaMidia];
    [self.tableview reloadData];
    [_busca resignFirstResponder];
    self.busca.text = @"";
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"Filmes";
    if (section == 1)
        return @"Musicas";
    if (section == 2)
        return @"Podcasts";
    if (section == 3)
        return @"Ebooks";
    return @"undefined";
}

-(void)categorizaMidia{
    filmes = [[NSMutableArray alloc]init];
    musicas = [[NSMutableArray alloc]init];
    podcasts = [[NSMutableArray alloc]init];
    ebooks = [[NSMutableArray alloc]init];
    for(int i=0; i<midias.count;i++){
        if([[midias objectAtIndex:i] isMemberOfClass:[Filme class]]){
            [filmes addObject:[midias objectAtIndex:i]];
        }
        if([[midias objectAtIndex:i] isMemberOfClass:[Musica class]]){
            [musicas addObject:[midias objectAtIndex:i]];
        }
        if([[midias objectAtIndex:i] isMemberOfClass:[Podcast class]]){
            [podcasts addObject:[midias objectAtIndex:i]];
        }
        if([[midias objectAtIndex:i] isMemberOfClass:[Ebook class]]){
            [ebooks addObject:[midias objectAtIndex:i]];
        }
    }
}

@end
