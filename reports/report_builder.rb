require 'report_builder'

time = Time.now.getutc

ReportBuilder.configure do |config|
 config.color = 'green'
 config.json_path = 'reports/report.json'
 config.report_path = 'reports/cucumber_web_report'
 config.report_types = [:html]
 config.report_tabs = %w[Overview Features Scenarios Errors]
 config.report_title = 'Test Results'
 config.compress_images = false
 config.additional_info = { 'Project name' => 'Test', 'Platform' => 'Integration', 'Report generated' => time }
end

ReportBuilder.build_report