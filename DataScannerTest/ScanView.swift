//
//  ScanView.swift
//  DataScannerTest
//
//  Created by Philipp on 07.01.2024.
//

import SwiftUI

struct ScanView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var vm: ScannerDataViewModel = ScannerDataViewModel()
    private let viewInsideScan = ViewInsideScanView()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(spacing: 8) {
                    
                    Text("Place barcode in the center")
                        .font(.title3)
                        .foregroundColor(Color.primary)
                        .padding(.top, 20)
                    
                    Text("The scan will start automatically")
                        .font(.callout)
                        .foregroundColor(Color.primary)
                    
                    Spacer()
                    
                    CenteredSquareView(content: viewInsideScan)
                        .frame(width: 350, height: 350, alignment: .center)
                    
                    Spacer()
                    
                    Image(systemName: "qrcode.viewfinder")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    
                    
                    Text("Tap the icon to run a new scan")
                        .font(.callout)
                        .foregroundColor(Color.primary)
                    
                    Spacer(minLength: 45)
                    
                }
            }
            .environmentObject(vm)
            .onAppear {
                print("ScanView onAppear")
                Task {
                    await vm.requestDataScannerAccessStatus()
                }
            }
        }
    }
}

struct CenteredSquareView<Content: View>: View {
    var content: Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                content
                    .frame(width: geometry.size.width * 1, height: geometry.size.width * 1)
                    .cornerRadius(20)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2) // Posiziona al centro
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ScanView()
}
