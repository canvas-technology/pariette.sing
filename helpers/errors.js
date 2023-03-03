export default function errros(what) {
  let msg = 'some error'
  switch (what) {
    case 400:
      msg = 'method not allowed'
      break;
    case 404:
      msg = 'content not found'
      break;
    default:
      msg = 'some error'
      break;
  }
  return msg
}
