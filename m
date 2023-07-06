Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D98749C14
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjGFMnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjGFMm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:42:58 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2072b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4458171D;
        Thu,  6 Jul 2023 05:42:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNvHrCWddGhgkiicjuEjePOz1y8ZiI31YluW/F0+ju/gjTbWOX5XY4mgJG5YXinja3WB9RAwV8Vm93kAaWOYULtu6V4GdMWiDmdJgym+tsFLq0t4Yt1dK7+bMdam16e5Nehc6WSaJbFtbD266ZmdTSwvhh1R1OwAy+MCsF638BVIiznOy6kZa0CU98Vvd+EA8X81j5yhTvX5w3PZ+8jV/17Ioxq8KHyvLhB8QKcKdQ50RWom4rbIyObUuAPVF9Ena9DAGLn6dUXbfc4RFEiHDupuORM5svy6Apwen1wL+gCHlrUFUXr8NYR4Zh2Bmnrz6hs99kDVWJJNtNaRvjks6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD8GThYyR4e7OPYeAyEKnBqEfkeohWv4pHC59+3Uy50=;
 b=AYgygXcmp8ZCM1Gl0BrF2vpflaLCBh514ZcqPiFJvblIpVzAz5fAwyoPIjqyJRnw4Bh9pHVFYgd9MvkbhqH4K9ZQHmxIhBlo2XYEPegPfMqbVVsguAECBDBJ6LEbNVpjScXLGcquh+pVxUdSQENY7rPxXNvF87KYVHkYJ7e01OqD+xSVy5rTmybwMKf4u1oIlM7Q1o5LUrvbfqVbGjRyJCSiKfPK3XpxvYXsQOBjfDsTp3Fp8xWF2HAyWU4dJsGaXQFsPR4Dl1k0fvqeQVICPUnATXZR6q/7v+71SjBpvKT2+WJ3/IekS2mPQekYxifHGcOYnCS8dLxQG9YelOfLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD8GThYyR4e7OPYeAyEKnBqEfkeohWv4pHC59+3Uy50=;
 b=a3borwIx5020GPZzPXla34HxW+/7iD0jEfUrME/AVHftUQ65xFXU4pmSDUGVuZ4VyOZ+aN76pQyi3KzAZr9j+HtBVuH4ZiXT9k/szBUiKkl+Qf7UhTLoUcUWsRSJ5wVWRDPIyht5CPovPxv83Y4b5bhjEf3eHGMz92RJ7cSqwS8CnEJ66Eu4tTmPGme2ccRIQzdKeFUy4ctcaobHITAN5MzTeVHqweAcxp7qjU6vr/6ODbppLgGXCoVEFc0GnjS8RLo5GME/1daG3T9SXQxM0X07VA5GB/BAsMPc+zeklKmhKN5eN7vJu0fUT35i6CqRoDIwC6qfSmLaECuPCIsqBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5602.apcprd06.prod.outlook.com (2603:1096:301:e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:42:52 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:42:52 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] ata: ahci_xgene: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 20:42:33 +0800
Message-Id: <20230706124239.23366-3-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: da37ddd2-6557-41aa-4f66-08db7e1e83a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08fZKMDIDDkPfwKjXtAp8haon/6dB3jLPjAFDrg/j3fDbsbu+6RUNMj37Fn27RrwjELRqsg1GJW4uSaULtgi7StaKPZ7gPi5JpcpHVItVTfxa9Tql9jKDAkCtlPcweprGh48QgO6BPeaV0vVUY64ks1xoaIYZLueY+6bjPp4Q4rkVVolqJLCJveaQlEhFUvweRWBrJUeDPYAe6I+LsmZufC/zP3GtRp810R4N2FM1uEu8pRFE5lll2mIS7wgzI1BhaJ7xNYPwg+NfDxRUq066kYrbzBI86EUIMlNq2TIioswIGS17AVl/FrTg85m3iC9R/zVYZhQx5frNnS72D6qIc2m8R4FJAMqf6RxL944KZXlHoFMV7ybS7q+8vcm90uinmyM8A1uQ4LX+aDVqwj6GuZyQkkgDV5k1j8J5iCCxe+ahPO1awrGIeVxt7iW8KTI36foOClANYaGgEmEK5ihJovX0dodtKCAHF41Ms0MQRHvcDuwjZHgoBluRR4jUikH7zuYZVZjPJb2V1ogkitxVSTeCVD2Fp4epEMR+c3tPKgoL9t9Xky2PzV9vt4kindyq3tSW9tNpFhCJTn8g3DNmaqEhLYfJd0YsQM19bfHzWhQgi0sQqIQ9TmIQvqwjAYz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(5660300002)(41300700001)(8936002)(8676002)(2906002)(316002)(83380400001)(2616005)(66476007)(38100700002)(66556008)(66946007)(6916009)(4326008)(38350700002)(6506007)(86362001)(186003)(1076003)(478600001)(26005)(52116002)(6486002)(6512007)(6666004)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bCUsQgYOOQyZmputHR/YoBKL2k9htaELS0jAGtnPOTekc4jy3pvF69RqYiId?=
 =?us-ascii?Q?1xbn8v9ZTw4y9AWsIqnqfnGg7J96/JmZfvKJ7qXN6iHvFEWBUsiqccviprDZ?=
 =?us-ascii?Q?T1/noPCbhUhWQQbpkaVn7UxVtqBROcnafOrBV/hJVf++zhE6VGUELvB4615+?=
 =?us-ascii?Q?bRpZMkTHQvTlbhVOaGlELw5mTRch5H3mNrEYzEl8mZdssFEFA4pz9ttaBhTJ?=
 =?us-ascii?Q?hubCaAfjRbYTqILjiQ5MpdrVdxXtsZNaDnPiZBKz5uBhqJr9ONMpeQ9ZQ7XO?=
 =?us-ascii?Q?4hw743VukOOsXcpQVh2XtaoAcjhGE2JJ1WNi3+gIRd34vK3QIzZ5G+p80Gck?=
 =?us-ascii?Q?y0XuoPIhr8U1JujzyCGKTFp95pYzGsGPXy1LReF3Q9Pj34ChDrAm3GS8fgo5?=
 =?us-ascii?Q?lI48FZaoSbLXuiOkCEMYU0S9zgRkt3Y9FDDsmm0J1N3yrQG6nzKiaqxIdDJd?=
 =?us-ascii?Q?yY0z2xlKW7WS8cjLpeHZte5KRL0opezKwJ72CvSqq4giU/mP50HHtLA4+g0Y?=
 =?us-ascii?Q?0fakaS4YsCFtzuM2bw9lmUwjHFOatqlugw+s1rmRfFkRrnRAtOxMRpploYPy?=
 =?us-ascii?Q?q5e4Y3drSJEiKufMdst19wfrU6CQKcV1UfMLphuYJL1/p6ciJAmzqHKXC/RY?=
 =?us-ascii?Q?RRtPuDzXw9y2UAOaZtrzAS0hpahA/3TiYdAq3vcLlAx9Lum6waAp8ZLeoHbP?=
 =?us-ascii?Q?IMCJQ7/QmxKcswIKs5XCyP3ZxT1VXLDfbwu790zFPENDRhOg9MBhArWZDmOM?=
 =?us-ascii?Q?ovHbnbqv+v5aLIDy9Gy0iyZc1MLp5xWooiH9qjZxw5+5rorj+CMAOyLY9qiX?=
 =?us-ascii?Q?AT7DbKgTq3RlMU7SEp8x9Qq7AdHvzfDzzD4toC6Gi3FL9rz8cY0RwKYclJT5?=
 =?us-ascii?Q?87BxFVsXjRIn0Fp7pDRp+899zXgq7FXBYTgn6iQjYKsdo+QJisZh7YGNasCJ?=
 =?us-ascii?Q?IGEysoSaVsuq+7aecy3L46yG3ZYqTzpWWJcFfi1lSqkoGFCYqzHZahYDZMMm?=
 =?us-ascii?Q?Nf9gG3wlttKCGT+3aJ/cieod4SslE3tRilqm+zQypFsathPAme1d6i4BRwD/?=
 =?us-ascii?Q?07evpXniRQfYKD4QMHkboS62DI7PIDdGrBCqjetkOw+lLFa2/aOlny4RTjJA?=
 =?us-ascii?Q?M4Kr/mbJw3CojskzA8OWp1SHI/2tyym+a6VKOCgLUHllJnz2OW5z8MQ4ifo7?=
 =?us-ascii?Q?6/SbqvSZORYnwensBccIXkXL7ahLpKV5wXV4+JvA24t3C3a2Ok5Um0bRde2s?=
 =?us-ascii?Q?dtlLWfCva3X0jGQxCYd/vUpCZWuG6CE3iBxlcQD5xCSuvDXzEqW7Krf/fM3O?=
 =?us-ascii?Q?qKyRXk5Jp1O1OQAplfPASifnH3X/9kf1XePW4JbipBrX2OjZeOOWTAiGr8LR?=
 =?us-ascii?Q?tkWSPN+DmXATFZ4fU2eovWOMlNIRucsAPCB8UqezRAhvllOIer7q3YfDjpJv?=
 =?us-ascii?Q?WKttypAuuS34+2APlBkTjJLBkEhhP9hh8BZN7Pnhl6h3TRyKDJgLx5IE8ApE?=
 =?us-ascii?Q?09mPXzIZnIjpGTlee4Riei7TdanNkC5b085ltzlK8cNzuZ3sT+Hd84pPXuxW?=
 =?us-ascii?Q?gV9f2PFm4PNB0vyHChxQbKJ6iQMaLV36ehRnFvJC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da37ddd2-6557-41aa-4f66-08db7e1e83a1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:42:52.7559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fr04ODfcnTJLy6KSNsZLGy6XXs+FBtCDH3Q9Cw1cJteWlI3BNZo2gt//4X/+Fe/dKz6cjXmnAMA/4Ym90r40cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5602
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/ahci_xgene.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index eb773f2e28fc..f5deaf648663 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -755,20 +755,17 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 	ctx->dev = dev;
 
 	/* Retrieve the IP core resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ctx->csr_core = devm_ioremap_resource(dev, res);
+	ctx->csr_core = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(ctx->csr_core))
 		return PTR_ERR(ctx->csr_core);
 
 	/* Retrieve the IP diagnostic resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	ctx->csr_diag = devm_ioremap_resource(dev, res);
+	ctx->csr_diag = devm_platform_ioremap_resource(pdev, 2);
 	if (IS_ERR(ctx->csr_diag))
 		return PTR_ERR(ctx->csr_diag);
 
 	/* Retrieve the IP AXI resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-	ctx->csr_axi = devm_ioremap_resource(dev, res);
+	ctx->csr_axi = devm_platform_ioremap_resource(pdev, 3);
 	if (IS_ERR(ctx->csr_axi))
 		return PTR_ERR(ctx->csr_axi);
 
-- 
2.39.0

