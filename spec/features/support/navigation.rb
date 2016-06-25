def ensure_on(path)
  visit path unless page.current_path == path
end
