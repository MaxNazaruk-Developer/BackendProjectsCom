import { LightningElement } from 'lwc';

import getRelationshipObject from '@salesforce/apex/childAuditorController.getRelationshipObject';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class ChildAuditor extends LightningElement {
    urlObject;
    idObject;
    listRelation = [];

    connectedCallback () {
        this.getRelationshipData();
    }

    clickButtonRefrech() {       
        this.getRelationshipData();
    }

    getRelationshipData () {        
        [this.urlObject, this.idObject] = window.location.pathname.split('/').slice(3,5);                
        getRelationshipObject({ 
            nameObject: this.urlObject,
            idObject: this.idObject 
        })            
        .then(result => {
            console.log('result  ' + result);            
            this.listRelation = JSON.parse(result);                                     
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