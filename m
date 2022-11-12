Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7239626839
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 09:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiKLI5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 03:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:57:17 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EF231ECA;
        Sat, 12 Nov 2022 00:57:14 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N8Tw829FDz15MW4;
        Sat, 12 Nov 2022 16:56:56 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
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
Subject: [PATCH 2/2] crypto: hisilicon/sec - remove continuous blank lines
Date:   Sat, 12 Nov 2022 08:51:05 +0000
Message-ID: <20221112085105.7644-3-yekai13@huawei.com>
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

From: Wenkai Lin <linwenkai6@hisilicon.com>

Fix that put two or more continuous blank lines inside function.

Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 1 -
 drivers/crypto/hisilicon/sec2/sec_main.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index a2630ddc0294..f5bfc9755a4a 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -283,7 +283,6 @@ static int sec_bd_send(struct sec_ctx *ctx, struct sec_req *req)
 
 	spin_lock_bh(&qp_ctx->req_lock);
 	ret = hisi_qp_send(qp_ctx->qp, &req->sec_sqe);
-
 	if (ctx->fake_req_limit <=
 	    atomic_read(&qp_ctx->qp->qp_status.used) && !ret) {
 		list_add_tail(&req->backlog_head, &qp_ctx->backlog);
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 4e24735d95ba..93572c0d4faa 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -427,7 +427,6 @@ static void sec_set_endian(struct hisi_qm *qm)
 	if (!IS_ENABLED(CONFIG_64BIT))
 		reg |= BIT(1);
 
-
 	if (!IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
 		reg |= BIT(0);
 
-- 
2.17.1

