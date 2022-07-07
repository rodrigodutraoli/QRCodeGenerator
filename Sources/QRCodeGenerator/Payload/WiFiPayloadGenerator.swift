//
//  File.swift
//  
//
//  Created by Rodrigo Dutra de Oliveira on 7/7/22.
//

import Foundation

struct WiFiPayloadGenerator: PayloadGenerator {
    let ssid: String
    let password: String
    let authenticationMode: AuthenticationMode
    let isHiddenSsid: Bool
    
    init(ssid: String, password: String, authenticationMode: AuthenticationMode, isHiddenSsid: Bool, escapeHexStrings: Bool = false){
        
        self.ssid = escapeHexStrings && ssid.escapeInput().isValidHexNumber() ? "\"" + ssid.escapeInput() + "\"" : ssid.escapeInput()
        self.password = escapeHexStrings && password.escapeInput().isValidHexNumber() ? "\"" + password.escapeInput() + "\"" : password.escapeInput()
        
        self.authenticationMode = authenticationMode
        self.isHiddenSsid = isHiddenSsid
    }

    var payload: String {
        "WIFI:T:\(self.authenticationMode.rawValue);S:\(self.ssid);P:\(self.password);\((self.isHiddenSsid ? "H:true" : ""));"
    }
    
    enum AuthenticationMode: String {
        case WEP
        case WPA
        case nopass
    }
}



