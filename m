Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF81B5B9A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIOMIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIOMIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:08:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2AC83060;
        Thu, 15 Sep 2022 05:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEEf1u4ZNVO2FL/uR6hBeKbLnWOLl/1HRI7TYEO67rBKU8nWh2m3WUmcXYtsUNtPy/Dtrm58ajENCEdmfTGcmZHpBL64xzspNw/Au/etkga56VEerGFQwbOg1d8UnOGYD8slNyqZB85VAJzil6PZkEhlWjf8U+HfjNZTloyl/4844HBfla3XHF1yHb9QA9DIwRoPIdJQXiMFkt+xRxiKK2TVOxi848i7nMMctYFzHw3R9xmFE/X2ZtY2DxWRtwI3WbAxkhZwnN2mInSeafBLCGF72wo1pBVUauz0kB5CRZ3JQPljS6DlgotS241iUVCOtac5056Ad3J/n81q4WC8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gsn2LBpwiGqQcZmaJKicYpFEY+6Vq++VvL8W/4jTY9E=;
 b=gpf7D6OHgUDNGH6dfLq7eF4NjSj6bkRUtP8or0lKaFJEkjTezfrNXb2fDEGHIU59a2p6dQWeNJZK3sHUI2aF6Lx8JyOoipYjYHKLdlfwsiiz6d6SV18NlPxG6rN9P3j8MjLwzzmQ0IZ0IoRT5o38kV5b7w7IEZ8CgqbCrwNhJQvPus5gHHyINic8ydFh8GVbylCoz12zxzX0bGAv0kjC9joYvvjGRU20mIa45HvzvAeYxRwTy3b6cqDRHiH4ZWg8BlCJ4Mme4zrw+XQ1Mp5Z5Qv25g1u/oWxostle/1jASakoLV/gA9Qzl79b3IzbxGZodifCr/yPzg/YLpGA+xbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gsn2LBpwiGqQcZmaJKicYpFEY+6Vq++VvL8W/4jTY9E=;
 b=X50cjD5Cl/uQHYsHHXDQ1hSKJegg9ASALC3AgNxu0yfLXlbdYw8WpjcIrKgf8sVcPEG1x3DoPivizZyrSl8zrV/82T1TJOpH4XtAPcPxjxCvSRyAfq07fPnt4Mk/InADr8Lx9NtvNnMlsKIBahUPIsmFRmRzw1i6MamIiFFhDxk=
Received: from DS7PR03CA0227.namprd03.prod.outlook.com (2603:10b6:5:3ba::22)
 by BN0PR02MB8109.namprd02.prod.outlook.com (2603:10b6:408:16a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 12:08:15 +0000
Received: from DM3NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::85) by DS7PR03CA0227.outlook.office365.com
 (2603:10b6:5:3ba::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 12:08:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT015.mail.protection.outlook.com (10.13.5.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 12:08:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 15 Sep 2022 05:08:05 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Thu, 15 Sep 2022 05:08:05 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 git@amd.com,
 michal.simek@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 akumarma@amd.com
Received: from [10.140.6.39] (port=33420 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1oYnf3-000Fci-EB; Thu, 15 Sep 2022 05:08:05 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v2 3/7] spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same SPI frequency
Date:   Thu, 15 Sep 2022 17:37:46 +0530
Message-ID: <20220915120750.1424984-4-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
References: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT015:EE_|BN0PR02MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: c76f68e8-832a-4396-fa8b-08da9712f7d8
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHPm3/I1GCD8z1K/sOm4oV5U+c+vL6Wqit4j1XsWseiFRuzXlaJSH+LIqeaBytIDiBHzLESOUbNWcnkP3KIf5kUm+ItcNEdgLkaZSsxMSH2gaHPuSt/h7PnMwJtq0iEK4JppXPtDLzh1SnF4a/2eEOLaABoXBViTxVARJ4Kw+Qzx+I4BCYVY/qsrqgtBZE4sJiU0WD+UZGY+H31njRg9PFdzrUb+OC7NPXmDflwMGJnBDvYwZj/LvrPjJ5XpTlXcNRjzNab9AdwobjTvX4SVnAFewURcYa6k8+bjHbq/l+9oxO3B0PrNOicJQdju8jIkCNIwy1OripxSGCa6FlmGI5AQEK5TbqGUM5G53WHFKRPPExK6zGBBuejs+2zPwZ7sCkmnooUuuNYNtIK9S7vfTCoHh8puMDYZdC0P/pt9TZu+jSOMkewszL4aEnGe7VkZhNdleC3rJyAAmAPIyA1c2XZo+sGu2t39IjmjrsobWJOjHcbHovFkoSWFHb/nUWZZhymt9PBV1QwsjEOTg4ehbNH90PGyczKhTVPGXEMZQU4t9ewvNykzKfdRXYix0tyqonBFmUklye7DdM1xyrcbMNQisvdkf2kfoQQAZe3kfmH3budXMm4mjkszst/3S1Lxd444Io0eS/nWI9PX3pyNgZLGbv/EsVYeY3s7eHsExMxswJk/su1A5rCvvVVJzLyHFnZAL2zA5BDKTU25xx+C9a42Jm0DVcfhNZCUjYXXkVnoks9jcrrwPF6lyBgjs0lmXZS+XIbZZZGyqhZFCGNeuk67uZMWUUvWXhSHb31zu5Q=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(186003)(107886003)(6666004)(2906002)(478600001)(4326008)(83380400001)(47076005)(2616005)(1076003)(70586007)(336012)(426003)(26005)(40460700003)(7696005)(7416002)(40480700001)(5660300002)(8676002)(82310400005)(316002)(8936002)(110136005)(9786002)(54906003)(70206006)(82740400003)(36860700001)(356005)(7636003)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 12:08:14.8650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76f68e8-832a-4396-fa8b-08da9712f7d8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8109
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During every transfer the GQSPI driver configures the baud rate value. But
when there is no change in the SPI clock frequency the driver should avoid
rewriting the same baud rate value to the configuration register. With this
patch the GQSPI driver rewrites the baud rate value if there is a change in
SPI clock frequency.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 49 ++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 6771496c1f86..024085098515 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -157,6 +157,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @mode:		Defines the mode in which QSPI is operating
  * @data_completion:	completion structure
  * @op_lock:		Operational lock
+ * @speed_hz:		Current SPI bus clock speed in hz
  */
 struct zynqmp_qspi {
 	struct spi_controller *ctlr;
@@ -177,6 +178,7 @@ struct zynqmp_qspi {
 	enum mode_type mode;
 	struct completion data_completion;
 	struct mutex op_lock;
+	u32 speed_hz;
 };
 
 /**
@@ -271,7 +273,8 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
  */
 static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 {
-	u32 config_reg;
+	u32 config_reg, baud_rate_val = 0;
+	ulong clk_rate;
 
 	/* Select the GQSPI mode */
 	zynqmp_gqspi_write(xqspi, GQSPI_SEL_OFST, GQSPI_SEL_MASK);
@@ -316,6 +319,16 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 	else
 		config_reg &= ~GQSPI_CFG_CLK_POL_MASK;
 
+	/* Set the clock frequency */
+	clk_rate = clk_get_rate(xqspi->refclk);
+	while ((baud_rate_val < GQSPI_BAUD_DIV_MAX) &&
+	       (clk_rate /
+		(GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) > xqspi->speed_hz)
+		baud_rate_val++;
+
+	config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
+	config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
+
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
 
 	/* Clear the TX and RX FIFO */
@@ -459,22 +472,29 @@ static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
 				 struct spi_device *qspi)
 {
 	ulong clk_rate;
-	u32 config_reg, baud_rate_val = 0;
+	u32 config_reg, req_speed_hz, baud_rate_val = 0;
 
-	/* Set the clock frequency */
-	/* If req_hz == 0, default to lowest speed */
-	clk_rate = clk_get_rate(xqspi->refclk);
+	req_speed_hz = qspi->max_speed_hz;
 
-	while ((baud_rate_val < GQSPI_BAUD_DIV_MAX) &&
-	       (clk_rate /
-		(GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) > qspi->max_speed_hz)
-		baud_rate_val++;
+	if (xqspi->speed_hz != req_speed_hz) {
+		xqspi->speed_hz = req_speed_hz;
 
-	config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
+		/* Set the clock frequency */
+		/* If req_speed_hz == 0, default to lowest speed */
+		clk_rate = clk_get_rate(xqspi->refclk);
 
-	config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
-	config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
-	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+		while ((baud_rate_val < GQSPI_BAUD_DIV_MAX) &&
+		       (clk_rate /
+			(GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) >
+		       req_speed_hz)
+			baud_rate_val++;
+
+		config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
+
+		config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
+		config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
+		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+	}
 	return 0;
 }
 
@@ -1165,6 +1185,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 		SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
+	xqspi->speed_hz = ctlr->max_speed_hz;
 
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
@@ -1190,7 +1212,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->num_chipselect = GQSPI_DEFAULT_NUM_CS;
 	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
 	ctlr->setup = zynqmp_qspi_setup_op;
-	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->dev.of_node = np;
 	ctlr->auto_runtime_pm = true;
-- 
2.25.1

