//
//  RatingView.swift
//  Films Library
//
//  Created by Dmitrij Meidus on 10.06.23.
//

import SwiftUI

struct FilledStar: View {
    var body: some View {
        Image(systemName: "star.fill")
            .foregroundStyle(.red)
            .font(.body)
    }
}

struct Star: View {
    var body: some View {
        Image(systemName: "star")
            .foregroundStyle(.red)
            .font(.body)
    }
}

struct RatingView: View {
    var rating: Float
    var countOfFilledStars: Int { Int(rating) / 2 + 1}
    
    var body: some View {
        ZStack {
            HStack {
                ForEach(0..<countOfFilledStars, id: \.self) { _ in
                    FilledStar()
                }
                ForEach(0..<5 - countOfFilledStars, id: \.self){ _ in
                    Star()
                }
            }
        }
    }
}
