Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2784E62683A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 09:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiKLI5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 03:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiKLI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:57:17 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E488E31DDC;
        Sat, 12 Nov 2022 00:57:13 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N8TwB5KrJzRp4J;
        Sat, 12 Nov 2022 16:56:58 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 16:57:12 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 12 Nov
 2022 16:57:12 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yekai13@huawei.com>
Subject: [PATCH 1/2] crypto: hisilicon/sec - fix spelling mistake 'ckeck' -> 'check'
Date:   Sat, 12 Nov 2022 08:51:04 +0000
Message-ID: <20221112085105.7644-2-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221112085105.7644-1-yekai13@huawei.com>
References: <20221112085105.7644-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of spelling mistakes in sec2. Fix them.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 84ae8ddd1a13..a2630ddc0294 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -2009,7 +2009,7 @@ static int sec_aead_sha512_ctx_init(struct crypto_aead *tfm)
 	return sec_aead_ctx_init(tfm, "sha512");
 }
 
-static int sec_skcipher_cryptlen_ckeck(struct sec_ctx *ctx,
+static int sec_skcipher_cryptlen_check(struct sec_ctx *ctx,
 	struct sec_req *sreq)
 {
 	u32 cryptlen = sreq->c_req.sk_req->cryptlen;
@@ -2071,7 +2071,7 @@ static int sec_skcipher_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 		}
 		return 0;
 	} else if (c_alg == SEC_CALG_AES || c_alg == SEC_CALG_SM4) {
-		return sec_skcipher_cryptlen_ckeck(ctx, sreq);
+		return sec_skcipher_cryptlen_check(ctx, sreq);
 	}
 
 	dev_err(dev, "skcipher algorithm error!\n");
-- 
2.17.1

