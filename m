Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1BA72972A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbjFIKmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbjFIKlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:41:24 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2079.outbound.protection.outlook.com [40.107.249.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EE73C33;
        Fri,  9 Jun 2023 03:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPts9aNUWX+lbBiAanDP8vJerXLvZHLnLPpUP9kP32LpPzfmBrbiuqa3hnPvQfK+o4HMGCxDAa3PU6bF13I0c2b55aTdb509w7fFLPoaEOob1/5sxKRC4XRirhIfwRI33zCj7NlxfW+VKxZMkWFqaMm58E6RRXwMacZ7gvRKR8HqZqArFycu4XXVifCKJXA9bMqEP7K0Brq9HETEDLmHsFANzHIasWQkfvV7+onQvjxeUDZmho7chLJkBt78FjTPySNq24hrn7P9q1M9GPc/MsGw7XTahsslPNFw1gNemeKKyiGlNCgxcf/1n9VeccTN6qOxg+CCoFW0a21xwBnyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu8jzSMkF9yxfT2BNRjd5cCY827hkMYZdemRxzoK0Xc=;
 b=VSIbupQFrvIWRaDulxBCXAfs06BAs1m43AhQx0IzbC4Bbjw1i6i/Vr8jvmC2TYwgnGqxFklmg4OYZcSTMoNeLpD3ESThEpgL7n8cfCpUOLobMYAtcKrDbY3OqsX6Us2mvwVQ31qF2p0OgZ/MjiGRh7fQLz6Bf1KFHSfT2Nf66Le7kE0CAyF1IJhi/KY3kn7u8CkJ9B3oGe+O9N4DhJXBvjcQ1Hy4/6CRxdp/tPQuo1H/r6ouiMR7IKp2896ewWzG4GnUkZMZjRH/CV8EWUNIBBq1JP2d6diDNK3/lYeVvm+H0RmxFevn3yWLVQJtF1d20ZmfTVCxTpvYnJoLWYW8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu8jzSMkF9yxfT2BNRjd5cCY827hkMYZdemRxzoK0Xc=;
 b=RoHva5H7u+hkABe+Ndavu/+99IudY4Zw1G8UGpWsGe37+EZU1NNlGAhA0o8ugTk4i7mEkm2GgSSRJOPkWoTTIeHzNP69OPrgcWT+LF+DlUfzcWqjW/hx9pKHGN7X65UO+wIlOsTU01WXkSohQ8IvjXD1Ls6AuLGgYtqN5Bl8dgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS1PR04MB9336.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 10:38:57 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 10:38:58 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, iuliana.prodan@nxp.com
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v2 4/5] crypto: caam/qi - avoid allocating memory at crypto request runtime
Date:   Fri,  9 Jun 2023 12:38:41 +0200
Message-Id: <20230609103842.4159321-5-meenakshi.aggarwal@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 106823bc-1a47-4941-9b89-08db68d5bb94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rEd4Z7mLBuJzI1DerUskAJIYiIb2WsXN51ivEBYoFiXfCvreXsXTxHQDdIFS5oNBa5eYduRC/DMoJZdZdNgHP81ura/Ze43iJGViyeXn6pbGD3xKkD3zoV94VOV9TnT3l1ycreoSERFw4KTyGEAco2XBch+v6GyYw7YX9olWrnhE6ccKoitjDuiqj/1n4Plypu6E4X/U9mdGvMEsiaVq/xKwyxiq6cTJrvh06b8NxJHgaQICi4sFNXW5GfDNKb8oGfENrh0jBPRgJ83pSGzWsFzv51ORkPIxgfKk+pOz5OyAnAm2DUuth2erWIGNAGVHdJwW5wnyx76AUC9zZ2QL6e01GHOxlfGJRAlqdUp0eihrwVq2qdCz34xz0k/T42FSXN4Q8d2X0By3YebrEJOLmVMozI82R/udB9Y7MZwkfYFldWvLG9pQHT+Fdg4z9n6evte7BeqV7X1ac8YkiAaKETOwEOfZAukyXgdogCeToVdjc81KE6UpvtEiKQ0iDxHBE+xVgaqEjeT4ki6NX/7qsVHQJP8jxoupNXDfUhfPsZG2anmJU8ouJBLZsyqnx6IhXjFzBpBV3UOXp6LsnacX1d+NETxICbgVApMc5bT40EMHvg1xxMtQQdZcV75hZ0u0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(66946007)(66476007)(2906002)(30864003)(478600001)(4326008)(8936002)(8676002)(316002)(41300700001)(5660300002)(66556008)(6666004)(6486002)(52116002)(9686003)(6506007)(26005)(6512007)(1076003)(186003)(2616005)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d+vxV9zCtmEE9QfYpDAwtrWMwTJSLBQcCuYF3UbH6bx3F/7VwIez/grElboc?=
 =?us-ascii?Q?7uZKV/gdKka6i0QE5slQV8fBqR6tPwPBcGT6e8RH3M57Z6NGD9sdZV0S9oyW?=
 =?us-ascii?Q?zKKafcpvFdQ2wjFKzcHxCGN0zTRgL+uYgzAFSY/eTKV/kW7U80xId27X/Gdr?=
 =?us-ascii?Q?s2E+S8+ZC5HUVqZpBgnyf/OOmU7f81leRT8IqHO0K0uGGMBlTple5Opt6mtY?=
 =?us-ascii?Q?Xb3HmOPk2DVQBcxou7JbdUa6e/8TnD3BUQYRklC6sSaDc3DRSNr4FoMtXHEv?=
 =?us-ascii?Q?f/kb6J1war9TvGJIkoxv/Fxxshdshdb1txwq62oKr4cX6IK+AJF0AvD6tYat?=
 =?us-ascii?Q?Q1TVIXDnupK5khxZ9sBR8byoa6b/RmUF+8RzdgfLi73SS+nMSEqoSdEN9sze?=
 =?us-ascii?Q?qsIKESvmV08LRpBFfKq4YMq8jlU3pVfP7fnPg5QrpldHb2kUagOI7pCeCL1U?=
 =?us-ascii?Q?q/piQJInt+381DtOHXQS7j9/Sd4a72VRpb7i/Q+a/3S0xpC5ZkBiuEYZrI8t?=
 =?us-ascii?Q?UMxLxJUkmU/A8KsR/opP2EwywcRgMY7N9jrL3kUoJ9kDpWGe++iPNJOvITat?=
 =?us-ascii?Q?Yf6S9hdO0wMbyfs8/fKow2YVHPHA91Q0/xJDG9D3NvGZcE0lUS/SjR/bbpVH?=
 =?us-ascii?Q?MDztQuS0HdnUNneLiEfDHG0FDN0Ltv3QMlNc7yEd6EJ8M6Gdb7WtmKP1WrnK?=
 =?us-ascii?Q?kO2ewFWgQXhxlHkaMMthU4RSHnLEWlVdCLkMLyayZfJNN4bjhfYG4aFNAlmJ?=
 =?us-ascii?Q?Mpv2jEPHYMq/ZdZG9EfM0NhguJjKBM800fR+d2kMsAGL4PbW8s9Jq40e9NhP?=
 =?us-ascii?Q?YmKytuKSGoxb+boydMi9skvdXszBc0tnHR2m/8MPLgZEmcy/Vp4+yjpq6RHU?=
 =?us-ascii?Q?v6DC+7STU/ZE4GwNaRw2UqElcuhHk1EdTC02aNtw+t2L1O3y3FlryTLMzpR0?=
 =?us-ascii?Q?aC0ZeP6b2E3IXOSP0hHblWpZ7cG5ayO4zNTYT5+vjOIwPTST4IzgXp7c5rLb?=
 =?us-ascii?Q?wQSxPSdJvvmspJRtE5wQEz5MNlydLoQwJ8AkrCRestwC0e9aKPUFN0DUeh3C?=
 =?us-ascii?Q?zYM9BdAfbpxX9+AHHw35cuW4PhrULrK8UMZxT68cloDdJzDVudmo8qg4TI+d?=
 =?us-ascii?Q?pmgfv0BG1VSp35cpuGrrkPhaoaaCsMvGbQhRsFetV30pb+qtsh6h0evPy2II?=
 =?us-ascii?Q?v9g1XqoetPYZWdEEFfPDrZAnTe5/+H3iL4gf0D9VZvHYzKfgoqQhdDGJmckW?=
 =?us-ascii?Q?FTDPA836jw6GCSQq9lOP0UnarUv/tMp224cEmtqXSsormcyhvFusaWqIytUG?=
 =?us-ascii?Q?14djkM419iNTVBRZdOiJmo/p1RpoZiKL22mRpTZOMLOXK/iHUsqHMwULqPU5?=
 =?us-ascii?Q?8gOE2flzAloEaMu8LhI7SFPphtx+ZOxqGhxpJnpJi7UbSHAGhtmOXCYHTYo2?=
 =?us-ascii?Q?mpuk2q/14eoYgmm1MlM6L/H2EdAZ3noz7+hHHPD+n1Q3OzytvsC5nA3xNtKV?=
 =?us-ascii?Q?pXWeUoS48E8wYHUeuLfvIolk/dekjcbyf0NSSHtvAKvPv7h6lS2SDIgiv+ED?=
 =?us-ascii?Q?Lycdp64ehSYGwVBHAyfcy3eihGjPic/c5Waqyl9UmYBXFS2+wk5i4muDEApj?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106823bc-1a47-4941-9b89-08db68d5bb94
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:38:58.9047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0mAe7uwMzD5gmsSkj7kHSshL/SEuuZQ1M5A8HmyHKw+nhQMLxRkrFDj7LliVIepKYL76KNTidDnB1rIdEZb8GMMAa+uFGwZ5fgfjU7EZuk=
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
driver (caamalg_qi) initialization and saved in reqsize field
that indicates how much memory could be needed per request.

In reqsize we allocate memory for maximum 4 entries
for src and 4 for dst, aligned.
If the driver needs more than the 4 entries maximum, the memory
is dynamically allocated, at runtime.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/caamalg_qi.c | 131 +++++++++++++++++++++----------
 1 file changed, 89 insertions(+), 42 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 743ce50c14f2..d7078f37ef9f 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -793,6 +793,7 @@ static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
  * @dst_nents: number of segments in output scatterlist
  * @iv_dma: dma address of iv for checking continuity and link table
  * @qm_sg_bytes: length of dma mapped h/w link table
+ * @free: stored to determine if aead_edesc needs to be freed
  * @qm_sg_dma: bus physical mapped address of h/w link table
  * @assoclen: associated data length, in CAAM endianness
  * @assoclen_dma: bus physical mapped address of req->assoclen
@@ -804,6 +805,7 @@ struct aead_edesc {
 	int dst_nents;
 	dma_addr_t iv_dma;
 	int qm_sg_bytes;
+	bool free;
 	dma_addr_t qm_sg_dma;
 	unsigned int assoclen;
 	dma_addr_t assoclen_dma;
@@ -817,6 +819,7 @@ struct aead_edesc {
  * @dst_nents: number of segments in output scatterlist
  * @iv_dma: dma address of iv for checking continuity and link table
  * @qm_sg_bytes: length of dma mapped h/w link table
+ * @free: stored to determine if skcipher_edesc needs to be freed
  * @qm_sg_dma: bus physical mapped address of h/w link table
  * @drv_req: driver-specific request structure
  * @sgt: the h/w link table, followed by IV
@@ -826,6 +829,7 @@ struct skcipher_edesc {
 	int dst_nents;
 	dma_addr_t iv_dma;
 	int qm_sg_bytes;
+	bool free;
 	dma_addr_t qm_sg_dma;
 	struct caam_drv_req drv_req;
 	struct qm_sg_entry sgt[];
@@ -932,7 +936,8 @@ static void aead_done(struct caam_drv_req *drv_req, u32 status)
 	aead_unmap(qidev, edesc, aead_req);
 
 	aead_request_complete(aead_req, ecode);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 }
 
 /*
@@ -954,7 +959,7 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	dma_addr_t qm_sg_dma, iv_dma = 0;
 	int ivsize = 0;
 	unsigned int authsize = ctx->authsize;
-	int qm_sg_index = 0, qm_sg_ents = 0, qm_sg_bytes;
+	int qm_sg_index = 0, qm_sg_ents = 0, qm_sg_bytes, edesc_size = 0;
 	int in_len, out_len;
 	struct qm_sg_entry *sg_table, *fd_sgt;
 	struct caam_drv_ctx *drv_ctx;
@@ -963,13 +968,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	if (IS_ERR(drv_ctx))
 		return (struct aead_edesc *)drv_ctx;
 
-	/* allocate space for base edesc and hw desc commands, link tables */
-	edesc = qi_cache_alloc(flags);
-	if (unlikely(!edesc)) {
-		dev_err(qidev, "could not allocate extended descriptor\n");
-		return ERR_PTR(-ENOMEM);
-	}
-
 	if (likely(req->src == req->dst)) {
 		src_len = req->assoclen + req->cryptlen +
 			  (encrypt ? authsize : 0);
@@ -978,7 +976,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		if (unlikely(src_nents < 0)) {
 			dev_err(qidev, "Insufficient bytes (%d) in src S/G\n",
 				src_len);
-			qi_cache_free(edesc);
 			return ERR_PTR(src_nents);
 		}
 
@@ -986,7 +983,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 					      DMA_BIDIRECTIONAL);
 		if (unlikely(!mapped_src_nents)) {
 			dev_err(qidev, "unable to map source\n");
-			qi_cache_free(edesc);
 			return ERR_PTR(-ENOMEM);
 		}
 	} else {
@@ -997,7 +993,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		if (unlikely(src_nents < 0)) {
 			dev_err(qidev, "Insufficient bytes (%d) in src S/G\n",
 				src_len);
-			qi_cache_free(edesc);
 			return ERR_PTR(src_nents);
 		}
 
@@ -1005,7 +1000,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		if (unlikely(dst_nents < 0)) {
 			dev_err(qidev, "Insufficient bytes (%d) in dst S/G\n",
 				dst_len);
-			qi_cache_free(edesc);
 			return ERR_PTR(dst_nents);
 		}
 
@@ -1014,7 +1008,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 						      src_nents, DMA_TO_DEVICE);
 			if (unlikely(!mapped_src_nents)) {
 				dev_err(qidev, "unable to map source\n");
-				qi_cache_free(edesc);
 				return ERR_PTR(-ENOMEM);
 			}
 		} else {
@@ -1029,7 +1022,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 				dev_err(qidev, "unable to map destination\n");
 				dma_unmap_sg(qidev, req->src, src_nents,
 					     DMA_TO_DEVICE);
-				qi_cache_free(edesc);
 				return ERR_PTR(-ENOMEM);
 			}
 		} else {
@@ -1061,18 +1053,35 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	else
 		qm_sg_ents = pad_sg_nents(qm_sg_ents);
 
-	sg_table = &edesc->sgt[0];
 	qm_sg_bytes = qm_sg_ents * sizeof(*sg_table);
-	if (unlikely(offsetof(struct aead_edesc, sgt) + qm_sg_bytes + ivsize >
-		     CAAM_QI_MEMCACHE_SIZE)) {
+
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = offsetof(struct aead_edesc, sgt) + qm_sg_bytes + ivsize;
+	if (unlikely(edesc_size > CAAM_QI_MEMCACHE_SIZE)) {
 		dev_err(qidev, "No space for %d S/G entries and/or %dB IV\n",
 			qm_sg_ents, ivsize);
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, DMA_NONE, 0, 0);
-		qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
+	} else if (edesc_size > crypto_aead_reqsize(aead)) {
+		/* allocate space for base edesc, link tables and IV */
+		edesc = qi_cache_alloc(flags);
+		if (unlikely(!edesc)) {
+			dev_err(qidev, "could not allocate extended descriptor\n");
+			caam_unmap(qidev, req->src, req->dst, src_nents,
+				   dst_nents, 0, 0, DMA_NONE, 0, 0);
+			return ERR_PTR(-ENOMEM);
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc, link tables and IV */
+		edesc = (struct aead_edesc *)((u8 *)aead_request_ctx(req));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
+	sg_table = &edesc->sgt[0];
+
 	if (ivsize) {
 		u8 *iv = (u8 *)(sg_table + qm_sg_ents);
 
@@ -1084,7 +1093,8 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 			dev_err(qidev, "unable to map IV\n");
 			caam_unmap(qidev, req->src, req->dst, src_nents,
 				   dst_nents, 0, 0, DMA_NONE, 0, 0);
-			qi_cache_free(edesc);
+			if (edesc->free)
+				qi_cache_free(edesc);
 			return ERR_PTR(-ENOMEM);
 		}
 	}
@@ -1103,7 +1113,8 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		dev_err(qidev, "unable to map assoclen\n");
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, DMA_TO_DEVICE, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1125,7 +1136,8 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		dma_unmap_single(qidev, edesc->assoclen_dma, 4, DMA_TO_DEVICE);
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, DMA_TO_DEVICE, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1179,7 +1191,8 @@ static inline int aead_crypt(struct aead_request *req, bool encrypt)
 		ret = -EINPROGRESS;
 	} else {
 		aead_unmap(ctx->qidev, edesc, req);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 	}
 
 	return ret;
@@ -1247,7 +1260,8 @@ static void skcipher_done(struct caam_drv_req *drv_req, u32 status)
 	if (!ecode)
 		memcpy(req->iv, skcipher_edesc_iv(edesc), ivsize);
 
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	skcipher_request_complete(req, ecode);
 }
 
@@ -1333,21 +1347,28 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 	len = ALIGN(len, dma_get_cache_alignment());
 	len += ivsize;
 
+	/* Check if there's enough space for edesc saved in req */
 	if (unlikely(len > CAAM_QI_MEMCACHE_SIZE)) {
 		dev_err(qidev, "No space for %d S/G entries and/or %dB IV\n",
 			qm_sg_ents, ivsize);
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, DMA_NONE, 0, 0);
 		return ERR_PTR(-ENOMEM);
-	}
-
-	/* allocate space for base edesc, link tables and IV */
-	edesc = qi_cache_alloc(flags);
-	if (unlikely(!edesc)) {
-		dev_err(qidev, "could not allocate extended descriptor\n");
-		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents, 0,
-			   0, DMA_NONE, 0, 0);
-		return ERR_PTR(-ENOMEM);
+	} else if (len > crypto_skcipher_reqsize(skcipher)) {
+		/* allocate space for base edesc, link tables and IV */
+		edesc = qi_cache_alloc(flags);
+		if (unlikely(!edesc)) {
+			dev_err(qidev, "could not allocate extended descriptor\n");
+			caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents, 0,
+				   0, DMA_NONE, 0, 0);
+			return ERR_PTR(-ENOMEM);
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc, link tables and IV */
+		edesc = (struct skcipher_edesc *)((u8 *)skcipher_request_ctx(req));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
 	edesc->src_nents = src_nents;
@@ -1367,7 +1388,8 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 		dev_err(qidev, "unable to map IV\n");
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, DMA_NONE, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1388,7 +1410,8 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 		dev_err(qidev, "unable to map S/G table\n");
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, DMA_BIDIRECTIONAL, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1462,7 +1485,8 @@ static inline int skcipher_crypt(struct skcipher_request *req, bool encrypt)
 		ret = -EINPROGRESS;
 	} else {
 		skcipher_unmap(ctx->qidev, edesc, req);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 	}
 
 	return ret;
@@ -2509,7 +2533,16 @@ static int caam_cra_init(struct crypto_skcipher *tfm)
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
+			16 * sizeof(struct qm_sg_entry);
+	extra_reqsize += ALIGN(extra_reqsize, dma_get_cache_alignment());
+	extra_reqsize += AES_BLOCK_SIZE; /* ivsize */
 
 	if (alg_aai == OP_ALG_AAI_XTS) {
 		const char *tfm_name = crypto_tfm_alg_name(&tfm->base);
@@ -2525,7 +2558,10 @@ static int caam_cra_init(struct crypto_skcipher *tfm)
 
 		ctx->fallback = fallback;
 		crypto_skcipher_set_reqsize(tfm, sizeof(struct caam_skcipher_req_ctx) +
-					    crypto_skcipher_reqsize(fallback));
+					    crypto_skcipher_reqsize(fallback) +
+					    extra_reqsize);
+	} else {
+		crypto_skcipher_set_reqsize(tfm, extra_reqsize);
 	}
 
 	ret = caam_init_common(ctx, &caam_alg->caam, false);
@@ -2541,6 +2577,19 @@ static int caam_aead_init(struct crypto_aead *tfm)
 	struct caam_aead_alg *caam_alg = container_of(alg, typeof(*caam_alg),
 						      aead);
 	struct caam_ctx *ctx = crypto_aead_ctx_dma(tfm);
+	int extra_reqsize = 0;
+
+	/* Compute extra space needed for base edesc, link tables and IV */
+	extra_reqsize = sizeof(struct aead_edesc) +
+			/* link tables for src and dst:
+			 * 4 entries max + 1 for IV, aligned = 8
+			 */
+			(16 * sizeof(struct qm_sg_entry)) +
+			AES_BLOCK_SIZE; /* ivsize */
+	/*
+	 * Set the size for the space needed for base edesc, link tables, IV
+	 */
+	crypto_aead_set_reqsize(tfm, extra_reqsize);
 
 	return caam_init_common(ctx, &caam_alg->caam, !caam_alg->caam.nodkp);
 }
@@ -2596,8 +2645,7 @@ static void caam_skcipher_alg_init(struct caam_skcipher_alg *t_alg)
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
 	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
-	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
-				CRYPTO_ALG_KERN_DRIVER_ONLY);
+	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY);
 
 	alg->init = caam_cra_init;
 	alg->exit = caam_cra_exit;
@@ -2610,8 +2658,7 @@ static void caam_aead_alg_init(struct caam_aead_alg *t_alg)
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
 	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
-	alg->base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
-			      CRYPTO_ALG_KERN_DRIVER_ONLY;
+	alg->base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY;
 
 	alg->init = caam_aead_init;
 	alg->exit = caam_aead_exit;
-- 
2.25.1

