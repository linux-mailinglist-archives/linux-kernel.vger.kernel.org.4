Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A207363EB73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiLAIok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLAIoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:44:08 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAC627B25
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:44:05 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2EC985C019B;
        Thu,  1 Dec 2022 03:44:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Dec 2022 03:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669884245; x=
        1669970645; bh=TX/MScXZxpNxZTAh0bNCmzZ4iPPWT3jFBiNkEbs/bfg=; b=C
        twsgzy/h00ZTJAp7wNWiJ//zQRPuf6rULPU6szi3E6cqQqRU4TjiMFmN7McrWFVD
        1vPMv7qf+2z19X8Ij0sI1Ndyk1h6Q2VFTjzKY+ulmNvXjBxpMfWaJZLV+8uUKm9N
        pnIbfFh70MxNRydMF3TE153AN2UqwQId1NsouUIhXnEsz+4J1x1Fw33eL1mDvOCq
        XNz58hMAOLQFUn+kVW1dwS02v5cnpSpTMsMEDTLiXpj0PTYl3ukPkbh/ttgOKlmf
        V4uoWP4uL420Ku22ZNpyvdxp6wXcs/iamCATp8nrsWxE2WyVWvCzuagGcBhU/Se8
        LVmgdkjooz0dGrhm2dxNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669884245; x=
        1669970645; bh=TX/MScXZxpNxZTAh0bNCmzZ4iPPWT3jFBiNkEbs/bfg=; b=Y
        g4a6U+5PbGwODcNctTU3WFl09JcoukdYPamwFqrbN/paEgGNIOxi93wmj7ax0Uls
        kEsmTJ42M4VpZfMMPHIdgnhQ9xT39epwLprHGSssRGeCyTw+5hg30j/ozJTrtqZc
        QzS5Zk/HjRvtGKsDubP09wlShT1G9ZIPHQii1WmT6MYfpvFS70WRWeQ0epj7AAXY
        20LS/Ls6khelK0559MYqw0he2Bzm4sqqOBRIt8vU7vqgMXHZ/ewAssLsnzj4lluO
        b8oQK12qKVdlt/OnO4Aee1+bo0D9Xlr//5fdBQUi8FCTQy3eY78ZATskit5C0sJ/
        UX0ZM4H5K9lhF6bWjWZxg==
X-ME-Sender: <xms:VGmIY2BfF1d3qY4R6-43EZDEn9MfDeqRceNYJDn2yEyCIRbkGggxYA>
    <xme:VGmIYwj4GYkks9WmUae4npOZP96mFaZaMfGIipALNcqticeazb1SGCnh4Stvaxjxc
    T5ZYgi4ilEha5qRlkQ>
X-ME-Received: <xmr:VGmIY5kjpkMxwMaDBqKjBTaEfXxAeCKg_XJVEM0X0Q3rvOq0WtqlXwxEfIfmgYauJQV0COy4b46QJIn2JJi-sOZpGFI-FXmkj44nYiXA6i-tVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdeggdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:VWmIY0wKqNW_3hV9khex-NOCdhEaKwWFToO3IgbdI43tXyUT2MQ9og>
    <xmx:VWmIY7RuIJRO86e5BqdJRgk9CE6H7MiATZj6QIA-NfFKu7c6wskD9w>
    <xmx:VWmIY_Z2G9wnxIJeNbgq7NqxHK8j6zbbRfUNPQ7V1xiBTzrsdtozNQ>
    <xmx:VWmIY2k8EUNFuxLol_tFN2NWVhNR25F0HubRV6XV6tPu5-aS_1NJnA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Dec 2022 03:44:04 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 01 Dec 2022 09:42:46 +0100
Subject: [PATCH v3 1/7] media: uapi: add MEDIA_BUS_FMT_RGB565_1X24_CPADHI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221013-rpi-dpi-improvements-v3-1-eb76e26a772d@cerno.tech>
References: <20221013-rpi-dpi-improvements-v3-0-eb76e26a772d@cerno.tech>
In-Reply-To: <20221013-rpi-dpi-improvements-v3-0-eb76e26a772d@cerno.tech>
To:     Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
        Eric Anholt <eric@anholt.net>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Joerg Quinten <aBUGSworstnightmare@gmail.com>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2502; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=YXd9LPnxRpkmzoRCAwiTId6gqHz9INfpDDgXEGCA3q0=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMkdmWz+n1qzJmZYH73wtCWPb7MJF9d62XsquRotb1ReHZRd
 pVvZUcrCIMbFICumyBIjbL4k7tSs151sfPNg5rAygQxh4OIUgIm8jmVk2HdT0PRkXtMT76VC79wXuD
 o94J978fJ+fnOpN3aOsW86/RgZ1s14ath32/2tqL3p65bV8p3751y+1cboe2Wz6fQPD/7UMgAA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add the MEDIA_BUS_FMT_RGB565_1X24_CPADHI format used by the Geekworm
MZP280 panel for the Raspberry Pi.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 .../userspace-api/media/v4l/subdev-formats.rst     | 37 ++++++++++++++++++++++
 include/uapi/linux/media-bus-format.h              |  3 +-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/subdev-formats.rst b/Documentation/userspace-api/media/v4l/subdev-formats.rst
index d21d532eee15..aa549c42e798 100644
--- a/Documentation/userspace-api/media/v4l/subdev-formats.rst
+++ b/Documentation/userspace-api/media/v4l/subdev-formats.rst
@@ -1023,6 +1023,43 @@ The following tables list existing packed RGB formats.
       - b\ :sub:`2`
       - b\ :sub:`1`
       - b\ :sub:`0`
+    * .. _MEDIA-BUS-FMT-RGB565-1X24_CPADHI:
+
+      - MEDIA_BUS_FMT_RGB565_1X24_CPADHI
+      - 0x1022
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      - 0
+      - 0
+      - 0
+      - r\ :sub:`4`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
+      - 0
+      - 0
+      - g\ :sub:`5`
+      - g\ :sub:`4`
+      - g\ :sub:`3`
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      - 0
+      - 0
+      - 0
+      - b\ :sub:`4`
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
     * .. _MEDIA-BUS-FMT-BGR888-1X24:
 
       - MEDIA_BUS_FMT_BGR888_1X24
diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
index ec3323dbb927..8e159e6b4d21 100644
--- a/include/uapi/linux/media-bus-format.h
+++ b/include/uapi/linux/media-bus-format.h
@@ -34,7 +34,7 @@
 
 #define MEDIA_BUS_FMT_FIXED			0x0001
 
-/* RGB - next is	0x1022 */
+/* RGB - next is	0x1023 */
 #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
@@ -48,6 +48,7 @@
 #define MEDIA_BUS_FMT_RGB666_1X18		0x1009
 #define MEDIA_BUS_FMT_RBG888_1X24		0x100e
 #define MEDIA_BUS_FMT_RGB666_1X24_CPADHI	0x1015
+#define MEDIA_BUS_FMT_RGB565_1X24_CPADHI	0x1022
 #define MEDIA_BUS_FMT_RGB666_1X7X3_SPWG		0x1010
 #define MEDIA_BUS_FMT_BGR888_1X24		0x1013
 #define MEDIA_BUS_FMT_BGR888_3X8		0x101b

-- 
b4 0.10.1
