Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B948F69ED3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjBVDFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjBVDEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:04:52 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A982312B;
        Tue, 21 Feb 2023 19:04:47 -0800 (PST)
X-UUID: a5b382a2b25d11ed945fc101203acc17-20230222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=m3eXF39txh6c76bLHqw0R93HCRiA2dN4IhRPifLF9Y8=;
        b=NM3R6POx7pkBtV09ssyCBqybtdwSOT9wMUjbWXIZ1vv3cfMNt6MQq4hY9y3xPtm5qIEsgA0AkRf7Iqjv+r6Lb7WRlGaLO0XIuNcE/mks12qKaeOoaU5o756V0+VV+MvCEptS6TFa8YzVMxX+yHTuBHyuphdNyhQ7ZOH7I4e2ywQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:9cae7ae7-d2fd-497b-9bc9-0b986ada741d,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.20,REQID:9cae7ae7-d2fd-497b-9bc9-0b986ada741d,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:25b5999,CLOUDID:a3452fb1-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230222110443GGJHAGCY,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: a5b382a2b25d11ed945fc101203acc17-20230222
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1983994696; Wed, 22 Feb 2023 11:04:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 22 Feb 2023 11:04:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 22 Feb 2023 11:04:38 +0800
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
Subject: [PATCH v2 2/7] scsi: ufs: core: Rename symbols
Date:   Wed, 22 Feb 2023 11:04:19 +0800
Message-ID: <20230222030427.957-3-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230222030427.957-1-powen.kao@mediatek.com>
References: <20230222030427.957-1-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid confusion, sizeof_utp_transfer_cmd_desc() is renamed to
ufshcd_get_ucd_size().

Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
---
 drivers/ufs/core/ufs-mcq.c | 2 +-
 drivers/ufs/core/ufshcd.c  | 8 ++++----
 include/ufs/ufshcd.h       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 3a27fa4b0024..a39746b2a8be 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -265,7 +265,7 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
 	addr = (le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA) -
 		hba->ucdl_dma_addr;
 
-	return div_u64(addr, sizeof_utp_transfer_cmd_desc(hba));
+	return div_u64(addr, ufshcd_get_ucd_size(hba));
 }
 
 static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3b3cf78d3b10..81c9f07ebfc8 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2823,10 +2823,10 @@ static void ufshcd_map_queues(struct Scsi_Host *shost)
 static void ufshcd_init_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrb, int i)
 {
 	struct utp_transfer_cmd_desc *cmd_descp = (void *)hba->ucdl_base_addr +
-		i * sizeof_utp_transfer_cmd_desc(hba);
+		i * ufshcd_get_ucd_size(hba);
 	struct utp_transfer_req_desc *utrdlp = hba->utrdl_base_addr;
 	dma_addr_t cmd_desc_element_addr = hba->ucdl_dma_addr +
-		i * sizeof_utp_transfer_cmd_desc(hba);
+		i * ufshcd_get_ucd_size(hba);
 	u16 response_offset = offsetof(struct utp_transfer_cmd_desc,
 				       response_upiu);
 	u16 prdt_offset = offsetof(struct utp_transfer_cmd_desc, prd_table);
@@ -3735,7 +3735,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 	size_t utmrdl_size, utrdl_size, ucdl_size;
 
 	/* Allocate memory for UTP command descriptors */
-	ucdl_size = sizeof_utp_transfer_cmd_desc(hba) * hba->nutrs;
+	ucdl_size = ufshcd_get_ucd_size(hba) * hba->nutrs;
 	hba->ucdl_base_addr = dmam_alloc_coherent(hba->dev,
 						  ucdl_size,
 						  &hba->ucdl_dma_addr,
@@ -3835,7 +3835,7 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
 	prdt_offset =
 		offsetof(struct utp_transfer_cmd_desc, prd_table);
 
-	cmd_desc_size = sizeof_utp_transfer_cmd_desc(hba);
+	cmd_desc_size = ufshcd_get_ucd_size(hba);
 	cmd_desc_dma_addr = hba->ucdl_dma_addr;
 
 	for (i = 0; i < hba->nutrs; i++) {
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index ed9e3d5addb3..8f79cca449e1 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1136,7 +1136,7 @@ static inline size_t ufshcd_sg_entry_size(const struct ufs_hba *hba)
 	({ (void)(hba); BUILD_BUG_ON(sg_entry_size != sizeof(struct ufshcd_sg_entry)); })
 #endif
 
-static inline size_t sizeof_utp_transfer_cmd_desc(const struct ufs_hba *hba)
+static inline size_t ufshcd_get_ucd_size(const struct ufs_hba *hba)
 {
 	return sizeof(struct utp_transfer_cmd_desc) + SG_ALL * ufshcd_sg_entry_size(hba);
 }
-- 
2.18.0

