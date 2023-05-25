Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46F47114D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbjEYSjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbjEYSjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:39:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454461725;
        Thu, 25 May 2023 11:37:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 427A7647B7;
        Thu, 25 May 2023 18:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB06C4339C;
        Thu, 25 May 2023 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039714;
        bh=nv4pu/DVjuArKp1IDphcIeJJlJ9bGuaD2HPi5eSGOho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LwOAMOjtpDl68aakBVXvtjSZvZXGO15uyY3/tJ9zvNXei2usM6iYiJH8VN/6QssTq
         3HRqRakJhmVqGoYiQ11lPgS2XYK23tXqwnSBnVQhvJaawnDhNP+qXW0TprHJTWe/WP
         2HbnKJBPqLcSWe036hJMPrqnN+FrrijHLELlmI/SuaKSMuNssYZ/VXfQZ2OndKdLsC
         U1nBOpME6HyiPaKFslwfh3sH/OmRDbsh3fjc11DABdw5kPmOz/IKDZRVrPuTUs/PVV
         lChmJVmfJWqr+iVCNydnJzwlLmWHHRST0+1xzjEOrCJP2Cl0Bqd/F6MjmIJwLRWmJQ
         6yzQ3robuC1dQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Po-Wen Kao <powen.kao@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Ziqi Chen <quic_ziqichen@quicinc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        matthias.bgg@gmail.com, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, alice.chao@mediatek.com,
        avri.altman@wdc.com, beanhuo@micron.com, j-young.choi@samsung.com,
        Arthur.Simchaev@wdc.com, athierry@redhat.com, ebiggers@google.com,
        yoshihiro.shimoda.uh@renesas.com, keosung.park@samsung.com,
        dlunev@chromium.org, linux-scsi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 50/67] scsi: ufs: core: Rename symbol sizeof_utp_transfer_cmd_desc()
Date:   Thu, 25 May 2023 14:31:27 -0400
Message-Id: <20230525183144.1717540-50-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Po-Wen Kao <powen.kao@mediatek.com>

[ Upstream commit 06caeb536b2b21668efd2d6fa97c09461957b3a7 ]

Naming the functions after standard operators like sizeof() may cause
confusion. Rename it to ufshcd_get_ucd_size().

Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
Link: https://lore.kernel.org/r/20230504154454.26654-3-powen.kao@mediatek.com
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Ziqi Chen <quic_ziqichen@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c |  2 +-
 drivers/ufs/core/ufshcd.c  | 10 +++++-----
 include/ufs/ufshcd.h       |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index b7c5f39b50e6d..937933d3f77c2 100644
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
index c7a9a1cedf920..b95b5afd7eaeb 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2821,10 +2821,10 @@ static void ufshcd_map_queues(struct Scsi_Host *shost)
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
@@ -3733,7 +3733,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 	size_t utmrdl_size, utrdl_size, ucdl_size;
 
 	/* Allocate memory for UTP command descriptors */
-	ucdl_size = sizeof_utp_transfer_cmd_desc(hba) * hba->nutrs;
+	ucdl_size = ufshcd_get_ucd_size(hba) * hba->nutrs;
 	hba->ucdl_base_addr = dmam_alloc_coherent(hba->dev,
 						  ucdl_size,
 						  &hba->ucdl_dma_addr,
@@ -3833,7 +3833,7 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
 	prdt_offset =
 		offsetof(struct utp_transfer_cmd_desc, prd_table);
 
-	cmd_desc_size = sizeof_utp_transfer_cmd_desc(hba);
+	cmd_desc_size = ufshcd_get_ucd_size(hba);
 	cmd_desc_dma_addr = hba->ucdl_dma_addr;
 
 	for (i = 0; i < hba->nutrs; i++) {
@@ -8422,7 +8422,7 @@ static void ufshcd_release_sdb_queue(struct ufs_hba *hba, int nutrs)
 {
 	size_t ucdl_size, utrdl_size;
 
-	ucdl_size = sizeof_utp_transfer_cmd_desc(hba) * nutrs;
+	ucdl_size = ufshcd_get_ucd_size(hba) * nutrs;
 	dmam_free_coherent(hba->dev, ucdl_size, hba->ucdl_base_addr,
 			   hba->ucdl_dma_addr);
 
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 431c3afb2ce0f..db70944c681aa 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1138,7 +1138,7 @@ static inline size_t ufshcd_sg_entry_size(const struct ufs_hba *hba)
 	({ (void)(hba); BUILD_BUG_ON(sg_entry_size != sizeof(struct ufshcd_sg_entry)); })
 #endif
 
-static inline size_t sizeof_utp_transfer_cmd_desc(const struct ufs_hba *hba)
+static inline size_t ufshcd_get_ucd_size(const struct ufs_hba *hba)
 {
 	return sizeof(struct utp_transfer_cmd_desc) + SG_ALL * ufshcd_sg_entry_size(hba);
 }
-- 
2.39.2

