//
//  DataScannerView.swift
//  DataScannerTest
//
//  Created by Philipp on 07.01.2024.
//

import Foundation
import SwiftUI
import VisionKit

struct DataScannerView: UIViewControllerRepresentable {
    
    @Binding var recognizedItems: [RecognizedItem]
    let recognizedDataType: DataScannerViewController.RecognizedDataType
    let recognizesMultipleItems: Bool
    
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        print(#function)
        let vc = DataScannerViewController(
            recognizedDataTypes: [recognizedDataType],
            qualityLevel: .balanced,
            recognizesMultipleItems: recognizesMultipleItems,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        return vc
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        print(#function)
        if uiViewController.delegate == nil {
            uiViewController.delegate = context.coordinator
        }
        if uiViewController.isScanning == false {
            print("🟡 Scanning was stopped. Starting now")
            do {
                try uiViewController.startScanning()
            } catch {
                print("🔴 startScanning failed with \(error)")
            }
        }
        if !uiViewController.recognizedDataTypes.contains(recognizedDataType) {
            print("recognizedDataType did change to ", recognizedDataType)
        }
        if uiViewController.recognizesMultipleItems != recognizesMultipleItems {
            print("recognizesMultipleItems did change to ",recognizesMultipleItems)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        print(#function)
        return Coordinator(recognizedItems: $recognizedItems)
    }
    
    static func dismantleUIViewController(_ uiViewController: DataScannerViewController, coordinator: Coordinator) {
        print(#function)
        uiViewController.stopScanning()
    }
    
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        
        @Binding var recognizedItems: [RecognizedItem]
        
        init(recognizedItems: Binding<[RecognizedItem]>) {
            print(#function)
            self._recognizedItems = recognizedItems
        }

        deinit {
            print(#function)
        }

        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            print("didTapOn \(item)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            recognizedItems.append(contentsOf: addedItems)
            print("didAddItems \(addedItems)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            self.recognizedItems = recognizedItems.filter { item in
                !removedItems.contains(where: {$0.id == item.id })
            }
            print("didRemovedItems \(removedItems)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            print("became unavailable with error \(error.localizedDescription)")
        }
    }
}
