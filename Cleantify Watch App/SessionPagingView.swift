//
//  SessionPagingView.swift
//  Cleantify Watch App
//
//  Created by Vicky Irwanto on 23/07/23.
//

import SwiftUI

struct SessionPagingView: View {
    @State private var tabSelection: Tab = .metrics
    
    enum Tab{
        case controls, metrics, nowPlaying
    }
    var body: some View {
        TabView(selection: $tabSelection){
            Text("Controls").tag(Tab.controls)
            Text("Metrics").tag(Tab.metrics)
            Text("Now Playong").tag(Tab.nowPlaying)
        }
    }
}

struct SessionPagingView_Previews: PreviewProvider {
    static var previews: some View {
        SessionPagingView()
    }
}
