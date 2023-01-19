import { Controller } from "stimulus"
import axios from "axios"


export default class extends Controller {
  static targets = [ "followButton", "bookmark" ]

  follow(event){
    event.preventDefault()

    let user = this.followButtonTarget.dataset.user        //把超連結抓出來
    let button = this.followButtonTarget
    // /users/:id/follow
    axios.post(`/api/users/${user}/follow`)
        .then(function(response){
          let status = response.data.status
          switch(status){
            case 'sing_in_first':
              alert('你必須先登入')
              break
            default:
              button.innerHTML = status
          }
        })
        .catch(function(error){       //出錯時可以catch起來
          console.log(error)
        })
  }

  bookmark(event){
    event.preventDefault()

    let link = event.currentTarget
    let slug = link.dataset.slug

    axios.post(`/api/stories/${slug}/bookmark`)
      .then(function(response){
        console.log(response.data)
      })
      .catch(function(error){           //出錯時可以catch起來
        console.log(error)
      })
  }
}
