Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F026908FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjBIMhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjBIMhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:37:02 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD77B5775A;
        Thu,  9 Feb 2023 04:37:00 -0800 (PST)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PCGZc5Sqpzdb9f;
        Thu,  9 Feb 2023 20:36:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Feb 2023 20:36:58 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH v2 4/5] crypto: hisilicon/qm - update comments to match function
Date:   Thu, 9 Feb 2023 20:36:16 +0800
Message-ID: <20230209123617.30545-5-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230209123617.30545-1-qianweili@huawei.com>
References: <20230209123617.30545-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return values of some functions have been modified,
but the comments have not been modified together. The
comments must be updated to be consistent with the functions.

Also move comments over the codes instead of right place
to ensure consistent coding styles.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 5 ++---
 include/linux/hisi_acc_qm.h   | 3 ++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index f108a74e3b7f..6ce69e8eba82 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1892,8 +1892,7 @@ static struct hisi_qp *qm_create_qp_nolock(struct hisi_qm *qm, u8 alg_type)
  * @qm: The qm we create a qp from.
  * @alg_type: Accelerator specific algorithm type in sqc.
  *
- * return created qp, -EBUSY if all qps in qm allocated, -ENOMEM if allocating
- * qp memory fails.
+ * Return created qp, negative error code if failed.
  */
 static struct hisi_qp *hisi_qm_create_qp(struct hisi_qm *qm, u8 alg_type)
 {
@@ -2062,7 +2061,7 @@ static int qm_start_qp_nolock(struct hisi_qp *qp, unsigned long arg)
  * @arg: Accelerator specific argument.
  *
  * After this function, qp can receive request from user. Return 0 if
- * successful, Return -EBUSY if failed.
+ * successful, negative error code if failed.
  */
 int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg)
 {
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index a9e75b7a0636..a7d54d4d41fd 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -322,7 +322,8 @@ struct hisi_qm {
 	const struct hisi_qm_err_ini *err_ini;
 	struct hisi_qm_err_info err_info;
 	struct hisi_qm_err_status err_status;
-	unsigned long misc_ctl; /* driver removing and reset sched */
+	/* driver removing and reset sched */
+	unsigned long misc_ctl;
 	/* Device capability bit */
 	unsigned long caps;
 
-- 
2.33.0

