import pandas as pd



def clean_head_names(data_frame):
    data_frame.columns = data_frame.columns.str.replace(' ','_')

    cols = []
    for i in range (len(data_frame.columns)):
        cols.append(data_frame.columns[i].lower())
    data_frame.columns = cols

    renamed_dataframe = data_frame.rename(columns={'customer':'customer_id',
                                                    'st':'state',
                                                    'education':'education_level',
                                                    'customer_lifetime_value':'lifetime_value',
                                                    'monthly_premium_auto':'monthly_premium',
                                                    'number_of_open_complaints':'complaints_count',
                                                    'total_claim_amount' : 'total_claim'})
    return renamed_dataframe

    
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
    
    data_frame['state'] = data_frame['state'].data_frame(conditions_state)
    data_frame['education_level'] = data_frame['education_level'].replace(conditions_education)
    data_frame['complaints_count'] = data_frame['complaints_count'].str.slice(2, 3)
    return

def formating_data_types(data_frame):
    # renamed_dataframe['customer_id'] = renamed_dataframe['customer_id'].astype(str)
    # renamed_dataframe['state'] = renamed_dataframe['state'].astype(str)
    # renamed_dataframe['gender'] = renamed_dataframe['gender'].astype(str)
    data_frame['lifetime_value'] = data_frame['lifetime_value'].str.replace('%', '')
    data_frame['lifetime_value'] = data_frame['lifetime_value'].astype(float)
    data_frame['complaints_count']= pd.to_numeric(data_frame['complaints_count'],errors='coerce')
    data_frame['complaints_count'] = data_frame['complaints_count'].astype(int)
    # hay que cambioar la columna de complaints count a un int cojiendo solo el numero de el medio
    return

def delete_null_values(data_frame):
    data_frame.dropna(axis=0, how='all', inplace=True)
    data_frame['state'].fillna(data_frame['state'].mode(),inplace=True)
    data_frame['gender'].fillna(data_frame['gender'].mode(),inplace=True)
    data_frame['education_level'].fillna(data_frame['education_level'].mode(),inplace=True)
    data_frame['policy_type'].fillna(data_frame['policy_type'].mode(),inplace=True)
    data_frame['vehicle_class'].fillna(data_frame['vehicle_class'].mode(),inplace=True)
    data_frame['lifetime_value'].fillna(data_frame['lifetime_value'].mode(),inplace=True)
    data_frame['income'].fillna(data_frame['income'].mean(),inplace=True)
    data_frame['monthly_premium'].fillna(data_frame['monthly_premium'].mode(),inplace=True)
    data_frame['complaints_count'].fillna(data_frame['complaints_count'].mode(),inplace=True)
    data_frame['total_claim'].fillna(data_frame['total_claim'].mean(),inplace=True)
    return

def delete_duplicated_values(data_frame):
    data_frame.drop_duplicates(subset=['customer_id'],inplace=True)
    return