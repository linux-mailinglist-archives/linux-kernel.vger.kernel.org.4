Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8988620635
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiKHBgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiKHBgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:36:46 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E1CBE36
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 17:36:45 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VUGoARA_1667871402;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VUGoARA_1667871402)
          by smtp.aliyun-inc.com;
          Tue, 08 Nov 2022 09:36:43 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, tvrtko.ursulin@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@gmail.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/i915: Fix some kernel-doc comments
Date:   Tue,  8 Nov 2022 09:36:39 +0800
Message-Id: <20221108013639.110513-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixs the function name in kernel-doc comments to clear the below
warnings:

drivers/gpu/drm/i915/gt/intel_engine_cs.c:1295: warning: expecting prototype for intel_engines_init_common(). Prototype was for engine_init_common() instead
drivers/gpu/drm/i915/gt/intel_engine_cs.c:1377: warning: expecting prototype for intel_engines_cleanup_common(). Prototype was for intel_engine_cleanup_common() instead

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2741
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/i915/gt/intel_engine_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index 3b7d750ad054..ebd2c21b3f47 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -1281,7 +1281,7 @@ create_kernel_context(struct intel_engine_cs *engine)
 }
 
 /**
- * intel_engines_init_common - initialize cengine state which might require hw access
+ * engine_init_common - initialize cengine state which might require hw access
  * @engine: Engine to initialize.
  *
  * Initializes @engine@ structure members shared between legacy and execlists
@@ -1367,7 +1367,7 @@ int intel_engines_init(struct intel_gt *gt)
 }
 
 /**
- * intel_engines_cleanup_common - cleans up the engine state created by
+ * intel_engine_cleanup_common - cleans up the engine state created by
  *                                the common initiailizers.
  * @engine: Engine to cleanup.
  *
-- 
2.20.1.7.g153144c

