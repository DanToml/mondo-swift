Pod::Spec.new do |s|
  s.name         = "MonzoAPI"
  s.version      = "0.0.1"
  s.summary      = "A short description of MonzoAPI."
  s.description  = <<-DESC
                   DESC
  s.source_files  = "Classes", "MonzoAPI/*.{swift,h}"
  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  s.dependency "Result", "~> 1.0.2"
  s.dependency "Interstellar", "~> 1.4.0"
end
