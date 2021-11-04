import { LightningElement, track, wire } from 'lwc';
import getVehicleList from '@salesforce/apex/LwcAccountDealershipVehicleController.getVehicleList';
import SAMPLEMC from "@salesforce/messageChannel/VehicleMessageChannel__c";
import {MessageContext, publish} from 'lightning/messageService';


export default class DisplayVehiclesParent extends LightningElement {
    
    @track dealerId;
    @track records;
    @track errorMsg;
    @track vehicleId;

    @wire (getVehicleList, {dealerId:'$dealerId'})
    handleVehicles({error,data}){
        if(data){
            this.records = data;
            this.errorMsg = undefined;
        }else {
            this.errorMsg = error;
            this.records = undefined;
        }
    }

    @wire(MessageContext)
    context

    handleDealerChange(event){
        this.dealerId = event.detail;
    }

    handleChangeRadio(event){
        this.vehicleId = event.target.value;        
        let message = {
            myData:{
                value:this.vehicleId
            }
        }
        publish(this.context,SAMPLEMC, message)
    }
}