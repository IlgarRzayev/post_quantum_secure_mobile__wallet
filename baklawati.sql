USE [final_project]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[country] [varchar](100) NULL,
	[city] [varchar](100) NULL,
	[street] [varchar](200) NULL,
	[postal_code] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartItems]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItems](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cart_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Coupons]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Coupons](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](50) NULL,
	[discount_type] [varchar](20) NULL,
	[discount_value] [decimal](10, 2) NULL,
	[valid_from] [date] NULL,
	[valid_to] [date] NULL,
	[is_active] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderCoupon]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderCoupon](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[coupon_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NULL,
	[price] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[address_id] [int] NULL,
	[total_amount] [decimal](10, 2) NULL,
	[status_id] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[status_name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[order_id] [int] NULL,
	[payment_method] [varchar](50) NULL,
	[amount] [decimal](10, 2) NULL,
	[status] [varchar](50) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImages]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImages](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[image_url] [varchar](255) NULL,
	[is_primary] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](150) NULL,
	[description] [text] NULL,
	[price] [decimal](10, 2) NULL,
	[vat_rate] [decimal](4, 2) NULL,
	[stock] [int] NULL,
	[category_id] [int] NULL,
	[trendyol_price] [decimal](10, 2) NULL,
	[trendyol_url] [nvarchar](255) NULL,
	[shipping_time] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[product_id] [int] NULL,
	[rating] [int] NULL,
	[comment] [text] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shipping]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipping](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[tracking_number] [varchar](100) NULL,
	[shipping_company] [varchar](100) NULL,
	[estimated_delivery] [date] NULL,
	[shipped_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserActivityLog]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserActivityLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[activity_type] [varchar](100) NULL,
	[activity_description] [text] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[user_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](100) NULL,
	[last_name] [varchar](100) NULL,
	[email] [varchar](150) NULL,
	[password] [varchar](255) NULL,
	[phone] [varchar](20) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wishlists]    Script Date: 4/13/2025 2:25:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wishlists](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[product_id] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([id], [name]) VALUES (1, N'Gurme & Organik Urunler')
INSERT [dbo].[Categories] ([id], [name]) VALUES (2, N'Tatl?')
INSERT [dbo].[Categories] ([id], [name]) VALUES (3, N'Ramazan & Kurban Paketi')
INSERT [dbo].[Categories] ([id], [name]) VALUES (4, N'Sekerleme')
INSERT [dbo].[Categories] ([id], [name]) VALUES (5, N'Lokum')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImages] ON 

INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (1, 1, N'https://cdn.dsmcdn.com/ty1197/product/media/images/prod/SPM/PIM/20240305/22/c3e35ef0-605f-34ff-b868-1a59d85f1d29/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (2, 2, N'https://cdn.dsmcdn.com/ty1353/product/media/images/prod/QC/20240609/17/a4228be5-6f8c-32cf-8dd5-d68ac4b17e68/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (3, 2, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/17/47b7f92d-d58a-3df9-9c8c-b31344bda153/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (4, 2, N'https://cdn.dsmcdn.com/ty1354/product/media/images/prod/QC/20240609/17/128d927d-9ba3-3b25-89cb-f170e0b5df7b/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (5, 2, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/17/9f4da3ab-4d92-3a15-a1bf-5e502bac03be/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (6, 2, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/17/d26bf8b4-c147-3800-95b7-aa1ac506f812/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (7, 3, N'https://cdn.dsmcdn.com/ty1184/product/media/images/prod/SPM/PIM/20240226/19/9a09c4ac-9b32-33eb-adcb-c4d744710dda/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (8, 3, N'https://cdn.dsmcdn.com/ty1184/product/media/images/prod/SPM/PIM/20240226/19/b3f3b17d-404b-3963-b6f1-be7c6a7d84e8/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (9, 3, N'https://cdn.dsmcdn.com/ty1183/product/media/images/prod/SPM/PIM/20240226/19/f5052990-8a68-35de-956c-e98927d73908/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (10, 4, N'https://cdn.dsmcdn.com/ty1354/product/media/images/prod/QC/20240609/16/09ddb5cf-efb4-3a50-9f68-b082925508cb/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (11, 4, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/16/316b35df-8c89-34f3-aa69-9b62b87aaedd/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (12, 4, N'https://cdn.dsmcdn.com/ty1353/product/media/images/prod/QC/20240609/16/03bb8c34-8b99-3214-ab69-b20a2ec694f8/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (13, 5, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/17/4c8dca51-6bfd-3c9f-98b3-0a4a864577e4/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (14, 5, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/17/1ba9477e-9c65-3f71-b2df-191f6f79441b/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (15, 5, N'https://cdn.dsmcdn.com/ty1354/product/media/images/prod/QC/20240609/17/ac05017e-52d9-3472-9d2d-e27071c40e61/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (16, 6, N'https://cdn.dsmcdn.com/ty1354/product/media/images/prod/QC/20240609/17/1f303b52-d92f-3836-bc91-0ff112caddb2/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (17, 6, N'https://cdn.dsmcdn.com/ty1353/product/media/images/prod/QC/20240609/17/fad5fbb0-1ca0-3136-8e9e-10a9d1023046/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (18, 7, N'https://cdn.dsmcdn.com/ty1353/product/media/images/prod/QC/20240609/17/3bf973ce-bb4c-378a-bf97-8762fb2a3b8c/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (19, 7, N'https://cdn.dsmcdn.com/ty1354/product/media/images/prod/QC/20240609/17/d81777b1-a927-3a8b-a27c-3b8fc7c7d5ff/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (20, 8, N'https://cdn.dsmcdn.com/ty1594/prod/QC/20241029/21/061cf1bd-595e-3407-ac44-443bab74b966/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (21, 8, N'https://cdn.dsmcdn.com/ty1593/prod/QC/20241029/21/0470982a-d062-3540-87f9-5ebf04799979/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (22, 8, N'https://cdn.dsmcdn.com/ty1594/prod/QC/20241029/21/5391d0c7-e54e-3556-9bed-072e42c8a3a9/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (23, 8, N'https://cdn.dsmcdn.com/ty1593/prod/QC/20241029/21/1809a51b-23ea-301d-9d76-b4954e634109/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (24, 9, N'https://cdn.dsmcdn.com/ty1595/prod/QC/20241029/21/4fd02a2f-03f9-33df-ac44-3d281dd66f2c/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (25, 9, N'https://cdn.dsmcdn.com/ty1595/prod/QC/20241029/21/9cc2a715-9774-3481-b21f-534fecf08e05/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (26, 9, N'https://cdn.dsmcdn.com/ty1594/prod/QC/20241029/21/d974ee40-4263-38a7-8151-217b378670f1/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (27, 10, N'https://cdn.dsmcdn.com/ty1353/product/media/images/prod/QC/20240609/16/62b7faf8-54d8-388d-bafe-287cc827089b/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (28, 10, N'https://cdn.dsmcdn.com/ty1354/product/media/images/prod/QC/20240609/16/89d79ffc-f579-3a73-9df9-d8c2ce9a96d3/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (29, 10, N'https://cdn.dsmcdn.com/ty1354/product/media/images/prod/QC/20240609/16/800b6a87-8f81-3d30-8f44-efbf5ff9ea3e/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (30, 10, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/16/1616109e-6030-364a-9e10-dc44e00b2149/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (31, 11, N'https://cdn.dsmcdn.com/ty286/product/media/images/20220104/22/21831927/202198655/1/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (32, 11, N'https://cdn.dsmcdn.com/ty286/product/media/images/20220104/22/21831927/202198655/2/2_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (33, 11, N'https://cdn.dsmcdn.com/ty285/product/media/images/20220104/22/21831927/202198655/3/3_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (34, 11, N'https://cdn.dsmcdn.com/ty286/product/media/images/20220104/22/21831927/202198655/4/4_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (35, 12, N'https://cdn.dsmcdn.com/ty1354/product/media/images/prod/QC/20240609/16/413f5813-28d4-3ba5-89e1-6b9b6c3d9b6b/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (36, 12, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/16/f8fc45c9-a040-378f-af51-6c6089873e98/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (37, 12, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/16/cd07fdd3-b137-3c44-ac58-08ecfbc7cb78/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (38, 12, N'https://cdn.dsmcdn.com/ty1353/product/media/images/prod/QC/20240609/16/ceb4f8e6-dd0c-3dc3-9a23-20528c5e493a/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (39, 12, N'https://cdn.dsmcdn.com/ty1353/product/media/images/prod/QC/20240609/16/a8cd0427-f9b4-3588-ba56-1cdeb799f97b/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (40, 13, N'https://cdn.dsmcdn.com/ty1349/product/media/images/prod/QC/20240603/22/756cbca6-0da3-3428-9e2e-b2c10296d6e9/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (41, 13, N'https://cdn.dsmcdn.com/ty1347/product/media/images/prod/QC/20240603/22/247e749a-7029-3271-8d3d-423a2cf1a3f4/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (42, 13, N'https://cdn.dsmcdn.com/ty1347/product/media/images/prod/QC/20240603/22/378fafbe-4174-3709-adfd-f4ac1a777ab6/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (43, 13, N'https://cdn.dsmcdn.com/ty1347/product/media/images/prod/QC/20240603/22/141038ec-bf39-3d9e-96d1-3cbd29d03529/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (44, 13, N'https://cdn.dsmcdn.com/ty1346/product/media/images/prod/QC/20240603/22/79ed19f2-fb02-35d8-8256-9a007ced1dc1/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (45, 14, N'https://cdn.dsmcdn.com/ty1349/product/media/images/prod/QC/20240603/22/756cbca6-0da3-3428-9e2e-b2c10296d6e9/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (46, 14, N'https://cdn.dsmcdn.com/ty1347/product/media/images/prod/QC/20240603/22/247e749a-7029-3271-8d3d-423a2cf1a3f4/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (47, 14, N'https://cdn.dsmcdn.com/ty1347/product/media/images/prod/QC/20240603/22/378fafbe-4174-3709-adfd-f4ac1a777ab6/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (48, 14, N'https://cdn.dsmcdn.com/ty1347/product/media/images/prod/QC/20240603/22/141038ec-bf39-3d9e-96d1-3cbd29d03529/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (49, 14, N'https://cdn.dsmcdn.com/ty1346/product/media/images/prod/QC/20240603/22/79ed19f2-fb02-35d8-8256-9a007ced1dc1/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (50, 15, N'https://cdn.dsmcdn.com/ty1353/product/media/images/prod/QC/20240609/18/7606dc4b-c7e5-3494-8a9d-e030b087cd75/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (51, 15, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/18/d72dbd13-a597-365f-b9df-5ca884927692/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (52, 16, N'https://cdn.dsmcdn.com/ty1353/product/media/images/prod/QC/20240609/17/cbfd3775-7e9f-3371-bc23-6ed0ce774072/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (53, 16, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/17/0c1f9b02-a027-3bab-ba59-b70e7e5882ef/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (54, 16, N'https://cdn.dsmcdn.com/ty1353/product/media/images/prod/QC/20240609/17/07af682c-0370-320d-a94d-98bd4c1b88b0/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (55, 16, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/17/87c63e3d-6de5-3fa7-b38f-e61ebf08ac0d/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (56, 16, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/17/2bac7479-4461-3a26-a0fc-59fe054b0168/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (57, 17, N'https://cdn.dsmcdn.com/ty1183/product/media/images/prod/SPM/PIM/20240226/19/241d2bed-795e-3dc7-a10c-3486fcc4c933/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (58, 17, N'https://cdn.dsmcdn.com/ty1182/product/media/images/prod/SPM/PIM/20240226/19/e0ca24bb-4d4c-3ad1-a570-526b0b8c250b/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (59, 17, N'https://cdn.dsmcdn.com/ty1182/product/media/images/prod/SPM/PIM/20240226/19/5a186d6c-d5e9-387c-abd4-783bb8a38803/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (60, 17, N'https://cdn.dsmcdn.com/ty1184/product/media/images/prod/SPM/PIM/20240226/19/9c998bfa-e965-370f-b671-ed3229c0269a/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (61, 17, N'https://cdn.dsmcdn.com/ty1183/product/media/images/prod/SPM/PIM/20240226/19/6811e0a7-6d18-3be8-9fdb-8c92473c1ee2/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (62, 17, N'https://cdn.dsmcdn.com/ty1182/product/media/images/prod/SPM/PIM/20240226/19/c29773c6-4bc5-34f6-847e-25583c3e8a48/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (63, 18, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/18/f01f0994-597c-32c9-ba22-7c1ced0a5bfb/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (64, 18, N'https://cdn.dsmcdn.com/ty1354/product/media/images/prod/QC/20240609/18/5d7e7deb-87d8-36a2-9be7-b3565447fb8a/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (65, 18, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/18/2251d20e-2775-3ac7-ba42-de5498c41f8c/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (66, 19, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/17/15ce5022-6b0c-3f58-ae05-752e95d6ea2d/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (67, 19, N'https://cdn.dsmcdn.com/ty1354/product/media/images/prod/QC/20240609/17/6a4a88db-f97e-3114-baa8-cf8d26597e8c/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (68, 19, N'https://cdn.dsmcdn.com/ty1354/product/media/images/prod/QC/20240609/17/e14c6751-f2a0-3a4e-8f32-8636028d441e/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (69, 19, N'https://cdn.dsmcdn.com/ty1355/product/media/images/prod/QC/20240609/17/27414f93-e97b-312a-bf12-f7e6f0f29c4a/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (70, 20, N'https://cdn.dsmcdn.com/ty1183/product/media/images/prod/SPM/PIM/20240226/19/d604042b-6c57-3055-b923-bf149fa1980e/1_org_zoom.jpg', 1)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (71, 20, N'https://cdn.dsmcdn.com/ty1182/product/media/images/prod/SPM/PIM/20240226/19/1f16e111-80cd-3bcb-9326-93a01a05632b/1_org_zoom.jpg', 0)
INSERT [dbo].[ProductImages] ([id], [product_id], [image_url], [is_primary]) VALUES (72, 20, N'https://cdn.dsmcdn.com/ty1184/product/media/images/prod/SPM/PIM/20240226/19/d76a920e-88f2-373d-b8c2-e8ce56adc455/1_org_zoom.jpg', 0)
SET IDENTITY_INSERT [dbo].[ProductImages] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (1, N'F?st?kl? Baklava Belluriye 400g', N'Baklawati Soguk Tepsi Kaday?fl? F?st?kl? Baklava Belluriye (400)gr Baklawati F?st?k Billuriye , Geleneksel Turk Mutfag?n?n en leziz ve meshur tatl?lar?ndand?r.; Baklawatinin eli lezzetli ustalar? taraf?ndan ac?lan incecik yufkas?, icerisindeki bol ve Luks Antep F?st?g? ve ozel olarak tatl?larda kullan?lan birinci kalite boza yag? ile birlikte gulsuyunun birlesimiyle olusan Baklawati Billuriye tatl?s?, damaklar?n?zda lezzet festivali yasatacak.; Leziz gorunumu ve temiz icerigi ile guvenle tuketebileceginiz Baklawati Billuriye tatl?s? sofralar?n?za nese ve lezzet getirecek.; Hafif dokusu ve kars? konulmaz lezzeti ile favori tatlar?n?z aras?na girecek olan Baklawati Billuriye tatl?s? ile kendinizi s?martmaya haz?r olun.; Kullan?lan Malzemeler: Antep F?st?g? - Kaday?f - sade dogal ghee yag? - seker', CAST(790.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 0, 1, CAST(790.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/fistikli-baklava-belluriye-400g-p-812361838?merchantId=160438&filterOverPriceListings=false', NULL)
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (2, N'Luks Antep F?st?kl? Arap Baklavas? (400g)', N'Osmanl? zaman?ndan bu zamana kadar gelen Halep''e ozgu Arap Baklavas? Yar?m kilo net tart?r?lmaktad?r.', CAST(790.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 100, 2, CAST(790.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/luks-antep-fistikli-arap-baklavasi-400g-p-809569053?merchantId=160438&filterOverPriceListings=false', N'2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (3, N'Senyora Kurabiyesi (800 GR)', N'Yumusac?k kurabiye ag?zda dag?lan mukemmel tad? keyifle yemeniz icin sunuyoruz.', CAST(780.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 100, 3, CAST(780.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/senyora-kurabiyesi-800-gr-p-809478349?merchantId=160438&filterOverPriceListings=false', NULL)
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (4, N'Kar?s?k F?st?k Ve Kajulu Tatl? Kutusu (800 G)', N'F?st?kl? kajolu tum tatl?lar?m?z?n lezzeti bir arada birlestiren ozel bir urun.', CAST(1350.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 100, 2, CAST(1350.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/karisik-fistik-ve-kajulu-tatli-kutusu-800-g-p-809470199?merchantId=160438&filterOverPriceListings=false', N'2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (5, N'Kar?s?k Arap Baklavas? (800 GR)', N'Tum tatl?lar?m?z?n lezzetleri denemek icin ideal bir urunumuz Bir kilo net tart?r?lmaktad?r.', CAST(2200.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 100, 4, CAST(2200.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/karisik-arap-baklavasi-800-gr-p-809242392?merchantId=160438&filterOverPriceListings=false', N'2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (6, N'Arap Baklavas? (800 G)', N'Osmanl? zaman?ndan bu zamana kadar gelen Halep''e ozgu Arap Baklavas?.', CAST(1480.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 100, 2, CAST(1480.00 AS Decimal(10, 2)), N'https://www.trendyol.com/benim-baklavalari/arap-baklavasi-800-g-p-809171540?merchantId=160438&filterOverPriceListings=false', N'2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (7, N'Luks Antep F?st?kl? Ve Kajulu Tatl? Kutusu (400G)', N'F?st?kl? kajolu tum tatl?lar?m?z?n lezzeti bir arada birlestiren ozel bir urun.', CAST(810.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 100, 2, CAST(810.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/luks-antep-fistikli-ve-kajulu-tatli-kutusu-400g-p-807728687?merchantId=160438&filterOverPriceListings=false', N'2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (8, N'Paketli Badem Ezmesi (800G)', N'Baklawati Paketli Luks Badem Ezmesi en ustunde ise Luks Antep F?st?klar?.; Bu katk?s?z mukemmel lezzet bombas? Baklawati fark?yla sizlerle.; Bademin tok tutucu ozelligi ile Antep F?st?g?n?n antioksidan ozelliginin birlestigi bu leziz tad? tum diyetlerinizde kullanabilir, cocuklar?n?za guvenle verebilirsiniz.; Tad?ml?k olarak paketlenen Baklawati Luks Antep F?st?kl? Badem Ezmesi, ister is yerinde can?n?z sagl?kl? at?st?rmal?klar istediginde isterseniz cocuklar?n?z?n beslenme cantalar?na ekleyebilirsiniz.; Gunun her saati bu sagl?kl? lezzet bombas?n?n keyfini surun.; Icindekiler; Seker - Luks Badem - Luks Antep F?st?g?.', CAST(1600.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 100, 4, CAST(1600.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/paketli-badem-ezmesi-800g-p-785765689?merchantId=160438&filterOverPriceListings=false', NULL)
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (9, N'Paketli Lokum (800G)', N'Baklawati Luks Antep F?st?kl? Paketli Lokum Dunyaca unlu Turk Lokumu Baklawati yorumuyla sizlerle bulusuyor.; Istah kabartan gorunumu ve damaklarda senlik yaratacak lezzeti ile tatl? kacamaklar?n?z?n favorisi olacak.; Birinci s?n?f seker ve Luks Antep F?st?g?n?n usta ellerle birlesmesiyle ortaya c?kan bu lezzete kimse hay?r diyemeyecek.; Icerigi; Luks F?st?k - seker - sak?z.', CAST(1600.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 100, 5, CAST(1600.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/paketli-lokum-800g-p-785614628?merchantId=160438&filterOverPriceListings=false', NULL)
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (10, N'Luks Badem Kurabiyesi (800G)', N'Istanbuliyah ghariba bademli 800g Bademli Istanbul kurabiyesi lezzetli bir tatl? olmas?n?n yan? s?ra protein ve sagl?kl? yaglar ac?s?ndan da zengin olmas?yla on plana c?k?yor; Bu tatl?, basar?, dogum partileri veya tatillerde ev sahipligi yapmak icin idealdir; Istanbul bademli kurabiye malzemeleri Ozel ve hassas bir haz?rlama yontemiyle yumurta ak?, seker ve ince soyulmus badem tozuyla birlikte kullan?larak haz?rlan?r, guzelligi ve lezzeti artt?rmak icin f?st?kla suslenir; Istanbuliya''n?n bademli garip faydalar? Ici c?t?r, d?s? c?t?r dokusu ve enfes lezzetinin yan? s?ra, yuksek oranda yumurta ak? ve bademden elde edilen proteinleri icermesi, tatl?lar aras?nda besin degerini art?r?yor; bilesenler Badem tozu; yumurta ak?; toz seker; antep f?st?g?;.', CAST(1100.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 100, 4, CAST(1100.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/luks-badem-kurabiyesi-800g-p-226155745?merchantId=160438&filterOverPriceListings=false', N'2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (11, N'Luks  Antep F?st?k Ezmesi 1 Kg', N'Osmanl?’dan beri ayn? gelenekle uretilen lezzet olan F?st?k ezmesi, essiz anlar?n?za deger ve sagl?k katacak; Kutu ag?rl?g? 1KG olup, ozel ambalajlar?m?zda kargoya teslim edilmektedir;', CAST(2200.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 100, 2, CAST(2200.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/luks-antep-fistik-ezmesi-1-kg-p-124418895?merchantId=160438&filterOverPriceListings=false', N'-2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (12, N'Arap Baklavas? (800 G)', N'Osmanl? zaman?ndan bu zamana kadar gelen Halep''e ozgu Arap Baklavas?', CAST(1480.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 100, 2, CAST(1480.00 AS Decimal(10, 2)), N'https://www.trendyol.com/benim-baklavalari/arap-baklavasi-800-g-p-124370767?merchantId=160438&filterOverPriceListings=false', N'2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (13, N'Soguk Tepsi Kaday?fl? F?st?kl? Baklava Belluriye (400G)', N'Arap Kulturunun meshur lezzetlerinden sadece bir tanesi olan Kar?s?k Osmanl? Kaday?f?''n?n tarihi ad?ndan da anlas?lacag? gibi Osmanl?''ya dayan?yor; 400g net tart?r?lmaktad?r;', CAST(750.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 100, 2, CAST(750.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/soguk-tepsi-kadayifli-fistikli-baklava-belluriye-400g-p-124094358?merchantId=160438&filterOverPriceListings=false', N'2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (14, N'Soguk Tepsi Kaday?fl? F?st?kl? Baklava Belluriye (400G)', N'Arap Kulturunun meshur lezzetlerinden sadece bir tanesi olan Kar?s?k Osmanl? Kaday?f?''n?n tarihi ad?ndan da anlas?lacag? gibi Osmanl?''ya dayan?yor; 400g net tart?r?lmaktad?r;', CAST(650.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 100, 2, CAST(620.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/soguk-tepsi-kadayifli-fistikli-baklava-belluriye-400g-p-124094358?merchantId=160438&filterOverPriceListings=false', N'-2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (15, N'Luks Antep F?st?kl? Ve Kajulu Tatl? Kutusu (400G)', N'F?st?kl? kajolu tum tatl?lar?m?z?n lezzeti bir arada birlestiren ozel bir urun', CAST(810.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 100, 2, CAST(810.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/luks-antep-fistikli-ve-kajulu-tatli-kutusu-400g-p-124094328?merchantId=160438&filterOverPriceListings=false', N'2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (16, N'Kaday?fl? F?st?kl? Baklava Belluriye (800 G)', N'Kaday?fl? F?st?kl? Baklava Belluriye (800 g) Baklawati F?st?k Billuriye , Geleneksel Turk Mutfag?n?n en leziz ve meshur tatl?lar?ndand?r; Baklawatinin eli lezzetli ustalar? taraf?ndan ac?lan incecik yufkas?, icerisindeki bol ve Luks Antep F?st?g? ve ozel olarak tatl?larda kullan?lan birinci kalite boza yag? ile birlikte gulsuyunun birlesimiyle olusan Baklawati Billuriye tatl?s?, damaklar?n?zda lezzet festivali yasatacak; Leziz gorunumu ve temiz icerigi ile guvenle tuketebileceginiz Baklawati Billuriye tatl?s? sofralar?n?za nese ve lezzet getirecek; Hafif dokusu ve kars? konulmaz lezzeti ile favori tatlar?n?z aras?na girecek olan Baklawati Billuriye tatl?s? ile kendinizi s?martmaya haz?r olun; Kullan?lan Malzemeler: Un – Nisasta – Seker – Su – Tuz – Sut – F?st?k – Kaju Parca Say?s?: 56; 58;', CAST(1480.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 100, 2, CAST(1480.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/kadayifli-fistikli-baklava-belluriye-800-g-p-124094315?merchantId=160438&filterOverPriceListings=false', N'2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (17, N'Antep F?st?kl? Kaday?fl? Kar?s?k Tatl? Kutusu (400G)', N'Tum Baklavati urunlerinin lezzetine erismek icin harika bir tercih; Turkiye''nin en kaliteli birinci s?n?f Antep f?st?g?, kaliteli, lezzetli hafif ve en yumusak hamurdan uretilmistir; Kutu icerisinde gorselde gordugunuz urunler yer almaktad?r; Toplam ag?rl?k 1KG''dir; Tum urunlerimizde her zaman ayn? kaliteyi ar?yor ve tum urunlerimizi her zaman sizlerin damak tad?n?za uygun haz?rl?yoruz;', CAST(830.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 100, 2, CAST(8300.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/antep-fistikli-kadayifli-karisik-tatli-kutusu-400g-p-124094271?merchantId=160438&filterOverPriceListings=false', N'2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (18, N'Kar?s?k F?st?k Ve Kajulu Tatl? Kutusu (800 G)', N'F?st?kl? kajolu tum tatl?lar?m?z?n lezzeti bir arada birlestiren ozel bir urun', CAST(1440.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 100, 2, CAST(1440.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/karisik-fistik-ve-kajulu-tatli-kutusu-800-g-p-124094251?merchantId=160438&filterOverPriceListings=false', N'2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (19, N'Badem Kurabiyesi (400G)', N'Taze ve yumusac?k yap?s?yla badem tatl?s?n?n lezzetini mutlaka deneyin . Urun ag?rl?g? 500 Gram olup, ozel ambalajlar?m?zda kargoya verilecektir. Cay ya da kahvenin yan?na lezzetli at?st?rmal?klara kim hay?r diyebilir ki? D?s? c?t?r ici ise yumusac?k Baklawati Badem Kurabiyesi hem sizin hem de cocuklar?n?z icin essiz lezzetlerden. Birinci s?n?f Badem ve Antep F?st?g?ndan olusan bu c?t?r kurabiye, lezzetli oldugu kadar besleyici de. Yumurta, badem ve antep f?st?g?ndan elde edilen yuksek protein icerigi sayesinde diyetinizi bozmadan da rahatl?kla tuketebilirsiniz. Icerigi; Badem tozu - yumurta ak? - pudra sekeri - f?st?k', CAST(650.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 100, 2, CAST(650.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/badem-kurabiyesi-400g-p-124094228?merchantId=160438&filterOverPriceListings=false', N'2')
INSERT [dbo].[Products] ([id], [name], [description], [price], [vat_rate], [stock], [category_id], [trendyol_price], [trendyol_url], [shipping_time]) VALUES (20, N'Taze Cekilmis Antep F?st?kl? Gurebic (800 G)', N'Yumusac?k hamurun icindeki cekilmis f?st?g?n lezzeti uzerinde budra seker ile mukemmel tad? kac?rmayiniz', CAST(1900.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 100, 4, CAST(1900.00 AS Decimal(10, 2)), N'https://www.trendyol.com/baklawati/taze-cekilmis-antep-fistikli-gurebic-800-g-p-103713624?merchantId=160438&filterOverPriceListings=false', N'2')
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Coupons__357D4CF9574781C4]    Script Date: 4/13/2025 2:25:54 PM ******/
ALTER TABLE [dbo].[Coupons] ADD UNIQUE NONCLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__AB6E6164B77A2C01]    Script Date: 4/13/2025 2:25:54 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UC_Wishlist]    Script Date: 4/13/2025 2:25:54 PM ******/
ALTER TABLE [dbo].[Wishlists] ADD  CONSTRAINT [UC_Wishlist] UNIQUE NONCLUSTERED 
(
	[user_id] ASC,
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Coupons] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ProductImages] ADD  DEFAULT ((0)) FOR [is_primary]
GO
ALTER TABLE [dbo].[Reviews] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[UserActivityLog] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Wishlists] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[CartItems]  WITH NOCHECK ADD FOREIGN KEY([cart_id])
REFERENCES [dbo].[Cart] ([id])
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_Products]
GO
ALTER TABLE [dbo].[OrderCoupon]  WITH CHECK ADD FOREIGN KEY([coupon_id])
REFERENCES [dbo].[Coupons] ([id])
GO
ALTER TABLE [dbo].[OrderCoupon]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([id])
GO
ALTER TABLE [dbo].[OrderItems]  WITH NOCHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([id])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([address_id])
REFERENCES [dbo].[Address] ([id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([status_id])
REFERENCES [dbo].[OrderStatus] ([id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([id])
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[ProductImages]  WITH CHECK ADD  CONSTRAINT [FK_ProductImages_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[ProductImages] CHECK CONSTRAINT [FK_ProductImages_Products]
GO
ALTER TABLE [dbo].[Reviews]  WITH NOCHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Products]
GO
ALTER TABLE [dbo].[Shipping]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([id])
GO
ALTER TABLE [dbo].[UserActivityLog]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([id])
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Wishlists]  WITH NOCHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Wishlists]  WITH CHECK ADD  CONSTRAINT [FK_Wishlists_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[Wishlists] CHECK CONSTRAINT [FK_Wishlists_Products]
GO
ALTER TABLE [dbo].[Coupons]  WITH CHECK ADD CHECK  (([discount_type]='amount' OR [discount_type]='percentage'))
GO
ALTER TABLE [dbo].[Reviews]  WITH NOCHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
