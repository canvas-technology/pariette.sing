import * as React from 'react';
import Box from '@mui/material/Box';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import InboxIcon from '@mui/icons-material/Inbox';

export default function Contents({ rows }) {
  return (
    <Box sx={{ width: '100%', maxWidth: 360 }}>
      <nav aria-label="main mailbox folders">
        <List>
          {rows.map( r => (
            <ListItem key={r.id} dark>
              <ListItemButton>
                <ListItemIcon>
                  <InboxIcon />
                </ListItemIcon>
                <ListItemText>
                {r.title}
                </ListItemText>
              </ListItemButton>
            </ListItem>
          ))}
        </List>
      </nav>
    </Box>
  );
}

export async function getServerSideProps() {
  const res = await fetch('http://localhost:3000/api/contents')
  const data = await res.json()
  return {
      props: { rows: data },
  };
}
