Pod::Spec.new do |s|
    s.name        = "BlowinSwiper"
    s.version     = "1.0.13"
    s.summary     = "BlowinSwiper makes it possible to swipe back from anywhere on the screen."
    s.description = <<-DESC
                    BlowinSwiper makes it possible to swipe back from anywhere on the screen at UINavigationController!
                    DESC
    s.homepage         = "https://github.com/horitaku46/BlowinSwiper"
    s.license          = { :type => "MIT", :file => "./LICENSE" }
    s.author           = { "Takuma Horiuchi" => "horitaku46@gmail.com" }
    s.social_media_url = "https://twitter.com/horitaku46"
    s.platform         = :ios, "10.0"
    s.source           = { :git => "https://github.com/horitaku46/BlowinSwiper.git", :tag => "#{s.version}" }
    s.source_files     = "BlowinSwiper/**/*.{swift}"
    s.swift_version    = "4.0"
end
