//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Musica.h"
#import "Podcast.h"
#import "Ebook.h"
#import "Midia.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSArray *)buscarMidias:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all&limit=200", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *midias = [[NSMutableArray alloc]init];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    NSMutableArray *musicas = [[NSMutableArray alloc] init];
    NSMutableArray *podcasts = [[NSMutableArray alloc] init];
    NSMutableArray *ebooks = [[NSMutableArray alloc] init];
    
    void(^setMidia)(Midia*,NSDictionary*)=^(Midia *aux, NSDictionary *item){
        [aux setNome:[item objectForKey:@"trackName"]];
        [aux setTrackId:[item objectForKey:@"trackId"]];
        [aux setArtista:[item objectForKey:@"artistName"]];
        [aux setPreco:[item objectForKey:@"trackPrice"]];
        [aux setUrlImg:[item objectForKey:@"artworkUrl60"]];
        [aux setUrlGrande:[item objectForKey:@"artworkUrl100"]];

    };
    
    for (NSDictionary *item in resultados) {
        
        //FILME
        if([[item objectForKey:@"kind"] isEqualToString:@"feature-movie"]){
            Filme *filme = [[Filme alloc]init];
            setMidia(filme, item);
            [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [filme setGenero:[item objectForKey:@"primaryGenreName"]];
            [filme setPais:[item objectForKey:@"country"]];
            [filmes addObject:filme];
        }
        
        //MUSICA
        if([[item objectForKey:@"kind"] isEqualToString:@"song"]){
            Musica *musica = [[Musica alloc]init];
            setMidia(musica, item);
            [musica setAlbum:[item objectForKey:@"collectionName"]];
            [musica setPais:[item objectForKey:@"country"]];
            [musicas addObject:musica];
        }
        
        //EBOOK
        if([[item objectForKey:@"kind"] isEqualToString:@"ebook"]){
            Ebook *ebook = [[Ebook alloc]init];
            setMidia(ebook, item);
            [ebook setRating:[item objectForKey:@"averageUserRating"]];
            [ebooks addObject:ebook];
        }
        
        //PODCAST
        if([[item objectForKey:@"kind"] isEqualToString:@"podcast"]){
            Podcast *podcast = [[Podcast alloc]init];
            setMidia(podcast,item);
            [podcast setGeneroPrincipal:[item objectForKey:@"primaryGenreName"]];
            [podcasts addObject:podcast];
        }
        
    }
    
    [midias addObject:filmes];
    [midias addObject:musicas];
    [midias addObject:ebooks];
    [midias addObject:podcasts];
    
    return midias;
}




#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
