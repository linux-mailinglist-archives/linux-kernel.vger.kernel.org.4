Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DE46D1C45
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjCaJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjCaJ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:27:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0B41D2C4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:27:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B95062656
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84951C4339B;
        Fri, 31 Mar 2023 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680254814;
        bh=8AGKbu3+LbNahQA9+BV8cpQ9XSnkvlPrI5KbjVo54Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eOBqcE0mA4J73g2ftWRNsZm8U23TaA9r3zmLGid83WDxH83+j6lZmu6iTDkz+1Ixp
         edyH7ctvVVfYJLJWhtOWkFab3tPyj22/KkSY9B3QX6TQWBdtrko2Wh7YbFuAkBGON4
         RfAr1UYWHGhDhx7foA032phVxjc5VnLXR7JHaFp8oIJRJPL6h4aDYF2U6+RpID3P9w
         neQ+BgnjrTjI5jg/DD4POag6DK0uUpvVhLqciOVk3pywVqTr6p6BUJKj9v/iTXtB/9
         mv4TcglI+DcH7TxABC97+keY4Q4zc/AU0I7YpXbqjJa8Yc9g5QzerI+QD9LVvburH0
         4XVFCk8T3LRLQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 14/19] drm/i915/i915_gem: Provide function names to complete the expected kerneldoc format
Date:   Fri, 31 Mar 2023 10:26:02 +0100
Message-Id: <20230331092607.700644-15-lee@kernel.org>
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

 drivers/gpu/drm/i915/i915_gem.c:447: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/i915/i915_gem.c:536: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/i915/i915_gem.c:726: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/i915/i915_gem.c:811: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Eric Anholt <eric@anholt.net>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/i915/i915_gem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 35950fa914068..6a00d13db2893 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -444,7 +444,7 @@ i915_gem_gtt_pread(struct drm_i915_gem_object *obj,
 }
 
 /**
- * Reads data from the object referenced by handle.
+ * i915_gem_pread_ioctl - Reads data from the object referenced by handle.
  * @dev: drm device pointer
  * @data: ioctl data blob
  * @file: drm file pointer
@@ -533,7 +533,7 @@ ggtt_write(struct io_mapping *mapping,
 }
 
 /**
- * This is the fast pwrite path, where we copy the data directly from the
+ * i915_gem_gtt_pwrite_fast - This is the fast pwrite path, where we copy the data directly from the
  * user into the GTT, uncached.
  * @obj: i915 GEM object
  * @args: pwrite arguments structure
@@ -723,7 +723,7 @@ i915_gem_shmem_pwrite(struct drm_i915_gem_object *obj,
 }
 
 /**
- * Writes data to the object referenced by handle.
+ * i915_gem_pwrite_ioctl - Writes data to the object referenced by handle.
  * @dev: drm device
  * @data: ioctl data blob
  * @file: drm file
@@ -808,7 +808,7 @@ i915_gem_pwrite_ioctl(struct drm_device *dev, void *data,
 }
 
 /**
- * Called when user space has done writes to this buffer
+ * i915_gem_sw_finish_ioct - Called when user space has done writes to this buffer
  * @dev: drm device
  * @data: ioctl data blob
  * @file: drm file
-- 
2.40.0.348.gf938b09366-goog

