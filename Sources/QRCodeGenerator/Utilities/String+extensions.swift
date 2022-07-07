//
//  File.swift
//  
//
//  Created by Rodrigo Dutra de Oliveira on 7/7/22.
//

import Foundation

extension String {
    func isValidHexNumber() -> Bool {
        let chars = NSCharacterSet(charactersIn: "0123456789ABCDEF").inverted
        guard self.uppercased().rangeOfCharacter(from: chars) != nil else {
            return false
        }
        return true
    }
    
    func escapeInput(simple: Bool = false) -> String {
        let forbiddenChars: Set<Character> = simple ? [":"] : ["\\", ";", ",", ":"]
        
        var res = self
        res.removeAll(where: { forbiddenChars.contains($0) } )
        
        return res
    }
}
