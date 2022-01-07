/*
 * The MIT License (MIT)
 * Copyright (c) 2020 Leif Lindbäck
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction,including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so,subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package se.kth.iv1351.bankjdbc.controller;

import java.util.ArrayList;
import java.util.List;

import se.kth.iv1351.bankjdbc.integration.SoundGoodDAO;
import se.kth.iv1351.bankjdbc.integration.SoundGoodDBException;
import se.kth.iv1351.bankjdbc.model.Account;
import se.kth.iv1351.bankjdbc.model.AccountDTO;
import se.kth.iv1351.bankjdbc.model.AccountException;
import se.kth.iv1351.bankjdbc.model.RejectedException;

/**
 * This is the application's only controller, all calls to the model pass here.
 * The controller is also responsible for calling the DAO. Typically, the
 * controller first calls the DAO to retrieve data (if needed), then operates on
 * the data, and finally tells the DAO to store the updated data (if any).
 */
public class Controller {
    private final SoundGoodDAO bankDb;

    /**
     * Creates a new instance, and retrieves a connection to the database.
     * 
     * @throws SoundGoodDBException If unable to connect to the database.
     */
    public Controller() throws SoundGoodDBException {
        bankDb = new SoundGoodDAO();
    }

    /**
     * Lists all accounts in the whole bank.
     * 
     * @return A list containing all accounts. The list is empty if there are no
     *         accounts.
     * @throws AccountException If unable to retrieve accounts.
     */
    public List<? extends AccountDTO> getAllAccounts(String instrument) throws AccountException {
        try {
            return bankDb.findRentableInstrumentByType(instrument);
        } catch (Exception e) {
            throw new AccountException("Unable to list accounts.", e);
        }
    }

    public void rentedInstruments(String student_id, String instrument_id) {
        try {
            if(bankDb.checkStudentRents(student_id) < 2){
                System.out.println("This student can still rent an instrument.");
                
                //if((bankDb.rentableInstruments(instrument_id) > 0 )
                  //  rentInstrument();

            }
            else {
                System.out.println("This student can not rent any more instruments.");
            }
        } catch (Exception e) {
            
        }
    }


    
    private void rentInstrument() {
        try {

            
        } catch (Exception e) {
            
        }
    }

    /**
     * Retrieves the account with the specified number.
     * 
     * @param acctNo The number of the searched account.
     * @return The account with the specified account number, or <code>null</code>
     *         if there is no such account.
     * @throws AccountException If unable to retrieve the account.
     */
    public AccountDTO getAccount(String acctNo) throws AccountException {
        if (acctNo == null) {
            return null;
        }

        try {
            return null;
        } catch (Exception e) {
            throw new AccountException("Could not search for account.", e);
        }
    }


    private void commitOngoingTransaction(String failureMsg) throws AccountException {
        try {
            bankDb.commit();
        } catch (SoundGoodDBException bdbe) {
            throw new AccountException(failureMsg, bdbe);
        }
    }
}