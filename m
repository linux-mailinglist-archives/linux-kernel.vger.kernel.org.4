Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976C76D1C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjCaJ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjCaJ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:26:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194AE1D2C2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9574FB82DAC
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1833FC4339E;
        Fri, 31 Mar 2023 09:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680254779;
        bh=JNGe4Stkfx4U8PEelqzPaQWET75d/oi6wGG9GBuzGjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxD+CR5W+M4FMA4u7Hve2K2JQHHfpYrFTxcrzo1+D3s9MFvxrft5XY2qstmWV0U9b
         Dcihw64MldAHjYk5Nu4uAVf1bD0M+vHq8MjU9fFglHhvT3juY9hxLJP6J1mNK+Lpiq
         bRYgOkTu73CBFuOtEJKjmVsZTQfaJuaap1FntnI8LO14tvm9hxT/e4r9YDeBmRGSb+
         tdXfN3XV/IZVyIYAXTp4UEVQgqHuRrP9KOFV8uEbsgKZ8zeoKRZ0f7Knn7Sgyr+6a/
         tIyR7WqeSSP+Asl/BYPWoGv60k9WGCg/Aeak+jN7+o5Mer9rfEVJLgX/HOAs4Ck4o+
         Re9zsLs21/OgQ==
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
Subject: [PATCH 02/19] drm/i915/intel_region_ttm: Provide missing description for 'offset' param
Date:   Fri, 31 Mar 2023 10:25:50 +0100
Message-Id: <20230331092607.700644-3-lee@kernel.org>
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

 drivers/gpu/drm/i915/intel_region_ttm.c:201: warning: Function parameter or member 'offset' not described in 'intel_region_ttm_resource_alloc'

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
 drivers/gpu/drm/i915/intel_region_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/intel_region_ttm.c b/drivers/gpu/drm/i915/intel_region_ttm.c
index b7fbd5abb42a5..bf6097e7433d5 100644
--- a/drivers/gpu/drm/i915/intel_region_ttm.c
+++ b/drivers/gpu/drm/i915/intel_region_ttm.c
@@ -181,6 +181,7 @@ intel_region_ttm_resource_to_rsgt(struct intel_memory_region *mem,
 /**
  * intel_region_ttm_resource_alloc - Allocate memory resources from a region
  * @mem: The memory region,
+ * @offset: BO offset
  * @size: The requested size in bytes
  * @flags: Allocation flags
  *
-- 
2.40.0.348.gf938b09366-goog

