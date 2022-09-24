Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC4B5E876C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 04:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiIXC0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 22:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiIXC0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:26:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF8013A073
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 19:26:12 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MZCTH4lXSzWgq4;
        Sat, 24 Sep 2022 10:22:11 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 10:26:11 +0800
Received: from huawei.com (10.69.192.56) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 10:26:10 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v3 5/5] hisi_acc_vfio_pci: Update some log and comment formats
Date:   Sat, 24 Sep 2022 10:20:49 +0800
Message-ID: <20220924022049.12022-6-liulongfang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220924022049.12022-1-liulongfang@huawei.com>
References: <20220924022049.12022-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Modify some annotation information formats to keep the
entire driver annotation format consistent.
2. Modify some log description formats to be consistent with
the format of the entire driver log.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 18 +++++++++---------
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h |  6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 24c03ff41502..cc4256c9a472 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -16,7 +16,7 @@
 
 #include "hisi_acc_vfio_pci.h"
 
-/* return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
+/* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
 static int qm_wait_dev_not_ready(struct hisi_qm *qm)
 {
 	u32 val;
@@ -189,7 +189,7 @@ static int qm_set_regs(struct hisi_qm *qm, struct acc_vf_data *vf_data)
 	struct device *dev = &qm->pdev->dev;
 	int ret;
 
-	/* check VF state */
+	/* Check VF state */
 	if (unlikely(hisi_qm_wait_mb_ready(qm))) {
 		dev_err(&qm->pdev->dev, "QM device is not ready to write\n");
 		return -EBUSY;
@@ -381,7 +381,7 @@ static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 		return -EINVAL;
 	}
 
-	/* vf qp num check */
+	/* VF qp num check */
 	ret = qm_get_vft(vf_qm, &vf_qm->qp_base);
 	if (ret <= 0) {
 		dev_err(dev, "failed to get vft qp nums\n");
@@ -395,7 +395,7 @@ static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 
 	vf_qm->qp_num = ret;
 
-	/* vf isolation state check */
+	/* VF isolation state check */
 	ret = qm_read_regs(pf_qm, QM_QUE_ISO_CFG_V, &que_iso_state, 1);
 	if (ret) {
 		dev_err(dev, "failed to read QM_QUE_ISO_CFG_V\n");
@@ -426,10 +426,10 @@ static int vf_qm_get_match_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 	int ret;
 
 	vf_data->acc_magic = ACC_DEV_MAGIC;
-	/* save device id */
+	/* Save device id */
 	vf_data->dev_id = hisi_acc_vdev->vf_dev->device;
 
-	/* vf qp num save from PF */
+	/* VF qp num save from PF */
 	ret = pf_qm_get_qp_num(pf_qm, vf_id, &vf_data->qp_base);
 	if (ret <= 0) {
 		dev_err(dev, "failed to get vft qp nums!\n");
@@ -473,19 +473,19 @@ static int vf_qm_load_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 
 	ret = qm_set_regs(qm, vf_data);
 	if (ret) {
-		dev_err(dev, "Set VF regs failed\n");
+		dev_err(dev, "set VF regs failed\n");
 		return ret;
 	}
 
 	ret = hisi_qm_mb(qm, QM_MB_CMD_SQC_BT, qm->sqc_dma, 0, 0);
 	if (ret) {
-		dev_err(dev, "Set sqc failed\n");
+		dev_err(dev, "set sqc failed\n");
 		return ret;
 	}
 
 	ret = hisi_qm_mb(qm, QM_MB_CMD_CQC_BT, qm->cqc_dma, 0, 0);
 	if (ret) {
-		dev_err(dev, "Set cqc failed\n");
+		dev_err(dev, "set cqc failed\n");
 		return ret;
 	}
 
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
index 8e4bf21deae1..67343325b320 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
@@ -79,7 +79,7 @@ struct acc_vf_data {
 	/* QM reserved 5 regs */
 	u32 qm_rsv_regs[5];
 	u32 padding;
-	/* qm memory init information */
+	/* QM memory init information */
 	u64 eqe_dma;
 	u64 aeqe_dma;
 	u64 sqc_dma;
@@ -98,7 +98,7 @@ struct hisi_acc_vf_migration_file {
 struct hisi_acc_vf_core_device {
 	struct vfio_pci_core_device core_device;
 	u8 deferred_reset:1;
-	/* for migration state */
+	/* For migration state */
 	struct mutex state_mutex;
 	enum vfio_device_mig_state mig_state;
 	struct pci_dev *pf_dev;
@@ -107,7 +107,7 @@ struct hisi_acc_vf_core_device {
 	struct hisi_qm vf_qm;
 	u32 vf_qm_state;
 	int vf_id;
-	/* for reset handler */
+	/* For reset handler */
 	spinlock_t reset_lock;
 	struct hisi_acc_vf_migration_file *resuming_migf;
 	struct hisi_acc_vf_migration_file *saving_migf;
-- 
2.33.0

