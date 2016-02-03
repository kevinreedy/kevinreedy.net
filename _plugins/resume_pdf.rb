require 'pdfkit'

Jekyll::Hooks.register :pages, :post_write do |page|
  if page.name == 'resume.html'
    margin = '0.5in'

    kit = PDFKit.new(File.open("#{Jekyll.configuration['destination']}/resume/index.html").read,
      page_size: 'Letter',
      print_media_type: true,
      margin_top: margin,
      margin_bottom: margin,
      margin_left: margin,
      margin_right: margin
    )

    kit.stylesheets << "#{Jekyll.configuration['destination']}/css/main.css"
    file = kit.to_file("#{Jekyll.configuration['destination']}/resume-kevin-reedy.pdf")
    file = kit.to_file("#{Jekyll.configuration['destination']}/resume.pdf")
  end
end
