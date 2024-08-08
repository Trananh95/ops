# GITLAB CICD

## GitLab CICD là gì?
GitLab CI/CD (Continuous Integration and Continuous Deployment/Delivery) là một phần của GitLab, một nền tảng DevOps mã nguồn mở tích hợp cung cấp các công cụ để quản lý toàn bộ vòng đời của một dự án phần mềm (software development life cycle). GitLab CI/CD giúp tự động hóa quy trình xây dựng (Build), kiểm thử (Test) và triển khai mã nguồn  (Deploy), giúp cải thiện chất lượng phần mềm và tăng cường hiệu quả làm việc.

Các thành phần chính của GitLab CICD

* Pipeline: Là một tập hợp các Jobs (công việc) được thực thi theo một thứ tự xác định. Mỗi pipeline có thể có nhiều stages (giai đoạn), và mỗi stage có thể có nhiều jobs.
* Job: Là một đơn vị công việc cụ thể, ví dụ như biên dịch mã nguồn, chạy kiểm thử, hoặc triển khai ứng dụng. Các jobs trong cùng một stage được thực thi song song, còn các stages được thực thi tuần tự.
* Runner: Là các agent chịu trách nhiệm thực thi các jobs. GitLab Runner có thể được cài đặt trên máy chủ riêng hoặc sử dụng các runners được cung cấp bởi GitLab.
* .gitlab-ci.yml: Là tệp cấu hình được lưu trữ trong kho mã nguồn (repository) của bạn. Tệp này xác định các pipelines, stages và jobs cần thực thi. Đây là nơi bạn định nghĩa logic CI/CD cho dự án của mình.

## Pricing

<img loading="lazy" width="800px" src="./images/image.png" alt="Pricing" />

## 