Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B856A6A71BA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCARCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCARCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:02:35 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191F4347D;
        Wed,  1 Mar 2023 09:02:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1b7FQiPPCZ9jos2y0sHLmiinK+fAbiVNsHIEFLc4vEjn4pN3rkP+zA+WRGUj/n+xIURv/xkLPflrptGtiX7iDa1kMv/s74RIkcyf5WEndpznqRO09cS+ejhxYpkJPe5JFtB/4pkeafbgzH+kZ3Axr+/Z6qqHRh58ymCOg/ccL+l4xISsGKhJvQIwc877KcNT7XnwVpaRwMTWLn6w1+WR31c02Stz7FWxWrKGmnJOAleM+VDV59extVS46FZyEOelzl31M9Lcqp7UXImdp2DlMqj7mB7UxfZjnBBAYtfZSxlsXJbdae7mHhbvsKO7nfG0b3FvKvAM0CL5UVPapRXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUmXBwq+AcgcEA1qhhRf1s/Npahwwk7m7iLn45QXnAk=;
 b=HzFTQI//h0lyxDuj3kekOeOj/8v+3eJ3lcqg1CCqD3pVXGNtu6QKFXlP0IHKI7wpWKCGMXsL9xw2vj2T+8xGCOOGKmQfF/3U4U+9zLcO+cIYein7QkVKxKtLc6/EOv7wMrVfYgg6VNgJQqYH5lQh3uda1B8/vRZTzK7vpKgthltZgNvdib/LU9FDW6ydNu/L05Nvd5Tn2VK9sLSUJy0mwpp+twKbF6WCDOIkvaMYNAI9973/oAiz9aCIX+O4vS99dWvoGoFrzdYk2WseXKrTNKI88zbunRp9C0SbveV7+PAMa4yzQ4PbMVK9BVBi2nwB889m0oDOLK4thUtD1U4WDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUmXBwq+AcgcEA1qhhRf1s/Npahwwk7m7iLn45QXnAk=;
 b=BoDwpLn/YxALpUAr8v8m+UeMprNv2vVRkCUr90c4x/+pGZNrPsJU8b4MfBNWpfEdR30gKdP66cmua8UPJi4R8Vpf/m3RggdAL6ZhJbGvXXILrIpnQqRH1P/iVIb6sBgQVeqy760XssnBqQGWRr734jGBJ9ftF/iJh0JkfSPFto+JV48qFw4FO/LDJeVw0az41TQeIMiOTbe/jcUb5Vj0hhHZfKkz1fx0aCQ5EbNi4OjoQxZW5Do94DoDvV3op9VMiVygoFTPxaGxQHD7xu7PMoxEZp/bdKNkxmdA9S4zcUv7nrXkrEv4UeVbby4x8sP+bohGy1WVId5t/4MHt9xkWw==
Received: from OS6P279CA0054.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:31::12)
 by DU0PR10MB5996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 17:02:28 +0000
Received: from HE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:31:cafe::3a) by OS6P279CA0054.outlook.office365.com
 (2603:10a6:e10:31::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 17:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT019.mail.protection.outlook.com (10.152.0.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 17:02:27 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 1 Mar 2023 18:02:26 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.0.120) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Wed, 1 Mar 2023 18:02:26 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 2/3] leds: simatic-ipc-leds-gpio: split up into multiple drivers
Date:   Wed, 1 Mar 2023 18:02:14 +0100
Message-ID: <20230301170215.23382-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301170215.23382-1-henning.schild@siemens.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.120]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT019:EE_|DU0PR10MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f70ad6-ce8b-4bfb-a7f2-08db1a76bce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hx8n2gw1PlBuNi2NhI5w1U0PPePZL4I7EbpN7TtoDFcraHeTrD7UV/j+J8ERmCf/nXlsqYUdnCYYwI2QWvmPQliZ+8SoCxgmQ2NLhBh/Il0v8IBnDDKl+6r8zdsiK+62zEdIO+xS+f5zdi9DhN02iAJl8I5dQ6ACu9a1ZoK6hnUAqis+Fq2n/hlA91efZ+cBx9/D+G3XES+EW/Wu0z1zmujcGZcQQOAG41/6JkPZokEJ5woVYSdXl/fCKeh7B0/CQqHhsFDSPo4+tb67sfyNxVYd2LONmgVW2wswB0/NgkAI3+quYUZg/PVVcZDLqMUna28CIEbsXa1wsmr1DD3fX4YiR0W02Q7KylgAdL6QoOBni67Ti14Y09eesxlonGBIaahwllEc/YQTWARZ1qfrQzUXcAtSK2K9Wu5sRMGC9DIRSbivOXpzCzZ9WpDTHk0lcftavtoy4CoIBcYQSLvKm/Mpa4rDvUao5JSgP+9onKHmtenkZ8Aj/Cu3viZzzUYmpXkXOJgCclWBeAu0f73TldlnO3ML8bHPAZBUwIbxDtkQqSC00RUnKIQNX2qFKi/r05N0WyiDlky67UOOT7P5a2VsA05+KV8Z0CiWEaMGTpR+iSziOYo2m+rl/CiVOIfS1juw90p5PZqmCJVSNOgkRSzH+L1+cRZ0Vu6UhbevtVLQ5iZl0aBlxS0qO5sXPf453XMPelkN/lekihmutKA65A==
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199018)(40470700004)(36840700001)(46966006)(86362001)(36756003)(8936002)(5660300002)(4326008)(44832011)(40480700001)(41300700001)(30864003)(2906002)(7596003)(82960400001)(82740400003)(8676002)(356005)(7636003)(36860700001)(107886003)(316002)(478600001)(6666004)(70586007)(47076005)(82310400005)(40460700003)(70206006)(83380400001)(110136005)(26005)(2616005)(336012)(16526019)(186003)(1076003)(956004);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:02:27.9815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f70ad6-ce8b-4bfb-a7f2-08db1a76bce6
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5996
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 .../leds/simple/simatic-ipc-leds-gpio-core.c  | 103 ++++++++++++
 .../simple/simatic-ipc-leds-gpio-f7188x.c     |  64 +++++++
 drivers/leds/simple/simatic-ipc-leds-gpio.c   | 159 ------------------
 drivers/leds/simple/simatic-ipc-leds-gpio.h   |  22 +++
 drivers/platform/x86/simatic-ipc.c            |   7 +-
 7 files changed, 260 insertions(+), 163 deletions(-)
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
index 000000000000..8b874cdb38a1
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
+	.dev_id = NULL,
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
+
+module_platform_driver(simatic_ipc_led_gpio_apollolake_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: simatic-ipc-leds-gpio-core platform:apollolake-pinctrl");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
new file mode 100644
index 000000000000..ad5c9f8986d4
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
@@ -0,0 +1,103 @@
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
index 000000000000..d3dff1bffae3
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
+	.dev_id = NULL,
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
+
+module_platform_driver(simatic_ipc_led_gpio_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: simatic-ipc-leds-gpio-core gpio_f7188x");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
deleted file mode 100644
index ba0f24638af5..000000000000
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
-	.dev_id = NULL,
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
-	.dev_id = NULL,
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
2.39.2

