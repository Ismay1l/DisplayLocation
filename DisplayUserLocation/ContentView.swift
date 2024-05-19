//
//  ContentView.swift
//  DisplayUserLocation
//
//  Created by Ismayil Ismayilov on 5/18/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var mapViewModel = MapViewModel()
    
    
    var body: some View {
        Map(coordinateRegion:  $mapViewModel.region, showsUserLocation: true)
            .accentColor(.pink)
            .ignoresSafeArea()
            .onAppear {
                mapViewModel.checkIfLocationServicesEnabled()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
