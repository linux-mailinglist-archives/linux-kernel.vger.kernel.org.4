Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF18F6EE4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbjDYPjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbjDYPjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:39:32 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2082.outbound.protection.outlook.com [40.107.249.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83AFCC39;
        Tue, 25 Apr 2023 08:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bszDpDRG6VPdRGLg4Ou0yP+QupOgEQHcjpoS1vOPdePNM7VSQrCsggK+rrQOTZ8xpIkxHZ+ZWebXVm6gFhuzGNbdVU4PbPBahrBnmLfvbP/tHIIQ0OagJ8FZiX5GjmSlUs159xl0BfIdT56DJhoHOuURiBlze3B6e2hVlCt3FZVH7FrhpKjlDhWevRWENv1ezXWROQi7oXF7yL7DhlwjAlpA+PlvmEYjeuw1PxPWPC63etdOLhEovpgeKasTUamqpIBWzUx64zNcSeLgAk621TMlgMCQcj97ryLX70MDYqZajQBqghU60N5RlSJKazHAuRXk9P1CwudSCV1mNh1+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZT+Blzf0GUo2dZxVV2YgwlGm5DWaCPm9mxoJDDNa0g=;
 b=FA1wm+b4/0HK5G4ZCDLLkrPVr0ozTfI0EgSguupEtcIpKYuoNbt8afblTrZ3NIqREfQqQ0ZWAShQjC1HL12/7agSuw7fTmR39jBiIq684RDAqhUNjypVSONE0XijYpQDnK03GicygA6mSdiwBTJaQ/zeZ8XUqSvSOa67J9Oi40FNFcfajdVCifmzxv/OISBEdJCvcz3j+z6LXnaevPmH4Y5GAxZKo11sA5/53a/K6biWR4G4BGosNJFTqzCVqyPXS63sVgxBHFSd48GijMqmpoyWJuXfP/IkLSD7OS4lvF//JLLlx1sPWRQgCr7MgqxgRwiFyZmAhvDFsTZXu5JH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZT+Blzf0GUo2dZxVV2YgwlGm5DWaCPm9mxoJDDNa0g=;
 b=FT4lvPkTukhyuQ8xtkhgTdl7I0IlOBgki8QPSeQKw39BWS1uVACXMBNdEeHrBGUPSM6HxtRSE/lPy2CjQfhkWTri42WRCJ/ztSRsDIV4wFtvmKtAm1sVmdD26E643SYSO1Iy6AveYhn7Jt52vjUe2tiY8UuYCQA/GvffdZMrO01qZuv6ut+fPYQW9ebZjFsBVKy/zvZprsNMGE3gcFM9/W6OJB3G4SCtc/+GEFSLCdQUcgK0O23q6nqUdXtQsfGQp+/rHoVHv6ccMu0D4XLReXwl0AHNdK/cibMJ+lzMsp3vgfUQtRJnm+Z9Vfjj6AktyFQ+E8Uu7k2UC81MS/e8SA==
Received: from GV2PEPF000000FA.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:1:0:17) by AS2PR10MB7131.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:60d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Tue, 25 Apr
 2023 15:39:23 +0000
Received: from HE1EUR01FT021.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::206) by GV2PEPF000000FA.outlook.office365.com
 (2603:1026:900::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Tue, 25 Apr 2023 15:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT021.mail.protection.outlook.com (10.152.0.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 15:39:23 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 25 Apr 2023 17:39:23 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.115) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 25 Apr 2023 17:39:22 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Henning Schild <henning.schild@siemens.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>
Subject: [PATCH 1/1] gpio-f7188x: fix pin count on nct6116d bank 7
Date:   Tue, 25 Apr 2023 17:39:11 +0200
Message-ID: <20230425153911.32135-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425153911.32135-1-henning.schild@siemens.com>
References: <20230425153911.32135-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.115]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT021:EE_|AS2PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: a73a2279-cee5-4203-33ba-08db45a33eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnwn1Za8tLO4ISq4HTtiOXEtic3tIG5hYl++g1ctfQmji6OTrnG62sSC6mO3ekbBpumQcmKlEZzHJGmGAAb2gdoYwxYv8hEcs0S9OnG6fLPBvszE3XuU86ig6N24QRo98A39En6gn2qqsan+yTcLB9CMo8wqBLyVVfBxBJB3S2ySlygeXQcIjLbc55IJ3wiEyvga/GD4BYXL5JRQB+OBkODfdqNvA50KMN94pBAyMGgO0jKwEKE0euf0p0ssZK9wLtfYWi8xyFkBqvJpaWCMxBRjRWbL9eizDOUm0xIpAt2e0UAQ3sRJL6X9GV+quI0TAKuGb2vB6GwtUtPis+BvHf1sBuGIKREUpYfkaOzZ4+jWXjdTuUuoGLieaYNPcARs4mlrX21PTwyxFLdi2a4Qz3SmM5WNF8UZRwqWK9DtcbR3pxxtINZRFwfiBMIjrO8+PRf9FhWh3JpoRCr8M5a3OzFVQt4/N+yBvrYsZK+58h1oCHDnLpHvNs7GN/imV3mXiH6vouDE61n8Aaamp3bXzgro/U6Cr2HdnAATsiKyJKuHKEdmw88b/ey+TctCz/geyn3OfiSNUgQFAZCwQfgpnoZpL1vad5bXIJi9x3XVRstcqGjBBV6OUs/AXE/81oFnxsIpiLthfw9dBNnYVDbCMY3AtGt0B7IeYtKr5whuIJeeRh5AO6QuW7XuEWeZTSdrXT/bLc4OosYTUa1hmuoSdt7X/Q3dBWxoBz4U4T7dR9o=
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(2906002)(70206006)(70586007)(4326008)(316002)(44832011)(5660300002)(8936002)(8676002)(41300700001)(82310400005)(36756003)(86362001)(40460700003)(40480700001)(356005)(186003)(26005)(16526019)(1076003)(107886003)(81166007)(478600001)(36860700001)(6666004)(83380400001)(2616005)(47076005)(336012)(956004)(82960400001)(110136005)(54906003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 15:39:23.5618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a73a2279-cee5-4203-33ba-08db45a33eaf
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT021.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7131
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The count was wrong because i looked at the wrong spec for the chip in
question. I now got access to the spec for that very chip and group7 has
all 8 pins, just like the other groups.

Fixes: d0918a84aff0 ("gpio-f7188x: Add GPIO support for Nuvoton NCT6116")
Reported-by: Xing Tong Wu <xingtong.wu@siemens.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/gpio-f7188x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 9effa7769bef..05c0edc4778f 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -282,7 +282,7 @@ static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
 	F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
 	F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
 	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
-	F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
+	F7188X_GPIO_BANK(70, 8, 0xFC, DRVNAME "-7"),
 };
 
 static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
-- 
2.39.2

