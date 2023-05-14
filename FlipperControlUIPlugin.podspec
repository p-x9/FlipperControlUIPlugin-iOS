folly_compiler_flags = '-DDEBUG=1 -DFLIPPER_OSS=1 -DFB_SONARKIT_ENABLED=1 -DFOLLY_HAVE_BACKTRACE=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_HAVE_LIBGFLAGS=0 -DFOLLY_HAVE_LIBJEMALLOC=0 -DFOLLY_HAVE_PREADV=0 -DFOLLY_HAVE_PWRITEV=0 -DFOLLY_HAVE_TFO=0 -DFOLLY_USE_SYMBOLIZER=0'

Pod::Spec.new do |spec|

  spec.name         = "FlipperControlUIPlugin"
  spec.version      = "0.0.1"
  spec.summary      = "Plug-in to control iPhone screen from Flipper."

  spec.homepage     = "https://github.com/p-x9/FlipperControlUIPlugin-iOS"


  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author       = { "p-x9" => "p.x9.dev@gmail.com" }

  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://github.com/p-x9/FlipperControlUIPlugin-iOS.git", :tag => "#{spec.version}" }
  spec.source_files  = "FlipperControlUIPlugin/**/*.{swift}",
                       "FlipperControlUIPlugin/FlipperControlUIPlugin.h"

  spec.public_header_files = "FlipperControlUIPlugin/FlipperControlUIPlugin.h"

  spec.static_framework = true
  spec.dependency 'HammerTests'
  spec.dependency 'FlipperKit/Core'

  spec.compiler_flags = folly_compiler_flags
  spec.pod_target_xcconfig = { "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)\"/Headers/Private/FlipperKit/**","ONLY_ACTIVE_ARCH": "YES" }

end
