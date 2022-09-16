Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83B15BB3A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiIPUsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiIPUsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:48:04 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52D4BA154
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:48:02 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-12b542cb1d3so44043954fac.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=8tndNWWo7lA8zxMWjXo79wFYy7T8DZ1WmSv9NU+Qn00=;
        b=ZWmfg1lRRT5cNVKTt0jTiHBgVMqzXKAg+mWeUHDA+3U1KWQQ49oYipINIxDFBWou6A
         OB4YQ8Z+slpnBCt0Ecv5s5cwk0g6/rfOl2/r4ds6cmgk3w8l+x2lTMSOp8Co0lyYwzdG
         f6XKy/puez2KLA3pbV37FoAKgr2RaXgNNyqPq+FJOxxxhBtbiihCspumLXPWuZm+FHjo
         awwyHCuyTSbbb+8IW5dBx/kMJgoOvf1kiJcQGwigm8xFAq3Jg6I/OC5CMbQinQTxI9x7
         ZQ8arAuZiUjrqVYmYHW3St2FHRGm+ASRqoTvvQ25s9EC7luoiUm9EMn/z8bwG6wP7OU2
         azrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8tndNWWo7lA8zxMWjXo79wFYy7T8DZ1WmSv9NU+Qn00=;
        b=XjwcudF/BM57GwzGhsXM/PWLjUaROwppT+42RwdrNSC+B3ZL5ZoYS4UgVLxm0axaBh
         kbpHWMvhTQooZv8oI+u4yH5S9WSrMbwr2Hur/J2TQAd8se9PSKJcVa3UWxrh28LmIuXd
         /PX/VXads7hTd4vOtTM/N9ijTu0OS0i+6SKN8h/TgiF9lPH7th4BsW0FqLe3E7DJwxvD
         7beZM80/Ci8n3zQsOnFpgMlqzrczVcf7AL8Fo+Yz9EZIIYfzi4T57esJ9xyMM3B8mXFc
         UDQ9ffNTkaVYi5S/rmYObdDIRMAkRMtjSOMAcGSUB68Pho1RVegYS7IaycsC77tly/sl
         KdaA==
X-Gm-Message-State: ACgBeo0K82q1LpPftIhWdS80vYRMneVNI8W2HLLpaBUgPNVNIPsMF2Ur
        SWmqIwnzg8+X50CXaB1SddCJ7ZBRbcg=
X-Google-Smtp-Source: AA6agR5G+ecb3He752RviFLpk7+0KdXJV/JKh/ZKfmg8l+9nkf1YYT8QIY9isMCp9DXbMAlDo2T6rw==
X-Received: by 2002:a05:6870:b290:b0:127:4089:227a with SMTP id c16-20020a056870b29000b001274089227amr9788780oao.8.1663361282172;
        Fri, 16 Sep 2022 13:48:02 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cd:8cb3:43e6:f4f3:1b9f:38fe])
        by smtp.gmail.com with ESMTPSA id r20-20020a4aea94000000b0044b47bb023fsm1803963ooh.37.2022.09.16.13.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 13:48:01 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Martin Krastev <krastevm@vmware.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Fix memory leak in vmw_mksstat_add_ioctl()
Date:   Fri, 16 Sep 2022 17:47:51 -0300
Message-Id: <20220916204751.720716-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the copy of the description string from userspace fails, then the page
for the instance descriptor doesn't get freed before returning -EFAULT,
which leads to a memleak.

Fixes: 7a7a933edd6c ("drm/vmwgfx: Introduce VMware mks-guest-stats")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 2aceac7856e2..089046fa21be 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -1076,6 +1076,7 @@ int vmw_mksstat_add_ioctl(struct drm_device *dev, void *data,
 
 	if (desc_len < 0) {
 		atomic_set(&dev_priv->mksstat_user_pids[slot], 0);
+		__free_page(page);
 		return -EFAULT;
 	}
 
-- 
2.34.1

