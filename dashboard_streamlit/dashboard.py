import streamlit as st
from connect_data_warehouse import query_housing_prices
import pandas as pd

def layout():
    # Load data
    df = query_housing_prices()

    region_mapping = {0: "Riket", 10: "Stockholm",}
    df["REGION"] = df["REGION"].replace(region_mapping)

    st.title("Housing Prices Comparison")
    st.write("This dashboard shows Housing prices comparison from SCB API.")

    
    st.markdown("## Filters")
    region_filter = st.selectbox("Select Region:", options=df["REGION"].unique(), index=0)
    year_filter = st.selectbox("Select Year:", options=sorted(df["YEAR"].unique()), index=0)

    pricing_filters = [
        st.selectbox("Pricing Category 1:", options=["APARTMENT_AREA", "LAND_PRICE", "BUILDING_PRICE"], index=0),
        st.selectbox("Pricing Category 2:", options=["APARTMENT_AREA", "LAND_PRICE", "BUILDING_PRICE"], index=1),
        st.selectbox("Pricing Category 3:", options=["APARTMENT_AREA", "LAND_PRICE", "BUILDING_PRICE"], index=2),
    ]
    filtered_df = df[(df["REGION"] == region_filter) & (df["YEAR"] == year_filter)]


    st.markdown("## Metrics")
    cols = st.columns(5)
    averages = {}

    with cols[0]:
        st.markdown(
            f"""
            <div style="text-align: center;">
                <h3 style="font-size: 18px; margin-bottom: 0;">Selected Region</h3>
                <p style="font-size: 18px; margin-top: 0;">{region_filter}</p>
            </div>
            """,
            unsafe_allow_html=True,
        )

    with cols[1]:
        st.markdown(
            f"""
            <div style="text-align: center;">
                <h3 style="font-size: 18px; margin-bottom: 0;">Selected Year</h3>
                <p style="font-size: 18px; margin-top: 0;">{year_filter}</p>
            </div>
            """,
            unsafe_allow_html=True,
        )

    for i, pricing_filter in enumerate(pricing_filters, start=2):
        with cols[i]:
            if not filtered_df.empty:
                mean_pricing = filtered_df[pricing_filter].mean()
                averages[pricing_filter] = mean_pricing
                st.markdown(
                    f"""
                    <div style="text-align: center;">
                        <h3 style="font-size: 17px; margin-bottom: 0;">Average {pricing_filter.replace('_', ' ').title()}</h3>
                        <p style="font-size: 18px; margin-top: 0;">{mean_pricing:.2f}</p>
                    </div>
                    """,
                    unsafe_allow_html=True,
                )
            else:
                averages[pricing_filter] = None
                st.markdown(
                    f"""
                    <div style="text-align: center;">
                        <h3 style="font-size: 17px; margin-bottom: 0;">Average {pricing_filter.replace('_', ' ').title()}</h3>
                        <p style="font-size: 18px; margin-top: 0;">No Data</p>
                    </div>
                    """,
                    unsafe_allow_html=True,
                )



    st.markdown("### Average prices: Region and year/m2 ")
    if any(value is not None for value in averages.values()):  # Check if there is valid data
        chart_data = pd.DataFrame(
            {"Average": [averages[p] for p in pricing_filters]},
            index=[p.replace("_", " ").title() for p in pricing_filters]
        )
        st.bar_chart(chart_data)
    else:
        st.write("No data available to display in the chart.")

if __name__ == "__main__":
    layout()
