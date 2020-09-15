setup:
		python3 -m venv ~/.capstone
		#source ~/.capstone/bin/activate

install:
		pip install -r requirements.txt
		#sudo curl --silent --location -o /usr/local/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/kubectl
		#sudo chmod +x /usr/local/bin/kubectl
		#sudo pip install --upgrade awscli && hash -r
		#sudo apt-get install jq gettext bash-completion moreutils
		#kubectl completion bash >>  ~/.bash_completion
		#. /etc/profile.d/bash_completion.sh
		#. ~/.bash_completion
		#curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
test:
		#python -m pytest -vv --cov=myrepolib tests/*.py
		#python -m pytest --nbval notebook.ipynb

validate-circleci:
		# See https://circleci.com/docs/2.0/local-cli/#processing-a-config
		circleci config process .circleci/config.yml
		
run-circleci-local:
		# See https://circleci.com/docs/2.0/local-cli/#running-a-job
		circleci local execute

lint:
		#hadolint Dockerfile
		pylint --disable=R,C,W1203,W1202 app.py
all: install lint test



