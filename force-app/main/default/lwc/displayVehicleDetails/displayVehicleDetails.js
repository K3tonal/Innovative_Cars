import { LightningElement, wire, api, track } from 'lwc';
import SAMPLEMC from "@salesforce/messageChannel/VehicleMessageChannel__c";
import { subscribe, MessageContext, APPLICATION_SCOPE} from 'lightning/messageService';
import { updateRecord } from 'lightning/uiRecordApi';
import { getRecord } from 'lightning/uiRecordApi';
import VEHICLE_OBJECT from '@salesforce/schema/Vehicle__c'
import NAME_FIELD from '@salesforce/schema/Vehicle__c.Name';
import BRAND_FIELD from '@salesforce/schema/Vehicle__c.Brand__c';
import MODEL_FIELD from '@salesforce/schema/Vehicle__c.Model__c';
import VIN_FIELD from '@salesforce/schema/Vehicle__c.Vin__c';

import addOrRemoveUserFromVehicleInterest from '@salesforce/apex/LwcVehicleDetailController.addOrRemoveUserFromVehicleInterest'
import setInitCheckboxValueOnLwc from '@salesforce/apex/LwcVehicleDetailController.setInitCheckboxValueOnLwc'
import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';


export default class DisplayVehicleDetails extends LightningElement {
    
    receivedMessage;
    fields = [NAME_FIELD, BRAND_FIELD, MODEL_FIELD, VIN_FIELD ];
    objectName=VEHICLE_OBJECT
    @api recordId
    @wire(getRecord, { recordId: '$recordId', fields: [NAME_FIELD, BRAND_FIELD, MODEL_FIELD, VIN_FIELD]})
    vehicle;

    @wire(MessageContext)
    context     

    @track checkbox;
    @wire (setInitCheckboxValueOnLwc, {vehicleId: '$recordId'})
    handleCheckBoxValue({error,data}){
        if(data || !data){
            this.checkbox = data;
            this.errorMsg = undefined;
        }else {
            this.errorMsg = error;
            this.checkbox = undefined;
        }
    }

    connectedCallback(){
        this.subscribeMessage();           
    }

    subscribeMessage(){
        subscribe(this.context, SAMPLEMC, (message) => this.handleMessage(message), {scope:APPLICATION_SCOPE})
    }

    handleMessage(message){
        this.receivedMessage = message.myData.value;
        this.recordId = this.receivedMessage;
    }
    
    handleFavourite(){       
        this.checkbox = !this.checkbox;       
        addOrRemoveUserFromVehicleInterest({status: this.checkbox, vehicleId: this.recordId});
    }
}