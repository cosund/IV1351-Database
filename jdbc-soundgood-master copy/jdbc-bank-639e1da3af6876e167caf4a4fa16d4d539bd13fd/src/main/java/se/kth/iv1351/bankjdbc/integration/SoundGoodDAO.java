package se.kth.iv1351.bankjdbc.integration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.security.auth.login.AccountException;

import com.google.protobuf.Timestamp;
import com.google.protobuf.TypeRegistry;

import se.kth.iv1351.bankjdbc.model.Instruments;
import se.kth.iv1351.bankjdbc.model.RejectedException;
import se.kth.iv1351.bankjdbc.model.InstrumentDTO;

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
            connectToSoundGoodDB();
            prepareStatements();
        } catch (ClassNotFoundException | SQLException exception) {
            throw new SoundGoodDBException
        ("Could not connect to datasource.", exception);
        }
    }
    private void connectToSoundGoodDB() throws ClassNotFoundException, SQLException {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/soundgood5",
                                                 "postgres", "example");
        connection.setAutoCommit(false);
    }


    private void prepareStatements() throws SQLException {

        listRentableInstrumentStmt = connection.prepareStatement(
            " SELECT rentableinstruments.rentable_id, instrument.type, instrument.brand, instrument.instrument_price"
            + " FROM rentableinstruments"
            + " INNER JOIN instrument ON rentableinstruments.rental_instrument_id=instrument.rental_instrument_id"
            + " WHERE rentableinstruments.rentable_id"
            + " NOT IN ("
            + " SELECT rentable_id FROM rentalinstruments"
            + " WHERE current_date >= from_date and current_date < to_date)"
            + " AND instrument.type= ?");

        checkStudentRentsStmt = connection.prepareStatement(
            " SELECT COUNT(*)"
            + " FROM rentalinstruments WHERE student_id= ? " 
            + " AND current_date < to_date"
        );

        checkInstrumentAvailableStmt = connection.prepareStatement(
            " SELECT COUNT(*) "
            + " FROM rentableinstruments " 
            + " WHERE rentableinstruments.rentable_id= ? " 
            + " AND  rentableinstruments.rentable_id NOT IN ("
            + " SELECT rental_id"
            + " FROM rentalinstruments"
            + " WHERE current_date >= from_date AND current_date < to_date)"
        );

        insertRentalStmt = connection.prepareStatement(
            " INSERT INTO rentalinstruments" +
            " Values (?, ?, ?, current_date, current_date+365);"
        );


        terminateRentalStmt = connection.prepareStatement(
            " UPDATE rentalinstruments " 
            + " SET to_date = current_date "
            + " WHERE rental_id = (" 
            + " SELECT rental_id "
            + " FROM rentalinstruments"
            + " WHERE rentable_id= ? AND student_id= ?"
            + " AND current_date < to_date"
            + " ORDER BY to_date DESC LIMIT 1)");
    }
    public List<Instruments> findRentableInstrumentByType(String instrument_type) throws SoundGoodDBException{
        String failureMsg = "Could not search for specified type.";
        //ResultSet result = listRentableInstrumentStmt.setString(1, instrument_type);
        List<Instruments> instruments = new ArrayList<>();
        try {
            listRentableInstrumentStmt.setString(1, instrument_type);
            ResultSet result = listRentableInstrumentStmt.executeQuery();

            while (result.next()) {
                instruments.add(new Instruments(
                     result.getString("rentable_id"),
                     result.getString("type"),
                     result.getString("brand"),
                     result.getInt("instrument_price")));
            }
            connection.commit();
       } catch (Exception e) {
           handleException(failureMsg, e);
       }
       return instruments;
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

   public int rentableInstruments(String instrument_id){
    try {
        checkInstrumentAvailableStmt.setString(1, instrument_id);
           ResultSet available = checkInstrumentAvailableStmt.executeQuery();
           available.next();
           return Integer.parseInt(available.getString(1));
    } catch (Exception e) {
        return 666;
    }
   }

   public void rentInstrument(String rental_id, String instrument_id, String student_id){
        String failureMsg = "Could not find rented instrument: " + rental_id;
       try {
           insertRentalStmt.setString(1, rental_id);
           insertRentalStmt.setString(2, instrument_id);
           insertRentalStmt.setString(3, student_id);
           int updateRows = insertRentalStmt.executeUpdate();
           if (updateRows != 1) {
            handleException(failureMsg, null);
        } else{
            System.out.println("Rental of instrument with ID: " + instrument_id + "by student with ID: "
                        + student_id + " was succesfull!");
            connection.commit();
        }        
       } catch (Exception e) {
       }

   }


    public void terminateRental(String rental_id , String student_id) throws SoundGoodDBException{
        String failureMsg = "Could not find rented instruments: " + rental_id;
        try {
            terminateRentalStmt.setString(1, rental_id);
            terminateRentalStmt.setString(2, student_id);

            int updatedRows = terminateRentalStmt.executeUpdate();

            if (updatedRows != 1) {
                handleException(failureMsg, null);
            }
            else {
                connection.commit();
            }
        } catch (SQLException sqle) {
            handleException(failureMsg, null);
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
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/soundgooddb",
                                                 "postgres", "example");
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

}