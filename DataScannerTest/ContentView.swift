//
//  ContentView.swift
//  DataScannerTest
//
//  Created by Philipp on 07.01.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                Image(systemName: "house")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
                    .navigationTitle("Home")
                    .foregroundStyle(.secondary)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            ScanView()
                .tabItem {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
        }
    }
}

#Preview {
    ContentView()
}
