//
//  PayloadGeneratorTests.swift
//  
//
//  Created by Rodrigo Dutra de Oliveira on 7/7/22.
//

import XCTest
@testable import QRCodeGenerator

final class PayloadGeneratorTests: XCTestCase {
    func test_TextPayloadGenerator() throws {
        let sut = TextPayloadGenerator(content: "Rodrigo Dutra")
        let payload = sut.payload
        
        XCTAssertEqual(sut.content, payload)
    }
    
    func test_URLPayloadGenerator() throws {
        let url = "https://google.com.br"
        let sut = URLPayloadGenerator(url: URL(string: url)!)
        let payload = sut.payload
        
        XCTAssertEqual(url, payload)
    }
    
    
}
