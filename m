Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30BF6A509C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjB1BYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1BY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:24:29 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C75149AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:24:28 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id kb15so8164899pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:subject:to:date:from:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DAC/FV2vHAHfczoWyUaI0s6B/ySA4HkGwdtS4HpH9c8=;
        b=EaDsn/v1DRlAFKlaIX13mBSY8P+gB479SffHZVqrtvHrlqWBoWXhLyx06o2if/7yBz
         N4gt1KKsqP/VmC0Wi47Rvt8hiZSlOTFHJoENRyZzotiQYcnHmEgAhEMNVC3XfZ3MWVlq
         7x3gVgXhRRxNuT5b+wC5AEy80zqUtyThOpCsB19uHlvn1FSV+7fw4qceEcs7etXxGmUl
         xRt2Un+UI7zumnsXypeJPlX5ce9NloZkxRnuxk+wfTOkqYVQrhdnFAKZ9O6wBfJI5Ufs
         z4SlaK6NRUKdqy7n0Tc+ytxkvVwUIEF7nbCDEk68Dm70/D3iB2t4S4Rbb/hRjLX53v/1
         8qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:subject:to:date:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAC/FV2vHAHfczoWyUaI0s6B/ySA4HkGwdtS4HpH9c8=;
        b=zjA45By9XyMIOSy/NGdFily0QlF0tID1OMK4cBvOPX6woD8wWlP8TBDL4D6E0SNfZr
         qP7GaP28neMeb3lDIzYpahpy6s31Tf9C/d2AVtXoLGvp1x3dm3vadjMLGlGZaFPD6wRy
         HXKErLmGCjciawmDIiHV22GJPwY1pOb4yMDHYbs2SZ6PaJ+v4zKfc98yTBaSrbgVXFrq
         +uPHixVTQNGjQiGX2ERsdocVB5PNB+Yd46gG39mCH/UyQz+Es4vp+Qs5IRNn5XGEtRRy
         AsvSVLwFybzAAQkifdvyHPOULVMg+/JmDrys/2ROR4xUnQmI6xoybwO/qa33lHKrTF1z
         Jd5w==
X-Gm-Message-State: AO0yUKV3oI66Mg79VKBG6mnqmWPjh/xewntN0bHtanrEikpjIapNZhnk
        o47yiUp5wsEic4kLDgXw2Ew=
X-Google-Smtp-Source: AK7set+VH06+4f/+qsowUJv19VFvjDWbt8UgHPzIzz2pJNbeI6vDcy1hoyrSdx+xyr+Iur5sASKjKA==
X-Received: by 2002:a05:6a20:12cd:b0:c2:f930:45e8 with SMTP id v13-20020a056a2012cd00b000c2f93045e8mr1608424pzg.46.1677547468190;
        Mon, 27 Feb 2023 17:24:28 -0800 (PST)
Received: from sie-luc. ([124.89.8.225])
        by smtp.gmail.com with ESMTPSA id j4-20020a62b604000000b005b02ddd852dsm4937099pff.142.2023.02.27.17.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 17:24:27 -0800 (PST)
Message-ID: <63fd57cb.620a0220.4e1b.8886@mx.google.com>
X-Google-Original-Message-ID: <20230228012422.GA27528@sie-luc.>
From:   Luc Ma <onion0709@gmail.com>
X-Google-Original-From: Luc Ma <luc@sietium.com>
Date:   Tue, 28 Feb 2023 09:24:22 +0800
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/vram-helper: fix function names in vram helper doc
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

Refer to drmm_vram_helper_init() instead of the non-existent
drmm_vram_helper_alloc_mm().

Fixes: a5f23a72355d ("drm/vram-helper: Managed vram helpers")
Signed-off-by: Luc Ma <luc@sietium.com>
---
v1 -> v2: improved commit message and add changelog

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

