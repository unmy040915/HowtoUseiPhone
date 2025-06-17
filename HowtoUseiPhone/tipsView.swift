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
struct messageSendTip: Tip {
    @Parameter static var ismessageSend: Bool = false
    var title: Text{ Text("テキストを入力しよう")
    }
    var rules: [Rule] {
        [
            #Rule(Self.$ismessageSend) { $0 == true }
        ]
    }
}
struct ImageSendTip: Tip {
    @Parameter static var isImageSend: Bool = false
    var title: Text{ Text("ここをタップして画像を送信")
    }
    var rules: [Rule] {
        [
            #Rule(Self.$isImageSend) { $0 == true }
        ]
    }
}

struct copyPasteTip: Tip {
    @Parameter static var isCopySend: Bool = false
    var title: Text{ Text("ここを長押ししてコピー")
    }
    var rules: [Rule] {
        [
            #Rule(Self.$isCopySend) { $0 == true }
        ]
    }
}

struct pasteTip: Tip {
    @Parameter static var isPasteSend: Bool = false
    var title: Text{ Text("ここを長押ししてペースト")
    }
    var rules: [Rule] {
        [
            #Rule(Self.$isPasteSend) { $0 == true }
        ]
    }
}
