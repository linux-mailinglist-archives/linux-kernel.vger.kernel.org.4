Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ED4622221
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiKICrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKICri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:47:38 -0500
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9C01FF9A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 18:47:34 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VULiWKz_1667962049;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VULiWKz_1667962049)
          by smtp.aliyun-inc.com;
          Wed, 09 Nov 2022 10:47:31 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] iommu: Fix some kernel-doc comments
Date:   Wed,  9 Nov 2022 10:47:29 +0800
Message-Id: <20221109024729.3957-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the description of @group to @dev in iommu_device_release_dma_owner()
to clear the below warnings:

drivers/iommu/iommu.c:3235: warning: Function parameter or member 'dev' not described in 'iommu_device_release_dma_owner'
drivers/iommu/iommu.c:3235: warning: Excess function parameter 'group' description in 'iommu_device_release_dma_owner'

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2820
Fixes: 506c4809b2d3 ("iommu: Add device-centric DMA ownership interfaces")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4cb14e44e40f..d299fef4fd81 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3227,7 +3227,7 @@ EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
 
 /**
  * iommu_device_release_dma_owner() - Release DMA ownership of a device
- * @group: The device.
+ * @dev: get the group that this device belongs to
  *
  * Release the DMA ownership claimed by iommu_device_claim_dma_owner().
  */
-- 
2.20.1.7.g153144c

