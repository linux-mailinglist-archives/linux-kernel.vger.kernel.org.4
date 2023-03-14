Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132266BA262
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCNWUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjCNWTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:19:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466EFB760;
        Tue, 14 Mar 2023 15:18:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id br6so3774207lfb.11;
        Tue, 14 Mar 2023 15:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678832307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=unv7jkKhSyV7JGv+yIPCmnr6mTwYXd0VFoIWTdDr37E=;
        b=l29oKArfJSGBXwVSUsqNOVE5S1Zb1OAFW9yIYHA6BfStr7PKGfLDsfMMLA6d/Rim+i
         vlQa2cyZf2i3GTkS1Bp9hpIL422z8Cbe6bBP/aKeeCCWWfMZB3FtKzg/4naXwkfV5t2G
         6CWm50VuCCibVX/Zd7cAPubC9x/HXSs3JrBi7O4NphxayguyB5cHAM3Sua5ZF6AqSNCA
         4skJIVz7qV+q6n6msywUkLZ7lyfIw+ad4oF2wrkdiNWScpJlIaNtF8Pf42XMmZY8I70s
         cy5m91CfWMyhGWDUHWXuVSX+udh7nNrKtjpNoO4j/M1oaLIRbKKqY7QOVrNDjwpNxKqM
         4Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678832307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unv7jkKhSyV7JGv+yIPCmnr6mTwYXd0VFoIWTdDr37E=;
        b=ssOvbJhvA8LTG1Erui13ytY4PNCUZqjiaLi0tI2LT8iMapiQNcEavNHeN6tUMOiT+X
         lZOv7Otw4tQ5Mb7C8/15u/ETZqS4+Alzb0TEI5UmC+XYbWwW9kSvpqy2xfTeaIBNCRur
         +ZIeWfhAKFx1Kt4AP8uFiXnVEM0iJW4PSseoIyNzS+GNNCQWVDx+WBv/s5HJvP2nRtFE
         Ko0GdrxsxFy/oT+UEpQ57p7YNmUrqQMAqv+Zlm0YO6dTedfjpLgHVZSZcD4rQbemaN23
         ZpYteluTn1iJndqgvxmqWchMKgIXWBsxWVNQY80iJSjqclRbYBSQr9OdP/wGJP61vUpF
         H4rA==
X-Gm-Message-State: AO0yUKXnOxpHPcXeqpk1XoxxDGEIQ8DefkYfXPSUGHxkhRI4q3r2LLYt
        0LXYsZewtfN7Rx4A83bhdFF1xZ0BUw3NLw==
X-Google-Smtp-Source: AK7set/rJc+gSrVKA7Qa6wO50JW4WEimCebjK+oKixALe42HEQYmov1TyILND58iArHQtSRdwvObLQ==
X-Received: by 2002:ac2:4822:0:b0:4db:3e7e:51dc with SMTP id 2-20020ac24822000000b004db3e7e51dcmr1199459lft.55.1678832307446;
        Tue, 14 Mar 2023 15:18:27 -0700 (PDT)
Received: from localhost.localdomain (byw237.neoplus.adsl.tpnet.pl. [83.30.42.237])
        by smtp.gmail.com with ESMTPSA id l7-20020ac24a87000000b004d23763fe96sm554893lfp.72.2023.03.14.15.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 15:18:27 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: msm: adreno: Disable preemption on Adreno 510
Date:   Tue, 14 Mar 2023 23:17:17 +0100
Message-Id: <20230314221757.13096-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Downstream driver appears to not support preemption on A510 target,
trying to use one make device slow and fill log with rings related errors.
Set num_rings to 1 to disable preemption.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: e20c9284c8f2 ("drm/msm/adreno: Add support for Adreno 510 GPU")
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index d09221f97f71..074b4e9a8500 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1743,6 +1743,7 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 	struct a5xx_gpu *a5xx_gpu = NULL;
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
+	unsigned int nr_rings;
 	int ret;
 
 	if (!pdev) {
@@ -1763,7 +1764,12 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 
 	check_speed_bin(&pdev->dev);
 
-	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 4);
+	nr_rings = 4;
+
+	if (adreno_is_a510(adreno_gpu))
+		nr_rings = 1;
+
+	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, nr_rings);
 	if (ret) {
 		a5xx_destroy(&(a5xx_gpu->base.base));
 		return ERR_PTR(ret);
-- 
2.25.1

