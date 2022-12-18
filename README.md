# 🎬 영화 순위 앱

<img width="1957" alt="TMDB_preview" src="https://user-images.githubusercontent.com/88874280/207108349-f7dd4dc0-49a1-407a-a68d-e270d3d534f4.png">

### TMDB API를 이용해서 영화 순위를 확인하고 자세한 정보를 볼 수 있는 앱입니다.

- Pagination으로 영화의 순위를 한 화면에서 스크롤을 통하여 손쉽게 확인할 수 있습니다.
- CollectionView를 사용하여 TOP 5 영화와 비슷한 장르의 컨텐츠를 추천받을 수 있습니다.
- WebKit을 사용하여 링크 버튼 시 각 영화의 시놉시스를 시청할 수 있습니다.
- CustomCell을 재사용 하여 영화의 자세한 정보(영화 설명, 출연진, 스탭 등)을 확인할 수 있습니다.
- MapKit을 사용하여 추천 영화관을 MapView로 확인해볼 수 있습니다.
</br><br/>
</br><br/>

## 🛠️ 사용 기술 및 라이브러리

- `Swift`, `UIKit`, `Storyboard`, `MVC`, `MapKit`, `CLLocation`, `WebKit`
- `Alamofire`, `SwiftyJSON`, `Kingfisher`
</br><br/>
</br><br/>

## 🗓️ 개발 기간

- 개발 기간: 2022년 8월 3일 ~ 2022년 8월 18일 (약 2주)
- 세부 개발 기간
    - 2022.08.03 ~ 2022.08.06: 기본 UI 및 기능 구현 (영화별 순위, 상세 페이지 등)
    - 2022.08.07 ~ 2022.08.18: 그 외 기능 구현 (영화 추천, 영화관 추천 등)

</br><br/>
</br><br/>

## ✏️ 구현해야 할 기술

- Storyboard를 사용하여 UI 구현
- Alamofire를 활용한 API 통신
- WebKit을 활용한 웹페이지 이동 및 기본 메서드 구현.
- 위치 권한 설정 및 대응
</br><br/>
</br><br/>

## 💡 Trouble Shooting

- 100개가 넘는 영화 데이터를 CollectionView Cell에 넣어야 하는 이슈
    
    → Pagenation으로 배열의 일정 시점마다 통신하여 데이터 추가
    

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
- 비슷한 컨텐츠의 개수에 따라 셀의 개수가 바뀌어야 하는 이슈
    
    → TableViewCell 내 CollectionView를 넣고 CollectionView에게 값을 전달하여 해결
    
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
## 🤔 회고
- UserDefaults를 사용할 때 Key값에 해당하는 String을 사용할 때 마다 raw값으로 넣어주었다. 하지만 추후 리팩토링 시 비용이 많이 들고, 개발자의 실수로 에러가 발생할 수 있다고 생각했다. 추후 프로젝트를 진행할 때 raw값을 쉽게 관리해야함을 느꼈고, 이후 반기다 프로젝트에서 열거형으로 raw값들을 관리하여 추후 유지보수에도 비용이 적게 들도록 설계했다.
- 현재 프로젝트에서 네이밍을 봤을 때 메서드나 클래스가 어떤 역할을 하고 있는지 정확하게 알기 어렵다고 생각했다. 추후 다른 개발자들과 협업에 대비하여 네이밍을 더 직관적이고 한 번에 이해할 수 있게 작성해야 한다는 것을 느꼈다.
- API 통신 시 Error에 대한 대응이 미숙했다는 것을 느꼈다. 만약 사용자가 API 통신에 실패하는 상황이 발생했을 때, 사용자가 어떤 상황이 발생했는지 알 수 있는 방법이 없었다. 따라서 추후 프로젝트를 진행할 때 Error에 관한 대응의 필요성을 느꼈고, 이후 새싹 스터디 프로젝트에서 각 네트워크 통신 시 발생할 수 있는 Error를 대응했다.
</br><br/>
