Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC86B5F8565
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 15:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJHNNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 09:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJHNNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 09:13:25 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E5B52084;
        Sat,  8 Oct 2022 06:13:21 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4Ml5G90XjVz9scH;
        Sat,  8 Oct 2022 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1665234801; bh=gnBsNEwM/S9PWvUObRoQlFNCY33roZKRpy1dn0jtxok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=emSc0gqCUKQW42V6JYa3M/wKOYykH90vytIU0O3jf0NuqriCVPiUJB7P2fvoxPhU+
         1kZuoO2aQcREFCEy5uroiBkeTdD0OmBYp0Dd/lcXuxX3n3ms5eFBGDnoq3eALFe4bW
         j1faTVK7JfMFkLb75ZtNm0NTIKc5QXoxuLa7snd4=
X-Riseup-User-ID: 3783ACED89D999CB73A1EC90BE730AA5623AFE1B022D29E56059CF3EC65D5E90
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Ml5G623Bvz5vNH;
        Sat,  8 Oct 2022 13:13:18 +0000 (UTC)
From:   Nia Espera <a5b6@riseup.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Nia Espera <a5b6@riseup.net>,
        Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH v3 2/2] drivers: gpu: drm: remove support for sofef00 driver on s6e3fc2x01 panel
Date:   Sat,  8 Oct 2022 15:12:03 +0200
Message-Id: <20221008131201.540185-3-a5b6@riseup.net>
In-Reply-To: <20221008131201.540185-1-a5b6@riseup.net>
References: <20221008131201.540185-1-a5b6@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes functionality from sofef00 panel driver which allowed it to
drive the s6e3fc2x01 panel

Signed-off-by: Nia Espera <a5b6@riseup.net>
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
---
 drivers/gpu/drm/panel/Kconfig                 |  6 +++---
 drivers/gpu/drm/panel/panel-samsung-sofef00.c | 18 ------------------
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 0dd5e1ec5644..1addbd7e4790 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -547,16 +547,16 @@ config DRM_PANEL_SAMSUNG_S6E8AA0
 	select VIDEOMODE_HELPERS
 
 config DRM_PANEL_SAMSUNG_SOFEF00
-	tristate "Samsung sofef00/s6e3fc2x01 OnePlus 6/6T DSI cmd mode panels"
+	tristate "Samsung sofef00 OnePlus 6 DSI cmd mode panel"
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
 	select VIDEOMODE_HELPERS
 	help
 	  Say Y or M here if you want to enable support for the Samsung AMOLED
-	  command mode panels found in the OnePlus 6/6T smartphones.
+	  command mode panel found in the OnePlus 6 smartphone.
 
-	  The panels are 2280x1080@60Hz and 2340x1080@60Hz respectively
+	  The panel is 2280x1080@60Hz
 
 config DRM_PANEL_SAMSUNG_S6E3FC2X01
 	tristate "Samsung s6e3fc2x01 OnePlus 6T DSI cmd mode panel"
diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
index bd02af81a4fe..68e58b9b8c5c 100644
--- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
+++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
@@ -181,20 +181,6 @@ static const struct drm_display_mode enchilada_panel_mode = {
 	.height_mm = 145,
 };
 
-static const struct drm_display_mode fajita_panel_mode = {
-	.clock = (1080 + 72 + 16 + 36) * (2340 + 32 + 4 + 18) * 60 / 1000,
-	.hdisplay = 1080,
-	.hsync_start = 1080 + 72,
-	.hsync_end = 1080 + 72 + 16,
-	.htotal = 1080 + 72 + 16 + 36,
-	.vdisplay = 2340,
-	.vsync_start = 2340 + 32,
-	.vsync_end = 2340 + 32 + 4,
-	.vtotal = 2340 + 32 + 4 + 18,
-	.width_mm = 68,
-	.height_mm = 145,
-};
-
 static int sofef00_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector)
 {
 	struct drm_display_mode *mode;
@@ -327,10 +313,6 @@ static const struct of_device_id sofef00_panel_of_match[] = {
 		.compatible = "samsung,sofef00",
 		.data = &enchilada_panel_mode,
 	},
-	{ // OnePlus 6T / fajita
-		.compatible = "samsung,s6e3fc2x01",
-		.data = &fajita_panel_mode,
-	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sofef00_panel_of_match);
-- 
2.38.0

