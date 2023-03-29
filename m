Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9D86CD8B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjC2LrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjC2LrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:47:01 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12184226;
        Wed, 29 Mar 2023 04:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmr9FxsL1j8kOSnF/quoiivnhVYYLKIa2D+fbPReVjeQEsxelqYHExO/GEV9uX9s0KZKyw4DgEUxHhpWuu8v26MyA09pU1fVPMBvX9TATqaYVU6D6Ro5hp1gWmfFbmwQ5yiZye0fVr2lqrHFvb2RnOIxZomSFasvP4oTXBUwhNE00E1BMXmjpQhGi3gimTmOeHjftKZJ7T/YGl7U6w2nCVuEzLAenSk5yy1JYKfnlzLSK0rNs+jLu9XzH7qlAFuTssWU7ZxD20mpcaUHhosuFU6P1hg02BvIW2L7N/Z0xqLF50oYAtGtWVPIvDPTfzOBJZBbjFCojjvkOUo4prZ16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cizPKg38UKgQqSRqzjOIahfSEvkwRC4rAbsA2sBhseQ=;
 b=I7sOpFALIvnIsJ+HCYvT4Lluhd5P/paCFkKQ/sooypnNiax36jHiJxjKTnkqADjGlrFSssM7GByiyUYlL750LkbX/HxSqwJvy2zUGUd8yS0cX6GEv+HHSuXR9NMPGYMN5jUQ1/ueu1Hri4jHsEuj1auYPQz7f3/URXfgYQ67jY1fmh5ERU7Himlt/qxOcmUpni8MHidOkFXu84NfRYVSnoASTUczSEXqU5NZe+qyjYwXvzy/FvQ7Znfvpr7tMDEfYrRNdQVbkbTlv1mU/2OZXMOVpMYr2417RBs4/mbzo5PwZyuwMJ7Dl9tKapNcYJBPGoPsAdnWvqc1eQ/tHovHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cizPKg38UKgQqSRqzjOIahfSEvkwRC4rAbsA2sBhseQ=;
 b=FKI5T1qQhZvR7siF4WFGCDs1TGQkWXjblquG4XoL8s9oKhB9XJr8c8ir1lggjHwdd3mSwIeDJw11tIVHbk1xo100CTfBido0VwJAxzLNfnfqqWNud6HLoSeafHpcXZRDmmXigH4dT4CrWQms/QPR5/YMIY7Kb35Z6a3RpGHIdVk=
Received: from DM5PR08CA0058.namprd08.prod.outlook.com (2603:10b6:4:60::47) by
 BY5PR02MB7091.namprd02.prod.outlook.com (2603:10b6:a03:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 11:46:51 +0000
Received: from DM3NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::9d) by DM5PR08CA0058.outlook.office365.com
 (2603:10b6:4:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 11:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT014.mail.protection.outlook.com (10.13.5.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Wed, 29 Mar 2023 11:46:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 29 Mar 2023 04:46:46 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 29 Mar 2023 04:46:46 -0700
Envelope-to: git@amd.com,
 srinivas.goud@amd.com,
 gcnu.goud@gmail.com,
 broonie@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Received: from [172.23.64.2] (port=58553 helo=xhdvnc102.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.goud@xilinx.com>)
        id 1phUGL-000CDC-Dd; Wed, 29 Mar 2023 04:46:46 -0700
Received: by xhdvnc102.xilinx.com (Postfix, from userid 10378)
        id 57600104546; Wed, 29 Mar 2023 17:16:31 +0530 (IST)
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <gcnu.goud@gmail.com>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH 1/2] spi: spi-cadence: Switch to spi_controller structure
Date:   Wed, 29 Mar 2023 17:16:23 +0530
Message-ID: <1680090384-25769-2-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1680090384-25769-1-git-send-email-srinivas.goud@amd.com>
References: <1680090384-25769-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT014:EE_|BY5PR02MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f1d1ae-9557-4626-c1cd-08db304b493e
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYp7BRQk0CGFGxSqIpLFrydGiOqd9PbfIB8u1dHdePqB63LTvmQJVTinhyAP3luDuKtSoBYThJMOtcdGE7/oIvU8gyuyXM38uXvlQQqslx6p1ebOsfCVnuf5TkTn/tXQ5k6OHuGeRHVg1l9FD9SJVtpRLxQUv99424pNyJ7XgdNvTPZRuQNwEayYgVgsIfr2SqTTE81GqsPqYGgFYJ2GLXtWIRdp1wxDkbhJGFWv55lv68OPef0Raqo+OXk1ZZMQC2aW4gjjPwkMNLT339a4Tnyl2MfrjjVbTNJSkJArIsmWL7H+kjBwqO76NoA+G6LkM6sB2WXyqa+Oe+r0RZJZkTeB6G0QoLkMDX5pBk9SrmBtQs2oIuWk7ZVxmQp1IRFsJN8wE1/UDPfO/FPEAt3N5jO4Mj9hmLheKCTkB/1VCfMMXTHTsQReG44Mp/+zlvv5hPrsu8PJQuQf0I+cWeLqI6J+3umOwRS3kaOU7l95B+4B8VeLvVYbSGb3ubN6MmaSenay6snb0XLLUSqR+lbg5fkZVSI92eacOvbeO+hvjs5+6U1szPWcBspdfsH4KpliVdWzQOPAeqU9y3ic8LLFpRqzqXCI7AK7FvyoAxYt8hekcZZINV+oclrFnOam5auSz7kiSBBN4LGAM1ClpYg0PLqFeNwQvrX3h6zzVLYNXwBL7Wu5/1UBxWN7j5HHlOdorGhNSHv9gwOq+HmZftNa2e6hRSOB/i3SHbhzYxIt090=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(7636003)(356005)(26005)(6666004)(186003)(83380400001)(2616005)(336012)(42882007)(47076005)(6266002)(5660300002)(36860700001)(44832011)(8936002)(2906002)(30864003)(40460700003)(82310400005)(36756003)(42186006)(478600001)(54906003)(83170400001)(40480700001)(316002)(8676002)(70586007)(70206006)(41300700001)(4326008)(6916009)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 11:46:51.1493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f1d1ae-9557-4626-c1cd-08db304b493e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7091
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace spi_master structure with spi_controller structure.
spi_controller structure provides interface support for
both SPI master and slave controller.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
 drivers/spi/spi-cadence.c | 116 +++++++++++++++++++++++-----------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 4ec778d..e18df53 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -173,7 +173,7 @@ static void cdns_spi_init_hw(struct cdns_spi *xspi)
  */
 static void cdns_spi_chipselect(struct spi_device *spi, bool is_high)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(spi->controller);
 	u32 ctrl_reg;
 
 	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
@@ -204,7 +204,7 @@ static void cdns_spi_chipselect(struct spi_device *spi, bool is_high)
  */
 static void cdns_spi_config_clock_mode(struct spi_device *spi)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(spi->controller);
 	u32 ctrl_reg, new_ctrl_reg;
 
 	new_ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
@@ -247,7 +247,7 @@ static void cdns_spi_config_clock_mode(struct spi_device *spi)
 static void cdns_spi_config_clock_freq(struct spi_device *spi,
 				       struct spi_transfer *transfer)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(spi->controller);
 	u32 ctrl_reg, baud_rate_val;
 	unsigned long frequency;
 
@@ -285,7 +285,7 @@ static void cdns_spi_config_clock_freq(struct spi_device *spi,
 static int cdns_spi_setup_transfer(struct spi_device *spi,
 				   struct spi_transfer *transfer)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(spi->controller);
 
 	cdns_spi_config_clock_freq(spi, transfer);
 
@@ -340,8 +340,8 @@ static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)
  */
 static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = dev_id;
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 	irqreturn_t status;
 	u32 intr_status;
 
@@ -355,7 +355,7 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 		 * transferred is non-zero
 		 */
 		cdns_spi_write(xspi, CDNS_SPI_IDR, CDNS_SPI_IXR_DEFAULT);
-		spi_finalize_current_transfer(master);
+		spi_finalize_current_transfer(ctlr);
 		status = IRQ_HANDLED;
 	} else if (intr_status & CDNS_SPI_IXR_TXOW) {
 		unsigned long trans_cnt;
@@ -381,7 +381,7 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 			/* Transfer is completed */
 			cdns_spi_write(xspi, CDNS_SPI_IDR,
 				       CDNS_SPI_IXR_DEFAULT);
-			spi_finalize_current_transfer(master);
+			spi_finalize_current_transfer(ctlr);
 		}
 		status = IRQ_HANDLED;
 	}
@@ -389,7 +389,7 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 	return status;
 }
 
-static int cdns_prepare_message(struct spi_master *master,
+static int cdns_prepare_message(struct spi_controller *ctlr,
 				struct spi_message *msg)
 {
 	cdns_spi_config_clock_mode(msg->spi);
@@ -398,7 +398,7 @@ static int cdns_prepare_message(struct spi_master *master,
 
 /**
  * cdns_transfer_one - Initiates the SPI transfer
- * @master:	Pointer to spi_master structure
+ * @ctlr:	Pointer to spi_controller structure
  * @spi:	Pointer to the spi_device structure
  * @transfer:	Pointer to the spi_transfer structure which provides
  *		information about next transfer parameters
@@ -408,11 +408,11 @@ static int cdns_prepare_message(struct spi_master *master,
  *
  * Return:	Number of bytes transferred in the last transfer
  */
-static int cdns_transfer_one(struct spi_master *master,
+static int cdns_transfer_one(struct spi_controller *ctlr,
 			     struct spi_device *spi,
 			     struct spi_transfer *transfer)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
 	xspi->txbuf = transfer->tx_buf;
 	xspi->rxbuf = transfer->rx_buf;
@@ -429,16 +429,16 @@ static int cdns_transfer_one(struct spi_master *master,
 
 /**
  * cdns_prepare_transfer_hardware - Prepares hardware for transfer.
- * @master:	Pointer to the spi_master structure which provides
+ * @ctlr:	Pointer to the spi_controller structure which provides
  *		information about the controller.
  *
  * This function enables SPI master controller.
  *
  * Return:	0 always
  */
-static int cdns_prepare_transfer_hardware(struct spi_master *master)
+static int cdns_prepare_transfer_hardware(struct spi_controller *ctlr)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
 	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_ENABLE);
 
@@ -447,16 +447,16 @@ static int cdns_prepare_transfer_hardware(struct spi_master *master)
 
 /**
  * cdns_unprepare_transfer_hardware - Relaxes hardware after transfer
- * @master:	Pointer to the spi_master structure which provides
+ * @ctlr:	Pointer to the spi_controller structure which provides
  *		information about the controller.
  *
  * This function disables the SPI master controller when no slave selected.
  *
  * Return:	0 always
  */
-static int cdns_unprepare_transfer_hardware(struct spi_master *master)
+static int cdns_unprepare_transfer_hardware(struct spi_controller *ctlr)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 	u32 ctrl_reg;
 
 	/* Disable the SPI if slave is deselected */
@@ -497,42 +497,42 @@ static void cdns_spi_detect_fifo_depth(struct cdns_spi *xspi)
 static int cdns_spi_probe(struct platform_device *pdev)
 {
 	int ret = 0, irq;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	struct cdns_spi *xspi;
 	u32 num_cs;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*xspi));
-	if (!master)
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xspi));
+	if (!ctlr)
 		return -ENOMEM;
 
-	xspi = spi_master_get_devdata(master);
-	master->dev.of_node = pdev->dev.of_node;
-	platform_set_drvdata(pdev, master);
+	xspi = spi_controller_get_devdata(ctlr);
+	ctlr->dev.of_node = pdev->dev.of_node;
+	platform_set_drvdata(pdev, ctlr);
 
 	xspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xspi->regs)) {
 		ret = PTR_ERR(xspi->regs);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	xspi->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(xspi->pclk)) {
 		dev_err(&pdev->dev, "pclk clock not found.\n");
 		ret = PTR_ERR(xspi->pclk);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	xspi->ref_clk = devm_clk_get(&pdev->dev, "ref_clk");
 	if (IS_ERR(xspi->ref_clk)) {
 		dev_err(&pdev->dev, "ref_clk clock not found.\n");
 		ret = PTR_ERR(xspi->ref_clk);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	ret = clk_prepare_enable(xspi->pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	ret = clk_prepare_enable(xspi->ref_clk);
@@ -549,9 +549,9 @@ static int cdns_spi_probe(struct platform_device *pdev)
 
 	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
 	if (ret < 0)
-		master->num_chipselect = CDNS_SPI_DEFAULT_NUM_CS;
+		ctlr->num_chipselect = CDNS_SPI_DEFAULT_NUM_CS;
 	else
-		master->num_chipselect = num_cs;
+		ctlr->num_chipselect = num_cs;
 
 	ret = of_property_read_u32(pdev->dev.of_node, "is-decoded-cs",
 				   &xspi->is_decoded_cs);
@@ -570,35 +570,35 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, cdns_spi_irq,
-			       0, pdev->name, master);
+			       0, pdev->name, ctlr);
 	if (ret != 0) {
 		ret = -ENXIO;
 		dev_err(&pdev->dev, "request_irq failed\n");
 		goto clk_dis_all;
 	}
 
-	master->use_gpio_descriptors = true;
-	master->prepare_transfer_hardware = cdns_prepare_transfer_hardware;
-	master->prepare_message = cdns_prepare_message;
-	master->transfer_one = cdns_transfer_one;
-	master->unprepare_transfer_hardware = cdns_unprepare_transfer_hardware;
-	master->set_cs = cdns_spi_chipselect;
-	master->auto_runtime_pm = true;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	ctlr->use_gpio_descriptors = true;
+	ctlr->prepare_transfer_hardware = cdns_prepare_transfer_hardware;
+	ctlr->prepare_message = cdns_prepare_message;
+	ctlr->transfer_one = cdns_transfer_one;
+	ctlr->unprepare_transfer_hardware = cdns_unprepare_transfer_hardware;
+	ctlr->set_cs = cdns_spi_chipselect;
+	ctlr->auto_runtime_pm = true;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
 	xspi->clk_rate = clk_get_rate(xspi->ref_clk);
 	/* Set to default valid value */
-	master->max_speed_hz = xspi->clk_rate / 4;
-	xspi->speed_hz = master->max_speed_hz;
+	ctlr->max_speed_hz = xspi->clk_rate / 4;
+	xspi->speed_hz = ctlr->max_speed_hz;
 
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
-		dev_err(&pdev->dev, "spi_register_master failed\n");
+		dev_err(&pdev->dev, "spi_register_controller failed\n");
 		goto clk_dis_all;
 	}
 
@@ -610,8 +610,8 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(xspi->ref_clk);
 clk_dis_apb:
 	clk_disable_unprepare(xspi->pclk);
-remove_master:
-	spi_master_put(master);
+remove_ctlr:
+	spi_controller_put(ctlr);
 	return ret;
 }
 
@@ -627,8 +627,8 @@ static int cdns_spi_probe(struct platform_device *pdev)
  */
 static int cdns_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
 	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
@@ -637,7 +637,7 @@ static int cdns_spi_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	spi_unregister_master(master);
+	spi_unregister_controller(ctlr);
 
 	return 0;
 }
@@ -653,9 +653,9 @@ static int cdns_spi_remove(struct platform_device *pdev)
  */
 static int __maybe_unused cdns_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
 
-	return spi_master_suspend(master);
+	return spi_controller_suspend(ctlr);
 }
 
 /**
@@ -668,11 +668,11 @@ static int __maybe_unused cdns_spi_suspend(struct device *dev)
  */
 static int __maybe_unused cdns_spi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
 	cdns_spi_init_hw(xspi);
-	return spi_master_resume(master);
+	return spi_controller_resume(ctlr);
 }
 
 /**
@@ -685,8 +685,8 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
  */
 static int __maybe_unused cdns_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 	int ret;
 
 	ret = clk_prepare_enable(xspi->pclk);
@@ -714,8 +714,8 @@ static int __maybe_unused cdns_spi_runtime_resume(struct device *dev)
  */
 static int __maybe_unused cdns_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
 	clk_disable_unprepare(xspi->ref_clk);
 	clk_disable_unprepare(xspi->pclk);
-- 
2.1.1

