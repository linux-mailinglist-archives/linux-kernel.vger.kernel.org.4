Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8E7030EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbjEOPFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242001AbjEOPEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:04:37 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9788E76;
        Mon, 15 May 2023 08:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mml96KT71wZMjGpGmIegf5ZBPrZ5j0EGN1T+VcqWnBVdlUuI7rYmgc+aWgUWMdzPwtDBLxFiXcCprU2NO8e6eWhpTwVbRtqg07UH/SLb40JeMUMbNr+WgfpLeJnvzCYrtaX6Eplh3rAgmzzsAFadFbwBd6cpalWKM4QqtvyjPKBN8mNz7bRGTkLXcyoKHKIGskxptvTVOEOpQJCgqn+AB+OQyeIh+9h7OxgwOvnHetg/rhrWW7FqvgJJn7RotDfLIbWMHXhE+sa5K6to5oGKTcchIw4QjNrxx/pseRmy/v9C/5SMo66nxtJVGNWWZLTxmtTu6KJLIEMAWT/QLfH+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xIqJD5NYJtkuvAk/N5YH9NIKhd5a3HYxmBx/SnpRGE=;
 b=lxpf8RymH+LZQJcvXIL30ywCUFjYtn7gfAIT9M3JcQTM/509NsIR8MwJWvL6aWeuEZ/4oU5HoA0yQi9FNzWP/DyXKtQJprPsURGXOLTdh/+h6FAe60JRSy7htPC2oqWTX5U7578t2d3Aj+cmc9HjoQHl3pWVc0SGc8bfyeY0XWLUh+pV+5rSx7zMPXwYVmgquxzS8WJh2CXMjWQn/01tmPSR5Wnxnce9RpOPlgCUba4OoO4xLaUjzvaSz+dK6UIqjb9/fNlCaSoUIyUESijNxNx+q7awLh2Zyz3NjLyNLwqSTt04Ig1A/4Uil7SFU9tbB++DnWLBi4YUPBRR5fcmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xIqJD5NYJtkuvAk/N5YH9NIKhd5a3HYxmBx/SnpRGE=;
 b=Hkr2RJqbONePoJ0VMhrAMuNiQaBak6FxUc72DIrvfSVao8oX3a2eUqoeN9FL2CWsV4mQM+67fhQ9izT2UxfDvjVdWtyU1jL45nlw4Ilh8/As9QA/Y7ifgFbQiFR+Zvhqmv9ug+JCWUVzcnwRxjijnv/DmvCnsVjnTsj6vdfXomcH0cEvXMesihtBTgqCxkv2o594baGiMrh/itf0+Dnzn0qcz1bzNhJxNZDtKCTImpDYN7Mxou7KEgdwCm2pUCGgwQt/HBRa9js2huZz3Ul4UJhaXNSCGGDi9OO4pb6Yx4TeK81pZrPJR+dYrb+nESm1jTLADwlna9DU3efqUOKX/w==
Received: from AM5PR0601CA0027.eurprd06.prod.outlook.com
 (2603:10a6:203:68::13) by GV2PR10MB7607.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 15:04:13 +0000
Received: from VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:68:cafe::42) by AM5PR0601CA0027.outlook.office365.com
 (2603:10a6:203:68::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 15:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT059.mail.protection.outlook.com (10.152.3.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 15:04:13 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 15 May 2023 17:04:13 +0200
Received: from localhost.localdomain (167.87.0.30) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 15 May 2023 17:04:12 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v3 2/3] leds: simatic-ipc-leds-gpio: split up into multiple drivers
Date:   Mon, 15 May 2023 17:03:51 +0200
Message-ID: <20230515150352.30925-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230515150352.30925-1-henning.schild@siemens.com>
References: <20230515150352.30925-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [167.87.0.30]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT059:EE_|GV2PR10MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a01cd7-fd8b-477d-8720-08db5555a53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpMZBsM+yvxPR1LDzNPdntZC4ee3cWEl1t4DAZT5f/8bOEsvH7fI7iOqqobukrYdrCYH8XMSWZtfCH1kWDkiujK6OIwOSk0SW/JlmqzPaA/z4QJ1ERdmby+QnCxpOQivcS6b88NLSXmfs2iosf1ZSw+PmsVx1DhsT1SUTiDtnkq3SOpLLeECR90wF3xPMqaUfKxhxHSw/RI+C0CetSrdg8k6XBLL5yn28XUIeVUxeYVEdLkpRhOQh3CzY0dHePTmcS9u9jWqUumsyn60uEr+52ApsJ1XyBRrJX95GKHRayMX8yyIexXO7ywg3R7NiU/JZCNJJXK/zUa0C1qS/p2LHeLLLGx4sLbfjr5JRtrGkQaZOp+m5855RZDHIS0zMyPt9K3dwet+O4DjTIXq+ZTiTlQZ043LpDlfzn2hlBA+rijPi0LbI57dAbq69OF2yBPNU+tXc4aPGVDIaeRQPR9ckNnGcsocUD8witI10YgDUWmljjckF1Ytge2Tq/rBhRj46CBjDTZsA9njOFI9aS+klV3s2AL4DbkL/3p9NL6XMdkGSI5esidA/sj5/k+uQZIN9qwERZpaCchVK92WvuLFaDqUvJTOinKEuLrV88fL5QDE/1GIDY7LpVhWAK4jxRtOHy6m3kZy4irE5JVz4kYMX8U0tl7rcXLVhSnMOaJzsM3v8qHi10/k/spa3jWxoNnrrHmNXUP0jrRSYD/+xZ1K9XGdfBFV1zW/UO/Tg+Dh9QU21CMjxcdld/gl0pXjPINgZuTY9DfhSAUnG5XNbS01LQ==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(36756003)(86362001)(110136005)(316002)(4326008)(70206006)(70586007)(478600001)(81166007)(82310400005)(40480700001)(5660300002)(8676002)(8936002)(6666004)(30864003)(2906002)(44832011)(356005)(82960400001)(82740400003)(41300700001)(16526019)(2616005)(956004)(1076003)(186003)(107886003)(26005)(36860700001)(83380400001)(336012)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:04:13.5220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a01cd7-fd8b-477d-8720-08db5555a53c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7607
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to clearly describe the dependencies between the GPIO
controller drivers and the users the driver is split up into a core,
two drivers and a common header.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/Makefile                  |   4 +-
 .../simple/simatic-ipc-leds-gpio-apollolake.c |  64 +++++++
 .../leds/simple/simatic-ipc-leds-gpio-core.c  | 104 ++++++++++++
 .../simple/simatic-ipc-leds-gpio-f7188x.c     |  64 +++++++
 drivers/leds/simple/simatic-ipc-leds-gpio.c   | 159 ------------------
 drivers/leds/simple/simatic-ipc-leds-gpio.h   |  22 +++
 drivers/leds/simple/simatic-ipc-leds.c        |   1 -
 drivers/platform/x86/simatic-ipc.c            |   7 +-
 8 files changed, 261 insertions(+), 164 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-core.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
 delete mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.h

diff --git a/drivers/leds/simple/Makefile b/drivers/leds/simple/Makefile
index 1c7ef5e1324b..ed9057f7b6da 100644
--- a/drivers/leds/simple/Makefile
+++ b/drivers/leds/simple/Makefile
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)  += simatic-ipc-leds-gpio-core.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-apollolake.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-f7188x.o
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c b/drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
new file mode 100644
index 000000000000..1206190e709f
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+
+#include "simatic-ipc-leds-gpio.h"
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
+	.dev_id = NULL, /* Filled during initialization */
+	.table = {
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
+	},
+};
+
+static int simatic_ipc_leds_gpio_apollolake_probe(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_probe(pdev, &simatic_ipc_led_gpio_table,
+					   &simatic_ipc_led_gpio_table_extra);
+}
+
+static int simatic_ipc_leds_gpio_apollolake_remove(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
+					    &simatic_ipc_led_gpio_table_extra);
+}
+
+static struct platform_driver simatic_ipc_led_gpio_apollolake_driver = {
+	.probe = simatic_ipc_leds_gpio_apollolake_probe,
+	.remove = simatic_ipc_leds_gpio_apollolake_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+module_platform_driver(simatic_ipc_led_gpio_apollolake_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: simatic-ipc-leds-gpio-core platform:apollolake-pinctrl");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
new file mode 100644
index 000000000000..2a21b663df87
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+
+#include "simatic-ipc-leds-gpio.h"
+
+static struct platform_device *simatic_leds_pdev;
+
+static const struct gpio_led simatic_ipc_gpio_leds[] = {
+	{ .name = "red:" LED_FUNCTION_STATUS "-1" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-1" },
+	{ .name = "red:" LED_FUNCTION_STATUS "-2" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-2" },
+	{ .name = "red:" LED_FUNCTION_STATUS "-3" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
+};
+
+static const struct gpio_led_platform_data simatic_ipc_gpio_leds_pdata = {
+	.num_leds	= ARRAY_SIZE(simatic_ipc_gpio_leds),
+	.leds		= simatic_ipc_gpio_leds,
+};
+
+int simatic_ipc_leds_gpio_remove(struct platform_device *pdev,
+				 struct gpiod_lookup_table *table,
+				 struct gpiod_lookup_table *table_extra)
+{
+	gpiod_remove_lookup_table(table);
+	gpiod_remove_lookup_table(table_extra);
+	platform_device_unregister(simatic_leds_pdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(simatic_ipc_leds_gpio_remove);
+
+int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
+				struct gpiod_lookup_table *table,
+				struct gpiod_lookup_table *table_extra)
+{
+	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	struct gpio_desc *gpiod;
+	int err;
+
+	switch (plat->devmode) {
+	case SIMATIC_IPC_DEVICE_127E:
+	case SIMATIC_IPC_DEVICE_227G:
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	gpiod_add_lookup_table(table);
+	simatic_leds_pdev = platform_device_register_resndata(NULL,
+		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
+		&simatic_ipc_gpio_leds_pdata,
+		sizeof(simatic_ipc_gpio_leds_pdata));
+	if (IS_ERR(simatic_leds_pdev)) {
+		err = PTR_ERR(simatic_leds_pdev);
+		goto out;
+	}
+
+	table_extra->dev_id = dev_name(dev);
+	gpiod_add_lookup_table(table_extra);
+
+	/* PM_BIOS_BOOT_N */
+	gpiod = gpiod_get_index(dev, NULL, 6, GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		err = PTR_ERR(gpiod);
+		goto out;
+	}
+	gpiod_put(gpiod);
+
+	/* PM_WDT_OUT */
+	gpiod = gpiod_get_index(dev, NULL, 7, GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		err = PTR_ERR(gpiod);
+		goto out;
+	}
+	gpiod_put(gpiod);
+
+	return 0;
+out:
+	simatic_ipc_leds_gpio_remove(pdev, table, table_extra);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(simatic_ipc_leds_gpio_probe);
+
+MODULE_LICENSE("GPL v2");
+MODULE_SOFTDEP("pre: platform:leds-gpio");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
new file mode 100644
index 000000000000..0f55b2dad5cd
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+
+#include "simatic-ipc-leds-gpio.h"
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 1, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 2, NULL, 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
+	.dev_id = NULL, /* Filled during initialization */
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
+	},
+};
+
+static int simatic_ipc_leds_gpio_f7188x_probe(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_probe(pdev, &simatic_ipc_led_gpio_table,
+					   &simatic_ipc_led_gpio_table_extra);
+}
+
+static int simatic_ipc_leds_gpio_f7188x_remove(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
+					    &simatic_ipc_led_gpio_table_extra);
+}
+
+static struct platform_driver simatic_ipc_led_gpio_driver = {
+	.probe = simatic_ipc_leds_gpio_f7188x_probe,
+	.remove = simatic_ipc_leds_gpio_f7188x_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+module_platform_driver(simatic_ipc_led_gpio_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: simatic-ipc-leds-gpio-core gpio_f7188x");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
deleted file mode 100644
index 87efdfbb3fcd..000000000000
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ /dev/null
@@ -1,159 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Siemens SIMATIC IPC driver for GPIO based LEDs
- *
- * Copyright (c) Siemens AG, 2022
- *
- * Authors:
- *  Henning Schild <henning.schild@siemens.com>
- */
-
-#include <linux/gpio/machine.h>
-#include <linux/gpio/consumer.h>
-#include <linux/leds.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/platform_data/x86/simatic-ipc-base.h>
-
-static struct gpiod_lookup_table *simatic_ipc_led_gpio_table;
-static struct gpiod_lookup_table *simatic_ipc_led_gpio_table_extra;
-
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
-	.dev_id = "leds-gpio",
-	.table = {
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 2, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
-	},
-};
-
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e_extra = {
-	.dev_id = NULL, /* Filled during initialization */
-	.table = {
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
-	},
-};
-
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
-	.dev_id = "leds-gpio",
-	.table = {
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 1, NULL, 1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 2, NULL, 2, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
-	},
-};
-
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g_extra = {
-	.dev_id = NULL, /* Filled during initialization */
-	.table = {
-		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
-	},
-};
-
-static const struct gpio_led simatic_ipc_gpio_leds[] = {
-	{ .name = "red:" LED_FUNCTION_STATUS "-1" },
-	{ .name = "green:" LED_FUNCTION_STATUS "-1" },
-	{ .name = "red:" LED_FUNCTION_STATUS "-2" },
-	{ .name = "green:" LED_FUNCTION_STATUS "-2" },
-	{ .name = "red:" LED_FUNCTION_STATUS "-3" },
-	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
-};
-
-static const struct gpio_led_platform_data simatic_ipc_gpio_leds_pdata = {
-	.num_leds	= ARRAY_SIZE(simatic_ipc_gpio_leds),
-	.leds		= simatic_ipc_gpio_leds,
-};
-
-static struct platform_device *simatic_leds_pdev;
-
-static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
-{
-	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table);
-	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table_extra);
-	platform_device_unregister(simatic_leds_pdev);
-
-	return 0;
-}
-
-static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
-{
-	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
-	struct device *dev = &pdev->dev;
-	struct gpio_desc *gpiod;
-	int err;
-
-	switch (plat->devmode) {
-	case SIMATIC_IPC_DEVICE_127E:
-		if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
-			return -ENODEV;
-		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_127e;
-		simatic_ipc_led_gpio_table_extra = &simatic_ipc_led_gpio_table_127e_extra;
-		break;
-	case SIMATIC_IPC_DEVICE_227G:
-		if (!IS_ENABLED(CONFIG_GPIO_F7188X))
-			return -ENODEV;
-		request_module("gpio-f7188x");
-		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_227g;
-		simatic_ipc_led_gpio_table_extra = &simatic_ipc_led_gpio_table_227g_extra;
-		break;
-	default:
-		return -ENODEV;
-	}
-
-	gpiod_add_lookup_table(simatic_ipc_led_gpio_table);
-	simatic_leds_pdev = platform_device_register_resndata(NULL,
-		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
-		&simatic_ipc_gpio_leds_pdata,
-		sizeof(simatic_ipc_gpio_leds_pdata));
-	if (IS_ERR(simatic_leds_pdev)) {
-		err = PTR_ERR(simatic_leds_pdev);
-		goto out;
-	}
-
-	simatic_ipc_led_gpio_table_extra->dev_id = dev_name(dev);
-	gpiod_add_lookup_table(simatic_ipc_led_gpio_table_extra);
-
-	/* PM_BIOS_BOOT_N */
-	gpiod = gpiod_get_index(dev, NULL, 6, GPIOD_OUT_LOW);
-	if (IS_ERR(gpiod)) {
-		err = PTR_ERR(gpiod);
-		goto out;
-	}
-	gpiod_put(gpiod);
-
-	/* PM_WDT_OUT */
-	gpiod = gpiod_get_index(dev, NULL, 7, GPIOD_OUT_LOW);
-	if (IS_ERR(gpiod)) {
-		err = PTR_ERR(gpiod);
-		goto out;
-	}
-	gpiod_put(gpiod);
-
-	return 0;
-out:
-	simatic_ipc_leds_gpio_remove(pdev);
-
-	return err;
-}
-
-static struct platform_driver simatic_ipc_led_gpio_driver = {
-	.probe = simatic_ipc_leds_gpio_probe,
-	.remove = simatic_ipc_leds_gpio_remove,
-	.driver = {
-		.name = KBUILD_MODNAME,
-	}
-};
-module_platform_driver(simatic_ipc_led_gpio_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" KBUILD_MODNAME);
-MODULE_SOFTDEP("pre: platform:leds-gpio");
-MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.h b/drivers/leds/simple/simatic-ipc-leds-gpio.h
new file mode 100644
index 000000000000..bf258c32f83d
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#ifndef _SIMATIC_IPC_LEDS_GPIO_H
+#define _SIMATIC_IPC_LEDS_GPIO_H
+
+int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
+				struct gpiod_lookup_table *table,
+				struct gpiod_lookup_table *table_extra);
+
+int simatic_ipc_leds_gpio_remove(struct platform_device *pdev,
+				 struct gpiod_lookup_table *table,
+				 struct gpiod_lookup_table *table_extra);
+
+#endif /* _SIMATIC_IPC_LEDS_GPIO_H */
diff --git a/drivers/leds/simple/simatic-ipc-leds.c b/drivers/leds/simple/simatic-ipc-leds.c
index 4894c228c165..2124f6d09930 100644
--- a/drivers/leds/simple/simatic-ipc-leds.c
+++ b/drivers/leds/simple/simatic-ipc-leds.c
@@ -126,7 +126,6 @@ static struct platform_driver simatic_ipc_led_driver = {
 		.name = KBUILD_MODNAME,
 	}
 };
-
 module_platform_driver(simatic_ipc_led_driver);
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index b3622419cd1a..c773995b230d 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -68,9 +68,10 @@ static int register_platform_devices(u32 station_id)
 	}
 
 	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
-		if (ledmode == SIMATIC_IPC_DEVICE_127E ||
-		    ledmode == SIMATIC_IPC_DEVICE_227G)
-			pdevname = KBUILD_MODNAME "_leds_gpio";
+		if (ledmode == SIMATIC_IPC_DEVICE_127E)
+			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
+		if (ledmode == SIMATIC_IPC_DEVICE_227G)
+			pdevname = KBUILD_MODNAME "_leds_gpio_f7188x";
 		platform_data.devmode = ledmode;
 		ipc_led_platform_device =
 			platform_device_register_data(NULL,
-- 
2.39.3

