# SwiftUI Data Scanner Test

This projects demonstrates a problem in SwiftUI when embedding `DataScannerViewController` in 
`UIViewControllerRepresentable`. It has been created based on [StackOverflow questions](https://stackoverflow.com/questions/77427828/restart-camera-when-view-appears)
and its associated code.

## The setup 

- `DataScannerViewController` is wrapped in a `UIViewControllerRepresentable` conforming `DataScannerView` (in file DataScannerView.swift).
   It will detect barcode/text elements (based on some input parameters).

- `ViewInsideScanView` is embedding the `DataScannerView` if access to the camera has been granted, otherwise a text message is shown.  
   The `headerView` (presented as a sheet) allows changing the type of scan.
  
- `ScanView` is integrating `ViewInsideScanView` in its layout.

- `ContentView` is combining a dummy "Home" view and the `ScanView` in a `TabView`.


## The problem

The `DataScannerViewController` automatically stopps scanning and updating the camera preview, when the view disappears
by switching the currently selected tab. When switching the tab back to the scanner view, the scanning does not restart,
even though method `startScanning()` of `DataScannerViewController` is called. 


## The workaround

Recreating the `DataScannerView` instance is currently the only way to make it work again.  
This is done by incrementing the `appearCount` of the current `ScannerDataViewModel` instance. This causes the 
`dataScannerViewId` to change, making SwiftUI think, that the `DataScannerView` has to be re-instantiated.
