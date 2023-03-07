import * as React from 'react';
import type { ReactElement } from 'react'
import Layout from '../components/layout'
import Head from 'next/head'
import endpoint from '../helpers/endpoints';
import styles from '@/styles/Home.module.css'
import type { NextPageWithLayout } from './_app'
import Link from 'next/link'

const Page: NextPageWithLayout = ({ mySite, homeCanvas }) => {
  return (
    <>
      <Head>
        <title>{mySite.title}</title>
        <meta name="description" content={mySite.description} />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className={styles.main}>
        <h1>{mySite.title}</h1>
        <h3>{homeCanvas.title}</h3>
        {homeCanvas.contents[0].title}
      {/* {mySite.contents.map( (r: {
          id: React.Key | null | undefined;
          title: string | number | boolean | React.ReactElement<any, string | React.JSXElementConstructor<any>> | React.ReactFragment | React.ReactPortal | null | undefined;
          content: string | number | boolean | React.ReactElement<any, string | React.JSXElementConstructor<any>> | React.ReactFragment | React.ReactPortal | null | undefined;
        }) => (
          <Link
            key={r.id}
            href={{pathname: '/[slug]', query: { slug: mySite.slug }}}
          >
            <h1>{r.title}</h1>
            <p>{ r.content }</p>
          </Link>
        ))} */}
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

export async function getServerSideProps() {
  const siteData = await fetch(endpoint.getSite)
  const canvasData = await fetch(`${endpoint.getCanvas}/pariette_homepage?withContent=true`)
  const data_site = await siteData.json()
  const data_homeCanvas = await canvasData.json()
  return {
    props: {
      mySite: data_site,
      homeCanvas: data_homeCanvas
    }
  }
}

export default Page