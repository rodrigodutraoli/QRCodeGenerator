//
//  File.swift
//  
//
//  Created by Rodrigo Dutra de Oliveira on 7/7/22.
//

import Foundation

struct MailPayloadGenerator: PayloadGenerator {
    let mailReceiver: String
    let subject: String
    let message: String
    let encoding: MailEncoding
    
    init(mailReceiver: String, subject: String, message: String, encoding: MailEncoding){
        self.mailReceiver = mailReceiver
        self.subject = subject
        self.message = message
        self.encoding = encoding
    }
    
    var payload: String {
        switch encoding {
        case .MAILTO:
            var parts: [String] = []
            if !subject.isEmpty {
                parts.append("subject=" + subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
            }
            
            if !message.isEmpty {
                parts.append("body=" + message.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
            }
            
            return "mailto:\(self.mailReceiver)\(parts.joined(separator: "&"))"
        case .MATMSG:
            return "MATMSG:TO:\(self.mailReceiver);SUB:\(self.subject.escapeInput());BODY:\(self.message.escapeInput());;";
        case .SMTP:
            return "SMTP:\(self.mailReceiver):\(self.subject.escapeInput(simple: true)):\(self.message.escapeInput(simple: true))";
        }
    }
    
    enum MailEncoding: String {
        case MAILTO
        case MATMSG
        case SMTP
    }
}
