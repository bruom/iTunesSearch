//
//  Midia.h
//  iTunesSearch
//
//  Created by Bruno Omella Mainieri on 3/11/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Midia : NSObject

@property (nonatomic, strong) NSString *nome;
@property (nonatomic, strong) NSString *trackId;
@property (nonatomic, strong) NSString *artista;
@property (nonatomic, strong) NSNumber *preco;
@property (nonatomic, strong) NSString *urlImg;

@end
