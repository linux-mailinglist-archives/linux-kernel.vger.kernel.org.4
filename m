Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C0E5BC9AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiISKop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiISKoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:44:21 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6DA371B8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:26:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VQBUIuX_1663583157;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VQBUIuX_1663583157)
          by smtp.aliyun-inc.com;
          Mon, 19 Sep 2022 18:26:08 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/i915/gt: Fix kernel-doc
Date:   Mon, 19 Sep 2022 18:25:55 +0800
Message-Id: <20220919102555.18580-1-jiapeng.chong@linux.alibaba.com>
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

drivers/gpu/drm/i915/gt/intel_engine_cs.c:1288: warning: expecting prototype for intel_engines_cleanup_common(). Prototype was for intel_engine_cleanup_common() instead.
drivers/gpu/drm/i915/gt/intel_engine_cs.c:1211: warning: expecting prototype for intel_engines_init_common(). Prototype was for engine_init_common() instead.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2218
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/i915/gt/intel_engine_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index 275ad72940c1..6e8d45e5e574 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -1197,7 +1197,7 @@ create_kernel_context(struct intel_engine_cs *engine)
 }
 
 /**
- * intel_engines_init_common - initialize cengine state which might require hw access
+ * engine_init_common() - initialize cengine state which might require hw access
  * @engine: Engine to initialize.
  *
  * Initializes @engine@ structure members shared between legacy and execlists
@@ -1278,7 +1278,7 @@ int intel_engines_init(struct intel_gt *gt)
 }
 
 /**
- * intel_engines_cleanup_common - cleans up the engine state created by
+ * intel_engine_cleanup_common() - cleans up the engine state created by
  *                                the common initiailizers.
  * @engine: Engine to cleanup.
  *
-- 
2.20.1.7.g153144c

