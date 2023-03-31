Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F616D1C17
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjCaJ00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjCaJ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:26:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB2F46BF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8A5DECE2E04
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3E0C4339C;
        Fri, 31 Mar 2023 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680254776;
        bh=JZf0svDcEcGog0NsSz5cUzUNXsqZCcAN5I+gmpPDgzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgdsOUyLaKZBHIvB9GPVLk4X9CeQ4pHXp0fBiu28DVZBvm43qBKIVCFL/sdqsJECq
         M6EbfJ6qLZvvrwd0m97u25a66HakrZhKSyhJwVb48M5K3Bhqo9uS/rCyoc9CfZ2pBQ
         NP2Ei7jihGLSnvmdd49aH6AjEpDiArG+97ca2E2XQ8UHA1xXBDTxMyDg0kr7ockqzZ
         OKV8BB64V/G2tKuBK3YQELLfvtgjvf+ON2XVZnRjZs6f64TVvNJYc3/zgMgSz85GiB
         GhFWGxCl3fq4/F6H6fKnQNwKm0Q14hOIh3eVxjyWNGqP9LWgeHDeiZBG0VSU9HTzu1
         pnljvPt9fz31A==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 01/19] drm/i915/i915_scatterlist: Fix kerneldoc formatting issue - missing '@'
Date:   Fri, 31 Mar 2023 10:25:49 +0100
Message-Id: <20230331092607.700644-2-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331092607.700644-1-lee@kernel.org>
References: <20230331092607.700644-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/i915/i915_scatterlist.c:62: warning: Function parameter or member 'size' not described in 'i915_refct_sgt_init'

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/i915/i915_scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_scatterlist.c b/drivers/gpu/drm/i915/i915_scatterlist.c
index 7c7a86921b1c7..e93d2538f2988 100644
--- a/drivers/gpu/drm/i915/i915_scatterlist.c
+++ b/drivers/gpu/drm/i915/i915_scatterlist.c
@@ -56,7 +56,7 @@ static const struct i915_refct_sgt_ops rsgt_ops = {
 /**
  * i915_refct_sgt_init - Initialize a struct i915_refct_sgt with default ops
  * @rsgt: The struct i915_refct_sgt to initialize.
- * size: The size of the underlying memory buffer.
+ * @size: The size of the underlying memory buffer.
  */
 void i915_refct_sgt_init(struct i915_refct_sgt *rsgt, size_t size)
 {
-- 
2.40.0.348.gf938b09366-goog

