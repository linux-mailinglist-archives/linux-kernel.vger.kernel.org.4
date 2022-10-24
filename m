Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DFF609DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJXJUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJXJUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:20:47 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe13::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C0E3D5A5;
        Mon, 24 Oct 2022 02:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVnBG7OWWHdPWDmKbbz4vSJMdzSdPCLI5y1O2da5jKKPU0laDapIauvPy7N6w8hMYFqsTvF9+jHSmUZkcFJTRvreFgtJWdZuM/XJW6Mqk63CFcP6ivXMSeqlGESAtCx+16sN/6UFgZbYi6Y4mhjTw05MXBN/ITgFaBTLoC5TyyzccKe/mVQjvegkS9NBcETBch95bPcmmnDuVQMLXnBTdLhDblQu85W5F7l2n60k/uyqxM2ihEYi5UlkHyAZ7YcJ2vFCzZM17aFT2qAFK1wMZ1oItkJopvNO5Chr2fLUoPPoSbobBrOI5F0tK6hASMOW7Q1YaC2ylUeLURR/VQIyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEijFTHbAt2hdGX2uemfZRjapyryS2p9YuqJAWCpodE=;
 b=Gr7slIGSJQzuE64/IY0CXVdtxsT5n/D7drzoALs1JdYN3ByV0oPz9bIy0Ynqc/PoEbNy76xSJD1bl1efkbJnLzHNT7q570ILZ6QD+JIRAc8QkVA7GoVlRybIegKJNdzKKo0BD09PoXl9Jtcp+on500RG5ZjivgtHpcbc4F7eal9Z0rKoLTtkfAdpiAceA+RZAqTL+KhlgYQ3BumKdLqoZbnpYtDNr/bbg1LyQPC5bKZ2r2121PwqQQfyZQNX7XeBBc/HumTc5S8RlLXus+NrgC2rTVWPINxSFORcwgIqJj6pj9mGQRqNgP7AjSAtdIR0mab3wW+IVEEal23pT48vGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEijFTHbAt2hdGX2uemfZRjapyryS2p9YuqJAWCpodE=;
 b=TBZNatw/uhjnhZoxC7CqL9W5nfDRs5Fk+VIKiUTQJkEpVvyb3RpvoQUVJG8s0e5zAOmnwXzP7TJ3XYlcRZuiHgLPCsoQU5mThskAENGcP7XqaJXUjMk/OBPJC5w1gfvjRTeh0ofgTsLHqOEoGdFDRFOokvFXR4welId3NEcRTmp7JQgCCBdnwpBlLojQBquuX/Ijo3VzlilWPMZlAgJn+46EVrv35rf85KWgZt1A5JvbPbXPAMpGznFwdfgshgB7jE5ZN3tC8wLpqS4OLSsrq84rLcyTzdT/4OSDyUzcCS3lvXGWos1SOLXGac9VpjT0i+uqMuGKhHklXAMMTVpFUA==
Received: from AM6PR10CA0058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::35)
 by AM7PR10MB3608.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:134::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 09:20:39 +0000
Received: from VE1EUR01FT079.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:80:cafe::11) by AM6PR10CA0058.outlook.office365.com
 (2603:10a6:209:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Mon, 24 Oct 2022 09:20:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT079.mail.protection.outlook.com (10.152.3.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Mon, 24 Oct 2022 09:20:38 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Mon, 24 Oct 2022 11:20:38 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.68.172) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.13; Mon, 24 Oct 2022 11:20:37 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        "Lee Jones" <lee@kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH] leds: simatic-ipc-leds-gpio: fix incorrect LED to GPIO mapping
Date:   Mon, 24 Oct 2022 11:20:27 +0200
Message-ID: <20221024092027.4529-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.172]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT079:EE_|AM7PR10MB3608:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c577978-4282-4a17-ab34-08dab5a103e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MM6xAkkKwbOQUynEZL9EkosRhDqvHa8hc1SIjQauME5WYzjHGh9GVH3g6q0VdkMZnsaRtDRqhKtRUB8xvz+IdFozYO6eev0k33ljOZyPpepjPi3q0G/eX/4dFR9df7Sj4WLL6eLj+XPmQcNrngCSoSfL6/Yb5/wYcHQi7VmauEjfBKbFyr9e3dZgoIPfHxTBRCSxYpXvfqPEwzYXzZVhdjzbat7OJw+vq/Mz0rXoWQXtaK/7gaMJT1xa1od6J34RH5qRvW1GMOrOdfruxB5Ijm5AB2z/9xYbLKiY8RS0agVIyL3RBECnryC5YNXh1okePqAe1hcli58n8BTX7xCCqqIrgmVfa6YEoJa7M3m+LN+6FxynLamr/+NanDSJF4Y/EE+bMRcMq6AKfy3twYDhLcgY6DxFLXYt512sqK7fz2ZK4TIf+XJKcoLCRwbNGRDGJdOP13DD7FWhNZn34ksXd38xUTw1hsUljMdGgHg592zrSW+IORSKHtTOnhMPOMiWQHhhfecQFhQ3IHjVpaRNz/BRwp3NYA91v0LbzdDLHggaNdurteA5vSOzlhnDoXSQfDLC+hdsB1Rit6NJELGMBojtkIecsZ/me3tM3DlEPzUdHF0oIVHzDujOxpAXa50rK7biqlOcBSwVPnoBpGwwfMvYakSK0rjw3TRkQZ2IaF8Kg21GxbtRpIfMPQU853RTXkJnimLFm2do/zcsfVqp1YkaEewNwAFF/ZSteZTpWeMT4KTO269WQJi395NN6XY2ietXYF3s9y3pHWs0cH5ZXVULL2NQK0CG/g1sbYaWhxYSu0ZsjGKC2PVk6Ad7SFXZlHp33dnXQEdsLthPbYUeDg==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(41300700001)(83380400001)(2906002)(82310400005)(82960400001)(6666004)(82740400003)(110136005)(107886003)(36756003)(1076003)(316002)(26005)(356005)(2616005)(16526019)(8676002)(81166007)(47076005)(70206006)(70586007)(956004)(186003)(336012)(4326008)(86362001)(40460700003)(5660300002)(8936002)(40480700001)(44832011)(36860700001)(478600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 09:20:38.5295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c577978-4282-4a17-ab34-08dab5a103e0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT079.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3608
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For apollolake the mapping between LEDs and GPIO pins was off because of
a refactoring when we introduced a new device model.
In addition to the reordering the indices in the lookup table need to be
updated as well.

Fixes: a97126265dfe ("leds: simatic-ipc-leds-gpio: add new model 227G")
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
index b9eeb8702df0..07f0d79d604d 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -20,12 +20,12 @@ static struct gpiod_lookup_table *simatic_ipc_led_gpio_table;
 static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
 	.dev_id = "leds-gpio",
 	.table = {
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 2, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 3, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 4, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 5, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
 	},
-- 
2.37.4

