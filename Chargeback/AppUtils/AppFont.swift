import SwiftUI

enum AppFont {
    static func regular(size: CGFloat) -> Font {
        Font.custom("GraphikTrial-Regular", size: size)
    }
    static func semibold(size: CGFloat) -> Font {
        Font.custom("GraphikTrial-Semibold", size: size)
    }
    static func bold(size: CGFloat) -> Font {
        Font.custom("GraphikTrial-Bold", size: size)
    }
    static func medium(size: CGFloat) -> Font {
        Font.custom("GraphikTrial-Medium", size: size)
    }
}
