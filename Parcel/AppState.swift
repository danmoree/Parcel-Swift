//
//  AppState.swift
//  Parcel
//
//  Created by Daniel Moreno on 7/3/24.
//  Controls the flow of views to present.

import Foundation

// Works between these two views.
enum Route {
    case dashboard
    case songView
    case samples
}

class AppState: ObservableObject {
    
    // Stack approach
    @Published var routes: [Route] = [.dashboard]
    
    var currentRoute: Route? {
        routes.last
    }
    
    
    func push(_ route: Route) {
        routes.append(route)
    }
    
    
    @discardableResult
    func pop() -> Route? {
        routes.popLast()
    }
}
