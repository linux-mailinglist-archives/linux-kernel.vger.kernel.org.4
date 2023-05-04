Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9A6F63A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjEDDng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEDDnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:43:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FBE1B1;
        Wed,  3 May 2023 20:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jISXc/aPefMp2ES0xL98nHpVTSiV4jQ7/kduzR9nXFxh2u+Xx0cAjcgzaHBj7m7hF7lfnr7ppdYy9RE5dmigVZv3W0n7sbl+o7TJI8wtrxcOmummJugKIrQk5lN0XfGg+k8jTWB0/sO9GsNrfO5CGmNhdu7GcUskcsTZHFr95DeWpuoi50ZlQkWLSvrn5qwgp4A7pWdWRuZcj3rO7MX7llQXg5BfysQoPZ1sMMn+1EYhaTlRQnug8bDihb6Fje8WPTxtza/tHz+YFlSre3S3mdX9tZVgyGTdeu8L6R3zMgrfGglmuDMtzyZuAkLtWCbQcBxXPSlDUcS9xkDqAb+cZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iG2Ivvdx2fhZqtlr1r2kHdSSNgGHpf6inzK7YTV6B4k=;
 b=Pgbu2Js3ZfDuYcoBnOCdKOnE5hsxm8qunzVuu73kH9wD/ujAje3BYIBt9DqnuTmhVbf+ij9Mot57xHf30ikcPZMajTOunsGuJelUOCw9GtFqK4T1PSOgmgbOF5/gVmuo14MfEBx27Z9t0nkTAWcZTCuF3vNQQVDHP9fXBdtN4xzQI/JFVBpDjWvzV3FLzTDE5v0Uv5T7m7H1pZ8vfeLkNN4eBneheTinTGiXWmWJd7skeGkFTUs0t2sXDmWEXKiEIbBIlkKQPnqKIeBPJ+8XFqXdxokXqYrd9CGPHGKTNKuMef7EfXua8xPn1e7t72ai/wOFERrkDWhCRfaRu7GyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.147.44.15) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=tw.synaptics.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=tw.synaptics.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iG2Ivvdx2fhZqtlr1r2kHdSSNgGHpf6inzK7YTV6B4k=;
 b=XMW3BJh5lLrZOwObHjMCtwEqyiOe7Ze+kiOTYdVuRMAnv5AZ0CAaHCiyCo4PfQ1J0L6RHonl0P6tg1ZOESbEXd8UOJSvCfOXzFcNFtDsFtMESD58B/P35R6/uvtxRZjy6juFL70RfHuibo8oELCCliKn4Q+ZtEqXOcq2s4uDtYQ=
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by SJ0PR03MB6566.namprd03.prod.outlook.com (2603:10b6:a03:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 03:43:27 +0000
Received: from BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::10) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22 via Frontend
 Transport; Thu, 4 May 2023 03:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.147.44.15)
 smtp.mailfrom=tw.synaptics.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=tw.synaptics.com;
Received-SPF: Pass (protection.outlook.com: domain of tw.synaptics.com
 designates 192.147.44.15 as permitted sender)
 receiver=protection.outlook.com; client-ip=192.147.44.15;
 helo=sjc1wvp-mail01.synaptics-inc.local; pr=C
Received: from sjc1wvp-mail01.synaptics-inc.local (192.147.44.15) by
 BN8NAM11FT111.mail.protection.outlook.com (10.13.177.54) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.6363.26 via Frontend Transport; Thu, 4 May 2023 03:43:26 +0000
Received: from sjc1wvp-mail01.synaptics-inc.local (10.20.24.252) by
 sjc1wvp-mail01.synaptics-inc.local (10.20.24.252) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 3 May 2023 20:43:24 -0700
Received: from sjc1uvd-bld04.synaptics.com (10.20.70.64) by
 sjc1wvp-mail01.synaptics-inc.local (10.20.24.252) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 3 May 2023 20:43:24 -0700
From:   Marge Yang <marge.yang@tw.synaptics.com>
To:     <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marge.yang@tw.synaptics.com>
CC:     <vincent.huang@tw.synaptics.com>, <david.chiu@tw.synaptics.com>,
        <derek.cheng@tw.synaptics.com>, <sam.tsai@synaptics.com>,
        Marge Yang <marge.yang@synaptics.com>
Subject: [PATCH V1] Input: synaptics-rmi4-add support for F21.
Date:   Thu, 4 May 2023 03:43:21 +0000
Message-ID: <20230504034321.97267-1-marge.yang@tw.synaptics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT111:EE_|SJ0PR03MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: da64cfa0-fb4a-4e6b-637f-08db4c51b7ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHKLOndE1uKInv5/RkCN8GYmMjanP7H3BD+Udw60WQN99xvUOtZC5TF8dxszqb3X6hAZsvVucsNe3uUJPTztfIe/0W8Z8TPHtVsO2Ted++x5vNI56etISehwdOw4dJMxRHIG61i2CVCLU3wIKJ0E5Bfm8Tj1v9nIuD8yPNqY1JSgo0AhiD6IG6IVO9hWCgVKIYY6M2nDPq0GOSv4J+5UfVN1rLGy1ySqad2glUdfnqzh1sjmn+LlpTzkiYAIY5amZbcv1cvMwaxm22gM1NWvuajqrsZSl6dBhV/SP0ka3PakslJLFvH8SzabvilEBWM4VwiRm/eBrOQkIvSrV1EL2SWogSFjrK8dmAzQTcpmbvWCd0VSpnwqDnWCXtqQzq/CoPK9q55Ho7XJT4KR8jnFmJxtA5B4oEya/NrAIo0oy8y3j6m6Ja6mCx40M2y4oHye6xsWof4o8LMUvytMP8QFaouKORKOFMiCA9YMaXi44zMHSEcMsNpWYmwE3/mq2Nr19095Tdru5TkryQnikDdLQYTZKJWTFjazd2qksvdBL05lfSQG+JrQTKVZs1hZbvuVQIHDtVUW4CmuNhX6OaVx5BWqJP1/Rbm+lsLY+c/v1O4sbmLVq5bjWdKtg9PlMISdGJ2TzeIu5PWbFqdqk5SUqTPVHIJCzW0DoYSaUmt6rdq6B9znU5L70ahdQcJe1SXwTrIPw387cW0JilAehgiJ5g==
X-Forefront-Antispam-Report: CIP:192.147.44.15;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjc1wvp-mail01.synaptics-inc.local;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(39860400002)(451199021)(46966006)(36840700001)(316002)(41300700001)(2906002)(186003)(1076003)(26005)(6666004)(54906003)(2616005)(110136005)(82310400005)(4326008)(107886003)(83380400001)(336012)(47076005)(70586007)(86362001)(70206006)(36860700001)(44832011)(478600001)(7049001)(8676002)(8936002)(82740400003)(5660300002)(81166007)(356005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 03:43:26.2835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da64cfa0-fb4a-4e6b-637f-08db4c51b7ea
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=335d1fbc-2124-4173-9863-17e7051a2a0e;Ip=[192.147.44.15];Helo=[sjc1wvp-mail01.synaptics-inc.local]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6566
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marge Yang <marge.yang@synaptics.com>

RMI4 F21 supports the forcepad click feature.

Signed-off-by: Marge Yang <marge.yang@synaptics.com>
---
 drivers/input/rmi4/Kconfig      |   8 +++
 drivers/input/rmi4/Makefile     |   1 +
 drivers/input/rmi4/rmi_bus.c    |   3 ++
 drivers/input/rmi4/rmi_driver.h |   5 +-
 drivers/input/rmi4/rmi_f21.c    | 110 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 drivers/input/rmi4/rmi_f21.c

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index c0163b9..37e2ba4 100644
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
index 02f14c8..ec4f085 100644
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
index 50a0134..d42df5f 100644
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
index 1c6c608..57f2583 100644
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
index 0000000..5657bf4
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
+	if (!!(f21->data_regs[0] & RMI_f21_FORCE_CLICK))
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
2.7.4

