import streamlit as st
import pandas as pd
from datetime import datetime
import base64

# Function to load data from uploaded file
def load_data(uploaded_file):
    return pd.read_csv(uploaded_file)

# Function to concatenate selected columns
def concatenate_columns(row, columns):
    return '-'.join(row[col] for col in columns)

# Function to clean data
def clean_data(data, columns_to_concatenate=None, categorize_customer=False, threshold=25):
    if columns_to_concatenate:
        data['Concatenated_Column'] = data.apply(lambda row: concatenate_columns(row, columns_to_concatenate), axis=1)
    if categorize_customer:
        data['Customer Category'] = data['total_bill'].apply(lambda x: 'Gold' if x >= threshold else 'Silver')
    return data

# Function to generate a link to download a file
def get_file_download_link(file_name, file_data):
    b64 = base64.b64encode(file_data).decode()
    href = f'<a href="data:file/{file_name.split(".")[-1]};base64,{b64}" download="{file_name}">Download {file_name}</a>'
    return href

st.title("Scholar Data Cleaner")

# Sidebar for user inputs
uploaded_file = st.sidebar.file_uploader("Upload a CSV file", type="csv")

if uploaded_file:
    df = load_data(uploaded_file)
    
    # User choice for data cleaning in sidebar
    st.sidebar.write("Select columns for concatenation:")
    columns_to_concatenate = st.sidebar.multiselect('Choose columns', df.columns.tolist())
    
    threshold = st.sidebar.number_input("Set threshold for Gold category based on total bill", min_value=1, max_value=100, value=25)
    categorize_choice = st.sidebar.checkbox('Categorize customers based on the threshold')
    
    if st.sidebar.button('Clean Data'):
        cleaned_df = clean_data(df, columns_to_concatenate, categorize_customer=categorize_choice, threshold=threshold)
        st.write(cleaned_df)  # Displaying the cleaned data in the main area
        
        # Export functionality
        current_time = datetime.now().strftime("%Y%m%d_%H%M%S")
        export_format = st.sidebar.radio('Select file format to export', ['Excel', 'CSV'])
        if st.sidebar.button('Export Cleaned Data'):
            if export_format == 'Excel':
                file_name = f'data_cleaned_{current_time}.xlsx'
                with st.sidebar.beta_expander("Download Link", expanded=True):
                    with open(file_name, 'wb') as f:
                        cleaned_df.to_excel(f, index=False)
                    with open(file_name, 'rb') as f:
                        st.sidebar.markdown(get_file_download_link(file_name, f.read()), unsafe_allow_html=True)
            else:
                file_name = f'data_cleaned_{current_time}.csv'
                with st.sidebar.beta_expander("Download Link", expanded=True):
                    with open(file_name, 'wb') as f:
                        cleaned_df.to_csv(f, index=False)
                    with open(file_name, 'rb') as f:
                        st.sidebar.markdown(get_file_download_link(file_name, f.read()), unsafe_allow_html=True)
else:
    st.sidebar.warning("Please upload a CSV file.")
