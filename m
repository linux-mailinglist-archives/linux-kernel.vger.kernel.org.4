Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152DE747D87
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGEGyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGEGx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:53:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD59A19B2;
        Tue,  4 Jul 2023 23:53:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aO/KBHzNhPZtWvAkY4ehi3YypQI2frnqPW+B32PxG9eXsHZwEwcHzZJRlqzivPQl3KYV6f53/zSV6mwpTD+gmKXyRymL7NXuAI51tyHvwaG77dMqHi+rCcQ7iiaQ+Xb1P7Q92Rk4nZVFnUgKQO2gi9n9FBqok+6eWSgCAVvyB3unXc5oKIkBlboUyWn0G4XkgyiwUnY3MZBZsF7hM5nO0U+Cux7KYFo8+UQt37lb6cj/erNyjbIXJddWCY4V1rjnRBu9d/e6HD5qSisCSs6WwseI7f/fKAN2LdVIpReEPpMquIDq9YQV0ciDih2oA5xOdXq8NA1xCsHagcJ8hANkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hvl6rkn1t/msRsA8K9IQ3QzUxNkY6oDygpIzKxnBh/w=;
 b=O6TbmTtIU4kFbbViRxtSGSbTfvzBd5Q1veDKcqjm/av9S+NAjCjsaHGW+vGVwnOL45/elp3Zs+CC+oqmlCJKZ0ifVuRh2uqPAwIF8oOrDD85LplfMbLheQlhNeAW9+IO9GRTPCbpRHwjPlRIQiAXVTtdE/kDK6UZSKN4AzoJfvI2hhkERhTvYZmDZLuV5m4AXNzUxXzPhejOOtCF8onLAHvluMZ8DN36Q4UrApb05NybEttgtHbeT2Ls99sGzB6nDDzAH2yTT9K6B5Lz+8pyFsqdPRlPOiFyCIBpib06fuWORDi1xenncsrREyMG5XqLUPHKiu3KUsHAnMtIadI8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvl6rkn1t/msRsA8K9IQ3QzUxNkY6oDygpIzKxnBh/w=;
 b=fXRsYMXNyyPqsMzU6syfNS1s73sPR9oy+bNYun4tBB/d7Ol9yRYgkuhTHKJf77efmGWPtUNBneJDvZifce9RFFkPvNIGBLAy0n00oYByyh1MuvQcJcSK73tnl5S6pN0wz5a/BZLywCku3WefbMGrb4V55eFyRDgFvQWfwUxUBiWAxfKH8Ny6XButGaSLhvZ8d8OlKUv7Qklo06D6hqpXKc5CZl0LDBCX+Cj96P+4/djGVsD4zDvsWK5FWitC3WRANYdTkKtI8pmhat2LMR80qz1e6zJXmKdAENp+SJGGYfIIMgEu17i8Uy+Z/wFEIas6a/g99iEDHga6kBXDNuNGVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6087.apcprd06.prod.outlook.com (2603:1096:101:e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:53:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:53:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] clk: sunxi: sun9i-mmc: Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 14:53:01 +0800
Message-Id: <20230705065313.67043-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a9b422-743a-4f78-6ea5-08db7d24877b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmTq1ucWiEQ6HMkhdIeVo0tMq7pi8GzNINjX8EIbzmSCD0NbAQ0LIbI0CJQRaE1rINIwwXhgr4j0SQf4qQP+WjtLDtT82mOy96HDjhENrgznf+cw9Sq7lWmFYSVASomq5ct4iaz4hsJcP7w/0WMtQd0q81lE1IC27Jrxp0kzmzfH2uIxoJtClo0YxeIn/UDJp82p32ucLssTasxcaDDw9qBEBZensfhVXf3cD+Oi8qBt6SoAgW6WKPH7nJ58nwiDoH9zyX9irCyV5BgCTMq52YkJ8rOCcZZ2gd0jUowHaQNtoAPw2t5ARvMRdM8q17eB0YSqQCQ60dBn50O2jD+rT6OSaRl6kqR5zulMm5UG3Z5YLq3fjskWnGbqw4XuNIt2QvijALQ4S2NXiRFuT6copBTdBvQ3ajB6i/aVSXW/b2giXO562PLzDlGla1LBTXrMsfwP8vSB8+XRF1LR+V4o5zpfhEIzhuSecJdhAnQWM8HqMkCLqzuIK4k+7SfSzgBFk+FhzuPrABlq3x9Jl+nynn+AFuBYSbewXxwHolfQN79TBwPtaYgmn42hSyMiyzKMYsovZdpzSDIMS14n7IBNVLPNoeDe+FCrVplP0PqbYq98rqZr8yXkXhY+2BhFS8QZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(41300700001)(38100700002)(6666004)(52116002)(38350700002)(83380400001)(2616005)(186003)(6506007)(1076003)(6512007)(86362001)(6486002)(110136005)(316002)(478600001)(66946007)(36756003)(66556008)(66476007)(4326008)(8936002)(8676002)(26005)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X9UhMBKXtmgxrBGfjJxZURKYmbJACKnwQdTmD5AL9QhsuRXR3rMs44NlCiZH?=
 =?us-ascii?Q?ciS9d0rDc/VN7wppv2x+dD6f528+bm2e6L7gLEdm9qi2k/iELvUP6Y+ontfe?=
 =?us-ascii?Q?KYuF/LZGiWzmj+Xl1POwKQKuNMjXZPKKyY1etS2mRsbNoj+P3I/rUdI9D9Ft?=
 =?us-ascii?Q?CJEBhrRbyqGLqTVzP4FnwkL7a10uWgsnmlLouA8b2A82ZC/UFUaFJw6TbG1z?=
 =?us-ascii?Q?/dKYMwv/clYRt4I/uYm7E3jv+9Zi+SVzgnqLncTdyVMuyaG/ntqHpgOSh+Wh?=
 =?us-ascii?Q?yrmtppncYk9Q1lsyOcN5b1Zu9BytmAoIt76XHqZrb6YC7cy+7nwggAr7zTqU?=
 =?us-ascii?Q?OBy2Oxgnw/xhEMoHrAFnaAIRxL5Yw3ZJ9V2lgG6OsK9icWinoKhP+nmHfKVF?=
 =?us-ascii?Q?icMy0f01YrH/nOpiGou4vjmTxm5COC+Rcmne/kjY0nitc+5pKc/HAcXxys+i?=
 =?us-ascii?Q?M6eSCpXJdP1M90DDWwE0JttrJOyuMtIa0DYuzhGKp7jkMhvFwR/EUGU58OZl?=
 =?us-ascii?Q?n/jKoNoU3s2bJyApNuPSjR5Z9oK+ET9bE6hWgEtLMfycAFSsphRXnzWHXvmB?=
 =?us-ascii?Q?ZaTvINYAYe2mXy6b0QsehZ+nu+HMO5VeOeIuGWnZRsNdAbwuc2Gv6i506mOF?=
 =?us-ascii?Q?V3M8TeV+3UPMP/kahxM3GBOGHPMYWpDTRoBBiqf9xDHfvfBXkuTxEDba28Od?=
 =?us-ascii?Q?VWGS0y5nxSKchGWmxu7+UUR3FwBcWCxQ0ComJOD5dHfrXnOO3RlZpZ8N/oMo?=
 =?us-ascii?Q?LE8JNORlWThE3b+z/5LQ+e/Fd5SsmxgETtDucajtBX4aReZgs4zCTeE9KGG5?=
 =?us-ascii?Q?BQJHsx1p3xFm297KmDgeZIYq2+gnhU3/sa0bdLIKnbLXZBJ7rqyuo8jE2uxa?=
 =?us-ascii?Q?WySr0mf51OGa4CO6OzZWGCZ7FGWm892p0sImXzvEpfsLNT2x/8do7UE0fo11?=
 =?us-ascii?Q?F3DtbiJTGRkgzz/za1x22I8X0hLQtgq7oTKANujN3C3AjIjNlkVgwRFBBT0C?=
 =?us-ascii?Q?R9gjNyqNd1joSUjreBO+wgRNz2xDSvkVtIX0Qqq5ua6s0PIuvnrjTBTx+p+S?=
 =?us-ascii?Q?ghRaJWqnOJLjp99Or/MHgI7Mg/8UzXaTZInfZ41OvfYX7FFEfnXFJC/dytSd?=
 =?us-ascii?Q?o69HKe80EFfPzHaQdpo4xL/A/3DJTXdtLg1bBPXzXFkvI3l3gU5eQBmaFK+7?=
 =?us-ascii?Q?fiT9BKsH7zSWaMkVcdIuP1ZNvSXXEY0oKR+Oi0YfvUX9FE/X5/8O+GuRL5p+?=
 =?us-ascii?Q?rP1zU4OlEjIdndeCUzSdeGOwgGZ0DbbRGjXw1sf72LEPHLNvDLiY65Bk8I4H?=
 =?us-ascii?Q?8u46aw5qpYH4rmf6/bMx6rlzdwu5AVRZet2E71evERvv3yEWF95h6i1HL02s?=
 =?us-ascii?Q?s2aGzBcy4LjQJXrRcFiOHN2sQPuDBrop5IhyCG3yAE4o0cLm8yiZ7huHQGnU?=
 =?us-ascii?Q?ZjNLYqjQ9NOVTlu9f2jWm0V2FjT2L42R9SbUaErgzPMBxiB5WU24A0J4156W?=
 =?us-ascii?Q?pT4xP8Xf8T3jcMF6pP2BoRhXPmq27ZRDvNs54KgexpnFz00JfijhUbUf4YBm?=
 =?us-ascii?Q?j+pdUs1a//kMZTsuFBLInIYk4csaMA5qyD2d3rqF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a9b422-743a-4f78-6ea5-08db7d24877b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:53:25.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tky/xn9tS44mDpdSs/wdp08UhfjaeVtGgDK9WYxw+4wIuAjDul8pc3OYqGqkD/95p9UWXK8y/T3XskPbcyMW7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/clk/sunxi/clk-sun9i-mmc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sun9i-mmc.c b/drivers/clk/sunxi/clk-sun9i-mmc.c
index 636bcf2439ef..0862b02b1ed4 100644
--- a/drivers/clk/sunxi/clk-sun9i-mmc.c
+++ b/drivers/clk/sunxi/clk-sun9i-mmc.c
@@ -108,15 +108,13 @@ static int sun9i_a80_mmc_config_clk_probe(struct platform_device *pdev)
 
 	spin_lock_init(&data->lock);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r)
-		return -EINVAL;
-	/* one clock/reset pair per word */
-	count = DIV_ROUND_UP((resource_size(r)), SUN9I_MMC_WIDTH);
-	data->membase = devm_ioremap_resource(&pdev->dev, r);
+	data->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(data->membase))
 		return PTR_ERR(data->membase);
 
+	/* one clock/reset pair per word */
+	count = DIV_ROUND_UP((resource_size(r)), SUN9I_MMC_WIDTH);
+
 	clk_data = &data->clk_data;
 	clk_data->clk_num = count;
 	clk_data->clks = devm_kcalloc(&pdev->dev, count, sizeof(struct clk *),
-- 
2.39.0

