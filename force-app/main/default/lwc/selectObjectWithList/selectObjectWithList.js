import { LightningElement, wire, track } from 'lwc';
import getObject from '@salesforce/apex/getObjectController.getObject';

export default class SelectObjectWithList extends LightningElement {
    value;
    @track dataCombobox =[];
    @track dataResultGetObject = [];
    
    get options() {        
        return this.dataCombobox;        
    }

    @wire(getObject) 
    objectData(result) {       
        const {data,error} = result;
        if (data) {            
            this.dataResultGetObject = JSON.parse(data);            
            let currentData = [];            
            this.dataResultGetObject.forEach( row => {
                let rowData = {};                                
                rowData={
                    label : row.lable,
                    value : row.value
                };              
                currentData.push(rowData);                
            });
            this.dataCombobox = currentData;                        
        }         
    }

    handleChange(event) {
        this.value = event.detail.value;
        console.log('Value:  ',this.value);
    }

}