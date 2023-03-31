Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625E66D1C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjCaJ2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjCaJ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:28:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34B146BF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:27:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 99F56CE2E04
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9099DC433A0;
        Fri, 31 Mar 2023 09:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680254829;
        bh=q94izLl3IZgGvkKrUY20PN7lYkSiE2LwGs8Cj3mJZ74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWWE2lUsVb8TTMqOUSSf9JvM1P043iDZAbpWP4lDy9c2SbmizGgxIatWILrD2r+Jw
         VRlIVW9z3L3Jf9R//bIt92G80do478ZWtZ4Z2wdqmQq0+EAemK7uAoGpNJuk4C9CwK
         q51jc8bJ/aKQYT507TmrORLBmMTKKIA85L8VK2Gs8rD+E0VC55h11lEzGIO26XlwBT
         UOA2ybn4v6hx6dZ1QgP9KGQAJPQ9WbGHx0TCrO8p3KM1aX7XY+G4jn8VZPFhA4sRhV
         8dDEBXpDaGVDQnk+yaOaRc2NxClQWpYz85+UeOLcI/c2vxnWK8uq/JISgeRbP6DKIt
         1TDOlovDJ9CmA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 19/19] drm/i915/display/intel_wm: Fix a little doc-rot in intel_update_watermarks()
Date:   Fri, 31 Mar 2023 10:26:07 +0100
Message-Id: <20230331092607.700644-20-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331092607.700644-1-lee@kernel.org>
References: <20230331092607.700644-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

 drivers/gpu/drm/i915/display/intel_wm.c:46: warning: Function parameter or member 'i915' not described in 'intel_update_watermarks'
 drivers/gpu/drm/i915/display/intel_wm.c:46: warning: Excess function parameter 'dev_priv' description in 'intel_update_watermarks'

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_wm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_wm.c b/drivers/gpu/drm/i915/display/intel_wm.c
index bb99179cd5fd1..b615449e70b47 100644
--- a/drivers/gpu/drm/i915/display/intel_wm.c
+++ b/drivers/gpu/drm/i915/display/intel_wm.c
@@ -11,7 +11,7 @@
 
 /**
  * intel_update_watermarks - update FIFO watermark values based on current modes
- * @dev_priv: i915 device
+ * @i915: i915 device
  *
  * Calculate watermark values for the various WM regs based on current mode
  * and plane configuration.
-- 
2.40.0.348.gf938b09366-goog

