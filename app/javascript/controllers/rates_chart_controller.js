import { Controller } from "@hotwired/stimulus"
import c3 from 'c3'

// Connects to data-controller="rates-chart"
export default class extends Controller {
  static values = {
    data: Array
  }

  connect() {
    this.showChart();
  }

  showChart() {
    const chart = c3.generate({
      bindto: "#chart-rates",
      data: {
        x: 'x',
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
