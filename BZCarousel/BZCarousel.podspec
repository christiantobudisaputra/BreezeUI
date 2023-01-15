Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.name         = "BZCarousel"
  spec.version      = "0.0.1"
  spec.summary      = "BZCarousel is an open-source SwiftUI library providing customizable carousel options for iOS apps."
  spec.description  = <<-DESC
BZCarousel is an open-source SwiftUI library providing customizable carousel options for iOS apps. It's easy to integrate with your existing codebase, and it's built with the latest iOS features in mind.
                        DESC
  spec.homepage     = "https://github.com/christiantobudisaputra/BreezeUI"

  
  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.author             = { "Christianto Budisaputra" => "93509382+christiantobudisaputra@users.noreply.github.com" }


  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.platform     = :ios, "14.0"
  spec.swift_version = "5"

 
  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.source       = { :git => "https://github.com/christiantobudisaputra/BreezeUI.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.source_files  = "BZCarousel/BZCarousel/**/*"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.frameworks = "SwiftUI", "Combine"

 
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.dependency "SDWebImageSwiftUI"


end
