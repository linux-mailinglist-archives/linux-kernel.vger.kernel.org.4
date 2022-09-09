Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886EE5B3089
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiIIHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiIIHgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:36:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331D0D2777
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4DC94CE219D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D454C43159;
        Fri,  9 Sep 2022 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708894;
        bh=Zl17JvmadDKy/3VNMn31BnyV5NtPa5RS+yB/bCMIP4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ECWU6mwinOdCUNpO/HZpeKj+uKVIDFjfQmDPhU2sEGErgfzGfXvJwD3SBIWa9md21
         06aGtQvLVx7JhuWTkht4wMxjJabbyu/Zazd3lVsCIz4qeJ4Q26XFD24u4F9vpghl8/
         1x2OCrlPyg9OesW5ERtEJl1IXDdrpe3+K+Yeb9nkwBj4JqfyQ0yX7Rm4DFtQH83wUM
         9MMvuUYq8kmN9f7hdWAM1yxz7pT5UpWDAW3OTMxNOaWQPNpPTWA99C4PJ/buPadhco
         flL9Hf0rk41F1vy8aqiAmxar1AWxxqXyv7KFzoL+JhOzVVALAaS2z5QTkrYLW+7BGU
         aA2RiIwEJ7ZYA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXG-007FGh-HE;
        Fri, 09 Sep 2022 09:34:46 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/37] drm/i915: i915_gem_wait.c: fix a kernel-doc markup
Date:   Fri,  9 Sep 2022 09:34:24 +0200
Message-Id: <a43bcb92337531714f9b7cf6d158d599d5b630ad.1662708705.git.mchehab@kernel.org>
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

The return codes for i915_gem_wait_ioctl() have identation issues,
and will be displayed on a very confusing way. Use lists to improve
its output.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/i915_gem_wait.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
index 4a33ad2d122b..1fd5cff552ed 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
@@ -210,23 +210,25 @@ static unsigned long to_wait_timeout(s64 timeout_ns)
  * @data: ioctl data blob
  * @file: drm file pointer
  *
- * Returns 0 if successful, else an error is returned with the remaining time in
- * the timeout parameter.
- *  -ETIME: object is still busy after timeout
- *  -ERESTARTSYS: signal interrupted the wait
- *  -ENONENT: object doesn't exist
- * Also possible, but rare:
- *  -EAGAIN: incomplete, restart syscall
- *  -ENOMEM: damn
- *  -ENODEV: Internal IRQ fail
- *  -E?: The add request failed
- *
  * The wait ioctl with a timeout of 0 reimplements the busy ioctl. With any
  * non-zero timeout parameter the wait ioctl will wait for the given number of
  * nanoseconds on an object becoming unbusy. Since the wait itself does so
  * without holding struct_mutex the object may become re-busied before this
  * function completes. A similar but shorter * race condition exists in the busy
  * ioctl
+ *
+ * Returns:
+ * 0 if successful, else an error is returned with the remaining time in
+ * the timeout parameter.
+ * * -ETIME: object is still busy after timeout
+ * * -ERESTARTSYS: signal interrupted the wait
+ * * -ENONENT: object doesn't exist
+ *
+ * Also possible, but rare:
+ * * -EAGAIN: incomplete, restart syscall
+ * * -ENOMEM: damn
+ * * -ENODEV: Internal IRQ fail
+ * * -E?: The add request failed
  */
 int
 i915_gem_wait_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
-- 
2.37.3

