import * as React from 'react';
import CssBaseline from '@mui/material/CssBaseline';
import Container from '@mui/material/Container';

// import useSWR from 'swr'
import Navbar from './navbar'
import Footer from './footer'

export default function Layout({children}:{children:any}) {
  // const { data, error } = useSWR('/api/navigation', fetcher)

  // if (error) return <div>Failed to load</div>
  // if (!data) return <div>Loading...</div>

  return (
    <>
    <React.Fragment>
      <CssBaseline />
      <Navbar />
      {/* container seçenekler disableGutters , maxWidth="100%" */}
      <Container>
        <main>{children}</main>
      </Container>
      <Footer />
    </React.Fragment>
    </>
  )
}
