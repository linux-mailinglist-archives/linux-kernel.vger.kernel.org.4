Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753D77453E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 04:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGCCru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 22:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGCCrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 22:47:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12hn2212.outbound.protection.outlook.com [52.100.165.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A5E18F;
        Sun,  2 Jul 2023 19:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XouX/K5qVA/IqlKFFNxRT/GZbtXIPw63KD36eIFFPr7W/qD+0OFtljy4mEJWkIl5lzu/Wtn9WPiqOsyEn+MnQcY/0ca8h3u6S7+s5jNJ6dMHgADNCUMUeqlpdn6IczXP8d1lioSgk/F2rARC+gjj3hSu1fFNjiEl7FzDZ6IRlJllDvEWmgMHVBlbsXlNjG+EpLWVSIMnam6O6j4YWYj20DSwcCsTmJsVPtjMiyt6HEYHiiZqBSJTzOvMNrl9kBRg3VGP7rcB0KfUb6OrMWDZLnUhXbc0kRdzPRyT85x69InjmNK/vKwzx9CrVblqEaCFSfxEOT4Rb9mpsxNPruKWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKncvf/Vi4+B2gbr+MyBeAkT5AE7qUlzVoUCKtgSdVk=;
 b=Z1Vm1IcT9YAe5ItkS/YPOe49aVIBJOJbqPnRF7DCYH9hN6Akdhh5/5V2Fxe0xpb+D2yAektqwc8PudJPHahbuw9Ls6H7g1quO1V2e/meowhYmQmSrmyHCcDp8E3ZMXEcjNT7wIQTpP25umHkU4g1/At7L7TQbBmHkDSA/Qrnu2x3NWby1TSpe9tBBUi3ZvyomYkKdD+UG10WbpmED/clD17OHeZI400M6FTlxzJ5TkG36QRl5zD7AeUMns7vv3l7omPLPjI5W0Su8eyIk5TJGkSrcz24jO+ED6FOhtp+Mlb5CG8QBg4b3vyWVT3HYs3I7GDOctCHj+H+nUCz6Qxg4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.147.44.155) smtp.rcpttodomain=gmail.com smtp.mailfrom=tw.synaptics.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=tw.synaptics.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKncvf/Vi4+B2gbr+MyBeAkT5AE7qUlzVoUCKtgSdVk=;
 b=FCaZEFG1afjHzpahxgDaTU3m0URP9i1j4OjnkzBJqMzJvbQoFROA6o1C42KH9KYuTrOG2fyCtUBAEE/3f8a3zd2QPRspx1I4h5E7CaWxdAI5PSPk//+hN/Ggk9kjJVvACIfplqzNcQjUAL/XSxDIdMFCUQpj8fY6b0DVyZy0K/o=
Received: from BN9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::34)
 by SJ0PR03MB5565.namprd03.prod.outlook.com (2603:10b6:a03:27a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 02:47:43 +0000
Received: from BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::f4) by BN9P223CA0029.outlook.office365.com
 (2603:10b6:408:10b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.26 via Frontend
 Transport; Mon, 3 Jul 2023 02:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.147.44.155)
 smtp.mailfrom=tw.synaptics.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=tw.synaptics.com;
Received-SPF: Pass (protection.outlook.com: domain of tw.synaptics.com
 designates 192.147.44.155 as permitted sender)
 receiver=protection.outlook.com; client-ip=192.147.44.155;
 helo=365hybrid.synaptics.com; pr=C
Received: from 365hybrid.synaptics.com (192.147.44.155) by
 BN8NAM11FT111.mail.protection.outlook.com (10.13.177.54) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Mon, 3 Jul 2023 02:47:42 +0000
Received: from SJC1WVP-OPEX01.synaptics-inc.local (10.20.148.252) by
 SJC1WVP-OPEX01.synaptics-inc.local (10.20.148.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 2 Jul 2023 19:47:40 -0700
Received: from sjc1uvd-bld04.synaptics.com (10.20.70.64) by
 SJC1WVP-OPEX01.synaptics-inc.local (10.20.148.252) with Microsoft SMTP Server
 id 15.2.1258.12 via Frontend Transport; Sun, 2 Jul 2023 19:47:40 -0700
From:   Marge Yang <marge.yang@tw.synaptics.com>
To:     <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marge.yang@tw.synaptics.com>
CC:     <david.chiu@tw.synaptics.com>, <derek.cheng@tw.synaptics.com>,
        <sam.tsai@synaptics.com>, <vincent.huang@tw.synaptics.com>
Subject: [PATCH V3] Input: synaptics-rmi4- Add a new feature for Forepad.
Date:   Mon, 3 Jul 2023 02:47:36 +0000
Message-ID: <20230703024736.80044-1-marge.yang@tw.synaptics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT111:EE_|SJ0PR03MB5565:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af7b6d0-0ffe-4456-7832-08db7b6fdfb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jutSk1O88miYqGNatqvdnGnGDlpioO+1N3wTWSfN7kB7kEgTA3KCwf9mwV2qBf4dAR4jRAdOXb7qp3tQRBjRWtPVWRsYy+p3PhuLhBOUdMfJ5OYeGEhYJgZCimnduErG9p0FgaW0qDkSqrTW13aMa3xJJaM0H2xOSLhpYD6GWyQSj3DSjaossDYd7n/VDUSu60SLAhob/tk/OY715lA7wgHTkfKLIKj00McXxgCYycog1A456EX18UWG6EWQ3vQ+UZbapX2Ute5XH5R0FM62Y7SO7SiyWwZjc7q4kJgDbk+hLfK0gp0WYQnol6wr3lMpazRSJpvXhIxJSqlzWWsOKU0pEPAbMB4497rLe+tOuTFqzSWi3p8j00gbG7mO5k0CR1dMBnMbv5kQ8F9MAkhkxxxlNTuZV0peJjN9MGAWUW+NH+wohhucpndzoU+LFHfqoDrK6X/Qu2BkQ1gZGZ1lNrSpUEBhm+cYJYkz2dHAB7yqvWuaD4fyKUw6ktlkCM/i4naOQW0Xqs5Ni4lguQyMp7HKBzGohUqCQ70uU/pBClJGJ9pdmHq4SQtGEIIQgQOeTmSPd6vkS4/pwE27Bw1l7eMD+ILkA04MsnvCKwWwsilSv34mk1AI8OpCjPRzFGXSkwW/+VpW4MX9+jJ1M//9DSU5AzHfsyPx//qzyjJkLfp+V/9xjnI99J0yVwcmHmYe3UJeaHcGTMGr6Kn7ZJ5lERBBNK0qvnfiLgZOpJ2r7c8urqShgRKHaD87n+DVTtR90uDhiDlLP/sY526EfIUY16714OfLlVeF9oJO8W0BDsimY/YmwIHrFC7pLikb7h33
X-Forefront-Antispam-Report: CIP:192.147.44.155;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:365hybrid.synaptics.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(346002)(39850400004)(396003)(136003)(376002)(5400799015)(451199021)(36840700001)(46966006)(336012)(7049001)(41300700001)(34020700004)(82310400005)(6666004)(82740400003)(2616005)(107886003)(81166007)(356005)(83380400001)(1076003)(26005)(186003)(47076005)(36860700001)(40480700001)(110136005)(54906003)(86362001)(478600001)(316002)(2906002)(4326008)(70586007)(70206006)(8936002)(8676002)(44832011)(5660300002)(36900700001)(12100799033);DIR:OUT;SFP:1501;
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 02:47:42.6227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af7b6d0-0ffe-4456-7832-08db7b6fdfb4
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=335d1fbc-2124-4173-9863-17e7051a2a0e;Ip=[192.147.44.155];Helo=[365hybrid.synaptics.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5565
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forcepad devices will use F21, for click simulation
due to lack of a metal button, so we add F21 support
to make forcepad support click function.

Signed-off-by: Marge Yang <marge.yang@tw.synaptics.com>
---
 drivers/input/rmi4/Kconfig      |   8 +++
 drivers/input/rmi4/Makefile     |   1 +
 drivers/input/rmi4/rmi_bus.c    |   3 +
 drivers/input/rmi4/rmi_driver.h |   5 +-
 drivers/input/rmi4/rmi_f21.c    | 110 ++++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 drivers/input/rmi4/rmi_f21.c

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index c0163b983ce6..37e2ba4918fd 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -108,6 +108,14 @@ config RMI4_F3A
 	  Function 3A provides GPIO support for RMI4 devices. This includes
 	  support for buttons on TouchPads and ClickPads.
 
+config RMI4_F21
+	bool "RMI4 Function 21 (PRESSURE)"
+	help
+	  Say Y here if you want to add support for RMI4 function 21.
+
+	  Function 21 provides buttons/pressure for RMI4 devices. This includes
+	  support for buttons/pressure on PressurePad.
+
 config RMI4_F54
 	bool "RMI4 Function 54 (Analog diagnostics)"
 	depends on VIDEO_DEV=y || (RMI4_CORE=m && VIDEO_DEV=m)
diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index 02f14c846861..ec4f08513d8b 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -11,6 +11,7 @@ rmi_core-$(CONFIG_RMI4_F12) += rmi_f12.o
 rmi_core-$(CONFIG_RMI4_F30) += rmi_f30.o
 rmi_core-$(CONFIG_RMI4_F34) += rmi_f34.o rmi_f34v7.o
 rmi_core-$(CONFIG_RMI4_F3A) += rmi_f3a.o
+rmi_core-$(CONFIG_RMI4_F21) += rmi_f21.o
 rmi_core-$(CONFIG_RMI4_F54) += rmi_f54.o
 rmi_core-$(CONFIG_RMI4_F55) += rmi_f55.o
 
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index f2e093b0b998..e12033aa7517 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -369,6 +369,9 @@ static struct rmi_function_handler *fn_handlers[] = {
 #ifdef CONFIG_RMI4_F3A
 	&rmi_f3a_handler,
 #endif
+#ifdef CONFIG_RMI4_F21
+	&rmi_f21_handler,
+#endif
 #ifdef CONFIG_RMI4_F54
 	&rmi_f54_handler,
 #endif
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 1c6c6086c0e5..57f258371bab 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -114,7 +114,9 @@ static inline int rmi_f03_overwrite_button(struct rmi_function *fn,
 }
 static inline void rmi_f03_commit_buttons(struct rmi_function *fn) {}
 #endif
-
+#ifdef CONFIG_RMI4_F21
+int rmi_f21_report_pressure(struct rmi_function *fn, int i);
+#endif
 #ifdef CONFIG_RMI4_F34
 int rmi_f34_create_sysfs(struct rmi_device *rmi_dev);
 void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev);
@@ -136,6 +138,7 @@ extern struct rmi_function_handler rmi_f12_handler;
 extern struct rmi_function_handler rmi_f30_handler;
 extern struct rmi_function_handler rmi_f34_handler;
 extern struct rmi_function_handler rmi_f3a_handler;
+extern struct rmi_function_handler rmi_f21_handler;
 extern struct rmi_function_handler rmi_f54_handler;
 extern struct rmi_function_handler rmi_f55_handler;
 #endif
diff --git a/drivers/input/rmi4/rmi_f21.c b/drivers/input/rmi4/rmi_f21.c
new file mode 100644
index 000000000000..bbb9ab12ae7c
--- /dev/null
+++ b/drivers/input/rmi4/rmi_f21.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2012-2020 Synaptics Incorporated
+ */
+
+#include <linux/kernel.h>
+#include <linux/rmi.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+#include "rmi_driver.h"
+
+#define RMI_F21_FORCE_CLICK_OFFSET	8
+#define RMI_f21_FORCE_CLICK			0x01
+#define RMI_f21_DATA_REGS_MAX_SIZE	1
+#define RMI_f21_FORCEPAD_BUTTON_COUNT	1
+
+struct f21_data {
+	/* Query Data */
+	u8 data_regs[RMI_f21_DATA_REGS_MAX_SIZE];
+	struct input_dev *input;
+	u16 key_code;
+};
+
+static irqreturn_t rmi_f21_attention(int irq, void *ctx)
+{
+	struct rmi_function *fn = ctx;
+	struct f21_data *f21 = dev_get_drvdata(&fn->dev);
+	int error;
+
+	error = rmi_read_block(fn->rmi_dev,
+				fn->fd.data_base_addr+RMI_F21_FORCE_CLICK_OFFSET,
+				f21->data_regs, 1);
+	if (error) {
+		dev_err(&fn->dev,
+			"%s: Failed to read f21 data registers: %d\n",
+			__func__, error);
+		return IRQ_RETVAL(error);
+	}
+
+	if ((f21->data_regs[0] & RMI_f21_FORCE_CLICK))
+		input_report_key(f21->input, f21->key_code, true);
+	else
+		input_report_key(f21->input, f21->key_code, false);
+	return IRQ_HANDLED;
+}
+
+static int rmi_f21_config(struct rmi_function *fn)
+{
+	struct f21_data *f21 = dev_get_drvdata(&fn->dev);
+	struct rmi_driver *drv = fn->rmi_dev->driver;
+
+	if (!f21)
+		return 0;
+
+	drv->set_irq_bits(fn->rmi_dev, fn->irq_mask);
+
+	return 0;
+}
+
+static int rmi_f21_initialize(struct rmi_function *fn, struct f21_data *f21)
+{
+	struct input_dev *input = f21->input;
+	unsigned int button = BTN_LEFT;
+
+	f21->key_code = button;
+	input_set_capability(input, EV_KEY, f21->key_code);
+	input->keycode = &(f21->key_code);
+	input->keycodesize = sizeof(f21->key_code);
+	input->keycodemax = RMI_f21_FORCEPAD_BUTTON_COUNT;
+
+	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+
+	return 0;
+}
+
+static int rmi_f21_probe(struct rmi_function *fn)
+{
+	struct rmi_device *rmi_dev = fn->rmi_dev;
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	struct f21_data *f21;
+	int error;
+
+	if (!drv_data->input) {
+		dev_info(&fn->dev, "f21: no input device found, ignoring\n");
+		return -ENXIO;
+	}
+
+	f21 = devm_kzalloc(&fn->dev, sizeof(*f21), GFP_KERNEL);
+	if (!f21)
+		return -ENOMEM;
+
+	f21->input = drv_data->input;
+
+	error = rmi_f21_initialize(fn, f21);
+	if (error)
+		return error;
+
+	dev_set_drvdata(&fn->dev, f21);
+	return 0;
+}
+
+struct rmi_function_handler rmi_f21_handler = {
+	.driver = {
+		.name = "rmi4_f21",
+	},
+	.func = 0x21,
+	.probe = rmi_f21_probe,
+	.config = rmi_f21_config,
+	.attention = rmi_f21_attention,
+};
-- 
2.25.1

