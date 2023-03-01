Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC9B6A71B7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCARCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCARCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:02:31 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F77A4347A;
        Wed,  1 Mar 2023 09:02:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3GYiBiHflzKL4qfyyXDJDV02whQUIYxx9rX3KxQDU5wPwnJJ7e/jWD7qMXuZC9auwgyz0n2i3rXnSkcZvvoQBknLYQgd3VPkjKmxsgLXkOuLqydLhNWt5GztExnDRsQe/cAE4E6YUqzxbpsdhbsfIPdWgQnI2ATzZCoxkvetpcwTpU8NgeXRGQvgeTvLXWdBHeci3wGTqHUYbS0lS+mP53Tqdw9OTTcmDfVN/zRH4hrqCLiuVCJRhLWGDdvbwPAz6qz+6uKQ3JQ8mqvdNwxxWaF8D9pGyuGXA16Dghmz1oX+eG+BkAf3auE6ZQ54wTZTAVzX3rV/K/76Bo3E3qO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b56LChrrOMNeXlSta0NH0223mU21fCBnYB3TCZTyDUo=;
 b=FNVxi518Vkw6lrk4Tftzord2L3dg/+RRy70p0SHkD9nGFIK0NTKMsElOB5UW0nmHnFH7cQQ2CvghFWs2oq7Qn7RSKSC+cL3dAFRvrN75ybZuqAZZfMOEsdsGOzpNWyJRSDRPKb5xmrk4EP4gUaJYhYb3+qaAGO+3cV+APWE7mrB73w0jSVKCRSMJ7EP88JDb5oQ3WlY9Q35mVE3fLOCYkdm3gsGvGY67TUAsxrZilpJcH3tt8mIixPiGx2g4Kw1XVI1v8fYBtnBNkJ+u3DZtUHLp8MfVQnjaAVovC/MtcvK8mZ5IVFoKYL2E/KrvYZEngPlhRYeEy51roeF/NJezZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b56LChrrOMNeXlSta0NH0223mU21fCBnYB3TCZTyDUo=;
 b=R0qp57BaqzT/8y98lhqL1Cd1VzrQ+vz6RT4kAUNW8oe8jr0qbt+nZ9+bb9XTDiXqUg+FYoVUt7oJOwdMEK4oekR5d6e90fZJtA4TVvexnaeLmPmnXKUExMfFqWSonUSI1sF+Y8l9QX/+qqVZOHzhHr9mbxGdcDgMazo39GnihLltkre+SY9no56WvfU8CpaMtZQVMCHGnHbvKrKJKbJacE7uaSc2lgEntOmM7VJt8MhuK96lqSieNft0E9Snlb0xC8BMwtGKCicUf9hSFFzhrRA2aus/P1Bm+zYenN+JSHeLUYhdIElM/5xLqewo6nyHHk8/nUgitw5/7o3z3Qxagg==
Received: from OS6P279CA0059.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:31::16)
 by PA4PR10MB5708.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 17:02:27 +0000
Received: from HE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:31:cafe::a3) by OS6P279CA0059.outlook.office365.com
 (2603:10a6:e10:31::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17 via Frontend
 Transport; Wed, 1 Mar 2023 17:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT019.mail.protection.outlook.com (10.152.0.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 17:02:26 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 1 Mar 2023 18:02:26 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.0.120) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Wed, 1 Mar 2023 18:02:25 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 1/3] leds: simatic-ipc-leds-gpio: move two extra gpio pins into another table
Date:   Wed, 1 Mar 2023 18:02:13 +0100
Message-ID: <20230301170215.23382-2-henning.schild@siemens.com>
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
X-MS-TrafficTypeDiagnostic: HE1EUR01FT019:EE_|PA4PR10MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: c54710b1-76e3-4d2e-2895-08db1a76bc42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0+ufiykzx/UiX7+BvzxanY913b6h8Zdch8Q6vtha2Bxn8oqmqJkg4oWQCVCcgCLjORwEMLJUO7cQaJvbrAHN3v+FsMHcGvONb0FqGBuVWKGV0GxzE5PFjHjaP+1kw650oe/q4/Mw6lqVOoEiTzY+CnXossJMSOxXBzDQi2fngYmYxda+u5UYwwJSSybwwSeroa0RioE0W9NTR347fFw4UaooP92+leJAkkF6FB5AP1vg1Clc6Q6wPXDiSiFj87fmnSza1nZH91cVCzKnN8Z+s5khKxH5vYzHZrUOhltB7vR8PocTXtjWkBjt0rFTd3L2SK4AHq1dZx9XM81TxO+zR5zJaWIH1vYptxQN7j+74M3UdhKLjdX/3VHU4u0JrHy+wpiWOl75T+Q+6rPSibnVxpZaXkfNJ/li+0cSvLG989MdF+EKBBLJUeQq4az6XfSU8r4h9ONBSCUDSo7v7eKSyfGg/PYvMSzADcD5ZQDy8L2V87xRnF3U0v+Y72hchvXv7XggOY4rSSVMpWnXBGcjNLOx1r8lcNVRMnSR5NBe+EWKzniN/j5ceRpzAx5dlLJh2xcAVfC5fcWeys/SRtG8OIp0B47A4LGlyEVlX75EIZxua/VmKT4rFC4n7qAuncTzGTT1NDq+jb1cIdfB5SArlW1iDpi3wEgSaeXbtGmorJpFmuFk7Y/Ciqfh3MSFaR2y+AIgNrmsvlun/3x2VCfow==
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(82310400005)(36756003)(316002)(336012)(47076005)(110136005)(83380400001)(478600001)(107886003)(186003)(1076003)(16526019)(2616005)(956004)(40460700003)(26005)(6666004)(86362001)(8936002)(356005)(41300700001)(2906002)(5660300002)(70206006)(44832011)(36860700001)(70586007)(4326008)(82960400001)(82740400003)(8676002)(7596003)(7636003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:02:26.9035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54710b1-76e3-4d2e-2895-08db1a76bc42
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5708
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two special pins needed to init the LEDs. We used to have them
at the end of the gpiod_lookup table to give to "leds-gpio". A cleaner
way is to have a dedicated table for the special pins.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 26 ++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
index e8d329b5a68c..ba0f24638af5 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -16,6 +16,7 @@
 #include <linux/platform_data/x86/simatic-ipc-base.h>
 
 static struct gpiod_lookup_table *simatic_ipc_led_gpio_table;
+static struct gpiod_lookup_table *simatic_ipc_led_gpio_table_extra;
 
 static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
 	.dev_id = "leds-gpio",
@@ -26,6 +27,12 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e_extra = {
+	.dev_id = NULL,
+	.table = {
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
 	},
@@ -40,9 +47,15 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g_extra = {
+	.dev_id = NULL,
+	.table = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
-	}
+	},
 };
 
 static const struct gpio_led simatic_ipc_gpio_leds[] = {
@@ -64,6 +77,7 @@ static struct platform_device *simatic_leds_pdev;
 static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
 {
 	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table);
+	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table_extra);
 	platform_device_unregister(simatic_leds_pdev);
 
 	return 0;
@@ -72,6 +86,7 @@ static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
 static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 {
 	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
 	struct gpio_desc *gpiod;
 	int err;
 
@@ -80,12 +95,14 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 		if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
 			return -ENODEV;
 		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_127e;
+		simatic_ipc_led_gpio_table_extra = &simatic_ipc_led_gpio_table_127e_extra;
 		break;
 	case SIMATIC_IPC_DEVICE_227G:
 		if (!IS_ENABLED(CONFIG_GPIO_F7188X))
 			return -ENODEV;
 		request_module("gpio-f7188x");
 		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_227g;
+		simatic_ipc_led_gpio_table_extra = &simatic_ipc_led_gpio_table_227g_extra;
 		break;
 	default:
 		return -ENODEV;
@@ -101,8 +118,11 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	simatic_ipc_led_gpio_table_extra->dev_id = dev_name(dev);
+	gpiod_add_lookup_table(simatic_ipc_led_gpio_table_extra);
+
 	/* PM_BIOS_BOOT_N */
-	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 6, GPIOD_OUT_LOW);
+	gpiod = gpiod_get_index(dev, NULL, 6, GPIOD_OUT_LOW);
 	if (IS_ERR(gpiod)) {
 		err = PTR_ERR(gpiod);
 		goto out;
@@ -110,7 +130,7 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 	gpiod_put(gpiod);
 
 	/* PM_WDT_OUT */
-	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 7, GPIOD_OUT_LOW);
+	gpiod = gpiod_get_index(dev, NULL, 7, GPIOD_OUT_LOW);
 	if (IS_ERR(gpiod)) {
 		err = PTR_ERR(gpiod);
 		goto out;
-- 
2.39.2

