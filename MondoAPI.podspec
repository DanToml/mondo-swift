Pod::Spec.new do |s|
  s.name         = "MondoAPI"
  s.version      = "0.0.1"
  s.summary      = "A short description of MondoAPI."
  s.description  = <<-DESC
                   DESC
  s.source_files  = "Classes", "MondoAPI/*.{swift,h}"
  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  
  s.dependency "Result", "~> 1.0.2"
  s.dependency "Interstellar", "~> 1.4.0"
end
