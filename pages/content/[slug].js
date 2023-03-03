export default function Contents() {
  return <pre>contents</pre>;
}

Contents.getInitialProps = async () => {
  const resp = await fetch(`http://localhost:3000/api/contents`);
  return { list: resp}
}