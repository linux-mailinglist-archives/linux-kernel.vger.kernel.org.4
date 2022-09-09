Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50C05B3074
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiIIHhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiIIHfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:35:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6089B40FB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:35:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AE00B8237B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E8EC4FF13;
        Fri,  9 Sep 2022 07:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708895;
        bh=I6eEapEOfzCQ9tPdvmEL+EtBLTgxim5EhgEQpdwxUDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qiz0OKpEzmVY5Oo4ShbUm3VJmdK12O+Ws4BXh8mu+cp1oEGeDkr3ylvF1F8Jsztmg
         8amevWyBvvYdCS1upAUE+cXzj+6+8nvM6x0ocsthedrR36TI95m4MqWqlYinMDpoLM
         bWJShnaeR3+tocSqWr7fKzOozHYAhpOGXIsU3cn60kekXlUBrmj6MtiXA89RQ3VQJT
         XHjWtY/wDArMgMbZFcoHGxSx7zA2kdqD1vqgfxFwAVZDHpGVjDqZnnUYbmH527Kien
         kfVJLPxfLTt4+/5Z5wsxiqjKvCMn38NWS3x6sB4uVIbU/3nZGrSYVI+aw4khwlnXjs
         Fs6J4pGMjArUg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXH-007FHj-HP;
        Fri, 09 Sep 2022 09:34:47 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 33/37] drm/i915 i915_gem_object_types.h: document struct i915_lut_handle
Date:   Fri,  9 Sep 2022 09:34:40 +0200
Message-Id: <0da7c28a377a1fac9db524dbc8462731d922b39c.1662708705.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662708705.git.mchehab@kernel.org>
References: <cover.1662708705.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d1b48c1e7184 ("drm/i915: Replace execbuf vma ht with an idr")
added a rbtree list to allow searching for obj/ctx.

Document it.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/i915_gem_object_types.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
index 9f6b14ec189a..35746cf268ea 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
@@ -21,9 +21,15 @@ struct drm_i915_gem_object;
 struct intel_fronbuffer;
 struct intel_memory_region;
 
-/*
- * struct i915_lut_handle tracks the fast lookups from handle to vma used
- * for execbuf. Although we use a radixtree for that mapping, in order to
+/**
+ * struct i915_lut_handle - tracks the fast lookups from handle to vma used
+ * for execbuf.
+ *
+ * @obj_link: link to the object associated with the @handle.
+ * @ctx: context associated with the @handle.
+ * @handle: a rbtree handle to lookup context for specific obj/vma.
+ *
+ * Although we use a radixtree for that mapping, in order to
  * remove them as the object or context is closed, we need a secondary list
  * and a translation entry (i915_lut_handle).
  */
-- 
2.37.3

