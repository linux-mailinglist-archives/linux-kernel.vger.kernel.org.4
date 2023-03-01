Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675C76A725B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCARxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCARwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:52:54 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29B24A1EE;
        Wed,  1 Mar 2023 09:52:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5imRQGI9OomAIqhOr2MyzUFunJs/gkp/2R1SqBOILw/ToiqQLRzeRxkApsc8ejx+ao1ITw0Dpb87CsCz4MnGHMDBxz/gdNIhakMqKLlVEUL0HJjqoLjX1KjvmPEwUAUMwCq5jIIvsz/dbfSD7YzOuqiIiYpiauFyDv4YOzXSgpc6xuDyqgFxh0iPMoNKcuwBvuvFc1dLZg9UGRzNEJRNmj8uJkWH94oRMwo4qpdSootb682AQpmvdmbL8Cq9fZrLFWy6YbQPVAS1lGk2OUsS5xFHztKOb3o1gSK+xvypLQ2Gu5jEnOL9fHc/TWZjCXT9HdkOaBJv6cXbMG4q3lAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4jPSm1u8x81huOojOh6hhCqQ3nFVlKvgZHpLyzZ3ik=;
 b=WKTpEXOPmejKg4l4YU4kY0iq/FfGS/Qiay3MT/KSrqrT5LWcnDRFnH0mkFPtxhsrJ4WLp0uTmOlIN+/STnvNp+TCN9fEfbCH9cZGSd2LodGxf+NclS71CKQyYoKQpP5iXC7TjlF8FVgl/y2KlFp5TzvPOaudfT8qw4GiAeMpF64Yc7QAsGXRNGM7bh/LG/nUVMgAgShWNSn0Hz6MGYtiXuYMnTRPJxvy/50V1fPsh6yDncEvehZPKDu5x6rFGrk9eDs4sUoC+pASf7xfjzqDDGOkjP/8vWI/2Kq16rZ2EOMhEvhgdXTEqpIBzdzPmrURIbtzG2a1OaxIJ0XdfXNVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4jPSm1u8x81huOojOh6hhCqQ3nFVlKvgZHpLyzZ3ik=;
 b=OJHoRu3D4dHlHefpBrWmj7OZTF15U5Gzr/UjhCP2D74TMTOQVCcsR4iZKAQ/0HT/9MRxqmK6xvvYQhUTKJOaF9UjxA+ALPDqdWBK6Y1aT/l1Rmlh8X1UsNQXypSjzn8podxXRMOueGC/sTYJrgKlo7EadKXbSAzwNk8GRK7cju8=
Received: from BN0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:e8::33)
 by CH2PR12MB5020.namprd12.prod.outlook.com (2603:10b6:610:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 17:52:45 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::24) by BN0PR04CA0058.outlook.office365.com
 (2603:10b6:408:e8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 17:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 17:52:45 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 11:52:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 09:52:44 -0800
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 1 Mar 2023 11:52:41 -0600
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@amd.com>,
        <neelisrinivas18@gmail.com>
CC:     <wim@linux-watchdog.org>, <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>, <git@amd.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 3/4] watchdog: xilinx_wwdt: Add Versal window watchdog support
Date:   Wed, 1 Mar 2023 23:22:28 +0530
Message-ID: <20230301175229.342004-4-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301175229.342004-1-srinivas.neeli@amd.com>
References: <20230301175229.342004-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT017:EE_|CH2PR12MB5020:EE_
X-MS-Office365-Filtering-Correlation-Id: e369f991-6840-41f8-fd26-08db1a7dc335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMEr7RaX9nhzQMcibJ21kuJj8WzEFeXQxeFpl5jEgyxUVtyaM+DwayLxp+66TwMEvvfdQ114NshSZh2H9m0SCzY80KcALtd3zBiox8C1lfbmB6YZMwAE2xnaLcuW+oumYj4gRuaATtevSWwAriRh0BnIXgf2ypRUT8tPFCmRS+b0xaWVPD5w2odvj8Y2e4vOG0jMYMZxjyvuNvjjDBk+GfhKr+A13iEJo6Y81o1qi9H3aCH6nS4RaGpnbVrfJxK+I4TpspE28WBMA4YcsXOq95TiHTSEUmaY6NtJSyoxl7IXl41DnGLRInWXJzpi2nfBLct8yFhEdRazQ2r0rzDbIGA0kpdKX9RiiPU7gx8nOwMWkNJIO1a8t0zIBQ/1SMd5dwH70MY13L+ury3SnaNEU4h2so5SmoeaWQbMQpziHp7hh2PtAH2Af5ji3lIIgDpEHX+/RjR0+sz6gqrlme1v+Yb5yHzINUVEfLDU5s0UmSoxDJgpbYEo1bgzieT+wUX3+lh6HV4nUNefGl8X5nqDmSKqu5TtJGIwDoCcraYWuIDtlrPme48Tztg/B4FJryOc9oH/Ehy+/XvkBsi5DIJOTKkldF6s7sEeskp3cJpcMfLiTjCgYBzsycckKam0+qmGO0AYQCfBkczGOA3hCjpYKDVp1M6WDKLWgsFG0k6k3JB+HSM6KFc/0pU/Qg5phbKeit9Oa5viFwu1icRrFbUCxZmv3gimdc3JjwKVnLLV/U4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(36756003)(86362001)(5660300002)(40480700001)(8676002)(7416002)(70206006)(8936002)(4326008)(41300700001)(44832011)(2906002)(356005)(82740400003)(36860700001)(81166007)(6666004)(316002)(478600001)(54906003)(70586007)(82310400005)(110136005)(83380400001)(26005)(47076005)(426003)(186003)(40460700003)(336012)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:52:45.0917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e369f991-6840-41f8-fd26-08db1a7dc335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5020
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Versal watchdog driver uses window watchdog mode. Window watchdog
timer(WWDT) contains closed(first) and open(second) window with
32 bit width. Write to the watchdog timer within predefined window
periods of time. This means a period that is not too soon and a
period that is not too late. The WWDT has to be restarted within
the open window time. If software tries to restart WWDT outside of
the open window time period, it generates a reset.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V2:                                                                  
- Takes "xlnx,close-percent" property from device tree parameter.
- Removed clk_disable() function.
- Removed module parameter permisions and using readomly.
- Added check for close_percent( 0 < close_perecent < 100).
- Updated other minor comments.
---
 drivers/watchdog/Kconfig       |  18 +++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/xilinx_wwdt.c | 232 +++++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 drivers/watchdog/xilinx_wwdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f0872970daf9..ec4b522ae29e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -304,6 +304,24 @@ config XILINX_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called of_xilinx_wdt.
 
+config XILINX_WINDOW_WATCHDOG
+	tristate "Xilinx window watchdog timer"
+	depends on HAS_IOMEM
+	depends on ARM64
+	select WATCHDOG_CORE
+	help
+	  Window watchdog driver for the versal_wwdt IP core.
+	  Window watchdog timer(WWDT) contains closed(first) and
+	  open(second) window with 32 bit width. Write to the watchdog
+	  timer within predefined window periods of time. This means
+	  a period that is not too soon and a period that is not too
+	  late. The WWDT has to be restarted within the open window time.
+	  If software tries to restart WWDT outside of the open window
+	  time period, it generates a reset.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called xilinx_wwdt.
+
 config ZIIRAVE_WATCHDOG
 	tristate "Zodiac RAVE Watchdog Timer"
 	depends on I2C
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9cbf6580f16c..6cb5f1dfb492 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -157,6 +157,7 @@ obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
 
 # MicroBlaze Architecture
 obj-$(CONFIG_XILINX_WATCHDOG) += of_xilinx_wdt.o
+obj-$(CONFIG_XILINX_WINDOW_WATCHDOG) += xilinx_wwdt.o
 
 # MIPS Architecture
 obj-$(CONFIG_ATH79_WDT) += ath79_wdt.o
diff --git a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
new file mode 100644
index 000000000000..5b50376d1474
--- /dev/null
+++ b/drivers/watchdog/xilinx_wwdt.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Window watchdog device driver for Xilinx Versal WWDT
+ *
+ * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/watchdog.h>
+
+#define XWWDT_DEFAULT_TIMEOUT	40
+#define XWWDT_MIN_TIMEOUT	1
+
+/* Register offsets for the WWDT device */
+#define XWWDT_MWR_OFFSET	0x00
+#define XWWDT_ESR_OFFSET	0x04
+#define XWWDT_FCR_OFFSET	0x08
+#define XWWDT_FWR_OFFSET	0x0c
+#define XWWDT_SWR_OFFSET	0x10
+
+/* Master Write Control Register Masks */
+#define XWWDT_MWR_MASK		BIT(0)
+
+/* Enable and Status Register Masks */
+#define XWWDT_ESR_WINT_MASK	BIT(16)
+#define XWWDT_ESR_WSW_MASK	BIT(8)
+#define XWWDT_ESR_WEN_MASK	BIT(0)
+
+#define XWWDT_CLOSE_WINDOW_PERCENT		50
+
+static int xwwdt_timeout;
+
+module_param(xwwdt_timeout, int, 0);
+MODULE_PARM_DESC(xwwdt_timeout,
+		 "Watchdog time in seconds. (default="
+		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT) ")");
+
+/**
+ * struct xwwdt_device - Watchdog device structure
+ * @base: base io address of WDT device
+ * @spinlock: spinlock for IO register access
+ * @xilinx_wwdt_wdd: watchdog device structure
+ * @clk: struct clk * of a clock source
+ * @freq: source clock frequency of WWDT
+ * @close_percent : Closed window percent
+ */
+struct xwwdt_device {
+	void __iomem *base;
+	spinlock_t spinlock; /* spinlock for register handling */
+	struct watchdog_device xilinx_wwdt_wdd;
+	struct clk *clk;
+	unsigned long	freq;
+	u32 close_percent;
+};
+
+static int xilinx_wwdt_start(struct watchdog_device *wdd)
+{
+	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
+	struct watchdog_device *xilinx_wwdt_wdd = &xdev->xilinx_wwdt_wdd;
+	u64 time_out, closed_timeout, open_timeout;
+	u32 control_status_reg;
+
+	/* Calculate timeout count */
+	time_out = xdev->freq * wdd->timeout;
+
+	if (xdev->close_percent && xdev->close_percent < 100) {
+		closed_timeout = (time_out * xdev->close_percent) / 100;
+		open_timeout = time_out - closed_timeout;
+		wdd->min_hw_heartbeat_ms = xdev->close_percent * 10 * wdd->timeout;
+	} else {
+		/* Calculate XWWDT_CLOSE_WINDOW_PERCENT of timeout */
+		time_out *= XWWDT_CLOSE_WINDOW_PERCENT;
+		time_out /= 100;
+		wdd->min_hw_heartbeat_ms = XWWDT_CLOSE_WINDOW_PERCENT * 10 * wdd->timeout;
+	}
+
+	spin_lock(&xdev->spinlock);
+
+	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
+	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base + XWWDT_ESR_OFFSET);
+
+	if (xdev->close_percent && xdev->close_percent < 100) {
+		iowrite32((u32)closed_timeout, xdev->base + XWWDT_FWR_OFFSET);
+		iowrite32((u32)open_timeout, xdev->base + XWWDT_SWR_OFFSET);
+	} else {
+		/* Configure closed and open windows with XWWDT_CLOSE_WINDOW_PERCENT of timeout */
+		iowrite32((u32)time_out, xdev->base + XWWDT_FWR_OFFSET);
+		iowrite32((u32)time_out, xdev->base + XWWDT_SWR_OFFSET);
+	}
+
+	/* Enable the window watchdog timer */
+	control_status_reg = ioread32(xdev->base + XWWDT_ESR_OFFSET);
+	control_status_reg |= XWWDT_ESR_WEN_MASK;
+	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);
+
+	spin_unlock(&xdev->spinlock);
+
+	dev_dbg(xilinx_wwdt_wdd->parent, "Watchdog Started!\n");
+
+	return 0;
+}
+
+static int xilinx_wwdt_keepalive(struct watchdog_device *wdd)
+{
+	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
+	u32 control_status_reg;
+
+	spin_lock(&xdev->spinlock);
+
+	/* Enable write access control bit for the window watchdog */
+	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
+
+	/* Trigger restart kick to watchdog */
+	control_status_reg = ioread32(xdev->base + XWWDT_ESR_OFFSET);
+	control_status_reg |= XWWDT_ESR_WSW_MASK;
+	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);
+
+	spin_unlock(&xdev->spinlock);
+
+	return 0;
+}
+
+static void xwwdt_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static const struct watchdog_info xilinx_wwdt_ident = {
+	.options = WDIOF_KEEPALIVEPING |
+		WDIOF_SETTIMEOUT,
+	.firmware_version = 1,
+	.identity = "xlnx_window watchdog",
+};
+
+static const struct watchdog_ops xilinx_wwdt_ops = {
+	.owner = THIS_MODULE,
+	.start = xilinx_wwdt_start,
+	.ping = xilinx_wwdt_keepalive,
+};
+
+static int xwwdt_probe(struct platform_device *pdev)
+{
+	struct watchdog_device *xilinx_wwdt_wdd;
+	struct device *dev = &pdev->dev;
+	struct xwwdt_device *xdev;
+	int ret;
+
+	xdev = devm_kzalloc(dev, sizeof(*xdev), GFP_KERNEL);
+	if (!xdev)
+		return -ENOMEM;
+
+	xilinx_wwdt_wdd = &xdev->xilinx_wwdt_wdd;
+	xilinx_wwdt_wdd->info = &xilinx_wwdt_ident;
+	xilinx_wwdt_wdd->ops = &xilinx_wwdt_ops;
+	xilinx_wwdt_wdd->parent = dev;
+
+	xdev->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(xdev->base))
+		return PTR_ERR(xdev->base);
+
+	xdev->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(xdev->clk))
+		return PTR_ERR(xdev->clk);
+
+	xdev->freq = clk_get_rate(xdev->clk);
+	if (!xdev->freq)
+		return -EINVAL;
+
+	ret = clk_prepare_enable(xdev->clk);
+	if (ret) {
+		dev_err(dev, "unable to enable clock\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, xwwdt_clk_disable_unprepare,
+				       xdev->clk);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(dev->of_node, "xlnx,close-percent",
+				   &xdev->close_percent);
+	if (ret)
+		xdev->close_percent = XWWDT_CLOSE_WINDOW_PERCENT;
+
+	xilinx_wwdt_wdd->timeout = XWWDT_DEFAULT_TIMEOUT;
+	xilinx_wwdt_wdd->min_timeout = XWWDT_MIN_TIMEOUT;
+	xilinx_wwdt_wdd->max_hw_heartbeat_ms = 1000 * xilinx_wwdt_wdd->timeout;
+
+	ret = watchdog_init_timeout(xilinx_wwdt_wdd,
+				    xwwdt_timeout, &pdev->dev);
+	if (ret)
+		dev_info(&pdev->dev, "Configured default timeout value\n");
+
+	spin_lock_init(&xdev->spinlock);
+	watchdog_set_drvdata(xilinx_wwdt_wdd, xdev);
+	watchdog_set_nowayout(xilinx_wwdt_wdd, WATCHDOG_NOWAYOUT);
+
+	ret = devm_watchdog_register_device(dev, xilinx_wwdt_wdd);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "Xilinx window watchdog Timer with timeout %ds\n",
+		 xilinx_wwdt_wdd->timeout);
+
+	return 0;
+}
+
+static const struct of_device_id xwwdt_of_match[] = {
+	{ .compatible = "xlnx,versal-wwdt", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xwwdt_of_match);
+
+static struct platform_driver xwwdt_driver = {
+	.probe = xwwdt_probe,
+	.driver = {
+		.name = "Xilinx window watchdog",
+		.of_match_table = xwwdt_of_match,
+	},
+};
+
+module_platform_driver(xwwdt_driver);
+
+MODULE_AUTHOR("Neeli Srinivas <srinivas.neeli@amd.com>");
+MODULE_DESCRIPTION("Xilinx window watchdog driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

