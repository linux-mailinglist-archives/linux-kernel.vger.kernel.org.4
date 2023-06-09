Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BCC7292E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbjFIIVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbjFIIUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:20:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E1F3AB3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC9C665482
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437E9C433A1;
        Fri,  9 Jun 2023 08:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298694;
        bh=21Srb7JJ7aWQibsq7Epm+9IaQI5kx7gLrn4UED9xIes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNmumLgwu0wWbxiIepjZc31NUJFFNYLnHpH549g63dBQNdYquAr335g1F2BNzT7ch
         /0Lszr7cTHpfdL8U3otNoBR6raX3/Sa34bb3csrAFFhT3bYagCQ07FMF6V4+Ndh39f
         22XppYp8pvtyFEKttzq3LHfqAj2X/ritOe6kqj1hw1t7HeHd+1KjxeXw6qSIqRGtT2
         vLOjoYRxR8hrB2zK0n2K72EILckcFCXl8O4kIeJBncWdKDfywedV9Egf/Wpk83jVFd
         4hWWbS6qpUOKhB1hsdtgBcHjCykTe4t1F7XUyW7pwvF5BdxVKJ6puCc5nnd/G6UiyS
         RNY6XLwbkHf2g==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [RESEND 12/15] drm/nouveau/dispnv04/crtc: Demote kerneldoc abuses
Date:   Fri,  9 Jun 2023 09:17:15 +0100
Message-ID: <20230609081732.3842341-13-lee@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230609081732.3842341-1-lee@kernel.org>
References: <20230609081732.3842341-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/dispnv04/crtc.c:453: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:629: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index a6f2e681bde98..7794902df17d5 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -449,7 +449,7 @@ nv_crtc_mode_set_vga(struct drm_crtc *crtc, struct drm_display_mode *mode)
 	regp->Attribute[NV_CIO_AR_CSEL_INDEX] = 0x00;
 }
 
-/**
+/*
  * Sets up registers for the given mode/adjusted_mode pair.
  *
  * The clocks, CRTCs and outputs attached to this CRTC must be off.
@@ -625,7 +625,7 @@ nv_crtc_swap_fbs(struct drm_crtc *crtc, struct drm_framebuffer *old_fb)
 	return ret;
 }
 
-/**
+/*
  * Sets up registers for the given mode/adjusted_mode pair.
  *
  * The clocks, CRTCs and outputs attached to this CRTC must be off.
-- 
2.41.0.162.gfafddb0af9-goog

