Gem::Specification.new do |spec|
  spec.name     = "my-sites-theme"
  spec.version  = "0.1.0"
  spec.authors  = ["Martijn Froeling"]
  spec.summary  = "Small shared Jekyll theme for the QMRITools, Muscle Atlas, 7T MRI and Biomotive websites."
  spec.homepage = "https://github.com/mfroeling/my-sites-theme"
  spec.license  = "MIT"

  spec.files = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README)!i) }

  spec.add_runtime_dependency "jekyll", ">= 4.0", "< 5.0"
end
