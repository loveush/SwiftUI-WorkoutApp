//
//  Navigation_CustomBackButton.swift
//  Daily Helper
//
//  Created by Любовь Ушакова on 30.09.2024.
//

import SwiftUI

struct Navigation_CustomBackButton: View {
    var body: some View {
        NavigationStack {
                    NavigationLink("Go To Detail",
                                   destination: Navigation_CustomBackButton_Detail())
                    .font(.title)
                    .navigationTitle("Navigation Views")
                }
    }
}

#Preview {
    Navigation_CustomBackButton()
}
