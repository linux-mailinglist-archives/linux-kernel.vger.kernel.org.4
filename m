Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D017C5FD76F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJMJ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJMJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:57:28 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E380120072
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:57:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CB8C45C00FC;
        Thu, 13 Oct 2022 05:57:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 13 Oct 2022 05:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665655036; x=
        1665741436; bh=MQ066bDfliOyaWbJBRc3Sb4MdlZldWl5D7wyoX+CGZo=; b=x
        81AffMZCH+CvgwcgB4t5iYYaUopenUM7qCfoFaHlEyZlWqeObBhKMrzyZtd3pi6h
        /LBHzx4gDs6VRP44xtKrhelGrH35CGlmCWGWXE8yXZnH+aKqMMhX56bQPcHM+jNX
        gE/YFKyOsNMlP9XkvvR68z4yfLu2jdibvkSLv136GOFSq5o8JGtrJ3+8d5Jo4xVu
        k39UsJTrTbr1cgvKbNUMjqw6nZkOJPWzUmYiFDSsZVVT/Owz0Sk/r3tTLhk4Ba9U
        wW3uwmXS1mFOXeiLR77Nj1S5wbPEaRYrAIJBk37mX/qhawgjVmU3JE3djbAuelvP
        WVoX500KXMYxswItFd7XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665655036; x=
        1665741436; bh=MQ066bDfliOyaWbJBRc3Sb4MdlZldWl5D7wyoX+CGZo=; b=U
        KrmIqrHP2GXOaMsc5KVl3D/YTRp190ljJV6KkiAwhn77qMs+H5hep7EK2U9sUWWn
        qBS94O2LkLePEGPCFPOLfQEy7TfUwTgOcIAM3CMZ7MEPTCJHcS8IXIpYX8DYr6ZK
        rQ6EhnHMatr30ESN2m+g3FZ4hTgJEncb3y2Rg3KobZZA+Al3pjZpijFvIyPPPSEK
        Oil4L62avqqrBUnoVkUnFlZRdW1brRBVqdAG/TEBRNMgBTquLIplL1DRXMHNhDhk
        vQvE3x5ctjWYUBL8M93ndOeCrfWMdmKN+guxr46njwzbYQrdstfOthkC6IbIe8n+
        Q56JQoRzx2676gD3cebvw==
X-ME-Sender: <xms:_OBHYxscKkip3OQOCnNUAUX68xxo8SU4qy8g2dDuOcbBcyWAq62kgQ>
    <xme:_OBHY6dVCCqpiKQxPLY1FKiCzw62gIV6cFmsSB55VVv45fzxSsXW1vEKMez4aD2e-
    MiPsM9bRoYHVEMOMWw>
X-ME-Received: <xmr:_OBHY0za1CGPYzQr7fSQoBfW57p40zHwKmxn7AIw78zKHPewNxbWDrHX6kek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeektddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:_OBHY4OmtA5ux_ZN8NVDkGN3txBeiZ0Gp9wskMSrl2iqhow5PkCZBg>
    <xmx:_OBHYx9cjOfXW4OL_GUw0NshC1ELewkhmes2IQioJF9rmg8DAEQqyg>
    <xmx:_OBHY4WvAQGB-rNhsZ83yKxc5SLs4zSnfq8CuTZPwqV2tNv6omfp2Q>
    <xmx:_OBHY4WtpuuMDMfvbV3qGxI7OmBsFLYA4KGz-JxLpPpfq7hrC7nFSA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Oct 2022 05:57:16 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 13 Oct 2022 11:56:51 +0200
Subject: [PATCH 7/7] drm/vc4: dpi: Fix format mapping for RGB565
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221013-rpi-dpi-improvements-v1-7-8a7a96949cb0@cerno.tech>
References: <20221013-rpi-dpi-improvements-v1-0-8a7a96949cb0@cerno.tech>
In-Reply-To: <20221013-rpi-dpi-improvements-v1-0-8a7a96949cb0@cerno.tech>
To:     Maxime Ripard <mripard@kernel.org>, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        Joerg Quinten <aBUGSworstnightmare@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=Bfa8b+T0qwe2ry6WQDaIcHsRajSivGlVAl/5p4IUcxg=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMnuD96e/7H/+CrrHeVva3cZWF1YfCg5aYbU5YxDujWlSrLr
 mKpedZSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAiXucY/lkV6ZqeCg1OO/Lk4ILN97
 OmLitbkCjYk/yQo1639KGS6yZGhr65R1brnv661ffvY5Untyy//O1fMimxlJW582vQYd9VIiwA
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

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The mapping is incorrect for RGB565_1X16 as it should be
DPI_FORMAT_18BIT_666_RGB_1 instead of DPI_FORMAT_18BIT_666_RGB_3.

Fixes: 08302c35b59d ("drm/vc4: Add DPI driver")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_dpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
index fdae02760b6d..a7bebfa5d5b0 100644
--- a/drivers/gpu/drm/vc4/vc4_dpi.c
+++ b/drivers/gpu/drm/vc4/vc4_dpi.c
@@ -185,7 +185,7 @@ static void vc4_dpi_encoder_enable(struct drm_encoder *encoder)
 						       DPI_FORMAT);
 				break;
 			case MEDIA_BUS_FMT_RGB565_1X16:
-				dpi_c |= VC4_SET_FIELD(DPI_FORMAT_16BIT_565_RGB_3,
+				dpi_c |= VC4_SET_FIELD(DPI_FORMAT_16BIT_565_RGB_1,
 						       DPI_FORMAT);
 				break;
 			case MEDIA_BUS_FMT_RGB565_1X24_CPADHI:

-- 
b4 0.11.0-dev-7da52
