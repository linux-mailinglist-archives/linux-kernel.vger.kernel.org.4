Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA735EAE23
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiIZRYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiIZRXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:23:44 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF45312BD92
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:38:23 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id pf10-20020a17090b1d8a00b002037c2aad2bso8024958pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=aBQtcstDZQqLeHVlIM75vGyKaWR65kO7/EjVsPGFbYA=;
        b=EuXMliuCVgEb1UTMiKFb+ESdp6V3BzRKc+b7utuqQIOPOHNcwiAsdfKXv0CByTTMHO
         A/cmtXWFZtS8qARFtlVgSMUoZBimXHF1wz4CNwGtGvIz2LwpajwPSKklhsP+tlMtwmql
         maFFjcq1BNEqNzfcLBbn2QBILgjsUBkIRZDrEbP/Ee6rqtFXy5pVqdEqCVQYSaqQ/KxT
         QmrCgi9T2QAhE8Au227HDc7b87Lxp9Qyw4xLEnUVSufrfkujevJSc2cuw0Zin34Kx5iF
         dXhGmPgrci5SDslFl/iRJhPu5X5tnWB/YP+N83p2LX/+U7MLLaGbj62ZK1Etpu7gbWji
         lPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=aBQtcstDZQqLeHVlIM75vGyKaWR65kO7/EjVsPGFbYA=;
        b=1kg8tAD5yQFEwPjeYQ+Q0q4tGddi6HPIr6hGcaB7/XaP3ANx0HBLcX8iIdza+xwDa4
         HXLyJol7YCBBboCsc9mEclBH8MbA4J9RMAg7BwgBrb1Tu0/Wj+mxrCJ3Y3A7HbYi4cYx
         tYE/YADR2FBYEG1Kr0uOe5DdB85oUrJXPtl0p3EAzcDAU1SXr77xI7sWWwi88c3Lstds
         JF9a45/kDznXNk7WFOHoF2BhSOkzxs5yMz8UxYZ8zJpuhuSDTMK1rFtkcU4273//iKQY
         gEBTbtSpfMDiLIltdHPx1LPfEoW2ff60zWUoBzYCpBqmRKuNWEUEwQp7HJknN2KvH3Bi
         Zn3g==
X-Gm-Message-State: ACrzQf0YofVFjwnwhbOcB6e4+UzHo5Gil0d/l9yT7QoGK73e6X1YUbc6
        UNGzEG6xHJiSZtUXy9s0lLEugHom6cDscjrpogGLOnD193r5K26KDS/t2puDqiUSJZ8C7FV04Ou
        0iKzGohAJQBkxvEw7KRvJuq7NXgi7iqLgPJEOeeL5nEMHolf3OlPOKas1p2rBWjK4PV6MgtU=
X-Google-Smtp-Source: AMsMyM7311CIPZJFPTAvVFfQHxqDeZdSosVfC0bK8XteC7QK27a6RZCjRZFQy2YWBurbmRyr0JE2qBn9lDea
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:cd06:b0:203:ae0e:6a21 with SMTP id
 d6-20020a17090acd0600b00203ae0e6a21mr900179pju.0.1664210302025; Mon, 26 Sep
 2022 09:38:22 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:38:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926163815.332144-1-jstultz@google.com>
Subject: [PATCH] MAINTAINERS: Add Sumit Semwal and Yongqin Liu as reviwers for
 kirin DRM driver
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
index f5ca4aefd184..11027cf9b670 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6875,9 +6875,11 @@ F:	drivers/gpu/drm/gma500/
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
2.37.3.998.g577e59143f-goog

