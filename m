Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DCF643D22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiLFGbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiLFGbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:31:50 -0500
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB43821E35
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 22:31:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=0;PH=DS;RN=8;SR=0;TI=SMTPD_---0VWdx-.o_1670308304;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VWdx-.o_1670308304)
          by smtp.aliyun-inc.com;
          Tue, 06 Dec 2022 14:31:45 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] nvdimm: Fix some kernel-doc comments
Date:   Tue,  6 Dec 2022 14:31:41 +0800
Message-Id: <20221206063142.52876-1-yang.lee@linux.alibaba.com>
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

Make the description of @nvdimm to @ndd in nvdimm_init_nsarea()
and nvdimm_allocated_dpa() to clear the below warnings:

drivers/nvdimm/dimm_devs.c:59: warning: Function parameter or member 'ndd' not described in 'nvdimm_init_nsarea'
drivers/nvdimm/dimm_devs.c:59: warning: Excess function parameter 'nvdimm' description in 'nvdimm_init_nsarea'
drivers/nvdimm/dimm_devs.c:841: warning: Function parameter or member 'ndd' not described in 'nvdimm_allocated_dpa'
drivers/nvdimm/dimm_devs.c:841: warning: Excess function parameter 'nvdimm' description in 'nvdimm_allocated_dpa'

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3361
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/nvdimm/dimm_devs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 1fc081dcf631..17b56171c2c2 100644
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
@@ -833,7 +833,7 @@ struct resource *nvdimm_allocate_dpa(struct nvdimm_drvdata *ndd,
 
 /**
  * nvdimm_allocated_dpa - sum up the dpa currently allocated to this label_id
- * @nvdimm: container of dpa-resource-root + labels
+ * @ndd: container of dpa-resource-root + labels
  * @label_id: dpa resource name of the form pmem-<human readable uuid>
  */
 resource_size_t nvdimm_allocated_dpa(struct nvdimm_drvdata *ndd,
-- 
2.20.1.7.g153144c

