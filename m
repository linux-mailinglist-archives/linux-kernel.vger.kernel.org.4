Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ECC66A09A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjAMRZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjAMRXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:23:24 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36896A41CD;
        Fri, 13 Jan 2023 09:14:30 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 930F8E0F26;
        Fri, 13 Jan 2023 20:14:29 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=XjWUWZx9hiGdoeCnBBKAqxVKEx/2Rz53JAW+aYIz+oI=; b=cb3gQq5FQLGO
        GCY7YzNMPIMLUx0jys55l0mJFms7jef3uweWPkyT3BDc8tgMF0HPqplbA2JrxYH2
        N5d5Tifah7+FEPPlK4NGSyJZLqcFfVGVA41SzR8pnoPQqvEfIctNPDTlpAq3hxD+
        lolVnUhL2BYteDzDoACo3aASeCurXTk=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 624B0E0F13;
        Fri, 13 Jan 2023 20:14:29 +0300 (MSK)
Received: from localhost (10.8.30.26) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 13 Jan 2023 20:14:29 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 14/27] dmaengine: dw-edma: Rename DebugFS dentry variables to 'dent'
Date:   Fri, 13 Jan 2023 20:13:56 +0300
Message-ID: <20230113171409.30470-15-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
References: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.26]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are about to add the eDMA channels direction support to the
debugfs module it will be confusing to have both the DebugFS directory and
the channels direction short names used in the same code. As a preparation
patch let's convert the DebugFS dentry 'dir' variables to having the
'dent' name so to prevent the confusion.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>

---

Changelog v2:
- This is a new patch added in v2. (@Manivannan)
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 46 ++++++++++++------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 78f15e4b07ac..7bb3363b40e4 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -96,7 +96,7 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
 
 static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
-				       int nr_entries, struct dentry *dir)
+				       int nr_entries, struct dentry *dent)
 {
 	struct dw_edma_debugfs_entry *entries;
 	int i;
@@ -109,13 +109,13 @@ static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
 	for (i = 0; i < nr_entries; i++) {
 		entries[i] = ini[i];
 
-		debugfs_create_file_unsafe(entries[i].name, 0444, dir,
+		debugfs_create_file_unsafe(entries[i].name, 0444, dent,
 					   &entries[i], &fops_x32);
 	}
 }
 
 static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
-				    struct dentry *dir)
+				    struct dentry *dent)
 {
 	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		REGISTER(ch_control1),
@@ -131,10 +131,10 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
 	int nr_entries;
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
-	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, dir);
+	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, dent);
 }
 
-static void dw_edma_debugfs_regs_wr(struct dentry *dir)
+static void dw_edma_debugfs_regs_wr(struct dentry *dent)
 {
 	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
@@ -171,34 +171,34 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 		WR_REGISTER_UNROLL(ch6_pwr_en),
 		WR_REGISTER_UNROLL(ch7_pwr_en),
 	};
-	struct dentry *regs_dir, *ch_dir;
+	struct dentry *regs_dent, *ch_dent;
 	int nr_entries, i;
 	char name[16];
 
-	regs_dir = debugfs_create_dir(WRITE_STR, dir);
+	regs_dent = debugfs_create_dir(WRITE_STR, dent);
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
-	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
+	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dent);
 
 	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
-					   regs_dir);
+					   regs_dent);
 	}
 
 	for (i = 0; i < dw->wr_ch_cnt; i++) {
 		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
 
-		ch_dir = debugfs_create_dir(name, regs_dir);
+		ch_dent = debugfs_create_dir(name, regs_dent);
 
-		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].wr, ch_dir);
+		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].wr, ch_dent);
 
 		lim[0][i].start = &regs->type.unroll.ch[i].wr;
 		lim[0][i].end = &regs->type.unroll.ch[i].padding_1[0];
 	}
 }
 
-static void dw_edma_debugfs_regs_rd(struct dentry *dir)
+static void dw_edma_debugfs_regs_rd(struct dentry *dent)
 {
 	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
@@ -236,27 +236,27 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 		RD_REGISTER_UNROLL(ch6_pwr_en),
 		RD_REGISTER_UNROLL(ch7_pwr_en),
 	};
-	struct dentry *regs_dir, *ch_dir;
+	struct dentry *regs_dent, *ch_dent;
 	int nr_entries, i;
 	char name[16];
 
-	regs_dir = debugfs_create_dir(READ_STR, dir);
+	regs_dent = debugfs_create_dir(READ_STR, dent);
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
-	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
+	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dent);
 
 	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
-					   regs_dir);
+					   regs_dent);
 	}
 
 	for (i = 0; i < dw->rd_ch_cnt; i++) {
 		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
 
-		ch_dir = debugfs_create_dir(name, regs_dir);
+		ch_dent = debugfs_create_dir(name, regs_dent);
 
-		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].rd, ch_dir);
+		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].rd, ch_dent);
 
 		lim[1][i].start = &regs->type.unroll.ch[i].rd;
 		lim[1][i].end = &regs->type.unroll.ch[i].padding_2[0];
@@ -269,16 +269,16 @@ static void dw_edma_debugfs_regs(void)
 		REGISTER(ctrl_data_arb_prior),
 		REGISTER(ctrl),
 	};
-	struct dentry *regs_dir;
+	struct dentry *regs_dent;
 	int nr_entries;
 
-	regs_dir = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
+	regs_dent = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
-	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
+	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dent);
 
-	dw_edma_debugfs_regs_wr(regs_dir);
-	dw_edma_debugfs_regs_rd(regs_dir);
+	dw_edma_debugfs_regs_wr(regs_dent);
+	dw_edma_debugfs_regs_rd(regs_dent);
 }
 
 void dw_edma_v0_debugfs_on(struct dw_edma *_dw)
-- 
2.39.0


