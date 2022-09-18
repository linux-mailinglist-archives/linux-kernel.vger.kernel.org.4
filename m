Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECFB5BBB60
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIRDpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIRDoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:44:39 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC09DE5;
        Sat, 17 Sep 2022 20:44:35 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 65E3E320099D;
        Sat, 17 Sep 2022 23:44:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 17 Sep 2022 23:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxfierke.com;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663472673; x=
        1663559073; bh=8wNDwyLQbgh81ChXcvRCrOfZSMYHUfqbm6VtNor6UYg=; b=H
        iK9aXgKuFmUKaI6ZN4N3f5myS4E4mhlvVzlZVAwcvD6uwh6pkAsJTsbe7++WG0dr
        2GjO5v3i5mX5VuSr2TwjNUBazpGHaCydInc9SbV/O6MgYf8yaJ6gHsYuQcGhO1fs
        fPD4nr64XAgKxNPwEk2jzhCq6j2TPgorYs4qxpgYJlzV/6XCAMFR/lLdd1IJwble
        k6XtUKf7V2HORts+kbErUON9Pd+irzueKLy8BQV3u0LJGqKws6JTllk0BwFXxDD8
        xIeCfceL4e3SPpYMKOUzTK+ECIDdt3uE9a6JsY/5rfaPQWUKE5s6cbAX2BSFcsGt
        LVTAKZIf5JpTRghueBALg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1663472673; x=1663559073; bh=8wNDwyLQbgh81
        ChXcvRCrOfZSMYHUfqbm6VtNor6UYg=; b=Vidop8vR4F9cxeIw/vSe8s/RiGZMD
        nDav1iwzMhhb7Ws27soSKaI0pn/AeqxRNk9WNeIwX9dCOxhxDKuVh/9T5kVwXYaW
        rv6DgsflqI6q8IB+EPvkviC61Cr7wICWeHuP37meiLEHR/eTbAFrO6sED25mUwj6
        wwFHPyvt+7Koz+BHo6IKcBPTgpATFpPhuZz+2UZQwcqfGAOqaIBDD7q9j6KXdBz0
        eTKo1vPGUX5ESHeWOzpcl+RzOr3DTtGog5qXSjIRYZWlIlEEzA36wMrZyuVOKebD
        /1X52pfJzuKggr31hONhv+7Q2fu6E5MSDQbMHAsdpWc20lE/M3dSFGimA==
X-ME-Sender: <xms:IZQmYzDd2LVBXbe-X-Gru7txf4hrflapjX_hKQRqIS6Z0KLrzVSfSw>
    <xme:IZQmY5hpRRSuW2j8VPisdIxtLcFNUd0TSymZFz8Ehu1j7xkFb-AZG3oZYKzlw9PIp
    FLBqnea7IKvCdo_jX4>
X-ME-Received: <xmr:IZQmY-nd7B2v6_rJPOyom5kaQmiKzC8PGFrr5DYdE1r_r6KFDtp1oan618mbdY_KwOPbt30UaNIIGJqFbLvRD3n_TFu-4JOYxoahPY-ydRPiMfQamA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvfedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeforgigucfhihgvrhhkvgcuoehmrgigsehmrgigfhhivghr
    khgvrdgtohhmqeenucggtffrrghtthgvrhhnpeduleevvddtfffhuefgleeiveevvdehgf
    evtdetfeekvedvhfeikeduueetfeegkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehmrgigsehmrgigfhhivghrkhgvrdgtohhm
X-ME-Proxy: <xmx:IZQmY1w-6XLzHEtou-XAgLZep2X8scE6uIVahJ8sjqCREfL1Oco3kg>
    <xmx:IZQmY4T5afwKfS7SSxafuCP2-EsTF0RRfDnJ5PzKWlO_iGOvxRTPZQ>
    <xmx:IZQmY4Zx4q1JJ_O4f3H1loBQ1zvlRWMh84boW5vkUegl2F2G0GMi6A>
    <xmx:IZQmY_JYdK-PB8Tkj_QpFAMca7VPPxmKFGyk66ekjY6uoNyklEIxlQ>
Feedback-ID: idee9475d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Sep 2022 23:44:33 -0400 (EDT)
From:   Max Fierke <max@maxfierke.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Fierke <max@maxfierke.com>
Subject: [PATCH v3 4/4] drm/panel: clockworkpi-cwd686: Implement .get_orientation callback
Date:   Sat, 17 Sep 2022 22:44:15 -0500
Message-Id: <20220918034415.74641-5-max@maxfierke.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220918034415.74641-1-max@maxfierke.com>
References: <20220918034415.74641-1-max@maxfierke.com>
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

Returns the panel's configured orientation

Signed-off-by: Max Fierke <max@maxfierke.com>
---
Changes in v3:
 - no changes

Changes in v2:
 - this was added as .get_orientation is now available in drm-misc-next since v1

 drivers/gpu/drm/panel/panel-clockworkpi-cwd686.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-clockworkpi-cwd686.c b/drivers/gpu/drm/panel/panel-clockworkpi-cwd686.c
index 87d20d784596..2c433a458c8b 100644
--- a/drivers/gpu/drm/panel/panel-clockworkpi-cwd686.c
+++ b/drivers/gpu/drm/panel/panel-clockworkpi-cwd686.c
@@ -340,7 +340,10 @@ static int cwd686_get_modes(struct drm_panel *panel, struct drm_connector *conne
 	drm_mode_set_name(mode);
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 
-	/* Set up connector's "panel orientation" property */
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
 	drm_connector_set_panel_orientation(connector, ctx->orientation);
 
 	drm_mode_probed_add(connector, mode);
@@ -348,10 +351,18 @@ static int cwd686_get_modes(struct drm_panel *panel, struct drm_connector *conne
 	return 1; /* Number of modes */
 }
 
+static enum drm_panel_orientation cwd686_get_orientation(struct drm_panel *panel)
+{
+	struct cwd686 *ctx = panel_to_cwd686(panel);
+
+	return ctx->orientation;
+}
+
 static const struct drm_panel_funcs cwd686_drm_funcs = {
 	.unprepare = cwd686_unprepare,
 	.prepare = cwd686_prepare,
 	.get_modes = cwd686_get_modes,
+	.get_orientation = cwd686_get_orientation,
 };
 
 static int cwd686_probe(struct mipi_dsi_device *dsi)
-- 
2.37.2
