import Foundation
import SwiftUI

// MARK: - Book Category
enum BookCategory: String, CaseIterable, Codable {
    case fairyTale, fable, adventure, classic, turkish

    var nameEN: String {
        switch self {
        case .fairyTale: return "Fairy Tales"
        case .fable:     return "Fables"
        case .adventure: return "Adventures"
        case .classic:   return "Classics"
        case .turkish:   return "Turkish Tales"
        }
    }
    var nameTR: String {
        switch self {
        case .fairyTale: return "Peri Masalları"
        case .fable:     return "Fabller"
        case .adventure: return "Maceralar"
        case .classic:   return "Klasikler"
        case .turkish:   return "Türk Masalları"
        }
    }
    var emoji: String {
        switch self {
        case .fairyTale: return "🧚"
        case .fable:     return "🦊"
        case .adventure: return "⚔️"
        case .classic:   return "📚"
        case .turkish:   return "🌙"
        }
    }
    var color: Color {
        switch self {
        case .fairyTale: return Color(hex: "FF6B9D")
        case .fable:     return Color(hex: "FF8C42")
        case .adventure: return Color(hex: "4ECDC4")
        case .classic:   return Color(hex: "9B59B6")
        case .turkish:   return Color(hex: "E74C3C")
        }
    }
}

// MARK: - Book Model
struct Book: Identifiable {
    let id: UUID
    let titleEN: String
    let titleTR: String
    let contentEN: [String]
    let contentTR: [String]
    let coverEmoji: String
    let coverColorHex: String
    let coverImageName: String?   // Assets'teki gerçek kapak görseli
    let category: BookCategory
    let isFree: Bool
    let readingTimeMinutes: Int

    var coverColor: Color { Color(hex: coverColorHex) }
    var hasCoverImage: Bool { coverImageName != nil }

    func title(in lang: AppLanguage) -> String { lang == .english ? titleEN : titleTR }
    func content(in lang: AppLanguage) -> [String] { lang == .english ? contentEN : contentTR }
}

// MARK: - Color Helper
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - All 58 Books
extension Book {
    static let allBooks: [Book] = [
        // ── FREE (1-15) ─────────────────────────────────────────────
        Book(id: UUID(), titleEN: "The Three Little Pigs", titleTR: "Üç Küçük Domuz",
             contentEN: [
                "Once upon a time, three little pigs left home to build their own houses. The first pig built a house of straw, hoping to finish quickly and play all day.",
                "The big bad wolf came huffing and puffing. He blew down the straw house and then the stick house, chasing the two little pigs to their brother's brick house.",
                "No matter how hard the wolf huffed and puffed, he could not blow down the brick house. The three pigs were safe inside, warm and cozy.",
                "Finally the wolf tried to come down the chimney, but the pigs had a pot of boiling water waiting. The wolf ran away and never bothered them again. The three pigs lived happily ever after."
             ],
             contentTR: [
                "Bir zamanlar üç küçük domuz evden ayrılıp kendi evlerini inşa etmeye karar verdi. İlk domuz hızlıca bitirmek için saman kulübe yaptı.",
                "Büyük kötü kurt geldi ve soluklanarak saman evi yıktı, sonra tahta evi de devirdi. İki domuz kardeşlerinin tuğla evine sığındı.",
                "Kurt ne kadar üflese de tuğla evi yıkamadı. Üç kardeş içeride sıcak ve güvende bekledi.",
                "Kurt bacadan girmeye çalışınca domuzlar kaynar su dolu bir tencere hazırlamıştı. Kurt kaçıp gitti ve bir daha onları rahatsız etmedi. Üç küçük domuz mutlu yaşadı."
             ],
             coverEmoji: "🐷", coverColorHex: "FFB347", coverImageName: nil, category: .fairyTale, isFree: true, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "Little Red Riding Hood", titleTR: "Kırmızı Başlıklı Kız",
             contentEN: [
                "A little girl always wore a red hood her grandmother had made her. One day her mother sent her through the forest to bring food to her sick grandmother.",
                "In the forest, she met a sly wolf. He asked where she was going, and she naively told him. The wolf ran ahead to grandmother's cottage.",
                "The wolf disguised himself as grandmother. When the girl arrived, she noticed how strange grandmother looked — big eyes, big ears, big teeth! The wolf leapt up to eat her.",
                "A brave woodcutter nearby heard her scream and rushed in, scaring the wolf away. Grandmother was rescued, and the little girl learned never to talk to strangers."
             ],
             contentTR: [
                "Küçük bir kız her zaman büyükannesinin diktiği kırmızı başlığını takardı. Bir gün annesi onu hasta büyükannesine yemek götürmesi için ormana gönderdi.",
                "Ormanda kurnaz bir kurtla karşılaştı. Kurt nereye gittiğini sordu; kız da saf bir şekilde söyledi. Kurt hızla büyüannenin evine koştu.",
                "Kurt büyüanne kılığına girdi. Kız eve gelince büyüannenin çok tuhaf göründüğünü fark etti — büyük gözler, büyük kulaklar, büyük dişler! Kurt onu yemek için fırladı.",
                "Yakındaki cesur bir oduncu kızın çığlığını duydu ve içeri koşarak kurdu korkuttu. Büyüanne kurtarıldı, kız da yabancılarla konuşmamayı öğrendi."
             ],
             coverEmoji: "🐺", coverColorHex: "FF6B6B", coverImageName: nil, category: .fairyTale, isFree: true, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "Cinderella", titleTR: "Külkedisi",
             contentEN: [
                "Cinderella lived with her cruel stepmother and two stepsisters who made her do all the housework. She dreamed of a better life but never lost her kindness.",
                "The kingdom announced a royal ball. The stepsisters went, but Cinderella was left behind. Then her fairy godmother appeared and transformed her rags into a beautiful gown and pumpkin into a carriage.",
                "At the ball, the prince danced only with Cinderella all night. But she had to leave before midnight, and in her rush she lost a glass slipper on the palace steps.",
                "The prince searched the kingdom for the girl whose foot fit the slipper. When he found Cinderella, she tried it on — a perfect fit. They married and lived happily ever after."
             ],
             contentTR: [
                "Külkedisi, zalim üvey annesi ve iki üvey kız kardeşiyle yaşıyordu; tüm ev işlerini o yapıyordu. İyi kalpli kız daha iyi bir yaşam düşlüyordu.",
                "Krallık bir balo düzenledi. Üvey kız kardeşler gitti, Külkedisi evde kaldı. Sihirli anneannesi belirdi ve paçavralarını güzel bir geceliğe, balkabağını da arabaya dönüştürdü.",
                "Baloda prens tüm gece yalnızca Külkedisi ile dans etti. Ama gece yarısından önce ayrılmak zorunda kaldı ve koşarken saray merdivenlerinde cam terliğini düşürdü.",
                "Prens, terliği ayağına uyan kızı tüm krallıkta aradı. Külkedisi'ni bulduğunda terliği denedi — tam oturdu. Evlendiler ve sonsuza dek mutlu yaşadılar."
             ],
             coverEmoji: "👠", coverColorHex: "C39BD3", coverImageName: "cover_cinderella", category: .fairyTale, isFree: true, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "Snow White", titleTR: "Pamuk Prenses",
             contentEN: [
                "Snow White had skin as white as snow, lips as red as blood, and hair as black as night. Her jealous stepmother, the queen, owned a magic mirror that said Snow White was the fairest of all.",
                "The queen ordered a huntsman to take Snow White into the forest and kill her. But he couldn't do it — he let her go, and Snow White fled deep into the woods.",
                "She found the cottage of seven dwarfs, who let her live with them. But the evil queen discovered she was alive and came disguised as an old woman with a poisoned apple.",
                "Snow White bit the apple and fell into a deep sleep. The dwarfs placed her in a glass coffin. A prince found her, fell in love, and when he kissed her, the spell broke and she woke up. They lived happily ever after."
             ],
             contentTR: [
                "Pamuk Prenses'in teni kar gibi beyaz, dudakları kan gibi kırmızı, saçları gece gibi siyahtı. Kıskanç üvey annesi olan kraliçenin sihirli aynası en güzelin Pamuk Prenses olduğunu söylüyordu.",
                "Kraliçe bir avcıya Pamuk Prenses'i ormana götürüp öldürmesini emretti. Ama avcı bunu yapamadı — kızı serbest bıraktı, Pamuk Prenses ormana kaçtı.",
                "Yedi cücenin kulübesini buldu; cüceler onu yanlarında kalmaya davet etti. Ama kötü kraliçe yaşadığını öğrenip yaşlı kadın kılığında zehirli elmayla geldi.",
                "Pamuk Prenses elmadan bir ısırık aldı ve derin uykuya daldı. Cüceler onu cam bir tabuta koydular. Bir prens buldu, aşık oldu; öpücüğüyle büyü bozuldu ve kız uyandı. Mutlu yaşadılar."
             ],
             coverEmoji: "🍎", coverColorHex: "E74C3C", coverImageName: "cover_snowwhite", category: .fairyTale, isFree: true, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "Sleeping Beauty", titleTR: "Uyuyan Güzel",
             contentEN: [
                "A beautiful princess was born and all the fairies of the land were invited to bless her. But one wicked fairy was forgotten and cursed the baby: she would prick her finger on a spindle and die.",
                "A kind fairy softened the curse — the princess would not die but sleep for a hundred years, until woken by a prince's kiss. The king banned all spindles, but on her sixteenth birthday the princess found one.",
                "She pricked her finger and fell into a deep sleep. The whole castle slept with her, and a forest of thorns grew around it.",
                "After a hundred years, a brave prince fought through the thorns, found the princess, and kissed her. She woke up, the castle stirred to life, and the two were married in great celebration."
             ],
             contentTR: [
                "Güzel bir prenses doğdu ve ülkedeki tüm periler onu kutsamaya davet edildi. Ama unutulan kötü bir peri bebeğe lanet etti: bir iğne ile parmağını delecek ve ölecekti.",
                "İyi bir peri laneti hafifletti — prenses ölmeyecek, ama bir prensin öpücüğüyle uyanana kadar yüz yıl uyuyacaktı. Kral tüm iğneleri yasakladı; ama prenses on altıncı doğum gününde bir iğne buldu.",
                "Parmağını deldi ve derin uykuya daldı. Tüm saray onunla uyudu; etrafında dikenli bir orman büyüdü.",
                "Yüz yıl sonra cesur bir prens dikenleri aşıp prensesi buldu ve öptü. Prenses uyandı, saray hayata döndü ve ikisi büyük bir törenle evlendi."
             ],
             coverEmoji: "🌹", coverColorHex: "FF85A1", coverImageName: "cover_sleepingbeauty", category: .fairyTale, isFree: true, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "Jack and the Beanstalk", titleTR: "Jack ve Fasulye Sırığı",
             contentEN: [
                "Jack and his mother were very poor. One day his mother sent him to sell their cow, but Jack traded it for magic beans. His mother threw the beans out the window in anger.",
                "Overnight a giant beanstalk grew to the sky. Jack climbed it and reached a castle in the clouds, home to a terrible giant who loved gold.",
                "Jack sneaked in three times, stealing a bag of gold, a hen that laid golden eggs, and a magic harp. Each time the giant chased him shouting, 'Fee fi fo fum!'",
                "On the last escape, Jack slid down and chopped the beanstalk with an axe. The giant fell and was gone. Jack and his mother lived happily ever after with their treasure."
             ],
             contentTR: [
                "Jack ve annesi çok fakirdi. Annesi onu ineklerini satmaya gönderdi, ama Jack ineği sihirli fasulyelerle takas etti. Annesi fasulyeleri sinirle pencereden attı.",
                "Gece boyunca gökyüzüne uzanan devasa bir fasulye sırığı büyüdü. Jack tırmandı ve bulutlarda altın seven korkunç bir devin yaşadığı bir şatoya ulaştı.",
                "Jack üç kez içeri gizlice girdi: bir torba altın, altın yumurtlayan bir tavuk ve sihirli bir arp çaldı. Her seferinde dev 'Dım dım dım!' diye bağırarak peşine düştü.",
                "Son kaçışta Jack aşağı kaydı ve sırığı baltayla kesti. Dev düştü ve bir daha görünmedi. Jack ve annesi hazineleriyle mutlu yaşadı."
             ],
             coverEmoji: "🌱", coverColorHex: "2ECC71", coverImageName: nil, category: .fairyTale, isFree: true, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "Goldilocks and the Three Bears", titleTR: "Altın Saçlı Kız ve Üç Ayı",
             contentEN: [
                "Three bears — papa bear, mama bear, and baby bear — went for a walk while their porridge cooled. A curious girl named Goldilocks wandered into their empty cottage.",
                "She tried the three bowls of porridge. Papa's was too hot, mama's too cold, but baby bear's was just right, so she ate it all up.",
                "She tried the chairs — too big, too big, just right! But she broke the little chair. Upstairs she tried the beds — too hard, too soft, just right! She fell fast asleep.",
                "The bears came home, found their porridge eaten and their chairs disturbed. Baby bear found Goldilocks sleeping in his bed. She woke up, screamed, and ran home, never to return again."
             ],
             contentTR: [
                "Üç ayı — baba ayı, anne ayı ve yavru ayı — lapaları soğusun diye gezmeye çıktılar. Altın Saçlı adında meraklı bir kız boş kulübeye girdi.",
                "Üç lapayı tattı. Babanınki çok sıcak, anneninki çok soğuk, ama yavru ayınınki tam yerindeydi ve hepsini yedi.",
                "Koltuklara oturdu — çok büyük, çok büyük, tam uygun! Ama küçük koltuğu kırdı. Üstte yatakları denedi — çok sert, çok yumuşak, tam uygun! Derin uykuya daldı.",
                "Ayılar eve döndü, lapalarının yendiğini ve koltuklarının karıştırıldığını gördü. Yavru ayı Altın Saçlı'yı kendi yatağında uyurken buldu. Kız uyandı, çığlık attı ve bir daha dönmemek üzere kaçtı."
             ],
             coverEmoji: "🐻", coverColorHex: "D4A574", coverImageName: nil, category: .fairyTale, isFree: true, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "The Ugly Duckling", titleTR: "Çirkin Ördek Yavrusu",
             contentEN: [
                "A mother duck hatched her eggs one spring. All her ducklings were yellow and fluffy, but one was large, grey, and ugly. The other animals mocked and chased him away.",
                "The ugly duckling wandered alone through autumn and a cold, harsh winter. He was lonely and sad, convinced that he would always be different and unloved.",
                "When spring came, he saw beautiful white swans on a lake. He approached them, ashamed of himself. But when he looked at his reflection in the water, he was amazed.",
                "He was no ugly duckling at all — he had grown into a magnificent swan! The other swans welcomed him warmly, and he lived happily ever after, proud of who he truly was."
             ],
             contentTR: [
                "Bir bahar anası ördek yumurtalarını çıkardı. Tüm yavruları sarı ve kabarıktı, ama biri büyük, gri ve çirkindi. Diğer hayvanlar onunla alay etti ve kovdu.",
                "Çirkin ördek yavrusu sonbahar ve soğuk kışta yalnız dolaştı. Yalnız ve üzgündü; her zaman farklı ve sevilmeyeceğine inanmıştı.",
                "İlkbahar gelince gölde güzel beyaz kuğular gördü. Kendinden utanarak yaklaştı. Ama sudaki yansımasına bakınca şaşırdı.",
                "O hiç de çirkin bir ördek yavrusu değildi — görkemli bir kuğuya dönüşmüştü! Diğer kuğular onu sıcakça karşıladı ve kim olduğuyla gurur duyarak mutlu yaşadı."
             ],
             coverEmoji: "🦢", coverColorHex: "85C1E9", coverImageName: "cover_uglyduckling", category: .fairyTale, isFree: true, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "The Little Mermaid", titleTR: "Küçük Denizkızı",
             contentEN: [
                "Deep beneath the ocean lived a young mermaid who was fascinated by the human world above. She collected human objects and dreamed of walking on land.",
                "One stormy night she saved a handsome prince from drowning. She fell deeply in love with him and made a deal with the sea witch: legs in exchange for her beautiful voice.",
                "She went ashore and the prince found her, but without her voice she could not tell him who she was. He eventually fell for another princess who he thought had saved him.",
                "The little mermaid faced a sad choice but chose love over vengeance. Her pure heart transformed her into a spirit of the air, and she found peace and happiness in a new form."
             ],
             contentTR: [
                "Okyanusun derinliklerinde yukarıdaki insan dünyasına hayran olan genç bir denizkızı yaşıyordu. İnsan nesneleri toplar ve karada yürümeyi hayal ederdi.",
                "Fırtınalı bir gecede yakışıklı bir prensi boğulmaktan kurtardı. Ona derinden aşık oldu ve deniz cadısıyla anlaştı: güzel sesi karşılığında bacak.",
                "Karaya çıktı ve prens onu buldu, ama sesi olmadan kendisinin kim olduğunu söyleyemedi. Prens, kendisini kurtardığını sandığı başka bir prensese aşık oldu.",
                "Küçük denizkızı zor bir seçimle karşılaştı ama intikam yerine sevgiyi seçti. Saf kalbi onu bir hava ruhuna dönüştürdü ve yeni haliyle huzur ile mutluluk buldu."
             ],
             coverEmoji: "🧜‍♀️", coverColorHex: "1ABC9C", coverImageName: "cover_littlemermaid", category: .fairyTale, isFree: true, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "Hansel and Gretel", titleTR: "Hansel ve Gretel",
             contentEN: [
                "Hansel and Gretel lived with their father and cruel stepmother at the edge of a forest. When food ran out, the stepmother convinced their father to abandon them in the woods.",
                "Hansel left a trail of breadcrumbs, but birds ate them all. The children were lost. Deep in the forest they found a house made entirely of gingerbread, candy, and cake.",
                "A wicked witch lived there. She captured them, locking Hansel in a cage to fatten him up for eating. Gretel had to cook and clean.",
                "Clever Gretel tricked the witch and pushed her into the oven. They found the witch's treasure, found their way home, and were reunited with their loving father. The stepmother was gone."
             ],
             contentTR: [
                "Hansel ve Gretel babaları ve zalim üvey anneleriyle ormanın kenarında yaşıyordu. Yiyecek bitince üvey anne babalarını ormanda bırakmaya ikna etti.",
                "Hansel ekmek kırıntıları bıraktı, ama kuşlar hepsini yedi. Çocuklar kayboldu. Ormanın derinliklerinde tamamen zencefilli kurabiye, şeker ve kekten yapılmış bir ev buldular.",
                "Orada kötü bir cadı yaşıyordu. Hansel'i yemek için kafese kapattı, Gretel de pişirip temizlik yapmak zorunda kaldı.",
                "Zeki Gretel cadıyı kandırıp fırına itti. Hazinenin peşinden eve döndüler ve sevgili babaları ile kavuştular. Üvey anne gitmişti."
             ],
             coverEmoji: "🏠", coverColorHex: "F39C12", coverImageName: "cover_hanselandgretel", category: .fairyTale, isFree: true, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "Rapunzel", titleTR: "Rapunzel",
             contentEN: [
                "A sorceress locked a girl named Rapunzel in a tall tower with no door. Rapunzel had magical golden hair that grew incredibly long, and the sorceress would climb up by calling out for her hair.",
                "One day a prince heard Rapunzel singing from the tower. He watched how the sorceress climbed and returned the next day, calling out the same words. Rapunzel let down her hair.",
                "The prince visited often and they fell in love. But the sorceress discovered their secret. She cut Rapunzel's hair and banished her to the wilderness.",
                "The prince was blinded by thorns when he fell. He wandered for years until he heard Rapunzel's voice. Her tears of joy fell on his eyes and restored his sight. They lived happily ever after."
             ],
             contentTR: [
                "Bir büyücü, Rapunzel adında bir kızı kapısı olmayan yüksek bir kuleye kapattı. Rapunzel'in mucizevi altın saçları inanılmaz uzundu; büyücü saçları aşağı bırakmasını isteyerek tırmanırdı.",
                "Bir gün bir prens Rapunzel'in kule içinde şarkı söylediğini duydu. Büyücünün nasıl tırmandığını izledi ve ertesi gün aynı sözleri söyledi. Rapunzel saçlarını bıraktı.",
                "Prens sık sık geldi ve birbirine aşık oldular. Ama büyücü sırrı öğrendi. Rapunzel'in saçını kesti ve onu ıssıza sürgün etti.",
                "Prens düşerken dikenler gözlerini kör etti. Yıllarca dolaştı ve Rapunzel'in sesini duydu. Sevincin gözyaşları gözlerine aktı ve görme duyusu geri geldi. Sonsuza dek mutlu yaşadılar."
             ],
             coverEmoji: "🏰", coverColorHex: "F1C40F", coverImageName: "cover_rapunzel", category: .fairyTale, isFree: true, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "Beauty and the Beast", titleTR: "Güzel ve Çirkin",
             contentEN: [
                "A merchant stumbled upon an enchanted castle owned by a terrifying beast. The Beast imprisoned him but offered to release him if one of his daughters came to live in the castle.",
                "His youngest daughter, Belle, volunteered. Though the castle was magical, she was lonely and afraid of the Beast. But slowly she began to see his kindness beneath his fearsome appearance.",
                "Belle was allowed to visit her ill father. But her jealous sisters delayed her return. She rushed back to find the Beast dying of a broken heart from missing her.",
                "With tears she confessed her love. The spell broke: the Beast transformed into a kind prince who had been cursed long ago. They were married and lived joyfully together."
             ],
             contentTR: [
                "Bir tüccar, korkunç bir canavarın sahip olduğu büyülü bir şatoya rastladı. Canavar onu hapsetti ama kızlarından biri şatoya gelirse serbest bırakacağını söyledi.",
                "En küçük kızı Belle gönüllü oldu. Şato sihirli olsa da yalnız ve Canavardan korkuyordu. Ama zamanla korkutucu görünümünün ardındaki iyiliği görmeye başladı.",
                "Belle hasta babasını ziyarete izin verildi. Ama kıskanç kız kardeşleri dönüşünü geciktirdi. Koşarak geri döndüğünde Canavarı özlemden ölmek üzere buldu.",
                "Gözyaşlarıyla sevgisini itiraf etti. Büyü bozuldu: Canavar uzun süre önce lanetlenmiş olan nazik bir prense dönüştü. Evlendiler ve birlikte mutlu yaşadılar."
             ],
             coverEmoji: "🌹", coverColorHex: "E91E8C", coverImageName: nil, category: .fairyTale, isFree: true, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "Puss in Boots", titleTR: "Çizmeli Kedi",
             contentEN: [
                "A poor miller's son inherited only a cat. But the cat could talk and had big plans. He asked his master for a pair of boots and a bag, and got to work.",
                "The clever cat told everyone that his master was the great Marquis of Carabas. He brought gifts to the king and tricked the ogre who owned vast lands.",
                "The cat challenged the ogre to transform into a mouse. The foolish ogre did so, and the cat immediately ate him. Now the lands belonged to the Marquis.",
                "The king was so impressed that he gave his daughter's hand in marriage. The miller's son became a noble, and the clever cat lived like a lord, wearing his boots proudly."
             ],
             contentTR: [
                "Fakir bir değirmencinin oğlu sadece bir kedi miras aldı. Ama kedi konuşabiliyordu ve büyük planları vardı. Efendisinden bir çift çizme ve bir çanta istedi, ardından işe koyuldu.",
                "Zeki kedi herkese efendisinin büyük Karabas Markisi olduğunu söyledi. Krala hediyeler götürdü ve geniş topraklara sahip olan canavarı kandırdı.",
                "Kedi canavarı fareye dönüşmeye davet etti. Ahmak canavar dönüştü ve kedi onu hemen yedi. Artık topraklar Markis'in olmuştu.",
                "Kral çok etkilendi ve kızını ona verdi. Değirmencinin oğlu soylu biri oldu, zeki kedi de çizmelerini gururla giyerek lord gibi yaşadı."
             ],
             coverEmoji: "🐱", coverColorHex: "E67E22", coverImageName: nil, category: .fairyTale, isFree: true, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "The Frog Prince", titleTR: "Kurbağa Prens",
             contentEN: [
                "A princess dropped her golden ball into a deep well. A frog offered to retrieve it if she promised to be his companion. She agreed, then took the ball and ran off.",
                "That evening the frog appeared at the palace door, reminding the princess of her promise. Her father the king insisted she keep her word.",
                "The princess reluctantly let the frog eat from her plate and sleep in her room. She was so frustrated that she threw him against the wall.",
                "In that instant the frog transformed into a handsome prince who had been cursed by a witch. The princess apologised and they became the best of friends, and in time, married."
             ],
             contentTR: [
                "Bir prenses altın topunu derin bir kuyuya düşürdü. Bir kurbağa, arkadaşı olacağına söz verirse topu getireceğini teklif etti. Prenses kabul etti, ama topu alınca kaçtı.",
                "O akşam kurbağa saray kapısında belirdi ve prensese sözünü hatırlattı. Babası kral, sözünde durmasını istedi.",
                "Prenses isteksizce kurbağanın tabağından yemesine ve odasında uyumasına izin verdi. Sinirinden kurbağayı duvara fırlattı.",
                "O anda kurbağa bir cadı tarafından lanetlenmiş yakışıklı bir prense dönüştü. Prenses özür diledi ve en iyi arkadaş oldular; zamanla evlendiler."
             ],
             coverEmoji: "🐸", coverColorHex: "27AE60", coverImageName: nil, category: .fairyTale, isFree: true, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "The Emperor's New Clothes", titleTR: "İmparatorun Yeni Elbiseleri",
             contentEN: [
                "An emperor loved clothes above all else. Two swindlers came to town claiming to weave magical cloth that was invisible to anyone who was stupid or unfit for their job.",
                "The emperor sent officials to check the weavers' work. Of course there was nothing there, but nobody dared say so for fear of looking foolish. They all pretended to admire the cloth.",
                "The day came for the emperor to wear his new suit in a grand parade. The swindlers pretended to dress him in nothing, and he went out in public.",
                "Everyone cheered and praised the magnificent clothes — until a small child called out, 'But he has nothing on!' The emperor realised the truth but walked on proudly, having learned a lesson about vanity."
             ],
             contentTR: [
                "Bir imparator her şeyden çok elbiseleri severdi. İki dolandırıcı kasabaya geldi; aptal ya da işine yaramaz olanlara görünmez olan sihirli kumaş dokuyabileceklerini iddia ettiler.",
                "İmparator dokumaları kontrol etmesi için yetkililer gönderdi. Tabii ki ortada hiçbir şey yoktu, ama kimse aptal görünmek korkusuyla söyleyemedi. Hepsi kumaşa hayran olmuş gibi yaptı.",
                "İmparatorun yeni kıyafetini büyük bir geçit töreniyle giyeceği gün geldi. Dolandırıcılar onu sanki giydirirmiş gibi yaptı; o da soyunmuş halde halkın karşısına çıktı.",
                "Herkes harika elbiseleri alkışladı — ta ki küçük bir çocuk 'Ama üstünde hiçbir şey yok!' diye bağırana kadar. İmparator gerçeği anladı ve kibiri hakkında bir ders alarak gururla yürümeye devam etti."
             ],
             coverEmoji: "👑", coverColorHex: "9B59B6", coverImageName: nil, category: .fairyTale, isFree: true, readingTimeMinutes: 4),

        // ── PAID (16-58) ─────────────────────────────────────────────
        Book(id: UUID(), titleEN: "Rumpelstiltskin", titleTR: "Rumpelstiltskin",
             contentEN: [
                "A miller boasted to the king that his daughter could spin straw into gold. The king locked her in a room full of straw and said she must spin it all into gold by morning.",
                "A strange little man appeared and offered to help in exchange for her necklace. He spun all night. This happened two more times, the last time the girl promised her firstborn child.",
                "She became queen and had a baby. The little man returned to claim the child. Heartbroken, she begged him to give her a chance — he would let her keep the child if she guessed his name.",
                "A messenger overheard the little man singing his name in the forest: Rumpelstiltskin! The queen guessed correctly. In rage the little man stomped his foot and disappeared forever."
             ],
             contentTR: [
                "Bir değirmenci krala kızının samanı altına çevirebileceğini söyledi. Kral onu saman dolu bir odaya kilitledi; sabaha kadar hepsini altına çevirmesi gerekiyordu.",
                "Garip küçük bir adam belirdi ve gerdanlığı karşılığında yardım teklif etti. Tüm gece döndürdü. Bu iki kez daha oldu, en son kız ilk çocuğunu söz verdi.",
                "Kraliçe oldu ve bir bebek sahibi oldu. Küçük adam çocuğu almaya geri döndü. Yıkılan kraliçe bir şans tanımasını yalvardı — adını tahmin ederse çocuğu saklayabilirdi.",
                "Bir haberci küçük adamın ormanda adını söyleyen bir şarkı söylediğini duydu: Rumpelstiltskin! Kraliçe doğru tahmin etti. Öfkeyle küçük adam ayağını yere vurdu ve sonsuza dek kayboldu."
             ],
             coverEmoji: "🪄", coverColorHex: "8E44AD", coverImageName: "cover_rumpelstiltskin", category: .fairyTale, isFree: false, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "Tom Thumb", titleTR: "Küçük Tom",
             contentEN: [
                "A poor couple wished for a child, even if only as big as a thumb. Their wish was granted — a tiny boy no bigger than a thumb was born. They named him Tom Thumb.",
                "Despite his size, Tom was clever and brave. He helped his father in the fields by sitting in the horse's ear and giving directions.",
                "Tom had many adventures — he was swallowed by a cow, carried off by a raven, and swallowed by a giant fish — but he always outsmarted those who tried to harm him.",
                "His bravery reached the king's court and Tom was made a royal knight. The tiny boy proved that courage and quick thinking matter far more than size."
             ],
             contentTR: [
                "Fakir bir çift, başparmak kadar bile olsa bir çocuk istedi. Dilekleri yerine getirildi — bir başparmak kadar küçük bir erkek bebek doğdu. Adını Küçük Tom koydular.",
                "Boyutuna rağmen Tom zeki ve cesaretliydi. Atın kulağına girerek yön vererek tarlada babasına yardım etti.",
                "Tom pek çok macera yaşadı — inek yuttu, bir karga taşıdı ve devasa bir balık yuttu — ama her zaman ona zarar vermeye çalışanları geçti.",
                "Cesareti krallık sarayına ulaştı ve Tom bir saray şövalyesi yapıldı. Küçük çocuk, cesaretin ve hızlı düşüncenin boyuttan çok daha önemli olduğunu kanıtladı."
             ],
             coverEmoji: "👍", coverColorHex: "3498DB", coverImageName: nil, category: .fairyTale, isFree: false, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "The Snow Queen", titleTR: "Kar Kraliçesi",
             contentEN: [
                "A wicked troll made a mirror that made everything look bad and ugly. It shattered and splinters entered people's hearts and eyes, making them cold.",
                "Kay, a young boy, got a splinter in his eye and heart. He became cold and mean. The Snow Queen took him to her icy palace far in the north.",
                "His best friend Gerda searched the whole world for him. She faced many dangers and adventures, guided by love and courage.",
                "Gerda found Kay in the Snow Queen's palace. Her warm tears of love melted the splinter from his heart. Kay remembered everything, and together they returned home."
             ],
             contentTR: [
                "Kötü bir trol her şeyi kötü ve çirkin gösteren bir ayna yaptı. Parçalandı ve kıymıklar insanların kalplerine ve gözlerine girdi, onları soğuk yaptı.",
                "Genç bir çocuk olan Kay'ın gözüne ve kalbine bir kıymık girdi. Soğuk ve kötü biri haline geldi. Kar Kraliçesi onu uzak kuzeydeki buz sarayına götürdü.",
                "En iyi arkadaşı Gerda onu tüm dünyada aradı. Sevgi ve cesaretle rehberlik ederek pek çok tehlikeyle ve macerayla karşılaştı.",
                "Gerda, Kay'ı Kar Kraliçesi'nin sarayında buldu. Sıcak sevgi gözyaşları kalbindeki kıymığı eritti. Kay her şeyi hatırladı ve birlikte eve döndüler."
             ],
             coverEmoji: "❄️", coverColorHex: "AED6F1", coverImageName: "cover_snowqueen", category: .fairyTale, isFree: false, readingTimeMinutes: 6),

        Book(id: UUID(), titleEN: "Thumbelina", titleTR: "Parmak Çocuk",
             contentEN: [
                "A woman planted a magic seed that grew into a flower. Inside the flower was a tiny girl no bigger than a thumb, named Thumbelina.",
                "A toad kidnapped her to marry her son. She escaped, but faced many hardships — captured by a beetle, almost forced to marry a mole.",
                "A swallow she had helped in winter flew her to a warm land full of flowers. There she met the tiny fairy prince of the flowers.",
                "The fairy prince loved Thumbelina at first sight. She received wings and a crown, and became queen of the flower fairies, living happily in her perfect-sized world."
             ],
             contentTR: [
                "Bir kadın sihirli bir tohum ekti ve bir çiçek büyüdü. Çiçeğin içinde bir başparmak kadar küçük bir kız vardı, adı Parmak Çocuk'tu.",
                "Bir kurbağa onu oğluyla evlendirmek için kaçırdı. Kaçtı ama pek çok güçlükle karşılaştı — bir böcek yakaladı, bir köstebeğe neredeyse evlendirildi.",
                "Kışın yardım ettiği bir kırlangıç onu çiçeklerle dolu ılık bir ülkeye uçurdu. Orada küçük çiçek peri prensini tanıdı.",
                "Çiçek peri prensi Parmak Çocuk'a ilk görüşte aşık oldu. Kanatlar ve taç aldı; çiçek perilerinin kraliçesi oldu ve mükemmel boyutlu dünyasında mutlu yaşadı."
             ],
             coverEmoji: "🌸", coverColorHex: "F8BBD9", coverImageName: "cover_thumbelina", category: .fairyTale, isFree: false, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "The Twelve Dancing Princesses", titleTR: "On İki Dans Eden Prenses",
             contentEN: [
                "Twelve princesses slept in a locked room each night, yet every morning their dancing shoes were worn through. The king promised that whoever discovered the secret could marry any princess.",
                "Many princes tried and failed, falling into a magical sleep. A poor soldier received a magic cloak from an old woman and followed the princesses.",
                "Each night he followed them through a secret passage to an underground kingdom where they danced with twelve princes until dawn.",
                "On the third night he broke a branch as proof. He revealed the secret to the king. The enchantment was broken, and he chose the eldest princess as his bride."
             ],
             contentTR: [
                "On iki prenses her gece kilitli bir odada uyudu, ama her sabah dans ayakkabıları yıpranmış çıktı. Kral, sırrı çözene herhangi bir prensisle evlenebileceğini vaat etti.",
                "Pek çok prens denedi ve başarısız oldu, sihirli uykuya daldı. Fakir bir asker yaşlı bir kadından sihirli bir pelerin aldı ve prensesleri takip etti.",
                "Her gece şafağa kadar on iki prensin dans ettiği yeraltı krallığına giden gizli bir geçitten onları izledi.",
                "Üçüncü gecede kanıt olarak bir dal kırdı. Sırrı krala açıkladı. Büyü bozuldu ve en büyük prensesi kendine gelin olarak seçti."
             ],
             coverEmoji: "💃", coverColorHex: "9B59B6", coverImageName: nil, category: .fairyTale, isFree: false, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "The Brave Little Tailor", titleTR: "Cesur Küçük Terzi",
             contentEN: [
                "A tailor killed seven flies with one slap and sewed on his belt 'Seven at one blow'. People thought he meant seven men and feared him greatly.",
                "The king sent him on impossible tasks: kill two giants, catch a wild unicorn, trap a wild boar. The clever tailor outwitted them all with tricks.",
                "He tricked the giants into fighting each other. He pinned the unicorn's horn to a tree. He chased the boar into a chapel and locked it in.",
                "Impressed beyond measure, the king gave him his daughter's hand. The tailor became a prince and proved that a sharp mind is greater than brute strength."
             ],
             contentTR: [
                "Bir terzi tek bir tokatta yedi sinek öldürdü ve kemеrine 'Tek vuruşta yedi' yazdı. İnsanlar yedi adam demek sandı ve ondan çok korktular.",
                "Kral onu imkânsız görevlere gönderdi: iki dev öldür, vahşi bir tekboynuz yakala, yabani domuzu tuzağa düşür. Zeki terzi hepsini hilelerle geçti.",
                "Devleri birbirleriyle savaştırarak kandırdı. Tekboynuzun boynuzunu ağaca sabitledi. Domuzu bir şapele kovalayıp içeri kilitledi.",
                "Son derece etkilenen kral ona kızını verdi. Terzi bir prens oldu ve keskin aklın kaba kuvvetten daha güçlü olduğunu kanıtladı."
             ],
             coverEmoji: "✂️", coverColorHex: "E74C3C", coverImageName: nil, category: .fairyTale, isFree: false, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "Mother Holle", titleTR: "Holle Ana",
             contentEN: [
                "Two sisters lived together — one hardworking and one lazy. The hardworking girl fell into a well and found herself in another world.",
                "She worked diligently for Mother Holle, shaking the bed so that feathers fell like snow on earth. Mother Holle rewarded her with gold when she returned.",
                "The lazy sister jumped into the well hoping for the same reward. But she was idle and careless in Mother Holle's service.",
                "When she returned, pitch black tar fell over her instead of gold. The hardworking girl's kindness was rewarded while laziness brought its own punishment."
             ],
             contentTR: [
                "İki kız kardeş birlikte yaşıyordu — biri çalışkan, biri tembel. Çalışkan kız bir kuyuya düşerek başka bir dünyada buldu kendini.",
                "Holle Ana'nın yanında özenle çalıştı, yatağı silkleyerek yeryüzüne kar gibi tüy düşürdü. Holle Ana dönerken onu altınla ödüllendirdi.",
                "Tembel kız kardeş aynı ödülü umarak kuyuya atladı. Ama Holle Ana'nın yanında tembel ve dikkatsizdi.",
                "Dönerken altın yerine üzerine kapkara zift döküldü. Çalışkan kızın iyiliği ödüllendirilirken tembelliğin kendi cezasını getirdiği görüldü."
             ],
             coverEmoji: "❄️", coverColorHex: "BDC3C7", coverImageName: nil, category: .fairyTale, isFree: false, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "The Golden Bird", titleTR: "Altın Kuş",
             contentEN: [
                "A king's golden apple tree was robbed each night by a golden bird. He sent his three sons to catch it. The first two fell asleep; only the youngest stayed awake.",
                "A fox guided the youngest prince on a quest for the golden bird. The prince had to resist temptation and follow the fox's advice exactly.",
                "With the fox's help, he found the golden bird, the golden horse, and rescued a beautiful princess.",
                "His jealous brothers betrayed him, but the fox saved him once more. In the end the prince had the bird, horse, princess, and his brothers were punished for their treachery."
             ],
             contentTR: [
                "Bir kralın altın elma ağacı her gece altın bir kuş tarafından soyuluyordu. Üç oğlunu yakalamak için gönderdi. İlk ikisi uyudu; sadece en küçüğü uyanık kaldı.",
                "Bir tilki en küçük prense altın kuş arayışında rehberlik etti. Prens cazibeye direnmek ve tilkinin tavsiyesine tam olarak uymak zorundaydı.",
                "Tilkinin yardımıyla altın kuşu, altın atı buldu ve güzel bir prensesi kurtardı.",
                "Kıskanç kardeşleri onu ihanet etti ama tilki onu bir kez daha kurtardı. Sonunda prens kuş, at, prenses ve kardeşlerini ihanetleri için cezalandırdı."
             ],
             coverEmoji: "🦅", coverColorHex: "F1C40F", coverImageName: nil, category: .fairyTale, isFree: false, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "Ali Baba and the Forty Thieves", titleTR: "Ali Baba ve Kırk Haramiler",
             contentEN: [
                "Ali Baba was a poor woodcutter who discovered the secret cave of forty thieves. He heard the magic words 'Open Sesame!' and found unimaginable treasure inside.",
                "His greedy brother Cassim also entered the cave but forgot the magic words. He was trapped and killed by the returning thieves.",
                "The thieves tried many tricks to find and kill Ali Baba. But his clever slave girl Morgiana always outsmarted them, even killing the disguised thief captain.",
                "Morgiana's bravery saved Ali Baba's life many times. He rewarded her with freedom and marriage into his family. They lived securely and prosperously ever after."
             ],
             contentTR: [
                "Ali Baba, kırk haraminin gizli mağarasını keşfeden fakir bir oduncuydu. 'Açıl Susam Açıl!' sihirli kelimelerini duydu ve içeride hayal edilemez bir hazine buldu.",
                "Açgözlü kardeşi Kassim de mağaraya girdi ama sihirli kelimeleri unuttu. Geri dönen haramiler tarafından tuzağa düşürüldü ve öldürüldü.",
                "Haramiler Ali Baba'yı bulmak ve öldürmek için pek çok numara denedi. Ama zeki cariye Morgiana her zaman onları geçti, hatta kılık değiştirmiş harami reisini bile öldürdü.",
                "Morgiana'nın cesareti Ali Baba'nın hayatını defalarca kurtardı. O da onu özgürlükle ve ailesine evlilikle ödüllendirdi. Sonsuza dek güvenli ve müreffeh yaşadılar."
             ],
             coverEmoji: "🏺", coverColorHex: "D4AC0D", coverImageName: nil, category: .adventure, isFree: false, readingTimeMinutes: 6),

        Book(id: UUID(), titleEN: "Aladdin and the Magic Lamp", titleTR: "Aladdin ve Sihirli Lamba",
             contentEN: [
                "Aladdin was a poor boy tricked by a sorcerer into entering a magic cave to retrieve an oil lamp. He became trapped when he refused to hand over the lamp.",
                "In the cave he found a ring that summoned a genie. The genie helped him escape. At home his mother rubbed the old lamp, releasing an even more powerful genie.",
                "The genie of the lamp granted Aladdin's wishes — wealth, a palace, and the hand of the princess. But the sorcerer stole the lamp and took everything away.",
                "Aladdin used the ring genie to get back the lamp, defeated the sorcerer, and restored everything. He and the princess lived happily, with Aladdin ruling wisely."
             ],
             contentTR: [
                "Aladdin, bir sihirbaz tarafından sihirli bir mağaraya bir yağ lambası almaya kandırılan fakir bir çocuktu. Lambayı teslim etmeyi reddedince mahsur kaldı.",
                "Mağarada bir cin çağıran yüzük buldu. Cin kaçmasına yardım etti. Evde annesi eski lambayı ovuşturdu ve çok daha güçlü bir cin çıkardı.",
                "Lambanın cini Aladdin'in dileklerini gerçekleştirdi — zenginlik, bir saray ve prensesin eli. Ama sihirbaz lambayı çalarak her şeyi götürdü.",
                "Aladdin yüzük cini ile lambayı geri aldı, sihirbazı yendi ve her şeyi geri getirdi. Prensesle mutlu yaşadılar ve Aladdin bilgece hükmetti."
             ],
             coverEmoji: "🪔", coverColorHex: "F39C12", coverImageName: nil, category: .adventure, isFree: false, readingTimeMinutes: 6),

        Book(id: UUID(), titleEN: "Sinbad the Sailor", titleTR: "Denizci Sinbad",
             contentEN: [
                "Sinbad was a merchant who went on seven amazing voyages across the seas. On his first voyage, he landed on what he thought was an island — it was actually a giant sleeping whale!",
                "On other voyages he encountered the Valley of Diamonds, the giant Roc bird, and the Old Man of the Sea who clung to his shoulders.",
                "Each voyage brought new dangers and wonders. Sinbad survived through courage, wit, and a little luck, always returning home with great treasures.",
                "After his seventh and final voyage, Sinbad returned home wealthy and wise, grateful for every adventure that had shaped him into the great sailor he became."
             ],
             contentTR: [
                "Sinbad denizlerde yedi muhteşem yolculuğa çıkan bir tüccardı. İlk yolculuğunda ada sandığı yere indi — aslında uyuyan devasa bir balinaymiş!",
                "Diğer yolculuklarda Elmas Vadisi, devasa Ruh kuşu ve omuzlarına yapışan Denizin Yaşlı Adamı ile karşılaştı.",
                "Her yolculuk yeni tehlikeler ve mucizeler getirdi. Sinbad cesaret, zeka ve biraz şansla hayatta kaldı, her zaman büyük hazinelerle eve döndü.",
                "Yedinci ve son yolculuğundan sonra Sinbad zengin ve bilge bir şekilde eve döndü; onu büyük denizci yapan her maceraya şükran duydu."
             ],
             coverEmoji: "⛵", coverColorHex: "2980B9", coverImageName: nil, category: .adventure, isFree: false, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "The Tortoise and the Hare", titleTR: "Kaplumbağa ve Tavşan",
             contentEN: [
                "A speedy hare always boasted about how fast he was. The slow tortoise grew tired of his bragging and challenged him to a race.",
                "The hare laughed but accepted. When the race began, the hare shot off like lightning while the tortoise plodded slowly but steadily.",
                "Halfway through, the hare was so far ahead that he decided to take a nap. He fell into a deep sleep under a tree.",
                "The tortoise never stopped. One slow step at a time, he crossed the finish line. The hare woke up and ran, but it was too late. Slow and steady wins the race!"
             ],
             contentTR: [
                "Hızlı tavşan her zaman ne kadar süratli olduğunu övünürdü. Yavaş kaplumbağa böbürlenmesinden bıktı ve onu yarışa davet etti.",
                "Tavşan güldü ama kabul etti. Yarış başlayınca tavşan şimşek gibi fırladı, kaplumbağa ise yavaş ama istikrarlı adımlarla ilerledi.",
                "Yarı yolda tavşan çok önündeydi ve şekerleme yapmaya karar verdi. Bir ağacın altında derin uykuya daldı.",
                "Kaplumbağa hiç durmadı. Bir yavaş adım bir adım daha, bitiş çizgisini geçti. Tavşan uyandı ve koştu ama çok geçti. Yavaş ve istikrarlı yarışı kazanır!"
             ],
             coverEmoji: "🐢", coverColorHex: "2ECC71", coverImageName: nil, category: .fable, isFree: false, readingTimeMinutes: 3),

        Book(id: UUID(), titleEN: "The Fox and the Crow", titleTR: "Tilki ve Karga",
             contentEN: [
                "A crow found a big piece of cheese and sat in a tree to enjoy it. A sly fox spotted the cheese and wanted it for himself.",
                "The fox looked up and said, 'Oh Crow, you are the most beautiful bird I've ever seen! Your feathers shine like midnight. Surely your voice must be as lovely as your looks!'",
                "The foolish crow, flattered by the compliments, opened her beak wide to sing. The cheese fell straight down and the fox snatched it up.",
                "As he ran off eating the cheese, the fox called back, 'That's all I wanted, dear Crow. Beware of those who flatter you — they may want something in return!'"
             ],
             contentTR: [
                "Bir karga büyük bir peynir parçası buldu ve onu yemek için ağaca kondu. Kurnaz bir tilki peyniri gördü ve onu kendisi için istedi.",
                "Tilki yukarı bakarak dedi ki, 'Ey Karga, seni gördüğüm en güzel kuşsun! Tüylerin gece gibi parıldıyor. Sesin görünüşün kadar güzel olmalı!'",
                "Pohpohlanan ahmak karga, şarkı söylemek için gagasını sonuna kadar açtı. Peynir dümdüz aşağı düştü ve tilki onu kapmak için atladı.",
                "Peyniri yerken kaçarken tilki geri bağırdı, 'Tek istediğim buydu, aziz Karga. Seni pohpohlayanlardan sakın — karşılığında bir şey isteyebilirler!'"
             ],
             coverEmoji: "🦊", coverColorHex: "E67E22", coverImageName: nil, category: .fable, isFree: false, readingTimeMinutes: 3),

        Book(id: UUID(), titleEN: "The Lion and the Mouse", titleTR: "Aslan ve Fare",
             contentEN: [
                "A tiny mouse accidentally ran over a sleeping lion's paw. The lion woke up furious and caught the mouse in his massive paw, ready to eat him.",
                "'Please spare me!' squeaked the mouse. 'One day I may be able to help you!' The lion laughed — how could a tiny mouse help the king of beasts? But he let the mouse go.",
                "Days later the lion was trapped in a hunter's net, roaring helplessly. The little mouse heard him and came running.",
                "With his sharp little teeth, the mouse gnawed through the ropes until the lion was free. 'You laughed at me,' said the mouse, 'but even small friends can be great friends.'"
             ],
             contentTR: [
                "Küçük bir fare yanlışlıkla uyuyan bir aslanın pençesinin üzerinden geçti. Aslan öfkeyle uyandı ve fareyi devasa pençesinde yakaladı, yemek üzereydi.",
                "'Lütfen bağışla beni!' diye cıyıkladı fare. 'Bir gün yardımcı olabilirim!' Aslan güldü — küçücük bir fare hayvanların kralına nasıl yardım ederdi? Ama fareyi bıraktı.",
                "Günler sonra aslan bir avcının ağında mahsur kaldı, çaresizce kükrüyordu. Küçük fare onu duydu ve koştu.",
                "Keskin küçük dişleriyle aslan özgür olana kadar ipleri kemirdi. 'Benimle alay ettin,' dedi fare, 'ama küçük dostlar da büyük dost olabilir.'"
             ],
             coverEmoji: "🦁", coverColorHex: "F39C12", coverImageName: nil, category: .fable, isFree: false, readingTimeMinutes: 3),

        Book(id: UUID(), titleEN: "The Ant and the Grasshopper", titleTR: "Karınca ve Çekirge",
             contentEN: [
                "All summer long the ant worked hard, carrying food grain by grain to store for winter. The grasshopper played music and mocked the ant for working so hard on beautiful days.",
                "'Come and play!' sang the grasshopper. 'There is plenty of time to work!' The ant shook her head and kept working.",
                "When winter came, the ground was frozen and there was nothing to eat. The grasshopper was cold and starving. He knocked on the ant's door and begged for food.",
                "The ant looked at him and said, 'I worked all summer while you played. Now I have food and you have none.' It is best to prepare for the days of need while times are good."
             ],
             contentTR: [
                "Tüm yaz boyunca karınca sert çalıştı, kışa stok yapmak için tahıl tanesi taşıdı. Çekirge müzik çalarak güzel günlerde bu kadar sert çalıştığı için karıncayla alay etti.",
                "'Gel oyna!' diye şarkı söyledi çekirge. 'Çalışmak için bol zaman var!' Karınca başını salladı ve çalışmaya devam etti.",
                "Kış gelince toprak donmuş ve yiyecek yoktu. Çekirge soğuk ve açtı. Karıncanın kapısına vurdu ve yiyecek dilendi.",
                "Karınca ona bakarak dedi, 'Sen oynarken ben bütün yaz çalıştım. Şimdi bende yiyecek var, sende yok.' İyi günlerde ihtiyaç günleri için hazırlamak en iyisidir."
             ],
             coverEmoji: "🐜", coverColorHex: "8B4513", coverImageName: nil, category: .fable, isFree: false, readingTimeMinutes: 3),

        Book(id: UUID(), titleEN: "The Boy Who Cried Wolf", titleTR: "Kurt Diye Bağıran Çoban",
             contentEN: [
                "A young shepherd boy watched over the village's sheep on the hillside. Bored and lonely, he thought of a way to have some fun and get attention.",
                "He ran down to the village crying, 'Wolf! Wolf! The wolf is chasing the sheep!' The villagers rushed up with pitchforks, but there was no wolf. The boy laughed.",
                "He played the same trick again the next day, and the villagers came running again. They were very angry to be fooled twice.",
                "Then a real wolf came. The boy cried 'Wolf! Wolf!' but nobody came. The wolf scattered the sheep. The boy learned that nobody believes a liar, even when he tells the truth."
             ],
             contentTR: [
                "Genç bir çoban tepede köyün koyunlarına baktı. Sıkılmış ve yalnız bir şekilde eğlenmenin ve dikkat çekmenin bir yolunu düşündü.",
                "Köye koşarak bağırdı, 'Kurt! Kurt! Kurt koyunları kovalıyor!' Köylüler yaba ile koştular ama kurt yoktu. Çocuk güldü.",
                "Ertesi gün aynı numarayı oynadı ve köylüler yeniden koştular. İki kez kandırılmaktan çok kızgındılar.",
                "Sonra gerçek bir kurt geldi. Çocuk 'Kurt! Kurt!' diye bağırdı ama kimse gelmedi. Kurt koyunları dağıttı. Çocuk gerçeği söylese bile yalancıya kimsenin inanmadığını öğrendi."
             ],
             coverEmoji: "🐑", coverColorHex: "95A5A6", coverImageName: nil, category: .fable, isFree: false, readingTimeMinutes: 3),

        Book(id: UUID(), titleEN: "The Fox and the Grapes", titleTR: "Tilki ve Üzümler",
             contentEN: [
                "A hungry fox spotted a bunch of beautiful ripe grapes hanging high on a vine. His mouth watered and he decided he had to have them.",
                "He ran and jumped, but the grapes were just out of reach. He tried again and again, leaping as high as he could.",
                "After many failed attempts, the fox sat down exhausted and looked up at the grapes. They were still perfectly out of reach.",
                "'Those grapes are probably sour anyway!' he said to himself and walked away with his nose in the air. It is easy to dismiss what you cannot have."
             ],
             contentTR: [
                "Aç bir tilki asmada yüksekte sallanan güzel olgun bir üzüm salkımı gördü. Ağzı sulandı ve onlara sahip olması gerektiğine karar verdi.",
                "Koştu ve zıpladı ama üzümler tam ulaşamayacağı yerdeydiler. Elinden geldiğince yükseğe sıçrayarak tekrar tekrar denedi.",
                "Pek çok başarısız denemeden sonra tilki yorgun bir şekilde oturdu ve üzümlere baktı. Hâlâ tam ulaşamayacağı bir yerdeydiler.",
                "'O üzümler zaten ekşiydi!' dedi kendine ve burnu havada uzaklaştı. Sahip olamadıklarını küçümsemek kolaydır."
             ],
             coverEmoji: "🍇", coverColorHex: "8E44AD", coverImageName: nil, category: .fable, isFree: false, readingTimeMinutes: 2),

        Book(id: UUID(), titleEN: "The Goose That Laid the Golden Eggs", titleTR: "Altın Yumurtlayan Kaz",
             contentEN: [
                "A farmer and his wife owned an ordinary goose. One morning they were astonished to find a glittering golden egg in her nest. It was pure gold!",
                "Every single morning the goose laid one golden egg. The farmer and wife became rich selling the eggs. But they grew impatient wanting more gold faster.",
                "'The goose must be full of gold inside!' said the farmer greedily. They decided to cut the goose open to get all the gold at once.",
                "But inside the goose there was nothing but ordinary goose. They had killed their golden goose. They had nothing left. Greed destroys what it cannot wait for."
             ],
             contentTR: [
                "Bir çiftçi ve karısının sıradan bir kazı vardı. Bir sabah yuvada pırıl pırıl parlayan altın bir yumurta bulunca şaşırdılar. Saf altındı!",
                "Her sabah kaz bir altın yumurta yumurtladı. Çiftçi ve karısı yumurtaları satarak zenginleştiler. Ama daha hızlı daha fazla altın isterek sabırsızlandılar.",
                "'Kazın içi altın dolu olmalı!' dedi çiftçi açgözlüce. Tüm altını bir seferde almak için kazı kesmeye karar verdiler.",
                "Ama kazın içinde sıradan bir kazdan başka bir şey yoktu. Altın kazlarını öldürmüşlerdi. Geriye hiçbir şey kalmadı. Açgözlülük, bekleyemediği şeyi yok eder."
             ],
             coverEmoji: "🥚", coverColorHex: "F1C40F", coverImageName: nil, category: .fable, isFree: false, readingTimeMinutes: 3),

        Book(id: UUID(), titleEN: "The Wind and the Sun", titleTR: "Rüzgar ve Güneş",
             contentEN: [
                "The Wind and the Sun argued about which of them was stronger. They decided to settle it with a contest: whoever could make a traveller remove his coat would be the winner.",
                "The Wind went first. He blew harder and harder, sending gusts and gales at the traveller. But the harder the Wind blew, the tighter the man pulled his coat around him.",
                "Then the Sun took his turn. He shone gently and warmly on the traveller. The man felt the warmth and relaxed.",
                "Soon the traveller was too warm and he took off his coat happily. The Sun had won. Gentleness and warmth accomplish more than force and anger ever can."
             ],
             contentTR: [
                "Rüzgar ve Güneş hangisinin daha güçlü olduğunu tartıştı. Bir yarışmayla çözmeye karar verdiler: yolcunun paltosunu çıkartmayı başaran kazanacaktı.",
                "Önce Rüzgar başladı. Yolcuya giderek daha güçlü fırtınalar ve kasırgalar gönderdi. Ama Rüzgar ne kadar sert eserse adam paltosunu o kadar sıkı sardı.",
                "Sonra Güneş sırasını aldı. Yolcuya nazikçe ve sıcakça parladı. Adam sıcaklığı hissetti ve rahatlayarak gülümsedi.",
                "Çok geçmeden yolcu çok ısındı ve paltosunu mutlu bir şekilde çıkardı. Güneş kazanmıştı. Yumuşaklık ve sıcaklık, kuvvet ve öfkenin yapabileceğinden çok daha fazlasını başarır."
             ],
             coverEmoji: "☀️", coverColorHex: "F39C12", coverImageName: nil, category: .fable, isFree: false, readingTimeMinutes: 3),

        Book(id: UUID(), titleEN: "The Crow and the Pitcher", titleTR: "Karga ve Testi",
             contentEN: [
                "A thirsty crow found a pitcher with a little water at the bottom. But the pitcher was tall and narrow, and no matter how hard the crow tried, he couldn't reach the water.",
                "The crow thought carefully. He looked around and saw pebbles on the ground. A clever idea came to him.",
                "One by one he picked up the pebbles and dropped them into the pitcher. Slowly the water level rose higher and higher.",
                "At last the water was high enough for the crow to drink. He quenched his thirst with a satisfied caw. Necessity is the mother of invention — think before you give up!"
             ],
             contentTR: [
                "Susayan bir karga dibinde biraz su olan bir testi buldu. Ama testi uzun ve dardı; karga ne kadar çabalasa da suya ulaşamıyordu.",
                "Karga dikkatlice düşündü. Etrafına bakarak yerde çakıl taşları gördü. Aklına zekice bir fikir geldi.",
                "Teker teker çakıl taşları alıp testiye attı. Yavaş yavaş su seviyesi yükseldi ve yükseldi.",
                "Sonunda su karganın içebileceği kadar yükselmişti. Tatmin olmuş bir ganıltıyla susuzluğunu giderdi. İhtiyaç icadın anasıdır — pes etmeden önce düşün!"
             ],
             coverEmoji: "🪨", coverColorHex: "7F8C8D", coverImageName: nil, category: .fable, isFree: false, readingTimeMinutes: 3),

        Book(id: UUID(), titleEN: "The Dog and His Reflection", titleTR: "Köpek ve Yansıması",
             contentEN: [
                "A dog found a juicy bone and was carrying it home happily in his mouth. He had to cross a bridge over a stream to get there.",
                "When he looked down into the clear water, he saw what appeared to be another dog with a bone in its mouth — bigger than his!",
                "Greedy for the bigger bone, he snapped at the reflection. Of course the moment he opened his mouth, his own bone fell into the water and sank.",
                "Now he had no bone at all. Wanting what others have can cause you to lose what you already possess. Greediness never pays."
             ],
             contentTR: [
                "Bir köpek sulu bir kemik buldu ve onu ağzında mutlu bir şekilde eve taşıyordu. Oraya ulaşmak için bir dere köprüsünden geçmesi gerekiyordu.",
                "Berrak suya aşağı baktığında ağzında kemik tutan başka bir köpek gördü — kendininkinden daha büyük!",
                "Daha büyük kemik için açgözlüce yansımaya hücum etti. Tabii ağzını açtığı an kendi kemiği suya düştü ve battı.",
                "Artık hiç kemiği yoktu. Başkalarının sahip olduğunu istemek, zaten sahip olduğunu kaybetmene neden olabilir. Açgözlülük asla işe yaramaz."
             ],
             coverEmoji: "🐕", coverColorHex: "CD853F", coverImageName: nil, category: .fable, isFree: false, readingTimeMinutes: 3),

        Book(id: UUID(), titleEN: "Nasreddin Hodja: The Cauldron", titleTR: "Nasreddin Hoca: Kazan",
             contentEN: [
                "Nasreddin Hodja once borrowed a cauldron from his neighbour. After a while he returned it with a small pot inside.",
                "'What is this little pot?' asked the neighbour. Hodja smiled and said, 'Your cauldron gave birth while it was at my house!'",
                "The neighbour, delighted at the extra pot, accepted the story without question. Some time later, Hodja borrowed the cauldron again.",
                "This time Hodja didn't return it. When the neighbour asked, Hodja said sadly, 'I have terrible news — your cauldron has died.' The neighbour cried, 'Cauldrons don't die!' 'You believed it could give birth,' said Hodja, 'so why not die?'"
             ],
             contentTR: [
                "Nasreddin Hoca bir keresinde komşusundan bir kazan ödünç aldı. Bir süre sonra içinde küçük bir tencereyle iade etti.",
                "'Bu küçük tencere ne?' diye sordu komşusu. Hoca güldü ve dedi, 'Kazanınız bende iken doğurdu!'",
                "Ekstra tencereden memnun olan komşusu hikâyeyi sorgulamadan kabul etti. Bir süre sonra Hoca kazanı yeniden ödünç aldı.",
                "Bu sefer Hoca iade etmedi. Komşu sorunca Hoca üzülerek dedi, 'Korkunç bir haberim var — kazanınız öldü.' Komşu bağırdı, 'Kazanlar ölmez!' 'Doğurabileceğine inandın,' dedi Hoca, 'peki neden ölmesin?'"
             ],
             coverEmoji: "🫕", coverColorHex: "C0392B", coverImageName: nil, category: .turkish, isFree: false, readingTimeMinutes: 3),

        Book(id: UUID(), titleEN: "Nasreddin Hodja: The Donkey", titleTR: "Nasreddin Hoca: Eşek",
             contentEN: [
                "One day Nasreddin Hodja was riding his donkey backwards, facing the tail. People called out, 'Hodja! You're sitting the wrong way!'",
                "Hodja calmly replied, 'You are mistaken. I am sitting perfectly correctly. It is the donkey that is going the wrong way.'",
                "Another time, Hodja was searching for his donkey in the village square. 'What are you looking for?' asked a neighbour. 'My donkey,' said Hodja.",
                "'But you are riding your donkey right now!' said the neighbour. Hodja looked down and said, 'Ah! Thank goodness I started looking for him — imagine if I hadn't found him so quickly!'"
             ],
             contentTR: [
                "Bir gün Nasreddin Hoca eşeğine ters binerek, kuyruğuna bakacak şekilde gidiyordu. İnsanlar bağırdı, 'Hoca! Yanlış yönde oturuyorsun!'",
                "Hoca sakin bir şekilde yanıtladı, 'Yanılıyorsunuz. Ben tam doğru oturuyorum. Yanlış yöne giden eşek.'",
                "Bir başka seferinde Hoca köy meydanında eşeğini arıyordu. 'Ne arıyorsun?' diye sordu bir komşusu. 'Eşeğimi,' dedi Hoca.",
                "'Ama şu an eşeğinin üzerine biniyorsun!' dedi komşusu. Hoca aşağı bakarak dedi, 'Ah! Şükürler olsun ki onu aramaya başladım — onu bu kadar çabuk bulmasaydım ne olurdu!'"
             ],
             coverEmoji: "🫏", coverColorHex: "8B6914", coverImageName: nil, category: .turkish, isFree: false, readingTimeMinutes: 3),

        Book(id: UUID(), titleEN: "Keloğlan and the Witch", titleTR: "Keloğlan ve Cadı",
             contentEN: [
                "Keloğlan was a bald, clever boy who lived with his poor mother. One day he heard of a wicked witch who had stolen all the happiness from the nearby village.",
                "Armed with only his wits and his mother's warm bread, Keloğlan set off to face the witch. Many brave men had tried before and failed.",
                "Keloğlan tricked the witch by praising her ugly reflection and convincing her she was beautiful. Distracted by vanity, the witch lowered her guard.",
                "Keloğlan grabbed the bag of happiness the witch had stolen and ran home. He returned happiness to the village and was celebrated as a hero — proving cleverness beats cruelty."
             ],
             contentTR: [
                "Keloğlan, fakir annesiyle yaşayan kel, zeki bir çocuktu. Bir gün yakındaki köyden tüm mutluluğu çalan kötü bir cadı olduğunu duydu.",
                "Yalnızca zekasıyla ve annesinin sıcak ekmeğiyle cadıyla yüzleşmeye gitti. Daha önce pek çok cesur adam denemişti ve başarısız olmuştu.",
                "Keloğlan çirkin yansımasını övüp güzel olduğuna inandırarak cadıyı kandırdı. Kibre kapılan cadı savunmasını indirdi.",
                "Keloğlan cadının çaldığı mutluluk torbasını kaptı ve eve koştu. Mutluluğu köye geri verdi ve kahraman olarak kutlandı — zekanın zalimliği yendiğini kanıtladı."
             ],
             coverEmoji: "🧙‍♀️", coverColorHex: "6C3483", coverImageName: nil, category: .turkish, isFree: false, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "Keloğlan and the Giant", titleTR: "Keloğlan ve Dev",
             contentEN: [
                "A giant terrorised the countryside, demanding food and treasure from every village. When he came to Keloğlan's village, the boy decided to stop him.",
                "Keloğlan challenged the giant to a squeezing contest. He secretly hid a piece of soft white cheese and pretended to squeeze water from a stone.",
                "The giant was amazed and tried to squeeze his own stone, but failed. 'How did you do that?' he asked. 'Practice!' said Keloğlan with a grin.",
                "The giant was so convinced of Keloğlan's superior strength that he fled and never returned. The clever boy had saved his village using only a piece of cheese and his imagination."
             ],
             contentTR: [
                "Bir dev her köyden yiyecek ve hazine talep ederek kırsal bölgeyi terörize ediyordu. Keloğlan'ın köyüne gelince çocuk onu durdurmaya karar verdi.",
                "Keloğlan devi sıkıştırma yarışmasına davet etti. Gizlice yumuşak beyaz peynir sakladı ve taştan su sıkıyormuş gibi yaptı.",
                "Dev şaşırdı ve kendi taşını sıkmaya çalıştı ama başarısız oldu. 'Bunu nasıl yaptın?' diye sordu. 'Pratik!' dedi Keloğlan sırıtarak.",
                "Dev, Keloğlan'ın üstün gücüne o kadar ikna oldu ki kaçıp bir daha gelmedi. Zeki çocuk yalnızca bir peynir parçası ve hayal gücüyle köyini kurtarmıştı."
             ],
             coverEmoji: "👹", coverColorHex: "E74C3C", coverImageName: nil, category: .turkish, isFree: false, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "The Magical Horse", titleTR: "Sihirli At",
             contentEN: [
                "A poor boy found an injured horse in the forest and nursed it back to health. The horse turned out to be magical and could speak.",
                "'I will grant you three wishes for your kindness,' said the horse. The boy wished for food for his family, a warm home, and a chance to prove himself to the king.",
                "With the horse's help, the boy solved impossible riddles the king had set. Other nobles had failed, but the clever boy with the magical horse succeeded.",
                "The king was so impressed that he made the boy a royal knight. The horse said goodbye, knowing the boy no longer needed magic — he had courage and kindness of his own."
             ],
             contentTR: [
                "Fakir bir çocuk ormanda yaralı bir at buldu ve iyileşmesine yardım etti. At sihirli olduğu ve konuşabildiği ortaya çıktı.",
                "'İyiliğin için sana üç dilek vereceğim,' dedi at. Çocuk ailesine yiyecek, sıcak bir ev ve kendini krala kanıtlama fırsatı istedi.",
                "Atın yardımıyla, kralın verdiği imkânsız bilmeceleri çözdü. Diğer soylular başarısız olurken sihirli ath ile zeki çocuk başardı.",
                "Kral çok etkilendi ve çocuğu krallık şövalyesi yaptı. At veda etti; çocuğun artık büyüye ihtiyacı olmadığını biliyordu — kendi cesaret ve iyiliği vardı."
             ],
             coverEmoji: "🐴", coverColorHex: "D35400", coverImageName: nil, category: .turkish, isFree: false, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "Ferdinand the Bull", titleTR: "Ferdinand Boğa",
             contentEN: [
                "Ferdinand was a large, strong bull who lived in Spain. While all the other bulls loved to run, butt heads, and show off, Ferdinand loved to sit quietly and smell the flowers.",
                "One day men came to choose the fiercest bull for the bullfight in Madrid. Ferdinand sat on a bumblebee by accident and jumped and snorted in pain.",
                "The men thought he was the fiercest bull of all and took him to Madrid. In the great arena, the matadors waved their capes, but Ferdinand just sat and smelled the flowers in the ladies' hair.",
                "Everyone was confused. They sent Ferdinand home. He sat under his favourite cork tree, smelling flowers, perfectly happy just being himself."
             ],
             contentTR: [
                "Ferdinand, İspanya'da yaşayan büyük ve güçlü bir boğaydı. Diğer tüm boğalar koşmayı, kafa tutmayı ve gösteriş yapmayı severken, Ferdinand sessizce oturup çiçeklerin kokusunu almayı severdi.",
                "Bir gün adamlar Madrid'deki boğa güreşi için en vahşi boğayı seçmeye geldi. Ferdinand yanlışlıkla bir yaban arısının üzerine oturdu ve acıyla zıplayıp hırıldadı.",
                "Adamlar onu en vahşi boğa sandılar ve Madrid'e götürdüler. Büyük arenada matadorlar pelerinlerini salladı, ama Ferdinand sadece oturarak hanımların saçlarındaki çiçekleri kokladı.",
                "Herkes şaşırdı. Ferdinand'ı eve gönderdiler. Favori mantar meşesinin altında oturdu, çiçekleri kokladı; sadece kendisi olduğu için tamamen mutluydu."
             ],
             coverEmoji: "🐂", coverColorHex: "8B4513", coverImageName: nil, category: .classic, isFree: false, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "The Velveteen Rabbit", titleTR: "Kadife Tavşan",
             contentEN: [
                "A velveteen rabbit was given to a boy for Christmas. At first he was left among the nursery toys. The wise old Skin Horse told him about becoming Real through love.",
                "The boy became ill and loved the rabbit dearly, carrying him everywhere. But when the boy recovered, the doctors ordered all his toys to be burned to prevent infection.",
                "The rabbit was put in a sack destined for burning. Alone in the garden, a real tear fell from his eye — and from that tear, a flower grew.",
                "A fairy appeared and told him his love had made him Real at last. She turned him into a real rabbit. In spring the boy saw a rabbit that reminded him of his old toy, and both were happy."
             ],
             contentTR: [
                "Noel için bir çocuğa kadife bir tavşan verildi. Başta diğer oyuncaklar arasında bırakıldı. Yaşlı ve bilge At Derisi, ona sevgi yoluyla Gerçek olmanın ne anlama geldiğini anlattı.",
                "Çocuk hastalandı ve tavşanı çok sevdi, onu her yere taşıdı. Ama çocuk iyileşince doktorlar enfeksiyonu önlemek için tüm oyuncaklarının yakılmasını emretti.",
                "Tavşan yakılmak üzere bir çuvala konuldu. Bahçede yalnız, gözünden gerçek bir gözyaşı düştü — ve o gözyaşından bir çiçek büyüdü.",
                "Bir peri belirdi ve ona sevgisinin onu sonunda Gerçek yaptığını söyledi. Onu gerçek bir tavşana dönüştürdü. İlkbaharda çocuk eski oyuncağını hatırlatan bir tavşan gördü ve ikisi de mutluydu."
             ],
             coverEmoji: "🐰", coverColorHex: "F4A460", coverImageName: nil, category: .classic, isFree: false, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "The Little Prince", titleTR: "Küçük Prens",
             contentEN: [
                "A pilot crashed in the Sahara Desert and met a mysterious little boy from a tiny planet called Asteroid B-612. The little prince had left his planet after arguing with his beloved rose.",
                "The little prince had visited many planets, each with one strange inhabitant — a king with no subjects, a vain man, a drunkard, a businessman — all grown-ups he found puzzling.",
                "On Earth he met a wise fox who taught him, 'What is essential is invisible to the eye. You are responsible for what you have tamed.'",
                "The prince needed to return to his planet and his rose. He let a snake bite him to shed his body and travel back as light. The pilot never forgot the little prince who taught him to see with the heart."
             ],
             contentTR: [
                "Bir pilot Sahra Çölü'ne düştü ve B-612 adlı küçük bir gezegenden gizemli küçük bir çocukla tanıştı. Küçük prens, sevgili gülüyle tartıştıktan sonra gezegeninden ayrılmıştı.",
                "Küçük prens pek çok gezegen ziyaret etmişti; her birinde garip birer sakin vardı — tebasız bir kral, kibirli bir adam, bir sarhoş, bir işadamı — hepsi şaşırtıcı bulduğu yetişkinlerdi.",
                "Yeryüzünde ona 'Önemli olan gözle görülmez. Evcilleştirdiklerinden sorumlusun' öğreten bilge bir tilkiyle tanıştı.",
                "Prens gezegenine ve gülüne dönmesi gerekiyordu. Bedeninden sıyrılıp ışık olarak geri dönmek için bir yılanın onu sokmasına izin verdi. Pilot, ona kalple görmeyi öğreten küçük prensi hiç unutmadı."
             ],
             coverEmoji: "⭐", coverColorHex: "F1C40F", coverImageName: nil, category: .classic, isFree: false, readingTimeMinutes: 6),

        Book(id: UUID(), titleEN: "Pinocchio", titleTR: "Pinokyo",
             contentEN: [
                "A woodcarver named Geppetto carved a wooden puppet and named him Pinocchio. That night the Blue Fairy brought the puppet to life, promising he could become a real boy if he proved himself brave, truthful, and unselfish.",
                "Pinocchio had many adventures and misadventures. Every time he told a lie, his nose grew longer. He was tricked by a Fox and a Cat, visited Pleasure Island, and made many bad choices.",
                "Geppetto went searching for Pinocchio and was swallowed by a giant shark. Pinocchio bravely went in after him and found his father inside the whale's belly.",
                "Together they escaped. Pinocchio's good deed proved his heart was true. The Blue Fairy appeared and turned him into a real boy at last. Geppetto wept with joy."
             ],
             contentTR: [
                "Geppetto adında bir oyma ustası tahta bir kukla oydu ve adını Pinokyo koydu. O gece Mavi Peri kuklayı hayata döndürdü; cesur, dürüst ve özgecil olduğunu kanıtlarsa gerçek bir çocuk olabileceğini vaat etti.",
                "Pinokyo pek çok macera ve talihsizlik yaşadı. Her yalan söyleyişinde burnu uzadı. Bir Tilki ve Kedi tarafından kandırıldı, Eğlence Adası'nı ziyaret etti ve pek çok kötü seçim yaptı.",
                "Geppetto Pinokyo'yu aramaya gitti ve devasa bir köpekbalığı tarafından yutuldu. Pinokyo cesurca onu aramaya gitti ve babasını balinanın karnında buldu.",
                "Birlikte kaçtılar. Pinokyo'nun iyi davranışı kalbinin gerçek olduğunu kanıtladı. Mavi Peri belirledi ve onu sonunda gerçek bir çocuğa dönüştürdü. Geppetto sevinçten ağladı."
             ],
             coverEmoji: "🪵", coverColorHex: "8B4513", coverImageName: "cover_pinocchio", category: .classic, isFree: false, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "Alice in Wonderland", titleTR: "Alice Harikalar Diyarında",
             contentEN: [
                "Alice was sitting by the river when she spotted a White Rabbit with a pocket watch hurrying past. Curious, she followed him down a rabbit hole and fell into a strange underground world.",
                "In Wonderland everything was topsy-turvy. She grew huge and tiny by eating and drinking things labelled 'EAT ME' and 'DRINK ME'. She met a Cheshire Cat, a Mad Hatter, and a caterpillar smoking a hookah.",
                "The terrifying Queen of Hearts kept shouting 'Off with their heads!' Alice had to navigate a mad croquet game and a trial where she was the accused.",
                "When Alice finally stood up to the Queen and her cards, she woke up — it had all been a dream. But Wonderland felt so real and she carried its magic in her heart forever."
             ],
             contentTR: [
                "Alice nehir kenarında otururken cep saatli Beyaz Tavşan'ın koşarak geçtiğini gördü. Merakla onu bir tavşan deliğinin içinden takip etti ve garip bir yeraltı dünyasına düştü.",
                "Harikalar Diyarı'nda her şey tepetaklaktı. 'YE BENİ' ve 'İÇ BENİ' etiketli şeyleri yiyip içerek kocaman büyüdü ve küçüldü. Cheshire Kedisi, Deli Şapkacı ve nargile içen bir tırtılla tanıştı.",
                "Korkunç Karo Kraliçesi 'Kellelerini kesin!' diye bağırdı durdu. Alice çılgın bir kroket oyununda ve suçlunun kendisi olduğu bir davada yolunu bulmak zorunda kaldı.",
                "Alice sonunda Kraliçe'ye ve iskambil kâğıtlarına karşı durduğunda uyandı — hepsi bir rüyaymış. Ama Harikalar Diyarı çok gerçek hissettirdi ve büyüsünü sonsuza dek kalbinde taşıdı."
             ],
             coverEmoji: "🐇", coverColorHex: "9B59B6", coverImageName: "cover_alice", category: .classic, isFree: false, readingTimeMinutes: 6),

        Book(id: UUID(), titleEN: "Peter Pan", titleTR: "Peter Pan",
             contentEN: [
                "Wendy, John, and Michael Darling were visited one night by Peter Pan, the boy who never grew up, and his fairy Tinker Bell. Peter taught them to fly with fairy dust and happy thoughts.",
                "They flew to Neverland, a magical island with mermaids, fairies, and the Lost Boys who lived under the ground. But danger lurked — the villainous Captain Hook wanted revenge on Peter.",
                "Captain Hook kidnapped the children. Peter Pan fought Hook in a dramatic sword battle on Hook's ship, sending the captain into the jaws of the ticking crocodile.",
                "The children returned home. Wendy grew up, as did her children and grandchildren — but Peter Pan never aged. He still visits children who believe, forever young, forever free."
             ],
             contentTR: [
                "Bir gece Wendy, John ve Michael Darling, hiç büyümeyen çocuk Peter Pan ve perisi Tinkerbell tarafından ziyaret edildi. Peter onlara peri tozu ve mutlu düşüncelerle uçmayı öğretti.",
                "Denizkızları, periler ve yerin altında yaşayan Kayıp Çocuklar'ın bulunduğu sihirli ada Asla-Asla Ülkesi'ne uçtular. Ama tehlike gizliydi — kötü Kaptan Çengel Peter'dan intikam almak istiyordu.",
                "Kaptan Çengel çocukları kaçırdı. Peter Pan, gemide çarpıcı bir kılıç düellosunda Çengel ile savaştı ve kaptanı tik tak tik tak eden timsahın ağzına gönderdi.",
                "Çocuklar eve döndü. Wendy büyüdü; çocukları ve torunları da öyle — ama Peter Pan hiç yaşlanmadı. Hâlâ inanan çocukları ziyaret ediyor, sonsuza kadar genç ve özgür."
             ],
             coverEmoji: "🧚", coverColorHex: "27AE60", coverImageName: nil, category: .classic, isFree: false, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "Winnie the Pooh", titleTR: "Winnie the Pooh",
             contentEN: [
                "Deep in the Hundred Acre Wood lived a small bear named Winnie the Pooh who loved honey above all things. He lived with his friends Piglet, Eeyore, Tigger, Rabbit, and Owl.",
                "Pooh was always getting into gentle adventures — getting stuck in Rabbit's door after eating too much honey, losing Eeyore's tail, or searching for a heffalump.",
                "His best friend was a boy named Christopher Robin who lived at the edge of the wood. Christopher Robin always believed in Pooh and helped him through every sticky situation.",
                "The adventures in the Hundred Acre Wood taught everyone that friendship, kindness, and a little bit of honey make every day wonderful. Pooh may have been a bear of very little brain, but his heart was enormous."
             ],
             contentTR: [
                "Yüz Dönümlük Orman'ın derinliklerinde her şeyden çok balı seven Winnie the Pooh adında küçük bir ayı yaşıyordu. Arkadaşları Piglet, Eeyore, Tigger, Tavşan ve Baykuş ile yaşıyordu.",
                "Pooh her zaman nazik maceralara karışırdı — çok fazla bal yedikten sonra Tavşan'ın kapısına sıkışmak, Eeyore'un kuyruğunu kaybetmek veya dev fil aramak gibi.",
                "En iyi arkadaşı ormanın kenarında yaşayan Christopher Robin adında bir çocuktu. Christopher Robin her zaman Pooh'a inandı ve her yapışkan durumda yardım etti.",
                "Yüz Dönümlük Orman'daki maceralar herkese arkadaşlık, iyilik ve biraz balın her günü muhteşem yaptığını öğretti. Pooh çok az beyinli bir ayı olabilirdi ama kalbi devasa büyüklükteydi."
             ],
             coverEmoji: "🍯", coverColorHex: "F39C12", coverImageName: "cover_winniepooh", category: .classic, isFree: false, readingTimeMinutes: 4),

        Book(id: UUID(), titleEN: "The Jungle Book", titleTR: "Orman Çocuğu",
             contentEN: [
                "A baby boy was found in the Indian jungle by a family of wolves, who raised him as their own. They named him Mowgli. The wise bear Baloo taught him the Law of the Jungle and the panther Bagheera protected him.",
                "The tiger Shere Khan hated humans and wanted to kill Mowgli. The Council of Animals debated whether a man-cub could live among them.",
                "Mowgli had adventures with the Bandar-log monkeys and King Louie. He discovered that humans used fire — the Red Flower — which all jungle creatures feared.",
                "When Shere Khan threatened the wolves, Mowgli used fire to defeat him. He was finally taken to the man-village. It was the right place for him, but the jungle remained in his heart forever."
             ],
             contentTR: [
                "Hindistan ormanında bir bebek bir kurt ailesi tarafından bulundu ve kendi çocukları gibi büyüttüler. Adını Mowgli koydular. Bilge ayı Baloo ona Orman Yasası'nı öğretti, panter Bagheera onu korudu.",
                "Kaplan Shere Khan insanları nefret ediyordu ve Mowgli'yi öldürmek istiyordu. Hayvanlar Konseyi insan yavrusunun aralarında yaşayıp yaşayamayacağını tartıştı.",
                "Mowgli Bandar-log maymunları ve Kral Louie ile maceralar yaşadı. İnsanların tüm orman yaratıklarının korktuğu ateşi — Kırmızı Çiçek — kullandığını keşfetti.",
                "Shere Khan kurdu tehdit edince Mowgli onu yenilgiye uğratmak için ateş kullandı. Sonunda insan köyüne getirildi. Orası onun için doğru yerdi ama orman sonsuza kadar kalbinde kaldı."
             ],
             coverEmoji: "🐯", coverColorHex: "E67E22", coverImageName: "cover_junglebook", category: .classic, isFree: false, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "Black Beauty", titleTR: "Siyah Güzel",
             contentEN: [
                "Black Beauty was a beautiful black horse born on a peaceful farm, raised with kindness and love. He learned that good manners and a gentle heart were more important than strength.",
                "As he was sold from owner to owner, Beauty experienced both kindness and cruelty. Some treated him with love and care, while others worked him to exhaustion.",
                "His best friend was a horse named Ginger who had been treated harshly all her life. Beauty tried to give her hope, but harsh treatment had broken her spirit.",
                "After many hardships, Beauty was finally bought by kind owners who recognised his worth. He spent his last years in a green meadow, peaceful and loved, sharing his story of the importance of kindness to animals."
             ],
             contentTR: [
                "Siyah Güzel, sakin bir çiftlikte doğmuş, sevgi ve nezaketle büyütülmüş güzel siyah bir attı. İyi huysuzluğun ve nazik kalbin güçten daha önemli olduğunu öğrendi.",
                "Sahibinden sahibine satılırken Güzel hem iyilik hem de zalimlik yaşadı. Bazıları onu sevgi ve özenle tedavi etti, bazıları ise onu yorgunluğa kadar çalıştırdı.",
                "En iyi arkadaşı hayatı boyunca sert muamele görmüş Zencefil adında bir attı. Güzel ona umut vermeye çalıştı ama sert muamele onun ruhunu kırmıştı.",
                "Pek çok güçlükten sonra Güzel sonunda değerini tanıyan nazik sahipler tarafından satın alındı. Son yıllarını yeşil bir çayırda, huzurlu ve sevilerek geçirdi; hayvanlara nezaket göstermenin önemini anlatan hikayesini paylaştı."
             ],
             coverEmoji: "🐎", coverColorHex: "2C3E50", coverImageName: nil, category: .classic, isFree: false, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "The Secret Garden", titleTR: "Gizli Bahçe",
             contentEN: [
                "Mary Lennox was a spoiled, sickly girl who came to live at her uncle's dark mansion on the Yorkshire moors after her parents died. She was lonely and disagreeable.",
                "Exploring the grounds, she found a key and then a hidden door in a wall — the entrance to a secret garden that had been locked for ten years.",
                "She began tending the garden secretly with a local boy named Dickon. Inside the mansion she also discovered her cousin Colin, bedridden and convinced he would die.",
                "Working in the garden brought them all to life. Colin discovered he could walk and run. The garden, children, and even the gloomy mansion bloomed with new life and joy."
             ],
             contentTR: [
                "Mary Lennox, anne babası öldükten sonra amcasının Yorkshire bataklığındaki karanlık malikanesine gelmek zorunda kalan şımarık, hasta bir kızdı. Yalnız ve huzursuzdur.",
                "Bahçede gezerken bir anahtar ve ardından bir duvarda gizli bir kapı buldu — on yıldır kilitli olan gizli bir bahçenin girişi.",
                "Yerel Dickon adında bir çocukla gizlice bahçeyi yetiştirmeye başladı. Malikanenin içinde ayrıca yatağa bağlı ve öleceğine inanan kuzeni Colin'i de keşfetti.",
                "Bahçede çalışmak hepsini canlandırdı. Colin yürüyebileceğini ve koşabileceğini keşfetti. Bahçe, çocuklar ve hatta kasvetli malikane yeni bir yaşam ve sevinçle çiçek açtı."
             ],
             coverEmoji: "🌷", coverColorHex: "27AE60", coverImageName: nil, category: .classic, isFree: false, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "Gulliver's Travels", titleTR: "Gulliver'in Gezileri",
             contentEN: [
                "Lemuel Gulliver was a ship's surgeon who loved to travel. When his ship sank in a storm, he washed ashore on a strange island and woke up tied to the ground by thousands of tiny ropes.",
                "The island was Lilliput, home to people no bigger than his finger. Despite being tiny, the Lilliputians had big arguments over which end of an egg should be broken first.",
                "Later Gulliver visited Brobdingnag, where everything was enormous and he was the tiny one. Farmers and giants observed him like a strange little insect.",
                "His travels taught him that size does not determine wisdom, and that people everywhere — big or small — argue over the silliest things. He returned home grateful for ordinary life."
             ],
             contentTR: [
                "Lemuel Gulliver, seyahat etmeyi seven bir gemi cerrahıydı. Gemisi bir fırtınada battığında garip bir adaya vurdu ve binlerce küçük iple yere bağlı olarak uyandı.",
                "Ada, parmağından büyük olmayan insanların yurdu Lilliput'tu. Küçük olmalarına rağmen Liliputlular yumurtanın hangi ucunun kırılması gerektiği konusunda büyük tartışmalar yapıyordu.",
                "Daha sonra Gulliver her şeyin devasa ve kendisinin küçük olduğu Brobdingnag'ı ziyaret etti. Çiftçiler ve devler onu garip küçük bir böcek gibi gözlemledi.",
                "Seyahatleri ona boyutun bilgeliği belirlemediğini ve her yerdeki insanların — büyük ya da küçük — en saçma şeyler üzerine tartıştığını öğretti. Sıradan hayata şükür duyarak eve döndü."
             ],
             coverEmoji: "🔭", coverColorHex: "2980B9", coverImageName: nil, category: .classic, isFree: false, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "The Water of Life", titleTR: "Hayat Suyu",
             contentEN: [
                "A king was gravely ill, and only the Water of Life could save him. His eldest son set out but was rude to a dwarf who warned him, and became trapped in a mountain gorge.",
                "The second son was equally arrogant and met the same fate. Only the youngest son treated the dwarf with respect, and the dwarf revealed the secret way to the enchanted castle.",
                "The youngest son entered the castle, kissed a sleeping princess, and found the Water of Life. He helped his brothers free from the gorge, but they betrayed him, stealing the water and leaving him behind.",
                "The truth came out at the royal court. The king recovered with the real water his youngest son had found. The brothers were punished and the youngest son married the princess he had awakened."
             ],
             contentTR: [
                "Bir kral ağır hastaydi ve onu yalnızca Hayat Suyu kurtarabilirdi. En büyük oğlu yola çıktı ama ona uyaran bir cüciye kaba davrandı ve bir dağ geçidine sıkıştı.",
                "İkinci oğul da aynı derecede kibirliydi ve aynı akıbete uğradı. Yalnızca en küçük oğlu cüciye saygıyla davrandı ve cüce ona büyülü kaleye giden gizli yolu gösterdi.",
                "En küçük oğul kaleye girdi, uyuyan bir prensesi öptü ve Hayat Suyu'nu buldu. Kardeşlerinin geçitten kurtulmasına yardım etti, ama onlar ona ihanet ederek suyu çaldılar ve onu geride bıraktılar.",
                "Gerçek krallık sarayında ortaya çıktı. Kral, en küçük oğlunun bulduğu gerçek suyla iyileşti. Kardeşler cezalandırıldı ve en küçük oğul uyandırdığı prensesle evlendi."
             ],
             coverEmoji: "💧", coverColorHex: "3498DB", coverImageName: nil, category: .fairyTale, isFree: false, readingTimeMinutes: 5),

        Book(id: UUID(), titleEN: "The Six Swans", titleTR: "Altı Kuğu",
             contentEN: [
                "A king had six sons and a daughter. His wicked new wife turned the six boys into swans using enchanted shirts. Only their sister knew the truth.",
                "A fairy told the girl she could break the spell only by sewing six shirts from starflowers and remaining completely silent for six years — not laughing, not crying, not speaking a single word.",
                "She was found by a king who married her, but she could not speak. His evil mother convinced him she was a witch. She was sentenced to burn, but she had finished five shirts.",
                "On the day of execution she threw the shirts over the swans. Her brothers became human again — though the youngest had one arm that stayed a wing. She finally spoke and all was explained. They lived happily."
             ],
             contentTR: [
                "Bir kralın altı oğlu ve bir kızı vardı. Kötü yeni karısı altı çocuğu büyülü gömlekler kullanarak kuğuya dönüştürdü. Gerçeği yalnızca kız kardeşleri biliyordu.",
                "Bir peri kıza büyüyü ancak yıldız çiçeklerinden altı gömlek dikerek ve tam altı yıl boyunca tamamen sessiz kalarak — gülmeden, ağlamadan, tek kelime söylemeden — kırabileceğini söyledi.",
                "Onu bulan bir kral evlendi ama konuşamıyordu. Kötü annesi kocasını onun cadı olduğuna inandırdı. Yanmak üzere mahkûm edildi ama beş gömleği bitirmişti.",
                "İnfaz gününde gömlekleri kuğuların üzerine fırlattı. Kardeşleri yeniden insan oldu — en küçüğünün bir kolu kanat olarak kaldı. Sonunda konuştu ve her şey açıklandı. Mutlu yaşadılar."
             ],
             coverEmoji: "🦢", coverColorHex: "AED6F1", coverImageName: nil, category: .fairyTale, isFree: false, readingTimeMinutes: 5),
    ]
}
