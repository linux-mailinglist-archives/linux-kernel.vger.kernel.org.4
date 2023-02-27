Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011FE6A41CD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjB0Miz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0Miy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:38:54 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10F91D93A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 04:38:41 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p20so5311634plw.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 04:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:subject:to:date:from:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knY8erri7Al7Rbw0Mlzq10z3XLQCpm6GRDGhp6tSwts=;
        b=fXMH3+1o3+BJ2szxXx3b0iQyiTiVOTXmeFKZeaqJZ1JU/CX9es95LdKY43NinQgRsN
         4JG/3xfV24tbvlcK7ymobth8Oey+sBEJlZypNl3cuERr7cp94QMRVFsMEfc51qSoBsu+
         K/eXbZv/f4lg3km11+rL7+ow+XOXh0ld7GNFwUJxv2+/PHB0l5+/E9/SYyVoa97WvieV
         QakiAX+XBUwIxUUWgKGqBz41KoVjl2ii3xqqBD7ClcSvERS7cggDYh8MpEL3B1c01oYl
         JAnq+Qxkv/b/ivQR6DUgLqri0Ju6eNWfiv+uK0Mn8sPhr1Q5I0ZxrEWPOFEwbXLip1E+
         ibTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:subject:to:date:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knY8erri7Al7Rbw0Mlzq10z3XLQCpm6GRDGhp6tSwts=;
        b=X9DA9E6+pr1yAbGjHjqEaaWsgN2DDIkborDEkh66UAXUERDLKlYvHedOMb5fBtcaE5
         5j/UmLSN1g5EyBBpchwKtBD0nx63HMQaY4OkAPDlqaY4YVEaO0PahW0TX1bXZluokQNj
         g2sGizgqnxmM5ekhoaugn6FsQISe31h1BVgCtBjcyo4j9T3CD9H74bXk42R0Oy95AY0Q
         yW7b2TycnEyJBl9EgG7kSY5tz6r4ZITZ/EXedO+3s98/KW2RDahk5Tkmbe4Z9Au6Wz3h
         okC+bBQUWJWy9MzOiiNo/IksMG+T9ByyikxqmJJ40paPA2pFvys/g5qqxQQR2CcCuxGF
         VkGg==
X-Gm-Message-State: AO0yUKVeQ1luRExVi3DicdTkEYj8XPBWsDmwlW7KRmXwfJ5rOfxH87lu
        NH01Cw6o3qPz47RU2/8i3k8=
X-Google-Smtp-Source: AK7set8kx3J/O+vfdEgH/w3+9Wpj+8KdJek3C4qPhbE/x323eGgBYYX6cc5sIq5PFSMvr32lTztNQg==
X-Received: by 2002:a17:903:234b:b0:196:595b:2580 with SMTP id c11-20020a170903234b00b00196595b2580mr29689685plh.0.1677501521385;
        Mon, 27 Feb 2023 04:38:41 -0800 (PST)
Received: from sie-luc. ([124.89.8.225])
        by smtp.gmail.com with ESMTPSA id jd1-20020a170903260100b001991942dde7sm4522195plb.125.2023.02.27.04.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 04:38:41 -0800 (PST)
Message-ID: <63fca451.170a0220.3cfe.698c@mx.google.com>
X-Google-Original-Message-ID: <20230227123743.GA25685@sie-luc.>
From:   Luc Ma <onion0709@gmail.com>
X-Google-Original-From: Luc Ma <luc@sietium.com>
Date:   Mon, 27 Feb 2023 20:38:36 +0800
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vram-helper: fix typos in vram helper doc
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: a5f23a72355d ("drm/vram-helper: Managed vram helpers")
Signed-off-by: Luc Ma <luc@sietium.com>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index d40b3edb52d0..f1539d4448c6 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -45,7 +45,7 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs;
  * the frame's scanout buffer or the cursor image. If there's no more space
  * left in VRAM, inactive GEM objects can be moved to system memory.
  *
- * To initialize the VRAM helper library call drmm_vram_helper_alloc_mm().
+ * To initialize the VRAM helper library call drmm_vram_helper_init().
  * The function allocates and initializes an instance of &struct drm_vram_mm
  * in &struct drm_device.vram_mm . Use &DRM_GEM_VRAM_DRIVER to initialize
  * &struct drm_driver and  &DRM_VRAM_MM_FILE_OPERATIONS to initialize
@@ -73,7 +73,7 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs;
  *		// setup device, vram base and size
  *		// ...
  *
- *		ret = drmm_vram_helper_alloc_mm(dev, vram_base, vram_size);
+ *		ret = drmm_vram_helper_init(dev, vram_base, vram_size);
  *		if (ret)
  *			return ret;
  *		return 0;
@@ -86,7 +86,7 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs;
  * to userspace.
  *
  * You don't have to clean up the instance of VRAM MM.
- * drmm_vram_helper_alloc_mm() is a managed interface that installs a
+ * drmm_vram_helper_init() is a managed interface that installs a
  * clean-up handler to run during the DRM device's release.
  *
  * For drawing or scanout operations, rsp. buffer objects have to be pinned
-- 
2.25.1

