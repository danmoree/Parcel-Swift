//
//  AppState.swift
//  Parcel
//
//  Created by Daniel Moreno on 7/3/24.
//

import Foundation

enum Route {
    case dashboard
    case songView
}

class AppState: ObservableObject {
    
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
