STEPS:

1. Delete variables in which the blank is over 70%. (delete_blank.m) and manually delete some useless variables( like all "passed" ).
   The output file is "TADPOLE_InputData_deleted.csv"

2. Delete blank data in Target (train_delete.m). It can delete when the variable is NAN. ( Use it to filter train_target and test_target )

3. Manually sort id in Excel ( Input_data and Target_data )

4. Filter "TADPOLE_InputData_deleted.csv" so that we can find same id of Target_data (find_sane_id.m). The number of variable is 365.

5. Then use "test.m" to impuate missing data. Ps. the size is 360 because we need to delete 4 data and last variable.

6. "after_impute_and_select.csv" is output

6.5 delete some variable and size become 337.

7. Use output file in step 6 to convert string to number (convert_string_to_num.m)

7.5 T (diff.m)

8. Then "output_train_target.csv" and "input_same_size" is the x and y of model
