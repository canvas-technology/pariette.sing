import * as React from 'react';
import type { ReactElement } from 'react'
import Layout from '../components/layout'
import Head from 'next/head'
import endpoint from '../helpers/endpoints';
import styles from '@/styles/Home.module.css'
import type { NextPageWithLayout } from './_app'
import Link from 'next/link'

const Page: NextPageWithLayout = ({ canvas }) => {
  return (
    <>
      <Head>
        <title>evet</title>
        <meta name="description" content="react geliyor" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className={styles.main}>
      {canvas.contents.map( (r: {
          id: React.Key | null | undefined;
          title: string | number | boolean | React.ReactElement<any, string | React.JSXElementConstructor<any>> | React.ReactFragment | React.ReactPortal | null | undefined;
          content: string | number | boolean | React.ReactElement<any, string | React.JSXElementConstructor<any>> | React.ReactFragment | React.ReactPortal | null | undefined;
        }) => (
          <div key={r.id}>
            <h1>{r.title}</h1>
            <p>{ r.content }</p>
          </div>
        ))}
      </main>
    </>
  )
}


Page.getLayout = function getLayout(page: ReactElement) {
  return (
    <Layout>
      {page}
    </Layout>
  )
}

export async function getServerSideProps({ params }) {
  console.log(params.slug)
  const res = await fetch(`${endpoint.getCanvas}/${params.slug}?withContent=true`)
  const data = await res.json()
  // console.log(data)
  return {
    props: { canvas: data }
  }
}

export default Page