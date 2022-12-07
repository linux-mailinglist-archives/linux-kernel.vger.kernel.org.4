Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58665645981
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiLGL4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLGLzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:55:33 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABEDE09A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:55:32 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4FD375C01BF;
        Wed,  7 Dec 2022 06:55:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Dec 2022 06:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1670414132; x=
        1670500532; bh=uijn7bhnwg8D9DX/rVAehHdMMtRMxAq4fSqT3VnEss8=; b=W
        +PwpIJ7O/VNKJohWz6I2y+l6qbeOC3Wvhz7GWaVpkeuX4qFWXO2U2P5WVfOTZx+Y
        SMg3C9ob1dUWfESoeEaEqYFoXza+pbpJ8+FHKw9FZgg2lAxNd95fHGC6hyx5z9Ob
        u6QdNP/1Mbh0AY/wvM4C44jwiDi9a7kjUmdZFtnEervOh03ny87UOOuROKO3Wj9/
        x8Zn/jYfGrR0cbFic7UgQfMqSmWubtaEvTgZw/jGOAf/uNLjz+i9ZkIFZUz2tLQi
        koDzsw6qyFJKWHMChO/9EnBYWUNcwnEuwdPeyStoumXogLHkVx1d0a1U3gluYRhS
        xJSkidM0s2U3St0I6d+fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1670414132; x=
        1670500532; bh=uijn7bhnwg8D9DX/rVAehHdMMtRMxAq4fSqT3VnEss8=; b=D
        dhtPaWj0dm88RJ6whCOBMtU60KAKvg06nup/P8g8HAKtN0Ne9sWoO7RNJfa5QCdl
        3II+HAGKsVwpcBkVJJs58ag46oQ4AWxqMA3FxQxFr1lYNSIcPB7TP7vOqkG+rj1I
        mWSbvDQMsKoCchZlKCY2gTc3WZ3juJa1ihMZB1b7a/k2WKXMDyJ3Ly70wbpHBE9d
        AEqToHSH7WRpSls6oMPS1HwU2uG0KHWJJHUZL/3l1i4AVDY8EDwlFrq1EaKYArHw
        aVGntXmMjQDVk7+AzgqLyS5KYr2bSUfhfja1J3Vna2WVe8U/j02O5N7dQZvreKCM
        6ShOHRol7bBiq+UhN3rJw==
X-ME-Sender: <xms:NH-QYzDxC-VQ_OfC6GHTV0WR2r667pCmZ-eV84DZdG9zZp3HKWcnxA>
    <xme:NH-QY5jt_ICx73fyxP7yTCF6n4LqnbpfcL8GItPSj_1Bh4fYpexbyNdLY-apr_y7y
    VDaQE6lExbh8RYBMRE>
X-ME-Received: <xmr:NH-QY-kRqPg6QfRYS9F1h4CSUXrw7kUVs8nuFhWNSdqUlxZtXscZoEcuY9aQD0qy6EOVUpkcb2R2ASNO4y5eDG6HpdgQNIGL38OUoCkQ3iGRlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeevvdelieejgedvkeffheekheeilefhgefgffehteekueelvddtueffheet
    ledtffenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:NH-QY1xiVrXTyPQWjCH8noC7_y2E8WNbnN0bMKq9aD-nJtphrLiNew>
    <xmx:NH-QY4RNOoOJjiWnwHkefnx_8FTCJV1gJelHWB_PaQmEaUnEBa-JdA>
    <xmx:NH-QY4Y1DrCA5KQIP1pfY7ineFqDxpzlMtWMCnpmkr5lKlN7-mngpw>
    <xmx:NH-QY5LC4Q2gArZXglMH38j2wm2VFjceYYUp-oxRv8a3aKiYu8MckQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Dec 2022 06:55:31 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Wed, 07 Dec 2022 12:53:22 +0100
Subject: [PATCH 11/15] drm/vc4: plane: Add 3:3:2 and 4:4:4:4 RGB/RGBX/RGBA formats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221207-rpi-hvs-crtc-misc-v1-11-1f8e0770798b@cerno.tech>
References: <20221207-rpi-hvs-crtc-misc-v1-0-1f8e0770798b@cerno.tech>
In-Reply-To: <20221207-rpi-hvs-crtc-misc-v1-0-1f8e0770798b@cerno.tech>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.11.0-dev-8c583
X-Developer-Signature: v=1; a=openpgp-sha256; l=3144; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=DvjBy0zh4zjirjYFb5EqVavFERIHbMTKbPtmYKYxPik=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMkT6lbeMmX59k8pK0F3d9l7qbYAxmuMeyLeCYskXQv/efxz
 7Du3jlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEykZTojw9LTG8MmzX3K0LVV6Zp15+
 qZc3enL/0fkL9b6W9tYGp6Di/DP8UpByxL2q4GlRXc9N/dvrbnXXrAocMth1fsM90r9mC9GRMA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The hardware supports the 332 8bpp and 4:4:4:4 16bpp formats,
but the table of supported formats didn't include them.
Add them in.

In theory they are supported for T-format as well as linear,
but without a way to test them just add them as linear for now.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 70 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 7b7bbe94d47a..dee525bacd4b 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -175,6 +175,66 @@ static const struct hvs_format {
 		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ABGR,
 		.hvs5_only = true,
 	},
+	{
+		.drm = DRM_FORMAT_RGB332,
+		.hvs = HVS_PIXEL_FORMAT_RGB332,
+		.pixel_order = HVS_PIXEL_ORDER_ARGB,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ARGB,
+	},
+	{
+		.drm = DRM_FORMAT_BGR233,
+		.hvs = HVS_PIXEL_FORMAT_RGB332,
+		.pixel_order = HVS_PIXEL_ORDER_ABGR,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ABGR,
+	},
+	{
+		.drm = DRM_FORMAT_XRGB4444,
+		.hvs = HVS_PIXEL_FORMAT_RGBA4444,
+		.pixel_order = HVS_PIXEL_ORDER_ABGR,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ARGB,
+	},
+	{
+		.drm = DRM_FORMAT_ARGB4444,
+		.hvs = HVS_PIXEL_FORMAT_RGBA4444,
+		.pixel_order = HVS_PIXEL_ORDER_ABGR,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ARGB,
+	},
+	{
+		.drm = DRM_FORMAT_XBGR4444,
+		.hvs = HVS_PIXEL_FORMAT_RGBA4444,
+		.pixel_order = HVS_PIXEL_ORDER_ARGB,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ABGR,
+	},
+	{
+		.drm = DRM_FORMAT_ABGR4444,
+		.hvs = HVS_PIXEL_FORMAT_RGBA4444,
+		.pixel_order = HVS_PIXEL_ORDER_ARGB,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ABGR,
+	},
+	{
+		.drm = DRM_FORMAT_BGRX4444,
+		.hvs = HVS_PIXEL_FORMAT_RGBA4444,
+		.pixel_order = HVS_PIXEL_ORDER_RGBA,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_BGRA,
+	},
+	{
+		.drm = DRM_FORMAT_BGRA4444,
+		.hvs = HVS_PIXEL_FORMAT_RGBA4444,
+		.pixel_order = HVS_PIXEL_ORDER_RGBA,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_BGRA,
+	},
+	{
+		.drm = DRM_FORMAT_RGBX4444,
+		.hvs = HVS_PIXEL_FORMAT_RGBA4444,
+		.pixel_order = HVS_PIXEL_ORDER_BGRA,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_RGBA,
+	},
+	{
+		.drm = DRM_FORMAT_RGBA4444,
+		.hvs = HVS_PIXEL_FORMAT_RGBA4444,
+		.pixel_order = HVS_PIXEL_ORDER_BGRA,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_RGBA,
+	},
 };
 
 static const struct hvs_format *vc4_get_hvs_format(u32 drm_format)
@@ -1521,6 +1581,16 @@ static bool vc4_format_mod_supported(struct drm_plane *plane,
 	case DRM_FORMAT_BGRX1010102:
 	case DRM_FORMAT_RGBA1010102:
 	case DRM_FORMAT_BGRA1010102:
+	case DRM_FORMAT_XRGB4444:
+	case DRM_FORMAT_ARGB4444:
+	case DRM_FORMAT_XBGR4444:
+	case DRM_FORMAT_ABGR4444:
+	case DRM_FORMAT_RGBX4444:
+	case DRM_FORMAT_RGBA4444:
+	case DRM_FORMAT_BGRX4444:
+	case DRM_FORMAT_BGRA4444:
+	case DRM_FORMAT_RGB332:
+	case DRM_FORMAT_BGR233:
 	case DRM_FORMAT_YUV422:
 	case DRM_FORMAT_YVU422:
 	case DRM_FORMAT_YUV420:

-- 
2.38.1
