#
# バージョンを変えた場合はlib/hondana.rbとMakefileのバージョン番号を変えること
#
VERSION=0.1.1

localinstall:
	rake package
	sudo gem install pkg/hondana-${VERSION}.gem
always:
test: always
	rake test
gempush:
	rake package
	gem push pkg/hondana-${VERSION}.gem
gitpush:
	git push pitecan.com:/home/masui/git/hondana-ruby.git
	git push git@github.com:masui/hondana-ruby.git


