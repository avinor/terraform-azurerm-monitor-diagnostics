variables {

  name          = "subscription"
  destination   = "/subscriptions/000000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.EventHub/namespaces/namespaceValue/authorizationRules/authorizationRuleValue"
  eventhub_name = "diagnostics"

  target_ids = [
    "/subscriptions/000000000-0000-0000-0000-000000000000",
  ]

  logs = [
    "Administrative",
    "Security",
    "ServiceHealth",
    "Alert",
    "Recommendation",
    "Policy",
    "Autoscale",
    "ResourceHealth",
  ]

}

run "simple" {
  command = plan

  assert {
    condition     = azurerm_monitor_diagnostic_setting.main["/subscriptions/000000000-0000-0000-0000-000000000000"].name == "subscription-diag"
    error_message = "Diagnostic name did not match expected"
  }

  assert {
    condition     = azurerm_monitor_diagnostic_setting.main["/subscriptions/000000000-0000-0000-0000-000000000000"].target_resource_id == "/subscriptions/000000000-0000-0000-0000-000000000000"
    error_message = "Target Resource ID did not match expected"
  }

  assert {
    condition     = azurerm_monitor_diagnostic_setting.main["/subscriptions/000000000-0000-0000-0000-000000000000"].eventhub_authorization_rule_id == "/subscriptions/000000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.EventHub/namespaces/namespaceValue/authorizationRules/authorizationRuleValue"
    error_message = "EventHub Authorization Rule ID did not match expected"
  }

  assert {
    condition     = azurerm_monitor_diagnostic_setting.main["/subscriptions/000000000-0000-0000-0000-000000000000"].eventhub_name == "diagnostics"
    error_message = "EventHub Name did not match expected"
  }

  assert {
    condition     = length(azurerm_monitor_diagnostic_setting.main["/subscriptions/000000000-0000-0000-0000-000000000000"].enabled_log) == 8
    error_message = "Length of Enabled Log did not match expected"
  }

  assert {
    condition     = length(azurerm_monitor_diagnostic_setting.main["/subscriptions/000000000-0000-0000-0000-000000000000"].metric) == 0
    error_message = "Length of Metrics did not match expected"
  }

}