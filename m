Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D796A71C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCARCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjCARCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:02:45 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B168C497ED;
        Wed,  1 Mar 2023 09:02:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3fVsPezEqXoNYFsG9yjEiUeF1rOqqPWtH4T3sWmR4uvdJuWLtPWlC983SL7MavK4df2n7r2y8A/J2yr9vv2/rHBCjTo/7qvJeoq6j6EO0xkl/XBG5xXQIDGUpXBJxWEEGrEj1h/nt9pcqDaCz3W2IZ7WeNHYc/upYH0VSQo5pid8U9L/iRNT4Usb/8dGOBLP/PC0OG41yjELdYaLQGB3u8eTSav/fvF6LpNiuaU+wJGlhZVy3td01qfQEF5vSH3p7IejeTlmMhulkKPW+YPBoDJUMACN4nxIqLIAUCNLjqzXhwHek08YnT+6R+KEaIcc+m6XEq1KR+vU4/LqDdz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yplmJNAmyPBCc3MOdaK8D9T/eu87oU3GzxsBtPy7iSE=;
 b=ls8du0lxli1P3/0l4SWdmhERJ8SyShESmZlxoR/mln/xuBEYg5wQHyvywoWGJD75EiZQVhUn8ZV4TG2QaRPw1FnxINsnn97a2xAMgrHvlYRljFwGhxNtw+Bgf6ACeHhKQ+F7h/o2A/qDwQfgdJQNe4pn2drZSDBiaYxf2N5HFHT1vxGFYKRe7dGR8RQ/dTj6NCxk9OTGQEBavcVAAyF6mmA9qpqkg0FsGXeBdoUVPlkf0OWK6/S8e7Kj1wbj5eS7oyoCPTUdf9YNLFWIjbdSLF8S0pQhi8VHJDDONYYhQZUy5WzC5Gy9Ris1X5VmzeMau2c42K5HBpWejU89t4ir3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yplmJNAmyPBCc3MOdaK8D9T/eu87oU3GzxsBtPy7iSE=;
 b=sfkQGmwl9OXVKgzdB4tFO2aSvcTT9o/9nO4H1G1lpe1bme8txE4Ugi1dQcIQA3UZpK1GyHzHp7EOON3AeL5HHhHxBuE0AmOcwAePbOqqjUQ8yxDQimipWAlYckdrVV57OmmYQExTOldMB+8u1DJ3QpLLvgC4HVYLwM2awSFQ10FGvKsMl2r9SHyCB+DpCgeYo1li5wq2MwA+VqbpxPZVlGDAf/m6U0Opm4LwixXKJiffWgqadxVqx0QJl6nCYN3+JOZGRqIPJ0ViRE4bdskHvvHAOjW45aJGb/rqmS2HH0laGxWGBvRnmcqK8t9aPvY8V1BOseXwiZD2bq4PWTMopg==
Received: from DU2PR04CA0215.eurprd04.prod.outlook.com (2603:10a6:10:2b1::10)
 by VI1PR10MB8133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 17:02:39 +0000
Received: from DB5EUR01FT102.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b1:cafe::5) by DU2PR04CA0215.outlook.office365.com
 (2603:10a6:10:2b1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17 via Frontend
 Transport; Wed, 1 Mar 2023 17:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT102.mail.protection.outlook.com (10.152.5.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 17:02:38 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 1 Mar 2023 18:02:37 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.0.120) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Wed, 1 Mar 2023 18:02:37 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 3/3] leds: simatic-ipc-leds-gpio: introduce more Kconfig switches
Date:   Wed, 1 Mar 2023 18:02:15 +0100
Message-ID: <20230301170215.23382-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301170215.23382-1-henning.schild@siemens.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.120]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT102:EE_|VI1PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: a744ae1d-a67b-4e66-c7d8-08db1a76c307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZU2ePE3aF0wAa4QAfTGJxmx4xXIO4Y7tmoegiaT+okc6sFJXn5x9W+jguTg6jjJEzy/wBXFV2IS4QEvPcrw3PT1pGPPFusI79EhtcPa9SMKoWiRCGoh0bLBdbiCcE5VGRu2JnqXoNfyfz0kppT0DfJd4SGUe/p23pbot7iFsk6RYxvFwBWkuMQNehSwrJYtQJr2SfpwVswMb/NgycIG1rGmNo6NzReUL0Dc3Hs9R6fcAZPnq5+41NMNZ7kz9/CXjAK4/2lpejPB/80ERXLsEw7G342hHI/52CE38mYndwlj6QNQCX3FrGDSD7mu7cmfVP1VBIHYEK5WWEUKphKzOtlMle+IhSUTU7NdA6ZtJf8JBWrBAM9nXzHoiyH6r/Qd7Fkxm6mJxuzMezeRpSMPnVZUBuoz0rzV2+4rY0tVvFoUPPbOOdm17QgJRKDGi+cqk4YHG+4ZRpHjXn8nXX3b6H/PM149nIyIljW3j18D2bheEQE85AD7/vrV3KCc0h/fBfsuGQ8hmMAfAF7yr/rgtlSNYumeez/7W8HzpF4OAH0s8XpyW68HxoukcprLHylawxYHwp8XAzEXf/3CgmBAe/ZxHcue4Eqp47cdSr+sq2drb5jdVF0NYeJKN/L1BXEybyo0GKJ6HiAmuC4pbQCf+dw/IK74wz28/Jmi0fAv1ko8+QB2X+M4pHAsbiaCGlYe5mKXD0HvXz8BoZTzz2w15t5wsXN749UVAfaJbJRa4Y4=
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199018)(40470700004)(36840700001)(46966006)(86362001)(8936002)(5660300002)(4326008)(44832011)(36756003)(40480700001)(41300700001)(36860700001)(2906002)(82960400001)(81166007)(356005)(8676002)(82740400003)(107886003)(316002)(478600001)(6666004)(70586007)(47076005)(82310400005)(40460700003)(70206006)(83380400001)(110136005)(1076003)(2616005)(336012)(16526019)(186003)(26005)(956004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:02:38.2806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a744ae1d-a67b-4e66-c7d8-08db1a76c307
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT102.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8133
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To describe the dependency chain better and allow for potential
fine-grained config tuning, introduce Kconfig switch for the individual
GPIO based drivers.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/Kconfig  | 31 ++++++++++++++++++++++++++++---
 drivers/leds/simple/Makefile |  7 +++----
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
index fd2b8225d926..44fa0f93cb3b 100644
--- a/drivers/leds/simple/Kconfig
+++ b/drivers/leds/simple/Kconfig
@@ -1,11 +1,36 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config LEDS_SIEMENS_SIMATIC_IPC
 	tristate "LED driver for Siemens Simatic IPCs"
-	depends on LEDS_GPIO
 	depends on SIEMENS_SIMATIC_IPC
 	help
 	  This option enables support for the LEDs of several Industrial PCs
 	  from Siemens.
 
-	  To compile this driver as a module, choose M here: the modules
-	  will be called simatic-ipc-leds and simatic-ipc-leds-gpio.
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-leds.
+
+config LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE
+	tristate "LED driver for Siemens Simatic IPCs based on Intel Apollo Lake GPIO"
+	depends on LEDS_GPIO
+	depends on PINCTRL_BROXTON
+	depends on SIEMENS_SIMATIC_IPC
+	default LEDS_SIEMENS_SIMATIC_IPC
+	help
+	  This option enables support for the LEDs of several Industrial PCs
+	  from Siemens based on Apollo Lake GPIO i.e. IPC127E.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-leds-gpio-apollolake.
+
+config LEDS_SIEMENS_SIMATIC_IPC_F7188X
+	tristate "LED driver for Siemens Simatic IPCs based on Nuvoton GPIO"
+	depends on LEDS_GPIO
+	depends on GPIO_F7188X
+	depends on SIEMENS_SIMATIC_IPC
+	default LEDS_SIEMENS_SIMATIC_IPC
+	help
+	  This option enables support for the LEDs of several Industrial PCs
+	  from Siemens based on Nuvoton GPIO i.e. IPC227G.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-leds-gpio-f7188x.
diff --git a/drivers/leds/simple/Makefile b/drivers/leds/simple/Makefile
index ed9057f7b6da..e3e840cea275 100644
--- a/drivers/leds/simple/Makefile
+++ b/drivers/leds/simple/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)  += simatic-ipc-leds-gpio-core.o
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-apollolake.o
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-f7188x.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)			+= simatic-ipc-leds.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE)	+= simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-apollolake.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X)		+= simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-f7188x.o
-- 
2.39.2

