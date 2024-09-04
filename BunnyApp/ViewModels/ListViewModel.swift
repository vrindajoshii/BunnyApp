//
//  ItemsViewModel.swift
//  TutApp
//
//  Created by Vrinda Joshi on 07/08/2024.
//

import Foundation

//list of items view - primary tabe
class ListViewModel: ObservableObject{
    
    @Published var showingNewItemView = false //when first launches dont want it shown right away
    
    init(){}
    
}
