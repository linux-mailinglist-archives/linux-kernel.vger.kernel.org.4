Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FB874948C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjGFEFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjGFEFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:05:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF2A1BF7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 21:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9Z+JYKKEL2Vv4HLnR8KQhN+1Kad4TlnML5GI7rJ0F5W99qWEY7wnzPPiZ5twUqg10IE8/kTzsLuCR1h0O4voIGhMBN647l6Qq4VcWmM45QTwNrHm7ETgwGQZ6DI67VKrL6ekq6RqDnAFqeovG4Y117yUthYuYTPz6Fo5Bo9G/PHZ0MHLq52VhWfibzgxkDsYsMkvc7iJ/6MS8n3v6Nzr0m7WikWTSeymqv1CkoR24DNH2ysZ3YqxnAGPmj3Rxnsqe6h0YDM4qp39da4jXBWamw1Kj+uaam1Srjfa79kgFr7RAWjzobsvOzJXWOvKHoGCK5FAmOsHBPcBu0jA2VyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkTq2z0Iylwy/vekUuST655V8GxepRvM2f0waLcVSBc=;
 b=K1dBBfi6PcJmLyOFno9V3Fh9QIl+3b4U2rnwoLhduJARDK9cFNstVwoXkrTP+EmDVEhT4cnZny2X6mKpbILwigbvWnEXeT6LSUgFHIJRwCem7bkSj1S2ScZ7h1UXqTpRDNFOoZlBDqDqhQWZgL2eOkinGZxKsIPW50u3FrZghPJjAuBMlibwcZC1iapvUaONO/1DldmVy4jqjpbdM8Ukn1CNPSn+1o9nmHFauXYdC0vHAjONxaF+LDG6KctepnZhDchaL1hv258BF1pm0YBtkGCEdDh/uHn1q6ArGdSUAmUzD6vojsuMT/LZfbmSywhtxrp6as2Ga6KuyDdNhr4XYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkTq2z0Iylwy/vekUuST655V8GxepRvM2f0waLcVSBc=;
 b=Re6yO8n1RSgF4gwsFI7GiYntydVZwEAlkrNHK0N6uq55BvNmzPNhRlyBjVHjXGAYM2pXZLjAKL0U+WjQhq6QPuoIu9uzaFR3ahVZx0ySZ6aGldb09TGyyH2zGJXbHDcnLrvzplNpAs3KpZI+dsHN6TSVvdXt5ZucoaMzEkrRdKXl+daA34njH1Si73ACTKYhrKRZEFBDkRTgoTR6h+48O5eg+8HVBvzcn45qWNwfw+uR5J9A7Zstj3UY0TpABvHUqZlkYrgdWjQ+KCa2sN5RbJ+lJ/RTwydLODL+7tZH1JdJ7+Y+a6JchxnzSnq1MB0MmP2gzLMdLiiSDpU3eCU/DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB4548.apcprd06.prod.outlook.com (2603:1096:301:a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:05:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:05:24 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] nvmem: stm32-romem: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 12:05:02 +0800
Message-Id: <20230706040504.34057-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706040504.34057-1-frank.li@vivo.com>
References: <20230706040504.34057-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 10536c9f-9d7f-4c23-54fb-08db7dd63986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmvGdWSODpwVa6uYBPacC0uZSfWoM8RYvrMRWkfhr1dh+GdcBjrgsRVx57pbkn5eeXOk6PMAf43X7bLU/81KjLo2AIecFuddojDdj7AbpkxC+Wy16S8gOQdiQEQBtKwbqb8oX3ch/HSNZElGcCgFdjm+A8Y22ZA+ki88CFYOUMVVdFSlkxevENqp37nsYAx5QbidMTFVNyrqR6+YUfIjnjW7pyH4JxH48sO3mNU6aZFKpXJT7pfLuTO1UgzIwUolN0H3AAIDRbW10PVZ5Ag7fPL+gx3p9NR3o9mh8XcsMVz7eouEvOnYMq9KIU3pRkNdssnr/aTvnA6o4v3W+zNSefjifWB5OgA8cg5Ut/8tZLkXWBzeph9IlTBec5Qn+qPHipLdaqDtoO2ulJYvQfFGGGrlsf+zIDYyEzu/LHEKuuLYGBXCpNqqBlYsAMeugLpJG/8GGxiaobS4ku25yxB6Ppts/HGkVzNp+qRvddRw4vvJjKYI9d9foXBCVxKXpb37QOCJrhUIWog47DmESJFRRt+yoUjihHsWcreyzM/X8ruWFVeGEVa+h8ZeZGufQK610AuntjmhS2OscySzNFVYG7BtKdVdk3Gg7oq/q0SsaAdP7Vj5xiiHcu3sFggaDzaC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(41300700001)(8936002)(8676002)(36756003)(110136005)(4744005)(316002)(5660300002)(2906002)(6486002)(66556008)(4326008)(66476007)(6512007)(6666004)(478600001)(52116002)(38100700002)(86362001)(38350700002)(186003)(66946007)(2616005)(1076003)(83380400001)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VOjyVOH10mXYEARadDJ1jc+ecAJQ3+Kz3nFUGilpTNm/WVYBXD0oiylu9Qip?=
 =?us-ascii?Q?HU7zNbpxaAU+lYHWeAfdoOcxhvt4ULzRBVE9zR9imnQBaZdv31TcMnNsgGk0?=
 =?us-ascii?Q?QxXjY00YoaEzp4q7H9jE7Sz/o4lEfJLzhtlBUYsSWFwK4ryKnFdhOAp9p38E?=
 =?us-ascii?Q?5+zZK201RdBM537KsK33NkCfOY6N+FVlvDqJPJH1hQT3A1GHo24XwN5KvnUf?=
 =?us-ascii?Q?s9cg12X7S7wgKnXxHHIJVGo8Q6W841ZipNeFT+q1RBtiRyRHoPHMXXLckTQI?=
 =?us-ascii?Q?NX1oNtQ0NB0mpD5hERiNj8u59WBTm1A7+5J/ZDvzMCHeVGRzBbEWklRVGP3p?=
 =?us-ascii?Q?V/Nh8Z0juE86+9MsVhRYswBRyhoSw04tG2G74cVHDQhsytuzvMgsrIuzJfkN?=
 =?us-ascii?Q?SreBA2t5SmgiRFBC/tV813cclYLiCDyq0Hht85LsyCudl9R2DPILY135Ay9r?=
 =?us-ascii?Q?a7EQtHCiX+L2e9HUFI9DvGGRWid5dJ4U+q4Eu7vcHVpBoG1UEn4iL7PwPsCw?=
 =?us-ascii?Q?CQ0RN9YkqidQfbVLJwcFDMyfeFdXJVOC+rAdPPvAftFMJ9tEw99VF74I/RRo?=
 =?us-ascii?Q?JOYL6OTOph/vB0DaRGfDUgyT7XSWV4aAwo1yGXEgumr3MkevzeHnQesvr82K?=
 =?us-ascii?Q?U+tkllu2MnO4zikYuA1geV5gR5SCKvolzKsbtXEPrmxw7hR0xEiBJjgUny5F?=
 =?us-ascii?Q?c0aEYGsiE5/+ZVDi9ynwIiyZCo2Rlds86LcoyZwQnykHB9TrEjBQLm3yAJNI?=
 =?us-ascii?Q?ycCsj/l10ehfXSSpIJuw6UO3zeJ8bnQSFoDioaQLXsVtuy/36UXngioYnAnM?=
 =?us-ascii?Q?AJDZZl9KTMKvWkU8P0kN2HKzKENHLxYHoxNiWF8evHSDXvRQ+VFPQM1GUWor?=
 =?us-ascii?Q?Awc6l7uCvjShVrdDVSI0UI0NTRuAJ/V1f+Q9liFdD+x63PMv2rDIcAMwkgHz?=
 =?us-ascii?Q?fTmangRS6043y1XV3DQLBwT8uS2K1S1PUBmDeTVmx3arK6vXUjhaXdT2VETR?=
 =?us-ascii?Q?XZJ1aqj5Lz9/Gw/dP3r6ObnklC3ExYSxg3V9t1GVSjM/KLML1jm0Ec2ZBuEc?=
 =?us-ascii?Q?DTZjETN0O34sqLqKkxgPL7K3wjMWcGIYci8myPUUWfTQOcSYjWXW4bnNTKMD?=
 =?us-ascii?Q?58wQr8OtqiFxM74bLcX3ocS+HqBcGTlxd5coC9zfIZ9VZQTBmKhNn3MFSR4D?=
 =?us-ascii?Q?oRr4W0Vyb6UAIK73WiePJDkshmVXHJI30eddyO0fpw/YzsAtvteMR8srnzFk?=
 =?us-ascii?Q?N74tNfYz2RwEtZ9ZsP/Ss6q9MGlbuWfUWB5WPTOskJXEdOpsvwNsTfnSuT5G?=
 =?us-ascii?Q?7EOl752K1duuOx7y/EQhlRRiWYEltzemh/Qd+B4PiDmbBvPD1tNdQ7z3suER?=
 =?us-ascii?Q?24UdWSFKbEx7Jh5sYwXiyc+sgji7NXhoO5bgJR7EJlpb9vtoG1bo7+C1jBWB?=
 =?us-ascii?Q?NVYI+OKuEKALOK1JXXiKH16BYfUZM3a97rN3nqCuyM8jJn3rnmOvmN7jsqMT?=
 =?us-ascii?Q?VIh1ZVPnPmBckNZ4F76IcGYVq6D2L3DV/PXjenJj9sB98j6ZnQEidqAsCjro?=
 =?us-ascii?Q?QeXqmjOzHwTKUiFUjrhTl55HIEDlohCKmfAOWDxZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10536c9f-9d7f-4c23-54fb-08db7dd63986
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:05:24.6805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ea/G3s/H9nUYiTxPaFKGIh+CjTXrvMrEfZbPAI9nENf+rYNobzQR38HETKUKLkMwSr+EkydbcdcDDcnN67d0KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB4548
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/nvmem/stm32-romem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 38d0bf557129..0f84044bd1ad 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -196,8 +196,7 @@ static int stm32_romem_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.39.0

