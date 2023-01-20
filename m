Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CEE674D07
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 07:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjATGKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 01:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjATGKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 01:10:01 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E446E3BD
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 22:10:00 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id c5-20020aa78805000000b0058d983c708aso2006521pfo.22
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 22:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2df1AX9vEFHElFLE85x7VL7GO7iiZhbuXNwIiyvY6II=;
        b=XivhWV9162Ca8UPPyie5qUAF3Ijqb+QXg7qO6pAoH1AdkjleXRMcdOccPotvg0ILk/
         akmE4svkyF83ZWl072BCZhVrtXr/c8KLyRMq73qpkikHo45RhhOmwGHCVUZYwDGjDy9o
         PWSMxnJHkB6nvJgsM0IXLlZXs2onj6gTgzY3IIe1DAuPSq/q61lCuT1U2r0nMyXu7+Wd
         R7jyt4jweygU5WMqcrvWpqCYtUdaIkHsUd1bwXixO+x6It1FJuF4fefgCo1MYqbRnMqm
         jOQC0448jyUFIsmj96UKQLgfp8hq+W1uz0n1UTj1baeLkb0x/syT/PO6hVMbF9o8ECaZ
         A7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2df1AX9vEFHElFLE85x7VL7GO7iiZhbuXNwIiyvY6II=;
        b=4fJwXW/Rn41uvNFWZxF6aN2jKoZ7e6UJEwf+V6dtSH4wbSCA2L5PPt1Hdm2OTUiCCL
         w38WU2x2f2tFDe1HNHiZ9HXkWxU/qkYCQPUnuEm6Yvr8I9JsSDiv6FzRsYaRcils56Tt
         4oesXV7CtwT4kmesGtlwmUZ/R/rS3+9GcEMru6azqT3+GVKpvnLiS+ZFlhfMdN9mkaxD
         ZMF8/mpOfDpFj3i+9B29x39+P/KgY/JwA6kUIGNZy3CaNXeHXDLpg8EX08Q4C0gfJbno
         tt7zfAI7wsUgf7Se3ySw2rwbRMJghMeSwJW05GzLevSrAEbU9NNQEzafgg/DeHyDdaoU
         UOug==
X-Gm-Message-State: AFqh2kpSFmx/DZlqMTmbIKXfJBtecjoD3arh0CgN9//Ehx8cxJoN1Xxj
        JNwkVAkimpk9dRx/+/Wm29MsAtQFTZa12AQfQgVZEDSWbQR0iNLXvIW0y7j7FdmVZ6RcZAHRui6
        FT2+g2qR1idJ2QU+VEcVTphCGLL1kEtuhhlTl3b2YelahzQ7iED2T99n38Ajvsb4jgq2Dnn4=
X-Google-Smtp-Source: AMrXdXsetSs3g8u4UgPor/pNTwBdAVoZfoK52z2AQKhFpLJNZTNFb1pzifmxSUcx/jwYByYumrOWNS2RtFhr
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:bb08:b0:227:2288:bcd5 with SMTP id
 u8-20020a17090abb0800b002272288bcd5mr1606337pjr.8.1674194999674; Thu, 19 Jan
 2023 22:09:59 -0800 (PST)
Date:   Fri, 20 Jan 2023 06:09:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230120060956.1244187-1-jstultz@google.com>
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
index 42fc47c6edfd..82df566e6925 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7007,9 +7007,11 @@ F:	drivers/gpu/drm/gma500/
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
2.39.1.405.gd4c25cc71f-goog

