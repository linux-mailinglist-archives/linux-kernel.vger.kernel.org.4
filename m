Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EF95BA819
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiIPIWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIPIW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:22:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7A32EF15;
        Fri, 16 Sep 2022 01:22:28 -0700 (PDT)
Received: from deskari.lan (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7C2CF496;
        Fri, 16 Sep 2022 10:22:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663316545;
        bh=fYeV+cbQCWldkWdo8LIksuwCzN5jDYIPYNI5pXw6Mfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+uMZfkUmvhSd6JH+A3vecq29zy2fBGwswKwgLzJeEpivI2j8dGnYUMJ0JnblVDYD
         BaMKXBPGT5/sUIpnTyzmlcr7fjM2oghLBu9vFlZ2ux194EUFLRYK5mSfQT3In2PfmZ
         BIARSw7+XIAWmp6SS27oIrcE64TEP+Zyz6qrB8zY=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 2/2] drm/omap: Fix kernel docs
Date:   Fri, 16 Sep 2022 11:22:06 +0300
Message-Id: <20220916082206.167427-2-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220916082206.167427-1-tomi.valkeinen@ideasonboard.com>
References: <20220916082206.167427-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix doc related warnings seen with W=1: the function names have changed
but the docs have not been changed accordingly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/omapdrm/omap_gem.c | 2 +-
 drivers/gpu/drm/omapdrm/omap_irq.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index cf571796fd26..d6b4934fa0fd 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -605,7 +605,7 @@ int omap_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 }
 
 /**
- * omap_gem_dumb_map	-	buffer mapping for dumb interface
+ * omap_gem_dumb_map_offset - create an offset for a dumb buffer
  * @file: our drm client file
  * @dev: drm device
  * @handle: GEM handle to the object (from dumb_create)
diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/omap_irq.c
index 4aca14dab927..a6f0bbc879d2 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.c
+++ b/drivers/gpu/drm/omapdrm/omap_irq.c
@@ -99,7 +99,7 @@ int omap_irq_enable_framedone(struct drm_crtc *crtc, bool enable)
 }
 
 /**
- * enable_vblank - enable vblank interrupt events
+ * omap_irq_enable_vblank - enable vblank interrupt events
  * @crtc: DRM CRTC
  *
  * Enable vblank interrupts for @crtc.  If the device doesn't have
@@ -129,7 +129,7 @@ int omap_irq_enable_vblank(struct drm_crtc *crtc)
 }
 
 /**
- * disable_vblank - disable vblank interrupt events
+ * omap_irq_disable_vblank - disable vblank interrupt events
  * @crtc: DRM CRTC
  *
  * Disable vblank interrupts for @crtc.  If the device doesn't have
-- 
2.34.1

