Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0642A6AD7CA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCGGzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjCGGza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:55:30 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAE080E26;
        Mon,  6 Mar 2023 22:55:28 -0800 (PST)
X-UUID: 0738119ebcb511eda06fc9ecc4dadd91-20230307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pHGHKAwQd1WEvEXFU29yMv2c1eVVLkDWNjDDTsG87iE=;
        b=qcfjyt/wtirOgv6j1TrP6KOLHy64GBggq1RBual95vBpJ2SBSSHPrwRxoN4KVbD74ihI29PtAMyqRfvmVG5JDLyXXYHA7G9McKmuCM2e600KIMseFHdGOJV0SvlYYmKvBGXN3Pt/CJgL3YW05iP00/+xw2pjTIVKgdgoCRftym8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:10b8e614-8f6f-44a3-8352-00a463dceb9c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:9bfc9027-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 0738119ebcb511eda06fc9ecc4dadd91-20230307
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1855069430; Tue, 07 Mar 2023 14:55:21 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 7 Mar 2023 14:55:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 7 Mar 2023 14:55:20 +0800
From:   Po-Wen Kao <powen.kao@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <eddie.huang@mediatek.com>, <mason.zhang@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>
Subject: [PATCH v4 4/5] scsi: ufs: core: Export symbols for MTK driver module
Date:   Tue, 7 Mar 2023 14:54:45 +0800
Message-ID: <20230307065448.15279-5-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230307065448.15279-1-powen.kao@mediatek.com>
References: <20230307065448.15279-1-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export
- ufshcd_mcq_config_mac
- ufshcd_mcq_make_queues_operational
- ufshcd_mcq_read_cqis
- ufshcd_disable_intr

Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/core/ufs-mcq.c     | 3 +++
 drivers/ufs/core/ufshcd-priv.h | 2 --
 drivers/ufs/core/ufshcd.c      | 3 ++-
 include/ufs/ufshcd.h           | 5 +++++
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index c7b807f58dca..2e1956455d36 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -92,6 +92,7 @@ void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds)
 	val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds);
 	ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
 }
+EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);
 
 /**
  * ufshcd_mcq_req_to_hwq - find the hardware queue on which the
@@ -242,6 +243,7 @@ u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i)
 {
 	return readl(mcq_opr_base(hba, OPR_CQIS, i) + REG_CQIS);
 }
+EXPORT_SYMBOL_GPL(ufshcd_mcq_read_cqis);
 
 void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i)
 {
@@ -372,6 +374,7 @@ void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
 			      MCQ_CFG_n(REG_SQATTR, i));
 	}
 }
+EXPORT_SYMBOL_GPL(ufshcd_mcq_make_queues_operational);
 
 void ufshcd_mcq_enable_esi(struct ufs_hba *hba)
 {
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 529f8507a5e4..ffafcac329a8 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -66,8 +66,6 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
 int ufshcd_mcq_init(struct ufs_hba *hba);
 int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
 int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
-void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
-void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds);
 void ufshcd_mcq_select_mcq_mode(struct ufs_hba *hba);
 u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i);
 void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8c62d92228ed..5893cd90eee3 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2570,7 +2570,7 @@ static void ufshcd_enable_intr(struct ufs_hba *hba, u32 intrs)
  * @hba: per adapter instance
  * @intrs: interrupt bits
  */
-static void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
+void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
 {
 	u32 set = ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 
@@ -2586,6 +2586,7 @@ static void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
 
 	ufshcd_writel(hba, set, REG_INTERRUPT_ENABLE);
 }
+EXPORT_SYMBOL_GPL(ufshcd_disable_intr);
 
 /**
  * ufshcd_prepare_req_desc_hdr - Fill UTP Transfer request descriptor header according to request
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index ed72c0a2d432..002b813147d6 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1231,6 +1231,7 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 
 int ufshcd_alloc_host(struct device *, struct ufs_hba **);
 void ufshcd_dealloc_host(struct ufs_hba *);
+void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs);
 int ufshcd_hba_enable(struct ufs_hba *hba);
 int ufshcd_init(struct ufs_hba *, void __iomem *, unsigned int);
 int ufshcd_link_recovery(struct ufs_hba *hba);
@@ -1243,9 +1244,13 @@ void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct clk *refclk);
 void ufshcd_update_evt_hist(struct ufs_hba *hba, u32 id, u32 val);
 void ufshcd_hba_stop(struct ufs_hba *hba);
 void ufshcd_schedule_eh_work(struct ufs_hba *hba);
+
+void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds);
+u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i);
 void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
 unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
 					 struct ufs_hw_queue *hwq);
+void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
 void ufshcd_mcq_enable_esi(struct ufs_hba *hba);
 void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg);
 
-- 
2.18.0

