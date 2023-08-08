import pandas as pd



def clean_head_names(data_frame):
    data_frame.columns = data_frame.columns.str.replace(' ','_')

    cols = []
    for i in range (len(data_frame.columns)):
        cols.append(data_frame.columns[i].lower())
    data_frame.columns = cols


    return data_frame

    
def clean_invalid_values(data_frame):
    
# Definimos los diccionarios con las condiciones
    conditions_gender = {'F':'Female',
                          'M':'Male', 
                          'Femal':'Female', 
                          'female':'Female'}
    
    conditions_state = {'Cali':'California',
                        'AZ':'Arizona',
                        'WA':'Washington'}
    
    conditions_education = {'Bachelors':'Bachelor'}
    
    # Utilizamos los diccionarios definidos para usar el .recplace como parametro para detectar las keys que coinciden y cambiarlas con el value indicado
    data_frame['gender'] = data_frame['gender'].replace(conditions_gender) # Option 1
    # se puede hacer con lambda functions tmb renamed_dataframe['gender'] = renamed_dataframe['gender'].apply(lambda x: 'Female' if x in ['F', 'Femal', 'female'] else 'Male' if x == 'M' else x) # Option 2
    
    data_frame['state'] = data_frame['state'].replace(conditions_state)
    data_frame['education'] = data_frame['education'].replace(conditions_education)
    data_frame['number_of_open_complaints'] = data_frame['number_of_open_complaints'].str.slice(2, 3)
    return data_frame

def formating_data_types(data_frame):
    # renamed_dataframe['customer_id'] = renamed_dataframe['customer_id'].astype(str)
    # renamed_dataframe['state'] = renamed_dataframe['state'].astype(str)
    # renamed_dataframe['gender'] = renamed_dataframe['gender'].astype(str)

    data_frame['customer_lifetime_value'] = data_frame['customer_lifetime_value'].str.replace('%', '')
    data_frame['customer_lifetime_value'] = data_frame['customer_lifetime_value'].astype(float)
    data_frame['number_of_open_complaints']= pd.to_numeric(data_frame['number_of_open_complaints'],errors='coerce')
    # hay que cambioar la columna de complaints count a un int cojiendo solo el numero de el medio
    return data_frame

def delete_null_values(data_frame):
    data_frame.dropna(axis=0, how='all', inplace=True)
    data_frame['state'].fillna(data_frame['state'].mode(),inplace=True)
    data_frame['gender'].fillna(data_frame['gender'].mode(),inplace=True)
    data_frame['education'].fillna(data_frame['education'].mode(),inplace=True)
    data_frame['policy_type'].fillna(data_frame['policy_type'].mode(),inplace=True)
    data_frame['vehicle_class'].fillna(data_frame['vehicle_class'].mode(),inplace=True)
    data_frame['customer_lifetime_value'].fillna(data_frame['customer_lifetime_value'].mode(),inplace=True)
    data_frame['income'].fillna(data_frame['income'].mean(),inplace=True)
    data_frame['monthly_premium_auto'].fillna(data_frame['monthly_premium_auto'].mode(),inplace=True)
    data_frame['number_of_open_complaints'].fillna(data_frame['number_of_open_complaints'].mode(),inplace=True)
    data_frame['total_claim_amount'].fillna(data_frame['total_claim_amount'].mean(),inplace=True)
    return data_frame

def delete_duplicated_values(data_frame):
    data_frame.drop_duplicates(subset=['customer'],inplace=True)
    return data_frame