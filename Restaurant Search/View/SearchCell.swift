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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.body)
                .foregroundColor(.primary)
            Text(detail)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct SearchCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell(
            title: "Title",
            detail: "Detail"
        )
    }
}
