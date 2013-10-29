namespace :deploy do

    BUILD_HASH_FILE = '_includes/version.html'

    GIT_DESCRIBE_CMD = '`git describe --tags`'

    #GIT_DESCRIBE_CMD = 'NO-BUILD'

    S3_CONFIG_FILE = 's3_website.yml'

    JEKYLL_BUILD_CMD = 'jekyll build'

    desc "Generates a file in a configured location with 'git describe' output for a build hash"
    task :generate_build_hash do
        puts "Generating build hash file: '#{BUILD_HASH_FILE}'"

        %x{echo #{GIT_DESCRIBE_CMD} > #{BUILD_HASH_FILE}}

    end

    desc "Clean the _site dir"
    task :clean_site_dir do
        `rm -rf _site/*`
    end

    desc "Run Jekyll to build site"
    task :build_site do

        puts "Jekyll is building the site..."

        puts `#{JEKYLL_BUILD_CMD}`

    end

    desc "Deploy Jekyll static site with 's3_website' gem"
    task :deploy_site do |t, args|

        interactive = args[:interactive] || true

        #check s3 config exists
        raise "File #{S3_CONFIG_FILE} does not exist!" unless File.exists?(S3_CONFIG_FILE)

        puts "Uploading site in interactive mode: '#{interactive}'..."

        if interactive == true then

            #use this if you want to display to STDOUT & basically run interactively
            exec('s3_website push')

        else

            #Run in headless mode automatically deletes stuff
            puts `s3_website push --headless`

        end

    end

    desc "Run all deployment tasks. pass true into interactive to run in interactive mode."
    task :go, [:interactive] => [:generate_build_hash, :clean_site_dir, :build_site, :deploy_site] do |t, args|

        puts "Done."
        
    end

end