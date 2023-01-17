import { Controller } from "stimulus"
import axios from "axios"


export default class extends Controller {
  static targets = [ "followButton" ]

  follow(event){
    event.preventDefault()

    let user = this.followButtonTarget.dataset.user
    
    // /users/:id/follow
    axios.post(`/users/${user}/follow`)
        .then(function(response){
          console.log(response.data)
        })
        .catch(function(error){
          console.log(error)
        })
  }
}
