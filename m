Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6BC5B30B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiIIHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiIIHgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7032A3460;
        Fri,  9 Sep 2022 00:35:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58F7A61F10;
        Fri,  9 Sep 2022 07:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233ECC4FEE2;
        Fri,  9 Sep 2022 07:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708895;
        bh=p0gRNxopbv/9oIGzyzpAiFGWySnAU40dy4twByJWqqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UF86OSy1bdrAVtz2A0D0TfkQsXszkgNG3lm2ofj+awZdWdrJhutftWrsNWL1HFCoA
         B7AG2oHiP8REm09hAfc5y+8QWu8OM1jLQT1vBua2p9fTIpu4JHYP0wQbiqYStaZDNM
         0zMC30RVi8rUVlinq3Ym1AF5hmk2MThFKmCbXD7hQ5YeqV3v5DjmyVXZOgna+nHFaH
         hSt5Cx1slBZyLUzZWkJaHQyOY528jucre/DmlC1805E2+EGxVQZSLfMaVERDyl0if+
         s6oXv4nzgSDhZ/7H0DEU4O5bY4jdY1hLPKlYvnlRx9W89YlljeswIFdvIE77dS8QMO
         uvx2ZCXmUchVg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXH-007FHH-31;
        Fri, 09 Sep 2022 09:34:47 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 26/37] docs: gpu: i915.rst: display: add kernel-doc markups
Date:   Fri,  9 Sep 2022 09:34:33 +0200
Message-Id: <690f8555b119dc783764de7d484ac07a711d2cd5.1662708705.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662708705.git.mchehab@kernel.org>
References: <cover.1662708705.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several documented kAPI at the display side that
aren't currently part of the docs. Add them, as this allows
identifying issues with badly-formatted tags.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 Documentation/gpu/i915.rst | 50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 4e59db1cfb00..2ad7941a79f2 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -100,6 +100,56 @@ Display FIFO Underrun Reporting
 .. kernel-doc:: drivers/gpu/drm/i915/display/intel_fifo_underrun.c
    :internal:
 
+Atomic Modeset Support
+----------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_atomic.c
+
+Display Power Domain
+--------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_display_power.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_display_power_map.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_display_power_well.c
+
+Misc display functions
+----------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_backlight.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_crtc.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_connector.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_display_debugfs.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_dp.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_dp_link_training.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_dpll.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_dpt.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_fb.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_fb_pin.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_gmbus.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_lvds.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_opregion.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_snps_phy.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_tc.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/skl_scaler.c
+
+
 Plane Configuration
 -------------------
 
-- 
2.37.3

