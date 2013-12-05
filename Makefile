BUILDDIR = build
S3BUCKET = chef-docs
S3OPTIONS = --delete-removed --acl-public --exclude='.doctrees/*' --exclude='chef/.doctrees/*' --config ~/.s3cfg-chef-docs  --add-header "Cache-Control: max-age=900"

release: master enterprise open_source all

#
# OTHER BUILDS -- REMOVED FOR THE MOMENT AND ONLY REBUILD AD HOC
#
#   11-4 11-6 11-8 oec_11-0
# 
# OLDER BUILDS -- REMOVED, UNLIKELY TO REBUILD
# 
#   server
# 


clean:
	@rm -rf $(BUILDDIR)

master:
	mkdir -p $(BUILDDIR)
	cp -r misc/robots.txt build/
	sphinx-build chef_master/source $(BUILDDIR)

all:
	mkdir -p $(BUILDDIR)/chef/
	sphinx-build docs_all/source $(BUILDDIR)/chef/

server:
	mkdir -p $(BUILDDIR)/server/
	sphinx-build docs_server/source $(BUILDDIR)/server/

11-4:
	mkdir -p $(BUILDDIR)/release/11-4/
	sphinx-build release_chef_11-4/source $(BUILDDIR)/release/11-4/

11-6:
	mkdir -p $(BUILDDIR)/release/11-6/
	sphinx-build release_chef_11-6/source $(BUILDDIR)/release/11-6/

11-8:
	mkdir -p $(BUILDDIR)/release/11-8/
	sphinx-build release_chef_11-8/source $(BUILDDIR)/release/11-8/

oec_11-0:
	mkdir -p $(BUILDDIR)/release/oec_11-0/
	sphinx-build release_oec_11-0/source $(BUILDDIR)/release/oec_11-0/

enterprise:
	mkdir -p $(BUILDDIR)/enterprise/
	sphinx-build docs_oec/source $(BUILDDIR)/enterprise/

open_source:
	mkdir -p $(BUILDDIR)/open_source/
	sphinx-build docs_osc/source $(BUILDDIR)/open_source/

upload:	release
	s3cmd sync $(S3OPTIONS) $(BUILDDIR)/ s3://$(S3BUCKET)/

gettext:
	sphinx-build -b gettext docs_all/source build/locale-all
	sphinx-build -b gettext chef_master/source build/locale-master
	@echo
	@echo "Build finished. The message catalogs are in $(BUILDDIR)/locale."

epub:
	sphinx-build -b epub docs_all/source build/epub-all
	sphinx-build -b epub chef_master/source build/epub-master
	@echo
	@echo "Build finished. The epub file is in $(BUILDDIR)/epub."


text:
	sphinx-build -b text docs_all/source build/text-all
	sphinx-build -b text chef_master/source build/text-all
	@echo
	@echo "Build finished. The text files are in $(BUILDDIR)/text."
