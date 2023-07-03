//
//  SearchCell.swift
//  Restaurant Search
//
//  Created by Yuto on 2023/06/27.
//

import SwiftUI

struct SearchCell: View {
    
    var title: String
    var detail: String
    var imageURL: URL?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                AsyncImage(url: imageURL) {
                    $0
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 160, maxHeight: 100)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                Spacer()
            }
            .frame(height: 100)
            
            Text(title)
                .font(.body)
                .foregroundColor(.primary)
            
            Text(detail)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .accessibilityElement(children: .combine)
    }
}

struct SearchCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell(
            title: "Title",
            detail: "Detail",
            imageURL: URL(string: "https://imgfp.hotp.jp/IMGH/63/97/P030036397/P030036397_69.jpg")
        )
    }
}
