Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820976D5D5D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbjDDKXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbjDDKW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:22:29 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ABF2D6D;
        Tue,  4 Apr 2023 03:22:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 33E61582158;
        Tue,  4 Apr 2023 06:22:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 04 Apr 2023 06:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680603743; x=1680610943; bh=McFZfSu3lQtkoGzFDWnXzDL5yLRC5eNlcnf
        9zV8mqVs=; b=iMhmRFqOet0KMffaWXdKJebERwXyOcOjkJ8oenvOHEViP5ywNoQ
        VRHAH3VOoQ1c4+T9khTksCM950Cq+3kk94btegM6n0yiHUreFtBorBTjTWZ8Ickc
        kkhOIQq7NGG9a5AyWAXqL1Il0rRSq1KSamSxbW3Rz4BxnltWfGsG1OeieviPq74m
        XjwNYdS7xTOAeAJSPfztdOKiJtIjREsZLp6H7f5143GP6MdOBrLASH9QWjHnN8Un
        lO6hlPNu2rE4cnnBKPv3oxk3a9gkZiYbhHow8zXv5YBAKWZtLUuctK/WGGroHEwj
        U8I/kEoH4ANDfnbR+U7qkkoNq+i+d/C1BwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680603743; x=1680610943; bh=McFZfSu3lQtkoGzFDWnXzDL5yLRC5eNlcnf
        9zV8mqVs=; b=gMGXbCrSvtaBHVYNRPC5CQSZpR6k4JnzcyYXOqZjCJN1UD1WUT6
        zFNQJyuB43CooVMjE0qT7B6cEDkyOQYYlASnQUPvBvV6vwcSOpYs4DXfsidPXzMO
        xlwZ5hI31ljdQgtLns2WpUs8m3tOMVY7xRiCjGjqA8EFxdiS86HKC/TvH5MIw2du
        WmE1ljXEr2hkVtj1WBJQEYkFe9CR/n892AH/8bxEnq1lzUyExDMu6/b+gRLvHnI9
        8KiH0Iq+zP5lQhWfUa3hLf8y42uqfewcBddbbcfD84WQoPzBtFDxlp5ru13xluJk
        +DKPWewkrlHlMX3YbhexghWRYbyvB/NeyCg==
X-ME-Sender: <xms:X_orZN9uhWBCWGdBMmuEEMaB22-I-atoxWSDslG3Ld2hnTk_R9TD_w>
    <xme:X_orZBur9tnLh2v0xi1Z0GsEdJspW4XvnwxUTOuFnZccGvV1lvCHDde6jRW0VPH4t
    BeYHncFESD23Bhz0Dg>
X-ME-Received: <xmr:X_orZLB0BYr_ZbrZsgP_2Cn-kZFePuKVb1_lDy5lhYspGWkdDxi105InFsN0W9ej6JDUTTjAZR3w2HO4koBCVfEm-S8tUmU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepvedvleeijeegvdekffehkeehieelhfeggfffheetkeeuledvtdeuffeh
    teeltdffnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:X_orZBc7TCJoDamg_GJn7BancCPj6lEFdt30hkPZpUIWbJjDeG3Mfw>
    <xmx:X_orZCOXA78iTIpZSqADsKl-fdZhyUFS3q3jsRZ3P8ZquUDxKC0W2A>
    <xmx:X_orZDloe71dULe5NTAFcihlyE06ShISRPxQ4hNN2VD-2dmVZtKZrQ>
    <xmx:X_orZH6wXM1kF6puOLqj5tPmnldvfeXX36-u9Qg09asPwJWiwXY5Ew>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 06:22:21 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 04 Apr 2023 12:10:58 +0200
Subject: [PATCH v3 08/65] clk: berlin: div: Add a determine_rate hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221018-clk-range-checks-fixes-v3-8-9a1358472d52@cerno.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=ILr30FQKyRNC7COORPRmcsIls6pf7H5+tWBJ11Ox8iA=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCna37eU3o/y5U8tfe+wxm6D0M5yvvb152cKNn87d7Xh8i27
 Apd9HaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZhIcTIjw1T7Iv6kJXmvJgqXb/04TV
 aTR4slaNVKJtnlux5LbtEKlmZkuBpsfiTT6uu10J/LD15vFFzRsFDzDcOW/Vt+LYl8+r/yGw8A
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Berlin2 divider clock implements a mux with a set_parent hook, but
doesn't provide a determine_rate implementation.

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
 drivers/clk/berlin/berlin2-div.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/berlin/berlin2-div.c b/drivers/clk/berlin/berlin2-div.c
index eb14a5bc0507..d3856ec93c12 100644
--- a/drivers/clk/berlin/berlin2-div.c
+++ b/drivers/clk/berlin/berlin2-div.c
@@ -210,6 +210,7 @@ static unsigned long berlin2_div_recalc_rate(struct clk_hw *hw,
 }
 
 static const struct clk_ops berlin2_div_rate_ops = {
+	.determine_rate	= __clk_mux_determine_rate,
 	.recalc_rate	= berlin2_div_recalc_rate,
 };
 
@@ -251,5 +252,5 @@ berlin2_div_register(const struct berlin2_div_map *map,
 
 	return clk_hw_register_composite(NULL, name, parent_names, num_parents,
 				      &div->hw, mux_ops, &div->hw, rate_ops,
-				      &div->hw, gate_ops, flags);
+				      &div->hw, gate_ops, flags | CLK_SET_RATE_NO_REPARENT);
 }

-- 
2.39.2

