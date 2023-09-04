param apiGateway string
param wbUrl string
param appInsightsId string
param appInsightsName string

var markdownContent = format(
  '''
# API Gateway
Endpoint URL: `{0}`

Endpoint Key: `tbd`


## Title
```
wb url to be used eventually?
{1}
```

### Test title
''', apiGateway, wbUrl)

resource dashboard 'Microsoft.Portal/dashboards@2020-09-01-preview' = {

  name: 'OpenAIDashboard'
  location: 'global'
  properties: {
    lenses: [
      {
        order: 0
        parts: [
          {
            position: {
              x: 0
              y: 0
              colSpan: 4
              rowSpan: 3
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: appInsightsId
                          }
                          name: 'requests/duration'
                          aggregationType: 4 // avg
                          namespace: 'Microsoft.Insights/components'
                          metricVisualization: {
                            displayName: 'Server response time'
                            resourceDisplayName: appInsightsName
                          }
                        }
                      ]
                      title: 'Response time'
                      titleKind: 1
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
            }
          }
          {
            position: {
              x: 0
              y: 0
              rowSpan: 2
              colSpan: 3
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '## OpenAI WorkBook Overview\r\nWelcome to your OpenAI WorkBook dashboard. Here you can find insights and analytics related to your OpenAI interactions.'
                  }
                }
              }
            }
          }
          {
            position: {
              x: 3
              y: 0
              rowSpan: 4
              colSpan: 8
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: 'This dashboard provides you with valuable information and links related to your OpenAI interactions:\r\n\r\n1. [OpenAI WorkBook](#workbookId)\r\n2. [API Management](#apiManagementId)\r\n3. [App Insights](#appInsightsId)'
                  }
                }
              }
            }
          }
          {
            position: {
              x: 3
              y: 0
              rowSpan: 4
              colSpan: 8
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: markdownContent
                  }
                }
              }
            }
          }
          {
            position: {
              x: 0
              y: 2
              rowSpan: 2
              colSpan: 3
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/VideoPart'
              settings: {
                content: {
                  settings: {
                    src: 'https://www.youtube.com/watch?v=rOiSRkxtTeU'
                    autoplay: false
                  }
                }
              }
            }
          }
        ]
      }
    ]
  }
}