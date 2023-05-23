Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307CA70DCD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjEWMo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbjEWMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:44:22 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F02118;
        Tue, 23 May 2023 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFx+1Fxg8j/0wYEiQSyHxa1ocYc+6vyIjJnlA0SBMsY=;
 b=uVQG53uA/ySb3CfpE9jdovx6zQrrgfey+ilZNchfaUgG5M6cUeo1ImcVQZ09Lf0Jy0wyt/HupoS7sVoyeBdlRDYWawqm5CDiyGSXymOsqhV5QwxA+xnohrHbWojmV9RH/K7bJp6BfY/j0TlmjHBkwVwfdnOPNZWycD/AEObt0/3krXsHpc5Ie5RQC/Tq4PhrQAFBWdgN6H/W+TOiAelSP0c7lMLQwqTkhhdXuRQtI7f9J1voga+sgnTQBekR1R51uuWSij8siXM7bnniyqyKg4s9xh624l7H4aE9Xm6kIy9kqH6wBvFWR47HIpKkKzRnLR/0pyrVsCv2ae5HRzjX0Q==
Received: from DB6P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:6:28::25) by
 VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 12:44:09 +0000
Received: from DB5EUR01FT042.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:28:cafe::e0) by DB6P191CA0015.outlook.office365.com
 (2603:10a6:6:28::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 12:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT042.mail.protection.outlook.com (10.152.5.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.18 via Frontend Transport; Tue, 23 May 2023 12:44:08 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.173) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 23 May 2023 12:44:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TffuH5Vr0zfGj4DRtDmJcu5C44lBBoY8sa9vSImvJ+9cK649e4utVryfDb78J38iMqnJlKt1VKsVEEptgRlqLEU3Ys57wTxC7Q08q9SHU9VOxBxn63yyLAIrdyh52fFTNv7QqOB0Dnd47FAIRihsBemRFzMzBDElUaxuj3U3t7CrW2PqNaF24oa/+QYojE6IZLCPW7sTzTEOCkCVPV7VQxLlQEawM0seVY5Q0S2XO3GPC8zn2ZmEBqTeozKGbj45sPkLDO1/4CKXlq4pOKmoUNSlA0ShuNwbjPj+wcBKbOrYKJ4i9qHnZH6nDvy8JV9tzLyKqgt2JhkQ1A/+2bxLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0L/HAYF0DOs3xp60YFSRzBsIhxOaSd4R3LTz262j/w=;
 b=YhtNCakZ+JBpNCJDmASjZVqtIQRoM+mAEJ1OdnXrvSzbNYLN3MqqzJLQeeH8oHKJBAyFMR2GfW+ViBODhjEDn6lCzsW1SeQnANWX79NJofF9BiGPQ0V+RLuiGhb+zaAt+y/FqMRTsiiF/7R+J877CfM/ZCAz+SdpxP/8fUaAJuBsv0tJhUfFRlmBQ3tm06VFB/WUUutQ2yy6bwdnGxJJwGIhNv4a5gNV7Y++m6/7gHkWXHxWaFfiiHSCOMGNZKYNlm2HDqVsTjPoBBc8Z+hbMzpICAGk/NW9GL+XqHBqy4Uylf3+iwTiqzNusejxDtxVurMJN/FkxhxA9am4z60Vnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM0PR04MB7172.eurprd04.prod.outlook.com (2603:10a6:208:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 12:44:02 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 12:44:02 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: Add microchip MCP3561/2/4R devices
Date:   Tue, 23 May 2023 14:43:54 +0200
Message-ID: <20230523124354.24294-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230523124354.24294-1-mike.looijmans@topic.nl>
References: <20230523124354.24294-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.eb6f5840-d073-4c65-a5e6-2e0163b5b1a6@emailsignatures365.codetwo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0119.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::24) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM0PR04MB7172:EE_|DB5EUR01FT042:EE_|VI1PR04MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: ec030b5b-7879-48dc-5e64-08db5b8b6701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: +UHV/amtMJNweAEhahn3LsYuc+BBKheBr+dp9hd/sqQuKVv2DZz0SfIFObF57tpf17wJbvwjrQkY9M3IDRBFUwoJ9XAbUrVC53sNh/4f2PQViEmXJ8NhVpsqWd8uDv128e2vI4pvMnXVOAISlswovKWMlwbziWLxVQlMiY4lJ5G8Sk+IDxb96Dg7r2/YK5OvqbGNAMZc+n4BD8d2xpyXX5tpQzU/5cxc5CUq/2kkvQZsDXrZ6EKMZxgSvnfa7SEiHwmA0cpWco9oK2eFo/GY7xUB8PuzZjIIBxyQpyDOmBV9yKwkQzwJM/gbDsDpsDUyhumDzkiagS5QkxUTnwgbIIfzfW1oq2b4zHHXoha//H7o+vfXxojB56plgLS3vq0+V2lLR5Kqw0rgmym476bgNt80aYKsGT+GwGHwZY+XaxFBCiThhmbagx6Y0ro1YJvN+WUlvND08IXz7pSNf5l8QGZrXMxvVX1eFFwP93rkjNUzfBN8BZcNtRZ3ss7wuLKcmPRGrZAen4LowK9eRt2gHTFSQRyK2cz2vZb4hQ+zl462lpRxhGVIy8pNcBxt0sDU6rj6Sw0RNKXcD40j5Lp02oiTU4sUaexhk72Y4H6VlvA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(396003)(366004)(346002)(136003)(451199021)(52116002)(45080400002)(41300700001)(66946007)(66556008)(66476007)(2906002)(30864003)(186003)(1076003)(44832011)(478600001)(26005)(6486002)(316002)(6666004)(4326008)(966005)(5660300002)(54906003)(6512007)(7416002)(8936002)(8676002)(36756003)(42882007)(2616005)(6506007)(83380400001)(83170400001)(40140700001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7172
X-CodeTwo-MessageID: d926ff01-f181-4eb0-9026-81819f5a8592.20230523124407@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT042.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1faeae8f-0236-4351-b028-08db5b8b6309
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHyLU9iqOusRf37phzLEx0uxXLOYfxXQ0NTywDmcvJMjT1dK9v4y7CFGI44qUrBXbibqwWrUZuLWGXg8IKFOnXiyLEVjdrVrCRE4f6KkO+WJsPPdU7EqNlIK83uD72E0+aTJ2kDlO85mE3Mg8ZKZA3n0/QB41e0K+ETAsF1d+ndwtoi0nvgGQ5Brtxjv5UysCD/UJlOk4MJt/V5oiLgQ5WiK+RvGacdmmgAR4cVm4goEcf/ODuMf4HGv9wkeLLmcG93Ndq+fFU1KaKZmy73hzqqnT7gGxV6IWtCSWWq0fuVW3CdnnT+//lnFmSKijopFgkxfRxcrqk5Qg77s6lyd4bvzZy2gCqGFDw4eS04Q5j2gM53NZwGpOLBmKU98zHZa0iUabaOsDUsz6hwI6nttlrd9ALjeR+e/VVLOQrShindkcuK8nfqQAcPoU98bVjPSLjJZA4CxgqpCNuBoDJfMdO7QDOJ7LpUKSE6KuekXql5i5wC2SHxSehMTbJrgyiwRX/66ob4pV8l5FWFRIXdnd6diT7MYuBW2Hc1AQ4ZXqI8sDT4X3lLtg0vM3NSijYdg670+768OhsaIXrpnxRXzoSlWKS3nvLaE+Tox8IOlZmCMn3BHVjRTg09VkQ7L8jdRrJ2DKn9jF3BkGma+SxNuiG58CFkMCTHCFOGaMQBBpSrA55yE3pYWOeA1W5yRWgMF
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(346002)(376002)(396003)(136003)(451199021)(46966006)(36840700001)(30864003)(26005)(7636003)(356005)(7596003)(186003)(1076003)(6512007)(6506007)(7416002)(40140700001)(15974865002)(44832011)(2616005)(36860700001)(47076005)(36756003)(83380400001)(42882007)(2906002)(83170400001)(336012)(40480700001)(41300700001)(6486002)(316002)(54906003)(6666004)(966005)(82310400005)(478600001)(70586007)(70206006)(4326008)(45080400002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 12:44:08.3532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec030b5b-7879-48dc-5e64-08db5b8b6701
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT042.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MCP3564R is a 24-bit ADC with 8 multiplexed inputs. The MCP3561R is
the same device with 2 inputs, the MCP3562R has 4 inputs. The device
contains one ADC and a multiplexer to select the inputs to the ADC.
To facilitate buffered reading, only channels that can be continuously
sampled are exported to the IIO subsystem. The driver does not support
buffered reading yet.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 drivers/iio/adc/Kconfig    |  10 +
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/mcp356xr.c | 800 +++++++++++++++++++++++++++++++++++++
 3 files changed, 811 insertions(+)
 create mode 100644 drivers/iio/adc/mcp356xr.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index eb2b09ef5d5b..4e41eaa98ce9 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -768,6 +768,16 @@ config MCP3422
 	  This driver can also be built as a module. If so, the module will be
 	  called mcp3422.
=20
+config MCP356XR
+	tristate "Microchip Technology MCP3561/2/4R driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Microchip Technology's MCP3561R,
+	  MCP3562R, MCP3564R analog to digital converters.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called mcp356xr.
+
 config MCP3911
 	tristate "Microchip Technology MCP3911 driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index e07e4a3e6237..2da780fa0763 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_MAX1363) +=3D max1363.o
 obj-$(CONFIG_MAX9611) +=3D max9611.o
 obj-$(CONFIG_MCP320X) +=3D mcp320x.o
 obj-$(CONFIG_MCP3422) +=3D mcp3422.o
+obj-$(CONFIG_MCP356XR) +=3D mcp356xr.o
 obj-$(CONFIG_MCP3911) +=3D mcp3911.o
 obj-$(CONFIG_MEDIATEK_MT6360_ADC) +=3D mt6360-adc.o
 obj-$(CONFIG_MEDIATEK_MT6370_ADC) +=3D mt6370-adc.o
diff --git a/drivers/iio/adc/mcp356xr.c b/drivers/iio/adc/mcp356xr.c
new file mode 100644
index 000000000000..4b1b1f696435
--- /dev/null
+++ b/drivers/iio/adc/mcp356xr.c
@@ -0,0 +1,800 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Microchip MCP3561/2/4R, ADC with 1, 2 or 4 differential or 2=
, 4 or
+ * 8 single-ended inputs. The chip has a single ADC unit that can be muxed=
 to
+ * any external input, internal reference or internal temperature sensor.
+ *
+ * Copyright (C) 2023 Topic Embedded Products
+ *
+ * Datasheet and product information:
+ * https://www.microchip.com/en-us/product/MCP3564R
+ */
+
+#include <asm/unaligned.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#define MCP396XR_REG_ADCDATA		0x00
+#define MCP396XR_REG_CONFIG0		0x01
+#define MCP396XR_REG_CONFIG1		0x02
+#define MCP396XR_REG_CONFIG2		0x03
+#define MCP396XR_REG_CONFIG3		0x04
+#define MCP396XR_REG_IRQ		0x05
+#define MCP396XR_REG_MUX		0x06
+#define MCP396XR_REG_SCAN		0x07
+#define MCP396XR_REG_TIMER		0x08
+#define MCP396XR_REG_OFFSETCAL		0x09
+#define MCP396XR_REG_GAINCAL		0x0a
+#define MCP396XR_REG_LOCK		0x0d
+#define MCP396XR_REG_CRCCFG		0x0f
+
+#define MCP396XR_FASTCMD_START		0x0a
+#define MCP396XR_FASTCMD_RESET		0x0e
+
+#define MCP396XR_STATUS_DR		BIT(2)
+
+#define MCP396XR_CMD_MASK_DEV_ADDR	GENMASK(7, 6)
+#define MCP396XR_CMD_MASK_REG_ADDR	GENMASK(5, 2)
+#define MCP396XR_CMD_MASK_TYPE		GENMASK(1, 0)
+
+#define MCP396XR_CMD_TYPE_FAST		0x0
+#define MCP396XR_CMD_TYPE_READ_STATIC	0x1
+#define MCP396XR_CMD_TYPE_WRITE_SEQ	0x2
+#define MCP396XR_CMD_TYPE_READ_SEQ	0x3
+
+#define MCP396XR_CONFIG0_VREF_SEL	BIT(7)
+#define MCP396XR_CONFIG0_PARTIAL_SHDN	BIT(6)
+#define MCP396XR_CONFIG0_CLK_SEL_MASK	GENMASK(5, 4)
+#define MCP396XR_CONFIG0_CS_SEL_MASK	GENMASK(3, 2)
+#define MCP396XR_CONFIG0_ADC_MODE	GENMASK(1, 0)
+
+#define MCP396XR_CONFIG1_AMCLK_PRE	GENMASK(7, 6)
+#define MCP396XR_CONFIG1_OSR		GENMASK(5, 2)
+#define MCP396XR_CONFIG1_DEFAULT	FIELD_PREP(MCP396XR_CONFIG1_OSR, 0x3)
+
+#define MCP396XR_CONFIG2_BOOST		GENMASK(7, 6)
+#define MCP396XR_CONFIG2_GAIN		GENMASK(5, 3)
+#define MCP396XR_CONFIG2_AZ_MUX		BIT(2)
+#define MCP396XR_CONFIG2_AZ_REF		BIT(1)
+#define MCP396XR_CONFIG2_RESERVED1	BIT(0)
+#define MCP396XR_CONFIG2_DEFAULT				\
+		(FIELD_PREP(MCP396XR_CONFIG2_BOOST, 0x2) |	\
+		 FIELD_PREP(MCP396XR_CONFIG2_GAIN, 0x1) |	\
+		 MCP396XR_CONFIG2_RESERVED1)
+
+#define MCP396XR_CONFIG3_CONV_MODE	GENMASK(7, 6)
+#define MCP396XR_CONFIG3_DATA_FORMAT	GENMASK(5, 4)
+#define MCP396XR_CONFIG3_CRC_FORMAT	BIT(3)
+#define MCP396XR_CONFIG3_EN_CRCCOM	BIT(2)
+#define MCP396XR_CONFIG3_EN_OFFCAL	BIT(1)
+#define MCP396XR_CONFIG3_EN_GAINCAL	BIT(0)
+#define MCP396XR_CONFIG3_DEFAULT				\
+		(FIELD_PREP(MCP396XR_CONFIG3_CONV_MODE, 0x1) |	\
+		 FIELD_PREP(MCP396XR_CONFIG3_DATA_FORMAT, 0x3))
+
+#define MCP396XR_CLK_SEL_EXTERNAL	0x1
+#define MCP396XR_CLK_SEL_INTERNAL	0x2
+
+#define MCP396XR_ADC_MODE_SHUTDOWN	0x1
+#define MCP396XR_ADC_MODE_STANDBY	0x2
+#define MCP396XR_ADC_MODE_CONVERSION	0x3
+
+#define MCP396XR_IRQ_ENABLE_FASTCMD	BIT(1)
+#define MCP396XR_IRQ_PUSH_PULL		BIT(2)
+
+#define MCP396XR_LOCK_PASSWORD		0xA5
+
+#define MCP396XR_INT_VREF_UV	2400000
+#define MCP396XR_MAX_CHANNELS	8
+#define MCP396XR_MAX_TRANSFER_SIZE	4
+/* Internal RC oscilator runs between 3.3 and 6.6 MHz, use the average val=
ue */
+#define MCP396XR_INTERNAL_CLOCK_FREQ	4950000
+
+enum chip_ids {
+	mcp3564r,
+	mcp3562r,
+	mcp3561r,
+};
+
+struct mcp356xr {
+	struct spi_device *spi;
+	struct mutex lock;
+	struct regulator *vref;
+	struct clk *clki;
+	struct completion sample_available;
+	u8 dev_addr;
+	u8 n_inputs;
+	u8 config[4];
+	int scale_avail[8 * 2]; /* 8 gain settings */
+	/* SPI transfer buffer */
+	u8 buf[1 + MCP396XR_MAX_TRANSFER_SIZE] ____cacheline_aligned;
+};
+
+static const int mcp356xr_oversampling_rates[] =3D {
+	32,	64,	128,	256,
+	512,	1024,	2048,	4096,
+	8192,	16384,	20480,	24576,
+	40960,	49152,	81920,	98304,
+};
+
+/* Transfers len bytes starting at address reg, results in adc->buf */
+static int mcp356xr_read(struct mcp356xr *adc, u8 reg, u8 len)
+{
+	int ret;
+	struct spi_transfer xfer =3D {
+		.tx_buf =3D adc->buf,
+		.rx_buf =3D adc->buf,
+		.len =3D len + 1,
+	};
+
+	adc->buf[0] =3D FIELD_PREP(MCP396XR_CMD_MASK_DEV_ADDR, adc->dev_addr) |
+		      FIELD_PREP(MCP396XR_CMD_MASK_REG_ADDR, reg) |
+		      MCP396XR_CMD_TYPE_READ_SEQ;
+	memset(adc->buf + 1, 0, len);
+
+	ret =3D spi_sync_transfer(adc->spi, &xfer, 1);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
+static int mcp356xr_fast_command(struct mcp356xr *adc, u8 cmd)
+{
+	u8 buf =3D FIELD_PREP(MCP396XR_CMD_MASK_DEV_ADDR, adc->dev_addr) |
+		FIELD_PREP(MCP396XR_CMD_MASK_REG_ADDR, cmd) |
+		MCP396XR_CMD_TYPE_FAST;
+
+	return spi_write(adc->spi, &buf, 1);
+}
+
+static int mcp356xr_write(struct mcp356xr *adc, u8 reg, void *val, u8 len)
+{
+	int ret;
+	struct spi_transfer xfer =3D {
+		.tx_buf =3D adc->buf,
+		.rx_buf =3D adc->buf,
+		.len =3D len + 1,
+	};
+
+	adc->buf[0] =3D FIELD_PREP(MCP396XR_CMD_MASK_DEV_ADDR, adc->dev_addr) |
+		      FIELD_PREP(MCP396XR_CMD_MASK_REG_ADDR, reg) |
+		      MCP396XR_CMD_TYPE_WRITE_SEQ;
+	memcpy(adc->buf + 1, val, len);
+
+	ret =3D spi_sync_transfer(adc->spi, &xfer, 1);
+
+	return ret;
+}
+
+static int mcp356xr_write_u8(struct mcp356xr *adc, u8 reg, u8 value)
+{
+	return mcp356xr_write(adc, reg, &value, 1);
+}
+
+static int mcp356xr_update_config(struct mcp356xr *adc, u8 index, u8 value=
)
+{
+	int ret;
+
+	if (value =3D=3D adc->config[index])
+		return 0;
+
+	ret =3D mcp356xr_write(adc, MCP396XR_REG_CONFIG0 + index, &value, 1);
+	if (ret < 0)
+		return ret;
+
+	adc->config[index] =3D value;
+	return 0;
+}
+
+static int mcp356xr_calc_scale_avail(struct mcp356xr *adc)
+{
+	int millivolts;
+	int i;
+	int *scale_avail =3D adc->scale_avail;
+
+	if (adc->vref) {
+		millivolts =3D regulator_get_voltage(adc->vref);
+		if (millivolts < 0)
+			return millivolts;
+	} else {
+		millivolts =3D MCP396XR_INT_VREF_UV;
+	}
+	millivolts /=3D 1000;
+
+	/* Gain setting 0 is 0.333x */
+	scale_avail[0] =3D millivolts * 3;
+	scale_avail[1] =3D 23; /* 23 bits for full scale */
+	/* Other gain settings are power-of-two */
+	for (i =3D 1; i < 8; i++) {
+		scale_avail[i * 2 + 0] =3D millivolts;
+		scale_avail[i * 2 + 1] =3D 22 + i;
+	}
+
+	return 0;
+}
+
+static int mcp356xr_set_oversampling_rate(struct mcp356xr *adc, int val)
+{
+	int i;
+	u8 cfg;
+
+	for (i =3D 0; i < ARRAY_SIZE(mcp356xr_oversampling_rates); ++i) {
+		if (mcp356xr_oversampling_rates[i] =3D=3D val) {
+			cfg =3D adc->config[1] & ~MCP396XR_CONFIG1_OSR;
+			cfg |=3D FIELD_PREP(MCP396XR_CONFIG1_OSR, i);
+			return mcp356xr_update_config(adc, 1, cfg);
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int mcp356xr_get_oversampling_rate(struct mcp356xr *adc)
+{
+	return mcp356xr_oversampling_rates[FIELD_GET(MCP396XR_CONFIG1_OSR,
+						     adc->config[1])];
+}
+
+static int mcp356xr_set_scale(struct mcp356xr *adc, int val, int val2)
+{
+	int millivolts =3D adc->scale_avail[2];
+	int gain;
+	u8 regval;
+
+	/* The scale is always below 1 */
+	if (val)
+		return -EINVAL;
+
+	if (!val2)
+		return -EINVAL;
+
+	/*
+	 * val2 is in 'micro' units, n =3D val2 / 1000000
+	 * the full-scale value is millivolts / n, corresponds to 2^23,
+	 * hence the gain =3D ((val2 / 1000000) << 23) / millivolts
+	 * Approximate ((val2 / 1000000) << 23) as (549755 * val2) >> 16
+	 * because 2 << (23 + 16) / 1000000 =3D 549755
+	 */
+	gain =3D DIV_ROUND_CLOSEST(millivolts, (549755 * val2) >> 16);
+	if (gain >=3D BIT(7))
+		return -EINVAL;
+
+	regval =3D adc->config[2] & ~MCP396XR_CONFIG2_GAIN;
+	if (gain)
+		regval |=3D FIELD_PREP(MCP396XR_CONFIG2_GAIN, ffs(gain));
+
+	return mcp356xr_update_config(adc, 2, regval);
+}
+
+/* Calculate AMCLK (audio master clock) */
+static long mcp356xr_get_amclk_freq(struct mcp356xr *adc)
+{
+	long result;
+
+	if (adc->clki) {
+		result =3D clk_get_rate(adc->clki);
+		if (result > 0) {
+			result >>=3D FIELD_GET(MCP396XR_CONFIG1_AMCLK_PRE,
+					    adc->config[1]);
+		}
+	} else {
+		result =3D  MCP396XR_INTERNAL_CLOCK_FREQ;
+	}
+
+	return result;
+}
+
+static int mcp356xr_get_samp_freq(struct mcp356xr *adc)
+{
+	long freq =3D mcp356xr_get_amclk_freq(adc);
+	int osr =3D mcp356xr_get_oversampling_rate(adc);
+
+	/* DMCLK runs at 1/4 of AMCLK, data rate is DMCLK/OSR */
+	return freq / (osr << 2);
+}
+
+static int mcp356xr_adc_conversion(struct mcp356xr *adc,
+				   struct iio_chan_spec const *channel,
+				   int *val)
+{
+	long freq =3D mcp356xr_get_amclk_freq(adc);
+	int osr =3D mcp356xr_get_oversampling_rate(adc);
+	/* Over-estimate timeout by a factor 2 */
+	int timeout_ms =3D DIV_ROUND_UP((osr << 2) * 2 * 1000, freq);
+	int ret;
+
+	/* Setup input mux (address field is the mux setting) */
+	ret =3D mcp356xr_write_u8(adc, MCP396XR_REG_MUX, channel->address);
+	if (ret)
+		return ret;
+
+	reinit_completion(&adc->sample_available);
+	/* Start conversion */
+	ret =3D mcp356xr_fast_command(adc, MCP396XR_FASTCMD_START);
+	if (ret)
+		return ret;
+
+	if (timeout_ms < 10)
+		timeout_ms =3D 10;
+	ret =3D wait_for_completion_interruptible_timeout(
+			&adc->sample_available, msecs_to_jiffies(timeout_ms));
+	if (ret =3D=3D 0) {
+		/* Interrupt did not fire, check status and report */
+		dev_warn(&adc->spi->dev, "Timeout (%d ms)\n", timeout_ms);
+		ret =3D mcp356xr_read(adc, MCP396XR_REG_ADCDATA, 4);
+		if (!ret) {
+			/* Check if data-ready was asserted  */
+			if ((adc->buf[0] & MCP396XR_STATUS_DR))
+				return -ETIMEDOUT;
+		}
+	}
+
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * We're using data format 0b11 (see datasheet). While the ADC output is
+	 * 24-bit, it allows over-ranging it and produces a 25-bit output in
+	 * this mode. Hence the "24".
+	 */
+	*val =3D sign_extend32(get_unaligned_be32(&adc->buf[1]), 24);
+
+	return 0;
+}
+
+static int mcp356xr_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	struct mcp356xr *adc =3D iio_priv(indio_dev);
+	int ret =3D -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals =3D mcp356xr_oversampling_rates;
+		*type =3D IIO_VAL_INT;
+		*length =3D ARRAY_SIZE(mcp356xr_oversampling_rates);
+		ret =3D IIO_AVAIL_LIST;
+		break;
+
+	case IIO_CHAN_INFO_SCALE:
+		*type =3D IIO_VAL_FRACTIONAL_LOG2;
+		*vals =3D adc->scale_avail;
+		*length =3D ARRAY_SIZE(adc->scale_avail);
+		ret =3D IIO_AVAIL_LIST;
+		break;
+	}
+
+	return ret;
+}
+
+static int mcp356xr_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *channel, int *val,
+			    int *val2, long mask)
+{
+	struct mcp356xr *adc =3D iio_priv(indio_dev);
+	int ret =3D -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret =3D iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			break;
+
+		ret =3D mcp356xr_adc_conversion(adc, channel, val);
+		if (ret >=3D 0)
+			ret =3D IIO_VAL_INT;
+		iio_device_release_direct_mode(indio_dev);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret =3D FIELD_GET(MCP396XR_CONFIG2_GAIN, adc->config[2]);
+		*val =3D adc->scale_avail[ret * 2 + 0];
+		*val2 =3D adc->scale_avail[ret * 2 + 1];
+		ret =3D IIO_VAL_FRACTIONAL_LOG2;
+		if (channel->type =3D=3D IIO_TEMP) {
+			/* To obtain temperature scale, divide by 0.0002973 */
+			*val =3D 100 * ((*val * 100000) / 2973);
+		}
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		if (channel->type =3D=3D IIO_TEMP) {
+			ret =3D FIELD_GET(MCP396XR_CONFIG2_GAIN, adc->config[2]);
+			/* temperature has 80 mV offset */
+			*val =3D (-80 << adc->scale_avail[ret * 2 + 1]) /
+						adc->scale_avail[ret * 2 + 0];
+			ret =3D IIO_VAL_INT;
+		}
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val =3D mcp356xr_get_samp_freq(adc);
+		ret =3D IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val =3D mcp356xr_get_oversampling_rate(adc);
+		ret =3D IIO_VAL_INT;
+		break;
+	}
+
+	return ret;
+}
+
+static int mcp356xr_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *channel, int val,
+			    int val2, long mask)
+{
+	struct mcp356xr *adc =3D iio_priv(indio_dev);
+	int ret =3D -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret =3D mcp356xr_set_oversampling_rate(adc, val);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret =3D mcp356xr_set_scale(adc, val, val2);
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * The "address" field corresponds to the MUX setting entry in table 5-15 =
in
+ * the datasheet. The scan_index is the index into this table.
+ */
+
+#define MCP396XR_SHARED_BY_ALL					\
+		.info_mask_shared_by_all =3D			\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |	\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+		.info_mask_shared_by_all_available =3D		\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |	\
+			BIT(IIO_CHAN_INFO_SCALE)		\
+
+#define MCP396XR_VOLTAGE_CHANNEL(num)				\
+	{							\
+		.type =3D IIO_VOLTAGE,				\
+		.indexed =3D 1,					\
+		.channel =3D (num),				\
+		.address =3D ((num) << 4) | 0x08,			\
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),	\
+		.info_mask_shared_by_type =3D			\
+				BIT(IIO_CHAN_INFO_SCALE),	\
+		MCP396XR_SHARED_BY_ALL,				\
+		.scan_index =3D (num),				\
+	}
+
+#define MCP396XR_VOLTAGE_CHANNEL_DIFF(chan1, chan2)		\
+	{							\
+		.type =3D IIO_VOLTAGE,				\
+		.indexed =3D 1,					\
+		.channel =3D (chan1),				\
+		.channel2 =3D (chan2),				\
+		.address =3D ((chan1) << 4) | (chan2),		\
+		.differential =3D 1,				\
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),	\
+		.info_mask_shared_by_type =3D			\
+				BIT(IIO_CHAN_INFO_SCALE),	\
+		MCP396XR_SHARED_BY_ALL,				\
+		.scan_index =3D (chan1) / 2 + 8,			\
+	}
+
+#define MCP396XR_TEMP_CHANNEL					\
+	{							\
+		.type =3D IIO_TEMP,				\
+		.address =3D 0xDE,				\
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),	\
+		.info_mask_shared_by_type =3D			\
+				BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_OFFSET),	\
+		MCP396XR_SHARED_BY_ALL,				\
+		.scan_index =3D 12,				\
+		.datasheet_name =3D "TEMP",			\
+	}
+
+/* Internal voltage channels */
+#define MCP396XR_VOLTAGE_CHANNEL_INT(num, addr, name)		\
+	{							\
+		.type =3D IIO_VOLTAGE,				\
+		.indexed =3D 1,					\
+		.channel =3D (num),				\
+		.address =3D (addr),				\
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),	\
+		.info_mask_shared_by_type =3D			\
+				BIT(IIO_CHAN_INFO_SCALE),	\
+		MCP396XR_SHARED_BY_ALL,				\
+		.scan_index =3D (num),				\
+		.datasheet_name =3D (name),			\
+	}
+
+static const struct iio_chan_spec mcp3564r_channels[] =3D {
+	MCP396XR_VOLTAGE_CHANNEL(0),
+	MCP396XR_VOLTAGE_CHANNEL(1),
+	MCP396XR_VOLTAGE_CHANNEL(2),
+	MCP396XR_VOLTAGE_CHANNEL(3),
+	MCP396XR_VOLTAGE_CHANNEL(4),
+	MCP396XR_VOLTAGE_CHANNEL(5),
+	MCP396XR_VOLTAGE_CHANNEL(6),
+	MCP396XR_VOLTAGE_CHANNEL(7),
+	MCP396XR_VOLTAGE_CHANNEL_DIFF(0, 1),
+	MCP396XR_VOLTAGE_CHANNEL_DIFF(2, 3),
+	MCP396XR_VOLTAGE_CHANNEL_DIFF(4, 5),
+	MCP396XR_VOLTAGE_CHANNEL_DIFF(6, 7),
+	MCP396XR_TEMP_CHANNEL,
+	MCP396XR_VOLTAGE_CHANNEL_INT(13, 0x98, "AVDD"),
+	MCP396XR_VOLTAGE_CHANNEL_INT(14, 0xF8, "VCM"),
+	MCP396XR_VOLTAGE_CHANNEL_INT(15, 0x88, "OFFSET"),
+};
+
+static const struct iio_chan_spec mcp3562r_channels[] =3D {
+	MCP396XR_VOLTAGE_CHANNEL(0),
+	MCP396XR_VOLTAGE_CHANNEL(1),
+	MCP396XR_VOLTAGE_CHANNEL(2),
+	MCP396XR_VOLTAGE_CHANNEL(3),
+	MCP396XR_VOLTAGE_CHANNEL_DIFF(0, 1),
+	MCP396XR_VOLTAGE_CHANNEL_DIFF(2, 3),
+	MCP396XR_TEMP_CHANNEL,
+	MCP396XR_VOLTAGE_CHANNEL_INT(13, 0x98, "AVDD"),
+	MCP396XR_VOLTAGE_CHANNEL_INT(14, 0xF8, "VCM"),
+	MCP396XR_VOLTAGE_CHANNEL_INT(15, 0x88, "OFFSET"),
+};
+
+static const struct iio_chan_spec mcp3561r_channels[] =3D {
+	MCP396XR_VOLTAGE_CHANNEL(0),
+	MCP396XR_VOLTAGE_CHANNEL(1),
+	MCP396XR_VOLTAGE_CHANNEL_DIFF(0, 1),
+	MCP396XR_TEMP_CHANNEL,
+	MCP396XR_VOLTAGE_CHANNEL_INT(13, 0x98, "AVDD"),
+	MCP396XR_VOLTAGE_CHANNEL_INT(14, 0xF8, "VCM"),
+	MCP396XR_VOLTAGE_CHANNEL_INT(15, 0x88, "OFFSET"),
+};
+
+static const struct iio_info mcp356xr_info =3D {
+	.read_raw =3D mcp356xr_read_raw,
+	.read_avail =3D mcp356xr_read_avail,
+	.write_raw =3D mcp356xr_write_raw,
+};
+
+/* Interrupt handler */
+static irqreturn_t mcp356xr_irq_handler(int irq, void *private)
+{
+	struct mcp356xr *adc =3D private;
+	int ret;
+
+	ret =3D mcp356xr_read(adc, MCP396XR_REG_ADCDATA, 4);
+	if (!ret) {
+		/* Check if data-ready bit is 0 (active) */
+		if (!(adc->buf[0] & MCP396XR_STATUS_DR))
+			complete(&adc->sample_available);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int mcp356xr_config(struct mcp356xr *adc, struct device_node *of_no=
de)
+{
+	int ret;
+	u32 value;
+	u8 regval;
+
+	if (!of_property_read_u32(of_node, "device-addr", &value)) {
+		if (value > 3) {
+			dev_err(&adc->spi->dev,
+				"invalid device address (%u). Must be <3.\n",
+				value);
+			return -EINVAL;
+		}
+		adc->dev_addr =3D value;
+	} else {
+		/* Default address is "1" unless you special-order them */
+		adc->dev_addr =3D 0x1;
+	}
+	dev_dbg(&adc->spi->dev, "use device address %u\n", adc->dev_addr);
+
+	/*
+	 * Datasheet mentions this POR procedure:
+	 * - Write LOCK register to 0xA5
+	 * - Write IRQ register to 0x03
+	 * - Send a fast CMD full reset (1110)
+	 * - Reconfigure the chip as desired
+	 */
+	ret =3D mcp356xr_write_u8(adc, MCP396XR_REG_LOCK, MCP396XR_LOCK_PASSWORD)=
;
+	if (ret)
+		return ret;
+
+	ret =3D mcp356xr_write_u8(adc, MCP396XR_REG_IRQ, 0x03);
+	if (ret)
+		return ret;
+
+	ret =3D mcp356xr_fast_command(adc, MCP396XR_FASTCMD_RESET);
+	if (ret)
+		return ret;
+
+	usleep_range(200, 400);
+
+	/* Default values */
+	regval =3D MCP396XR_CONFIG0_PARTIAL_SHDN | MCP396XR_ADC_MODE_SHUTDOWN;
+
+	if (!adc->vref) {
+		dev_dbg(&adc->spi->dev,
+			"use internal voltage reference (2.4V)\n");
+		regval |=3D MCP396XR_CONFIG0_VREF_SEL;
+	}
+
+	if (adc->clki) {
+		dev_dbg(&adc->spi->dev, "use external clock\n");
+		regval |=3D FIELD_PREP(MCP396XR_CONFIG0_CLK_SEL_MASK,
+					MCP396XR_CLK_SEL_EXTERNAL);
+	} else {
+		dev_dbg(&adc->spi->dev,
+			"use internal RC oscillator\n");
+		regval |=3D FIELD_PREP(MCP396XR_CONFIG0_CLK_SEL_MASK,
+					MCP396XR_CLK_SEL_INTERNAL);
+	}
+	adc->config[0] =3D regval;
+	adc->config[1] =3D MCP396XR_CONFIG1_DEFAULT;
+	adc->config[2] =3D MCP396XR_CONFIG2_DEFAULT;
+	adc->config[3] =3D MCP396XR_CONFIG3_DEFAULT;
+
+	ret =3D mcp356xr_write(adc, MCP396XR_REG_CONFIG0, adc->config,
+			     sizeof(adc->config));
+	if (ret)
+		return ret;
+
+	/* Enable fast commands, disable start-of-conversion interrupt */
+	regval =3D MCP396XR_IRQ_ENABLE_FASTCMD;
+	if (!of_property_read_bool(of_node, "drive-open-drain"))
+		regval |=3D MCP396XR_IRQ_PUSH_PULL;
+	ret =3D mcp356xr_write_u8(adc, MCP396XR_REG_IRQ, regval);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void mcp356xr_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
+static void mcp356xr_clk_disable(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
+static int mcp356xr_probe(struct spi_device *spi)
+{
+	struct device *dev =3D &spi->dev;
+	struct iio_dev *indio_dev;
+	struct mcp356xr *adc;
+	enum chip_ids chip;
+	int ret;
+
+	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc =3D iio_priv(indio_dev);
+	adc->spi =3D spi;
+	mutex_init(&adc->lock);
+	init_completion(&adc->sample_available);
+
+	adc->vref =3D devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(adc->vref)) {
+		if (PTR_ERR(adc->vref) =3D=3D -ENODEV) {
+			adc->vref =3D NULL;
+		} else {
+			return dev_err_probe(dev, PTR_ERR(adc->vref),
+					     "Failed to get vref regulator\n");
+		}
+	} else {
+		ret =3D regulator_enable(adc->vref);
+		if (ret)
+			return ret;
+
+		ret =3D devm_add_action_or_reset(dev, mcp356xr_reg_disable,
+					       adc->vref);
+		if (ret)
+			return ret;
+	}
+
+	adc->clki =3D devm_clk_get(dev, NULL);
+	if (IS_ERR(adc->clki)) {
+		if (PTR_ERR(adc->clki) =3D=3D -ENOENT) {
+			adc->clki =3D NULL;
+		} else {
+			return dev_err_probe(dev, PTR_ERR(adc->clki),
+					     "Failed to get adc clk\n");
+		}
+	} else {
+		ret =3D clk_prepare_enable(adc->clki);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Failed to enable adc clk\n");
+
+		ret =3D devm_add_action_or_reset(dev, mcp356xr_clk_disable,
+					       adc->clki);
+		if (ret)
+			return ret;
+	}
+
+	ret =3D mcp356xr_calc_scale_avail(adc);
+	if (ret)
+		return ret;
+
+	ret =3D mcp356xr_config(adc, dev->of_node);
+	if (ret)
+		return ret;
+
+	indio_dev->name =3D spi_get_device_id(spi)->name;
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->info =3D &mcp356xr_info;
+	spi_set_drvdata(spi, indio_dev);
+
+	chip =3D (enum chip_ids)spi_get_device_id(spi)->driver_data;
+	switch (chip) {
+	case mcp3564r:
+		indio_dev->channels =3D mcp3564r_channels;
+		indio_dev->num_channels =3D ARRAY_SIZE(mcp3564r_channels);
+		break;
+	case mcp3562r:
+		indio_dev->channels =3D mcp3562r_channels;
+		indio_dev->num_channels =3D ARRAY_SIZE(mcp3562r_channels);
+		break;
+	case mcp3561r:
+		indio_dev->channels =3D mcp3561r_channels;
+		indio_dev->num_channels =3D ARRAY_SIZE(mcp3561r_channels);
+		break;
+	}
+
+	ret =3D devm_request_threaded_irq(dev, spi->irq, NULL,
+					mcp356xr_irq_handler,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT |
+					IRQF_SHARED,
+					spi->dev.driver->name, adc);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to allocate IRQ\n");
+
+	ret =3D devm_iio_device_register(dev, indio_dev);
+	return ret;
+}
+
+static const struct of_device_id mcp356xr_dt_ids[] =3D {
+	{ .compatible =3D "microchip,mcp3561r", .data =3D (void *)mcp3561r },
+	{ .compatible =3D "microchip,mcp3562r", .data =3D (void *)mcp3562r },
+	{ .compatible =3D "microchip,mcp3564r", .data =3D (void *)mcp3564r },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mcp356xr_dt_ids);
+
+static const struct spi_device_id mcp356xr_id[] =3D {
+	{ "mcp3561r", mcp3561r },
+	{ "mcp3562r", mcp3562r },
+	{ "mcp3564r", mcp3564r },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, mcp356xr_id);
+
+static struct spi_driver mcp356xr_driver =3D {
+	.driver =3D {
+		.name =3D "mcp356xr",
+		.of_match_table =3D mcp356xr_dt_ids,
+	},
+	.probe =3D mcp356xr_probe,
+	.id_table =3D mcp356xr_id,
+};
+module_spi_driver(mcp356xr_driver);
+
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("Microchip Technology MCP356XR");
+MODULE_LICENSE("GPL");
--=20
2.17.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
