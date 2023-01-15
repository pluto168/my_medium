import { Controller } from "stimulus"
import axios from "axios"

export default class extends Controller {
  static targets = [ "clapCount" ]

  addClap(event){
    event.preventDefault()
    let slug = event.currentTarget.dataset.slug
    // console.log('go');

    axios.post(`stories/${slug}/clap`)
      .then(function(response){
        console.log(response.data);
      })
      .catch(function(error){
        console.log(error);
      })

    //stories/:id/clap
    // this.clapCountTarget.innerHTML = 'CCH'
  }
}