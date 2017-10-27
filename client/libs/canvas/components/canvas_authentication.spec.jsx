import _ from 'lodash';
import React from 'react';
import TestUtils from 'react-dom/test-utils';
import { CanvasAuthentication } from './canvas_authentication';
import Stub from 'atomic-fuel/libs/specs_support/stub';

describe('Canvas authentication', () => {
  it('renders a button to authenticate with Canvas', () => {
    const settings = {
      canvas_oauth_url: 'http://www.example.com'
    };
    const result = TestUtils.renderIntoDocument(
      <Stub><CanvasAuthentication settings={settings} /></Stub>
    );
    const inputs = TestUtils.scryRenderedDOMComponentsWithTag(result, 'input');
    const foundAuthorize = _.find(inputs, input => input.value === 'Authorize');
    expect(_.isUndefined(foundAuthorize)).toBe(false);
  });
});
