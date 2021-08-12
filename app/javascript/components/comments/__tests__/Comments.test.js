import React from 'react';
import renderer from "react-test-renderer";
import Comments from "../Comments";

describe('Comments', () => {
  it('Renders default Comments', () => {
    const component = renderer.create(
      <Comments greeting={'Ciao :)'} lesson_id={5}/>
    );

    let tree = component.toJSON();
    expect(tree).toMatchSnapshot();
  });
});
