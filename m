Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FD970F6D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjEXMqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjEXMqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:46:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A259E;
        Wed, 24 May 2023 05:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7db8Was0sy1QPANP+NYgLAGWSwLsrztvwJFWC5/IxME88dhFxW/okFCPe06MTtlFPjX2OdgHXOwYQdDMXiSlrjLH8KwZAWzpgDFjQEqVcjuL+ANnBgW8jYcL99ieHtGcT3z/768LCS+dhw/NPRSRdqR+CnB4b77cZGfHHw4t/de1AWPaAjRaf4N4RVhURpJCVWzl5SP86KtLnVdxHo1U9HV4z5cP/+Gxs9stKI9xBu5lDk9J2uthXiSI6Tr0VTqp+xgn94K6pEmWsrbLVuCDXnoqKvfGrFmw3g+MQUJHjC1BSEQgAGJR/9JbTN1zVibMp9VXiVb5i4TXvplh24baw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grjLN1PUkCyJ04ESW2GNFn2aZS+qEMjnJxxslmSTWfI=;
 b=O2K9gKWPkJGrZigoNpiaymylgi/EqA2Fo039Csurh/tFDD1uw7Ikm7J001oY17TCflDJHG65DrNIxFNRcoedfc+QZRsa1aRgD0kKsZLin3QV2ukz2dhGf2xtO9BLvk20HyGPw7oDnDysADaUcDdMxTu9bEwy8dFRiO88UBUsmPJGoT60+CTR5ZnjIP3Hmfl4GEDO0KouXJXf66Qekzf2kiZ9lM/MgLN9kcN/9vQg8P/4X5rf8ThFBvwQ4N8pHsGAebl0kKWyofgaHvoK/CeITARGcgaOuYMzAz+dNUQ7B5cO6YtHdU1rAKqVUzGeHV6tEc1aX3Z/DRDILzl8mYde6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grjLN1PUkCyJ04ESW2GNFn2aZS+qEMjnJxxslmSTWfI=;
 b=u2N47P+xlb/YL8+gaNNH1jyG8p7LRgngWgcmtTiuJ7gMPKbE2KjE6mvsrSWXMo75Wo5/xqzXOmnJ6IMGin9Wkopd9FnCM/B3l0sGH4Yh3GfxJ2cQ3xCoElwpKbbE7ZbcJDNY+DQ2JzqHpNe0e0fVqfR2E408891iQm40NhytJvA6CFhOKcSYGyhUpAdy6+IyADsjDrP2ng5hmfOVplrMtcOhstPIr52qqsCUBvv1eeP9ypf506mOOjSrjJRIRYAl5kyRMnKpQpQZZZ1/sF6pE4F9DCPD59HQVM0oOytVd9YlzpJJA8OUJRfRVMVDXjKbs/DgcfriZvMXWSntY18Kug==
Received: from DB6PR0802CA0040.eurprd08.prod.outlook.com (2603:10a6:4:a3::26)
 by AS2PR10MB7981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:559::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 12:46:41 +0000
Received: from DB5EUR01FT061.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a3:cafe::b1) by DB6PR0802CA0040.outlook.office365.com
 (2603:10a6:4:a3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 12:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT061.mail.protection.outlook.com (10.152.5.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.15 via Frontend Transport; Wed, 24 May 2023 12:46:40 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 24 May 2023 14:46:40 +0200
Received: from localhost.localdomain (139.22.37.129) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 24 May 2023 14:46:39 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v4 1/4] leds: simatic-ipc-leds-gpio: add terminating entries to gpio tables
Date:   Wed, 24 May 2023 14:46:25 +0200
Message-ID: <20230524124628.32295-2-henning.schild@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB5EUR01FT061:EE_|AS2PR10MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 1981629c-ae61-42e8-af32-08db5c54ebf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RJ6YRkcytnyo3PfCBerEShoq6mlOSTC8+RbQFhtLNvWcWlxRWXY24Ja7kb1KIW1OobPH9JwZQZ/2u3a8YPdVboHjQ76lFPAcQM6dNU/CmAyqWnVOq1TP4qWTzJPwSH1z2fotHuH+LH6jmRo0f85SI6DcYFFctIIP50aplYZ4LBDr4sHiaCL0BTF508a2h2Bii9N0KsQAcg9rxseX+dVdm7kmF7lkg6ZZ79JkktQRkgfgKTfVz73lDwWcp01KPw+Wa2dmjc03W4i6Q2zh/BBFicuwRIc3mUlmXVeHugmQq+YhOP/tcKjmS/MHk3tKvIFbKrQHWTX8lhr+FxKFrDoAPP5g+bMjQVR5qvYQUdm662oX+c2sFzZk0aThT/M0YaRlgjH8Yvrr/yQF9wkWDB8KrfukxiUax/Heibs0EI7FUqC2zunX+SLrpYJDu3Bhmyl34G5PML8QQaZK0PWRLyiGBkF+PMW6HxiHU4EC3Vc6IYcMd/UQs8mRt8VmcNZ8kiettIz5W1dXpKTWsz3G6MO4rDy89uwLOR9kU+vJo3NF2+LkwnawWk5SoKPGcQ4viK/0L3BpNUmXTac74DywMFs3op89xWoxxBSCoEQsW/53YnZvN1ZKNAneTeAvIggo0bFukyTBrasWi4mJlsDwI+O2YrWXP3bx6sPWvGtDw/COVjJlX1ypljs8489d8JFMes0gp2xYBZvDoPxAxiobx/vIXmHjQXLE9UTfxEJfTAOR1lgM9OV1XXEeMmdUsmjwGgrGbD437g//RHB/nGT607Oow==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(5660300002)(8676002)(8936002)(16526019)(186003)(36860700001)(47076005)(86362001)(36756003)(2906002)(336012)(2616005)(956004)(82310400005)(44832011)(356005)(82960400001)(40480700001)(82740400003)(81166007)(1076003)(26005)(107886003)(4326008)(316002)(70586007)(70206006)(6666004)(110136005)(478600001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:46:40.8033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1981629c-ae61-42e8-af32-08db5c54ebf4
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT061.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7981
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entries do not seem to be stricly needed when the number of entries
is given via the number of LEDs. But adding them is a safeguard should
anyone ever iterate over the tables to their end, it also gets us in
line with other drivers that register "leds-gpio" tables.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
index e8d329b5a68c..1a1cfdad6218 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -28,6 +28,7 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
 	},
 };
 
@@ -42,6 +43,7 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
 	}
 };
 
-- 
2.39.3

