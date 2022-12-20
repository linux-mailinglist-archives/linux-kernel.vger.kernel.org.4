Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2182651F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiLTLZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLTLZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:25:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32E914029
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:25:54 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so16140567pje.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qL3q8JCSm7dZpOMKxIJmM85ousNnPYyNvyBWJgJYTmw=;
        b=VGFKrEB5fp2xCuXYNsMMXnJNbm8MkZ1iJbKa2Rwjkhmj3iefziiq9C1Kdq9KwbGPB+
         3lQQ/dCEqIbaz0Ov/yxEGTRCupOiUzBiycb5Ng8xHjhk2iB+1IFbNAyQ5+33k7NEuU7A
         yc+p5rQVKmx3vklhIpZiRnu2vIpl5dGLwvFhXz6j7CtuRoLDweynCz6s3IsDSoCUMME8
         kx68hTeIlJGWI8XrySClqh+4Md2tZUqP8x2Vruai9KEjFsuMLyCZ/MITj86mrgu1Uy3+
         72zjtQ4MQZyH3g7XE7CiRphZZBJ754Im7DmJh4OGXtXwOTUdlP15L98DX5n6saPJUfAT
         VVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qL3q8JCSm7dZpOMKxIJmM85ousNnPYyNvyBWJgJYTmw=;
        b=wSB4HtVjPK5PjCSsU6i4lCxtjjPL8jA2348DVCBWkiLRk4vOA+feFljklWqSIL2Vry
         z2f63UCMLre0tXWktqgQAsbX3dBy0WpeKZ6EbEGsM/s0skU2XqWdEsz1BPw6n/LtACuM
         /JgDwFeEEIdmV4aWew4ewFn/+yxwLRudWwOaGLdnizhozABL2weMN+QpY3jl1j4XU3GI
         cy7B6wn4T7ZsNbQCh7aGCu9BsAEXLXEL8eMC7VROFZeqkS1vws8NqShXJXDp+isNlucx
         7+3IMXkw5e9c587SYILlSUs5AxoLLX/XhFGCXhwy6N1W1lSpyt741e/dfF21SaFM9NaJ
         LQEA==
X-Gm-Message-State: AFqh2ko26Sp7B070NFbCQi/YoBdiXgiNyDNA930Xmx80aKoBQE2aRu/7
        vn12SuLbLVYvDyL9OiZLRK0=
X-Google-Smtp-Source: AMrXdXtQog0J3OQ9/m/1FZxavZLd2S1k9iOW5sVlK6YbMXoSVlJieaashWu6o3f4JuLz8MC66NknHw==
X-Received: by 2002:a17:90a:cc08:b0:223:2aa6:7f0f with SMTP id b8-20020a17090acc0800b002232aa67f0fmr26260754pju.7.1671535554392;
        Tue, 20 Dec 2022 03:25:54 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id qe12-20020a17090b4f8c00b00212cf2fe8c3sm1194982pjb.1.2022.12.20.03.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 03:25:53 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] drm/vc4: Fix refcount leak in vc4_hvs_bind
Date:   Tue, 20 Dec 2022 15:25:44 +0400
Message-Id: <20221220112545.1460168-1-linmq006@gmail.com>
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

rpi_firmware_get() takes refcount, we should release it with
rpi_firmware_put(), add missing rpi_firmware_put() in the error path.

Fixes: 2a001ca00ad5 ("drm/vc4: hdmi: Rework hdmi_enable_4kp60 detection code")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index c4453a5ae163..816844ea60b1 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -809,6 +809,7 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 		hvs->core_clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(hvs->core_clk)) {
 			dev_err(&pdev->dev, "Couldn't get core clock\n");
+			rpi_firmware_put(firmware);
 			return PTR_ERR(hvs->core_clk);
 		}
 
-- 
2.25.1

