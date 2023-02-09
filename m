Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B730690903
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjBIMhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBIMhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:37:06 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D065ACC9;
        Thu,  9 Feb 2023 04:37:04 -0800 (PST)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PCGXx5zhPzJsLd;
        Thu,  9 Feb 2023 20:35:13 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Feb 2023 20:36:56 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH v2 1/5] crypto: hisilicon/qm - remove some unused defines
Date:   Thu, 9 Feb 2023 20:36:13 +0800
Message-ID: <20230209123617.30545-2-qianweili@huawei.com>
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

1. Remove some macros define since it is not used.
2. Remove enum QM_HW_UNKNOWN since it is not used.
3. Remove unused member 'is_frozen' in 'hisi_qm' structure.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 10 ----------
 include/linux/hisi_acc_qm.h   |  2 --
 2 files changed, 12 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 58d023f6fba3..4e277168b48d 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -95,8 +95,6 @@
 #define QM_VFT_CFG_RDY			0x10006c
 #define QM_VFT_CFG_OP_WR		0x100058
 #define QM_VFT_CFG_TYPE			0x10005c
-#define QM_SQC_VFT			0x0
-#define QM_CQC_VFT			0x1
 #define QM_VFT_CFG			0x100060
 #define QM_VFT_CFG_OP_ENABLE		0x100054
 #define QM_PM_CTRL			0x100148
@@ -164,7 +162,6 @@
 
 /* interfunction communication */
 #define QM_IFC_READY_STATUS		0x100128
-#define QM_IFC_C_STS_M			0x10012C
 #define QM_IFC_INT_SET_P		0x100130
 #define QM_IFC_INT_CFG			0x100134
 #define QM_IFC_INT_SOURCE_P		0x100138
@@ -198,7 +195,6 @@
 
 #define PCI_BAR_2			2
 #define PCI_BAR_4			4
-#define QM_SQE_DATA_ALIGN_MASK		GENMASK(6, 0)
 #define QMC_ALIGN(sz)			ALIGN(sz, 32)
 
 #define QM_DBG_READ_LEN		256
@@ -212,8 +208,6 @@
 #define QM_DRIVER_REMOVING		0
 #define QM_RST_SCHED			1
 #define QM_QOS_PARAM_NUM		2
-#define QM_QOS_VAL_NUM			1
-#define QM_QOS_BDF_PARAM_NUM		4
 #define QM_QOS_MAX_VAL			1000
 #define QM_QOS_RATE			100
 #define QM_QOS_EXPAND_RATE		1000
@@ -225,18 +219,14 @@
 #define QM_SHAPER_FACTOR_CBS_B_SHIFT	15
 #define QM_SHAPER_FACTOR_CBS_S_SHIFT	19
 #define QM_SHAPER_CBS_B			1
-#define QM_SHAPER_CBS_S			16
 #define QM_SHAPER_VFT_OFFSET		6
-#define WAIT_FOR_QOS_VF			100
 #define QM_QOS_MIN_ERROR_RATE		5
-#define QM_QOS_TYPICAL_NUM		8
 #define QM_SHAPER_MIN_CBS_S		8
 #define QM_QOS_TICK			0x300U
 #define QM_QOS_DIVISOR_CLK		0x1f40U
 #define QM_QOS_MAX_CIR_B		200
 #define QM_QOS_MIN_CIR_B		100
 #define QM_QOS_MAX_CIR_U		6
-#define QM_QOS_MAX_CIR_S		11
 #define QM_AUTOSUSPEND_DELAY		3000
 
 #define QM_MK_CQC_DW3_V1(hop_num, pg_sz, buf_sz, cqe_sz) \
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index d08bff0f87f9..a9e75b7a0636 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -122,7 +122,6 @@ enum qp_state {
 };
 
 enum qm_hw_ver {
-	QM_HW_UNKNOWN = -1,
 	QM_HW_V1 = 0x20,
 	QM_HW_V2 = 0x21,
 	QM_HW_V3 = 0x30,
@@ -346,7 +345,6 @@ struct hisi_qm {
 
 	const char *algs;
 	bool use_sva;
-	bool is_frozen;
 
 	resource_size_t phys_base;
 	resource_size_t db_phys_base;
-- 
2.33.0

