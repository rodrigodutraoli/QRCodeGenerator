//
//  File.swift
//  
//
//  Created by Rodrigo Dutra de Oliveira on 7/7/22.
//

import Foundation

extension String {
    func isValidHexNumber() -> Bool {
        isHexNumber
    }
    
    private var isHexNumber: Bool {
        filter(\.isHexDigit).count == count
    }
    
    func escapeInput(simple: Bool = false) -> String {
        let forbiddenChars: Set<Character> = simple ? [":"] : ["\\", ";", ",", ":"]
        
        var res = self
        
        for char in forbiddenChars {
            res = res.replacingOccurrences(of: "\(char)", with: "\\\(char)")
        }
        
        return res
    }
}
