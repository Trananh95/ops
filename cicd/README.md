# CI/CD

## Triển khai phần mềm thủ công:
Khi chưa có CI/CD, quy trình triển khai phần mềm thường mang tính thủ công và có thể phức tạp, dễ xảy ra lỗi do sự can thiệp của con người. Dưới đây là các bước triển khai phần mềm phổ biến trước khi áp dụng CI/CD:

1. Phát triển mã nguồn (Development)
* Lập trình: Các nhà phát triển làm việc trên các tính năng hoặc bản sửa lỗi mới trên các nhánh mã riêng biệt.
* Tích hợp thủ công: Khi hoàn thành một tính năng hoặc bản sửa lỗi, các nhà phát triển sẽ tích hợp mã của họ vào nhánh chính thông qua các công cụ quản lý mã nguồn như Git.
2. Kiểm thử (Testing)
* Kiểm thử đơn vị (Unit Testing): Các nhà phát triển viết và chạy các bài kiểm thử đơn vị thủ công để đảm bảo các phần của mã hoạt động đúng.
* Kiểm thử tích hợp (Integration Testing): Sau khi tích hợp, các nhà phát triển hoặc đội QA tiến hành kiểm thử tích hợp để đảm bảo các phần của ứng dụng hoạt động cùng nhau.
* Kiểm thử hệ thống (System Testing): Đội QA thực hiện kiểm thử hệ thống thủ công để xác định ứng dụng hoạt động tốt trên toàn bộ hệ thống.
3. Build ứng dụng (Building)
* Tạo bản build: Việc tạo bản build của ứng dụng thường được thực hiện thủ công. Điều này có thể bao gồm việc biên dịch mã nguồn, nén tệp, và chuẩn bị các tài nguyên cần thiết cho việc triển khai.
* Quản lý phiên bản: Nhà phát triển hoặc người quản lý build sẽ gán số phiên bản cho bản build và lưu trữ nó trong một hệ thống lưu trữ như máy chủ hoặc ổ đĩa mạng.
4. Triển khai (Deployment)
* Triển khai lên môi trường staging: Đội phát triển hoặc đội DevOps sẽ triển khai bản build lên môi trường staging để thử nghiệm. Quá trình này thường bao gồm:

    * Sao chép file: Chuyển các tệp cần thiết (như file ứng dụng, cấu hình) lên máy chủ staging.
    * Cấu hình môi trường: Cấu hình máy chủ theo yêu cầu của ứng dụng (ví dụ, cài đặt phần mềm phụ thuộc, điều chỉnh tệp cấu hình).
    * Khởi động ứng dụng: Khởi động ứng dụng trên máy chủ staging và thực hiện kiểm thử để đảm bảo mọi thứ hoạt động như mong đợi.
* Triển khai lên môi trường sản xuất (Production):

    * Sau khi xác nhận ứng dụng hoạt động tốt trên staging, đội DevOps sẽ triển khai ứng dụng lên môi trường sản xuất.
    * Sao lưu: Đôi khi, việc sao lưu hệ thống hiện tại sẽ được thực hiện trước khi triển khai để phòng trường hợp cần rollback.
    * Triển khai thủ công: Sao chép các tệp cần thiết lên máy chủ sản xuất và cấu hình chúng tương tự như trên staging.
    * Khởi động và kiểm tra: Khởi động ứng dụng trên môi trường sản xuất và thực hiện một số kiểm tra nhanh để đảm bảo ứng dụng hoạt động bình thường.
5. Giám sát và hỗ trợ sau triển khai (Monitoring and Post-Deployment Support)
* Giám sát: Sau khi triển khai, ứng dụng sẽ được giám sát để phát hiện các vấn đề phát sinh (ví dụ: lỗi, hiệu suất kém).
* Hỗ trợ và khắc phục sự cố: Đội phát triển hoặc đội hỗ trợ sẽ giải quyết các vấn đề phát sinh sau khi triển khai. Nếu có vấn đề nghiêm trọng, có thể cần phải rollback bản phát hành.
6. Tài liệu và báo cáo (Documentation and Reporting)
* Tài liệu: Ghi lại toàn bộ quá trình triển khai, bao gồm các thay đổi đã thực hiện, các vấn đề gặp phải, và các bước khắc phục.
* Báo cáo: Báo cáo tình trạng của bản phát hành, bao gồm thành công hay thất bại, thời gian triển khai, và các bước tiếp theo.
* Nhược điểm của Quy trình Triển khai Thủ công:
    * Lỗi con người: Do phụ thuộc nhiều vào các thao tác thủ công, quy trình dễ gặp lỗi do con người (như sao chép nhầm file, cấu hình sai).
    * Thiếu nhất quán: Mỗi lần triển khai có thể khác nhau, dẫn đến kết quả không đồng nhất trên các môi trường khác nhau.
    * Tốn thời gian: Quy trình triển khai thủ công thường tốn nhiều thời gian, từ việc build đến kiểm thử và triển khai.
    * Khó khăn trong việc phản hồi nhanh: Việc triển khai và phát hiện lỗi chậm, dẫn đến khó khăn trong việc phát hành các bản vá lỗi nhanh chóng.

## CI/CD là gì: 

CI/CD (Continuous Integration/Continuous Deployment) là một tập hợp các phương pháp và công cụ được sử dụng trong phát triển phần mềm để tự động hóa và cải thiện quy trình tích hợp, kiểm thử và triển khai mã nguồn.

<img loading="lazy" width="800px" src="./cicd_flow.png" alt="Gitlab Registry" />

## Continuous Integration (CI):
CI là quá trình tích hợp mã nguồn liên tục. Khi các nhà phát triển đẩy (push) mã nguồn mới lên kho mã (repository), mã đó sẽ được tự động tích hợp vào nhánh chính. Trong quá trình này:

* Tích hợp liên tục: Mỗi khi có thay đổi trong mã, hệ thống CI tự động xây dựng (build) ứng dụng.
* Kiểm thử tự động: Hệ thống thực hiện các bài kiểm thử tự động (unit tests, integration tests) để đảm bảo không có lỗi mới được giới thiệu vào mã nguồn.
* Phản hồi nhanh: Nếu phát hiện lỗi, hệ thống CI sẽ thông báo ngay lập tức để nhà phát triển sửa lỗi sớm nhất có thể.
## Continuous Deployment (CD):
CD là quá trình tự động triển khai mã nguồn đã được kiểm thử thành công ra môi trường sản xuất.

* Triển khai tự động: Sau khi mã vượt qua tất cả các bài kiểm thử trong CI, nó được tự động triển khai lên môi trường sản xuất hoặc môi trường staging.
* Phản hồi liên tục: Hệ thống sẽ theo dõi và ghi nhận phản hồi từ việc triển khai để điều chỉnh hoặc rollback nếu cần thiết.
* Phát hành nhanh: CD giúp phát hành phần mềm nhanh chóng và liên tục, giảm thời gian chờ đợi từ khi phát triển đến khi phát hành sản phẩm.
## Lợi ích của CI/CD:
* Tăng tốc độ phát triển: Giảm thời gian phát hiện lỗi và triển khai, giúp đưa sản phẩm ra thị trường nhanh hơn.
* Cải thiện chất lượng: Tự động kiểm thử liên tục giúp giảm thiểu rủi ro lỗi trong sản phẩm.
* Giảm thiểu rủi ro: Thường xuyên triển khai các thay đổi nhỏ thay vì một thay đổi lớn, dễ kiểm soát hơn và giảm thiểu rủi ro.
* Tăng cường hợp tác: CI/CD tạo ra một môi trường cộng tác, nơi các nhà phát triển có thể làm việc cùng nhau mà không lo xung đột mã.

## Các công cụ phổ biến trong CI/CD
Có rất nhiều công cụ hỗ trợ triển khai CI/CD. Dưới đây là một số công cụ phổ biến:

### Công cụ CI/CD:
* Jenkins:

Jenkins là một trong những công cụ CI/CD phổ biến và lâu đời nhất, mã nguồn mở và có một cộng đồng lớn hỗ trợ. Jenkins cung cấp một hệ thống plugin phong phú giúp tích hợp với nhiều công cụ và nền tảng khác nhau.

* GitLab CI/CD:

GitLab CI/CD là một phần của GitLab và tích hợp sẵn vào hệ thống quản lý mã nguồn GitLab. Nó cung cấp một trải nghiệm liền mạch từ mã nguồn đến triển khai, với khả năng tự động hóa mạnh mẽ và dễ cấu hình.

* GitHub Actions:

GitHub Actions là một công cụ CI/CD tích hợp trong GitHub. Nó cho phép bạn tự động hóa tất cả các quy trình từ build, kiểm thử đến triển khai trực tiếp từ GitHub, với các workflow được định nghĩa bằng YAML.

* CircleCI:

CircleCI là một công cụ CI/CD đám mây mạnh mẽ, tập trung vào việc xây dựng và kiểm thử nhanh chóng. Nó hỗ trợ nhiều ngôn ngữ lập trình và tích hợp tốt với các nền tảng quản lý mã nguồn phổ biến như GitHub và Bitbucket.

* Travis CI:

Travis CI là một công cụ CI/CD đám mây, đặc biệt phổ biến trong các dự án mã nguồn mở. Nó dễ sử dụng và tích hợp tốt với GitHub, cho phép bạn tự động kiểm thử và triển khai mã nguồn.

* Azure DevOps:

Azure DevOps là một bộ công cụ phát triển tích hợp từ Microsoft, hỗ trợ CI/CD, quản lý dự án, và nhiều dịch vụ khác. Azure Pipelines, một phần của Azure DevOps, cung cấp các tính năng CI/CD mạnh mẽ và tích hợp sâu với các dịch vụ Azure.

* AWS CodePipeline:

AWS CodePipeline là một dịch vụ CI/CD của Amazon Web Services. Nó cho phép bạn tạo ra các pipeline tích hợp và triển khai liên tục, dễ dàng tích hợp với các dịch vụ khác của AWS.

### Công cụ hỗ trợ trong CI/CD:
* Docker:

Docker là một công cụ tạo ra các container, cho phép các ứng dụng được đóng gói và chạy một cách nhất quán trên các môi trường khác nhau. Docker thường được sử dụng trong CI/CD để chuẩn bị các môi trường kiểm thử và triển khai.

* Kubernetes:

Kubernetes là một nền tảng quản lý container mạnh mẽ, thường được sử dụng trong các quy trình CD để triển khai và quản lý các ứng dụng container ở quy mô lớn.

* Terraform:

Terraform là một công cụ quản lý hạ tầng dưới dạng mã (Infrastructure as Code), cho phép bạn xác định và quản lý hạ tầng của mình bằng cách sử dụng các tệp cấu hình. Nó thường được sử dụng trong quá trình triển khai hạ tầng tự động trong các pipeline CD.

* Ansible:

Ansible là một công cụ tự động hóa cấu hình và triển khai, thường được sử dụng để quản lý cấu hình và triển khai phần mềm trong các pipeline CI/CD.