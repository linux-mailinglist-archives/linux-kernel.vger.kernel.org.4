Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1996D6D6178
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjDDMqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjDDMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:45:30 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE0B3C0F;
        Tue,  4 Apr 2023 05:45:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2BF265821A5;
        Tue,  4 Apr 2023 08:45:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 04 Apr 2023 08:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680612314; x=1680619514; bh=01FipjR7hB2znb4Y0NzgfAfJPt3j4Fl/cjj
        0ztkxVm0=; b=rEdWujGcLa1LsZefdDCOvwljcn+IMV68PcF4ljaVXCa0EMpmAtB
        aWE2VQOL1exyhTsv9C8w+oSx2AZMXkZpD4Geo9iKsHD4TEQ/kmgBgsKis/tLb8Le
        2GHmvir3+Eu8+nDXg+WiyaMzO5qwLWq/6916cMaWHdoCJI/NuAVggac85521YX06
        oP4ZRrS+xf5dKnfpLUqbjfg2lhBIJmcQlq+kpLe5XTw8NZ0VWRvJen8Dq9bQOaat
        yaPFi2CQycLgKtieHTeEbIuBxdujXWQT0SZNSsnM5e1+/WTJKvuJG5YAcF8Xn3MS
        vqFTINw9OtX6O8sQoD4w3WrAZyHeKKFGuLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680612314; x=1680619514; bh=01FipjR7hB2znb4Y0NzgfAfJPt3j4Fl/cjj
        0ztkxVm0=; b=ugtz189HJXn1c/nUrqOlFPAf/y/3Es7Fqyr0LQrd1jhYBKnrRIf
        l8Npg1rklQv1Y+vaSBzuwPgvlrzcXnGT9aVZErEd0/8k2Dt/5FMMGQlJYmnayd0A
        hDfziDOiQB5ZD0YVsxwoBXCKKT/wgJYlySUIz5ndffhuibnDKlexHLu674wDVEPA
        01rKjdIEzjnpYeD0sC8Ciaiet9Gq8Q0v8gLmXGSu8ymiBcmYYCeFRpuvD+ujXflY
        fakA9O+OoLIwwsuN2QZIcLdEnUbHjNjY3YVAnIEO6F94jzF3eiGYViO0DRFp2XLs
        veEEOaKxBnAOoou+kuyz96t1SwZkLfeXIrw==
X-ME-Sender: <xms:2RssZCSTKDB7zAxQCZfH1E-077Q95eiDd5FxTnUmRre3r3jqJokwiw>
    <xme:2RssZHwanxoCe4Q2NcYbOSiSnKD6hgM9zUrcqTWcjI0NhHgZ9NOZnfAl2RoczlzE1
    B3zoOg0lKAE5CFnnKA>
X-ME-Received: <xmr:2RssZP0GOjGIzRnT19EcRgV0DEa_aul9ErF4OzGyCJ_0dcxw3dGBhTCNQowX9zt9STbgOqakUNb0UgAe4U44zZ9fPe16CuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepvedvleeijeegvdekffehkeehieelhfeggfffheetkeeuledvtdeuffeh
    teeltdffnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:2hssZOCzGzTcHvTIZk0xf8mP6Xpwww-rwPzjzE4eujOjezdyr2hl2w>
    <xmx:2hssZLiaKmJ1JXSny_ET5-SgM_tcfESLYCPGI6yWw7XkGnW2fuQhPw>
    <xmx:2hssZKrMq8UPzeaLI6JlK9PVgI1Lm-uPAx292JcgNc-gnH4ltQOS_g>
    <xmx:2hssZJvEpcLaAIBqgI8jABDEamALijaQC95xLnLVx9aqFfnvBQYdPg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 08:45:12 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 04 Apr 2023 12:11:24 +0200
Subject: [PATCH v3 34/65] clk: ux500: prcmu: Add a determine_rate hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221018-clk-range-checks-fixes-v3-34-9a1358472d52@cerno.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2620; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=FJlZTK/z6qtz7cWmigitZm3y3KooEpa2POkQ9WE0nzA=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCna37eZHPR46iLpvfp2/Qsvx7dy8c36744UbtvwfXXl0aOJ
 hZfWdZSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAiF7UZ/vDpfsup3baO65ql1E3Lwv
 UcbV58PxglT6+0ZWN0OnLvBwsjw3rnRU2iP/e/0Vc9v+vT/X89hgU+/Z9v1nvfNBOXLlGo4AIA
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

The UX500 PRCMU "clkout" clock implements a mux with a set_parent hook,
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

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/ux500/clk-prcmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
index 4deb37f19a7c..7118991f3731 100644
--- a/drivers/clk/ux500/clk-prcmu.c
+++ b/drivers/clk/ux500/clk-prcmu.c
@@ -344,6 +344,7 @@ static const struct clk_ops clk_prcmu_clkout_ops = {
 	.prepare = clk_prcmu_clkout_prepare,
 	.unprepare = clk_prcmu_clkout_unprepare,
 	.recalc_rate = clk_prcmu_clkout_recalc_rate,
+	.determine_rate = __clk_mux_determine_rate,
 	.get_parent = clk_prcmu_clkout_get_parent,
 	.set_parent = clk_prcmu_clkout_set_parent,
 };
@@ -383,7 +384,7 @@ struct clk_hw *clk_reg_prcmu_clkout(const char *name,
 
 	clk_prcmu_clkout_init.name = name;
 	clk_prcmu_clkout_init.ops = &clk_prcmu_clkout_ops;
-	clk_prcmu_clkout_init.flags = CLK_GET_RATE_NOCACHE;
+	clk_prcmu_clkout_init.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_NO_REPARENT;
 	clk_prcmu_clkout_init.parent_names = parent_names;
 	clk_prcmu_clkout_init.num_parents = num_parents;
 	clk->hw.init = &clk_prcmu_clkout_init;

-- 
2.39.2

