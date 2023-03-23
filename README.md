# 💡 프로젝트 소개

<h3>Project - 고가용성 글로벌 팬 사이트</h3>
  
스타트업 뱁새엔터는 3티어 아키텍처로 구성된 커뮤니티를 운영하고 있습니다. 주로 K-Pop 팬들이 서로 소통할 수 있는 게시판을 운영하는 것이 사이트의 목적입니다.
특정 팬덤의 확대로 사이트의 트래픽이 늘고, 회사의 규모도 이에 따라 점점 커지다 보니, 개발 직군의 채용도 늘어났고, 운영 이슈도 더욱 많이 생기기 시작했습니다.
<br/>
> 뱁새 오형제 <br/> 개발기간: 2022.03.14 ~ 2022.03.23
<br/>
--------------------
## 개발팀 소개
  
|      김도형       |          박성욱         |       이혜정        |       진유록        |       최우람      |                                                                                            
| :--------------------------: | :--------------------------: | :--------------------------: | :--------------------------: | :--------------------------: |
| <image width="160px" src="https://user-images.githubusercontent.com/119159558/227075769-378c58ac-82ff-49c8-a20d-0a22120f539e.png"/> | <image width="160px" src="https://user-images.githubusercontent.com/119159558/227076242-6e802ef4-4f4e-48f0-8a8a-aa5f4ebdb8b8.png"/> | <image width="160px" src="https://user-images.githubusercontent.com/119159558/227076363-f2a67940-90c3-41de-abdf-4c2a0313212b.png"/> | <image width="160px" src="https://user-images.githubusercontent.com/119159558/227076449-e586846c-440d-4f42-88e4-c743ef2ec39e.png"/> | <image width="160px" src="https://user-images.githubusercontent.com/119159558/227076534-4f71a8d8-7bf8-485e-ae30-a941e640624c.png"/> |
| [@kdh5983](https://github.com/kdh5983) | [@WooK1184](https://github.com/WooK1184) | [@leehyejeong23421](https://github.com/leehyejeong23421) | [@2undaunted](https://github.com/2undaunted) | [@wooov](https://github.com/wooov) |

<br>
## 직면한 문제

 >글로벌 트래픽이 증가로 인한 특정 국가의 이용자로부터 웹사이트 로딩이 느리다는 불만이 속출<br/>
 K-Pop 아이돌로부터 발생하는 각종 사안에 따라, 순간적으로 트래픽이 급증하는 형태를 보여 종종 다운타임이 발생<br/>
 모니터링 시스템의 부재<br/>
 개발 조직문제 → 전문 개발자의 부재로 개발 중인 제품이 곧바로 production 수준에 배포되거나, 충분한 테스트를 거치지 못한 채로 릴리즈되는 경우가 있음

<br>

<details>
    <summary><strong>📍 요구사항 </strong></summary>
   <br>
   
   요구사항 | *
   -- | --
   CRUD 기능을 포함한 간단한 3티어 REST API | - 회원 가입 <br/>- 로그인 <br/>- 게시글 읽기,쓰기
   CI/CD 파이프라인을 만들고, dev/staging/production 수준을 구분 및 릴리즈 정책 생성 | git branch 및 릴리즈 여부에 따라 <br/> dev/staging/production 수준 분리
   서버 및 데이터베이스의 고가용성 달성 및 순간적인 트래픽 증가 대응 | 
   모니터링 시스템을 구축 또는 CloudWatch 대시보드를 통해 모니터링 | 
   모든 서버는 컨테이너 환경에서 구현 | 
   서버 및 데이터베이스는 AZ 단위의 가용성 확보 | 
   순간적인 트래픽 증가에 대응 | - 주로 국가별 트래픽 및 응답시간 확인 <br/> - 글로벌 트래픽 대응을 위한 방안 제시
   기본적인 보안 요구 사항 충족 | - 서브넷 분리
   IaC화 진행 | 
   CDN의 효과 증명 | 

   

   <br>


</details>


<details>
    <summary><strong>📍 서비스 구현에 사용되는 리소스 </strong></summary>
OS - Ubuntu
Web Server - Nginx

**AWS Cloud**

Network
>Internet Gateway
  ELB
  NAT gateway
  ASG

Container Service
  >ECS (Fargate)
    - ECR

Database
  >RDS Aurora

Storage
  > S3
     - Bucket

Monitering tool
  >CloudWatch
     - alarm
    AWS OpenSearch

Performance test tool
  >k6

CDN & Domain service
  >Cloud front
    route53

Security
  >AWS Shield
    AWS WAF
    AWS Firewall manager
    ASM

External Services
>Slack
  Kibana
  Github Action

Other Service
> Lambda
   SNS
   SQS

<br>
</details>


<br>

# 💡 서비스 아키텍처
![스크린샷 2023-03-20 오후 9 54 43](https://user-images.githubusercontent.com/119268657/226344823-5a53acdf-437b-4e03-a4ee-f9d38793a6a6.png)


<br>

***
<h3>📝 회고</h3>

<details>
    <summary><strong> 김도형 </strong></summary>
</details>

<details>
    <summary><strong> 박성욱 </strong></summary>
</details>

<details>
    <summary><strong> 이혜정 </strong></summary>
</details>

<details>
    <summary><strong> 진유록 </strong></summary>
</details>

<details>
    <summary><strong> 최우람 </strong></summary>
</details>
