Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049975F61C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiJFHjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiJFHjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:39:40 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2048.outbound.protection.outlook.com [40.107.215.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1948410DB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIm9AVZiPYlUogFsJ86dF53TnMuwg4fNyAQCx9644paJuPcjB90YfJg21rDHUIrxCe3B2baC/m+zEZwAbnk2VUftIi1gHrWXQXfNmeOc8RfyHtD1VQY0e0Dg4XCBXpkcLl0IYMTkRzIOQVO3CmEhHAtwQJY2u8Cax6+8vwcoHIgB7OeIdWRnR7O0r02ddYtIQ38pX4pDG8zSOnWwIFUjw3SasnBtuWHgnCYYMOR/StL6wmxwipAC3AWrpQ8TqHjLKa3gUF+z+jsnwH3DA7JCfHsuwBxh+RRW+7ZKOTeN6Ape6m7Yui3amfb6bkTYwpiELMtHwY8i0g3dxwY4zyUfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEhfys8WyLik2IG5wuweP4+UICMjWC7PBzvNuxx5xsU=;
 b=W5WybXDvv+LZqnolamvLrw7TqG+Iyg6hD/2I6MP+rCT2Ae/AbMNgJDLvg/xkzLzOoFtoPwmysoF4NQxTP8pvc69EKuUcQP2XVZ+1uwT2sLN9/dAr+Sr8QTyYRdj34tlGbzrkxoNDwJSd8s2URGaJf1xq4P9aDV3xOGzes71+0pXbNCauDX/HkqkBopkmyMkN/lntQ46ctTJoh2ixbuKo184kCBn1EH9auFFZWo4vhE/l60Zzi5jV3bBnBw9CcH38Ey4mGDqmN24H/wLtoEjycWQ/OdFJypNT9cjqOYGiwAfHpY7UxcMBAYRB2vYppwPF0lD14K+dHzhyw6tCaCgnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=lists.sr.ht smtp.mailfrom=wiwynn.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEhfys8WyLik2IG5wuweP4+UICMjWC7PBzvNuxx5xsU=;
 b=OyJgeq7+hbCU3zhllsfJTkhArjtpEnoyUF1AAF4wq3Z82No5Oh+HJzYoI1zBkca/0SBUvojJHWqY4f1hqxJkRZeQk4Q4BPULWATbHKTrPVeiXPOAH4hJCQPeArrbpiYVOC6vBU9PZQCZn9n6n+gKOhzsAkTzvvbUF9HZ6pH6YCpT8gDR2ClSm/dgstU4DfERbeIeVh/lO+QvrpckJzb6t8eeGKzDp0VK3cruKcLhVPfjDUM3mP4CJjxxZl2JvAE/RTcF+XjdUY4OaZghnNq9Yp4N2ZYiRwpXrqNYhFDfHveTpdxiUVgpaLxUDUC6cZtWwz2rzDEMSSYAe//KCtbF4Q==
Received: from SI1PR02CA0003.apcprd02.prod.outlook.com (2603:1096:4:1f7::20)
 by SEYPR04MB5833.apcprd04.prod.outlook.com (2603:1096:101:83::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.33; Thu, 6 Oct
 2022 07:39:33 +0000
Received: from SG2APC01FT0008.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:1f7:cafe::4a) by SI1PR02CA0003.outlook.office365.com
 (2603:1096:4:1f7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34 via Frontend
 Transport; Thu, 6 Oct 2022 07:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=Wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=Wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of Wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2APC01FT0008.mail.protection.outlook.com (10.13.36.114) with Microsoft SMTP
 Server id 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 07:39:31
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
To:     ~sircmpwn/email-test-drive@lists.sr.ht
Cc:     patrick@stwcx.xyz, garnermic@fb.com,
        Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: winbond: add support for w25q01jv-im
Date:   Thu,  6 Oct 2022 15:39:29 +0800
Message-Id: <20221006073929.2223225-1-Delphine_CC_Chiu@Wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0008:EE_|SEYPR04MB5833:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a92df5fa-4c57-4b60-dc00-08daa76de8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEPM7blM5V0to0QCswlMwlZA+9OeMA6di764P5QHB4QMXzDuLk3gtzdJHoo5eHBIQXkkBjx0LfJnNPaY7OcHtTr2U5qz7qa0sRN7ire82J3yFxoqDb50J7TO+O5USrqjFbChovHWybGNpXGK4559SlXmpK2aWSqLlgpuLLXpQC0OY4sprVGS/P7NiEwfs/rs/rrTjossd6swl/ZKkJwFpagDQzIW8++WGYJ3p1cJu48R1dVhRJd3sqCJ1yurFlcve6fl0fbg0V9eRKojNlWLWa8HcCXFIhS4ff/ctj2Qa63RFv5gWDRQr85q5CqtPeZvmXmC+TpeRRSif33yuWn87QrVWvt/KdkuTjR7t72v2/0+G0whporq6061tgVtYoNhwQhOWNOqaU5ygRE3lDDPUgI5DUW/HV+Kd8/+h+X/w0cU7JA8ZCGncTl/3CAPR/kjZrh+6hTuCyuu7MnNXPT1YilC12/4qA6dAEStJzct1mb3exlFp4hp7YLsIWNVquJxFcgWEpER1bmST0QeurEcAg84wBaWyROfA2FnN8ikOF5ZJP4e8m55W8zwZPDfvTvrQ2Beos+G1qoQB0L1S9+qhpZZRz54jsR+Qb7vXzNDO4LFbK9JrSq5usx3BwxBhDiEtUUuzJ8PuqZILereMssqzWo+FZCzozcjqEDfXDAtMKXLBoH3cAlvKWD0dYa8KBqPA59Lgpcl3k19MJ5U812mfk1Ur8fi+QImCXvHnWqPHnQ=
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230022)(6069001)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(46966006)(36840700001)(36736006)(36906005)(26005)(7416002)(36756003)(41300700001)(6506007)(4326008)(70586007)(70206006)(6512007)(5660300002)(8676002)(4744005)(8936002)(82740400003)(9316004)(36860700001)(82310400005)(54906003)(356005)(40480700001)(81166007)(2906002)(86362001)(336012)(47076005)(956004)(2616005)(186003)(1076003)(6486002)(478600001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 07:39:31.5814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a92df5fa-4c57-4b60-dc00-08daa76de8c7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0008.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5833
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SCC_THREE_WORD_MONTY,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for winbond w25q01jv-im chip.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
---
 drivers/mtd/spi-nor/winbond.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index ffaa24055259..2b02b05ceb0a 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -139,6 +139,9 @@ static const struct flash_info winbond_nor_parts[] = {
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
+	{ "w25q01jv-im", INFO(0xef7021, 0, 64 * 1024, 2048)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
 };
 
 /**
-- 
2.25.1

