//
//  ContentView.swift
//  UI-626
//
//  Created by nyannyan0328 on 2022/08/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            
            Home()
                .navigationTitle("ToolBar Animation")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
