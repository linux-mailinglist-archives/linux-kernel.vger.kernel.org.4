Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEECA6D1C26
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjCaJ1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjCaJ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C5B1E73C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A2D56265A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219BBC4339B;
        Fri, 31 Mar 2023 09:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680254792;
        bh=ta2pbVKeW086ExcAdggWjg7nNpPFLKl54oJMSC9ka1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3gsDsoVQRjqVXWT3xex2OuYoYat0CyfY2hZdt9DGVD0jmEecHiZC8mlheKaXzyMK
         4J/M6Wb2D0GdWJqYSGnAGzax9sa39rCsWw6XB8PaXvmVDGfcGHNSxE5DnzyLKXI8B3
         j4KuBztziW1CycbQiFYbMPSuSKXVX4TqHNr2R/PhrLT5SK/JZgpSvXmX8FMEEyzxqd
         HgkdDrOoDsnanNom9Qu58oID52zl2K3/BNeoQWP/ogQvgktk2mKgCZHpn/0uDCR4J0
         p5SG9phpT0uqF29qnfcNMZAxun/JuUG6uwJFhgKG4XR30IOs6pK1CT/dN4wqM0FJlY
         /O25w0TrzyFdQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 07/19] drm/i915/gem/i915_gem_create: Provide the function names for proper kerneldoc headers
Date:   Fri, 31 Mar 2023 10:25:55 +0100
Message-Id: <20230331092607.700644-8-lee@kernel.org>
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

 drivers/gpu/drm/i915/gem/i915_gem_create.c:147: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/i915/gem/i915_gem_create.c:218: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/i915/gem/i915_gem_create.c:402: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_create.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_create.c b/drivers/gpu/drm/i915/gem/i915_gem_create.c
index e76c9703680ef..4270575f88908 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_create.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_create.c
@@ -144,7 +144,8 @@ __i915_gem_object_create_user_ext(struct drm_i915_private *i915, u64 size,
 }
 
 /**
- * Creates a new object using the same path as DRM_I915_GEM_CREATE_EXT
+ * __i915_gem_object_create_user - Creates a new object using the same path as
+ *                                 DRM_I915_GEM_CREATE_EXT
  * @i915: i915 private
  * @size: size of the buffer, in bytes
  * @placements: possible placement regions, in priority order
@@ -215,7 +216,7 @@ i915_gem_dumb_create(struct drm_file *file,
 }
 
 /**
- * Creates a new mm object and returns a handle to it.
+ * i915_gem_create_ioctl - Creates a new mm object and returns a handle to it.
  * @dev: drm device pointer
  * @data: ioctl data blob
  * @file: drm file pointer
@@ -399,7 +400,7 @@ static const i915_user_extension_fn create_extensions[] = {
 };
 
 /**
- * Creates a new mm object and returns a handle to it.
+ * i915_gem_create_ext_ioct - Creates a new mm object and returns a handle to it.
  * @dev: drm device pointer
  * @data: ioctl data blob
  * @file: drm file pointer
-- 
2.40.0.348.gf938b09366-goog

