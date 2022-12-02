Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230BE640641
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiLBL7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiLBL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:58:56 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C41A4338
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:58:51 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669982330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qU6V1zC0ubiasGJw0DuyU+aIJG0zbseMSw+1CvsGzIg=;
        b=FXe4zJBnhoNRbs3MH3iG+lFAIKKUMxN9nUgVRZeU76Hc1ARyiOAp1+O2dNotBNvzeYEuyB
        e90UjUxl4SUCyhlIq3wB9O329rSPTe1KsXiOg1M3r3A1eCGo7uJhaHx5E+SHh8/uSjv2HV
        L/GX5gK7MW85qzmSu+zd4IZGddb8cAo=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Borislav Petkov <bp@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Danilo Krummrich <dakr@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [RESEND PATCH linux-next 1/2] MAINTAINERS: Remove some obsolete drm drivers(tdfx, mga, i810, savage, r128, sis)
Date:   Fri,  2 Dec 2022 19:57:31 +0800
Message-Id: <20221202115837.19475-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        TO_EQ_FM_DIRECT_MX autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 399516ab0fee ("MAINTAINERS: Add a bunch of legacy (UMS) DRM drivers")
marked these drivers obsolete 7 years ago.
And the mesa UMD of these drm drivers already in deprecated list
in the link: https://docs.mesa3d.org/systems.html

3dfx Glide-->driver/gpu/drm/tdfx
Matrox-->driver/gpu/drm/mga
Intel i810-->driver/gpu/drm/i810
S3 Savage-->drivers/gpu/drm/savage/
ATI Rage 128->drivers/gpu/drm/r128/
Silicon Integrated Systems->drivers/gpu/drm/sis/

It's time to remove these.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 MAINTAINERS | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3583c5f6889d..44c4f2d46cfa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6569,11 +6569,6 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/ilitek,ili9486.yaml
 F:	drivers/gpu/drm/tiny/ili9486.c
 
-DRM DRIVER FOR INTEL I810 VIDEO CARDS
-S:	Orphan / Obsolete
-F:	drivers/gpu/drm/i810/
-F:	include/uapi/drm/i810_drm.h
-
 DRM DRIVER FOR JADARD JD9365DA-H3 MIPI-DSI LCD PANELS
 M:	Jagan Teki <jagan@edgeble.ai>
 S:	Maintained
@@ -6602,11 +6597,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
 F:	drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
 
-DRM DRIVER FOR MATROX G200/G400 GRAPHICS CARDS
-S:	Orphan / Obsolete
-F:	drivers/gpu/drm/mga/
-F:	include/uapi/drm/mga_drm.h
-
 DRM DRIVER FOR MGA G200 GRAPHICS CHIPS
 M:	Dave Airlie <airlied@redhat.com>
 R:	Thomas Zimmermann <tzimmermann@suse.de>
@@ -6725,11 +6715,6 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/qxl/
 F:	include/uapi/drm/qxl_drm.h
 
-DRM DRIVER FOR RAGE 128 VIDEO CARDS
-S:	Orphan / Obsolete
-F:	drivers/gpu/drm/r128/
-F:	include/uapi/drm/r128_drm.h
-
 DRM DRIVER FOR RAYDIUM RM67191 PANELS
 M:	Robert Chiras <robert.chiras@nxp.com>
 S:	Maintained
@@ -6757,11 +6742,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
 F:	drivers/gpu/drm/panel/panel-sitronix-st7703.c
 
-DRM DRIVER FOR SAVAGE VIDEO CARDS
-S:	Orphan / Obsolete
-F:	drivers/gpu/drm/savage/
-F:	include/uapi/drm/savage_drm.h
-
 DRM DRIVER FOR FIRMWARE FRAMEBUFFERS
 M:	Thomas Zimmermann <tzimmermann@suse.de>
 M:	Javier Martinez Canillas <javierm@redhat.com>
@@ -6777,11 +6757,6 @@ F:	include/drm/drm_aperture.h
 F:	include/linux/aperture.h
 F:	include/video/nomodeset.h
 
-DRM DRIVER FOR SIS VIDEO CARDS
-S:	Orphan / Obsolete
-F:	drivers/gpu/drm/sis/
-F:	include/uapi/drm/sis_drm.h
-
 DRM DRIVER FOR SITRONIX ST7586 PANELS
 M:	David Lechner <david@lechnology.com>
 S:	Maintained
@@ -6809,10 +6784,6 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/ste,mcde.yaml
 F:	drivers/gpu/drm/mcde/
 
-DRM DRIVER FOR TDFX VIDEO CARDS
-S:	Orphan / Obsolete
-F:	drivers/gpu/drm/tdfx/
-
 DRM DRIVER FOR TI DLPC3433 MIPI DSI TO DMD BRIDGE
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.25.1

