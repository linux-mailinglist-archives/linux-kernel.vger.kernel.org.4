Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B1F645982
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiLGL43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiLGLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:55:35 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAED1E3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:55:34 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0AD5D5C01D9;
        Wed,  7 Dec 2022 06:55:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 07 Dec 2022 06:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1670414134; x=
        1670500534; bh=kzn7DswEsZBG72MZ502pUhHCXI7AVBomop8HSk+V4rI=; b=H
        MfiUAMN/8GxI9f8LdvSwzysAOhTR1839hey0OE6HW1fUbyoPfHX7LfWdxlZivYV2
        kIuJh08ybyqq8Y8jy5M/eVWS1S3GDNBnK8d6n96Jdwp5LN5o9wEO19h4b+uXTgLD
        ydSYgGQj5kopcnYErAazClOb9xiNtg/FJoKs2cpsFXX4tDWc7EcA4mvzG42k3n5+
        NcjccztZqeabEVhd8E/5pDeoUlI4LSXFQLfxZqdo359DOm6v+owOyL6hmi++2FFS
        RkLYK3ET7DSgDkAxDyqWJ5mSlnGe8XQJfYXnhpLguGOAVjMwQ/yI/D8pbZWbdOsF
        m8pQJTHRNAY72RytnldCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1670414134; x=
        1670500534; bh=kzn7DswEsZBG72MZ502pUhHCXI7AVBomop8HSk+V4rI=; b=e
        qjCLt0UR207Eyy5f3uSTQEcpye1laZFwzP6fM4tOs9/W2AbyUXmyoZxUXpxojkqG
        eM6SnZ1oElKcXYv30sdugvLcPOmcaCwTru6/x5FqQ/M6cQhvyKYmPrSXbaY2hfth
        aNeEia46bVQOFBgrzZOqbH2XQaMYMdOwwQmOGkoITLXd9cIbNFX3jZswLJr8RGI9
        vSG0BhdJUtg+iZvEzkhQnOJfc5RV9PQN8ejO5uiO/wgvJoomCNCaEUdM9V103ojg
        xkjgnohUr4nKuJiqMaH29+wsayOjIoIz7dlLkQWFCcA73Ncrib6yFOsGU0jsEqel
        WfRLx72LzzoET1Ww9VbYw==
X-ME-Sender: <xms:NX-QY9vSdYkDIpb5bS_GHZmM3NAuRAH5G08yjudaHuQeKKbjhBl_dA>
    <xme:NX-QY2eldfYodp8ot9IrZEEwzEgH_42p24l7kOMwj11smJCU4RezGmxDN9zWNPiHg
    rDPh89IUEYanc1PUAQ>
X-ME-Received: <xmr:NX-QYwxPBmczpKnlZLdxOdCVda298S8W7Jx3b2OG6lOIcmPZCzNm4lbiHLP1MnDqoMuILgyi5aSmfBZA8h2K9__6N3QuOymTszcPVPLUGBuk3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeevvdelieejgedvkeffheekheeilefhgefgffehteekueelvddtueffheet
    ledtffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:NX-QY0PcpxSVLhaORPxy3KNGYYtx1-2pRjA4BQF2X8xhV5PYxLoKWg>
    <xmx:NX-QY9--ZP8GUCkAPh1ZtWVEm336B-AAmVu7Eooi1Vbbjw7YQ6bCaA>
    <xmx:NX-QY0U73BkkYPTqgfi4cTCJ5Op6Qg-203SDj3scqbgKmbIVep8RQg>
    <xmx:Nn-QYw3JsAsr_Y1qqUM31K1MNGL3zppa43-mHikHVHDqcKEkTBh-xg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Dec 2022 06:55:33 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Wed, 07 Dec 2022 12:53:23 +0100
Subject: [PATCH 12/15] drm/vc4: Add comments for which HVS_PIXEL_ORDER_xxx
 defines apply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221207-rpi-hvs-crtc-misc-v1-12-1f8e0770798b@cerno.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=1LzaaBh0lTOudTNhILem3dXqKIZSSxQD4rTtQVTyIi0=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMkT6la+6AyRO7UzzEuatSXFvm5Joo/K7/eS0kzP1LsF/4ht
 Ys3tKGVhEONikBVTZIkRNl8Sd2rW6042vnkwc1iZQIYwcHEKwEQm1DH8L5GKnPyGY517XN98blMpl+
 DVHf6mB9rCeHb4LZ7i6eTYwvBXRHzOF4V/S68nXik4cne6tV9vKtPCqfNmxc2aNlWq2/4zIwA=
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

The HVS_PIXEL_ORDER_xxx defines apply to specific HVS_PIXEL_FORMAT_xxx
modes, so add comments to make this obvious.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_regs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index 1256f0877ff6..f3763bd600f6 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -848,16 +848,19 @@ enum hvs_pixel_format {
 /* Note: the LSB is the rightmost character shown.  Only valid for
  * HVS_PIXEL_FORMAT_RGB8888, not RGB888.
  */
+/* For modes 332, 4444, 555, 5551, 6666, 8888, 10:10:10:2 */
 #define HVS_PIXEL_ORDER_RGBA			0
 #define HVS_PIXEL_ORDER_BGRA			1
 #define HVS_PIXEL_ORDER_ARGB			2
 #define HVS_PIXEL_ORDER_ABGR			3
 
+/* For modes 666 and 888 (4 & 5) */
 #define HVS_PIXEL_ORDER_XBRG			0
 #define HVS_PIXEL_ORDER_XRBG			1
 #define HVS_PIXEL_ORDER_XRGB			2
 #define HVS_PIXEL_ORDER_XBGR			3
 
+/* For YCbCr modes (8-12, and 17) */
 #define HVS_PIXEL_ORDER_XYCBCR			0
 #define HVS_PIXEL_ORDER_XYCRCB			1
 #define HVS_PIXEL_ORDER_YXCBCR			2

-- 
2.38.1
