Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C0B5B30AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiIIHgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiIIHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:35:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C9685FF6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E775861EDA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51D1C43145;
        Fri,  9 Sep 2022 07:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708893;
        bh=0yDdul4ArmI1gn4+c8wJwKXVW2KLD89n35VfLmfAXes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKiTUO246Oprx6Kx6epvFKbjnmPJx7i1nxc+xp65WIWHc5b7qvO9F6siqz+NjJfSy
         bdTAGPMjSQMBsb55u1Av8xlkadly6+5OI7VhkKRyNQstrf5AAus7zGCSy1SxWJAT00
         GArg/Bbl7Oy50LC1yGzgD/4Tc6pVM5FAwG8yU5fmBFvd5/0QhNWRpBnmZ+tg4N3rV9
         rLHJZt6h8BL/CGMVoIho94kzq45kW+wTmMaTe52BEilLlO57xqDIxWISMOX5zEsN0c
         s0ZFtPEmgJB0kRmBhK8OGVuikaFER0ZHW6SY6LY7JEECcCF6z7RNWc0q45euhV6rFt
         RAsCWl6KswcVA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXF-007FG7-Ut;
        Fri, 09 Sep 2022 09:34:45 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/37] drm/i915: i915_gem_ttm_pm.c: fix kernel-doc markups
Date:   Fri,  9 Sep 2022 09:34:15 +0200
Message-Id: <0895b600a6c32c598564cd0fa8566efd42038ce7.1662708705.git.mchehab@kernel.org>
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

The documentation for the flags field is missing there. It sounds
that some last-time change converted some bools into flags, but
the kernel-doc change didn't follow it.

Fix those warnings:

	drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c:135: warning: Function parameter or member 'flags' not described in 'i915_ttm_backup_region'
	drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c:135: warning: Excess function parameter 'allow_gpu' description in 'i915_ttm_backup_region'
	drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c:135: warning: Excess function parameter 'backup_pinned' description in 'i915_ttm_backup_region'
	drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c:199: warning: Function parameter or member 'flags' not described in 'i915_ttm_restore_region'
	drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c:199: warning: Excess function parameter 'allow_gpu' description in 'i915_ttm_restore_region'

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
index 07e49f22f2de..03256ebbeb5f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
@@ -128,8 +128,9 @@ void i915_ttm_recover_region(struct intel_memory_region *mr)
 /**
  * i915_ttm_backup_region - Back up all objects of a region to smem.
  * @mr: The memory region
- * @allow_gpu: Whether to allow the gpu blitter for this backup.
- * @backup_pinned: Backup also pinned objects.
+ * @flags: Bitmap field with the following flags:
+ *	%I915_TTM_BACKUP_ALLOW_GPU: allow the gpu blitter for this backup;
+ *	%I915_TTM_BACKUP_PINNED: backup also pinned objects.
  *
  * Loops over all objects of a region and either evicts them if they are
  * evictable or backs them up using a backup object if they are pinned.
@@ -193,7 +194,8 @@ static int i915_ttm_restore(struct i915_gem_apply_to_region *apply,
 /**
  * i915_ttm_restore_region - Restore backed-up objects of a region from smem.
  * @mr: The memory region
- * @allow_gpu: Whether to allow the gpu blitter to recover.
+ * @flags: Bitmap field with the following flags:
+ *	%I915_TTM_BACKUP_ALLOW_GPU: allow the gpu blitter for this backup;
  *
  * Loops over all objects of a region and if they are backed-up, restores
  * them from smem.
-- 
2.37.3

