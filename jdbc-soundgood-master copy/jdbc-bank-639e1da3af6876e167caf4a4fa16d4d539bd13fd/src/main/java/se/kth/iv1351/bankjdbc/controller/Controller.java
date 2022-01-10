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
import se.kth.iv1351.bankjdbc.model.Instruments;
import se.kth.iv1351.bankjdbc.model.InstrumentDTO;
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
     * Lists all instruments by type.
     * .
     */
    public List<? extends InstrumentDTO> getAllAccounts(String instrument) throws AccountException {
        try {
            return bankDb.findRentableInstrumentByType(instrument);   
        } catch (Exception e) {
            throw new AccountException("Unable to list accounts.", e);
        }
    }

    
    public void rentInstrument(String rental_id, String instrument_id, String student_id) throws AccountException {
        try {  
            if(bankDb.checkStudentRents(student_id) < 2 ){
                System.out.println("hello: " + bankDb.rentableInstruments(instrument_id));
                if(bankDb.rentableInstruments(instrument_id) > 0 ){

                    bankDb.rentInstrument(rental_id, instrument_id, student_id);
                }
                else {
                    System.out.println("Instrument can not be found");
                }
            }
            else {
                System.out.print("Student already has 2 rented instruments");
            }
        } catch (Exception e) {
            throw new AccountException("Unable to rent", e);
        }
    }

    public void terminateRental(String rental_id, String student_id) throws AccountException {
        String failureMsg = "Could not terminate the rental";
        try {
            bankDb.terminateRental(rental_id, student_id);
            System.out.println("Rental for instrument " + rental_id + " is now terminated.");
        } catch (SoundGoodDBException e) {
            throw new AccountException(failureMsg, e);
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
    public InstrumentDTO getAccount(String acctNo) throws AccountException {
        if (acctNo == null) {
            return null;
        }

        try {
            return null;
        } catch (Exception e) {
            throw new AccountException("Could not search for account.", e);
        }
    }
    
}