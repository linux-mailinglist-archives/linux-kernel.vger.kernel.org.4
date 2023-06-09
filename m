Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01DF72972B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbjFIKmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbjFIKl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:41:28 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A853C3C;
        Fri,  9 Jun 2023 03:39:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaT4seaM0MsANIoU3zfu846Xg9UAqglpnMdDlWSu/bpgB8/uEiaxAHJhGbUxKh/V8FVOIRaGttzSGb9V14I3YHnurHfhpjWFf/VKRqyDu5ZdURYhz18RRaMBsVWTHp8HKAVoyhRW7wqOUt8VszwXndFGL6OkaMrnY83Ti0iBOseb4/Wg8Dg2mjV/puOvd5dW9KxTWg4P+SpVwCky+6dQxavAYZ/v6YzYqKlVEIR5whgjRKy5o63M21HoU+0sEUFaK9d92fDdxMcfJElY26NKL59GTNMIew2GWPlLSBnpf4IH0Y6V/nLPRcmYSkJnRsQhdoMnsXws/w3VMQX7WY8QXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXVHn853zmpa6W6wd/J82/Gj0qqyzRxVurxfR2JJkfE=;
 b=iLvyRB88UR/q4u/u7p9fpcQ+PvjaHNQh4ixErQ16MNsNO+rwZlBKQbyc+5y/cDTSn9R+dz52PjvgxpwsUtNdC9QotcwkTT4MLoDFziWmjLfBijKjn5LjkTWlLtCZNIF4tMKNzGiX7tyPFOW/RVuAIROuPApM89jJpZU/+r3+wE8i0PzsYm1jc1l3B/70tHyFqn+3trNizwWHcYM5kKan6WI6t+5GbGMeyIRCaZtlzrBrHREyFfvebqbjXCcK73GkYcJdvfO6bWGtR0yBD4A9UbTlulY2ETE2TwobBUpixAtDoMUf603OiBvTskGC1np6gZksPPPUhQg47vZ3SbqKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXVHn853zmpa6W6wd/J82/Gj0qqyzRxVurxfR2JJkfE=;
 b=KRZuOLvHUNX7txtZbLxc3H1F+j6VKS8mp0FDmUeb6Qr1yt3q1VxbXR6frdvV2oewOWcI03+Wa5ZE3O1CO0Mblw/jhMZ6BIM9sIqM+ofwj+/gGdQWiYoAqHDZZsL8Jgmn0nwv9FbWHbIyHXeKCLPPB5VshCzfpY7IN5Zns1ar6hA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS1PR04MB9336.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 10:38:58 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 10:38:59 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, iuliana.prodan@nxp.com
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v2 5/5] crypto: caam/qi2 - avoid allocating memory at crypto request runtime
Date:   Fri,  9 Jun 2023 12:38:42 +0200
Message-Id: <20230609103842.4159321-6-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609103842.4159321-1-meenakshi.aggarwal@nxp.com>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
 <20230609103842.4159321-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0096.eurprd03.prod.outlook.com
 (2603:10a6:208:69::37) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS1PR04MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: a2470699-60d5-447b-1c9b-08db68d5bbdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHxnAsCQSh3+K7yr58P2MWY/fQEXcSkM6PNG7ALrEkNW8GtLgxyjEw/bxeHeWm1Q+vMTxuPMvJZF3mhfa8AtOjAODXN4dkchUoXp5c5/zH/paL57kDzEK+ZM28FK6836BUKPTD1yLd9/jkORLgzFoKwBHd7jAT5Y3ThfLSqG6APKOAICt+XA3S7zx510KPg4SjuCdXXpTnJ1iRnBQt/JNQAgFeB03MzrWr6dh1QZKp3h8fINpNjah6idZ9IajZgCQOiLwv/uYcmk5d268mcWh7pMMLLfndM6j0u2L0ia6+YNlC0ud2t+tMRfl8G9yV84CYTL5ZuRjUCgyJoFG6ffxCZCL/IizGpKvMr/ML4dr6uVLTmewIk/Yu9lAJCMCx1VL8e+lB3Qj/wZspdw2MC4DmDGIdgKaueNgpD9rGJURL5rxIts8AVQ/oviKMUwe0vDj0hBr45AFGuqN9B8uSXo0jsJSNg8y8Tk58sQMYslJY2SYgF5GgDUiTwkq0I+Q7vDkMXestSAaRJKDH9azHZ3Svihz4O1MBeXXWOzTQdmvORJEV9/U0JZnLykxk5uVCoHtAEfp907PjKhTOYlyy2oFLzTOlJTLEnSXbkPfl+Aff3eAX29j9tu4ayHaXDmTYj2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(66946007)(66476007)(2906002)(30864003)(478600001)(4326008)(8936002)(8676002)(316002)(41300700001)(5660300002)(66556008)(6666004)(6486002)(52116002)(9686003)(6506007)(26005)(6512007)(1076003)(186003)(2616005)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qyGYzrcHD9zbJrxam3j/tzuJwomiZ3o0um+sQSCSndNZEIu96WmJlcydeir5?=
 =?us-ascii?Q?CD5v8mBnJq50qRU0CoLCxclsIKYB0YACkku+zoNJxZY/LZDZt3V/a4zgbjEW?=
 =?us-ascii?Q?8pNQ9w4pA5jQCNI6rBOIYG10ge944iTmtmKcfoWFwlv0mUJJ5N8MaY046dbg?=
 =?us-ascii?Q?7Fg27A4qKyD8numQPNaXoKvi0D4TwUawoLVBTvjE6pAHY3KZtvMHUnb7L+Nq?=
 =?us-ascii?Q?oqmHsztuuEGj9JJocerwaPizCEOOXLU4QcAXilZL87pBNvELZWXaUe0bqzBi?=
 =?us-ascii?Q?I7GwlqA7as6QqiN1Xq2pAYi9SEcE6UHMJ+oAdUj9FULB+LZ4oRYbKFHRIckq?=
 =?us-ascii?Q?LOs23T5qWbd+JufSNFsfNGJOPrxSHtSgBT2cGX2UOhVsdEbsSYtFlhV/UEyJ?=
 =?us-ascii?Q?jY/gd27HVr+sEFZTfzBsBJLqb4nrFr1asdN+s4U79o2ZqxhwgDvXwwFMxnBK?=
 =?us-ascii?Q?+SkFIUELH/76Obwz0tuGRvhbMIBwMIpT6YH5uq66Hitvv3UtHdI2w/pOEejj?=
 =?us-ascii?Q?bHhWUpqY1V0ErFhZFiBO+Mbm8pa9E7bEuGhpu0LvmMDuX17K6Ng5CMNZVYT8?=
 =?us-ascii?Q?H4mWH1AH/lDZr7wC9A+KV8YckiK5jKG94Ssh74aoh9icXCmTE9a+gig8jGdf?=
 =?us-ascii?Q?v8Vi4gQMTh9eGBETfy8HB4hfqnHOtqg54fQTRsATM1Wa/E6dD5ytcEctAFm0?=
 =?us-ascii?Q?mdOKY0ocsabySUwkTmEoISWfXECvM+Pkt5E2ZjXUjzeD8xEnxxlKfF6XW/Qa?=
 =?us-ascii?Q?LxiD0jvCu8Kh50X0B6zv41Wx5QnepbLR9dOYZEipWWfOMfiSQLrSOn9U5VUz?=
 =?us-ascii?Q?R7QHr93aZNguxAVVl2+l560Ea9JbF7C22spzaEz/m3hGHYjXLMwDLBdRscHX?=
 =?us-ascii?Q?ff11P6kIMZSd5G/jSEMYOvHYLzl0HByG+bHyE+3TSq++RtN4SdAbxEMw1pA1?=
 =?us-ascii?Q?h8VOl/erhuaovmNlb0dR8liFwqrrqDA2zaLH65w+YxJ7vrL/ToqbZA1AlNzq?=
 =?us-ascii?Q?QpQAnABRcuQrbrp7hr0bb95Xr4CmkVPyrBXudMLz3kdCSbpSisJqaLBVEGFz?=
 =?us-ascii?Q?+D5n77qTs6CMx/+z9drTS3bzHqjhYhV2oMr8Y7g8q6GB39D5MtAEh5aWZ9lw?=
 =?us-ascii?Q?CaH5wrNErXT1Hm1MYrhf5rPI6oeuYPA38hLYeV5tpnHDVfpASOpio2Qv10wd?=
 =?us-ascii?Q?0aaDEI53SAKylwhKSnTsObgxvn0742bo8Q15VG8sbDfAtVM1PD+ofXcRxdI9?=
 =?us-ascii?Q?7EYZJXviEHtFvlF3AFdC7RKxxxKYOWVzw11RupyZi8U7m2E955f27B85q3OV?=
 =?us-ascii?Q?eZT82Tjkk6WxZqgZhpYvUwXm4WkehsU8YsZbzxKQaqfxvE+izyQSW659YE1h?=
 =?us-ascii?Q?+BCamRwflWhxj530c27unIHhX9HJrwi/J22i+kqUjMCXg9vx0fKlWDwjmpBf?=
 =?us-ascii?Q?hymLe0ROb+/VysniA0yBQg0ihwgQTS/+xG89LONBSgMkjF77FBa5VZrTdvZE?=
 =?us-ascii?Q?s5C9Su/qgaLUw1Il7MvE/msOR2HMM5l/raR25UO4mU5O7ZWyJiWD0LPAe4ng?=
 =?us-ascii?Q?9FK0vjdWW+OM/w+IR+juz9ag+USDoXQcCf3UYc270wlxMauqqSZ3h6G9uoDn?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2470699-60d5-447b-1c9b-08db68d5bbdc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:38:59.4017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLVei9ShhDtFV3pB/ggdnExucW36ZS5PQGNHTKwwkq4BnVLTp4CvkclSfD8EbFJ+lCDuwpEEj3qYzN5YzXd9jVBIH/6tjnMlT5QAHcXoqaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9336
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

Remove CRYPTO_ALG_ALLOCATES_MEMORY flag and allocate the memory
needed by the driver, to fulfil a request, within the crypto
request object.
The extra size needed for base extended descriptor, hw
descriptor commands and link tables is computed in frontend
driver (caamalg_qi2) initialization and saved in reqsize field
that indicates how much memory could be needed per request.

In reqsize we allocate memory for maximum 4 entries
for src and 4 for dst, aligned.
If the driver needs more than the 4 entries maximum, the memory
is dynamically allocated, at runtime.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/caamalg_qi2.c | 421 ++++++++++++++++++++----------
 drivers/crypto/caam/caamalg_qi2.h |   6 +
 2 files changed, 293 insertions(+), 134 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 5c8d35edaa1c..5bf6e29ec2f5 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -367,17 +367,10 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	dma_addr_t qm_sg_dma, iv_dma = 0;
 	int ivsize = 0;
 	unsigned int authsize = ctx->authsize;
-	int qm_sg_index = 0, qm_sg_nents = 0, qm_sg_bytes;
+	int qm_sg_index = 0, qm_sg_nents = 0, qm_sg_bytes, edesc_size = 0;
 	int in_len, out_len;
 	struct dpaa2_sg_entry *sg_table;
 
-	/* allocate space for base edesc, link tables and IV */
-	edesc = qi_cache_zalloc(flags);
-	if (unlikely(!edesc)) {
-		dev_err(dev, "could not allocate extended descriptor\n");
-		return ERR_PTR(-ENOMEM);
-	}
-
 	if (unlikely(req->dst != req->src)) {
 		src_len = req->assoclen + req->cryptlen;
 		dst_len = src_len + (encrypt ? authsize : (-authsize));
@@ -386,7 +379,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		if (unlikely(src_nents < 0)) {
 			dev_err(dev, "Insufficient bytes (%d) in src S/G\n",
 				src_len);
-			qi_cache_free(edesc);
 			return ERR_PTR(src_nents);
 		}
 
@@ -394,7 +386,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		if (unlikely(dst_nents < 0)) {
 			dev_err(dev, "Insufficient bytes (%d) in dst S/G\n",
 				dst_len);
-			qi_cache_free(edesc);
 			return ERR_PTR(dst_nents);
 		}
 
@@ -403,7 +394,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 						      DMA_TO_DEVICE);
 			if (unlikely(!mapped_src_nents)) {
 				dev_err(dev, "unable to map source\n");
-				qi_cache_free(edesc);
 				return ERR_PTR(-ENOMEM);
 			}
 		} else {
@@ -417,7 +407,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 				dev_err(dev, "unable to map destination\n");
 				dma_unmap_sg(dev, req->src, src_nents,
 					     DMA_TO_DEVICE);
-				qi_cache_free(edesc);
 				return ERR_PTR(-ENOMEM);
 			}
 		} else {
@@ -431,7 +420,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		if (unlikely(src_nents < 0)) {
 			dev_err(dev, "Insufficient bytes (%d) in src S/G\n",
 				src_len);
-			qi_cache_free(edesc);
 			return ERR_PTR(src_nents);
 		}
 
@@ -439,7 +427,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 					      DMA_BIDIRECTIONAL);
 		if (unlikely(!mapped_src_nents)) {
 			dev_err(dev, "unable to map source\n");
-			qi_cache_free(edesc);
 			return ERR_PTR(-ENOMEM);
 		}
 	}
@@ -469,18 +456,35 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	else
 		qm_sg_nents = pad_sg_nents(qm_sg_nents);
 
-	sg_table = &edesc->sgt[0];
 	qm_sg_bytes = qm_sg_nents * sizeof(*sg_table);
-	if (unlikely(offsetof(struct aead_edesc, sgt) + qm_sg_bytes + ivsize >
-		     CAAM_QI_MEMCACHE_SIZE)) {
+
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = offsetof(struct aead_edesc, sgt) + qm_sg_bytes + ivsize;
+	if (unlikely(edesc_size > CAAM_QI_MEMCACHE_SIZE)) {
 		dev_err(dev, "No space for %d S/G entries and/or %dB IV\n",
 			qm_sg_nents, ivsize);
 		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, DMA_NONE, 0, 0);
-		qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
+	} else if (edesc_size > (crypto_aead_reqsize(aead) -
+				 sizeof(struct caam_request))) {
+		/* allocate space for base edesc, link tables and IV */
+		edesc = qi_cache_zalloc(flags);
+		if (unlikely(!edesc)) {
+			dev_err(dev, "could not allocate extended descriptor\n");
+			return ERR_PTR(-ENOMEM);
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc, link tables and IV */
+		edesc = (struct aead_edesc *)((u8 *)req_ctx +
+			 sizeof(struct caam_request));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
+	sg_table = &edesc->sgt[0];
+
 	if (ivsize) {
 		u8 *iv = (u8 *)(sg_table + qm_sg_nents);
 
@@ -492,7 +496,8 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 			dev_err(dev, "unable to map IV\n");
 			caam_unmap(dev, req->src, req->dst, src_nents,
 				   dst_nents, 0, 0, DMA_NONE, 0, 0);
-			qi_cache_free(edesc);
+			if (edesc->free)
+				qi_cache_free(edesc);
 			return ERR_PTR(-ENOMEM);
 		}
 	}
@@ -516,7 +521,8 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		dev_err(dev, "unable to map assoclen\n");
 		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, DMA_TO_DEVICE, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -538,7 +544,8 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		dma_unmap_single(dev, edesc->assoclen_dma, 4, DMA_TO_DEVICE);
 		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, DMA_TO_DEVICE, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1123,7 +1130,7 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req)
 	dma_addr_t iv_dma;
 	u8 *iv;
 	int ivsize = crypto_skcipher_ivsize(skcipher);
-	int dst_sg_idx, qm_sg_ents, qm_sg_bytes;
+	int dst_sg_idx, qm_sg_ents, qm_sg_bytes, edesc_size = 0;
 	struct dpaa2_sg_entry *sg_table;
 
 	src_nents = sg_nents_for_len(req->src, req->cryptlen);
@@ -1181,22 +1188,31 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req)
 		qm_sg_ents = 1 + pad_sg_nents(qm_sg_ents);
 
 	qm_sg_bytes = qm_sg_ents * sizeof(struct dpaa2_sg_entry);
-	if (unlikely(offsetof(struct skcipher_edesc, sgt) + qm_sg_bytes +
-		     ivsize > CAAM_QI_MEMCACHE_SIZE)) {
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = offsetof(struct skcipher_edesc, sgt) + qm_sg_bytes + ivsize;
+	if (unlikely(edesc_size > CAAM_QI_MEMCACHE_SIZE)) {
 		dev_err(dev, "No space for %d S/G entries and/or %dB IV\n",
 			qm_sg_ents, ivsize);
 		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, DMA_NONE, 0, 0);
 		return ERR_PTR(-ENOMEM);
-	}
-
-	/* allocate space for base edesc, link tables and IV */
-	edesc = qi_cache_zalloc(flags);
-	if (unlikely(!edesc)) {
-		dev_err(dev, "could not allocate extended descriptor\n");
-		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents, 0,
-			   0, DMA_NONE, 0, 0);
-		return ERR_PTR(-ENOMEM);
+	} else if (edesc_size > (crypto_skcipher_reqsize(skcipher) -
+				 sizeof(struct caam_request))) {
+		/* allocate space for base edesc, link tables and IV */
+		edesc = qi_cache_zalloc(flags);
+		if (unlikely(!edesc)) {
+			dev_err(dev, "could not allocate extended descriptor\n");
+			caam_unmap(dev, req->src, req->dst, src_nents,
+				   dst_nents, 0, 0, DMA_NONE, 0, 0);
+			return ERR_PTR(-ENOMEM);
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc, link tables and IV */
+		edesc = (struct skcipher_edesc *)((u8 *)req_ctx +
+			 sizeof(struct caam_request));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
 	/* Make sure IV is located in a DMAable area */
@@ -1209,7 +1225,8 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req)
 		dev_err(dev, "unable to map IV\n");
 		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, DMA_NONE, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1233,7 +1250,8 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req)
 		dev_err(dev, "unable to map S/G table\n");
 		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, DMA_BIDIRECTIONAL, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1297,7 +1315,8 @@ static void aead_encrypt_done(void *cbk_ctx, u32 status)
 		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	aead_unmap(ctx->dev, edesc, req);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	aead_request_complete(req, ecode);
 }
 
@@ -1318,7 +1337,8 @@ static void aead_decrypt_done(void *cbk_ctx, u32 status)
 		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	aead_unmap(ctx->dev, edesc, req);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	aead_request_complete(req, ecode);
 }
 
@@ -1344,7 +1364,8 @@ static int aead_encrypt(struct aead_request *req)
 	if (ret != -EINPROGRESS &&
 	    !(ret == -EBUSY && req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
 		aead_unmap(ctx->dev, edesc, req);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 	}
 
 	return ret;
@@ -1372,7 +1393,8 @@ static int aead_decrypt(struct aead_request *req)
 	if (ret != -EINPROGRESS &&
 	    !(ret == -EBUSY && req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
 		aead_unmap(ctx->dev, edesc, req);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 	}
 
 	return ret;
@@ -1422,7 +1444,8 @@ static void skcipher_encrypt_done(void *cbk_ctx, u32 status)
 		memcpy(req->iv, (u8 *)&edesc->sgt[0] + edesc->qm_sg_bytes,
 		       ivsize);
 
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	skcipher_request_complete(req, ecode);
 }
 
@@ -1460,7 +1483,8 @@ static void skcipher_decrypt_done(void *cbk_ctx, u32 status)
 		memcpy(req->iv, (u8 *)&edesc->sgt[0] + edesc->qm_sg_bytes,
 		       ivsize);
 
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	skcipher_request_complete(req, ecode);
 }
 
@@ -1516,7 +1540,8 @@ static int skcipher_encrypt(struct skcipher_request *req)
 	if (ret != -EINPROGRESS &&
 	    !(ret == -EBUSY && req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
 		skcipher_unmap(ctx->dev, edesc, req);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 	}
 
 	return ret;
@@ -1566,7 +1591,8 @@ static int skcipher_decrypt(struct skcipher_request *req)
 	if (ret != -EINPROGRESS &&
 	    !(ret == -EBUSY && req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
 		skcipher_unmap(ctx->dev, edesc, req);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 	}
 
 	return ret;
@@ -1607,7 +1633,15 @@ static int caam_cra_init_skcipher(struct crypto_skcipher *tfm)
 		container_of(alg, typeof(*caam_alg), skcipher);
 	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 	u32 alg_aai = caam_alg->caam.class1_alg_type & OP_ALG_AAI_MASK;
-	int ret = 0;
+	int ret = 0, extra_reqsize = 0;
+
+	/* Compute extra space needed for base edesc, link tables and IV */
+	extra_reqsize = sizeof(struct skcipher_edesc) +
+			/* link tables for src and dst:
+			 * 4 entries max + 1 for IV, aligned = 8
+			 */
+			(16 * sizeof(struct dpaa2_sg_entry)) +
+			AES_BLOCK_SIZE; /* ivsize */
 
 	if (alg_aai == OP_ALG_AAI_XTS) {
 		const char *tfm_name = crypto_tfm_alg_name(&tfm->base);
@@ -1625,10 +1659,12 @@ static int caam_cra_init_skcipher(struct crypto_skcipher *tfm)
 		ctx->fallback = fallback;
 		crypto_skcipher_set_reqsize_dma(
 			tfm, sizeof(struct caam_request) +
-			     crypto_skcipher_reqsize(fallback));
+			crypto_skcipher_reqsize(fallback +
+			extra_reqsize));
 	} else {
 		crypto_skcipher_set_reqsize_dma(tfm,
-						sizeof(struct caam_request));
+						sizeof(struct caam_request) +
+						extra_reqsize);
 	}
 
 	ret = caam_cra_init(ctx, &caam_alg->caam, false);
@@ -1644,7 +1680,18 @@ static int caam_cra_init_aead(struct crypto_aead *tfm)
 	struct caam_aead_alg *caam_alg = container_of(alg, typeof(*caam_alg),
 						      aead);
 
-	crypto_aead_set_reqsize_dma(tfm, sizeof(struct caam_request));
+	int extra_reqsize = 0;
+
+	/* Compute extra space needed for base edesc, link tables and IV */
+	extra_reqsize = sizeof(struct aead_edesc) +
+			/* link tables for src and dst:
+			 * 4 entries max + 1 for IV, aligned = 8
+			 */
+			(16 * sizeof(struct dpaa2_sg_entry)) +
+			AES_BLOCK_SIZE; /* ivsize */
+
+	crypto_aead_set_reqsize_dma(tfm, sizeof(struct caam_request) +
+				    extra_reqsize);
 	return caam_cra_init(crypto_aead_ctx_dma(tfm), &caam_alg->caam,
 			     !caam_alg->caam.nodkp);
 }
@@ -3013,8 +3060,7 @@ static void caam_skcipher_alg_init(struct caam_skcipher_alg *t_alg)
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
 	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
-	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
-			      CRYPTO_ALG_KERN_DRIVER_ONLY);
+	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY);
 
 	alg->init = caam_cra_init_skcipher;
 	alg->exit = caam_cra_exit;
@@ -3027,8 +3073,7 @@ static void caam_aead_alg_init(struct caam_aead_alg *t_alg)
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
 	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
-	alg->base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
-			      CRYPTO_ALG_KERN_DRIVER_ONLY;
+	alg->base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY;
 
 	alg->init = caam_cra_init_aead;
 	alg->exit = caam_cra_exit_aead;
@@ -3413,7 +3458,8 @@ static void ahash_done(void *cbk_ctx, u32 status)
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_FROM_DEVICE);
 	memcpy(req->result, state->caam_ctx, digestsize);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 
 	print_hex_dump_debug("ctx@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
@@ -3438,7 +3484,8 @@ static void ahash_done_bi(void *cbk_ctx, u32 status)
 		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_BIDIRECTIONAL);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 
 	scatterwalk_map_and_copy(state->buf, req->src,
 				 req->nbytes - state->next_buflen,
@@ -3478,7 +3525,8 @@ static void ahash_done_ctx_src(void *cbk_ctx, u32 status)
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_BIDIRECTIONAL);
 	memcpy(req->result, state->caam_ctx, digestsize);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 
 	print_hex_dump_debug("ctx@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
@@ -3503,7 +3551,8 @@ static void ahash_done_ctx_dst(void *cbk_ctx, u32 status)
 		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_FROM_DEVICE);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 
 	scatterwalk_map_and_copy(state->buf, req->src,
 				 req->nbytes - state->next_buflen,
@@ -3541,7 +3590,7 @@ static int ahash_update_ctx(struct ahash_request *req)
 	int in_len = *buflen + req->nbytes, to_hash;
 	int src_nents, mapped_nents, qm_sg_bytes, qm_sg_src_index;
 	struct ahash_edesc *edesc;
-	int ret = 0;
+	int ret = 0, edesc_size = 0;
 
 	*next_buflen = in_len & (crypto_tfm_alg_blocksize(&ahash->base) - 1);
 	to_hash = in_len - *next_buflen;
@@ -3567,18 +3616,31 @@ static int ahash_update_ctx(struct ahash_request *req)
 			mapped_nents = 0;
 		}
 
-		/* allocate space for base edesc and link tables */
-		edesc = qi_cache_zalloc(flags);
-		if (!edesc) {
-			dma_unmap_sg(ctx->dev, req->src, src_nents,
-				     DMA_TO_DEVICE);
-			return -ENOMEM;
-		}
-
-		edesc->src_nents = src_nents;
 		qm_sg_src_index = 1 + (*buflen ? 1 : 0);
 		qm_sg_bytes = pad_sg_nents(qm_sg_src_index + mapped_nents) *
 			      sizeof(*sg_table);
+
+		/* Check if there's enough space for edesc saved in req */
+		edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+		if (edesc_size > (crypto_ahash_reqsize(ahash) -
+				  sizeof(struct caam_hash_state))) {
+			/* allocate space for base edesc and link tables */
+			edesc = qi_cache_zalloc(flags);
+			if (!edesc) {
+				dma_unmap_sg(ctx->dev, req->src, src_nents,
+					     DMA_TO_DEVICE);
+				return -ENOMEM;
+			}
+			edesc->free = true;
+		} else {
+			/* get address for base edesc and link tables */
+			edesc = (struct ahash_edesc *)((u8 *)state +
+				 sizeof(struct caam_hash_state));
+			/* clear memory */
+			memset(edesc, 0, sizeof(*edesc));
+		}
+
+		edesc->src_nents = src_nents;
 		sg_table = &edesc->sgt[0];
 
 		ret = ctx_map_to_qm_sg(ctx->dev, state, ctx->ctx_len, sg_table,
@@ -3640,7 +3702,8 @@ static int ahash_update_ctx(struct ahash_request *req)
 	return ret;
 unmap_ctx:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_BIDIRECTIONAL);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -3655,18 +3718,31 @@ static int ahash_final_ctx(struct ahash_request *req)
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
 	int buflen = state->buflen;
-	int qm_sg_bytes;
+	int qm_sg_bytes, edesc_size = 0;
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct ahash_edesc *edesc;
 	struct dpaa2_sg_entry *sg_table;
 	int ret;
 
-	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(flags);
-	if (!edesc)
-		return -ENOMEM;
-
 	qm_sg_bytes = pad_sg_nents(1 + (buflen ? 1 : 0)) * sizeof(*sg_table);
+
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+	if (edesc_size > (crypto_ahash_reqsize(ahash) -
+			  sizeof(struct caam_hash_state))) {
+		/* allocate space for base edesc and link tables */
+		edesc = qi_cache_zalloc(flags);
+		if (!edesc)
+			return -ENOMEM;
+		edesc->free = true;
+	} else {
+		/* get address for base edesc and link tables */
+		edesc = (struct ahash_edesc *)((u8 *)state +
+			 sizeof(struct caam_hash_state));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
+	}
+
 	sg_table = &edesc->sgt[0];
 
 	ret = ctx_map_to_qm_sg(ctx->dev, state, ctx->ctx_len, sg_table,
@@ -3711,7 +3787,8 @@ static int ahash_final_ctx(struct ahash_request *req)
 
 unmap_ctx:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_BIDIRECTIONAL);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -3726,7 +3803,7 @@ static int ahash_finup_ctx(struct ahash_request *req)
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
 	int buflen = state->buflen;
-	int qm_sg_bytes, qm_sg_src_index;
+	int qm_sg_bytes, qm_sg_src_index, edesc_size = 0;
 	int src_nents, mapped_nents;
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct ahash_edesc *edesc;
@@ -3750,17 +3827,31 @@ static int ahash_finup_ctx(struct ahash_request *req)
 		mapped_nents = 0;
 	}
 
-	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(flags);
-	if (!edesc) {
-		dma_unmap_sg(ctx->dev, req->src, src_nents, DMA_TO_DEVICE);
-		return -ENOMEM;
-	}
-
-	edesc->src_nents = src_nents;
 	qm_sg_src_index = 1 + (buflen ? 1 : 0);
 	qm_sg_bytes = pad_sg_nents(qm_sg_src_index + mapped_nents) *
 		      sizeof(*sg_table);
+
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+	if (edesc_size > (crypto_ahash_reqsize(ahash) -
+			  sizeof(struct caam_hash_state))) {
+		/* allocate space for base edesc and link tables */
+		edesc = qi_cache_zalloc(flags);
+		if (!edesc) {
+			dma_unmap_sg(ctx->dev, req->src, src_nents,
+				     DMA_TO_DEVICE);
+			return -ENOMEM;
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc and link tables */
+		edesc = (struct ahash_edesc *)((u8 *)state +
+			 sizeof(struct caam_hash_state));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
+	}
+
+	edesc->src_nents = src_nents;
 	sg_table = &edesc->sgt[0];
 
 	ret = ctx_map_to_qm_sg(ctx->dev, state, ctx->ctx_len, sg_table,
@@ -3805,7 +3896,8 @@ static int ahash_finup_ctx(struct ahash_request *req)
 
 unmap_ctx:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_BIDIRECTIONAL);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -3820,8 +3912,9 @@ static int ahash_digest(struct ahash_request *req)
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
 	int digestsize = crypto_ahash_digestsize(ahash);
-	int src_nents, mapped_nents;
+	int src_nents, mapped_nents, qm_sg_bytes, edesc_size = 0;
 	struct ahash_edesc *edesc;
+	struct dpaa2_sg_entry *sg_table;
 	int ret = -ENOMEM;
 
 	state->buf_dma = 0;
@@ -3843,21 +3936,33 @@ static int ahash_digest(struct ahash_request *req)
 		mapped_nents = 0;
 	}
 
-	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(flags);
-	if (!edesc) {
-		dma_unmap_sg(ctx->dev, req->src, src_nents, DMA_TO_DEVICE);
-		return ret;
+	qm_sg_bytes = pad_sg_nents(mapped_nents) * sizeof(*sg_table);
+
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+	if (edesc_size > (crypto_ahash_reqsize(ahash) -
+			  sizeof(struct caam_hash_state))) {
+		/* allocate space for base edesc and link tables */
+		edesc = qi_cache_zalloc(flags);
+		if (!edesc) {
+			dma_unmap_sg(ctx->dev, req->src, src_nents,
+				     DMA_TO_DEVICE);
+			return ret;
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc and link tables */
+		edesc = (struct ahash_edesc *)((u8 *)state +
+			 sizeof(struct caam_hash_state));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
 	edesc->src_nents = src_nents;
 	memset(&req_ctx->fd_flt, 0, sizeof(req_ctx->fd_flt));
 
 	if (mapped_nents > 1) {
-		int qm_sg_bytes;
-		struct dpaa2_sg_entry *sg_table = &edesc->sgt[0];
-
-		qm_sg_bytes = pad_sg_nents(mapped_nents) * sizeof(*sg_table);
+		sg_table = &edesc->sgt[0];
 		sg_to_qm_sg_last(req->src, req->nbytes, sg_table, 0);
 		edesc->qm_sg_dma = dma_map_single(ctx->dev, sg_table,
 						  qm_sg_bytes, DMA_TO_DEVICE);
@@ -3900,7 +4005,8 @@ static int ahash_digest(struct ahash_request *req)
 
 unmap:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_FROM_DEVICE);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -3912,18 +4018,17 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 	struct caam_request *req_ctx = &state->caam_req;
 	struct dpaa2_fl_entry *in_fle = &req_ctx->fd_flt[1];
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
-	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
-		      GFP_KERNEL : GFP_ATOMIC;
 	u8 *buf = state->buf;
 	int buflen = state->buflen;
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct ahash_edesc *edesc;
 	int ret = -ENOMEM;
 
-	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(flags);
-	if (!edesc)
-		return ret;
+	/* get address for base edesc and link tables */
+	edesc = (struct ahash_edesc *)((u8 *)state +
+		 sizeof(struct caam_hash_state));
+	/* clear memory */
+	memset(edesc, 0, sizeof(*edesc));
 
 	if (buflen) {
 		state->buf_dma = dma_map_single(ctx->dev, buf, buflen,
@@ -3973,7 +4078,6 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 
 unmap:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_FROM_DEVICE);
-	qi_cache_free(edesc);
 	return ret;
 }
 
@@ -3991,7 +4095,7 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 	int *buflen = &state->buflen;
 	int *next_buflen = &state->next_buflen;
 	int in_len = *buflen + req->nbytes, to_hash;
-	int qm_sg_bytes, src_nents, mapped_nents;
+	int qm_sg_bytes, src_nents, mapped_nents, edesc_size = 0;
 	struct ahash_edesc *edesc;
 	int ret = 0;
 
@@ -4019,17 +4123,30 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 			mapped_nents = 0;
 		}
 
-		/* allocate space for base edesc and link tables */
-		edesc = qi_cache_zalloc(flags);
-		if (!edesc) {
-			dma_unmap_sg(ctx->dev, req->src, src_nents,
-				     DMA_TO_DEVICE);
-			return -ENOMEM;
+		qm_sg_bytes = pad_sg_nents(1 + mapped_nents) *
+			      sizeof(*sg_table);
+
+		/* Check if there's enough space for edesc saved in req */
+		edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+		if (edesc_size > (crypto_ahash_reqsize(ahash) -
+				  sizeof(struct caam_hash_state))) {
+			/* allocate space for base edesc and link tables */
+			edesc = qi_cache_zalloc(flags);
+			if (!edesc) {
+				dma_unmap_sg(ctx->dev, req->src, src_nents,
+					     DMA_TO_DEVICE);
+				return -ENOMEM;
+			}
+			edesc->free = true;
+		} else {
+			/* get address for base edesc and link tables */
+			edesc = (struct ahash_edesc *)((u8 *)state +
+				 sizeof(struct caam_hash_state));
+			/* clear memory */
+			memset(edesc, 0, sizeof(*edesc));
 		}
 
 		edesc->src_nents = src_nents;
-		qm_sg_bytes = pad_sg_nents(1 + mapped_nents) *
-			      sizeof(*sg_table);
 		sg_table = &edesc->sgt[0];
 
 		ret = buf_map_to_qm_sg(ctx->dev, sg_table, state);
@@ -4094,7 +4211,8 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 	return ret;
 unmap_ctx:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_TO_DEVICE);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -4109,7 +4227,7 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
 	int buflen = state->buflen;
-	int qm_sg_bytes, src_nents, mapped_nents;
+	int qm_sg_bytes, src_nents, mapped_nents, edesc_size = 0;
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct ahash_edesc *edesc;
 	struct dpaa2_sg_entry *sg_table;
@@ -4132,15 +4250,29 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 		mapped_nents = 0;
 	}
 
-	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(flags);
-	if (!edesc) {
-		dma_unmap_sg(ctx->dev, req->src, src_nents, DMA_TO_DEVICE);
-		return ret;
+	qm_sg_bytes = pad_sg_nents(2 + mapped_nents) * sizeof(*sg_table);
+
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+	if (edesc_size > (crypto_ahash_reqsize(ahash) -
+			  sizeof(struct caam_hash_state))) {
+		/* allocate space for base edesc and link tables */
+		edesc = qi_cache_zalloc(flags);
+		if (!edesc) {
+			dma_unmap_sg(ctx->dev, req->src, src_nents,
+				     DMA_TO_DEVICE);
+			return ret;
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc and link tables */
+		edesc = (struct ahash_edesc *)((u8 *)state +
+			 sizeof(struct caam_hash_state));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
 	edesc->src_nents = src_nents;
-	qm_sg_bytes = pad_sg_nents(2 + mapped_nents) * sizeof(*sg_table);
 	sg_table = &edesc->sgt[0];
 
 	ret = buf_map_to_qm_sg(ctx->dev, sg_table, state);
@@ -4190,7 +4322,8 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 	return ret;
 unmap:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_FROM_DEVICE);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -4208,7 +4341,7 @@ static int ahash_update_first(struct ahash_request *req)
 	int *buflen = &state->buflen;
 	int *next_buflen = &state->next_buflen;
 	int to_hash;
-	int src_nents, mapped_nents;
+	int src_nents, mapped_nents, qm_sg_bytes, edesc_size = 0;
 	struct ahash_edesc *edesc;
 	int ret = 0;
 
@@ -4237,12 +4370,26 @@ static int ahash_update_first(struct ahash_request *req)
 			mapped_nents = 0;
 		}
 
-		/* allocate space for base edesc and link tables */
-		edesc = qi_cache_zalloc(flags);
-		if (!edesc) {
-			dma_unmap_sg(ctx->dev, req->src, src_nents,
-				     DMA_TO_DEVICE);
-			return -ENOMEM;
+		qm_sg_bytes = pad_sg_nents(mapped_nents) * sizeof(*sg_table);
+
+		/* Check if there's enough space for edesc saved in req */
+		edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+		if (edesc_size > (crypto_ahash_reqsize(ahash) -
+				  sizeof(struct caam_hash_state))) {
+			/* allocate space for base edesc and link tables */
+			edesc = qi_cache_zalloc(flags);
+			if (!edesc) {
+				dma_unmap_sg(ctx->dev, req->src, src_nents,
+					     DMA_TO_DEVICE);
+				return -ENOMEM;
+			}
+			edesc->free = true;
+		} else {
+			/* get address for base edesc and link tables */
+			edesc = (struct ahash_edesc *)((u8 *)state +
+				 sizeof(struct caam_hash_state));
+			/* clear memory */
+			memset(edesc, 0, sizeof(*edesc));
 		}
 
 		edesc->src_nents = src_nents;
@@ -4253,11 +4400,7 @@ static int ahash_update_first(struct ahash_request *req)
 		dpaa2_fl_set_len(in_fle, to_hash);
 
 		if (mapped_nents > 1) {
-			int qm_sg_bytes;
-
 			sg_to_qm_sg_last(req->src, src_len, sg_table, 0);
-			qm_sg_bytes = pad_sg_nents(mapped_nents) *
-				      sizeof(*sg_table);
 			edesc->qm_sg_dma = dma_map_single(ctx->dev, sg_table,
 							  qm_sg_bytes,
 							  DMA_TO_DEVICE);
@@ -4319,7 +4462,8 @@ static int ahash_update_first(struct ahash_request *req)
 	return ret;
 unmap_ctx:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_TO_DEVICE);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -4566,7 +4710,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 					 HASH_MSG_LEN + 64,
 					 HASH_MSG_LEN + SHA512_DIGEST_SIZE };
 	dma_addr_t dma_addr;
-	int i;
+	int i, extra_reqsize = 0;
 
 	ctx->dev = caam_hash->dev;
 
@@ -4604,7 +4748,16 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 				   OP_ALG_ALGSEL_SUBMASK) >>
 				  OP_ALG_ALGSEL_SHIFT];
 
-	crypto_ahash_set_reqsize_dma(ahash, sizeof(struct caam_hash_state));
+	/* Compute extra space needed for base edesc and link tables */
+	extra_reqsize = sizeof(struct ahash_edesc) +
+			/* link tables for src:
+			 * 4 entries max + max 2 for remaining buf, aligned = 8
+			 */
+			(8 * sizeof(struct dpaa2_sg_entry));
+
+	crypto_ahash_set_reqsize_dma(ahash,
+				     sizeof(struct caam_hash_state) +
+				     extra_reqsize);
 
 	/*
 	 * For keyed hash algorithms shared descriptors
@@ -4659,7 +4812,7 @@ static struct caam_hash_alg *caam_hash_alloc(struct device *dev,
 	alg->cra_priority = CAAM_CRA_PRIORITY;
 	alg->cra_blocksize = template->blocksize;
 	alg->cra_alignmask = 0;
-	alg->cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY;
+	alg->cra_flags = CRYPTO_ALG_ASYNC;
 
 	t_alg->alg_type = template->alg_type;
 	t_alg->dev = dev;
diff --git a/drivers/crypto/caam/caamalg_qi2.h b/drivers/crypto/caam/caamalg_qi2.h
index abb502bb675c..c700438de9e6 100644
--- a/drivers/crypto/caam/caamalg_qi2.h
+++ b/drivers/crypto/caam/caamalg_qi2.h
@@ -100,6 +100,7 @@ struct dpaa2_caam_priv_per_cpu {
  * @dst_nents: number of segments in output scatterlist
  * @iv_dma: dma address of iv for checking continuity and link table
  * @qm_sg_bytes: length of dma mapped h/w link table
+ * @free: stored to determine if aead_edesc needs to be freed
  * @qm_sg_dma: bus physical mapped address of h/w link table
  * @assoclen: associated data length, in CAAM endianness
  * @assoclen_dma: bus physical mapped address of req->assoclen
@@ -110,6 +111,7 @@ struct aead_edesc {
 	int dst_nents;
 	dma_addr_t iv_dma;
 	int qm_sg_bytes;
+	bool free;
 	dma_addr_t qm_sg_dma;
 	unsigned int assoclen;
 	dma_addr_t assoclen_dma;
@@ -122,6 +124,7 @@ struct aead_edesc {
  * @dst_nents: number of segments in output scatterlist
  * @iv_dma: dma address of iv for checking continuity and link table
  * @qm_sg_bytes: length of dma mapped qm_sg space
+ * @free: stored to determine if skcipher_edesc needs to be freed
  * @qm_sg_dma: I/O virtual address of h/w link table
  * @sgt: the h/w link table, followed by IV
  */
@@ -130,6 +133,7 @@ struct skcipher_edesc {
 	int dst_nents;
 	dma_addr_t iv_dma;
 	int qm_sg_bytes;
+	bool free;
 	dma_addr_t qm_sg_dma;
 	struct dpaa2_sg_entry sgt[];
 };
@@ -139,12 +143,14 @@ struct skcipher_edesc {
  * @qm_sg_dma: I/O virtual address of h/w link table
  * @src_nents: number of segments in input scatterlist
  * @qm_sg_bytes: length of dma mapped qm_sg space
+ * @free: stored to determine if ahash_edesc needs to be freed
  * @sgt: pointer to h/w link table
  */
 struct ahash_edesc {
 	dma_addr_t qm_sg_dma;
 	int src_nents;
 	int qm_sg_bytes;
+	bool free;
 	struct dpaa2_sg_entry sgt[];
 };
 
-- 
2.25.1

