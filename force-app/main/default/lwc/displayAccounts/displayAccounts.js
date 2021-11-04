import { LightningElement, track, wire } from 'lwc';
import getAccountList from '@salesforce/apex/LwcAccountDealershipVehicleController.getAccountList';
import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';

export default class DisplayAccounts extends LightningElement {
    @track getAccId;
    @track accounts;
    @track records = [];

    pageLength = 4;
    page=1;

    @wire (getAccountList)
    handleAccounts({error,data}){
        if(data){
            this.accounts = data;
            for(let i = 0; i < this.pageLength; i++){
                this.records.push(this.accounts[i]);
            }
            this.errorMsg = undefined;
        }if(error){
            this.errorMsg = error;
            this.accounts = undefined;
        }
    }

    handleChangeRadio(event){
        this.getAccId = event.target.value;
        const customEvent = new CustomEvent('myeventdemo', {
            detail: this.getAccId
        });
        this.dispatchEvent(customEvent);
    }

    prevpage(){
        let results = [];
        if(this.page >= 1){
            this.page = this.page - 1;
            for(let i = 0; i < this.pageLength; i++){
                if((i + (this.page * this.pageLength)) < this.accounts.length){
                    results.push(this.accounts[i + (this.page * this.pageLength)]);
                }            
            }
            this.records = results;
        }
    }

    nextpage(){
        let results = [];
        if(this.page <= (Math.floor(this.accounts.length/this.pageLength))){
            this.page = this.page + 1;
            for(let i = 0; i < this.pageLength; i++){
                if((i + (this.page * this.pageLength)) < this.accounts.length){
                    results.push(this.accounts[i + (this.page * this.pageLength)]);
                }
            }
            this.records = results;
        }
    }   
}
