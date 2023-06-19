Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA28735C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjFSQ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjFSQ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:56:13 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8F9E6E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:55:58 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-763aba07271so2404385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1687193757; x=1689785757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnZNU/I8hVx/txQg+gZcbNdILNkL1d9QJiWI/0DW9wI=;
        b=FZytthrbCYDv3RZOtaTdlEZCVgoapIc+1yj309YHwRqE+CagPIrZRG0F4niNuuyc3M
         wLe5zF+7iiwSyXRnaT6Y7CPeQqeymyE9pCTfaXwRIDGwIf5wx1u+z2L4eWJQ3cpboG1I
         Ho3OM31KAsV2ZJtI2AE5AiRcYIozPpNICyWts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687193757; x=1689785757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnZNU/I8hVx/txQg+gZcbNdILNkL1d9QJiWI/0DW9wI=;
        b=c70y0DCxCmFxNaEAk8Q/FjCfiN08hVAyI+MAzdI0i8V87rnzqYAl5w7+fBOrrcjkr7
         p4or43blR+tfnVGqrBiuvz/xvvxktCEl6OanELXyvK+JkbUJyJUjjcH/4GplSV7fEXHv
         ZV4lR4ESwuGWFPeE8bpNjXQgJQU4Edhng8S9acO6IIK4xFAq7PxwDQfjy7Bvpmutgq7B
         fi0r/dD+8C5zO1EkTyOVAwHbMTILPHgVNjybuRW81POTXyfV4TOuEESzXsq80oPvexVM
         p0DDrOU0hcVRUpW52VUqGeKsTlMydQ4STgtbn4n7bGJqnaBC3Cru356PQI6mEajcwWm3
         1mNw==
X-Gm-Message-State: AC+VfDzcxNVL1mNJpH1Ut6oJfCV7G1Ix6aYr+aoJRI7o3dyke2JLA3ly
        dbVkHtbGr2QOu0lbWaaO94Cbucot2tfZOTmeaDw=
X-Google-Smtp-Source: ACHHUZ4seV5vQMD1B3+dqGuDxNBwJBs85xEpHLWIbXaIhwEvDfAjEJU/sT7OAfJwkc2qH0vO0JafgQ==
X-Received: by 2002:a05:620a:4397:b0:762:39c:7fb3 with SMTP id a23-20020a05620a439700b00762039c7fb3mr11634709qkp.60.1687193757326;
        Mon, 19 Jun 2023 09:55:57 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-79-25-27-4.retail.telecomitalia.it. [79.25.27.4])
        by smtp.gmail.com with ESMTPSA id p23-20020a05620a15f700b0075d49ce31c3sm109103qkm.91.2023.06.19.09.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:55:57 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v4 6/6] drm/stm: set framebuffer bit depth through DTS property
Date:   Mon, 19 Jun 2023 18:55:25 +0200
Message-Id: <20230619165525.1035243-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230619165525.1035243-1-dario.binacchi@amarulasolutions.com>
References: <20230619165525.1035243-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch, which is backwards compatible, sets the bit depth of the
framebuffer using the optional property 'st,fb-bpp' in the DTS.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v4:
- Use DTS property instead of module parameter to set the framebuffer bit depth.

Changes in v3:
- drop [4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
  Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next):
  https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c42a37a27c777d63961dd634a30f7c887949491a
- drop [5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
  Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
  https://cgit.freedesktop.org/drm/drm-misc/commit/?id=13cdd12a9f934158f4ec817cf048fcb4384aa9dc

 drivers/gpu/drm/stm/drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 422220df7d8c..7a61a3c63469 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -180,7 +180,9 @@ static const struct dev_pm_ops drv_pm_ops = {
 static int stm_drm_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
 	struct drm_device *ddev;
+	u32 fb_bpp = 16;
 	int ret;
 
 	DRM_DEBUG("%s\n", __func__);
@@ -203,7 +205,9 @@ static int stm_drm_platform_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_put;
 
-	drm_fbdev_dma_setup(ddev, 16);
+	of_property_read_u32(np, "st,fb-bpp", &fb_bpp);
+
+	drm_fbdev_dma_setup(ddev, fb_bpp);
 
 	return 0;
 
-- 
2.32.0

