Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7296D6170
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjDDMpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjDDMpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:45:06 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3CD10F2;
        Tue,  4 Apr 2023 05:45:05 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 88D93582193;
        Tue,  4 Apr 2023 08:45:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 08:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680612304; x=1680619504; bh=G94Eqttv/OXvodGlalDIzgnccQvgxGbN/SK
        U7FqgaLY=; b=DS55XAU4KiVd/B8XG23llRxIG0OMYo3UR3dP7KwAInssrmRHjYT
        OyLP+fQLbeamJ43A10yrkJSYlIbJfkmlH1W1mH9cyrJCsiA6rQoFJuY1u6qV18h2
        890Q6jI9FNYt86bCHtmNm9MIrDtEVDMdcn0Lzva4LXhmCD4W/CpYhaYY8hcFTtlZ
        NdE7+PhPQ3qTREiJdRjild5BZPLaxmoOKqpw0ucuYs/svHOi4vUN6cxC4fMJy8Il
        vjgGpM/VmInmOrDvkEAbJx6sUUAUp1+3Id/XjzQ7D0RnkeJymJ89svbzbyMLf7+P
        k0pKRabn/4ePeL31tnoPjWzkSfAIp9qWBeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680612304; x=1680619504; bh=G94Eqttv/OXvodGlalDIzgnccQvgxGbN/SK
        U7FqgaLY=; b=STuIsa1/IwXHihr5fIo/qipeOJl503AqDpYiS1k+6c8EZfDmNX5
        cXxrWVUfmvaF3FCkCyQiS6LKtdS22D5WAuYjwTpLVlgpV6j1hYD9EyryECJscNTv
        xYqaMFxB82g1b6q1RsPOX1gFqObSbUdexpJztQ08BW4dMm/ebcsymvDl+csOBeFD
        WqNV8TBNdoqbIjJ3lNYOl06nftmXfBVJm6JE73cSHsk/spEA21olgowrwJ6fjPYO
        XFPjKoySjrIyJKg5eqwWwdK7XtMJuvvAwhY94dXCfngq2OqF4G98JboN8rod75RD
        p8vFEmdIsjgF1jDj3ES1hIsLEpma39aG2SA==
X-ME-Sender: <xms:0BssZCITSbkGmzQLXMrZEEHPzaZU6RAHu6HHaGTMZFqx3IyjLsP5HQ>
    <xme:0BssZKLNm_Lw2awLkQopNCA_RwP2eIuDMLjeZjo0eA6OerWDa62L14XId1zT3olsB
    JTpOuRnck-U2Xueupc>
X-ME-Received: <xmr:0BssZCtyzkuOsL-VKmeJNVGFomOXKeMGvQGhsm3u6Q9-UBGV6L7CnIFx9MaEPqWbvJ6J82Z-3zazFLmevWKALSnZ3PBkAbI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepvedvleeijeegvdekffehkeehieelhfeggfffheetkeeuledvtdeuffeh
    teeltdffnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:0BssZHaqAJAa59eD8FeMSHkAOu65E5nFidLvYFC0FlI-fCzmzzxpYA>
    <xmx:0BssZJZcep7QXYxIKCo6U10SktbKMbhEhsUgUyvN7PCg2CCpbQhvUA>
    <xmx:0BssZDDMdli8hguzKICZxKZD7JadUi6nJFpMTGy1iy9xwdgQ6UpDuA>
    <xmx:0BssZKlwUCKM5TYTZZa2-mkA1Ug8sHVqnxdKyR4EGjZT1_uA86xsrw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 08:45:02 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 04 Apr 2023 12:11:21 +0200
Subject: [PATCH v3 31/65] clk: tegra: bpmp: Add a determine_rate hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221018-clk-range-checks-fixes-v3-31-9a1358472d52@cerno.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2653; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=LKIvxvq18llHtEyupaLBoAUlQmZEq1+0Jk0QS+GeIqM=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCna37dd7PvJpfVrrsTMDWK6ixa0OznWzdgj9fYfj032utoZ
 wg9kO0pZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjCRgHaGP/w+DzWUJ3/c/LvszswTix
 kupXziMjJwfmAp29z08PXT1ckM/7Sbpj2aN71KedOj9a5HDmetqDd/fO2XjQe/zpd5/PMkNvACAA==
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

The Tegra BPMP mux clock implements a mux with a set_parent hook, but
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
 drivers/clk/tegra/clk-bpmp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index 0ecdffaa6b16..3c12d8c0d28f 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -286,6 +286,7 @@ static const struct clk_ops tegra_bpmp_clk_mux_ops = {
 	.unprepare = tegra_bpmp_clk_unprepare,
 	.is_prepared = tegra_bpmp_clk_is_prepared,
 	.recalc_rate = tegra_bpmp_clk_recalc_rate,
+	.determine_rate = __clk_mux_determine_rate,
 	.set_parent = tegra_bpmp_clk_set_parent,
 	.get_parent = tegra_bpmp_clk_get_parent,
 };
@@ -543,10 +544,12 @@ tegra_bpmp_clk_register(struct tegra_bpmp *bpmp,
 		else
 			init.ops = &tegra_bpmp_clk_gate_ops;
 	} else if (info->flags & TEGRA_BPMP_CLK_HAS_MUX) {
-		if (info->flags & TEGRA_BPMP_CLK_HAS_SET_RATE)
+		if (info->flags & TEGRA_BPMP_CLK_HAS_SET_RATE) {
 			init.ops = &tegra_bpmp_clk_mux_rate_ops;
-		else
+		} else {
 			init.ops = &tegra_bpmp_clk_mux_ops;
+			init.flags |= CLK_SET_RATE_NO_REPARENT;
+		}
 	} else {
 		if (info->flags & TEGRA_BPMP_CLK_HAS_SET_RATE)
 			init.ops = &tegra_bpmp_clk_rate_ops;

-- 
2.39.2

