Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C46624389
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiKJNsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiKJNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:48:03 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8D76B3B3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:48:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l14so2348105wrw.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFQJswkFzF6rVK/ySLw3u7BUeEqvWgS7HaoyjTUbHaU=;
        b=FbYEQ4sMHFTKTwrRg+TG7p4q/Sr4qC7TP+ZtXyuyZAo3X/0cPO8yi/3DZcDjiSJbmY
         W6IVpxLaN2Nh/907f6VE9WpUWDsacrmTcvjmaQbc1K3qvhJcBwH99WHeauqEFD6dTq9h
         A2hdmu9SQVRciA7r1JEnwzQwioxi3IkeYWz0h1oojcrY+tRWuHICQPJAxdettUko9BwS
         BdpYTJBNDjqTGO9eXrOAL2nwNNXzGmdqLsSCauwh9jgdgHxB5bPThosvesBkr9u06xUH
         FF2wdmAP8xn4m5Os2UWdRjTrewr45n02PBcTLjVrbW7F8Un9M4+4ThHm62SiSfwTgesf
         d48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFQJswkFzF6rVK/ySLw3u7BUeEqvWgS7HaoyjTUbHaU=;
        b=RymnMRauhq94YLaum1HqbbBu9CoCNAUgzYMeb1BHDzwYuI0ETxFKGcHxGm3eZwzImD
         gk9NXtHZdkJCLt1b6V0xhNXp4t2Ny3+3JfdzQ+xqhR/IXoJmxP6YNaO0ArnXUrGk3YbB
         Bf1g5A5MEbhnLtcvOZXTQZaLQNo5MkHLw1GE+jdmSN1Szn7L6MGfQbpLIuibnQB8YXP0
         BX8VUNThxnlOSdRw/IhMJXobCW8ALy3mTvCrNTD/0X+Xw0Kus2+aK2Fkg/inM3BdM8v8
         /Mt2tyoD2qVNdnwBK4B4I242vtiUzESrfLjYVNIraM8/JqKWUsszAsV67GW0cisxzmIX
         5IyQ==
X-Gm-Message-State: ACrzQf3R/xmyYUYqdubmcdH+pBaS3HGDnyMl+ChiN/e1HIPyp8B87yoX
        SOVHo9VTHSM33wVVOxD6RnQ=
X-Google-Smtp-Source: AMsMyM7gP18kf7x+r2v5ySSaGrpwqLnSocitkDpa2Ir6vPYu4sHLNdb9K9bA9IMDJVsOH9kpsnIG3A==
X-Received: by 2002:adf:e603:0:b0:236:80ac:5f4b with SMTP id p3-20020adfe603000000b0023680ac5f4bmr40517495wrm.83.1668088081038;
        Thu, 10 Nov 2022 05:48:01 -0800 (PST)
Received: from localhost.localdomain ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d4302000000b0022ae0965a8asm15717060wrq.24.2022.11.10.05.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 05:48:00 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     mripard@kernel.org
Cc:     emma@anholt.net, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 2/2] drm/vc4: hdmi: Fix pointer dereference before check
Date:   Thu, 10 Nov 2022 14:47:52 +0100
Message-Id: <20221110134752.238820-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221110134752.238820-1-jose.exposito89@gmail.com>
References: <20221110134752.238820-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Commit 6bed2ea3cb38 ("drm/vc4: hdmi: Reset link on hotplug") introduced
the vc4_hdmi_reset_link() function. This function dereferences the
"connector" pointer before checking whether it is NULL or not.

Rework variable assignment to avoid this issue.

Fixes: 6bed2ea3cb38 ("drm/vc4: hdmi: Reset link on hotplug")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index a49f88e5d2b9..6b223a5fcf6f 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -318,8 +318,8 @@ static int reset_pipe(struct drm_crtc *crtc,
 static int vc4_hdmi_reset_link(struct drm_connector *connector,
 			       struct drm_modeset_acquire_ctx *ctx)
 {
-	struct drm_device *drm = connector->dev;
-	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
+	struct drm_device *drm;
+	struct vc4_hdmi *vc4_hdmi;
 	struct drm_connector_state *conn_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_crtc *crtc;
@@ -330,6 +330,7 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
 	if (!connector)
 		return 0;
 
+	drm = connector->dev;
 	ret = drm_modeset_lock(&drm->mode_config.connection_mutex, ctx);
 	if (ret)
 		return ret;
@@ -347,6 +348,7 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
 	if (!crtc_state->active)
 		return 0;
 
+	vc4_hdmi = connector_to_vc4_hdmi(connector);
 	if (!vc4_hdmi_supports_scrambling(vc4_hdmi))
 		return 0;
 
-- 
2.25.1

