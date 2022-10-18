Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72582602029
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiJRBH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJRBHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:07:55 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581663057B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:07:54 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h203so10617782iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axgOJD7gUJLWncY0SkfScMfFy0OM1pSvja+Frnrc+5E=;
        b=GFftaHMMmUxj3xkXKrCfhWdqb+oQdlnJjW7CU7cV94sLQccmKbI5FARHyT8b8JoJaI
         DmAoQ29tJ2IHFOWuFcimgsZqKpZVwb3QEdxq4AjUl9Iv2L2nLRjHWVtW+7+Pau35Q+oE
         xqa1nryIolqgjeuNCdo6RPEottpP7qcxul8x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axgOJD7gUJLWncY0SkfScMfFy0OM1pSvja+Frnrc+5E=;
        b=nwg2oKqdbdsOgql1IQK/XrOy/NN6c+FAY/WZXyPZTrewBEiN7Mlcat/xL/k+/dVfRP
         gQrPRqRv3rv09I6HSamIkTokTYDCTURCWQgbINQutszoZwDV3XfCYooFjbKRU9PlX5pO
         /jOyaHKfh0xlieRrvPLe9GwsHZXc6XxcaZElK35DVkV5UL4D02z+Nk4A8p1f+CqCI/0y
         /cSvhQrABfqlb1sSa2mxs8ogg57xqh76tzszhaSYIgLPnHZpH36Hnz2Ir1fFXqMcaRzF
         Kp6cSZubPdPTOaTNemwcOFXOCCz1KyA0ccH3QmSawXmE04uEMFRSrQkhp5hkTfsRtgHP
         nupw==
X-Gm-Message-State: ACrzQf0x8N+js/qmqSIruk+tV0ZQGQcaMLSJ8855nQztKOfz/0QuZjPX
        eKsqEz2cOBVwByHS2WA9LSy8cQ==
X-Google-Smtp-Source: AMsMyM5natxuKTgl0+9M8ndE3V5po0rKmMoUOGViP+Xpu7uSNVXwg3Cc6CMRhhmt6/yVDa5GZ8Q6xg==
X-Received: by 2002:a05:6638:14cb:b0:363:ed95:ce4c with SMTP id l11-20020a05663814cb00b00363ed95ce4cmr559798jak.308.1666055273505;
        Mon, 17 Oct 2022 18:07:53 -0700 (PDT)
Received: from localhost.localdomain ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e6-20020a022106000000b0036377aa5a35sm529499jaa.100.2022.10.17.18.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 18:07:53 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, sashal@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, alexander.deucher@amd.com,
        hamza.mahfooz@amd.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] Revert "drm/amdgpu: use dirty framebuffer helper"
Date:   Mon, 17 Oct 2022 19:07:46 -0600
Message-Id: <20221018010746.603662-2-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018010746.603662-1-skhan@linuxfoundation.org>
References: <20221018010746.603662-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 867b2b2b6802fb3995a0065fc39e0e7e20d8004d.

With this commit, dmesg fills up with the following messages and drm
initialization takes a very long time. This commit has bee reverted
from 5.4

[drm] Fence fallback timer expired on ring sdma0
[drm] Fence fallback timer expired on ring gfx
[drm] Fence fallback timer expired on ring sdma0
[drm] Fence fallback timer expired on ring gfx
[drm] Fence fallback timer expired on ring sdma0
[drm] Fence fallback timer expired on ring sdma0
[drm] Fence fallback timer expired on ring sdma0
[drm] Fence fallback timer expired on ring gfx

Cc: <stable@vger.kernel.org>    # 5.10
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 947f50e402ba..7cc7af2a6822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -35,7 +35,6 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <drm/drm_crtc_helper.h>
-#include <drm/drm_damage_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
@@ -499,7 +498,6 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
 static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
 	.destroy = drm_gem_fb_destroy,
 	.create_handle = drm_gem_fb_create_handle,
-	.dirty = drm_atomic_helper_dirtyfb,
 };
 
 uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
-- 
2.34.1

