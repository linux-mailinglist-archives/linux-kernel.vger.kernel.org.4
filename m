Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2615B3085
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiIIHgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiIIHfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:35:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DB933E08
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21A8D61EDE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48048C4314F;
        Fri,  9 Sep 2022 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708894;
        bh=GE14tUIRSARvCfD6N+l719pwW/d67HBRQrGl3a2tYxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNy6H2eVEKlOS13dWBx+RGyWavTbqrRJsPgnGsYanXpBD5apnWK13RcLb9PKWYfCc
         5uFo4+5caZW1mo/WI9vBOfn5RG76PFVR+5Fv4fY/lGsimicaya0ncTdtcA0RamsK23
         4FsabQycVkX3KWCUHWvzLs3a2Xqt6kENk80ervjKlxRw07dXPeeV7eDA1RNmQqrhXr
         FcB68AazngpLSnDrsk8/dJ0MRfXwOErKHTmlcle9ROSBlMwy0YoHLxl7ZF2nAL8xGZ
         QqclhjmkbAaf90DSjZPAqIMg8vdqFW4Z1+WvoPCp8/pGVEGKabZAGdcpN0ytp5tu4U
         1+sl+hzaS6TNQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXG-007FGJ-5O;
        Fri, 09 Sep 2022 09:34:46 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jordan Justen <jordan.l.justen@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/37] drm/i915: document kernel-doc trivial issues
Date:   Fri,  9 Sep 2022 09:34:18 +0200
Message-Id: <98e26c9a5018fe335a45ea60388fde464a0bf9d4.1662708705.git.mchehab@kernel.org>
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

Fix those kernel-doc warnings:
	drivers/gpu/drm/i915/intel_region_ttm.c:199: warning: Function parameter or member 'offset' not described in 'intel_region_ttm_resource_alloc'
	drivers/gpu/drm/i915/i915_vma_resource.h:123: warning: Function parameter or member 'wakeref' not described in 'i915_vma_resource'
	drivers/gpu/drm/i915/i915_vma.c:1703: warning: Function parameter or member 'vma' not described in 'i915_vma_destroy_locked'
	drivers/gpu/drm/i915/i915_vma.c:751: warning: Function parameter or member 'ww' not described in 'i915_vma_insert'
	drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c:159: warning: Function parameter or member 'gt' not described in 'intel_gt_fini_hwconfig'
	drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c:146: warning: Function parameter or member 'gt' not described in 'intel_gt_init_hwconfig'
	drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c:113: warning: expecting prototype for intel_guc_hwconfig_init(). Prototype was for guc_hwconfig_init() instead
	drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c:113: warning: Function parameter or member 'gt' not described in 'guc_hwconfig_init'
	drivers/gpu/drm/i915/gt/intel_engine_types.h:276: warning: Function parameter or member 'preempt_hang' not described in 'intel_engine_execlists'

That are due undocumented parameters.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gt/intel_engine_types.h    | 1 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c | 5 ++++-
 drivers/gpu/drm/i915/i915_vma.c                 | 2 ++
 drivers/gpu/drm/i915/i915_vma_resource.h        | 1 +
 drivers/gpu/drm/i915/intel_region_ttm.c         | 3 ++-
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_types.h b/drivers/gpu/drm/i915/gt/intel_engine_types.h
index 633a7e5dba3b..7c5ad9071fe7 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_engine_types.h
@@ -271,6 +271,7 @@ struct intel_engine_execlists {
 	 */
 	u8 csb_head;
 
+	/* private: Used only in selftests */
 	I915_SELFTEST_DECLARE(struct st_preempt_hang preempt_hang;)
 };
 
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c
index 4781fccc2687..76f7447302a6 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c
@@ -103,7 +103,8 @@ static bool has_table(struct drm_i915_private *i915)
 }
 
 /**
- * intel_guc_hwconfig_init - Initialize the HWConfig
+ * guc_hwconfig_init - Initialize the HWConfig
+ * @gt: GT structure
  *
  * Retrieve the HWConfig table from the GuC and save it locally.
  * It can then be queried on demand by other users later on.
@@ -138,6 +139,7 @@ static int guc_hwconfig_init(struct intel_gt *gt)
 
 /**
  * intel_gt_init_hwconfig - Initialize the HWConfig if available
+ * @gt: GT structure
  *
  * Retrieve the HWConfig table if available on the current platform.
  */
@@ -151,6 +153,7 @@ int intel_gt_init_hwconfig(struct intel_gt *gt)
 
 /**
  * intel_gt_fini_hwconfig - Finalize the HWConfig
+ * @gt: GT structure
  *
  * Free up the memory allocation holding the table.
  */
diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index f17c09ead7d7..946f26138381 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -731,6 +731,7 @@ bool i915_gem_valid_gtt_space(struct i915_vma *vma, unsigned long color)
 /**
  * i915_vma_insert - finds a slot for the vma in its address space
  * @vma: the vma
+ * @ww: An optional struct i915_gem_ww_ctx
  * @size: requested size in bytes (can be larger than the VMA)
  * @alignment: required alignment
  * @flags: mask of PIN_* flags to use
@@ -1686,6 +1687,7 @@ static void release_references(struct i915_vma *vma, struct intel_gt *gt,
 /**
  * i915_vma_destroy_locked - Remove all weak reference to the vma and put
  * the initial reference.
+ * @vma: VMA to destroy
  *
  * This function should be called when it's decided the vma isn't needed
  * anymore. The caller must assure that it doesn't race with another lookup
diff --git a/drivers/gpu/drm/i915/i915_vma_resource.h b/drivers/gpu/drm/i915/i915_vma_resource.h
index e155f6f7af6f..02dd8bb89c0a 100644
--- a/drivers/gpu/drm/i915/i915_vma_resource.h
+++ b/drivers/gpu/drm/i915/i915_vma_resource.h
@@ -49,6 +49,7 @@ struct i915_page_sizes {
  * @__subtree_last: Interval tree private member.
  * @vm: non-refcounted pointer to the vm. This is for internal use only and
  * this member is cleared after vm_resource unbind.
+ * @wakeref: wakeref used for runtime PM reference.
  * @mr: The memory region of the object pointed to by the vma.
  * @ops: Pointer to the backend i915_vma_ops.
  * @private: Bind backend private info.
diff --git a/drivers/gpu/drm/i915/intel_region_ttm.c b/drivers/gpu/drm/i915/intel_region_ttm.c
index 575d67bc6ffe..c2f87683236a 100644
--- a/drivers/gpu/drm/i915/intel_region_ttm.c
+++ b/drivers/gpu/drm/i915/intel_region_ttm.c
@@ -181,7 +181,8 @@ intel_region_ttm_resource_to_rsgt(struct intel_memory_region *mem,
 #ifdef CONFIG_DRM_I915_SELFTEST
 /**
  * intel_region_ttm_resource_alloc - Allocate memory resources from a region
- * @mem: The memory region,
+ * @mem: The memory region
+ * @offset: The range start
  * @size: The requested size in bytes
  * @flags: Allocation flags
  *
-- 
2.37.3

