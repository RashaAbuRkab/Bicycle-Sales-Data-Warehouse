# 🚲 Bicycle Sales Data Warehouse  

## 📌 Introduction  
Welcome to the **Bicycle Sales Data Warehouse**! 🎉 This project is designed to bring all sales, customer, inventory, and staff data together into one powerful platform for analysis and decision-making. With a centralized data warehouse, the company can:  
✅ Optimize sales 📈  
✅ Manage inventory effectively 📦  
✅ Improve customer experience 😊  

This document outlines the business case, key business questions answered, schema design, and data integration methods.  

---

## 💼 Why Do We Need a Data Warehouse?  
The company sells various types of bicycles (**road bikes, mountain bikes, e-bikes**) across multiple sales channels. As sales transactions and customer interactions grow, managing data from different systems becomes challenging. The issues include:  
🔹 Limited visibility into sales performance 📊  
🔹 Inventory management difficulties 🔄  
🔹 Lack of personalized marketing strategies 🎯  

**How does a data warehouse help?**  
By centralizing data from different sources (**sales transactions, customer databases, inventory systems, etc.**), the company can:  
✅ Make better, data-driven decisions 🤖  
✅ Streamline reporting and forecasting 📉📈  
✅ Identify sales trends and optimize inventory 🏬  

---

## 🏗️ Snowflake Schema Design  
To ensure smooth analytical queries and decision-making, the **Snowflake schema** is used. It consists of:  
📌 A **Fact Table** (**Sales_Fact**) that stores all transactional data.  
📌 Multiple **Dimension Tables** (**Products, Customers, Stores, Staff, Categories, and Brands**) to enrich the analysis.  

### 🔑 Key Features of the Schema  
- **Sales_Fact Table:** Stores sales transactions, order dates, quantities, products, store details, and staff involved in each sale.  
- **Dimension Tables:**  
  🔹 **Products:** Product details (name, price, category, brand).  
  🔹 **Customers:** Demographic data for customer segmentation.  
  🔹 **Stores:** Store locations and management info.  
  🔹 **Staff:** Employee details for performance tracking.  
  🔹 **Categories & Brands:** Helps group products for better insights.  

This design ensures **efficient data retrieval** and **scalability** for advanced analytics. 🚀  

---

## 📂 What’s Inside the Repo ?  
📁 **Raw Data Files** – Original sales, customer, and inventory data.  
🐍 **Python Script** – Loads data into PostgreSQL.  
📄 **SQL Files** – Scripts to create original tables and Snowflake schema tables.  
📊 **Business Insights** – Answers to key business questions.  

---

## 🤔 Key Business Questions Answered  
With the data warehouse, the company can answer important questions like:  

1️⃣ **Which bicycle categories generate the most revenue?**  
   - Analyze sales by category (road bikes, mountain bikes, etc.) to identify the most profitable product lines.  

2️⃣ **What are the top-selling bicycles by quantity?**  
   - Track which bicycles are in high demand and plan inventory accordingly.  

3️⃣ **How much revenue does each store generate?**  
   - Compare store performance to optimize operations and marketing efforts.  

---

## 🎯 Conclusion  
This data warehouse empowers the bicycle sales company to:  
✅ Gain **clear insights** into sales trends 🚀  
✅ Improve **inventory management** and reduce stock issues 🏬  
✅ Enhance **customer targeting and marketing strategies** 🎯  

With the **Snowflake schema**, data retrieval is **fast, efficient, and scalable**, helping the company make informed, data-driven decisions! 💡📊  
