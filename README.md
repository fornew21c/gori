<img src = "https://github.com/fornew21c/Gori/blob/master/README_Images/GoriLogoIosTeam.png">
        
이 레포지토리는 FastCampus iOS 스쿨의 팀프로젝트 'GORI'의 리모트 레포지토리 입니다.    
'GORI'는 "튜터와 튜티의 손쉬운 연결"이라는 기본 콘셉트 하에 구현되었습니다.  
사용자는 필터 및 검색을 통해 자신이 원하는 강좌를 찾아서 신청할 수 있습니다.

- 기간 : 2017.03.27 ~ 2017.04.26    
- 역할 : iOS 개발자

[고리 풀영상 보러가기](https://youtu.be/DIdv1zhVxNU)


[고리 데일리 스크럼](https://docs.google.com/spreadsheets/d/1Xz3Y67Dp2GSDnU4oL4q2VxOasSA0J17iP3byT3TJbdw/edit#gid=1901183771)


[고리 스크럼 보드](https://docs.google.com/spreadsheets/d/1teDkt6MyGfqshqUrBuswHba2CvnGEyg4uuFDxcygIsg/edit#gid=0)

## 스크린샷    
![이미지1](https://github.com/fornew21c/Gori/blob/master/README_Images/samplepage1.png)  
-- 
![이미지2](https://github.com/fornew21c/Gori/blob/master/README_Images/samplepage2.png)   
--

## 주요기능   
- 회원가입, 로그인, 페이스북 로그인, 로그아웃
- 회원 개인정보 수정 (이름, 닉네임, 프로필 사진 수정)
- 강좌 검색 및 학교, 지역구, 카테고리 필터링
- 강좌 신청, 강좌 위시리스트 저장, 지도를 통한 강좌 지역 시각화
- 강좌 리뷰 보기 및 등록, 강좌 신청시 일정 선택 및 학생 관련 정보 저장
- 문의사항 전송


## 사용기술  
- **네트워크 구축** : 강좌정보 불러오기, 회원가입, 필터링 등에 필요한 정보를 BackEnd Restful-API를 통해 가져오기 위한 네트워크 모듈을 생성하였습니다.  
코드 간소화, 기술 트렌드 Follow Up을 위하여 FastCampus에서 배운 일반적인 방법 이외에도, **AFNetwork**를 CocoaPod을 통해 설치하여 활용했습니다.

- **싱글턴과 데이터 모델링** : 네트워크모듈 클래스가 가져온 데이터를 관리하고, 이들을 연관 뷰컨트롤러에 정확하게 보내기 위해 **데이터센터** 클래스와 **데이터모델링** 클래스를 구축, Array 및 Dictionary 형태로 수신된 데이터들을 **싱글턴** 방식으로 뷰컨트롤러에 보내주도록 구현했습니다.      
BackEnd 서버로 데이터를 보낼 때도 데이터센터는 뷰컨트롤러와 네트워크모듈을 이어주는 중간자로서 구동하고 있습니다.

- **오토레이아웃** : 빠른 구현을 위해 코드작성을 통한 UI 작성과 더불어 **스토리보드**, **오토레이아웃**을 적극 활용하였습니다.   
**UI8사이트서 다운받은 iOS 앱이미지**을 참고하였으며, **오토레이아웃**의 **Constraint** 설정을 위한 간격은 **Sketch**로 Import한 UI파일을 **Zeplin**으로 Export하여 확인했습니다.

- **이미지 세팅 개선** : 메인 뷰컨트롤러에서 발생하는 스크롤 속도 저하 이슈를 해결하고자, 일반적인 방법 대신 CocoaPod으로 설치한 **SDWebImage**를 활용하는 방법을 사용했습니다. 

- **슬라이드 메뉴** : 로그인, 회원가입, 마이페이지 등에 접근 가능하도록 슬라이드메뉴를 생성하였으며, CocoaPod으로 설치한 **AmSlideMenu**를 활용하였습니다. 
또한 **커스터마이징**을 통해 사용자의 **로그인 여부**에 따라 다른 뷰로 이동할 수 있도록 슬라이드 메뉴가 **동적으로 전환**되게끔 구현하였습니다.

- **페이스북 로그인** : 페이스북 로그인, 회원가입을 구현하고자, **Facebook의 프레임워크**를 채택하여 사용했습니다.

- **강좌 평가**: 별점 입력 및 UI의 빠른 구현과 효율적 코드 작성을 위해 CocoaPod에서 **HCSStarRatingView**를 가져왔습니다.

- **지도** : 강좌 정보에 **Apple Map**을 추가하여 강좌가 진행되는 위치를 보다 구체적으로 표현했습니다.

- **사진보정** : FastCampus에서 제공한 UI파일에 없는 이미지를 편집하고자, 별도의 이미지 편집 프로그램인 **Pixelmator**를 활용해 프로젝트에 활용되는 이미지들을 편집하였습니다.

## 사용 프로그램 및 오픈소스  

- **Xcode** : 코드 작성 및 스토리보드의 오토레이아웃 활용
- **Sketch** : UI8에서 다운받은 iOS 디자인 이미지파일 오픈 및 필요한 아이콘의 Export를 위하여 활용
- **Zeplin** : Sketch에서 Import한 파일의 다운로드, 스토리보드의 오토레이아웃 위한 간격
- **AFNetwork** : 네트워크모듈 생성, BackEnd 서버로부터 데이터를 다운로드하거나, 반대로 서버로 데이터를 업로드 할 시 활용
- **SDWebImage** : 더욱 빠른 이미지 세팅을 위해서 활용, 이미지로 인해 스크롤이 느려지는 현상을 해결
- **AmSlideMenu** : 슬라이드메뉴 구현을 위해 채택
- **HCSStarRatingView** : 메인 뷰, 강의 디테일 뷰, 리뷰화면에서 별점 항목을 구현하고자 채택
- **Facebook 프레임워크** : 페이스북 로그인, 회원가입 구현을 위해 채택
- **Pixelmator** : UI파일에 없는 이미지의 크기 수정, 특정부분 삭제에 활용
- **Git** : 프로젝트 버전관리에 활용


## 참고
- **Taling** Mobile WebPage
- **Taling** iOS App
- **Zikto** iOS App
- **UI Sample** From **FastCampus**


## 팀원

|이름|이메일|전화번호|
|:--:|:--:|:--:|
|허원철|fornew21c@gmail.com|010-9592-2837|
|지준영|rainmaker8492@gmail.com|010-6211-3163|
