Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A2F5B9A68
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiIOMIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiIOMIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:08:21 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966607D1C3;
        Thu, 15 Sep 2022 05:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WECBcTeDVkr7xjx8lHzbWlOZr7WM4YqpJq6xDO00juUptxu4Ykjmj6ArdUc7WU11VJ2wRb4JR6NBXDcIpVyKD1LjBMxOxjSsZeeAbUeEmxYyLYx+66aBTmCTS730LIqm6SK4lemBFwdkzXbPG2ne6xmRp12k1JvRwYM6xBnbdjXsXaXQqW+f7+jMYdv2bwLHMryZFMGsTelXOpKWaDJbxpVU3vO3if5WmcqaGWMjR9rCqu4fTI5/ndh13ZFJWYeu0Y48SF8QEMn9Fidr9aNT8n9AleZXvuyQ7sqFuIqaXReDeiZ/qZrw5B443DKKzlXRZoTu3UAPSiBPuV3UTqNKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WlEA8FSZiP3dwCrA4X9QhFCQoEmG3MAcuV1rXN1Dwg=;
 b=gVy1ibbqwltJ4MxiD+1ABzDrFLjzGbfCxzRF9XzuZyLCzM26fJFA3bK3+0IElElnGVmHnDwZcRKdA2l3NrTpkoOh5dQDONPLEo3R+KgAGO4dUvz6wNlDzeWki8/baZrHyW7iO1CKkndCWn8w1JR7qkelqxKJOYFawFEw3ZlEczOeu77jwGsAikIXfC36OEs6rigTpZRVv475obrBpy3NyBmmXvXHGPV8xl4zuExV0v+NT8ov+urz9a8J4rVs/KrMLHem8fuwSW9u3srpXYPWqIKKhGt3y2sZLK75mJLd8OIr00IX/t4F/TgtBtWjseAG4RXIf9IDmwYdcLmmq5WB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WlEA8FSZiP3dwCrA4X9QhFCQoEmG3MAcuV1rXN1Dwg=;
 b=YeVAhRxqoMUz/GLuCAPZKGUafDsS0huI0WeWdhc7nOZ30Jox567PfFp2ClP3EbWAtEkOcvWxnQd110zCg8JTDktjv6YBfPX9R5jxmUCWPj+2ilAW6loLJubzzlOJcsFm8y7v2NxD920ay1Cdo5x7k8Hv9CCmx2f63GU1K3VqodY=
Received: from DS7PR03CA0240.namprd03.prod.outlook.com (2603:10b6:5:3ba::35)
 by DM8PR02MB8296.namprd02.prod.outlook.com (2603:10b6:8:7::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.19; Thu, 15 Sep 2022 12:08:11 +0000
Received: from DM3NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::a1) by DS7PR03CA0240.outlook.office365.com
 (2603:10b6:5:3ba::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 12:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT015.mail.protection.outlook.com (10.13.5.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 12:08:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 15 Sep 2022 05:08:02 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Thu, 15 Sep 2022 05:08:02 -0700
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
        id 1oYnf0-000Fci-9I; Thu, 15 Sep 2022 05:08:02 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v2 2/7] spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
Date:   Thu, 15 Sep 2022 17:37:45 +0530
Message-ID: <20220915120750.1424984-3-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
References: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT015:EE_|DM8PR02MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: b18b2f9e-f037-4928-2de8-08da9712f5fc
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qk2q35UbNLSN18D+psJ9qc2qw27DyFVqjQKYaBzvSs/bz4c3fj9efQ0uWdfQrgFKiw9J0vHAlXe56C0Vx62psfPv5VBaueDuKzUcuLZs2T3uFepKM2vavCAp1y7EC63smElwn9l8uNhjBZm2zClnVIXUCggbFaFfuG6j2w0ikmvj4SR/CDvmE5SOzBvjzG8RLrefX8sBwfG0gb07eQ83GXZkfkPOtFqqPP5LnLupK8jp73OuanDa9X3oKMcKk11VgSi7Ka+fsk7wXC8Fq1AenW9KqUK9zGLT3LGYyF9emBKA+y9DwjxnXT5pJ+p0kkq6m8j2NglhQy3puH6DQOKtk4Y/lPQJKa6j1O7BUKqSK2zPLouQUm+o6i5RFD9VwfzPwbjnBW7upXmUjwApedzUfgBmyHCTIgy0CyQ10VKbQGX8uIVegVcr7N2zhPuixyvYIKqR3+mzkk0/oyIsNeW1lOqNF2kjqP5coqgRcx0AX34LTC6bhw5cfC1NDbjyER7kh9HEBc+jyF9nwS3enV9Qrc4qwsef8dr+1xQrSlxdmaBqF/jBvsi02Mtjv3+T0M1JIlpckcZQ1o3QDkQJvZ5OSQuasqvgLPNQTVHbOz0EE7yzKts+wgmEuTiU1jt4YL2lRADmxzcOFMyopp9wK/6pMJKS8arNm1QRCD2nRn1QxVgcUuc831NuLRMu+H4AqkU3Y/OqOERSeI92EZ8RlHQSFg6I3gl+zrcWPry3fboQW6sm1awPGwqXLe74j4g0l5l/EHh5S3UI/IFtsmhC5T6ghOlUkk48kDMfLPnF1tjKewk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(8676002)(36860700001)(40460700003)(336012)(5660300002)(186003)(110136005)(8936002)(7416002)(7696005)(26005)(54906003)(6666004)(107886003)(316002)(82310400005)(83380400001)(478600001)(2616005)(41300700001)(7636003)(36756003)(82740400003)(9786002)(47076005)(1076003)(356005)(426003)(2906002)(70586007)(40480700001)(4326008)(70206006)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 12:08:11.7403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b18b2f9e-f037-4928-2de8-08da9712f5fc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8296
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During every transfer GQSPI driver writes the CPOL & CPHA values to the
configuration register. But the CPOL & CPHA values do not change in between
multiple transfers, so moved the CPOL & CPHA initialization to hardware
init so that the values are written only once.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index b07bb97cf874..6771496c1f86 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -264,7 +264,9 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
  *	- Enable manual slave select
  *	- Enable manual start
  *	- Deselect all the chip select lines
- *	- Set the little endian mode of TX FIFO and
+ *	- Set the little endian mode of TX FIFO
+ *	- Set clock phase
+ *	- Set clock polarity and
  *	- Enable the QSPI controller
  */
 static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
@@ -303,10 +305,17 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 	config_reg |= GQSPI_CFG_WP_HOLD_MASK;
 	/* Clear pre-scalar by default */
 	config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
-	/* CPHA 0 */
-	config_reg &= ~GQSPI_CFG_CLK_PHA_MASK;
-	/* CPOL 0 */
-	config_reg &= ~GQSPI_CFG_CLK_POL_MASK;
+	/* Set CPHA */
+	if (xqspi->ctlr->mode_bits & SPI_CPHA)
+		config_reg |= GQSPI_CFG_CLK_PHA_MASK;
+	else
+		config_reg &= ~GQSPI_CFG_CLK_PHA_MASK;
+	/* Set CPOL */
+	if (xqspi->ctlr->mode_bits & SPI_CPOL)
+		config_reg |= GQSPI_CFG_CLK_POL_MASK;
+	else
+		config_reg &= ~GQSPI_CFG_CLK_POL_MASK;
+
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
 
 	/* Clear the TX and RX FIFO */
@@ -463,14 +472,6 @@ static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
 
 	config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
 
-	/* Set the QSPI clock phase and clock polarity */
-	config_reg &= (~GQSPI_CFG_CLK_PHA_MASK) & (~GQSPI_CFG_CLK_POL_MASK);
-
-	if (qspi->mode & SPI_CPHA)
-		config_reg |= GQSPI_CFG_CLK_PHA_MASK;
-	if (qspi->mode & SPI_CPOL)
-		config_reg |= GQSPI_CFG_CLK_POL_MASK;
-
 	config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
 	config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
@@ -1162,6 +1163,9 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
+		SPI_TX_DUAL | SPI_TX_QUAD;
+
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
 
@@ -1188,8 +1192,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->setup = zynqmp_qspi_setup_op;
 	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
-	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
-			    SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
 	ctlr->auto_runtime_pm = true;
 
-- 
2.25.1

