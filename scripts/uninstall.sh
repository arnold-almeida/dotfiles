# TODO - rewrite in node
# task :uninstall do

#   Dir.glob('**/*.symlink').each do |linkable|

#     file = linkable.split('/').last.split('.symlink').last
#     target = "#{ENV["HOME"]}/.#{file}"

#     # Remove all symlinks created during installation
#     if File.symlink?(target)
#       FileUtils.rm(target)
#     end

#     # Replace any backups made during installation
#     if File.exists?("#{ENV["HOME"]}/.#{file}.backup")
#       `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"`
#     end

#   end
# end