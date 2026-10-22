[
  { name: "Billing revamp", status: "active", archived: false },
  { name: "Mobile onboarding", status: "blocked", archived: false },
  { name: "Legacy importer", status: "done", archived: true }
].each do |attributes|
  Project.find_or_create_by!(name: attributes[:name]) do |project|
    project.assign_attributes(attributes)
  end
end
