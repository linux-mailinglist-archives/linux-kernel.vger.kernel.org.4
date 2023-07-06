Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D727749921
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjGFKME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjGFKLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:11:42 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0941FD0;
        Thu,  6 Jul 2023 03:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UC2vVQmnyOB2S5WvWEtf4F+gphXhwB3aNdzamuvR82U6Y0TrNYI8SilwJKD074eExmuO/dKHPm95OmzZWWDvfBooepXuzoA0E0MW+EUS/kRt/Rktz72kehtwpp1ZmQKacWxyRTjfdfGY+ZKfBJTnllzRq/TVuJVl4bCALsWbEGAPT7ggAwyTz2JZ9/yGcYoUwPBkGjnozDrzqMW/J/J0b5ZemkSctHLS4Sm8/pwMxOnqsrmTyQ73qWH/vpwWJFFENQXYdgkMmmev3nnHX33kvQ3F7OnxZgkmTdbk9Wbxyb/8559em9OJfvDZy3XjJb5fJ/lTtz9WHMMAx+TP+x5NxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzQdBwm0YUNBzjmo8D9Z/4M7Py45GLerlbZjZIF7NOA=;
 b=HXpRvzWEDfOPlQl6DBrxUqd/fq8IrcPNLvz0kteAOqvlYhNzy5KOChEyxdSH1gFLoMJNHsXz/ftFsjAu+JvCbb0PyqSarcCUUs+jcg7P1nhGgiwX1k6D+XQdkrC0pYgNpcSHbK3xmYQx71C4GkMCUBenLxauMVqh/+ltrhk4CyD3VRbU/UBZfU0UDesqh5RxYHd3ybDXJW8zZTQzeAVTXhzfwL1Q38m/XjPNTb9732FCBsQsYHhAQaJSscROSKMqkym0zTDPHq2QHqQmQRfRoCFCWK07m99eyItmRO9KeSCoZsNRt3bUNKaTEwhxnJ8q3q9ES2jpiIlait6jdm79nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzQdBwm0YUNBzjmo8D9Z/4M7Py45GLerlbZjZIF7NOA=;
 b=pa8rs/gJrp2BYSPaxJ9juO54ebwaJHunTSLAMPcCS37CdJ4goO2MyZ+o3A2YR2LCHFxSB+71/u15Hyahlwy0i74N3+rw+7abGewBmUVDSwJbkIKEEaaqC0RRSwNiQgakFQbpng63onocqEtKOm50zWx6haecTETj9QvA9FXyN3rvJPjm6X1h05bEXln0E01ZFuzW3bIplzsxiXhY5hdoz/eQsqI6s/LweO/z/akjGJqi9YfzcTNR3M6XR6UEInGKfXEa7SltOBs/1UlhNDj0g+mAulOEeEZtbMp7RDok1eyGc9l4n0Y7cuS9Xjf2PdiVaZEkM3Vq84RXIh41YwKksw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5287.apcprd06.prod.outlook.com (2603:1096:4:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:11:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:11:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] media: platform: ti: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 18:10:57 +0800
Message-Id: <20230706101100.75654-9-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706101100.75654-1-frank.li@vivo.com>
References: <20230706101100.75654-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: c86a02ae-bddc-4c6c-5b02-08db7e095b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgyFfyfT4OpuNf5jST66GBleoUQH/3+LLRvhkWdY/4epBEn6o7urpT/XBAQeW2GIjvBZrzEa2reuu/2AqyrmCl94/AXLpqigP6inMrycqneHWd21eiPhkF24NFHhPdeNn2YuImN2USVOwL8kmxb/tahTV0e/ghIfsfDLQYxOitNCiFDzzdETZIteFErnRZvveyCPI7uFHHEKrmaqW3buhrgIIR6PT9pBtHzuKtjVbT7LB6LKYLYosAAZYKQS/xs4v4VQbrFnzQEqxVQIvqzoZ8ZNyX735RLXVi9jQgavGMW17Z0rnRLS+lMXdzhANCJu2PIKMJE6e9938duq2M9anQ6QkyZIxQARHX0dRvNTZ+Toika5PeQwnmkCewIjRg+u3WYIyPfhBsssv3KP+U+o37p4b4zDvLYq20v0DC7Pj95jbRDJpz8mnvAoNa1JSGu2nhbUZ4/yqjhdDTMj6ehyBq9ZvT6TbNVOtK8Vbo2OPPSbsNzQORZF1qCIABn6pRXvaVOjjkNyfhuFGvNvkJZzFs3eMO6PQ32KFlFDD0lFNVHd1OUyKwE3BXRnBmMmLcYQpUQFDvVs42psJ28pUd6YaRtDeMTfYdMc+8VF2wRSiCY+q0UfGRzcGDPxAfkjfTue
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(2906002)(86362001)(8936002)(66556008)(8676002)(2616005)(6512007)(6506007)(110136005)(478600001)(6486002)(1076003)(6666004)(52116002)(186003)(5660300002)(38100700002)(26005)(83380400001)(316002)(38350700002)(4326008)(66476007)(66946007)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r2amZgof/gTEM55XNfu8kAUSeC6FGKJaeEoYBaV/Cp+EWpHAjBpixnZlOo0k?=
 =?us-ascii?Q?Og+YhHHecj/zZaySsCgKj5gap/jkbuQ2/iQv57vYcgqGLd67Mqtd869LMbxC?=
 =?us-ascii?Q?3x4iR1DTokg3iWE8i4AdvrWsf5LXhtn/t/HUXEzr+jyfzu/ArNcVtby790nR?=
 =?us-ascii?Q?piQYWb4yciC+LoTmtv+Xyxzpe56D+MzuyZ3Vmw0M8uasi4nsuHMIzLv4ILvM?=
 =?us-ascii?Q?sbbZ4ybvhhbVok82B+hgUMTULSJ/9rjYN5MAfCb8ceGQDonEyb+Gga+V7SX+?=
 =?us-ascii?Q?M1B/lttseBT8i0K0Uxl78JZdvJw7a09qH/6qb/HIedhzZUONIUp/rVcGHQxr?=
 =?us-ascii?Q?0STjRR3QDbbwxr0BSXGzlaNXg5WVZf4FXZz460DTW6kTm2QeE+dN4N18yJZ9?=
 =?us-ascii?Q?DqYE8dhwRyrMlTSD4TobvgO3Eiuk5EZVWdZ7XhMnezCWiSt82fLbvmW8LeCm?=
 =?us-ascii?Q?F9TwO2pFGcoiGxeRLQWlqDxeOO17Paeov6mg+3Zqs+mUy6BUkDpQBFHjWNmz?=
 =?us-ascii?Q?V3i/a3ZcP0tXAcrv393m439nfRxSKMmU59bkmbEKh0IYsGzK6DMrU/vr2HQl?=
 =?us-ascii?Q?i5ZpvPYpHIpbHK7x8eOG1XoqKxxRb/jhoxhQV1HT6Qb6RDnHpExtqYB91hqC?=
 =?us-ascii?Q?ltupasaEk1PPiNEbVyHuoenW+82x9V7ZvGYWYlvtSUyRaBotM3g5m8x3sQAI?=
 =?us-ascii?Q?msgGpCa60BtY4bMDW7R+LBZpmQMnBhcPAmGcRxMiQijQgNppHKieGNP3/Axb?=
 =?us-ascii?Q?4I4FnA+BdABs+1IfEKUH66l5rzPONRd5Q2RT7bkKCOWy7BnOqGjw9tOkK3of?=
 =?us-ascii?Q?0zD8PIOsXF67ro2+MCQ+sfsmTa/3s+in1I6jondq8MUBkjg0kvZkMt86VGTy?=
 =?us-ascii?Q?q+DiT1KfJbVhqVRXqUd/Cmd/9NljVlk1HKf7gRwxeDYqIZZ+DaAb3RUlMhDQ?=
 =?us-ascii?Q?lt0OtVZQIiIsrv93CCc+gYQSruergdxDIeFHKXE/NlSzjXmw5U8u+jl326PR?=
 =?us-ascii?Q?GgpDAtc6NasgIgDBiHTtbyw2vsiAdu51ElauwSXLHFRD0wsyeuAFjKTRf/HA?=
 =?us-ascii?Q?kABdadhN7P1GuFJgPhdt8YFOfyNKOC9ZZC38CcflD/V/PgxhpTGoCzcYDBpW?=
 =?us-ascii?Q?RonW20y9NpB/PFPpsVaM9xae41yyzsrbCC+G3p5esvpE+oHB4kZ2ZHqWQCHU?=
 =?us-ascii?Q?OCV6coe13UdaPrEqm0Z53jzdbxTDYvXEvs8ZGOYcI6JjKLmu3hQd+FBkmWyJ?=
 =?us-ascii?Q?avb0bTGV4GlFE7b0xo68kAy/HR/9ysX3KvrQMWpzt83Iyem6jJqzeL3P3Olb?=
 =?us-ascii?Q?rThDHi0i0BNWXAJu2Jt90nzqE0MssCgeN+SrqtDD5kKe74muSY7lVEJwDVAN?=
 =?us-ascii?Q?p03ZzAcWB0ptLoA2vUOyp9eib4Xt3xZPj/tG3/siFTvYBBC74dNQ+yva4O5+?=
 =?us-ascii?Q?HMYEJ5CLO8trrnPuc585Gz9Ricl+ylvdvTluZ3mPuabPdeL4yl7XuYginFdD?=
 =?us-ascii?Q?QkX9Fd2EwY73ng+t/Aien4EHI2KUisJhISQxHl/co5YzsnV2QEnY5Ner6Rew?=
 =?us-ascii?Q?WAc5jimGS2naCacWk0fN8Q4+pxZH6rchcr9y1QmZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86a02ae-bddc-4c6c-5b02-08db7e095b6a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:11:25.8583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glAEzU6Oh10z/pZMZu0UJdCKQtThuE33e9yz0k5nzjznZhWpkOHP5f+JA7XlstoeFcqPaj8EjEQRMKv6tzhiBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5287
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
 drivers/media/platform/ti/omap3isp/isp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
index f3aaa9e76492..1c8e4ede29b6 100644
--- a/drivers/media/platform/ti/omap3isp/isp.c
+++ b/drivers/media/platform/ti/omap3isp/isp.c
@@ -2329,9 +2329,7 @@ static int isp_probe(struct platform_device *pdev)
 	for (i = 0; i < 2; i++) {
 		unsigned int map_idx = i ? OMAP3_ISP_IOMEM_CSI2A_REGS1 : 0;
 
-		mem = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		isp->mmio_base[map_idx] =
-			devm_ioremap_resource(isp->dev, mem);
+		isp->mmio_base[map_idx] = devm_platform_get_and_ioremap_resource(pdev, i, &mem);
 		if (IS_ERR(isp->mmio_base[map_idx])) {
 			ret = PTR_ERR(isp->mmio_base[map_idx]);
 			goto error;
-- 
2.39.0

