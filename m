Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BB86121E3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ2Jet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 05:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2Jen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 05:34:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDA117049
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 02:34:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so7894208wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 02:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0s7cusbjRhvfSFjBw6Lx4DFnE28qr99VM/89xctrXcY=;
        b=R8r9MYiVR/n1QCShgiCRjvlsyCmGxIth8d68WOBKuFwGFdpvU0hLifsKHXaA0i7R7T
         FATSb70x39JDuCr+RFIEMHkzCbXWDBVXLQrDeb9y7eB4/OehDirtQMwmoI+nEp+BrN0G
         u/fUtaHezDnpUbrRdrgmORy9rD4FhXGYMCmjG/LapRowSvd+EZrEGPnCIBo1dsmqrQzE
         esyFj2o/J+WqlmQTU+aoX79Wvn1x2MTGTvXbk00TQxNzSp0U4mMc+L1GZbZv4260jlSX
         DI4iK78azGeF6BR5yBioI4MAexmAQiV7qakqP16N3f0ibROLougrJyoyhWfCUkuqRZ00
         Lydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0s7cusbjRhvfSFjBw6Lx4DFnE28qr99VM/89xctrXcY=;
        b=25vfB19PYz3EZ3QYszyFKnt+t5tvUPJGoYqCdemPIHjw832vt13thOqcpS8eYvWKk3
         x1X5WVWQ9rc6BtV4EEb9medZKJKewLl+DVFZ+NR4/cRQ9gTdF6DUW9BiVLaXR8/tXBn9
         LjCrWnc+D1A9Nn9uhECQVHYCW1tcWfX8k85V8/noigQqYz6SlFOqXmP+G4P/Zj9yT/QK
         PrtRzl69qsJs/VlUf0558g796YEyQeJ9dg2Z0Tz4k/bZ2CkwnKQVUSSDlQgafoXDyVEY
         UixinLOt/6n/9Eot07YmFBVTXdZOqNDWjcTt90jLaBbb2Nnb6wfAgx1RflkW0B/qGM+A
         izkw==
X-Gm-Message-State: ACrzQf1UmkKnSbYEY6DW8r//rrqOq6yADbiXX/Z2bU2no+4IY1yF5yVz
        pO6L2CPzenbXFZdBKnsajCc=
X-Google-Smtp-Source: AMsMyM6Amig+erFbtqG7wwXSWmzDP5vkjeNyXS8CvHdnIWkIsJz9SDcz1bFmgAx7ObVYinv/0KmjpA==
X-Received: by 2002:a05:600c:310f:b0:3c6:ff0a:c41 with SMTP id g15-20020a05600c310f00b003c6ff0a0c41mr11820655wmo.91.1667036078032;
        Sat, 29 Oct 2022 02:34:38 -0700 (PDT)
Received: from localhost.localdomain ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe3d2000000b00236705daefesm1053785wrm.39.2022.10.29.02.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 02:34:37 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     mripard@kernel.org
Cc:     emma@anholt.net, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/vc4: hdmi: Fix pointer dereference before check
Date:   Sat, 29 Oct 2022 11:34:13 +0200
Message-Id: <20221029093413.546103-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
 drivers/gpu/drm/vc4/vc4_hdmi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 4a73fafca51b..07d058b6afb7 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -319,9 +319,9 @@ static int reset_pipe(struct drm_crtc *crtc,
 static int vc4_hdmi_reset_link(struct drm_connector *connector,
 			       struct drm_modeset_acquire_ctx *ctx)
 {
-	struct drm_device *drm = connector->dev;
-	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
-	struct drm_encoder *encoder = &vc4_hdmi->encoder.base;
+	struct drm_device *drm;
+	struct vc4_hdmi *vc4_hdmi;
+	struct drm_encoder *encoder;
 	struct drm_connector_state *conn_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_crtc *crtc;
@@ -332,6 +332,10 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
 	if (!connector)
 		return 0;
 
+	drm = connector->dev;
+	vc4_hdmi = connector_to_vc4_hdmi(connector);
+	encoder = &vc4_hdmi->encoder.base;
+
 	ret = drm_modeset_lock(&drm->mode_config.connection_mutex, ctx);
 	if (ret)
 		return ret;
-- 
2.25.1

