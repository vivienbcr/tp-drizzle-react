import React from "react";
import { newContextComponents } from "@drizzle/react-components";
import { Card } from "../src/ships/Card/Card.controller";

const { AccountData, ContractData, ContractForm } = newContextComponents;

const drizzleComp = ({ drizzle, drizzleState }) => {
  return (<div className="App">
    <div className="section">
      <h2>Active Account</h2>
      <AccountData drizzle={drizzle} drizzleState={drizzleState} accountIndex={0} units="ether" precision={3} />
      <ContractData drizzle={drizzle} drizzleState={drizzleState} contract="fightGame" method="GetPlayer"  />
    </div>
    <div className="section">
      <h2>Create Player</h2>
      <ContractForm drizzle={drizzle} drizzleState={drizzleState} contract="fightGame" method="CreatePlayer" sendArgs={{ from: drizzleState.accounts[7], gas: 3000000 }} />
    </div>
    <ContractData drizzle={drizzle} drizzleState={drizzleState} contract="fightGame" method="GetAllPlayers" />

    <div className="section">
      <h2>FIGHT NOW !</h2>
    <ContractForm drizzle={drizzle} drizzleState={drizzleState} contract="fightGame" method="Fight" sendArgs={{from: drizzleState.accounts[4], gas: 3000000 }}/>
    </div>
  </div>);
}

export default drizzleComp;

