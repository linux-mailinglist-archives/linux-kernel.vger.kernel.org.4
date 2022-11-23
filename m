Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31320636A79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiKWUES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbiKWUDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:03:55 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B83123F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:03:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t9-20020a5b03c9000000b006cff5077dc9so16861271ybp.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hIREoJf8N7Qc+VI7fjvFzFHUarKpVpMkIN35nq6OkBQ=;
        b=l1mxEbyxVuvgCMgyIuQZpfdpVrq4rsAJi1MvOzrIyNXqKnZd4Cx9qvZB//AScFMrEN
         qWwA9y4HbubWiFfhM3Xk9sU27zw1Q3wvw7BUIkIi5XHuc9KCpzp4jRY/r0+NQ2RwrMkX
         hWYNctdtH34/WkllwXFLqkty/1xRyZZJowBDeOitxO2DagCFfwGAGHQ7Axn9vvBoQDPL
         Srndn6yYz5xf88boenep/sbvzG5tkF6pKkg4x46jny08ohyb6DlPljEtHXhsGXhyL0+d
         hque1ArFzfYw9fX7WFNosN0JwHiMcfkzrG7q8UrIy246uRwo+JFiR7yw9OalVnXLMQ87
         9wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hIREoJf8N7Qc+VI7fjvFzFHUarKpVpMkIN35nq6OkBQ=;
        b=pLiEoncZqxBULlsUiOrA2ThkgLGZMGU4WD9Y9HKHpzcpakU12Ox9JjHK0tSQFr4t5g
         FCHl6FGSzXbEvAt7jPlSFkdeprpdLUA2+4rw9guP4yMLj76sUdYk7//SEbxYOGpMUr7n
         XYjwQf4HMm9Y7GUgZUhy1yFQccqqBWJMLLQEd+/Vd19C4oW7ki2mbshVBZ2fL0gDuyDC
         uFo2t1WNuXY/KsypwDVmqFJjFF9d7enw+swVPPCLtFpN/MGovmpS7ln3xWEBSli5PbIX
         zPiJ3bxM/LR9xMx2McNO0ZbBViUMw307PTffF13IvzfzjaoxPI/6OiDG9maiA2cfDRUl
         NiNg==
X-Gm-Message-State: ANoB5pm9suKw9V5N8MbEXs+8xkzZQL+rBntlnvMcvhrXo6/qDml50gSY
        vD60IceQro7A6N7pyUOtWWfGHxRbxVHcj8mt9KdgRU7NoOmqMpYQQCBL0eIda6FWt/gOQiJQUms
        sJhznjCQCQO0XTYxUTXIXi2KukEcqNOLAQFjDj1ecWx6NCw9vfo5v9ctUdCBM+ZeISFeGXWA=
X-Google-Smtp-Source: AA0mqf5MO01AjcVUz5B2xUKnE+P+u7xDM/v7K4PW+5p9xOAl/tBWIExyOJDPWYMpp477NUnPNz5J+0fQIOf+
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:5805:0:b0:3a5:aebd:2bed with SMTP id
 m5-20020a815805000000b003a5aebd2bedmr8ywb.174.1669233791751; Wed, 23 Nov 2022
 12:03:11 -0800 (PST)
Date:   Wed, 23 Nov 2022 20:03:08 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221123200308.400566-1-jstultz@google.com>
Subject: [RESEND][PATCH] MAINTAINERS: Add Sumit Semwal and Yongqin Liu as
 reviwers for kirin DRM driver
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        kernel-team@android.com, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I no longer have access to the HiKey boards, so while I'm happy to
review code, I wanted to add Sumit and Yongqin to the reviewers list
so they would get CC'ed on future changes and would be able to have
a chance to validate and provide Tested-by: tags

Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Tian Tao  <tiantao6@hisilicon.com>
Cc: Yongqin Liu <yongqin.liu@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: kernel-team@android.com
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <jstultz@google.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2585e7edc335..9f26e6b74ef4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6919,9 +6919,11 @@ F:	drivers/gpu/drm/gma500/
 DRM DRIVERS FOR HISILICON
 M:	Xinliang Liu <xinliang.liu@linaro.org>
 M:	Tian Tao  <tiantao6@hisilicon.com>
-R:	John Stultz <jstultz@google.com>
 R:	Xinwei Kong <kong.kongxinwei@hisilicon.com>
 R:	Chen Feng <puck.chen@hisilicon.com>
+R:	Sumit Semwal <sumit.semwal@linaro.org>
+R:	Yongqin Liu <yongqin.liu@linaro.org>
+R:	John Stultz <jstultz@google.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-- 
2.38.1.584.g0f3c55d4c2-goog

