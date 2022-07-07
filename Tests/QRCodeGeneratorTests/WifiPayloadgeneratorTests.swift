//
//  WifiPayloadgeneratorTests.swift
//  
//
//  Created by Rodrigo Dutra de Oliveira on 7/7/22.
//

import Foundation

import XCTest
@testable import QRCodeGenerator

final class WifiPayloadgeneratorTests: XCTestCase {
    func test_wifi_should_build_wep() throws {
        let ssid = "MyWiFiSSID";
        let password = "7heP4assw0rd";
        let authmode = WiFiPayloadGenerator.AuthenticationMode.WEP;
        let hideSSID = false;
        
        let sut = WiFiPayloadGenerator(ssid: ssid, password: password, authenticationMode: authmode, isHiddenSsid: hideSSID)
        let payload = sut.payload
        
        XCTAssertEqual(payload, "WIFI:T:WEP;S:MyWiFiSSID;P:7heP4assw0rd;;")
    }
    
    func test_wifi_should_build_wpa() throws {
        let ssid = "MyWiFiSSID"
        let password = "7heP4assw0rd"
        let authmode = WiFiPayloadGenerator.AuthenticationMode.WPA;
        let hideSSID = false
        
        let sut = WiFiPayloadGenerator(ssid: ssid, password: password, authenticationMode: authmode, isHiddenSsid: hideSSID)
        let payload = sut.payload
        
        XCTAssertEqual(payload, "WIFI:T:WPA;S:MyWiFiSSID;P:7heP4assw0rd;;")
    }
    
    func test_wifi_should_ignore_hiddenSSID_param() throws {
        let ssid = "MyWiFiSSID"
        let password = "7heP4assw0rd"
        let authmode = WiFiPayloadGenerator.AuthenticationMode.WPA;
        
        let sut = WiFiPayloadGenerator(ssid: ssid, password: password, authenticationMode: authmode)
        let payload = sut.payload
        
        XCTAssertEqual(payload, "WIFI:T:WPA;S:MyWiFiSSID;P:7heP4assw0rd;;")
    }
    
    func test_wifi_should_add_hiddenSSID_param() throws {
        let ssid = "M\\y;W,i:FiSSID"
        let password = "7heP4assw0rd\\;:,"
        let authmode = WiFiPayloadGenerator.AuthenticationMode.WPA
        let hideSSID = true
        
        let sut = WiFiPayloadGenerator(ssid: ssid, password: password, authenticationMode: authmode, isHiddenSsid: hideSSID)
        let payload = sut.payload

        XCTAssertEqual(payload, "WIFI:T:WPA;S:M\\\\y\\;W\\,i\\:FiSSID;P:7heP4assw0rd\\\\\\;\\:\\,;H:true;")
    }
    
    func test_wifi_should_escape_input() throws {
        let ssid = "MyWiFiSSID"
        let password = "7heP4assw0rd"
        let authmode = WiFiPayloadGenerator.AuthenticationMode.WPA
        let hideSSID = true
        
        let sut = WiFiPayloadGenerator(ssid: ssid, password: password, authenticationMode: authmode, isHiddenSsid: hideSSID)
        let payload = sut.payload
        
        XCTAssertEqual(payload, "WIFI:T:WPA;S:MyWiFiSSID;P:7heP4assw0rd;H:true;")
    }
    
    func test_wifi_should_escape_hex_style1() throws {
        let ssid = "A9B7F18CCE"
        let password = "00105F0E6"
        let authmode = WiFiPayloadGenerator.AuthenticationMode.WPA
        let hideSSID = true
        
        let sut = WiFiPayloadGenerator(ssid: ssid, password: password, authenticationMode: authmode, isHiddenSsid: hideSSID)
        let payload = sut.payload
        
        XCTAssertEqual(payload, "WIFI:T:WPA;S:\"A9B7F18CCE\";P:\"00105F0E6\";H:true;")
    }
    
}
