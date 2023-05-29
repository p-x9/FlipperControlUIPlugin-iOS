//
//  ContentView.swift
//  Example
//
//  Created by p-x9 on 2023/05/29.
//  
//

import SwiftUI

struct ContentView: View {
    @State var text: String = "Hello"
    
    var body: some View {
        NavigationView {
            List(0..<100) { r in
                NavigationLink {
                    VStack {
                        Text("\(r)")
                        TextEditor(text: $text)
                    }
                } label: {
                    Text("\(r)")
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
