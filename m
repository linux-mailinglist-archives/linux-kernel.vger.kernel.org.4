Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760556D1C39
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjCaJ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjCaJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:27:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252061D2FC;
        Fri, 31 Mar 2023 02:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AAC2B82DB3;
        Fri, 31 Mar 2023 09:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B61C4339E;
        Fri, 31 Mar 2023 09:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680254804;
        bh=zuwKMJNqTDoHBJoWH8QH3yXQEHwpZC6+8Slwblrz11M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzBRFbowGUW/YExXI2jTQQk/JtNvslenNW0Y4g0oY2Dk6yMfna/AhJ0nRE8VSsS+3
         PYWM9WyB+QL7TZ/0nfbfiIAHK53Q5l1qd2BolEBM4l6XaL26ixqrOzMRpF1C60ZEC/
         umXpAj7gPpWGyMqN/FdC907acxLU3FNGj5QRZySmOGhvw0WUGaQW5sooG6ClxbOsMQ
         P4lIpdMnyh1AKrCvBhDFrd5vMqY7Z/1NV2GNnAhBYfZlpGGDQMcbiYPGnLOU0OuYmc
         YMFmUiDYTg8RvB8RkPeGnOoVxFTY8fkrLil7jOF093eJ5BTgmLjYn+P9+CSTeeUulc
         mKn+attwDlEdA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 11/19] drm/i915/gem/i915_gem_ttm_move: Provide a couple of missing descriptions for 'num_pages' and 'ctx'
Date:   Fri, 31 Mar 2023 10:25:59 +0100
Message-Id: <20230331092607.700644-12-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331092607.700644-1-lee@kernel.org>
References: <20230331092607.700644-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c:272: warning: Function parameter or member 'num_pages' not described in 'i915_ttm_memcpy_arg'
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c:569: warning: Function parameter or member 'ctx' not described in 'i915_ttm_move'

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
index d030182ca1764..dd188dfcc423e 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -253,6 +253,7 @@ static struct dma_fence *i915_ttm_accel_move(struct ttm_buffer_object *bo,
  * @_src_iter: Storage space for the source kmap iterator.
  * @dst_iter: Pointer to the destination kmap iterator.
  * @src_iter: Pointer to the source kmap iterator.
+ * @num_pages: Number of pages
  * @clear: Whether to clear instead of copy.
  * @src_rsgt: Refcounted scatter-gather list of source memory.
  * @dst_rsgt: Refcounted scatter-gather list of destination memory.
@@ -557,6 +558,8 @@ __i915_ttm_move(struct ttm_buffer_object *bo,
  * i915_ttm_move - The TTM move callback used by i915.
  * @bo: The buffer object.
  * @evict: Whether this is an eviction.
+ * @ctx: Pointer to a struct ttm_operation_ctx indicating how the waits should be
+ *       performed if waiting
  * @dst_mem: The destination ttm resource.
  * @hop: If we need multihop, what temporary memory type to move to.
  *
-- 
2.40.0.348.gf938b09366-goog

