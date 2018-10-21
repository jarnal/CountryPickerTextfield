Pod::Spec.new do |s|
  s.name         = "CountryPickerTextfield"
  s.version      = "0.2"
  s.summary      = "TextField with country selection on left"
  s.description  = <<-DESC
    TextField with country selection on left allowing to add country context to a textfield
  DESC
  s.homepage     = "https://github.com/jarnal/CountryPickerTextfield.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Jonathan Arnal" => "jonathan.arnal89@gmail.com" }
  s.social_media_url   = ""
  s.ios.deployment_target = "10.0"
  s.source       = { :git => "https://github.com/jarnal/CountryPickerTextfield.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.resource_bundles = {'UniversalPhoneNumberKit' => ['Resources/**/*']}
  s.frameworks  = "Foundation"

  s.dependency 'SnapKit'
  s.dependency 'PhoneNumberKit'
end
