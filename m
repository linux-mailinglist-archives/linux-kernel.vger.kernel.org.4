Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AEF5B306B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiIIHjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiIIHiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:38:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E8011B019;
        Fri,  9 Sep 2022 00:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32F1DB8238E;
        Fri,  9 Sep 2022 07:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B39C4FF12;
        Fri,  9 Sep 2022 07:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708895;
        bh=4VHxSufjm7xKjm4fLVM1k5XlVY9FOQF8GqPlLaxsR/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IjK72AabMheDNyecrDNS+2qJ37gQx3g/XAwHXh7MZuVJHUUrZCXHkbqVDv8sKXCgI
         +LFBWaFuu+b3lfbV76KhgcMppf8ITiYS9aiX+KP1R4yHRf99EwQVlNn5qsKdB1oz4R
         jhRwJ14C67YZLzcAbpc/yMEK5cGpCACKu8r9oeWuK4js1ryimC2OyuncKA/fRi9CXu
         nUDmgaI/6lp57cyRd/1nH5ytlcns0d4pIBHGzSlp8y/fdsFSi+VSygj7Dw4Rs4i6z/
         sRv4vCn2v+jJckkhBim6vwXGXx+71DCVjwvDHJIYIzswklM5LoKpS/9/rPZ+O03ooj
         SXJw/7D8u+35g==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXH-007FHf-FB;
        Fri, 09 Sep 2022 09:34:47 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 32/37] docs: gpu: i915.rst: add the remaining kernel-doc markup files
Date:   Fri,  9 Sep 2022 09:34:39 +0200
Message-Id: <7ed6d74b75061fb2800e5a59f5282b224bd0621a.1662708705.git.mchehab@kernel.org>
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

There are other files with kernel-doc markups:

	$ git grep -l "/\*\*" $(git ls-files|grep drivers/gpu/drm/i915/) >kernel-doc-files
	$ for i in $(cat kernel-doc-files); do if [ "$(git grep $i Documentation/)" == "" ]; then echo "$i"; fi; done >aaa

Add them to i915.rst as well.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 Documentation/gpu/i915.rst | 85 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 545fe630557a..7f5cd01ed398 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -13,6 +13,11 @@ Core Driver Infrastructure
 This section covers core driver infrastructure used by both the display
 and the GEM parts of the driver.
 
+Core driver
+-----------
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_driver.c
+
 Runtime Power Management
 ------------------------
 
@@ -29,6 +34,8 @@ Runtime Power Management
 
 .. kernel-doc:: drivers/gpu/drm/i915/intel_pm.c
 
+.. kernel-doc:: drivers/gpu/drm/i915/intel_wakeref.h
+
 Interrupt Handling
 ------------------
 
@@ -44,8 +51,25 @@ Interrupt Handling
 .. kernel-doc:: drivers/gpu/drm/i915/i915_irq.c
    :functions: intel_runtime_pm_enable_interrupts
 
-Intel GVT-g Guest Support(vGPU)
--------------------------------
+Memory Handling
+---------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_vma_resource.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_vma_resource.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_vma.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_vma.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_mm.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/intel_memory_region.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_memcpy.c
+
+Intel GVT-g Guest Support (vGPU)
+--------------------------------
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_vgpu.c
    :doc: Intel GVT-g guest support
@@ -109,6 +133,55 @@ Workarounds
 .. kernel-doc:: drivers/gpu/drm/i915/gt/intel_workarounds.c
    :doc: Hardware workarounds
 
+Scatterlist handling
+--------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_scatterlist.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_scatterlist.c
+
+i915 request
+------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_request.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_request.c
+
+Others
+------
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_ioc32.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_gpu_error.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_active.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_deps.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_deps.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/intel_device_info.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_params.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_sw_fence_work.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_syncmap.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/intel_pcode.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_reg_defs.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/intel_wopcm.h
+
+
+Protected Xe Path (PXP)
+-----------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/pxp/intel_pxp_irq.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/pxp/intel_pxp_tee.c
+
 Display Hardware Handling
 =========================
 
@@ -615,6 +688,12 @@ Protected Objects
 Table Manager (TTM)
 -------------------
 
+.. kernel-doc:: drivers/gpu/drm/i915/i915_ttm_buddy_manager.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/i915_ttm_buddy_manager.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/intel_region_ttm.c
+
 .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_ttm.c
 
 .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_ttm.h
@@ -624,6 +703,8 @@ Table Manager (TTM)
 Graphics Execution Manager (GEM)
 --------------------------------
 
+.. kernel-doc:: drivers/gpu/drm/i915/i915_gem.c
+
 .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_create.c
 
 .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_domain.c
-- 
2.37.3

