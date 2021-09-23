import 'unpoly'

up.compiler('.js-screen-upload', () => {
  const uploads = document.querySelectorAll('.js-screen-upload')

  uploads.forEach((upload, screenId) => {
    upload.addEventListener('change', function(e) {
      readURL(this, screenId)
      console.log(this, screenId)
    })
    upload.addEventListener('mouseover', event => {
      document.querySelector(`#js-screen-img-${screenId}`).classList.add('bg-sky-400')
    })
    upload.addEventListener('mouseout', event => {
      document.querySelector(`#js-screen-img-${screenId}`).classList.remove('bg-sky-400')
    })
  })

  const readURL = (input, screenId) => {
    console.log(input, screenId)
    if (input.files && input.files[0]) {
      let reader = new FileReader()
      reader.onload = (e) => {
        document.querySelector(`#js-screen-img-${screenId}`).src = e.target.result
      }
      reader.readAsDataURL(input.files[0])
    }
  }

  return () => {
    element.removeEventListener('change')
  }

})
