//
//  File.swift
//  
//
//  Created by Rodrigo Dutra de Oliveira on 7/7/22.
//

import Foundation

struct URLPayloadGenerator: PayloadGenerator {
    let url: URL
    
    init(url: URL){
        self.url = url
    }
    
    var payload: String {
        "\(self.url.description)"
    }
}
