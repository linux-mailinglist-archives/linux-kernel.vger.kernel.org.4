Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEDC71FD4B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjFBJNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjFBJMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:12:44 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CAE1703
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:11:47 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:158c:2ccf:1f70:e136])
        by andre.telenet-ops.be with bizsmtp
        id 49Bg2A0061tRZS8019BgaW; Fri, 02 Jun 2023 11:11:46 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50ob-00BvaL-2W;
        Fri, 02 Jun 2023 11:11:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50ou-00ASIJ-6O;
        Fri, 02 Jun 2023 11:11:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] drm/todo: Add atomic modesetting references
Date:   Fri,  2 Jun 2023 11:11:34 +0200
Message-Id: <7cea42cd09540657875a210cd16421125497d690.1685696114.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1685696114.git.geert+renesas@glider.be>
References: <cover.1685696114.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section about converting existing KMS drivers to atomic modesetting
mentions the existence of a conversion guide, but does not reference it.
While the guide is old and rusty, it still contains useful information,
so add a link to it.  Also link to the LWN.net articles that give an
overview about the atomic mode setting design.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/gpu/todo.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 68bdafa0284f55f6..51eb67f5268c5ec1 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -49,14 +49,19 @@ converted over. Modern compositors like Wayland or Surfaceflinger on Android
 really want an atomic modeset interface, so this is all about the bright
 future.
 
-There is a conversion guide for atomic and all you need is a GPU for a
+There is a conversion guide for atomic[1] and all you need is a GPU for a
 non-converted driver (again virtual HW drivers for KVM are still all
-suitable).
+suitable).  The "Atomic mode setting design overview" series [2][3] at
+LWN.net can also be helpful.
 
 As part of this drivers also need to convert to universal plane (which means
 exposing primary & cursor as proper plane objects). But that's much easier to
 do by directly using the new atomic helper driver callbacks.
 
+  - [1] https://blog.ffwll.ch/2014/11/atomic-modeset-support-for-kms-drivers.html
+  - [2] https://lwn.net/Articles/653071/
+  - [3] https://lwn.net/Articles/653466/
+
 Contact: Daniel Vetter, respective driver maintainers
 
 Level: Advanced
-- 
2.34.1

