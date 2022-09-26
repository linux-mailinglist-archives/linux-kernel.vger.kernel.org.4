Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4295E9997
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiIZGfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiIZGec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:34:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A1732DBA;
        Sun, 25 Sep 2022 23:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dt8ATNqIAYpKbWIt3pP3rRird+KhXiXOWNeApi7ssNmHiDQcgu7xp9BBeZl5nbQGSrWIqw0GOkf1OEfMPUbPfAeNzPzN6kLq9lysv5o2/HzD6N1uut4RxQXbr/hHcu7VzXqiMlB+tMhpjWoYCMfavU3aZIV7GcGGE0eeU6o6DL9aABHly1o4Im1ZKuiGtA0enFHXON3csjauAy6g/o+hfWL7FexBm+zTvSXyi3EtMFrQodiOvv6mTVAK0QhqSlbKJYi7VeM4Pl7ly9IMSkybtwVocdTYsWdkQj90jFsVV/V5Kn83MJ9nRvnSzJmmyZvOFf5SA0eryem20pFuyYreoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGqIpgJBImhJ+mHTOMmzHGzkCtd7M31gAbipbXAqlhc=;
 b=RUCJAcV15rh29pXIHceeq0vNQ411ljdaDUEBzYHJ1Z372RZntYrf7MMVFEX55G2/QMVaPrSD6xlS43rF4kollda4MFsvZdJQamBfEaMfh3KsJ3yFKia6tLdVF3cad2Dba/2f4oLGry+oxaDugJNCqNBaE1m5C6BhxlR8mUAyRl3quZlgDYFSuKVPIS5wfaVKpDahgiXPKKCMpsa5igGrzAuBJZm4jZBqvoFGzrbzkbjbrfQ92R8DBIyigQitNax/sdidVkXFxPtUFLTJd9ZJ2wtsYnw9+UuxzahUbzZifgSs8vrj/qAONlnPvd0fnrWG81/Wmw4294tZ4qu914xWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGqIpgJBImhJ+mHTOMmzHGzkCtd7M31gAbipbXAqlhc=;
 b=Dc/FVzqGUofJPOioDWRw+VlEh40OTKvHF9b0CaCt8zR/ZUR5nwJN9mfcxEEVBuQdDBJ2TcFddH60+oI7868clpEpUNpsEkDpL2pp25ECI/ViP5/vINUsub6IEECcsARBXcGJrbEiDEe1q9E5Xh/HyX7pm+foGV9fy79Og6UdAkk=
Received: from SA1P222CA0036.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::21)
 by BY5PR02MB6770.namprd02.prod.outlook.com (2603:10b6:a03:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 06:34:09 +0000
Received: from SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:2d0:cafe::69) by SA1P222CA0036.outlook.office365.com
 (2603:10b6:806:2d0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Mon, 26 Sep 2022 06:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0037.mail.protection.outlook.com (10.97.4.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 06:34:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 25 Sep 2022 23:33:58 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Sun, 25 Sep 2022 23:33:58 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 akumarma@amd.com,
 git@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 amit.kumar-mahapatra@amd.com,
 michal.simek@amd.com
Received: from [10.140.6.18] (port=46254 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1ochgj-000GAg-IU; Sun, 25 Sep 2022 23:33:57 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <akumarma@amd.com>, <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Michal Simek <michal.simek@amd.com>
Subject: [RESEND PATCH v3 7/7] spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal platform
Date:   Mon, 26 Sep 2022 12:03:27 +0530
Message-ID: <20220926063327.20753-8-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
References: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0037:EE_|BY5PR02MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 17795e37-2364-4632-93cd-08da9f891e58
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BgQ0Z9z5UdTNG/9swnaiVxbzx5v350r30y+nofjZMr6RVt3J5lC8mhRLcp8ZCgtjB4/MKkbuRK8jhN6QiAq5me7CCVy4CsyhbA3rfpe4RO1avsvDzQA4Iwcd8jG706Chw6MmEuVrQbDiAbfTQ6WVWiJlzatJVLcYaXFOI4NkCoWmdBFRDAgSnTo1T4JHpW44wD/v6v5InllP7G4B5fWnQl37haDxTo62b/w2rS3Q5UbqTSbnmrfKpf8K7tD3sYhdv33cIZDDCkLURz+lMgYfMMeBbSi8t4yvD3B/9r2PQmZio6nx4emP224pXeJ5XbCTwRIAh6WZyKZP+a3qbic2VBEeAHmDFx3Vk+Z+tdhEmPbxf0F7KLUdvAcGuP3qCYe98KDD1YW1Oqi3qsiKZ3xM9b4mtzTyV/9M1fGknjuIcWYFtVFeed0tjZiNsyuze7eFm5RTsgYccvOziuLOKEjP98b+6yfwKmRAoeh3/dP1WWDX3ybzbWW0/Ta0zuu9YbU4vtWpxenvx0omZJHrkxOIoh9Rrd7XlzwELWVgARP4e/UwKEQjDZViwi4lh/7s1FBO7peC5RXXCdAfjfSUZ7MeCzdULOmrN8Rn/46YD44ggoNREXbRlNTpCgMaAoDbSdkr5iROkSkL95OQsLbTjPSMUUeKd+SMxgbraWfyAJAjPiUMDYTRYIfiDFoZo2MgxwX7EiEoPZKJ3/UGcx4BArG52B49X2xHevcna0KXXpL7cGBHNOFbk2ucpRkDOKwomYCbPDoxAUTCQzvnQTszW10WmIHEWCd6WRkqUgP9udogBeI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(110136005)(54906003)(7636003)(356005)(7416002)(5660300002)(36860700001)(82740400003)(2616005)(47076005)(83380400001)(336012)(186003)(426003)(1076003)(6666004)(26005)(41300700001)(478600001)(4326008)(70206006)(70586007)(316002)(7696005)(8676002)(40480700001)(8936002)(2906002)(9786002)(40460700003)(82310400005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 06:34:09.3866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17795e37-2364-4632-93cd-08da9f891e58
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6770
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tap delay support for GQSPI controller on Versal platform.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 86 ++++++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index c11736d96f33..95ff15665d44 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
@@ -34,6 +35,7 @@
 #define GQSPI_RXD_OFST			0x00000120
 #define GQSPI_TX_THRESHOLD_OFST		0x00000128
 #define GQSPI_RX_THRESHOLD_OFST		0x0000012C
+#define IOU_TAPDLY_BYPASS_OFST		0x0000003C
 #define GQSPI_LPBK_DLY_ADJ_OFST		0x00000138
 #define GQSPI_GEN_FIFO_OFST		0x00000140
 #define GQSPI_SEL_OFST			0x00000144
@@ -141,6 +143,13 @@
 #define GQSPI_USE_DATA_DLY_SHIFT	31
 #define GQSPI_DATA_DLY_ADJ_VALUE	0x2
 #define GQSPI_DATA_DLY_ADJ_SHIFT	28
+#define GQSPI_LPBK_DLY_ADJ_DLY_1	0x1
+#define GQSPI_LPBK_DLY_ADJ_DLY_1_SHIFT	0x3
+#define TAP_DLY_BYPASS_LQSPI_RX_VALUE	0x1
+#define TAP_DLY_BYPASS_LQSPI_RX_SHIFT	0x2
+
+/* set to differentiate versal from zynqmp, 1=versal, 0=zynqmp */
+#define QSPI_QUIRK_HAS_TAPDELAY		BIT(0)
 
 #define GQSPI_FREQ_37_5MHZ	37500000
 #define GQSPI_FREQ_40MHZ	40000000
@@ -150,6 +159,14 @@
 #define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
+/**
+ * struct qspi_platform_data - zynqmp qspi platform data structure
+ * @quirks:    Flags is used to identify the platform
+ */
+struct qspi_platform_data {
+	u32 quirks;
+};
+
 /**
  * struct zynqmp_qspi - Defines qspi driver instance
  * @ctlr:		Pointer to the spi controller information
@@ -171,6 +188,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @data_completion:	completion structure
  * @op_lock:		Operational lock
  * @speed_hz:          Current SPI bus clock speed in hz
+ * @has_tapdelay:	Used for tapdelay register available in qspi
  */
 struct zynqmp_qspi {
 	struct spi_controller *ctlr;
@@ -192,6 +210,7 @@ struct zynqmp_qspi {
 	struct completion data_completion;
 	struct mutex op_lock;
 	u32 speed_hz;
+	bool has_tapdelay;
 };
 
 /**
@@ -271,25 +290,44 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
  */
 static void zynqmp_qspi_set_tapdelay(struct zynqmp_qspi *xqspi, u32 baudrateval)
 {
-	u32 lpbkdlyadj = 0, datadlyadj = 0, clk_rate;
+	u32 tapdlybypass = 0, lpbkdlyadj = 0, datadlyadj = 0, clk_rate;
 	u32 reqhz = 0;
 
 	clk_rate = clk_get_rate(xqspi->refclk);
 	reqhz = (clk_rate / (GQSPI_BAUD_DIV_SHIFT << baudrateval));
 
-	if (reqhz <= GQSPI_FREQ_40MHZ) {
-		zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
-					      PM_TAPDELAY_BYPASS_ENABLE);
-	} else if (reqhz <= GQSPI_FREQ_100MHZ) {
-		zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
-					      PM_TAPDELAY_BYPASS_ENABLE);
-		lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
-		datadlyadj |= ((GQSPI_USE_DATA_DLY <<
-				GQSPI_USE_DATA_DLY_SHIFT) |
-			       (GQSPI_DATA_DLY_ADJ_VALUE <<
-				GQSPI_DATA_DLY_ADJ_SHIFT));
-	} else if (reqhz <= GQSPI_FREQ_150MHZ) {
-		lpbkdlyadj |= GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK;
+	if (!xqspi->has_tapdelay) {
+		if (reqhz <= GQSPI_FREQ_40MHZ) {
+			zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
+						      PM_TAPDELAY_BYPASS_ENABLE);
+		} else if (reqhz <= GQSPI_FREQ_100MHZ) {
+			zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
+						      PM_TAPDELAY_BYPASS_ENABLE);
+			lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
+			datadlyadj |= ((GQSPI_USE_DATA_DLY <<
+					GQSPI_USE_DATA_DLY_SHIFT)
+					| (GQSPI_DATA_DLY_ADJ_VALUE <<
+						GQSPI_DATA_DLY_ADJ_SHIFT));
+		} else if (reqhz <= GQSPI_FREQ_150MHZ) {
+			lpbkdlyadj |= GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK;
+		}
+	} else {
+		if (reqhz <= GQSPI_FREQ_37_5MHZ) {
+			tapdlybypass |= (TAP_DLY_BYPASS_LQSPI_RX_VALUE <<
+					TAP_DLY_BYPASS_LQSPI_RX_SHIFT);
+		} else if (reqhz <= GQSPI_FREQ_100MHZ) {
+			tapdlybypass |= (TAP_DLY_BYPASS_LQSPI_RX_VALUE <<
+					TAP_DLY_BYPASS_LQSPI_RX_SHIFT);
+			lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
+			datadlyadj |= (GQSPI_USE_DATA_DLY <<
+					GQSPI_USE_DATA_DLY_SHIFT);
+		} else if (reqhz <= GQSPI_FREQ_150MHZ) {
+			lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK
+				       | (GQSPI_LPBK_DLY_ADJ_DLY_1 <<
+					       GQSPI_LPBK_DLY_ADJ_DLY_1_SHIFT));
+		}
+		zynqmp_gqspi_write(xqspi,
+				   IOU_TAPDLY_BYPASS_OFST, tapdlybypass);
 	}
 	zynqmp_gqspi_write(xqspi, GQSPI_LPBK_DLY_ADJ_OFST, lpbkdlyadj);
 	zynqmp_gqspi_write(xqspi, GQSPI_DATA_DLY_ADJ_OFST, datadlyadj);
@@ -1156,6 +1194,16 @@ static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(zynqmp_qspi_suspend, zynqmp_qspi_resume)
 };
 
+static const struct qspi_platform_data versal_qspi_def = {
+	.quirks = QSPI_QUIRK_HAS_TAPDELAY,
+};
+
+static const struct of_device_id zynqmp_qspi_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-qspi-1.0"},
+	{ .compatible = "xlnx,versal-qspi-1.0", .data = &versal_qspi_def },
+	{ /* End of table */ }
+};
+
 static const struct spi_controller_mem_ops zynqmp_qspi_mem_ops = {
 	.exec_op = zynqmp_qspi_exec_op,
 };
@@ -1176,6 +1224,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	u32 num_cs;
+	const struct qspi_platform_data *p_data;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
 	if (!ctlr)
@@ -1186,6 +1235,10 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	xqspi->ctlr = ctlr;
 	platform_set_drvdata(pdev, xqspi);
 
+	p_data = of_device_get_match_data(&pdev->dev);
+	if (p_data && (p_data->quirks & QSPI_QUIRK_HAS_TAPDELAY))
+		xqspi->has_tapdelay = true;
+
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xqspi->regs)) {
 		ret = PTR_ERR(xqspi->regs);
@@ -1324,11 +1377,6 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id zynqmp_qspi_of_match[] = {
-	{ .compatible = "xlnx,zynqmp-qspi-1.0", },
-	{ /* End of table */ }
-};
-
 MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
 
 static struct platform_driver zynqmp_qspi_driver = {
-- 
2.17.1

