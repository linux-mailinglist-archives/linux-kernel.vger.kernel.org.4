Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA3C729BE4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbjFINoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjFINop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:44:45 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7073586
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:44:42 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:a1e2:1b31:cba3:390d])
        by laurent.telenet-ops.be with bizsmtp
        id 71kZ2A00112zQ4r011kZfS; Fri, 09 Jun 2023 15:44:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q7cPS-008La2-2T;
        Fri, 09 Jun 2023 15:44:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q7cPp-00GCTN-24;
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
Subject: [PATCH v2 0/4] drm: Atomic modesetting doc and comment improvements
Date:   Fri,  9 Jun 2023 15:44:26 +0200
Message-Id: <cover.1686318012.git.geert+renesas@glider.be>
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

Changes compared to 1:
  - Add Reviewed-by,
  - Drop double space after full stop,
  - Use footnotes for references,
  - Remore reference to unconverted virtual HW drivers,
  - New patch [2/4],
  - Drop "first part" in drivers/gpu/drm/drm_plane_helper.c.

Thanks for your comments!

Geert Uytterhoeven (4):
  drm/todo: Add atomic modesetting references
  drm/todo: Convert list of fbconv links to footnotes
  drm: Remove references to removed transitional helpers
  drm: Fix references to drm_plane_helper_check_state()

 Documentation/gpu/todo.rst               | 20 ++++++----
 drivers/gpu/drm/drm_plane_helper.c       | 12 +-----
 drivers/gpu/drm/rcar-du/rcar_du_plane.c  |  3 +-
 drivers/gpu/drm/tidss/tidss_plane.c      |  3 +-
 include/drm/drm_crtc.h                   |  5 ---
 include/drm/drm_modeset_helper_vtables.h | 48 +++++++++++-------------
 6 files changed, 39 insertions(+), 52 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
