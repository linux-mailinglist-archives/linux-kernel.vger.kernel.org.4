Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1464871FD52
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjFBJNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjFBJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:12:47 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1800170C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:11:48 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:158c:2ccf:1f70:e136])
        by baptiste.telenet-ops.be with bizsmtp
        id 49Bg2A00J1tRZS8019BgSX; Fri, 02 Jun 2023 11:11:46 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50ob-00BvaJ-2R;
        Fri, 02 Jun 2023 11:11:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50ou-00ASIG-5F;
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
Subject: [PATCH 0/3] drm: Atomic modesetting doc and comment improvements
Date:   Fri,  2 Jun 2023 11:11:33 +0200
Message-Id: <cover.1685696114.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains various improvements to the documentation and
comments related to atomic modesetting.  Hopefully, it will ease the job
of DRM novice who want to tackle the daunting task of converting a
legacy DRM driver to atomic modesetting.

Thanks for your comments!

Geert Uytterhoeven (3):
  drm/todo: Add atomic modesetting references
  drm: Remove references to removed transitional helpers
  drm: Fix references to drm_plane_helper_check_state()

 Documentation/gpu/todo.rst               |  9 ++++-
 drivers/gpu/drm/drm_plane_helper.c       |  8 ----
 drivers/gpu/drm/rcar-du/rcar_du_plane.c  |  3 +-
 drivers/gpu/drm/tidss/tidss_plane.c      |  3 +-
 include/drm/drm_crtc.h                   |  5 ---
 include/drm/drm_modeset_helper_vtables.h | 48 +++++++++++-------------
 6 files changed, 32 insertions(+), 44 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
