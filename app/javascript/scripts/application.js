import 'unpoly'
import { saveAs } from 'file-saver'
import * as htmlToImage from 'html-to-image';
import { toPng, toJpeg, toBlob, toPixelData, toSvg } from 'html-to-image';

up.compiler('.js-screen-upload', (element, screenId) => {
  const upload = element

  upload.addEventListener('change', function(e) {
    readURL(this, screenId)
  })
  upload.addEventListener('mouseover', event => {
    document.querySelector(screenId).classList.add('bg-sky-400')
  })
  upload.addEventListener('mouseout', event => {
    document.querySelector(screenId).classList.remove('bg-sky-400')
  })

  const readURL = (input, screenId) => {
    if (input.files && input.files[0]) {
      let reader = new FileReader()
      reader.onload = (e) => {
        document.querySelector(screenId).src = e.target.result
      }
      reader.readAsDataURL(input.files[0])
    }
  }

  return () => {
    element.removeEventListener('change')
  }
})

up.compiler('#js-download', (element) => {
  const FileSaver = require('file-saver');
  const downloadButton = element
  const mockup = document.querySelector('#mockup')

  downloadButton.addEventListener('click', event => {
    htmlToImage.toPng(mockup, {height: 2000}).then(function (dataUrl) {
      FileSaver.saveAs(dataUrl)
  })
  .catch(function (error) {
    console.error('oops, something went wrong!', error);
  });
  })
})
