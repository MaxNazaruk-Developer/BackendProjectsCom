import { LightningElement,track } from 'lwc';

import getTrips from '@salesforce/apex/showAllTripThisCustomerController.getTrips';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Name Trip', fieldName: 'Name' },
    { label: 'Account Id', fieldName: 'AccountId__c'},
    { 
        label: 'Date Create', fieldName: 'CreatedDate', type: 'date', typeAttributes: {
            month: "2-digit",
            day: "2-digit",
            year: "2-digit",
            hour: "2-digit",
            minute: "2-digit"
        },
    }    
];

export default class ShowAllTripThisCustomer extends LightningElement {
    idCase;
    @track data = [];
    columns = columns;

    connectedCallback () {
        [this.idCase] = window.location.pathname.split('/').slice(4,5);
        this.getIdCase();
    }

    getIdCase() {
        getTrips({ 
            idCase: this.idCase         
        })            
        .then(result => {                        
            this.data = JSON.parse(result);                                     
        }) 
        .catch((error) => {           
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error!!',
                message: error.message,
                variant: 'error'
            })); 
        })    
    }  
}