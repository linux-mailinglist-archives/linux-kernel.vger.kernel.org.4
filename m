Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D166D6326
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjDDNhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjDDNhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:37:48 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F9510CE;
        Tue,  4 Apr 2023 06:37:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id A657C5821B3;
        Tue,  4 Apr 2023 09:37:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 09:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680615465; x=1680622665; bh=snwRlfJk9HCjgI8FkV4K50a+eRyvYgxHCAm
        4VX1bCEs=; b=NNFGwJQ9GlHpgI0j9RKRuDGMwY7jp5DQIYsVF66qD4U9TIki2Zf
        ppPdHL0qcw7ZEk3QT69vrE28zTXQ0tIbb6rCpyTQ4s89xMerEl5odZt/+0Y5su97
        3HCEtCRQILPogZlxW3qHhATiyauSvLfaOnVlbiDMWejZyISSfnE3CWXacwsmI1cx
        RGCp9HiFK8jpbUy4LDAiAIs5UxEpXGsmDyiGqMaRQ/3sxPAxLtwRNB+BqJSGxeRO
        +JAHZI+lfTiI+Or//2WiDxVVg79I2h8YXkaENEvNUT+WacmhNYR2vJ5r3g1jYhzq
        fYNwri2QXiI6UoX1kZ6SJ2rJ9F16kPDQMog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680615465; x=1680622665; bh=snwRlfJk9HCjgI8FkV4K50a+eRyvYgxHCAm
        4VX1bCEs=; b=IFpx/kPSXSWDZ/o1G0Scl/+UCTUMFunUBAdlvI2q9V3YfDn2VZ+
        Fu/cL8YZKfRbEtVm5RTXuvGUZEqyJXVfugEGVvknuZPGKstR0guR9O0xE+90jnWS
        WHwQqIHtjyLMQCo2glbWaR9LoLN7geW3XS1PHy2D+C5IY4+wSKB9B+7bD6AXng1y
        lVjtsfgWd5PTayH4F/cPEaJuwrY0GvC2fHGsJ2xiYly8whjrv1Hps/OVk8B7gJ2y
        qSnwhECB651/HomgrozbPVSXiyrwwX7QH/ChMyUvbxcux6yECksJPOux5/JRncPH
        hx+26/SI0tiZJKLP0sKxEMiTihejcnnnkDQ==
X-ME-Sender: <xms:JygsZIyNU8nfG9F8EyDuN52u5QH4u8uPa-RDSrq7APM92iatQfKH0Q>
    <xme:JygsZMQoxfYb0SIWvPpcRwLRUiDwSRJsCb8hk83FU_nQwNS33TwhIHBLiRQmmqqZA
    nypqPBp9PYtEcP0NFA>
X-ME-Received: <xmr:JygsZKXLoriU3FBrLb0emR1zYAtFK1FwKLKpTkx4YPYJU30iyfKFQsWClHrS_GFfBSo6xgK9TctOsQuf1xxMCoHqbWhDiYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepvedvleeijeegvdekffehkeehieelhfeggfffheetkeeuledvtdeuffeh
    teeltdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JygsZGhfRvfEJvPE1ZSI_Hz2_wTSCAYut9BSzs_C9FDpiRb4-d_6OA>
    <xmx:JygsZKDT0eLG4lRSjpFvKmMn1qknGcKkqny-n40rM7C-dhYTmAuMXw>
    <xmx:JygsZHJ3329sBowqSdFQBm72xJTU-HSwdCv3d4MD94b0h8lVgAyD_A>
    <xmx:KSgsZMP7G-ZSQP_tFlYgaoAs-QfvQFY8lTv2_6JnEyg7KIFGaWuEew>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 09:37:42 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 04 Apr 2023 12:11:33 +0200
Subject: [PATCH v3 43/65] ASoC: tlv320aic32x4: Add a determine_rate hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221018-clk-range-checks-fixes-v3-43-9a1358472d52@cerno.tech>
References: <20221018-clk-range-checks-fixes-v3-0-9a1358472d52@cerno.tech>
In-Reply-To: <20221018-clk-range-checks-fixes-v3-0-9a1358472d52@cerno.tech>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Abel Vesa <abelvesa@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, patches@opensource.cirrus.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-mips@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2892; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=9re8qhNsTP+vY2op9k8uBaEAOkZLm6TykagYJ9nz2T8=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCna37e5MGc82teUM81c/sO0tIz/Zn9Dc89NdnX6c8bujU7s
 bubmjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEzk8lSG/yW3T+Y28nwVkg9qM21x2r
 Fhk9YXW12hvvOhM85udJgmxMPIsHPuFbZ7DaLZAue2zBGxkq8/+miabIP1qr/bJSU7nqk94wAA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=0.2 required=5.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tlv320aic32x4 clkin clock implements a mux with a set_parent hook,
but doesn't provide a determine_rate implementation.

This is a bit odd, since set_parent() is there to, as its name implies,
change the parent of a clock. However, the most likely candidate to
trigger that parent change is a call to clk_set_rate(), with
determine_rate() figuring out which parent is the best suited for a
given rate.

The other trigger would be a call to clk_set_parent(), but it's far less
used, and it doesn't look like there's any obvious user for that clock.

So, the set_parent hook is effectively unused, possibly because of an
oversight. However, it could also be an explicit decision by the
original author to avoid any reparenting but through an explicit call to
clk_set_parent().

The latter case would be equivalent to setting the flag
CLK_SET_RATE_NO_REPARENT, together with setting our determine_rate hook
to __clk_mux_determine_rate(). Indeed, if no determine_rate
implementation is provided, clk_round_rate() (through
clk_core_round_rate_nolock()) will call itself on the parent if
CLK_SET_RATE_PARENT is set, and will not change the clock rate
otherwise. __clk_mux_determine_rate() has the exact same behavior when
CLK_SET_RATE_NO_REPARENT is set.

And if it was an oversight, then we are at least explicit about our
behavior now and it can be further refined down the line.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index 2f78e6820c75..65b72373cb95 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -41,6 +41,7 @@ struct aic32x4_clkdesc {
 	const char * const *parent_names;
 	unsigned int num_parents;
 	const struct clk_ops *ops;
+	unsigned long flags;
 	unsigned int reg;
 };
 
@@ -292,6 +293,7 @@ static u8 clk_aic32x4_codec_clkin_get_parent(struct clk_hw *hw)
 }
 
 static const struct clk_ops aic32x4_codec_clkin_ops = {
+	.determine_rate = __clk_mux_determine_rate,
 	.set_parent = clk_aic32x4_codec_clkin_set_parent,
 	.get_parent = clk_aic32x4_codec_clkin_get_parent,
 };
@@ -401,6 +403,7 @@ static struct aic32x4_clkdesc aic32x4_clkdesc_array[] = {
 			(const char *[]) { "mclk", "bclk", "gpio", "pll" },
 		.num_parents = 4,
 		.ops = &aic32x4_codec_clkin_ops,
+		.flags = CLK_SET_RATE_NO_REPARENT,
 		.reg = 0,
 	},
 	{
@@ -452,7 +455,7 @@ static struct clk *aic32x4_register_clk(struct device *dev,
 	init.name = desc->name;
 	init.parent_names = desc->parent_names;
 	init.num_parents = desc->num_parents;
-	init.flags = 0;
+	init.flags = desc->flags;
 
 	priv = devm_kzalloc(dev, sizeof(struct clk_aic32x4), GFP_KERNEL);
 	if (priv == NULL)

-- 
2.39.2

