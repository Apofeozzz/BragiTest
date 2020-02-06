//
//  BLEManager.swift
//  BragiTest
//
//  Created by Denis Grishchenko on 05.02.2020.
//  Copyright © 2020 Denis Grishchenko. All rights reserved.
//

import UIKit
import CoreBluetooth
import RxSwift

class BLEManager: NSObject {
    
    static let shared = BLEManager()
    
    // MARK: - DATA SOURCE -
    
    var centralManager:     CBCentralManager!
    
    var savedPeripheral:    CBPeripheral?
    
    var foundedPeripheral   = [CBPeripheral]()
    
    var bluetoothState      = BehaviorSubject<CBManagerState?>(value: nil)
    
    var deviceConnection    = BehaviorSubject<DeviceConnection>(value: .Disconnected)
    
    // MARK: - INIT -
    
    override init() {
        
        super.init()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    // MARK: - START & STOP SCAN FOR PERIPHARAL DEVICES -
    
    func startScanning() {
        
        centralManager.scanForPeripherals(withServices: [], options: nil)
        
    }
    
    func stopScanning() {
        
        centralManager.stopScan()
        
    }
    
}

// MARK: - CENTRAL MANAGER DELEGATE -

extension BLEManager: CBCentralManagerDelegate {
    
    // MARK: - DID UPDATE STATE -
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        bluetoothState.onNext(central.state)
        
    }
    
    // MARK: - DID DISCOVER PERIPHERAL -
    
    func centralManager(_ central:              CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData:      [String : Any],
                        rssi RSSI:              NSNumber) {
        
        foundedPeripheral.append(peripheral)
        
    }
    
}

// MARK: - PERIPHERAL DELEGATE -

extension BLEManager: CBPeripheralDelegate {
    
    
}