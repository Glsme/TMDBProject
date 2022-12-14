# ๐ฌย ์ํ ์์ ์ฑ

<img width="1957" alt="TMDB_preview" src="https://user-images.githubusercontent.com/88874280/207108349-f7dd4dc0-49a1-407a-a68d-e270d3d534f4.png">

### TMDB API๋ฅผ ์ด์ฉํด์ ์ํ ์์๋ฅผ ํ์ธํ๊ณ  ์์ธํ ์ ๋ณด๋ฅผ ๋ณผ ์ ์๋ ์ฑ์๋๋ค.

- Pagination์ผ๋ก ์ํ์ ์์๋ฅผ ํ ํ๋ฉด์์ ์คํฌ๋กค์ ํตํ์ฌ ์์ฝ๊ฒ ํ์ธํ  ์ ์์ต๋๋ค.
- CollectionView๋ฅผ ์ฌ์ฉํ์ฌ TOP 5 ์ํ์ ๋น์ทํ ์ฅ๋ฅด์ ์ปจํ์ธ ๋ฅผ ์ถ์ฒ๋ฐ์ ์ ์์ต๋๋ค.
- WebKit์ ์ฌ์ฉํ์ฌ ๋งํฌ ๋ฒํผ ์ ๊ฐ ์ํ์ ์๋์์ค๋ฅผ ์์ฒญํ  ์ ์์ต๋๋ค.
- CustomCell์ ์ฌ์ฌ์ฉ ํ์ฌ ์ํ์ ์์ธํ ์ ๋ณด(์ํ ์ค๋ช, ์ถ์ฐ์ง, ์คํญ ๋ฑ)์ ํ์ธํ  ์ ์์ต๋๋ค.
- MapKit์ ์ฌ์ฉํ์ฌ ์ถ์ฒ ์ํ๊ด์ MapView๋ก ํ์ธํด๋ณผ ์ ์์ต๋๋ค.
</br><br/>
</br><br/>

## ๐ ๏ธย ์ฌ์ฉ ๊ธฐ์  ๋ฐ ๋ผ์ด๋ธ๋ฌ๋ฆฌ

- `Swift`, `UIKit`, `Storyboard`, `MVC`, `MapKit`, `CLLocation`, `WebKit`
- `Alamofire`, `SwiftyJSON`, `Kingfisher`
</br><br/>
</br><br/>

## ๐๏ธย ๊ฐ๋ฐ ๊ธฐ๊ฐ

- ๊ฐ๋ฐ ๊ธฐ๊ฐ: 2022๋ 8์ 3์ผ ~ 2022๋ 8์ 18์ผ (์ฝ 2์ฃผ)
- ์ธ๋ถ ๊ฐ๋ฐ ๊ธฐ๊ฐ
    - 2022.08.03 ~ 2022.08.06: ๊ธฐ๋ณธ UI ๋ฐ ๊ธฐ๋ฅ ๊ตฌํ (์ํ๋ณ ์์, ์์ธ ํ์ด์ง ๋ฑ)
    - 2022.08.07 ~ 2022.08.18: ๊ทธ ์ธ ๊ธฐ๋ฅ ๊ตฌํ (์ํ ์ถ์ฒ, ์ํ๊ด ์ถ์ฒ ๋ฑ)

</br><br/>
</br><br/>

## โ๏ธย ๊ตฌํํด์ผ ํ  ๊ธฐ์ 

- Storyboard๋ฅผ ์ฌ์ฉํ์ฌ UI ๊ตฌํ
- Alamofire๋ฅผ ํ์ฉํ API ํต์ 
- WebKit์ ํ์ฉํ ์นํ์ด์ง ์ด๋ ๋ฐ ๊ธฐ๋ณธ ๋ฉ์๋ ๊ตฌํ.
- ์์น ๊ถํ ์ค์  ๋ฐ ๋์
</br><br/>
</br><br/>

## ๐กย Trouble Shooting

- 100๊ฐ๊ฐ ๋๋ ์ํ ๋ฐ์ดํฐ๋ฅผ CollectionView Cell์ ๋ฃ์ด์ผ ํ๋ ์ด์
    
    โ Pagenation์ผ๋ก ๋ฐฐ์ด์ ์ผ์  ์์ ๋ง๋ค ํต์ ํ์ฌ ๋ฐ์ดํฐ ์ถ๊ฐ
    

```swift
static var searchList: [TrendListModel] = []

extension ListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if ListViewController.searchList.count - 5 == indexPath.item && ListViewController.searchList.count < totalCount {
                startPage += 1
                requestTMDBTrend(media_type: mediaType, time_window: timeWindow, page: startPage)
            }
        }
    }
}
```
</br><br/>
- ๋น์ทํ ์ปจํ์ธ ์ ๊ฐ์์ ๋ฐ๋ผ ์์ ๊ฐ์๊ฐ ๋ฐ๋์ด์ผ ํ๋ ์ด์
    
    โ TableViewCell ๋ด CollectionView๋ฅผ ๋ฃ๊ณ  CollectionView์๊ฒ ๊ฐ์ ์ ๋ฌํ์ฌ ํด๊ฒฐ
    
    <img width="200" alt="TMDB_issue" src="https://user-images.githubusercontent.com/88874280/207109300-52ee9deb-38f1-4435-aa61-bb496e91a176.png">
    
```swift
class RecommandTableViewCell: UITableViewCell {

    @IBOutlet weak var recommandCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()

    }

    func setupUI() {
        titleLabel.font = UIFont(name: "Binggrae-Bold", size: 17)
        titleLabel.text = ""
        recommandCollectionView.backgroundColor = .clear
        recommandCollectionView.collectionViewLayout = collectionViewLayout()
    }

    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)

        return layout
    }
}
```

</br><br/>
</br><br/>
## ๐คย ํ๊ณ 
- UserDefaults๋ฅผ ์ฌ์ฉํ  ๋ Key๊ฐ์ ํด๋นํ๋ String์ ์ฌ์ฉํ  ๋ ๋ง๋ค raw๊ฐ์ผ๋ก ๋ฃ์ด์ฃผ์๋ค. ํ์ง๋ง ์ถํ ๋ฆฌํฉํ ๋ง ์ ๋น์ฉ์ด ๋ง์ด ๋ค๊ณ , ๊ฐ๋ฐ์์ ์ค์๋ก ์๋ฌ๊ฐ ๋ฐ์ํ  ์ ์๋ค๊ณ  ์๊ฐํ๋ค. ์ถํ ํ๋ก์ ํธ๋ฅผ ์งํํ  ๋ raw๊ฐ์ ์ฝ๊ฒ ๊ด๋ฆฌํด์ผ ํจ์ ๋๊ผ๊ณ , ์ดํ ๋ฐ๊ธฐ๋ค ํ๋ก์ ํธ์์ ์ด๊ฑฐํ์ผ๋ก raw๊ฐ๋ค์ ๊ด๋ฆฌํ์ฌ ์ถํ ์ ์งโข๋ณด์์๋ ๋น์ฉ์ด ์ ๊ฒ ๋ค๋๋ก ์ค๊ณํ๋ค.
- ํ์ฌ ํ๋ก์ ํธ์์ ๋ค์ด๋ฐ์ ๋ดค์ ๋ ๋ฉ์๋๋ ํด๋์ค๊ฐ ์ด๋ค ์ญํ ์ ํ๊ณ  ์๋์ง ์ ํํ๊ฒ ์๊ธฐ ์ด๋ ต๋ค๊ณ  ์๊ฐํ๋ค. ์ถํ ๋ค๋ฅธ ๊ฐ๋ฐ์๋ค๊ณผ ํ์์ ๋๋นํ์ฌ ๋ค์ด๋ฐ์ ๋ ์ง๊ด์ ์ด๊ณ  ํ ๋ฒ์ ์ดํดํ  ์ ์๊ฒ ์์ฑํด์ผ ํ๋ค๋ ๊ฒ์ ๋๊ผ๋ค.
- API ํต์  ์ Error์ ๋ํ ๋์์ด ๋ฏธ์ํ๋ค๋ ๊ฒ์ ๋๊ผ๋ค. ๋ง์ฝ ์ฌ์ฉ์๊ฐ API ํต์ ์ ์คํจํ๋ ์ํฉ์ด ๋ฐ์ํ์ ๋, ์ฌ์ฉ์๊ฐ ์ด๋ค ์ํฉ์ด ๋ฐ์ํ๋์ง ์ ์ ์๋ ๋ฐฉ๋ฒ์ด ์์๋ค. ๋ฐ๋ผ์ ์ถํ ํ๋ก์ ํธ๋ฅผ ์งํํ  ๋ Error์ ๊ดํ ๋์์ ํ์์ฑ์ ๋๊ผ๊ณ , ์ดํ ์์น ์คํฐ๋ ํ๋ก์ ํธ์์ ๊ฐ ๋คํธ์ํฌ ํต์  ์ ๋ฐ์ํ  ์ ์๋ Error๋ฅผ ๋์ํ๋ค.
</br><br/>
