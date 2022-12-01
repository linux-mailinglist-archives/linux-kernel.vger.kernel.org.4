Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EC763EB77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiLAIpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLAIoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:44:21 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDB98B1A9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:44:11 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 250A25C01A6;
        Thu,  1 Dec 2022 03:44:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 01 Dec 2022 03:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669884251; x=
        1669970651; bh=Wp89GBtaW7MK+d6la9pPlll3p7zimHiYkS2UgGO+ZZU=; b=I
        t/Ddxl/vLtCzgybAsREva1LlWJApQsJKliE29BLqdBVe61HJYI7OoqakerWwRo4u
        V9QVc+YxiVwLQ/3j7w7Tuk0ErI2zm7+0LmD87C9/FD2IN1MFkU8OTH6r+yVprHeW
        pzakRrfVWVGU/CZdzSZoRrtyQovfjVCwST3FW8YDNYMU4lV7lRsdfRBpjtK5CWzT
        waCSZLyMUlEKfczyLPoA5+z+EbbLKROh3zQ/1YtZ6pY4RV1nt6oXZKqF4vaBq+20
        JwnzdvbwWpJQ5OT16wqWFEgy/lJkozQ6CzijBizQJTOW5Ub5TZstRebqkYqrNQJo
        zt5KTV4I6oFvnEavxGyXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669884251; x=
        1669970651; bh=Wp89GBtaW7MK+d6la9pPlll3p7zimHiYkS2UgGO+ZZU=; b=v
        XlGbnGod+KDIVVIUCc5vAMDAZRcfqFI6ZdnkdExsSh6FkVzL84uNaZBf7k1sQbb4
        iRhacGQZl2m6Ru3Wk+qJuqsvYhmdAejWJR1J4Li6OgwFUZlniHs22nBiVqnLOaRV
        6mca32JuqwPeYh+NPKgDGbsoRiXweovcSV+ij70C0nmi3MQI7czP6V+sXECiaQ37
        evxNCKIEZw6VNO88qB8dVzFvg2aunYO4DxPSTOhYnWmmYdlgx5BtoKsHr4lMSnVc
        2MbasUXkh4IqNXtQrWYJLGJKFL+rf7nRNDaiM1Q/uiNQrwAW8sBmYbK14uS6gfr5
        RIjMtNT4eYSgkK7Nh26rg==
X-ME-Sender: <xms:WmmIY5aoLmnicM6w9gVZz9vDecxhmK2bvMs4VesxqZIyWMCvS7iWEg>
    <xme:WmmIYwaoknqHuwwmR_oGTQDWk0XqoDC_Wlflz-AjfcXyKMZBcVL_dfa4mQvCt4EkP
    4SnMIVWp88zdcbngEY>
X-ME-Received: <xmr:WmmIY79GTwS5Iy2bhpEqeWegJD5Mzbgj73OTyYVedmrbjPFs2qIpNuEx6O2jnwWWjpdj65QvHUhS6hCbmpEyP01r1OF16YpxYXOgXaS-g5DpyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdeggdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:W2mIY3olSC6b99mH-hNSTAGmSQ_jNwh3bcwTGHrw_2xegN1AJCy7HA>
    <xmx:W2mIY0pVHxu6v_OIJiDuu5T_qyTZh4i3BiR4jO2avEk2OOGbUJLCNQ>
    <xmx:W2mIY9RoFgBQw4MPPUU6ZKPwPYF7jpdYLanU32Y21Z1T473FC8PBgg>
    <xmx:W2mIY_8lZQiY-lyF3dUdqvkjYHCkCgUE8-IpyzIzpVpvUAtewQeb7g>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Dec 2022 03:44:10 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 01 Dec 2022 09:42:49 +0100
Subject: [PATCH v3 4/7] drm/vc4: dpi: Support RGB565 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221013-rpi-dpi-improvements-v3-4-eb76e26a772d@cerno.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=frMUS74NDFOUKqROpfuyhXgF/ifuNk0VZpwfF7mFoNs=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMkdmewylwqF7hzuDwpfyMWy+8K8G6fPz9ogP6vi9JFVKr7s
 GgtkOkpZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjARVSNGhrV3O9NYNu4OClvStai57i
 rXpcf+qc8Ypph556W251ya/orhn86yJv3vltKH+NjPpjc2WZsePesesDgq7VxbrLf+8crVbAA=
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

The RGB565 format with padding over 24 bits
(MEDIA_BUS_FMT_RGB565_1X24_CPADHI) is supported by the vc4 DPI
controller. This is what the Geekworm MZP280 DPI display uses, so let's
add support for it in the DPI controller driver.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_dpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
index 1f8f44b7b5a5..7da3dd1db50e 100644
--- a/drivers/gpu/drm/vc4/vc4_dpi.c
+++ b/drivers/gpu/drm/vc4/vc4_dpi.c
@@ -182,6 +182,10 @@ static void vc4_dpi_encoder_enable(struct drm_encoder *encoder)
 				dpi_c |= VC4_SET_FIELD(DPI_FORMAT_16BIT_565_RGB_3,
 						       DPI_FORMAT);
 				break;
+			case MEDIA_BUS_FMT_RGB565_1X24_CPADHI:
+				dpi_c |= VC4_SET_FIELD(DPI_FORMAT_16BIT_565_RGB_2,
+						       DPI_FORMAT);
+				break;
 			default:
 				DRM_ERROR("Unknown media bus format %d\n",
 					  bus_format);

-- 
b4 0.10.1
