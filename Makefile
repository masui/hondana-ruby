#
# バージョンを変えた場合はlib/hondana.rbとMakefileのバージョン番号を変えること
#
push:
	echo 'make gempush/gitpush'
gempush:
	rake package
	gem push pkg/hondana-0.0.1.gem
gitpush:
	git push pitecan.com:/home/masui/git/hondana-ruby.git
	git push git@github.com:masui/hondana-ruby.git


