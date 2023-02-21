Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1510969E050
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjBUMZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjBUMYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:24:42 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA167B74E;
        Tue, 21 Feb 2023 04:24:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q78QShanU06qSzDLxcmyKKS1YRCAqy6wkYmPMAEfgPhrBgjHxHCyrIgiBbA5gKU4UJ7Vc8sdurbwXI1p7WKweZ03A3SC3wMf3WdABKyKVTSYhUDVeqjVRU06Xg569+xmzjbwo8IOfQQrJGZLWQIlZyDHdXBymjeJXVKeXzQ0o0Xh36ufh/IVJkVruri2K+DFh0FgGAe9WIcaLm5r5BtnT1MlpU+vgxyAqau+/0f+YvGETPTPbjEqPKJIpdXwSqgUlojqITe21nZJkNM1Fc8oCdDj9nE/Y+8PT1GzaUC9VA2yIx5t13Sm0LkrKGwFMk8Rj6UtdcaWLmuFtluu6tg9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5GTPt4BDdO5xv/iNRfjFVSnzmnyH97RgndPb+kRXH8=;
 b=BSjThp8kt+fbkRd+tNoNeRwfcb2BT3Ln42jAGjbxaZpPIT9G/DQUNFohiVaQSEZMAU9ZJkQk+FTgkI+9psTMw7c7a/Rk761wLSFZ7UsVKwjlfDoWikVN7Fqsq/TDuKUsYKRDqgoAruOIzKsDlB81z1VHlbI4fPoEm6ULwO2RzMNKNgTzBv3aftE9wjYaX40WkzoUQDVN/eb80YiPqh4egF/mhyAE8oUdo42sF3y5l8VPVKk7VP/dJwHSB7+pOs6Jc9zOqZj3PvPPKb/FIyZ7qEiIyqNCgzCaCjrw8OyLFVNrSpM2AhvFpGWxo2muBNNzc+Uop5ShYGPraLlpe3GLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5GTPt4BDdO5xv/iNRfjFVSnzmnyH97RgndPb+kRXH8=;
 b=mz2m5/KOFoTHTU/cqS9qWQOjWodZqB4tu6dVh/qdoEM2hPOv3aiiWGMkG4wr7ZVOBw+/LieTxUMhCLsOqY+3RWibKYHK6YbgMYHYAyJ3paIbkZiz154lViL4Ji9GdMd4tymXkzwdnXW2g8n7l1/c4gTpPrNqVCiZkes/iwpT00aojSdhuDHIrds8fVgmN76aK2ZW/94Wpa2GxSPNLho1p8ZLIM/b9dYl1n1sojvK3MS/21+EJsi5d6Tew8vh16PqnksaT0a5z+T+dMs881LYRwPFelcdy6ODbLaFo1Ewu/HfcZMRfOz45vhNkScsjVtEs9MpjJ2LHxt2Zl1pEddCeA==
Received: from FR0P281CA0095.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a9::12)
 by AS2PR10MB7370.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:606::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 12:24:31 +0000
Received: from VE1EUR01FT079.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a9:cafe::4f) by FR0P281CA0095.outlook.office365.com
 (2603:10a6:d10:a9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17 via Frontend
 Transport; Tue, 21 Feb 2023 12:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT079.mail.protection.outlook.com (10.152.3.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.17 via Frontend Transport; Tue, 21 Feb 2023 12:24:30 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Tue, 21 Feb 2023 13:24:29 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.68.242) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Tue, 21 Feb 2023 13:24:29 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 2/3] leds: simatic-ipc-leds-gpio: split up into multiple drivers
Date:   Tue, 21 Feb 2023 13:24:13 +0100
Message-ID: <20230221122414.24874-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221122414.24874-1-henning.schild@siemens.com>
References: <20230221122414.24874-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.242]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT079:EE_|AS2PR10MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fe4f56-4794-492b-6674-08db14069534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Glz7rXdQhqIoy9enZNKzzdzCHRU1vHzY6CXldpQ0epm/VVzO6QxSM2lb3XM1Ocy921sUBFEHgKeC9te+xIIrWLmRYgXf0R4CB6tNo4265TRb3V7DlR6uoUCtW1SX7rJbLHeWWN5PvvoC0aAMKJQSiWhKTEN8fCjf3k89cvjNeZI3t14FDjSEpKJybmSp0+/Qs+KHIr0D6x7zvcHUG32jXWHLsdACnfPfardN/ndKxQDYZ7uU6DSghx2UiZ2AGl1mOD+g0zFLOlJC2SMcuhDdKhE8y2RGe5FKc+I5VEDuvTa7kUKOtHz3i4/XRe05/lgcCVvlpn94QZZ0nWpnd7kbUdw84+1PZtYqmbFPBNynKeY+FD9q9cXRS20Q9ntDpEi/A08qgQ9hcuiJgFgJRl1payToGrgHu2vQ5JyZThE+7S7cSzI05DPMd3lxcVg1DFTC1ZcKpVznZsLNo8KU5eSOwSlxQ2NsdRJn4EJXANZ4QHrig49C/1XewdhrDfhk+8F1IJn/3Q9ZIlZT375jKGh+UUaCN72Id8oRdmrdjzK8k4ALbGWn7SmS1Ld/lg/ru3OJkWOTt53uZBaMHI8DaZu+MjNdvW7f1j1osotGjKFmAtn/XDeu7vCj8JAVot/gVo5gm4o84/QrzzXS3Rqv2lVEgCIFaTfcPVfT1+sqeLCxMFSRrMtExxcBCPgnHvBb/9amljwO5FX23lJ46gn3lHZHjolB9rsGegiJqKbR7K9jZvU=
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(316002)(70586007)(110136005)(83380400001)(8676002)(8936002)(4326008)(956004)(2616005)(1076003)(107886003)(41300700001)(47076005)(16526019)(26005)(186003)(478600001)(336012)(6666004)(40480700001)(70206006)(36756003)(2906002)(82310400005)(82740400003)(86362001)(5660300002)(30864003)(82960400001)(44832011)(36860700001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 12:24:30.8030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fe4f56-4794-492b-6674-08db14069534
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT079.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7370
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to clearly describe the dependencies between the gpio
controller drivers and the users the driver is split up into two and one
common header.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/Makefile                  |   3 +-
 .../simple/simatic-ipc-leds-gpio-apollolake.c |  34 ++++
 .../simple/simatic-ipc-leds-gpio-f7188x.c     |  34 ++++
 drivers/leds/simple/simatic-ipc-leds-gpio.c   | 159 ------------------
 drivers/leds/simple/simatic-ipc-leds-gpio.h   | 112 ++++++++++++
 drivers/platform/x86/simatic-ipc.c            |   7 +-
 6 files changed, 186 insertions(+), 163 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
 delete mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.h

diff --git a/drivers/leds/simple/Makefile b/drivers/leds/simple/Makefile
index 1c7ef5e1324b..21853956c1ea 100644
--- a/drivers/leds/simple/Makefile
+++ b/drivers/leds/simple/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-apollolake.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-f7188x.o
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c b/drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
new file mode 100644
index 000000000000..b5f2448e0aa4
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Authors:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
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
+	.dev_id = NULL,
+	.table = {
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
+	},
+};
+
+MODULE_SOFTDEP("pre: platform:leds-gpio platform:apollolake-pinctrl");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
new file mode 100644
index 000000000000..bc6eeb47ce91
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Authors:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
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
+	.dev_id = NULL,
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
+	},
+};
+
+MODULE_SOFTDEP("pre: platform:leds-gpio gpio_f7188x");
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
index 000000000000..c474836c7a59
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.h
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Authors:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#ifndef __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO
+#define __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+
+static struct platform_device *simatic_leds_pdev;
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table;
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra;
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
+static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
+{
+	gpiod_remove_lookup_table(&simatic_ipc_led_gpio_table);
+	gpiod_remove_lookup_table(&simatic_ipc_led_gpio_table_extra);
+	platform_device_unregister(simatic_leds_pdev);
+
+	return 0;
+}
+
+static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
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
+	gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
+	simatic_leds_pdev = platform_device_register_resndata(NULL,
+		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
+		&simatic_ipc_gpio_leds_pdata,
+		sizeof(simatic_ipc_gpio_leds_pdata));
+	if (IS_ERR(simatic_leds_pdev)) {
+		err = PTR_ERR(simatic_leds_pdev);
+		goto out;
+	}
+
+	simatic_ipc_led_gpio_table_extra.dev_id = dev_name(dev);
+	gpiod_add_lookup_table(&simatic_ipc_led_gpio_table_extra);
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
+	simatic_ipc_leds_gpio_remove(pdev);
+
+	return err;
+}
+
+static struct platform_driver simatic_ipc_led_gpio_driver = {
+	.probe = simatic_ipc_leds_gpio_probe,
+	.remove = simatic_ipc_leds_gpio_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+
+module_platform_driver(simatic_ipc_led_gpio_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+
+#endif /* __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO */
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

