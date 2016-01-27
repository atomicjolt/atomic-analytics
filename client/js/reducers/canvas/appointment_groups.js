"use strict";

import Immutable   from "immutable";
import CanvasConstants  from "../constants/canvas";
import ErrorTypes  from "../constants/error";
import _ from "lodash";

const initialState = Immutable.fromJS({});

export default (state = initialState, action) => {

  switch(action.type){

    case ActionTypes.LIST_APPOINTMENT_GROUPS:
      const accounts = _.reduce(action.payload, (result, account) => {
        return result[account.id] = account;
      }, {});
      return state.set("accounts", accounts);
      break;

