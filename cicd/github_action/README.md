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
* Setup Github action 


### Setup github registry
Gitlab cho chúng ta free private registry cho mỗi repository và unlimited storage để lưu trữ docker images. Tức là với mỗi repo bạn có thể lưu bao nhiêu image tương ứng tuỳ thích.

<img loading="lazy" width="800px" src="./images/github_registry_price.jpg" alt="Pricing" />
* Đầu tiên, muốn login vào gitlab registry bằng commandline, chúng ta cần tạo asscess token có đầy đủ quyền truy cập vaò registry:
    * Huớng dẫn tạo acctesss token có thể đọc tại [đây](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)
    * Câu lệnh login vào gitlab registry:
        ` docker login registry.gitlab.com -u $USER_NAME -p $PASSWORD`
        Ở đây password chính là access token mà chúng ta mới tạo ở trên
* Sau đó, chúng ta truy cập vào phần registry của repository để xem tên của image được lưu trên registry:
<img loading="lazy" width="800px" src="./images/container_registry.png" alt="Gitlab Registry" />

### Setup Gitlab-CI:
Các bạn tạo cho mình 1 file tên là .gitlab-ci.yml. Đây là 1 file đặc biệt 😄, khi commit code lên GItlab, Gitlab sẽ phát hiện nếu có file này thì quá trình CICD sẽ được kích hoạt sau khi code được commit.

Chúng ta thêm vào nội dung file này như sau:
```
    # This file is a template, and might need editing before it works on your project.
# To contribute improvements to CI/CD templates, please follow the Development guide at:
# https://docs.gitlab.com/ee/development/cicd/templates.html
# This specific template is located at:
# https://gitlab.com/gitlab-org/gitlab/-/blob/master/lib/gitlab/ci/templates/Python.gitlab-ci.yml

# Official language image. Look for the different tagged releases at:
# https://hub.docker.com/r/library/python/tags/
image: python:latest

# Change pip's cache directory to be inside the project directory since we can
# only cache local items.
variables:
  PIP_CACHE_DIR: "$CI_PROJECT_DIR/.cache/pip"

# https://pip.pypa.io/en/stable/topics/caching/
cache:
  paths:
    - .cache/pip

before_script:
  - python --version ; pip --version  # For debugging
  - pip install virtualenv
  - virtualenv venv
  - source venv/bin/activate

build:
  image: docker:20.10.16
  services:
    - docker:20.10.16-dind
  variables:
    IMAGE_NAME: registry.gitlab.com/anhtrankstn/ai-stoke
    DOCKER_TLS_CERTDIR: "/certs"

  before_script:
    - echo $ACCESS_TOKEN
    - export IMAGE_TAG=$(cat api_version.txt)
    - echo "$ACCESS_TOKEN" | docker login registry.gitlab.com -u $USER_NAME --password-stdin
  script:
    - docker build -t $IMAGE_NAME:$IMAGE_TAG -f Dockerfile.flaskApp .
    - docker push $IMAGE_NAME:$IMAGE_TAG
deploy:
  stage: deploy
  script:
    - apt-get update && apt-get install rsync -y && apt-get install openssh-server -y
    - mkdir -p ~/.ssh
    - ssh-keyscan -H "$PRODUCT_SERVER_IP" >> ~/.ssh/known_hosts
    - chmod 644 ~/.ssh/known_hosts
    - echo "$PRODUCT_SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
    - chmod 700 ~/.ssh/id_rsa
    - echo "$PRODUCT_SSH_KEY" > ~/.ssh/id_rsa.publ
    - chmod 700 ~/.ssh/id_rsa.pub
    - ssh linuxuser@$PRODUCT_SERVER_IP 'cd /home/linuxuser/stoke && ./gitlab_login.sh && cd /home/linuxuser/stoke/ai-stoke && docker compose up -d'
  environment: production

```
Trước khi tìm hiểu về nội dung file này mình sẽ giải thích điều gì sẽ xảy ra ở quá trình CICD nhé:

* Khi các bạn commit code và có chứa file .gitlab-ci.yml thì quá trình CICD sẽ được khởi động
* Gitlab sẽ tạo ra 1 pipeline, pipeline chính là toàn bộ những gì trong file .gitlab-ci.yml của chúng ta,  pipeline này sẽ chứa nhiều jobs, các jobs này sẽ được gửi tới các Gitlab Runners, mỗi 1 con runner ở đây có thể hiểu là 1 worker, chúng sẽ tạo ra 1 môi trường riêng để chạy job của chúng ta và khi kết thúc thì trả kết quả lại về cho Gitlab.
* Mặc định Gitlab họ có nhiều Share Runners dùng chung cho tất cả mọi người, cá nhân mình thấy project vừa và nhỏ thì vẫn đủ để chạy CICD, job của chúng ta không phải pending (chờ) nhiều, nhưng nếu các bạn có nhu cầu chạy nhiều CICD pipeline thì các bạn có thể cài Gitlab runner về server riêng của các bạn và không phải share với ai cả

Các thành phần cơ bản sẽ bao gồm như sau:

* Danh sách các bước (stage) sẽ thực hiện
* Các công việc (job) cần được thực hiện của stage đi kèm với danh sách câu lệnh
* Các biến môi trường cần sử dụng cho toàn bộ các công việc hoặc từng job (nếu có)
* Các tập tin cần thiết từ các repository khác cần được thêm (nếu có)
* Docker image cần sử dụng cho các job (nếu có)
* Danh sách các câu lệnh cần được thực thi trước và sau khi thực thi job (nếu có)
* Tag dùng để chỉ định runner nào được chọn để thực thi job (nếu có)

<img loading="lazy" width="800px" src="./images/gitlab_cicd_params.png" alt="Gitlab Registry" />

### Stages: các bước cần thực hiện
Từ khóa này đực sử dụng để khai báo và thứ tự các bước (stage) mà pipeline của người dùng sẽ có. Nếu như không được khai báo trong file gitlab-ci.yaml, pipeline của người dùng sẽ bao gồm các stage mặc định của Gitlab:
– .pre
– build
– test
– deploy
– .post
 

Người dùng có thể tự khai báo các stage với cách đặt tên và thứ tự các stage theo nhu cầu của mình, không yêu cầu phải giống như cấu hình mặc định của Gitlab. Ví dụ:
```
stages:
 - linter
 - unit-test
 - build-image
 - deploy-service

```
Một stage sẽ có thể bao gồm nhiều job khác nhau, nhưng 1 job thì chỉ thuộc 1 stage. Những job nào không khai báo “stage” thì sẽ mặc định được cấu hình thuộc stage “test”. Các job thuộc cùng 1 stage sẽ được xử lý đồng thời (parallel) tùy theo số lượng runner hiện có của repo.
Các stage sẽ được thực thi 1 cách tuần tự, từ trên xuống dưới. Khi stage đầu tiên thực thi “thành công” các job của mình thì stage tiếp theo sẽ bắt đầu xử lý các job cả mình. Quá trình này sẽ do người dùng quy định dựa vào cách liệt kê và sắp xếp các stage. 
 ### Job: các công việc cần thực hiện của từng stage
 Các job sẽ được người dùng khai báo bằng cách đặt tên không trùng với các từ khóa mặc định của Gitlab-CI (default, stages, variables,…). Nội dung của 1 job sẽ cơ bản bao gồm:
– stage: tên của stage mà job thuộc về. Nếu không khai báo thì mặc định job sẽ thuộc về stage “test”
– script: danh sách các câu lệnh mà job sẽ thực hiện
– image: Docker image được sử dụng cho job (chỉ áp dụng đối với executor là Docker)
– variables: danh sách các biến môi trường của job (tùy chọn – không bắt buộc)
– tags: danh sách các tag dùng để chỉ định runner nào sẽ thực thi job

Ví dụ:
```
unit-test-job:        # Job có tên là unit-test-job
  stage: test         # Thuộc stage "test"
  image: python:3.6   # Docker image sử dụng để thực thi job (chỉ áp dụng đối với executor là Docker)
  tags:               # Những runner được đánh tag thuộc danh sách đã liệt kê sẽ thực thi job
    - testing
    - python
  script:             # Danh sách câu lệnh mà job này sẽ thực hiện
    - command test 1
    - command test n

```

#### script: các câu lệnh job sẽ thực thi
Từ khóa này được khai báo bên trong từng job và sử dụng để liệt kê danh sách các câu lệnh cần được thực thi của các job. Mỗi job sẽ cần được khai báo cách “script” để executor có thể thực hiện.

#### stage: khai báo job thuộc stage được chỉ định (tùy chọn)
Từ khóa này được sử dụng bên trong các job để khai báo job sẽ thuộc một stage trong danh sách đã khai báo trước đó. Nếu như danh sách stage khác với cấu hình mặc định của Gitlab, bạn cần thêm trường này để xác định rõ job sẽ thuộc stage nào trong pipeline. Nếu không được định nghĩa, job sẽ mặc định thuộc stage “test”.

#### image: chỉ áp dụng khi executor là docker (tùy chọn)
Từ khóa này được sử dụng để khai báo Docker image mặc định sử dụng cho toàn bộ các job hoặc chỉ sử dụng cho 1 job cụ thể nếu “executor” của runner là docker.

#### tags: dùng để chọn runner xử lý job (tùy chọn)
Khi sử dụng từ khóa này, người dùng có thể chỉ định được runner nào sẽ nhận và xử lý job bằng các liệt ê các tag tương ứng. Mặc định chỉ những runner được đánh tag cùng tên với danh sách đã liệt kê sẽ có quyền xử lý job, những runner còn lại nếu chưa được đánh tag sẽ “hầu như” không được nhận job. Cách đặt tên tag là do người dùng quyết định.

#### variables: biến môi trường (tùy chọn)
Từ khóa này được sử dụng để khai báo các biến môi trường được sử dụng toàn bộ các job hoặc cho từng job cụ thể nếu được khai báo bên trong các job. 

#### before_script: các câu lệnh job sẽ thực thi (tùy chọn)
Từ khóa này được sử dụng để liệt kê danh sách các câu lệnh cần được thực thi trước khi vào các câu lệnh chính của job được thực hiện. Bạn có thể sử dụng từ khóa này để áp dụng cho toàn bộ các job nếu khai báo bên từ khóa này không thuộc bất kỳ job nào cả.


#### after_script: các câu lệnh job sẽ thực thi (tùy chọn)
Từ khóa này được sử dụng để liệt kê danh sách câu lệnh cần được thực thi sau khi “script” bên trên đã thực thi xong. Bạn có thể sử dụng từ khóa này để tiến hành các câu lệnh mang tính chất “dọn dẹp” sau khi đã thực thi xong công việc để giải phóng tài nguyên của hệ thống được sinh ra trong quá trình thực thi “script”.