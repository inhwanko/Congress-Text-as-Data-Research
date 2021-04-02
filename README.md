고인환, 최하예, 강신재. (2021). "자동화된 텍스트 분석을 활용한 국회의원 간 갈등 양상 연구: 17~20대 국회 환경노동위원회와 보건복지위원회 회의록을 중심으로." 한국정당학회보 제20권 1호, 5-42쪽. ([링크](http://www.partystudies.or.kr/contents/bbs/bbs_content.html?bbs_cls_cd=004003&cid=21033117313490&bbs_type=B))  

논문의 저자들은 자료 분석 과정을 투명하게 공개하기 위하여 본 페이지에 사용된 R코드와 데이터셋을 업로드하였습니다. 공개 과정의 투명성을 위해 정제되지 않은 코드를 그대로 올려드렸음을 알려드리며, 번호 순서에 따라 코드를 실행하면 위 논문에 기재된 분석 결과와 동일한 결과를 얻을 수 있습니다. 추후에 하나의 R 스크립트에 코드를 정리하여 보다 쉽게 반복 검증(replication)이 가능하도록 정리할 예정입니다. 코드 및 분석 과정과 관련하여 질문이 있으시다면 inhwanko at uw dot edu 로 연락주시기 바랍니다. 특히 5번 코드 "regression"과 관련하여, 통계적 결과만을 검증하고자 하시는 연구자께서 env_final.csv 및 wel_final.csv 파일이 필요하시다면 연락 주시기 바랍니다. 

This directory contains R codes and datasets for the replication of the paper, "Analyzing Conflict Patterns among Legislator with Automated Text Analysis: Cases of Environmental and Labor Committee and Health and Welfare Committee of the 17-20th National Assembly of Korea," published in a peer-reviewed journal of the Korean Association of Party Studies.   

Please contact inhwanko at uw dot edu for more information.   


## 자동화된 텍스트 분석을 활용한 국회의원 간 갈등 양상 연구: 17～20대 국회 환경노동위원회와 보건복지위원회 회의록을 중심으로  

고인환 (University of Washington, Seattle), 최하예 (영남대학교), 강신재 (연세대학교)  

초록  

국회의원 간 갈등 및 대립에 관한 대다수 연구 및 문헌은 의원 간 갈등을 개별 의원 혹은 소속 정당 간 정치 이념적 양극화의 관점에서 바라보며, 정당 공약이나 본회의 표결 기록 등을 분석 대상으로 설정했다. 그러나 의원 간 갈등은 반드시 정치적 양극화에서만 유래하지 않는다. 특히 개별 의원들의 발언 행태를 살펴보면 의원 간 대립은 이념적 차이로 인한 언쟁뿐만이 아닌 동료 의원 비난, 의사진행 방해, 정부 관계자 및 참고인에 대한 태도에서도 나타난다. 본 연구는 이러한 다양한 의원 간 갈등의 양상을 분석하기 위해, 제17～20대 국회 환경노동위원회와 보건복지위원회, 두 상임위원회 회의록에 나타난 약 24만 개의 발언을 자동화된 텍스트 분석 기법(automated text analysis)으로 분석하였다. 발언 상에 드러난 의원 간 대립을 이전 발화자의 발언을 중도에 간섭하는 “중도방해 발언”과 상대방에 대해 인신공격과 비난을 하는 “갈등적 담화 발언”으로 파악할 수 있음을 제안하였다. 분석 결과, 첫째, 의원들의 전체 발언에서 갈등적 담화 발언은 중도방해 발언에 비해 그 비중이 현저히 낮고 대수 및 위원회 별로 차이가 나타나지 않아, 의원 간 갈등 정도를 측정할 수 있는 유의미한 지표가 아님을 알 수 있었다. 둘째, 통계분석 결과 여당 및 야당 소속 여부가 중도방해 발언 비율 차이를 설명하는 유의미한 변수였던 반면 여당과 개별 의원 간의 이념적 격차는 그렇지 않았다. 본 연구는 회의록에 대한 자동화된 텍스트 분석을 통해 상임위원회에서 나타나는 여러 갈등 양상들을 측정하고 여당과 야당 간의 대립 양식이 입법과정에 지배적인 변수라는 점을 밝혔다는 점에서 의의가 있다.  

주제어: 중도방해 발언, 갈등적 담화, 의원 간 갈등, 국회 회의록, 자동화된 텍스트 분석, 입법과정  


## Analyzing Conflict Patterns among Legislators with Automated Text Analysis: Cases of Environmental and Labor Committee and Health and Welfare Committee of the 17-20th National Assembly of Korea  

Ko, Inhwan (University of Washington, Seattle), Choi, Haye (Youngnam University), Sinjae Kang (Yonsei University)  

Abstract  

Most of the research and literature on conflicts and confrontations among lawmakers viewed conflict between individual lawmakers or political parties in terms of ideological polarization and set party pledges and voting records for the plenary session as analysis targets.  However, conflict between lawmakers does not necessarily stem from political polarization. In particular, when looking at individual lawmakers' remarks, confrontations between lawmakers are caused by ideological differences and criticism of fellow lawmakers, interrupting speeches and proceedings, and attitudes toward government officials and witnesses. In order to analyze these various aspects of the conflict between lawmakers, we analyzed approximately 240,000 statements in the minutes of the 17th-20th National Assembly's Environmental and Labor Committee, Health and Welfare Committee, through automated text analysis. Our study suggests that the confrontation between lawmakers revealed in the remarks could be identified as an "interruptive discourse" that interferes with the former speaker's remarks, and a "conflictual discourse" that makes personal condemns and criticisms against others. Our analysis results are as follows. First, the conflictual discourses appeared less frequently than the interruptive discourses in meeting minutes, indicating that they were not a significant indicator of conflict between lawmakers. Second, statistical analysis showed that belonging to the ruling party and the opposition party was a significant variable to explain the difference in the ratio of the interruptive, while the ideological gap between the ruling party and individual lawmakers was not. This study is meaningful in that it measures various aspects of conflict that appear in the standing committee through automated text analysis of the minutes and reveals that the mode of confrontation between the ruling and opposition parties is the dominant factor in the legislative process.
