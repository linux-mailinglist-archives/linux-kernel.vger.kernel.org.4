Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04EF69C5DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBTHNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBTHNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:13:23 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E783E2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:13:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vc1ux49_1676877177;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vc1ux49_1676877177)
          by smtp.aliyun-inc.com;
          Mon, 20 Feb 2023 15:12:58 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] libnvdimm: Fix some kernel-doc comments
Date:   Mon, 20 Feb 2023 15:12:56 +0800
Message-Id: <20230220071256.72513-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the description of @nvdimm to @ndd in function
nvdimm_init_nsarea() and nvdimm_allocated_dpa () to silence the warnings:
drivers/nvdimm/dimm_devs.c:59: warning: Function parameter or member 'ndd' not described in 'nvdimm_init_nsarea'
drivers/nvdimm/dimm_devs.c:59: warning: Excess function parameter 'nvdimm' description in 'nvdimm_init_nsarea'
drivers/nvdimm/dimm_devs.c:844: warning: Function parameter or member 'ndd' not described in 'nvdimm_allocated_dpa'
drivers/nvdimm/dimm_devs.c:844: warning: Excess function parameter 'nvdimm' description in 'nvdimm_allocated_dpa

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4118
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/nvdimm/dimm_devs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 957f7c3d17ba..fc152e6016ca 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -53,7 +53,7 @@ static int validate_dimm(struct nvdimm_drvdata *ndd)
 
 /**
  * nvdimm_init_nsarea - determine the geometry of a dimm's namespace area
- * @nvdimm: dimm to initialize
+ * @ndd: dimm to initialize
  */
 int nvdimm_init_nsarea(struct nvdimm_drvdata *ndd)
 {
@@ -836,7 +836,7 @@ struct resource *nvdimm_allocate_dpa(struct nvdimm_drvdata *ndd,
 
 /**
  * nvdimm_allocated_dpa - sum up the dpa currently allocated to this label_id
- * @nvdimm: container of dpa-resource-root + labels
+ * @ndd: container of dpa-resource-root + labels
  * @label_id: dpa resource name of the form pmem-<human readable uuid>
  */
 resource_size_t nvdimm_allocated_dpa(struct nvdimm_drvdata *ndd,
-- 
2.20.1.7.g153144c

