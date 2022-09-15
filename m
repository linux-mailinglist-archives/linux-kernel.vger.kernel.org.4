Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B9F5B9235
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIOBhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiIOBhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:37:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895A98C460
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:37:14 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSfpD4RmtzNmGP;
        Thu, 15 Sep 2022 09:32:36 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 15 Sep 2022 09:37:12 +0800
Received: from huawei.com (10.69.192.56) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 15 Sep
 2022 09:37:12 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH 5/5] hisi_acc_vfio_pci: Fix some clean code issues
Date:   Thu, 15 Sep 2022 09:31:57 +0800
Message-ID: <20220915013157.60771-6-liulongfang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220915013157.60771-1-liulongfang@huawei.com>
References: <20220915013157.60771-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Fix some code comments
2.Fix some code style issues
3.Delete an unused macro definition

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 40 +++++++++----------
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  1 -
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index fce49c7f5db8..c4857e171da9 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
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
 
@@ -640,15 +640,16 @@ static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vde
 static void
 hisi_acc_vf_state_mutex_unlock(struct hisi_acc_vf_core_device *hisi_acc_vdev)
 {
-again:
-	spin_lock(&hisi_acc_vdev->reset_lock);
-	if (hisi_acc_vdev->deferred_reset) {
+	while (true) {
+		spin_lock(&hisi_acc_vdev->reset_lock);
+		if (!hisi_acc_vdev->deferred_reset)
+			break;
+
 		hisi_acc_vdev->deferred_reset = false;
 		spin_unlock(&hisi_acc_vdev->reset_lock);
 		hisi_acc_vdev->vf_qm_state = QM_NOT_READY;
 		hisi_acc_vdev->mig_state = VFIO_DEVICE_STATE_RUNNING;
 		hisi_acc_vf_disable_fds(hisi_acc_vdev);
-		goto again;
 	}
 	mutex_unlock(&hisi_acc_vdev->state_mutex);
 	spin_unlock(&hisi_acc_vdev->reset_lock);
@@ -709,10 +710,9 @@ static ssize_t hisi_acc_vf_resume_write(struct file *filp, const char __user *bu
 
 	if (pos)
 		return -ESPIPE;
-	pos = &filp->f_pos;
 
-	if (*pos < 0 ||
-	    check_add_overflow((loff_t)len, *pos, &requested_length))
+	if (filp->f_pos < 0 ||
+	    check_add_overflow((loff_t)len, filp->f_pos, &requested_length))
 		return -EINVAL;
 
 	if (requested_length > sizeof(struct acc_vf_data))
@@ -729,7 +729,7 @@ static ssize_t hisi_acc_vf_resume_write(struct file *filp, const char __user *bu
 		done = -EFAULT;
 		goto out_unlock;
 	}
-	*pos += len;
+	filp->f_pos += len;
 	done = len;
 	migf->total_length += len;
 out_unlock:
@@ -772,14 +772,14 @@ static ssize_t hisi_acc_vf_save_read(struct file *filp, char __user *buf, size_t
 {
 	struct hisi_acc_vf_migration_file *migf = filp->private_data;
 	ssize_t done = 0;
+	size_t min_len;
 	int ret;
 
 	if (pos)
 		return -ESPIPE;
-	pos = &filp->f_pos;
 
 	mutex_lock(&migf->lock);
-	if (*pos > migf->total_length) {
+	if (filp->f_pos > migf->total_length) {
 		done = -EINVAL;
 		goto out_unlock;
 	}
@@ -789,15 +789,15 @@ static ssize_t hisi_acc_vf_save_read(struct file *filp, char __user *buf, size_t
 		goto out_unlock;
 	}
 
-	len = min_t(size_t, migf->total_length - *pos, len);
-	if (len) {
-		ret = copy_to_user(buf, &migf->vf_data, len);
+	min_len = min_t(size_t, migf->total_length - filp->f_pos, len);
+	if (min_len) {
+		ret = copy_to_user(buf, &migf->vf_data, min_len);
 		if (ret) {
 			done = -EFAULT;
 			goto out_unlock;
 		}
-		*pos += len;
-		done = len;
+		filp->f_pos += min_len;
+		done = min_len;
 	}
 out_unlock:
 	mutex_unlock(&migf->lock);
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
index 5494f4983bbe..8e4bf21deae1 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
@@ -16,7 +16,6 @@
 #define SEC_CORE_INT_STATUS		0x301008
 #define HPRE_HAC_INT_STATUS		0x301800
 #define HZIP_CORE_INT_STATUS		0x3010AC
-#define QM_QUE_ISO_CFG			0x301154
 
 #define QM_VFT_CFG_RDY			0x10006c
 #define QM_VFT_CFG_OP_WR		0x100058
-- 
2.33.0

