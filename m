Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B44468E66F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBHDGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBHDGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:06:15 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20EB3E62D;
        Tue,  7 Feb 2023 19:06:14 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 16so2451619pfo.8;
        Tue, 07 Feb 2023 19:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XUAc3Kmtrw7bkWSIP/D/yItveoAW2k52Mgjl/bK0iks=;
        b=nG1NPZrb8LiHm/evfdCL7aILi5Dz1X2y0XkCLveyLG6b95WG1Xd/ycmKwxGCrJ/1i1
         f37gy2g+pBiPMck7Zd6TMa7ontAXyxDLdI85fMnp7FmfxETpGYraKppzolHagQvu/nEE
         GkfOPZh7bpprcLBC7+DdhPtuv/V620CA+Vw7hpLu4Dtsk9webLbfnWk+61WAgFmMi/Ce
         Njd/giWv2Pbq9vFEKR7WtNVwQb1I3zoytjUwogVmk2ek8hgIppzxx9sERa+cX4tOSdB4
         W1WBKFamsjpQ+18Xw2cKhuuHdJWWuaJWJFaIWEWjRodoK4fDvm0iPqwG7WTWhllHmfx0
         wqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUAc3Kmtrw7bkWSIP/D/yItveoAW2k52Mgjl/bK0iks=;
        b=ZloemRWddIkoKEaZQ4B2L13ZhNehmtr2+wjVej2uLa37H4Dbl8ka6TCWjDiSi0n9np
         kniCCSoAcwItm5zpIEH0gIn+tPrI028YIGvs1+dvHJnEkuRV4sWS0ANl1f53PJTL/bHb
         MEi23+uXva2gU1Qxyyv/892e+ZHluH61Mhgem1UxFOQu3Mr9nBZxigNr+1CLm7YBE4s+
         e/j6Cjaa8HqDW5UQw+4VSf259H3dNh2DRnblBJiO+5TGvvVa0B8ZISSrkpsDu50mztmB
         5rgDobp++vqVee7Ka7gWxF4nEk4dNcvq0jz3/KgH62m9tDb6EF9M6tzVQlpo/TDmFQI/
         lPOQ==
X-Gm-Message-State: AO0yUKWEsIUS4mtDMBMI4nmc24Kfywp/AQ9+rJX+4r1PcEgcz+8B00N+
        tqB3nEeG+s/bGgPJ1R/CARY=
X-Google-Smtp-Source: AK7set9/i1uN8fisjkFwIiio/QMsAN3f7BbUkw+peP+WD5bgQgTEOd07h5aHGqJX2N2ZlDpqbwHXhw==
X-Received: by 2002:a62:3203:0:b0:590:7623:9c6f with SMTP id y3-20020a623203000000b0059076239c6fmr4417969pfy.34.1675825574434;
        Tue, 07 Feb 2023 19:06:14 -0800 (PST)
Received: from localhost.localdomain (arc.lsta.media.kyoto-u.ac.jp. [130.54.10.65])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b005a7c892b435sm2118935pfn.25.2023.02.07.19.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 19:06:14 -0800 (PST)
From:   Taichi Nishimura <awkrail01@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, skhan@linuxfoundation.org,
        Taichi Nishimura <awkrail01@gmail.com>
Subject: [PATCH] Fix drm documentation warning
Date:   Wed,  8 Feb 2023 12:05:23 +0900
Message-Id: <20230208030523.759146-1-awkrail01@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Taichi Nishimura <awkrail01@gmail.com>
---
 include/drm/drm_file.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 0d1f853092ab..cffccf6b94de 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -407,8 +407,6 @@ static inline bool drm_is_render_client(const struct drm_file *file_priv)
  *
  * Returns true if this is an open file of the compute acceleration node, i.e.
  * &drm_file.minor of @file_priv is a accel minor.
- *
- * See also the :ref:`section on accel nodes <drm_accel_node>`.
  */
 static inline bool drm_is_accel_client(const struct drm_file *file_priv)
 {
-- 
2.25.1

