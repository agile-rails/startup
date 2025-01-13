module ApplicationHelper

#########################################################################################################
# Will prepare all_options form for display on a web
#########################################################################################################
def prepare_all_options_yaml
  help, html = '', ''
  ar = File.read(AgileHelper.form_file_find('all_options') )
      .gsub(" ", "&nbsp;")
      .split("\n")

  ar.each_with_index do |line, index|
    if line[0, 2] == '##'
      help += line[2..]
      next
    end

    if help.present?
      html += %(<span class="form-key-help">#{update_links(help)}</span>\n)
      help = ''
    end

    i = line.index(":")
    if i
      clas = ar[index + 1][0, 2] == '##' ? 'with-help' : 'no-help'
      line = %(<span class="form-key #{clas}">#{line[..i]}</span>#{line[i+1..]})
    end

    i = line.index("#")
    line = case i
           when nil then line
           when 0 then %(<span class="comment">#{line}</span>)
           else
             %(#{line[..i-1]}<span class="comment">#{line[i..]}</span>) if i
           end

    html += line + "<br>"
  end
  html.html_safe
end

private

#########################################################################################################
def update_links(text)
  while (start = text.index('link='))
    the_end = text.index('&nbsp;', start)
    link, txt = text[(start + 5)..(the_end-1)].split(',')
    link = %(<a href="#{link}" target="_blank">#{txt}</a>)
    text = text[..(start - 1)] + link + text[the_end..]
  end
  text
end

end
