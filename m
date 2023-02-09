Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1B2690902
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjBIMhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjBIMhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:37:04 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E9F5A9E3;
        Thu,  9 Feb 2023 04:37:01 -0800 (PST)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PCGXQ2yNTznW3J;
        Thu,  9 Feb 2023 20:34:46 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Feb 2023 20:36:59 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH v2 5/5] crypto: hisilicon/qm - fix coding style issues
Date:   Thu, 9 Feb 2023 20:36:17 +0800
Message-ID: <20230209123617.30545-6-qianweili@huawei.com>
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

1. Remove extra blank lines.
2. Remove extra spaces.
3. Use spaces instead of tabs around '=' and '\',
to ensure consistent coding styles.
4. Macros should be capital letters, change 'QM_SQC_VFT_NUM_MASK_v2'
to 'QM_SQC_VFT_NUM_MASK_V2'.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c  | 29 ++++++++++++-----------------
 drivers/crypto/hisilicon/sgl.c |  1 -
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 6ce69e8eba82..04b2d382267a 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -116,7 +116,7 @@
 #define QM_SQC_VFT_BASE_SHIFT_V2	28
 #define QM_SQC_VFT_BASE_MASK_V2		GENMASK(15, 0)
 #define QM_SQC_VFT_NUM_SHIFT_V2		45
-#define QM_SQC_VFT_NUM_MASK_v2		GENMASK(9, 0)
+#define QM_SQC_VFT_NUM_MASK_V2		GENMASK(9, 0)
 
 #define QM_ABNORMAL_INT_SOURCE		0x100000
 #define QM_ABNORMAL_INT_MASK		0x100004
@@ -230,23 +230,23 @@
 #define QM_AUTOSUSPEND_DELAY		3000
 
 #define QM_MK_CQC_DW3_V1(hop_num, pg_sz, buf_sz, cqe_sz) \
-	(((hop_num) << QM_CQ_HOP_NUM_SHIFT)	| \
-	((pg_sz) << QM_CQ_PAGE_SIZE_SHIFT)	| \
-	((buf_sz) << QM_CQ_BUF_SIZE_SHIFT)	| \
+	(((hop_num) << QM_CQ_HOP_NUM_SHIFT) | \
+	((pg_sz) << QM_CQ_PAGE_SIZE_SHIFT) | \
+	((buf_sz) << QM_CQ_BUF_SIZE_SHIFT) | \
 	((cqe_sz) << QM_CQ_CQE_SIZE_SHIFT))
 
 #define QM_MK_CQC_DW3_V2(cqe_sz, cq_depth) \
 	((((u32)cq_depth) - 1) | ((cqe_sz) << QM_CQ_CQE_SIZE_SHIFT))
 
 #define QM_MK_SQC_W13(priority, orders, alg_type) \
-	(((priority) << QM_SQ_PRIORITY_SHIFT)	| \
-	((orders) << QM_SQ_ORDERS_SHIFT)	| \
+	(((priority) << QM_SQ_PRIORITY_SHIFT) | \
+	((orders) << QM_SQ_ORDERS_SHIFT) | \
 	(((alg_type) & QM_SQ_TYPE_MASK) << QM_SQ_TYPE_SHIFT))
 
 #define QM_MK_SQC_DW3_V1(hop_num, pg_sz, buf_sz, sqe_sz) \
-	(((hop_num) << QM_SQ_HOP_NUM_SHIFT)	| \
-	((pg_sz) << QM_SQ_PAGE_SIZE_SHIFT)	| \
-	((buf_sz) << QM_SQ_BUF_SIZE_SHIFT)	| \
+	(((hop_num) << QM_SQ_HOP_NUM_SHIFT) | \
+	((pg_sz) << QM_SQ_PAGE_SIZE_SHIFT) | \
+	((buf_sz) << QM_SQ_BUF_SIZE_SHIFT) | \
 	((u32)ilog2(sqe_sz) << QM_SQ_SQE_SIZE_SHIFT))
 
 #define QM_MK_SQC_DW3_V2(sqe_sz, sq_depth) \
@@ -706,7 +706,7 @@ static void qm_db_v2(struct hisi_qm *qm, u16 qn, u8 cmd, u16 index, u8 priority)
 
 	doorbell = qn | ((u64)cmd << QM_DB_CMD_SHIFT_V2) |
 		   ((u64)randata << QM_DB_RAND_SHIFT_V2) |
-		   ((u64)index << QM_DB_INDEX_SHIFT_V2)	 |
+		   ((u64)index << QM_DB_INDEX_SHIFT_V2) |
 		   ((u64)priority << QM_DB_PRIORITY_SHIFT_V2);
 
 	writeq(doorbell, io_base);
@@ -1304,7 +1304,7 @@ static int qm_get_vft_v2(struct hisi_qm *qm, u32 *base, u32 *number)
 	sqc_vft = readl(qm->io_base + QM_MB_CMD_DATA_ADDR_L) |
 		  ((u64)readl(qm->io_base + QM_MB_CMD_DATA_ADDR_H) << 32);
 	*base = QM_SQC_VFT_BASE_MASK_V2 & (sqc_vft >> QM_SQC_VFT_BASE_SHIFT_V2);
-	*number = (QM_SQC_VFT_NUM_MASK_v2 &
+	*number = (QM_SQC_VFT_NUM_MASK_V2 &
 		   (sqc_vft >> QM_SQC_VFT_NUM_SHIFT_V2)) + 1;
 
 	return 0;
@@ -3195,7 +3195,6 @@ static int qm_stop_started_qp(struct hisi_qm *qm)
 	return 0;
 }
 
-
 /**
  * qm_clear_queues() - Clear all queues memory in a qm.
  * @qm: The qm in which the queues will be cleared.
@@ -3679,7 +3678,7 @@ static ssize_t qm_algqos_read(struct file *filp, char __user *buf,
 	qos_val = ir / QM_QOS_RATE;
 	ret = scnprintf(tbuf, QM_DBG_READ_LEN, "%u\n", qos_val);
 
-	ret =  simple_read_from_buffer(buf, count, pos, tbuf, ret);
+	ret = simple_read_from_buffer(buf, count, pos, tbuf, ret);
 
 err_get_status:
 	clear_bit(QM_RESETTING, &qm->misc_ctl);
@@ -4176,13 +4175,10 @@ static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
 	if (!qm->err_status.is_dev_ecc_mbit &&
 	    qm->err_status.is_qm_ecc_mbit &&
 	    qm->err_ini->close_axi_master_ooo) {
-
 		qm->err_ini->close_axi_master_ooo(qm);
-
 	} else if (qm->err_status.is_dev_ecc_mbit &&
 		   !qm->err_status.is_qm_ecc_mbit &&
 		   !qm->err_ini->close_axi_master_ooo) {
-
 		nfe_enb = readl(qm->io_base + QM_RAS_NFE_ENABLE);
 		writel(nfe_enb & QM_RAS_NFE_MBIT_DISABLE,
 		       qm->io_base + QM_RAS_NFE_ENABLE);
@@ -4630,7 +4626,6 @@ static irqreturn_t qm_abnormal_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-
 /**
  * hisi_qm_dev_shutdown() - Shutdown device.
  * @pdev: The device will be shutdown.
diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index 2b6f2281cfd6..a07257a7e75f 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -250,7 +250,6 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
 		dev_err(dev, "Get SGL error!\n");
 		dma_unmap_sg(dev, sgl, sg_n, DMA_BIDIRECTIONAL);
 		return ERR_PTR(-ENOMEM);
-
 	}
 	curr_hw_sgl->entry_length_in_sgl = cpu_to_le16(pool->sge_nr);
 	curr_hw_sge = curr_hw_sgl->sge_entries;
-- 
2.33.0

