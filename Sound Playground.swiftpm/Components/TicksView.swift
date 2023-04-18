//
//  TicksView.swift
//
//
//  Created by Helloyunho on 2023/04/17.
//

import SwiftUI

struct TicksView: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()

        let width = Double(rect.width)
        let height = Double(rect.height)
        var currentX: Double = 0
        let currentY: Double = height
        while currentX <= width {
            path.move(to: .init(x: currentX, y: 0))
            path.addLine(to: .init(x: currentX, y: currentY))
            currentX += 400 / 12
        }

        return Path(path.cgPath)
    }
}

struct TicksView_Previews: PreviewProvider {
    static var previews: some View {
        TicksView()
            .stroke(Color.black, lineWidth: 1)
    }
}
