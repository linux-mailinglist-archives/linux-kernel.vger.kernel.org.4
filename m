Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F161EA84
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 06:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiKGFgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 00:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiKGFgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 00:36:01 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8FA6461;
        Sun,  6 Nov 2022 21:36:00 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C40E25C010F;
        Mon,  7 Nov 2022 00:35:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 07 Nov 2022 00:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1667799359; x=1667885759; bh=CT
        F3MeYBdYDb9QkjYMGL6Erp3oYYPDieKsIYfX3UM/o=; b=oztyJd2DwVU66oSlO4
        hU2Ylwpd5r1sGPpUVIZgDeVlN1YDysjnKxtHaa5Eog5QGNexxDJUxh7iPO4WBL++
        XqHRfDNfAzaXQxVPKm3KUjKI6+6/KZrzopx/A6efEm/VPPqotGYXxk7fOkpnz21o
        DJffO8LVzKGG26HyVWUGDtulT85+blUv8sbvW5i4AxZ4H8eA6u3Y3pJbDeEZh4FL
        2MorhqWRAWmzYckreZAHD1I9x2P0aw/OWMM5GrXXcZC8iD4eNNDUFshOHDzJ1qoz
        6JIdDlbRFkVRc6Z+sMAU85kJ2/wBNQYH+5vLeWqhRgVnUo9xbuOWCnPq0oGGvv8d
        +8UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667799359; x=1667885759; bh=CTF3MeYBdYDb9
        QkjYMGL6Erp3oYYPDieKsIYfX3UM/o=; b=hxhSlOjhW0zlCMgveB+jr7nbj6mHp
        ziNeGtdMV4fuZHTiLUT2y7+ZOy4/61VkkNcvW3yR8+JV1nihEsL083adPxSosn/j
        4MjY6vOxJ4vFEiUfnENhtsW0WDEa9M1PQUZ4iuF+JODFtDb6BxHCVrM1AHEEHiRh
        cZpNuxlL8pllUnjBAnu+1ioeKJJOkfKcxPjxXtLcXMmlXYsIG5iBENAK3AePEJ7b
        HeZo6N7bRMfqxii0x+3KL2x2xG97kT/dUa5Fhgdx42bFJZGzSvVHvugyv0vnk6oC
        XGwg1Eo0w7VuMRrnc+ltGbazO46gLhWDz0ZvmpgxayWgTD9Yn3VlNag4Q==
X-ME-Sender: <xms:P5loY0mLaQDs_5T0oflYK9ATlt1_ZpWCW_jK1p__glbPK3GjBi9Mfg>
    <xme:P5loYz0AVv11fcTRMMC58DzOVEMq92ufIFrcYn53VjKWUFYW48VabekIUoehyhu0-
    GzfYNqp-kMV89IqJw>
X-ME-Received: <xmr:P5loYypAcTeL3g_tCkRTbTTM1YOcD-GtqnOu-wrlPMfTec5peHfB4jIX0rHFBVMSWmEXgh4HAOViBpvJscwlUE5VrI_vRbOZpcuW_Fw1MOh8MgnvQyp3mpkBdwEjisa8DAiqkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdejgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:P5loYwl6eTLBfzDzx7tfxAyJ0UW35UhvSVv5TpxpEzr61gPjSmTtYQ>
    <xmx:P5loYy3Q7Cu81eRcaPX6QU3e5nb9IwWAp-VlJN_SAvlVSk9jcDW1uw>
    <xmx:P5loY3utP-fKV6JfylFmk0ygsAMWnoq2oc_nZ0z49Oq_9q_LPTWQ1A>
    <xmx:P5loY4P0CNm9-iFcoo_1tKLvSMx2-jk4mzarSiDtV6nqgPTLDY3vpA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 00:35:58 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 4/4] drm/sun4i: dsi: Add the A100 variant
Date:   Sun,  6 Nov 2022 23:35:52 -0600
Message-Id: <20221107053552.2330-5-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221107053552.2330-1-samuel@sholland.org>
References: <20221107053552.2330-1-samuel@sholland.org>
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

The A100 variant of the MIPI DSI controller now gets its module clock
from the TCON via the TCON TOP, so the clock rate cannot be set to a
fixed value. Otherwise, it appears to be the same as the A31 variant.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index f22c96cc8408..760ff05eabf4 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1223,6 +1223,10 @@ static const struct sun6i_dsi_variant sun6i_a31_mipi_dsi_variant = {
 static const struct sun6i_dsi_variant sun50i_a64_mipi_dsi_variant = {
 };
 
+static const struct sun6i_dsi_variant sun50i_a100_mipi_dsi_variant = {
+	.has_mod_clk	= true,
+};
+
 static const struct of_device_id sun6i_dsi_of_table[] = {
 	{
 		.compatible	= "allwinner,sun6i-a31-mipi-dsi",
@@ -1232,6 +1236,10 @@ static const struct of_device_id sun6i_dsi_of_table[] = {
 		.compatible	= "allwinner,sun50i-a64-mipi-dsi",
 		.data		= &sun50i_a64_mipi_dsi_variant,
 	},
+	{
+		.compatible	= "allwinner,sun50i-a100-mipi-dsi",
+		.data		= &sun50i_a100_mipi_dsi_variant,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
-- 
2.37.3

