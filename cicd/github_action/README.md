# Github Actions

## Github Actions là gì?
* Github Actions cho phép chúng ta tạo workflows vòng đời phát triển phần mềm cho dự án trực tiếp trên Github repository của chúng ta
* Github Actions giúp chúng ta tự động hóa quy trình phát triển phần mềm tại nơi chúng ta lưu trữ code và kết hợp với pull request và issues. Chúng ta có thể viết các tác vụ riêng lẻ, được gọi là các actions và kết hợp các actions đó lại với nhau để tạo ra một workflow theo ý của chúng ta. Workflow là các tiến trình tự động mà bạn có thể thiết lập trong repository của mình để build, test, publish package, release, hoặc deploy dự nào trên Github
* Với Github Actions chúng ta có thể tích hợp continuous integration (CI) và continuous deployment (CD) trực tiếp trên repository của mình\

## Pricing

<img loading="lazy" width="800px" src="./images/github_price.jpeg" alt="Pricing" />


## Triển khai CICD trên github action
Các bước triển khai cicd trên gitlab:
* Tạo Github Repository
* Setup Github registry
* Setup Github runner(nếu có)
* Cấu hình Github action 


### Setup github registry
Khác với gitlab, thì github private repository sẽ tính phí data transfer theo mỗi action 

<img loading="lazy" width="800px" src="./images/github_registry_price.jpg" alt="Pricing" />

* Đầu tiên, muốn login vào github container registry bằng commandline, chúng ta cần tạo asscess token có đầy đủ quyền truy cập vaò registry:
    * Câu lệnh login vào github registry:
        `docker login ghcr.io -u <your-github-username> -p <your-personal-access-token>`
        Ở đây password chính là access token mà chúng ta mới tạo ở trên
* Sau đó, chúng ta truy cập vào phần registry của repository để xem tên của image được lưu trên registry

### Setup Github Actions:
Để thiết lập một quy trình CI/CD bằng GitHub Actions, bạn sẽ cần tạo một tệp workflow trong repository của bạn. GitHub Actions cho phép bạn tự động hóa quy trình phát triển phần mềm của mình, bao gồm kiểm thử, xây dựng, triển khai, v.v. Dưới đây là một ví dụ cơ bản về cách thiết lập một quy trình CI/CD với GitHub Actions.

1. Tạo tệp Workflow
Tạo một thư mục .github/workflows trong repository của bạn nếu chưa có, và tạo một tệp workflow mới, ví dụ ci-cd.yml.

2. Cấu hình tệp Workflow
Dưới đây là một ví dụ về tệp workflow để kiểm thử, build, và triển khai ứng dụng của bạn:
```
name: CI/CD Pipeline

# Khi nào workflow này sẽ chạy
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

# Các job sẽ được thực hiện
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # Checkout mã nguồn từ repository
      - name: Checkout code
        uses: actions/checkout@v3

      # Cài đặt môi trường (Node.js ví dụ)
      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '14'

      # Cài đặt các dependencies
      - name: Install dependencies
        run: npm install

      # Chạy kiểm thử
      - name: Run tests
        run: npm test

      # Build dự án
      - name: Build project
        run: npm run build

  deploy:
    runs-on: ubuntu-latest
    needs: build
    steps:
      # Checkout mã nguồn từ repository
      - name: Checkout code
        uses: actions/checkout@v3

      # Thiết lập các secrets cần thiết (ví dụ SSH để deploy)
      - name: Setup SSH
        uses: webfactory/ssh-agent@v0.5.3
        with:
          ssh-private-key: ${{ secrets.SSH_PRIVATE_KEY }}

      # Triển khai dự án (ví dụ đẩy mã lên một server qua SSH)
      - name: Deploy to Server
        run: |
          ssh user@your-server "cd /path/to/your/app && git pull && npm install && npm run start"
```

3. Giải thích tệp Workflow
* on:: Định nghĩa các sự kiện sẽ kích hoạt workflow này. Ví dụ: workflow sẽ chạy khi có push hoặc pull request đến nhánh main.

* jobs:: Xác định các công việc (jobs) sẽ được thực hiện. Trong ví dụ này, có hai jobs: build và deploy.

* build job:

    * runs-on:: Chỉ định môi trường để chạy job (ở đây là ubuntu-latest).
    * Các bước (steps):
        * Checkout mã nguồn từ repository.
        * Cài đặt môi trường Node.js.
        * Cài đặt các dependencies từ package.json.
        * Chạy kiểm thử (nếu có).
        * Build dự án.
* deploy job:

    * Job này chạy sau khi job build hoàn thành thành công (needs: build).
    * Thiết lập SSH để kết nối với server triển khai.
    * Triển khai dự án bằng cách kéo mã mới về từ repository và khởi động lại ứng dụng.
4. Thiết lập Secrets
Để bảo mật, bạn nên lưu các thông tin nhạy cảm như SSH keys, token, hoặc thông tin đăng nhập vào GitHub Secrets. Bạn có thể thiết lập chúng từ repository của mình:

* Vào repository của bạn trên GitHub.
* Chọn Settings.
* Chọn Secrets and variables > Actions.
* Nhấn vào New repository secret để thêm secrets.
5. Kiểm tra và sử dụng CI/CD Pipeline
Sau khi bạn đã đẩy tệp workflow lên repository, GitHub Actions sẽ tự động chạy pipeline mỗi khi có push hoặc pull request đến nhánh main. Bạn có thể xem tiến trình của pipeline trong tab "Actions" trên GitHub.