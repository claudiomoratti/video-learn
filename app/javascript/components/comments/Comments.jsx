import React from 'react'

const Comments = ({greeting, lesson_id}) => {

  return (
    <div>
      <span>{greeting}</span>
      <span>{lesson_id}</span>
    </div>
  )
}

export default Comments;
