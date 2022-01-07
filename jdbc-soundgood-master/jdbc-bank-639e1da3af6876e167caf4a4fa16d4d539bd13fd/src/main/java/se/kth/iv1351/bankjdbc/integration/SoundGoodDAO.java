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

package se.kth.iv1351.bankjdbc.integration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.google.protobuf.Timestamp;
import com.google.protobuf.TypeRegistry;

import se.kth.iv1351.bankjdbc.model.Account;
import se.kth.iv1351.bankjdbc.model.AccountDTO;

/**
 * This data access object (DAO) encapsulates all database calls in the bank
 * application. No code outside this class shall have any knowledge about the
 * database.
 */
public class SoundGoodDAO {

    private Connection connection;
    // adding our own statements
    private PreparedStatement listRentableInstrumentStmt;
    private PreparedStatement checkStudentRentsStmt;
    private PreparedStatement checkInstrumentAvailableStmt;
    private PreparedStatement insertRentalStmt;
    private PreparedStatement terminateRentalStmt;
    

    /**
     * Constructs a new DAO object connected to the bank database.
     */
    public SoundGoodDAO() throws SoundGoodDBException {
        try {
            connectToBankDB();
            prepareStatements();
        } catch (ClassNotFoundException | SQLException exception) {
            throw new SoundGoodDBException
        ("Could not connect to datasource.", exception);
        }
    }

    private void prepareStatements() throws SQLException {

        listRentableInstrumentStmt = connection.prepareStatement(
            "SELECT rentableinstruments.rentable_id, instrument.type, instrument.brand, instrument.instrument_price"
            + "FROM rentableinstruments"
            + "INNER JOIN instrument ON rentableinstruments.rental_instrument_id=instrument.rental_instrument_id"
            + "WHERE rentableinstruments.rentable_id"
            + "NOT IN ("
            + "SELECT rentable_id FROM rentalinstruments"
            + "WHERE current_date >= from_date and current_date < to_date)"
            + "AND instrument.type= ?");

        checkStudentRentsStmt = connection.prepareStatement(
            "SELECT COUNT(*)"
            + "FROM rentalinstruments WHERE student_id= ? " 
            + "AND current_date < to_date"
        );

        checkInstrumentAvailableStmt = connection.prepareStatement(
            "SELECT COUNT(*) "
            + "FROM rentableinstruments " 
            + "WHERE rentableinstruments.rentable_id='1' " 
            + "AND  rentableinstruments.rentable_id NOT IN ("
            + "SELECT rental_id"
            + "FROM rentalinstruments"
            + "WHERE current_date >= from_date AND current_date < to_date)"
        );

        insertRentalStmt = connection.prepareStatement(
            "INSERT INTO rentalinstruments"
            + "VALUES ('14', '4', '0',current_date, current_date+365)"
        );

        terminateRentalStmt = connection.prepareStatement(
            "UPDATE rentalinstruments " 
            + "SET to_date = current_date "
            + "WHERE rental_id = (" 
            + "SELECT rental_id "
            + "FROM rentalinstruments"
            + "WHERE rentable_id= ? AND student_id= ?"
            + "AND current_date < to_date"
            + "ORDER BY to_date DESC LIMIT 1)");
    }
    public List<Account> findRentableInstrumentByType(String instrument_type) throws SoundGoodDBException{
        String failureMsg = "Could not search for specified type.";
        ResultSet result = null;
        List<Account> accounts = new ArrayList<>();
        try {
            listRentableInstrumentStmt.setString(1, instrument_type);
            result = listRentableInstrumentStmt.executeQuery();

            while (result.next()) {
                accounts.add(new Account(
                     result.getString("rentable_id"),
                     result.getString("type"),
                     result.getString("brand"),
                     result.getInt("instrument_price")));
            }
            connection.commit();
       } catch (Exception e) {
           handleException(failureMsg, e);
       }
       finally {
           closeResultSet(failureMsg, result);
       }
       return accounts;
   }

   public int checkStudentRents(String student_id){
       try {
           checkStudentRentsStmt.setString(1, student_id);
           ResultSet rentedByStudent = checkStudentRentsStmt.executeQuery();
           rentedByStudent.next();
           return Integer.parseInt(rentedByStudent.getString(1));
           } catch (Exception e) {
           return 666;
       }

   }



    public void terminateRent(String rental_id , String student_id) throws SoundGoodDBException{
        String failureMsg = "Could not find rented instrument: " + rental_id;
        try {
            terminateRentalStmt.setString(1, rental_id);
            terminateRentalStmt.setString(2, student_id);

            int updatedRows = terminateRentalStmt.executeUpdate();
            
            if (updatedRows != 1) {
                handleException(failureMsg, null);
            }
            else {
                System.out.println("Successfully deleted rented instrument " + rental_id + " by student " + student_id);
                connection.commit();
            }
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
    }

    /**
     * Commits the current transaction.
     * 
     * @throws SoundGoodDBException
     * If unable to commit the current transaction.
     */
    public void commit() throws SoundGoodDBException
 {
        try {
            connection.commit();
        } catch (SQLException e) {
            handleException("Failed to commit", e);
        }
    }

    private void connectToBankDB() throws ClassNotFoundException, SQLException {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/bankdb",
                                                 "postgres", "postgres");
        // connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb",
        //                                          "mysql", "mysql");
        connection.setAutoCommit(false);
    }

    // TASK 4 SHIT HERE :) Queries (Stmt = statements)

    

    private void handleException(String failureMsg, Exception cause) throws SoundGoodDBException
 {
        String completeFailureMsg = failureMsg;
        try {
            connection.rollback();
        } catch (SQLException rollbackExc) {
            completeFailureMsg = completeFailureMsg + 
            ". Also failed to rollback transaction because of: " + rollbackExc.getMessage();
        }

        if (cause != null) {
            throw new SoundGoodDBException
        (failureMsg, cause);
        } else {
            throw new SoundGoodDBException
        (failureMsg);
        }
    }

    private void closeResultSet(String failureMsg, ResultSet result) throws SoundGoodDBException
 {
        try {
            result.close();
        } catch (Exception e) {
            throw new SoundGoodDBException
        (failureMsg + " Could not close result set.", e);
        }
    }

    private int createAccountNo() {
        return (int)Math.floor(Math.random() * Integer.MAX_VALUE);
    }
}