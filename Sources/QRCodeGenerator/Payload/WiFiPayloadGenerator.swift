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
    
    init(ssid: String, password: String, authenticationMode: AuthenticationMode, isHiddenSsid: Bool = false, escapeHexStrings: Bool = true){
        
        let escapedSsid = ssid.escapeInput()
        let escapedPassword = password.escapeInput()
        
        self.ssid = (escapeHexStrings && escapedSsid.isValidHexNumber()) ? ("\"" + escapedSsid + "\"") : escapedSsid
        self.password = (escapeHexStrings && escapedPassword.isValidHexNumber()) ? ("\"" + escapedPassword + "\"") : escapedPassword
        
        self.authenticationMode = authenticationMode
        self.isHiddenSsid = isHiddenSsid
    }

    var payload: String {
        print(self.ssid)
        return "WIFI:T:\(self.authenticationMode.rawValue);S:\(self.ssid);P:\(self.password);\((self.isHiddenSsid ? "H:true" : ""));"
    }
    
    enum AuthenticationMode: String {
        case WEP
        case WPA
        case nopass
    }
}



