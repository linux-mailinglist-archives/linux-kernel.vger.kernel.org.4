Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0107320A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjFOUKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjFOUKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:10:49 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A635A1715
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=Jo6WrxNEBvFGf7AFwmeZPUW/JDvN4uXBntOmSb9t0Xw=;
        b=UJJk/i2kqv2+FgNaiQ7osSjPGFyvg+xx90znS7A6WMqpEnFj0gnvj33JNOjwqfmjCZoI
        tSLxmZqwcsQKATSs6fM4Gps9ufnOKMUjlhXvEDSoWroLpX/rE1PWMnXqRlUb8XbXb0MgLF
        ibIF8AKNo2ZVEmVCK9SaYEib/6zYEyPutujJQ6JxhTZgZU4f4DVgstiAX6+v4ke3IAVvYX
        jkbxngwRNbkcrAxNCy26C4VTpKJKETu3TDec6VksvJbNLTZ8k+IaeqCMkusynPGdCvjFts
        DyBy4hJZT+mhIHF/WSKbH+OfwXp+4NDboY5ZJ8WFOTs+XDyMYuDiBeHPL8Y5Hzwg==
Received: by filterdrecv-77869f68cc-lcgp6 with SMTP id filterdrecv-77869f68cc-lcgp6-1-648B7047-29
        2023-06-15 20:10:47.655923269 +0000 UTC m=+3098089.849329708
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-5 (SG)
        with ESMTP
        id HeBgvyqzQEmrDPru8i_iZw
        Thu, 15 Jun 2023 20:10:47.460 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/3] iommu: rockchip: Remove unused variant ops
Date:   Thu, 15 Jun 2023 20:10:47 +0000 (UTC)
Message-Id: <20230615201042.2291867-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615201042.2291867-1-jonas@kwiboo.se>
References: <20230615201042.2291867-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hw3PhMXq4dBde3yCz?=
 =?us-ascii?Q?R1jfjYCf+7fd8HHpQWrb68EQHPtq89X0VUIvV9y?=
 =?us-ascii?Q?qtrQo51l3wTBwoWjkkPMRshT5iwndBQnUXHgbOj?=
 =?us-ascii?Q?M=2FABO2jE8IRX+k=2F+7kFVMmCGoRyc2hY3vNV2J6F?=
 =?us-ascii?Q?MoH7IkANy=2FKKjUwP=2FrTERjLDN=2FaZV4lp=2FFk8cW?=
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dte_addr_phys and dma_addr_dte ops is now unused by the driver,
let's remove them.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- no change

 drivers/iommu/rockchip-iommu.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index d46319f77e5c..62be9bf42390 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -98,8 +98,6 @@ struct rk_iommu_ops {
 	phys_addr_t (*pt_address)(u32 dte);
 	u32 (*mk_dtentries)(dma_addr_t pt_dma);
 	u32 (*mk_ptentries)(phys_addr_t page, int prot);
-	phys_addr_t (*dte_addr_phys)(u32 addr);
-	u32 (*dma_addr_dte)(dma_addr_t dt_dma);
 	u64 dma_bit_mask;
 };
 
@@ -531,33 +529,6 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 	return 0;
 }
 
-static inline phys_addr_t rk_dte_addr_phys(u32 addr)
-{
-	return (phys_addr_t)addr;
-}
-
-static inline u32 rk_dma_addr_dte(dma_addr_t dt_dma)
-{
-	return dt_dma;
-}
-
-#define DT_HI_MASK GENMASK_ULL(39, 32)
-#define DTE_BASE_HI_MASK GENMASK(11, 4)
-#define DT_SHIFT   28
-
-static inline phys_addr_t rk_dte_addr_phys_v2(u32 addr)
-{
-	u64 addr64 = addr;
-	return (phys_addr_t)(addr64 & RK_DTE_PT_ADDRESS_MASK) |
-	       ((addr64 & DTE_BASE_HI_MASK) << DT_SHIFT);
-}
-
-static inline u32 rk_dma_addr_dte_v2(dma_addr_t dt_dma)
-{
-	return (dt_dma & RK_DTE_PT_ADDRESS_MASK) |
-	       ((dt_dma & DT_HI_MASK) >> DT_SHIFT);
-}
-
 static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 {
 	void __iomem *base = iommu->bases[index];
@@ -1405,8 +1376,6 @@ static struct rk_iommu_ops iommu_data_ops_v1 = {
 	.pt_address = &rk_dte_pt_address,
 	.mk_dtentries = &rk_mk_dte,
 	.mk_ptentries = &rk_mk_pte,
-	.dte_addr_phys = &rk_dte_addr_phys,
-	.dma_addr_dte = &rk_dma_addr_dte,
 	.dma_bit_mask = DMA_BIT_MASK(32),
 };
 
@@ -1414,8 +1383,6 @@ static struct rk_iommu_ops iommu_data_ops_v2 = {
 	.pt_address = &rk_dte_pt_address_v2,
 	.mk_dtentries = &rk_mk_dte_v2,
 	.mk_ptentries = &rk_mk_pte_v2,
-	.dte_addr_phys = &rk_dte_addr_phys_v2,
-	.dma_addr_dte = &rk_dma_addr_dte_v2,
 	.dma_bit_mask = DMA_BIT_MASK(40),
 };
 
-- 
2.40.1

