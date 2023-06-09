Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F97729BDB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbjFINot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjFINoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:44:44 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C6230FA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:44:41 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:a1e2:1b31:cba3:390d])
        by baptiste.telenet-ops.be with bizsmtp
        id 71kZ2A00512zQ4r011kZdr; Fri, 09 Jun 2023 15:44:39 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q7cPS-008La7-38;
        Fri, 09 Jun 2023 15:44:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q7cPp-00GCTT-43;
        Fri, 09 Jun 2023 15:44:33 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/4] drm/todo: Convert list of fbconv links to footnotes
Date:   Fri,  9 Jun 2023 15:44:28 +0200
Message-Id: <be8d2886f50485c86f74a3c1a117abb1b8718a07.1686318012.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1686318012.git.geert+renesas@glider.be>
References: <cover.1686318012.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the references to fbconv links to footnotes, so they can be
navigated.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 Documentation/gpu/todo.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 6c328613c049fc1d..ce1d4e22c327063b 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -753,16 +753,16 @@ existing hardware. The new driver's call-back functions are filled from
 existing fbdev code.
 
 More complex fbdev drivers can be refactored step-by-step into a DRM
-driver with the help of the DRM fbconv helpers. [1] These helpers provide
+driver with the help of the DRM fbconv helpers [4]_. These helpers provide
 the transition layer between the DRM core infrastructure and the fbdev
 driver interface. Create a new DRM driver on top of the fbconv helpers,
 copy over the fbdev driver, and hook it up to the DRM code. Examples for
-several fbdev drivers are available at [1] and a tutorial of this process
-available at [2]. The result is a primitive DRM driver that can run X11
+several fbdev drivers are available at [4]_ and a tutorial of this process
+available at [5]_. The result is a primitive DRM driver that can run X11
 and Weston.
 
- - [1] https://gitlab.freedesktop.org/tzimmermann/linux/tree/fbconv
- - [2] https://gitlab.freedesktop.org/tzimmermann/linux/blob/fbconv/drivers/gpu/drm/drm_fbconv_helper.c
+ .. [4] https://gitlab.freedesktop.org/tzimmermann/linux/tree/fbconv
+ .. [5] https://gitlab.freedesktop.org/tzimmermann/linux/blob/fbconv/drivers/gpu/drm/drm_fbconv_helper.c
 
 Contact: Thomas Zimmermann <tzimmermann@suse.de>
 
-- 
2.34.1

