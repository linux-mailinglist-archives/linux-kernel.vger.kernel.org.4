Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C1063BD33
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiK2JqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiK2JqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:46:00 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C9E5476B;
        Tue, 29 Nov 2022 01:45:59 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so5857155pje.5;
        Tue, 29 Nov 2022 01:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko+qbf+b0Yv7gj3x+dmqgXT2t4VmwkOjBb0uMWb0qeo=;
        b=QMTGc8dATSuNa3qa2tdoi28432ZIGdXhepGsvXVGCtpTOLz41a16mSV6pjjVIeEsO9
         PJrhktRoFkYYeAO5E8N+9SXNKvsJBnpVmZY0oDEWaVJ4nC37dthNqFz+2bX0NyoPb7ji
         D3/HxVLjkt5GkrZw/CysGVyK3EGEpKo/THJR8Y4wpL092B6BWaFSmqNMjXwB4mWqoEUN
         jR4GhjSo6zgxjIkYcZt9OQr8ijnL/KwAbKvTjac/uMZE1ZFsFmqlIY33esnYdKCmgngv
         BTvsjNSh5Vp/JawszvH9dXG0Y2xfdA0UHyun1wvwR0r5/DDXMLHnOiXxFgnUwonl+OPZ
         ecjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ko+qbf+b0Yv7gj3x+dmqgXT2t4VmwkOjBb0uMWb0qeo=;
        b=sMfwjkG+8tGwzJTMYHxnqGcGONkJaGWEuXBZ02CpuFicd/Ju+kH2vnDqd7vUp52FUr
         mGx/FenaZ5uTBGC3mUnAROFZhj9a4fwlZ8kRzGS+lz1wBlatEUN1Hm/kCEET6QG1ZJoL
         LsznlsNITwOyumMOhhmffLCYHgpyqLT+KbVblKwCldvgwhvsaSU/Nsv2ADrqJd07wU3X
         9OF7BDrvgrBLSENbhvpwoR51f6nxaOCaJ+yVLggeBvJaqTmXjvwQf9m2lQfcd5vEhB6g
         pdV+Dn4ra/FOtMdycTCnhopPG8fLiIyD6iHBPen3QHGscwRJORtHu6HeBSBNUfyhhJCN
         oJmA==
X-Gm-Message-State: ANoB5pmVolh0qfD/Wh6I3sRzj7VDFq6hstb92eXbW/K5iNGRZgTZl7WN
        KYeeXPRaQkAFW4p4cVewDQo=
X-Google-Smtp-Source: AA0mqf4Ne7K6UCo3LviuEHHi1Ldd3jeDKdUSANZrcIYdiQ5jgjAkHiE15SlUMXjD5rBe+tGAb5h5og==
X-Received: by 2002:a17:90a:4302:b0:20a:e469:dc7d with SMTP id q2-20020a17090a430200b0020ae469dc7dmr56845748pjg.97.1669715158916;
        Tue, 29 Nov 2022 01:45:58 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b001895b2d48a1sm8259266plk.253.2022.11.29.01.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 01:45:58 -0800 (PST)
From:   zys.zljxml@gmail.com
To:     thierry.reding@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jonathanh@nvidia.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH] drm/tegra: Remove redundant null checks before kfree
Date:   Tue, 29 Nov 2022 17:45:46 +0800
Message-Id: <20221129094546.197424-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yushan Zhou <katrinzhou@tencent.com>

Fix the following coccicheck warning:
./drivers/gpu/drm/tegra/submit.c:689:2-7: WARNING:
NULL check before some freeing functions is not needed.

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---
 drivers/gpu/drm/tegra/submit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index b24738bdf3df..df34c5daa400 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -685,8 +685,7 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 		kfree(job_data->used_mappings);
 	}
 
-	if (job_data)
-		kfree(job_data);
+	kfree(job_data);
 put_bo:
 	gather_bo_put(&bo->base);
 unlock:
-- 
2.27.0

