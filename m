Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB4B6DD7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDKKUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDKKUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:20:46 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A47F2D61
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:20:45 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by michel.telenet-ops.be with bizsmtp
        id jNLe2900D1C8whw06NLeKC; Tue, 11 Apr 2023 12:20:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pmB6J-00Gaa2-Ip;
        Tue, 11 Apr 2023 12:20:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pmB78-00EHKL-Je;
        Tue, 11 Apr 2023 12:20:38 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan@rox.of.borg, Xinhui <Xinhui.Pan@amd.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] drm: Spelling s/sempahore/semaphore/
Date:   Tue, 11 Apr 2023 12:20:35 +0200
Message-Id: <50439958420f91cc97ad929437334bfb19ca4d90.1681208396.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspellings of "semaphore".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/i915/i915_request.c | 2 +-
 drivers/gpu/drm/radeon/cik.c        | 2 +-
 drivers/gpu/drm/radeon/r600.c       | 2 +-
 include/drm/task_barrier.h          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 630a732aaecca8fb..0bb368a5dd0bb107 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -1220,7 +1220,7 @@ emit_semaphore_wait(struct i915_request *to,
 	/*
 	 * If this or its dependents are waiting on an external fence
 	 * that may fail catastrophically, then we want to avoid using
-	 * sempahores as they bypass the fence signaling metadata, and we
+	 * semaphores as they bypass the fence signaling metadata, and we
 	 * lose the fence->error propagation.
 	 */
 	if (from->sched.flags & I915_SCHED_HAS_EXTERNAL_CHAIN)
diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 5819737c21c678d3..5d6b81a6578ef2ba 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -3603,7 +3603,7 @@ void cik_fence_compute_ring_emit(struct radeon_device *rdev,
  * @rdev: radeon_device pointer
  * @ring: radeon ring buffer object
  * @semaphore: radeon semaphore object
- * @emit_wait: Is this a sempahore wait?
+ * @emit_wait: Is this a semaphore wait?
  *
  * Emits a semaphore signal/wait packet to the CP ring and prevents the PFP
  * from running ahead of semaphore waits.
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index dd78fc4994024815..34457e51035278fb 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -2918,7 +2918,7 @@ void r600_fence_ring_emit(struct radeon_device *rdev,
  * @rdev: radeon_device pointer
  * @ring: radeon ring buffer object
  * @semaphore: radeon semaphore object
- * @emit_wait: Is this a sempahore wait?
+ * @emit_wait: Is this a semaphore wait?
  *
  * Emits a semaphore signal/wait packet to the CP ring and prevents the PFP
  * from running ahead of semaphore waits.
diff --git a/include/drm/task_barrier.h b/include/drm/task_barrier.h
index 087e3f649c52f02d..217c1cf21c1ab7d5 100644
--- a/include/drm/task_barrier.h
+++ b/include/drm/task_barrier.h
@@ -25,7 +25,7 @@
 
 /*
  * Reusable 2 PHASE task barrier (randevouz point) implementation for N tasks.
- * Based on the Little book of sempahores - https://greenteapress.com/wp/semaphores/
+ * Based on the Little book of semaphores - https://greenteapress.com/wp/semaphores/
  */
 
 
-- 
2.34.1

