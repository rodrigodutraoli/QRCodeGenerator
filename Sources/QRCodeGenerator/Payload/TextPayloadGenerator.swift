//
//  File.swift
//  
//
//  Created by Rodrigo Dutra de Oliveira on 7/7/22.
//

import Foundation

struct TextPayloadGenerator: PayloadGenerator {
    let content: String
    
    init(content: String){
        self.content = content.escapeInput()
    }
    
    var payload: String {
        "\(self.content)"
    }
}
