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
            VStack(spacing: 8) {

                Text("Place barcode in the center")
                    .font(.title3)
                    .padding(.top, 20)

                Text("The scan will start automatically")
                    .font(.callout)

                Spacer()

                viewInsideScan
                    .clipShape(.rect(cornerRadius: 20))
                    .frame(width: 350, height: 350, alignment: .center)

                Spacer()

                Image(systemName: "qrcode.viewfinder")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)


                Text("Tap the icon to run a new scan")
                    .font(.callout)

                Spacer(minLength: 45)
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

#Preview {
    ScanView()
}
