Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A3C749C20
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjGFMnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjGFMnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:43:05 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2072b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCE01996;
        Thu,  6 Jul 2023 05:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuJ/9WuPl3i685HGIwWCaj0iLAiduT3Wh/K4LKdIgQLpgB9KLRS5Bzo9g5gSS9dzhN0z3mMBGlePjs5MM9T8BaLqK6n5KPPZID3zmeckLIaHr0eSH5fSiA80jYnDHlu60nno17a4TwsmrpfgT7p3QL9NAPOwFd4aUd3agIGDCT2bLuIxjka/qQggeddMpellWHeyK0CQTO/Hth2CmmImWWjtIjyZY7pHi+aVUeo3XyqK2PSwDotZxNu/1dxErlTavdNzXof4VAWJDgYKId9uYwkxlAn2h7/GH9d7nvqCyNfd1H/HgiXcgPu6o6Hg114oacbbCJjXnJ/7HKbCl0xZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teS9tLIGRln+U70GtsJ4arrXFR+yWvS7ys/QCVHQ1Mc=;
 b=ZEG9V/9MzXVaiSUGxIJ37zKPj75vBuHRwtyTZvweBDseOieYe4K2bfBKJvhGX4hjdlk16pi9CUgipOfXP6D6WSsjF8eLLVl0HhJRvVyp2yEeaN9zzGh2xWQ5LrDg00SAMij/iqc7mc5lQEWsQfxhGRblWVki3gz17vcqjFj95+M/aoOH45NY7DtiHX78MiXlxsACrPBPR4Cvtn6v247gGP0X6QaRh8hcnM1zrw6mpHr4k7gUQlEfweJ17Z1zZ8e5gP9mlbTSp07BjsvjMPTBywCBT35CbQZ4eFQo00wDTZPQ+NQYJn7+k6G0dZrXP+6uzLFsKFbP7Wwdgh1q//5qiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teS9tLIGRln+U70GtsJ4arrXFR+yWvS7ys/QCVHQ1Mc=;
 b=kvM14TstwbuyGGaHYy4AELBJKSN87SFumGPvlWSeWQuM2WEzGhGmhvP87pTrkmp/iuy0jXJODBlb5AC3lRY69fUA4wuzpvnhxFkD9pM4VVMKgPuMDZA3KSAeQqDEmdF4pFb4hexGZbaJCFEx7GVG3kb8Eo1KC47uxQascYd0hIkt/rYB3qtkkEOH3VKkSPQepa/7y9P1JcjFNVlwuQ+3zfq0x5v77ELS0XGH1IavjGZWMSsgH6/bPK36e1o7n8Ivc3DCAqxqxcQlKb7juINMm52sQGBJYBVwC07TG/C4i4pgTl0IwFCCFr6uwGSpjXHUzr9rDFkiYFaHNPbxv8U/Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5602.apcprd06.prod.outlook.com (2603:1096:301:e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:42:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:42:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] pata: ixp4xx: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 20:42:36 +0800
Message-Id: <20230706124239.23366-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706124239.23366-1-frank.li@vivo.com>
References: <20230706124239.23366-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: c864341a-bc86-4c39-8f88-08db7e1e877e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AatZ4N7z+3lZ+X0UWQiXbPsKh1XTrAweYw4GSiezPr6nJFb12THvjWB/n3OlebVdzuMMhU8S2A4L4S0IxNxa14d/VtWvKOngPZvcKjRFdoeIYNFzJrGi4d4iplxU6eMH7H3gSxfOzwVlHmJX8Rd0+ucDt3R2XZLmTfKfIF43KQEnryzKbSjVZJiIVMZ1OOGjmpLkpjEjR9ODKZVe8HH00e3d0OkG991R2mIGT+PtB1hPo84GFuTkkLjQtL6iWweEQLkIjnNS19OjM3rDaW3jlBFUhx5Eba43DGs74sNt+mM4G3YLPoxDU6uKvc5pzjH1YQYCqfPTy0vN4ODPksNxButTRq+NTjWfPP+W2l/IfU/dXOlt5t77lQ7e6fq+VLdyz1oC82b6ry5w1C3ZPmkHxJVwXu8EQMO8pXysq03COLleQFMk4rZtLnu/qc4wTFssCX8zfRAfv4vYprVj60BLJkIqY4ukizzj0IvMJWHqD7Y57THsHUwY5/pvZXpfMbpqglE/C5d24d75Qo3jc01hri0hvDKnSHbHkYEdzK9soSfjLEgEbTFZtIRDmdeB+p0HPQc05CAJ1TjiYRzngHHDHBdpbs2TA9RcN38i1K26eiJ2Xu3Gt3wLiaRptfpsOZMcHpb/IN7FB1jk/ZFcjJCPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(5660300002)(41300700001)(8936002)(8676002)(2906002)(316002)(83380400001)(2616005)(66476007)(38100700002)(66556008)(66946007)(4326008)(38350700002)(6506007)(86362001)(186003)(1076003)(478600001)(26005)(110136005)(52116002)(6486002)(6512007)(6666004)(36756003)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0oEYGQ9ENyIzrdlzF9rEm5ViO8mAB+d8D0xm0FKp4lLACtzMvjnMLUuI1Epy?=
 =?us-ascii?Q?L9rZW/CmWiYMnyo7EjcGQiJeXSsoQEbdopxee7uCNGuVrdiE2HiT+23xuJRD?=
 =?us-ascii?Q?N5Q4q1DsJr/BKFwCuG3+MMSgskC7DuM1AtikDbiB4y8r/sRkhHlNt5Za5Otb?=
 =?us-ascii?Q?Z111BV46BInGk7sTJaS/E3JqDmYoUYXTgushzTu/gePgmEm04xWM5JHnPgPd?=
 =?us-ascii?Q?aS8jnNN9ZRd9UBFUnGMiX6FPMG7xscmy7vsAB9eOW6uojH9z46LV43s5Vwd9?=
 =?us-ascii?Q?99sSxBP+Pfyy7iAEK+soTDt9FxnKxTzclO7nxuTHjCxaG33zOXAeuQ/elut3?=
 =?us-ascii?Q?tWjj7pOF2VaARoQn9uLpK/RONvmXvd0U7nQmR2+cAbXIhDXJ5EYGy+Azlfrl?=
 =?us-ascii?Q?5qRtNS7pFpYxhc8cyl9V1z1Wv8dvpEa7e5n6SP0OX/XdXVYGXApED/uYyiLR?=
 =?us-ascii?Q?U87p0+EmM+vC8jlHfa4oPaF7FHbQI4qGH3zfiYX+yj9y0gpNRU68KGHkXU/B?=
 =?us-ascii?Q?ip5NImwpD386eYIHYr0WWyfP1ETniIjPisGpDBaUzq9PPPISULOD97pgw1C7?=
 =?us-ascii?Q?JbOQjcqZhmvtZHOd+5zNyyPFX/Xeleer2pAx4O9EXU6psawGpXqqCyRcxkeS?=
 =?us-ascii?Q?/DkW8J3Uoe3eJWO2yie6nN6cb+nhdpWxQybilOp/Nk2hX1XEGSfCgrMjFQLs?=
 =?us-ascii?Q?s5E/1zNGNVH5ArV6HvOKmB9bt/EXcR+UDwtbR0f7OGwkZJByvkCsQxQvexfQ?=
 =?us-ascii?Q?dbVvL06dAfkv5dXE9TKocQAE+fWc6J4eHrPRxmX9a/77rgZyOyqQDPS93Muf?=
 =?us-ascii?Q?zKlJ9+0mrrndiQ5jEM8dqxjRVI4c2s73eFU4LTqSUuy6a5+5HqM597mc9vlz?=
 =?us-ascii?Q?5qR3SrkZ6lN6TXkmFXNpReBpR0MwuuPiD23RD15Ob2qf2OBeAU9obU20YoTu?=
 =?us-ascii?Q?ELLVVIUkGijt9WiG3OXgUwwyMvadn3ympa1LI6CKG31k0OuEUyBXRThXTBvc?=
 =?us-ascii?Q?rnFl4iB6MJV3XAbsObXZZK0npKanz/Hl2HR3cTmuiP8NtZ8U/JiLq9h5u3Nk?=
 =?us-ascii?Q?KoVbWYLB44wEKc4/w+5h1qMt1Mu6KQESKLHYkYJS/pjYwh0h0IBYlEeBmsQB?=
 =?us-ascii?Q?t1ONwlsLBwb3UexBlpMgPqfCtdmfM8qOaKg47XA0NJidB+MKilztcwfGsGX9?=
 =?us-ascii?Q?8qp0rK4CSpWk0xLe0EOwY7raE2woyQnh2guIhslZMEw76GVGfnMMEoC5ltQx?=
 =?us-ascii?Q?2xJnRWKC+HLUVRfQy6oWfrIJWVMP8Slk+dEn7wdFYxROxdAmDOVCHqBjMexL?=
 =?us-ascii?Q?72UkUA9z5ndN5OrRJmTqJzOCZ3p0Bbj5UJQ0wGfYZ8tCfVhdyiGtJ+I0bMdG?=
 =?us-ascii?Q?2v9pj24fbWRbr2gCYjXhqWmdIvBh9sln3tZHku2ZoRtLckn/fsWh34VJlTk/?=
 =?us-ascii?Q?LLmpNYJ/cmsE+NxQkYepeQsB67qK0zGBfcceAiDK8MDvzn3QeJXEtQLT2CKt?=
 =?us-ascii?Q?5+JdTonzxHBIn1x1DqJ/h8SvFHHNoYqV5hmXyTb5dLrRCcqs2NTyBRFVDgfY?=
 =?us-ascii?Q?W1U4NRsIaWKAQPYlr1bPN1IpPgOKNfQ7Su5f3Ont?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c864341a-bc86-4c39-8f88-08db7e1e877e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:42:59.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMLVqKGSpfSNVohca0TcAzdWaA4xTeEvfX8ET+ZdrQNTaHngk4cOTsish1to6/kJw0eGU1jr+LBFXbNDi6z02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5602
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/pata_ixp4xx_cf.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index b1daa4d3fcd9..246bb4f8f1f7 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -242,12 +242,6 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 	int ret;
 	int irq;
 
-	cmd = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ctl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-
-	if (!cmd || !ctl)
-		return -EINVAL;
-
 	ixpp = devm_kzalloc(dev, sizeof(*ixpp), GFP_KERNEL);
 	if (!ixpp)
 		return -ENOMEM;
@@ -271,18 +265,18 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ixpp->cmd = devm_ioremap_resource(dev, cmd);
-	ixpp->ctl = devm_ioremap_resource(dev, ctl);
-	if (IS_ERR(ixpp->cmd) || IS_ERR(ixpp->ctl))
-		return -ENOMEM;
+	ixpp->cmd = devm_platform_get_and_ioremap_resource(pdev, 0, &cmd);
+	if (IS_ERR(ixpp->cmd))
+		return PTR_ERR(ixpp->cmd);
+
+	ixpp->ctl = devm_platform_get_and_ioremap_resource(pdev, 1, &ctl);
+	if (IS_ERR(ixpp->ctl))
+		return PTR_ERR(ixpp->ctl);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq > 0)
-		irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
-	else if (irq < 0)
+	if (irq < 0)
 		return irq;
-	else
-		return -EINVAL;
+	irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
 
 	/* Just one port to set up */
 	ixp4xx_setup_port(ixpp->host->ports[0], ixpp, cmd->start, ctl->start);
-- 
2.39.0

