Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D057030F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241994AbjEOPFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbjEOPEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:04:39 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AC5172A;
        Mon, 15 May 2023 08:04:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGP2SbIwblZ4ivgF/qejU+e116y5+zrL+FVsSRmb5r8T8CgA2at6Dr3AJtAy5N3AmX4LO+nopd6uPtrvn+QadEte0mJa+sMcYbiHblJS9lkR64EWCj07pjGb+3Gyje5EEhYKACREtDyd9IWTP8gZLUaRkwrSLoTM0LlhuiJaoTJI7SJ01m5Y6aTtu8T28JIc3Q6ZlLtXcM2AqfPiZ8n7Ef66T5PL6sFaR9v5HHezQHsNzmihMRqkuUoRG5KWMdYX87EFyEk84asAxoDsjT++iOSa+JOf+uc91jgeZNHuEo3MOfyI4AXlndzKPOaKehTlyAQ20XOd/lo4Wm550vFkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDIbHt+GIdNrdOWSe2pZSzaoc3EgQgnGfKLokJlxn5o=;
 b=VF6PRs8ZL9dPbQJ8cAuDzWsgX+/4vP22yhChlF7CaOihYuw9SKKO0w7ctyqKwL7mno8mVCLGvYXGTjuZW6dJyphuw1v5z1IzYNnIGW3erazrQI8KZOu39KS03Tg5RSdYRFJ7YswlG9ruExx7ynnQxj6SIf/wiLYNsBbndVBTfYyeCVCrQRX4R9HYCiSTQ5lBPL9N4FS6Nke61S/8LeDIPu4elw8zt1qw6PMHoWkeYqFVyf5aCoJ9V+4m8J0NRybHmoF0sMR8Wxm45R0Jy30fO0MGdNwN3CavtAcybQdTAUC1BnkaQk8esbhq2rNB4Fu1gHWKDt2R7uH/qPOkn6tGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDIbHt+GIdNrdOWSe2pZSzaoc3EgQgnGfKLokJlxn5o=;
 b=dz9t4681s24Utkwx6fpJIFkP2yoE9nLKPvF3DRlpYrPj7HKXcwOQtGwyXEEd8NR9M4IKZtGFtIc0VLG988zteaHbJeF/zR29SAiY80uu33qHDzFjyUotm8Xo04tKe1ZvC6izbiUxllB2YDQP3US5uuUyyEJjlv65Gpt+XD/sH06VEjYqM86GcIWrsho3A2D4oed+k1ykPuJWcRkDQE83OKjeJ1lZcIi7AO69Jv2B9q/i07CKnBtLJZaCLhwJ4o3qKrsHlp061Egw4H8wys8ZvE2KqvugSYncGBgWhncYPrj6WfpaGQDAtcHU/Z41CpNDblaWRhMl7HKdGLhJnfR0cg==
Received: from DU2P251CA0008.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::10)
 by DB9PR10MB8194.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 15:04:28 +0000
Received: from DB5EUR01FT030.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:230:cafe::75) by DU2P251CA0008.outlook.office365.com
 (2603:10a6:10:230::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 15:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT030.mail.protection.outlook.com (10.152.4.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 15:04:27 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 15 May 2023 17:04:25 +0200
Received: from localhost.localdomain (167.87.0.30) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 15 May 2023 17:04:25 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v3 3/3] leds: simatic-ipc-leds-gpio: introduce more Kconfig switches
Date:   Mon, 15 May 2023 17:03:52 +0200
Message-ID: <20230515150352.30925-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230515150352.30925-1-henning.schild@siemens.com>
References: <20230515150352.30925-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [167.87.0.30]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT030:EE_|DB9PR10MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d936c4-e5fe-4983-f5c8-08db5555ada3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbO+POQZ41JYCTgk0hHjEPh/vVz9cy2rDRBcJLd9LwlrSOD1mou5KTmFYpuTk3Q3wyGhzvvJZrGjlb7ME5f4XPbRSbPiSypgha9+F1PEeBrir9+UZnO0w6gNKs+pv/wXL/zbqb/jwW1Rm8FBBbTiC7GamZO7hyX7Nsd6Mc2xjaL3ewrt1NnO7+l0Y0rrBgnuWVHu/bYn2F+qWWBXUvR8AwT0HPYo9zX0o+q6QMKm/aig5ysMnz1YOB67vB/Y4X2RdOhuEPeyEPNeJnU7g6j24NvBHNNAMV5zye+/cAjNzgL5VgGOFrPV0TPtXyObGWLjxFlDhUulm7BH6y4+NuNv7MWwG/vNfxvccUGbUohZOTgTGZFMpLIPq7fZwgPkPJwlkAXu5+FJJaNxeHrw+gQHfRiGqXds97ibG+P3gO+OjhWOvBDF9QgLX+anfcj6VYb8gKbW1IRbxBzGLiUy3OB2SGE7YQXM2crERcCscd94qb5hyVlEfmQ/3OhfE67clBPFNedK4FryLbRlCD5Z3Q0amZnsfSTLzTaMVDE2YbKgEFc9Bgi4ZfvV8xuMrHyJ16/bawipHUYlDmlMAUDjiKrXGNTa0/vSn749ikugXivJ0lQM+Y26cFspdkDO0ZLmp2s/DISLoGuLFVP+5CPNOU51E9iIoS9oY2in6pXhVJFjynBm8IvSzj3D8jvMNPiTYj+FtUxue+IMIi6ofhtsnDcdddsAzT3QjoXreTkfNQNXm7R0hKYigqUKgAGZi5dL5+sfrYw1zUWi7acy/SvS1KchiA==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(2906002)(316002)(81166007)(41300700001)(356005)(5660300002)(8676002)(44832011)(36756003)(82310400005)(8936002)(40480700001)(86362001)(6666004)(478600001)(36860700001)(336012)(1076003)(26005)(107886003)(186003)(16526019)(2616005)(956004)(110136005)(83380400001)(47076005)(4326008)(70206006)(70586007)(82960400001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:04:27.6060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d936c4-e5fe-4983-f5c8-08db5555ada3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT030.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8194
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To describe the dependency chain better and allow for potential
fine-grained config tuning, introduce Kconfig switch for the individual
GPIO based drivers.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
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
2.39.3

