Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BC263EB78
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiLAIpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLAIoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:44:24 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71E38C681
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:44:13 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E6845C01A9;
        Thu,  1 Dec 2022 03:44:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Dec 2022 03:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669884253; x=
        1669970653; bh=yGORwJBsPkh/b0PObL5kDZslL3mkGzpnk9pANWLtbFs=; b=H
        NHJAo8ZRRAMl/h55bdIkyWSHbo8nzWSfnWX8lv0XA0qYK4msLbcoDUIlmy3LdLcc
        7saFz50qkP7V9nQOZmMGWof33GlRwJ4wQKmV9SVHhwITLarUFYEC3s7BhD5fz5b3
        Qwm4+Ud1w+b1Q3VApTK2IfmvEvZFDaPEc8EFgCDmpDRDjdxiyx1nwyGT9q1o8I5U
        UGPZo+w8hM7+u/twQ2XEXD8wuEzc6bW8haoE6aV12sxB2U9B4j4qYbTSgxwZIyqA
        dy3TA0e3yLZeyNfGwLSGAxef8fln83vQ3nFyU+HhTPjmOitM5i7dtThImnj4Zooo
        9E4zfBABUL7fGhVFIqtmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669884253; x=
        1669970653; bh=yGORwJBsPkh/b0PObL5kDZslL3mkGzpnk9pANWLtbFs=; b=b
        5wcgZZa17fb7DzCrPh+Y7kCHjyLsb7wXAxYNeAoNfNZgfpC4AgviGD7Ollo2MW+4
        mpcsKLEk8X8lVILLtG7tZ7/CYyGOKUWfApSX5LGyfGlvemXCUpUijNzVkNwrjw3c
        GAIfTHMYbmZu3SGxltT1Xe49F0d/qOZdCiWGHfcd4cjgPCe3gqugP6+JgGzbK+FV
        Yz4MC95obHatEMM83I+OVOIR0n9xIxcgYnZC6PdaSTmDDEg6P5uefoKnV3yWNnWG
        YfWm66vb15K9gio5GOArzxjHUIEIOptvz5N/EipKfMBBrcV45AlPQwcYUUJRRO0r
        ePDKgLev3AqgqMMpn913Q==
X-ME-Sender: <xms:XWmIY6Z2cunoh3wVmcEM2U_92clydKyDJBj0GdWSMQ7zvoi0elt7xg>
    <xme:XWmIY9bEU9ly5FLIaswpgEQYa0bTqRSmfziakb33ywIsyGwVJW7DgKPQfLqXZ-JHf
    hRydpF1VcCYxns4YJ0>
X-ME-Received: <xmr:XWmIY09rK8wvvm8jMQq0anqjHP2_GPAfjkx16AsL-9r3LIAwU0FE8np9n2CXohxqXmjfl0uPFqML3jhuuzEJM5TqT0jq9WYuLYa-w-TKQioRtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdeggdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:XWmIY8oWnaTwMWr8cbRJeGaQOQrBsP-ii5d_fKs9BjKSve7wGO6dVw>
    <xmx:XWmIY1r016NDVpITC855Pkai29HtmznMaa92eKmLEiBhxERPzZHQaQ>
    <xmx:XWmIY6SCWpjM0h0NeXqfWj2F6eopy5bXE8QeDmt4Aa5wpwWg-KLmVA>
    <xmx:XWmIYw-NqjuWZ5hfCVWuiyPGp-HRSNMU6LB7XWAvl2Ero5KIhVXncA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Dec 2022 03:44:12 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 01 Dec 2022 09:42:50 +0100
Subject: [PATCH v3 5/7] drm/vc4: dpi: Support BGR666 formats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221013-rpi-dpi-improvements-v3-5-eb76e26a772d@cerno.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=C2A769Ttl36FCHI2s5BdHwC3a6/7DNTBsfWdG3Cv96g=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMkdmexqvho3Ky3/6niwrL+w8ui5o1a3XlY77J+39tMyeZan
 piFGHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZhIlCTDP9151ZMrfp5rZaxqWM+TVf
 Ly11S1lZ0h7utL3GZeXZkQP5Xhf7GWs/rzu3s5xIUWa5n3uzdlTf46521jf+tCl7+6dzUZOAA=
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

The VC4 DPI output can support multiple BGR666 variants, but they were
never added to the driver. Let's add the the support for those formats.

Signed-off-by: Joerg Quinten <aBUGSworstnightmare@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_dpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
index 7da3dd1db50e..ecbe4cd87036 100644
--- a/drivers/gpu/drm/vc4/vc4_dpi.c
+++ b/drivers/gpu/drm/vc4/vc4_dpi.c
@@ -170,10 +170,16 @@ static void vc4_dpi_encoder_enable(struct drm_encoder *encoder)
 				dpi_c |= VC4_SET_FIELD(DPI_ORDER_BGR,
 						       DPI_ORDER);
 				break;
+			case MEDIA_BUS_FMT_BGR666_1X24_CPADHI:
+				dpi_c |= VC4_SET_FIELD(DPI_ORDER_BGR, DPI_ORDER);
+				fallthrough;
 			case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
 				dpi_c |= VC4_SET_FIELD(DPI_FORMAT_18BIT_666_RGB_2,
 						       DPI_FORMAT);
 				break;
+			case MEDIA_BUS_FMT_BGR666_1X18:
+				dpi_c |= VC4_SET_FIELD(DPI_ORDER_BGR, DPI_ORDER);
+				fallthrough;
 			case MEDIA_BUS_FMT_RGB666_1X18:
 				dpi_c |= VC4_SET_FIELD(DPI_FORMAT_18BIT_666_RGB_1,
 						       DPI_FORMAT);

-- 
b4 0.10.1
