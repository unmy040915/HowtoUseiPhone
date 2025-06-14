import SwiftUI

import TipKit
struct SearchTip: Tip {
    @Parameter static var isTaskSearch: Bool = false
    var title: Text{ Text("ここをタップして検索")
    }
    var rules: [Rule] {
        [
            #Rule(Self.$isTaskSearch) { $0 == true }
        ]
    }
}
struct AdvertisementTip: Tip{
    @Parameter static var isTaskAdvertisement: Bool = false
    var title: Text{ Text("広告を開こう")
    }
    var rules: [Rule] {
        [
            #Rule(Self.$isTaskAdvertisement) { $0 == true }
        ]
    }
}
struct CrossTip: Tip{
    @Parameter static var isCross: Bool = false
    var title: Text{ Text("×ボタンを押して削除しよう")
    }
    var rules: [Rule] {
        [
            #Rule(Self.$isCross) { $0 == true }
        ]
    }
}
