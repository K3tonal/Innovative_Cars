import { LightningElement, track, wire } from 'lwc';
import getDealershipList from '@salesforce/apex/LwcAccountDealershipVehicleController.getDealershipList';

export default class DisplayDealersParent extends LightningElement {

    @track accountId;
    @track records;
    @track errorMsg;
    @track dealerId

    @wire (getDealershipList, {accId:'$accountId'})
    handleDealers({error,data}){
        if(data){
            this.records = data;
            this.errorMsg = undefined;
        }else {
            this.errorMsg = error;
            this.records = undefined;
        }
    }
    handleAccountChange(event){
        this.accountId = event.detail;
    }

    handleChangeRadio(event){
        this.dealerId = event.target.value;
        const customEvent = new CustomEvent('mydealerdemo', {
            detail: this.dealerId
        });
        this.dispatchEvent(customEvent);
    }

}