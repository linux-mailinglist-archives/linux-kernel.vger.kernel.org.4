Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A8263EB76
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiLAIo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiLAIoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:44:18 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1CF88B58
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:44:09 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2A6F55C0158;
        Thu,  1 Dec 2022 03:44:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Dec 2022 03:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669884249; x=
        1669970649; bh=hEJTnUIgC8V/nzUkl5GS6H0wYtPTgVt/TYQLx4JaJs4=; b=Y
        pdC5wqp/eaxh0jW+7qY108uvwtD/l7CGeuRlHq/9M26xP8HRc8j+H6CtfMSuMX5X
        g6Jm3QHPjKq0jWZKV0IKw03nYZZAFIBpsHABJn6YBmScTvj8bB4KxMHRwCJvX6zW
        a6JjzkiPSLvafPBXzrOLw4a5iVZRfiiU8AFb8/KpLBrBtDbuZHTX/174kEpM8hr9
        5MSmn5+tKnuQVbH+T5tkPOTZlr2c9gRzzNqtWblx2HB87kMWtnQAO7BsnCLf5+Se
        XCY2JFbKx88fNqVbsdwzz0hQEze3h0qDX9geAJvLoBIsUV95OhEN+lFsY+vzrbIz
        7O9dL6IB6RUDRVbm4ZvnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669884249; x=
        1669970649; bh=hEJTnUIgC8V/nzUkl5GS6H0wYtPTgVt/TYQLx4JaJs4=; b=c
        CWygMXXraUKDAI9scUD1Web/CG6pxChDXITr8sXVBl1mirthkS8ODZM2KdUyYTf/
        QBEuvhcIqH1j6GTRTF0ERvdcD7I1svtnSIhzXQaijqqGPpSmBBHwmBQtFChlPrSA
        CtSt98ZG1Qk/xf1j1VJ7EXihKNOeVTYhk44Xc/XSxjeiwd2wWebuDg3eJyJqodBc
        Dz2IsBgpe4wD+91MeRdzosUvzyRE+rQsVgrm02vPSYECk4Y/O52mbYo9mF76OCLP
        7+xU/qhEBn1r6ywF+Dwx3RZ/VBfbu2mGgvgmjQGMP+DJWgOHZ1hwOdre0q08hnis
        vJq+Tahdm9cOa8NBiIlPg==
X-ME-Sender: <xms:WGmIY80R1IUpguh1rQw91Wkyl4Rzd0lJbzeJeX5r78k7aLczFLH7lw>
    <xme:WGmIY3HeO_qmHsyhAYoS3pwFmVktY7SZycsDRuVobn3cA-AcI2BQD1NDCJO7XOpbP
    LIsEmicjvhccfW0fJ8>
X-ME-Received: <xmr:WGmIY06U41pZIgYQMMI9aWc6TefIW8N4O3aIEle_nFH7XkxNpa1Tolqfgz6391W1w08F1fKIGzVbDHFv2je2NOp6fK9qhY1Ehwmhme0KGg2TRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdeggdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:WWmIY12l78qF78aqfJ1ImAU5XRjWDz2m4uqrYc8hBieJ0-aH_rppiw>
    <xmx:WWmIY_G6mgreOs2yhPoaNVwNyVitUA_zbFb4UVLboRXF_o5el8Dckg>
    <xmx:WWmIY--66FzW3DKevSuXPl02Is2bsOq9Gc2qkTr8-kEMHgSajfneXQ>
    <xmx:WWmIYyZrHzu0OCBRmxSZe3K2yzHm3ejxPabvAJizWGBfVb2J_HaJ3w>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Dec 2022 03:44:08 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 01 Dec 2022 09:42:48 +0100
Subject: [PATCH v3 3/7] media: uapi: add MEDIA_BUS_FMT_BGR666_1X24_CPADHI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221013-rpi-dpi-improvements-v3-3-eb76e26a772d@cerno.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=tfGtUA9ELtPM7jNo60pRSLXpqH0FBCcDLX027C7E7WQ=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMkdmexi6/lPHrp3vyXSL+K3aEBxkYvg+b4lyqysP9N2W8id
 Xvmuo5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABNJ62JkmHxPcqdNJMe9r+KG/5VmCQ
 tGJU57/PlN6v21xzf/PXShVIiR4fdMVwPrMMO4JxeSOZufz59p6PArWFFrqpimtsO6b/UNPAA=
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

From: Joerg Quinten <aBUGSworstnightmare@gmail.com>

Add the BGR666 format MEDIA_BUS_FMT_BGR666_1X24_CPADHI supported by the
RaspberryPi.

Signed-off-by: Joerg Quinten <aBUGSworstnightmare@gmail.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 .../userspace-api/media/v4l/subdev-formats.rst     | 37 ++++++++++++++++++++++
 include/uapi/linux/media-bus-format.h              |  3 +-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/subdev-formats.rst b/Documentation/userspace-api/media/v4l/subdev-formats.rst
index 6605c056cc7c..5f2ce6eada71 100644
--- a/Documentation/userspace-api/media/v4l/subdev-formats.rst
+++ b/Documentation/userspace-api/media/v4l/subdev-formats.rst
@@ -1060,6 +1060,43 @@ The following tables list existing packed RGB formats.
       - b\ :sub:`2`
       - b\ :sub:`1`
       - b\ :sub:`0`
+    * .. _MEDIA-BUS-FMT-BGR666-1X24_CPADHI:
+
+      - MEDIA_BUS_FMT_BGR666_1X24_CPADHI
+      - 0x1024
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
+      - b\ :sub:`5`
+      - b\ :sub:`4`
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
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
+      - r\ :sub:`5`
+      - r\ :sub:`4`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
     * .. _MEDIA-BUS-FMT-RGB565-1X24_CPADHI:
 
       - MEDIA_BUS_FMT_RGB565_1X24_CPADHI
diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
index 6ce56a984112..f3b0b8091a2c 100644
--- a/include/uapi/linux/media-bus-format.h
+++ b/include/uapi/linux/media-bus-format.h
@@ -34,7 +34,7 @@
 
 #define MEDIA_BUS_FMT_FIXED			0x0001
 
-/* RGB - next is	0x1024 */
+/* RGB - next is	0x1025 */
 #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
@@ -49,6 +49,7 @@
 #define MEDIA_BUS_FMT_BGR666_1X18		0x1023
 #define MEDIA_BUS_FMT_RBG888_1X24		0x100e
 #define MEDIA_BUS_FMT_RGB666_1X24_CPADHI	0x1015
+#define MEDIA_BUS_FMT_BGR666_1X24_CPADHI	0x1024
 #define MEDIA_BUS_FMT_RGB565_1X24_CPADHI	0x1022
 #define MEDIA_BUS_FMT_RGB666_1X7X3_SPWG		0x1010
 #define MEDIA_BUS_FMT_BGR888_1X24		0x1013

-- 
b4 0.10.1
