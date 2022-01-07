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

package se.kth.iv1351.bankjdbc.model;

/**
 * An account in the bank.
 */
public class Account implements AccountDTO {
    private String rentable_id;
    private String type;
    private String brand;
    private int instrument_price;

    /**
     * Creates an account for the specified holder with the balance zero. The account
     * number is unspecified.
     *
     * @param rentable_id
      The account holder's rentable_id
     .
     * @param bankDB     The DAO used to store updates to the database.

    /**
     * Creates an account for the specified holder with the specified balance and account
     * number.
     *
     * @param type     The account number.
     * @param rentable_id
      The account holder's rentable_id
     .
     * @param balance    The initial balance.
     */
    public Account(String rentable_id, String type, String brand, int instrument_price) {
        this.rentable_id = rentable_id;
        this.type = type;
        this.brand = brand;
        this.instrument_price = instrument_price;
    }

    /**
     * @return The account number.
     */
    public String getAccountNo() {
        return type;
    }

    /**
     * @return The balance.
     */
    public int getBalance() {
        return instrument_price;
    }

    /**
     * @return The holder's name.
     */
    public String getrentable_id() {
        return rentable_id
;
    }

    public String getBrand() {
        return brand;
    }

    /**
     * Deposits the specified amount.
     *
     * @param amount The amount to deposit.
     * @throws AccountException If the specified amount is negative, or if unable to
     *                          perform the update.
     */
    public void deposit(int amount) throws RejectedException {
        if (amount < 0) {
            throw new RejectedException("Tried to deposit negative value, illegal value: "
                                        + amount + ", account: " + this);
    }
        instrument_price = instrument_price + amount;
    }

    /**
     * Withdraws the specified amount.
     *
     * @param amount The amount to withdraw.
     * @throws AccountException If the specified amount is negative, if the amount
     *                          is larger than the balance, or if unable to perform
     *                          the update.
     */
    public void withdraw(int amount) throws RejectedException {
        if (amount < 0) {
            throw new RejectedException("Tried to withdraw negative value, illegal value: "
                                        + amount + ", account: " + this);
        }
        if (instrument_price - amount < 0) {
            throw new RejectedException("Overdraft attempt, illegal value: " + amount
                                        + ", account: " + this);
        }
        instrument_price = instrument_price - amount;
    }

    /**
     * @return A string representation of all fields in this object.
     */
    @Override
    public String toString() {
        StringBuilder stringRepresentation = new StringBuilder();
        stringRepresentation.append("Account: [");
        stringRepresentation.append("account number: ");
        stringRepresentation.append(type);
        stringRepresentation.append(", holder: ");
        stringRepresentation.append(rentable_id
);
        stringRepresentation.append(", balance: ");
        stringRepresentation.append(instrument_price);
        stringRepresentation.append("]");
        return stringRepresentation.toString();
    }

    @Override
    public String getHolderName() {
        // TODO Auto-generated method stub
        return null;
    }
}
