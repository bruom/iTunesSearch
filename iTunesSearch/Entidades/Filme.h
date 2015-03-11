//
//  Filme.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Midia.h"

@interface Filme : Midia

@property (nonatomic, strong) NSString *duracao;
@property (nonatomic, strong) NSString *genero;
@property (nonatomic, strong) NSString *pais;

@end
