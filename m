Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3548620048
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiKGVFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiKGVFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:05:02 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71C50659F;
        Mon,  7 Nov 2022 13:04:54 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id AAB9BE0ED7;
        Tue,  8 Nov 2022 00:04:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=SEc0/TJGdJztP7HNTfy6MRhUGeFPU8iiNcFtwZFyML0=; b=eoWuYx0v9XC8
        rNfCB1OWDHbEC3AUveng/769lUCJjArCjbzNTsXP65b6UoUSTp4jVEBCFFt5JIHr
        lnxnFb98LM+RfoT4bLso85bQvkViA5cblE01NMNwe9b65hhJ5ULS+o/QXxpfDzTO
        QCy0/zn6U46Vx9kL7LSEzhqElNkdmAw=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 9C353E0ED5;
        Tue,  8 Nov 2022 00:04:53 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 8 Nov 2022 00:04:53 +0300
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
        caihuoqing <caihuoqing@baidu.com>, <linux-pci@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 12/24] dmaengine: dw-edma: Add dw_edma prefix to the DebugFS nodes descriptor
Date:   Tue, 8 Nov 2022 00:04:26 +0300
Message-ID: <20221107210438.1515-13-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru>
References: <20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rest of the locally defined and used methods and structures have
dw_edma prefix in their names. It's right in accordance with the kernel
coding style to follow the locally defined rule of naming. Let's add that
prefix to the debugfs_entries structure too especially seeing it's name
may be confusing as if that structure belongs to the global DebugFS space.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 6e7f3ef60ca7..2121ffc33cf3 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -46,7 +46,7 @@ static struct {
 	void					__iomem *end;
 } lim[2][EDMA_V0_MAX_NR_CH];
 
-struct debugfs_entries {
+struct dw_edma_debugfs_entry {
 	const char				*name;
 	void __iomem				*reg;
 };
@@ -94,7 +94,7 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
 
-static void dw_edma_debugfs_create_x32(const struct debugfs_entries entries[],
+static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry entries[],
 				       int nr_entries, struct dentry *dir)
 {
 	int i;
@@ -108,8 +108,7 @@ static void dw_edma_debugfs_create_x32(const struct debugfs_entries entries[],
 static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
 				    struct dentry *dir)
 {
-	int nr_entries;
-	const struct debugfs_entries debugfs_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		REGISTER(ch_control1),
 		REGISTER(ch_control2),
 		REGISTER(transfer_size),
@@ -120,6 +119,7 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
 		REGISTER(llp.lsb),
 		REGISTER(llp.msb),
 	};
+	int nr_entries;
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, dir);
@@ -127,7 +127,7 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
 
 static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 {
-	const struct debugfs_entries debugfs_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
 		WR_REGISTER(engine_en),
 		WR_REGISTER(doorbell),
@@ -148,7 +148,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 		WR_REGISTER(ch67_imwr_data),
 		WR_REGISTER(linked_list_err_en),
 	};
-	const struct debugfs_entries debugfs_unroll_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
 		/* eDMA channel context grouping */
 		WR_REGISTER_UNROLL(engine_chgroup),
 		WR_REGISTER_UNROLL(engine_hshake_cnt.lsb),
@@ -191,7 +191,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 
 static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 {
-	const struct debugfs_entries debugfs_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
 		RD_REGISTER(engine_en),
 		RD_REGISTER(doorbell),
@@ -213,7 +213,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 		RD_REGISTER(ch45_imwr_data),
 		RD_REGISTER(ch67_imwr_data),
 	};
-	const struct debugfs_entries debugfs_unroll_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
 		/* eDMA channel context grouping */
 		RD_REGISTER_UNROLL(engine_chgroup),
 		RD_REGISTER_UNROLL(engine_hshake_cnt.lsb),
@@ -256,7 +256,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 
 static void dw_edma_debugfs_regs(void)
 {
-	const struct debugfs_entries debugfs_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		REGISTER(ctrl_data_arb_prior),
 		REGISTER(ctrl),
 	};
-- 
2.38.0


