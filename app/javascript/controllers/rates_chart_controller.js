import { Controller } from "@hotwired/stimulus"
import c3 from 'c3'


// Connects to data-controller="rates-chart"
export default class extends Controller {
  static values = {
    data: Array
  }

  connect() {
    this.initializeChart();
    console.log(this.dataValue)
  }

  initializeChart() {
    const chart = c3.generate({
      bindto: "#chart",
      data: {
        x: 'x',
//        xFormat: '%Y%m%d', // 'xFormat' can be used as custom format of 'x'
        columns: this.dataValue
      },
      axis: {
        x: {
          type: 'timeseries',
          tick: {
            format: '%Y-%m-%d'
          }
        }
      }
    });
  }
}
