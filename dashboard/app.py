from pathlib import Path

import duckdb
import streamlit as st

DB = Path(__file__).resolve().parent.parent / "dev.duckdb"

st.set_page_config(page_title="Sales Dashboard", layout="wide")
st.title("Sales Analytics Dashboard")


@st.cache_data
def q(sql: str):
    con = duckdb.connect(str(DB), read_only=True)
    try:
        return con.execute(sql).df()
    finally:
        con.close()


kpi = q("""
    select
        cast(sum(net_amount) as double) as revenue,
        count(*)                        as orders,
        sum(quantity)                   as units
    from marts.fct_orders
""").iloc[0]

c1, c2, c3 = st.columns(3)
c1.metric("Net revenue", f"R {kpi['revenue']:,.0f}")
c2.metric("Orders", int(kpi["orders"]))
c3.metric("Units sold", int(kpi["units"]))

st.subheader("Monthly revenue")
monthly = q("""
    select cast(order_month as date) as order_month,
           cast(net_revenue as double) as net_revenue
    from marts.mart_monthly_revenue
    order by 1
""")
st.line_chart(monthly.set_index("order_month")["net_revenue"])

left, right = st.columns(2)

with left:
    st.subheader("Revenue by category")
    cat = q("""
        select category,
               cast(net_revenue as double) as net_revenue,
               margin_pct
        from marts.mart_category_performance
        order by net_revenue desc
    """)
    st.bar_chart(cat.set_index("category")["net_revenue"])
    st.dataframe(cat, hide_index=True)

with right:
    st.subheader("Revenue by customer tier")
    tier = q("""
        select tier,
               customers,
               total_orders,
               cast(net_revenue as double) as net_revenue,
               margin_pct
        from marts.mart_revenue_by_customer_tier
        order by net_revenue desc
    """)
    st.bar_chart(tier.set_index("tier")["net_revenue"])
    st.dataframe(tier, hide_index=True)

st.subheader("Top 5 customers")
top = q("""
    select customer_name, region, tier,
           cast(sum(net_amount) as double) as net_revenue
    from marts.fct_orders
    group by 1, 2, 3
    order by net_revenue desc
    limit 5
""")
st.dataframe(top, hide_index=True)