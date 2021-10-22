import { LightningElement } from 'lwc';

export default class ShowAllTripThisCustomer extends LightningElement {
    idCase;

    connectedCallback () {
        this.getIdCase();
    }

    getIdCase() {
        this.idCase = window.location.pathname.split('/').slice(4,5);
        
    }  
}