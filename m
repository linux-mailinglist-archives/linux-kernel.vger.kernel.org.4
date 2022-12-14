Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A6264C263
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 03:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbiLNCwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 21:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbiLNCwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:52:03 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F337726AFE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:51:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VXGK2Xz_1670986274;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VXGK2Xz_1670986274)
          by smtp.aliyun-inc.com;
          Wed, 14 Dec 2022 10:51:33 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@gmail.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v3] drm/i915: Remove unnecessary doc from static engine_init_common()
Date:   Wed, 14 Dec 2022 10:51:12 +0800
Message-Id: <20221214025112.104595-1-jiapeng.chong@linux.alibaba.com>
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

The function engine_init_common() has changed to static and we don't need
doc comment in the static function. No functional modification involved.

drivers/gpu/drm/i915/gt/intel_engine_cs.c:1306: warning: expecting prototype for intel_engines_init_common(). Prototype was for engine_init_common() instead.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3442
Fixes: 019bf277634a ("drm/i915: Pull out some more common engine init code")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v3:
  -Modify the commit message and add a "Fixes:" tag.

 drivers/gpu/drm/i915/gt/intel_engine_cs.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index c33e0d72d670..7c29b1504ae7 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -1291,17 +1291,6 @@ create_kernel_context(struct intel_engine_cs *engine)
 						  &kernel, "kernel_context");
 }
 
-/**
- * intel_engines_init_common - initialize cengine state which might require hw access
- * @engine: Engine to initialize.
- *
- * Initializes @engine@ structure members shared between legacy and execlists
- * submission modes which do require hardware access.
- *
- * Typcally done at later stages of submission mode specific engine setup.
- *
- * Returns zero on success or an error code on failure.
- */
 static int engine_init_common(struct intel_engine_cs *engine)
 {
 	struct intel_context *ce;
-- 
2.20.1.7.g153144c

