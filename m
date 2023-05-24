Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C31170F6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjEXMqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjEXMqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:46:45 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E809C99;
        Wed, 24 May 2023 05:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTkpBNpw1lhOuVVd6LfXkn+rP+FP14UnBW+sVwjoJgzPRsH7/YeDg+FZ4imhdSyOeea89DnPqjxFWvDwQwV+3ibaM2O001I7mVWjc3zALqJLCVIwtsPBoZ6HUIrf87JFiHme3PjxE1grtOhjJR2d8RB6I4X/dsPsYhgFksa+Ft1A2+1UpTEWNUE0gCCUW0HAXrEG9+/UE5AxoejMGPovDmOavIdhCp+VokAQ2Ob6kJIEjd5jEeuK97d52mWDqfVuiCR6bjY/k7kCsa5ynrTKXKFm+GAD8Y1Q9C4kPKxC/Vd9omvlqP3qclbGdC9k+dAWEe0HfnFe4VzDmM6d2R5E3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh3TbW4YErS+bBUZE1cA52kD2hjgiMDDXP+wCSGt0C4=;
 b=ndWZWKuaEm0iiGLMSgpCDNEa1WM/JU+tH7F28yZTUhTbuJqcVPMfDlvIrYXEmzqNfIXuuJdWV4VZ1Z6jui/BSAuvEm9h7avHtWQ85Yq5DVhev7yDkhCawOBI0aOPx2BNa2tFencg42OfiCs+z+O7OWYa35c5RoA6CjsFZVU7FY54Nxptan3JhNcF48NbZl9lGulbR34tp49LkZxT/TM39QlQXv+Jqjm3WT3buCjOt9m6MrIKOY+I6kfCMMcy/GUeV8xOa3BeKfKJf6qUUBkKP5XmCY6b0Y5djLR2wGvB+6of3WIq/at2dY2KdByGdqhtqTPqQkD9a/Mhbm7mAezYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh3TbW4YErS+bBUZE1cA52kD2hjgiMDDXP+wCSGt0C4=;
 b=NhajjtMEJSeGN9+MBpr1kqjNkP6w6XTF1tymHC6rB/QC5F2lkM5uS20H8nUKj1tACWPFRe/fLhxiKyqBkoP4ceM8SkU5LuDttajz5Ro1rdhisS0P2/gJejDs/R2YEHPY72MTCBfr3D8F2Id+yQI4luGxb9lvMFUtkHYEYrJsyvw5sJSSOo0YgnC7uA7Ih9ElpoLbOoBZ7YBQRiLJRHao9f13IuvxdqrCi/v5TA9HggQiAZAKQv0BjO3lE/yb4LDVcihlsBEt7tDmLTne0nBK1xRTONdkxc7Zijd2gMWVWRPKVDalzYjsJOJz0NHBBfyWrG6WlEmixydNtdb8EACS6A==
Received: from GVYP280CA0038.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f9::15)
 by DU2PR10MB7882.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 12:46:42 +0000
Received: from HE1EUR01FT095.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:f9:cafe::5e) by GVYP280CA0038.outlook.office365.com
 (2603:10a6:150:f9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 12:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT095.mail.protection.outlook.com (10.152.1.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.15 via Frontend Transport; Wed, 24 May 2023 12:46:41 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 24 May 2023 14:46:40 +0200
Received: from localhost.localdomain (139.22.37.129) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 24 May 2023 14:46:40 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v4 2/4] leds: simatic-ipc-leds-gpio: move two extra gpio pins into another table
Date:   Wed, 24 May 2023 14:46:26 +0200
Message-ID: <20230524124628.32295-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230524124628.32295-1-henning.schild@siemens.com>
References: <20230524124628.32295-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.22.37.129]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT095:EE_|DU2PR10MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd9f38b-c7e3-4357-3b3d-08db5c54ec64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQgwHxigQ0Gi+DRwIcl0hsym7SukLO3/TgLAy4UMrxHoBph1ed3HRQt0MobPxgnFqum/EgwJT2Bo3lt/jGeJxVwUPflLrzrQeKRDzKoxOoOvZoW9YJUQABFRBgr+Mc1U6lCY34lJJxiqgxmdkA5L7TOeK0/ravqwfzWp2xRTNaoOJegFkqIZkz0AKr+slZnLjmkFWmSGHfVKi0lYlkQLUcoUhjjmVnwYLPIKRQ9q2etH6AlqXRdMV8AJKslMGZTorV9VqRfkz8q2xQ6K4oXWFXz7QhNJhvowhnZk+HWi6bwmj+D41RscPKP7gGACJW49MZcpL8OH+hPgSAEXtkSIAfDeC0ZGzZ23Ffn4Bga7PLnYF29Z59dGzo1azMP99CzIjgsXuMHN3cMLdSmhtlzxe39Qxxl4N0YnKbyhjjNzGUzpZFT6hZ+zBxIngKfsuzoE3A+6VtJs11Xx/WV4cHbT32b/Coq5PBHl2CcSF+69mgU2opd0at3DzhvdfruEUIG91IbasoxX9WGB4KxmTbPVKoWK11zHfKLGfTdkRwj3+pbPpI584GRIgMcwgmZt9l/Yy4mq12Mkqxzi8WJFBJKo6w2dS7e+4SjTh8xtHIAxn/AFnZx2WzSYpEzpRC0ufNc8X98huTtXXYAE/dUPAyQEpK0OI0qxb6BoGsL9b+KV4VKaQngWC0c0H2Em760skwoF27e1wfTFPqaiuH8At45KB3Ehm5bZRkUtZtX7CTrFdCBkcsK+PxWiN+GikSIqI1Sf
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(82960400001)(4326008)(47076005)(36860700001)(70586007)(70206006)(40480700001)(316002)(7596003)(356005)(7636003)(110136005)(478600001)(6666004)(41300700001)(40460700003)(956004)(26005)(86362001)(5660300002)(336012)(107886003)(82310400005)(1076003)(2906002)(36756003)(44832011)(2616005)(8676002)(16526019)(186003)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:46:41.4963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd9f38b-c7e3-4357-3b3d-08db5c54ec64
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT095.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7882
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 28 ++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
index 1a1cfdad6218..0f1fde44e8d9 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -16,6 +16,7 @@
 #include <linux/platform_data/x86/simatic-ipc-base.h>
 
 static struct gpiod_lookup_table *simatic_ipc_led_gpio_table;
+static struct gpiod_lookup_table *simatic_ipc_led_gpio_table_extra;
 
 static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
 	.dev_id = "leds-gpio",
@@ -26,6 +27,13 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
+		{} /* Terminating entry */
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e_extra = {
+	.dev_id = NULL, /* Filled during initialization */
+	.table = {
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
 		{} /* Terminating entry */
@@ -41,10 +49,17 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
+		{} /* Terminating entry */
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g_extra = {
+	.dev_id = NULL, /* Filled during initialization */
+	.table = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
 		{} /* Terminating entry */
-	}
+	},
 };
 
 static const struct gpio_led simatic_ipc_gpio_leds[] = {
@@ -66,6 +81,7 @@ static struct platform_device *simatic_leds_pdev;
 static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
 {
 	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table);
+	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table_extra);
 	platform_device_unregister(simatic_leds_pdev);
 
 	return 0;
@@ -74,6 +90,7 @@ static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
 static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 {
 	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
 	struct gpio_desc *gpiod;
 	int err;
 
@@ -82,12 +99,14 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
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
@@ -103,8 +122,11 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
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
@@ -112,7 +134,7 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 	gpiod_put(gpiod);
 
 	/* PM_WDT_OUT */
-	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 7, GPIOD_OUT_LOW);
+	gpiod = gpiod_get_index(dev, NULL, 7, GPIOD_OUT_LOW);
 	if (IS_ERR(gpiod)) {
 		err = PTR_ERR(gpiod);
 		goto out;
-- 
2.39.3

