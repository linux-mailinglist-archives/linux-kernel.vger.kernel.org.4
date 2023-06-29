Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E510E741E01
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjF2CLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjF2CL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:11:29 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9529E2D52;
        Wed, 28 Jun 2023 19:11:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VmBtSFm_1688004679;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VmBtSFm_1688004679)
          by smtp.aliyun-inc.com;
          Thu, 29 Jun 2023 10:11:20 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alison.schofield@intel.com
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] cxl: Fix one kernel-doc comment
Date:   Thu, 29 Jun 2023 10:11:18 +0800
Message-Id: <20230629021118.102744-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the description of @cxlds to @mds.
silence the warnings:
drivers/cxl/core/memdev.c:678: warning: Function parameter or member 'mds' not described in 'cxl_mem_get_fw_info'
drivers/cxl/core/memdev.c:678: warning: Excess function parameter 'cxlds' description in 'cxl_mem_get_fw_info'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/cxl/core/memdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 90237b9487a7..f99e7ec3cc40 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -666,7 +666,7 @@ static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 
 /**
  * cxl_mem_get_fw_info - Get Firmware info
- * @cxlds: The device data for the operation
+ * @mds: The device data for the operation
  *
  * Retrieve firmware info for the device specified.
  *
-- 
2.20.1.7.g153144c

