Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C612E6D615D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjDDMpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbjDDMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:44:51 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F025D90;
        Tue,  4 Apr 2023 05:44:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 62D7A58215F;
        Tue,  4 Apr 2023 08:44:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 08:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680612289; x=1680619489; bh=r3KMQFa+lrkWg2WBqQj10EQ9q1W+/TWm+Pz
        BqMrDdTI=; b=dbf1x1yAHsITG76k8ptMk0OBcyBgbTQmL0tomFHDYQQ9pkmYru+
        SjjJzxdhnYpJOlilnagvfJ8nZ9DXzV2/VplzO7zXCjLxoU24ZTGushKTSsBjT76k
        NqMuT82075ETWV4+o/yzRzQLxyD4oXv3rouWwylMovmbiTVwxdxLGlfnr+5RkJUP
        y/DUcQAsyxND9Go+AUEOEn5OQempm7FAZJcNF/x5734UukiqgwFnn0g+h+qOYDrL
        eHCTFUNe9iHHWcvgNFpdDwprFPTkn9llMRiqgDfAhUz0FucVIE5spyRnWkAnWybY
        jc6zCDLRwfA9giqONPbs3Uz0G8/uSwQCmoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680612289; x=1680619489; bh=r3KMQFa+lrkWg2WBqQj10EQ9q1W+/TWm+Pz
        BqMrDdTI=; b=nElUpLJwgeTtdOqmWG4IwxnjdUrYPdii6dEH+uAl+kwUefciUYZ
        gqYb/avO7cwVspHOpaNauBgUjRQa9R3Qs+octaZeySM2iL0niI8WlBEhnMC6ZT9g
        sC0ITnmUhNjeS3E+0WCRvsuH1Y1syo3EssDel2Ulw39whCEw0SdOQCmeBgF/bq0w
        TUJpxEvdc0R0oLGWkZe4Y7a7JngtpuOcN8l/RGAKgfG5Ckq6k3c9PdkwDwUy1WS2
        NUWz0VXnVy/7hkY5gjH5363lE/xa9OLni/OXe/RTjj0zjBXC/k+aTmZDOeoS0LqC
        P53zQiIh4zlfj4GrBOZo08Kq9QqEs6pgXsw==
X-ME-Sender: <xms:wRssZOxTGukDEojnk4xSOWdN2ME-tgZ1lLNOlY1nX4qAArCmkOJszA>
    <xme:wRssZKTfITVz8_5Z3grLCbOC89cDu0t2wYJRI85rfM6Xr0429B8tkTGN9fXaKqGL4
    8t15RizsF3zHWsPISE>
X-ME-Received: <xmr:wRssZAXp6Wj5S13yPzOduIgHGmxgzx-Twv9552CW50WD0_oPvxSEwwYzkqzlco3yXapOlByjAEOrMuMBSydZhzySdWuwHlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepvedvleeijeegvdekffehkeehieelhfeggfffheetkeeuledvtdeuffeh
    teeltdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:wRssZEghcj5-rsgpP-XLjkuvwkCTTR2FlEK8FdhtXgxcxTvsywFLsQ>
    <xmx:wRssZACgInuYmGTxIGwix2FElZYkT6oXFZT6XM5JgC7kXPOF-rscLA>
    <xmx:wRssZFK8ZIoB4JGkZpD2ZTdRwJ38_Zmqya-qj_rZQC01VDFvcPTS1w>
    <xmx:wRssZCNPAA4eUsexTFD3INnj8DX8hf6HjMWkFo2PLDinfOp0xXmmYQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 08:44:47 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 04 Apr 2023 12:11:16 +0200
Subject: [PATCH v3 26/65] clk: mediatek: cpumux: Add a determine_rate hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221018-clk-range-checks-fixes-v3-26-9a1358472d52@cerno.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=vAoGLWC1+b7M6VlyyPtfv65hShVWSyPsvsjKIhTdNgA=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCna37cyZ/V9P9lwJrpi9jMez6jcp6c2xfaFrr5b+vt68MkD
 10w2dJSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAidzczMuwrUPN0ZdR49tD495xcpt
 e9U97FM85XtX7YEfa+KPMC1y2G/6kHSiuP2ed/vNbDM+HV253yZxuE1Jx+nbr15652n4HmUm4A
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

The Mediatek cpumux clock implements a mux with a set_parent hook, but
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
 drivers/clk/mediatek/clk-cpumux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index da05f06192c0..dd4eb3f215cc 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -53,6 +53,7 @@ static int clk_cpumux_set_parent(struct clk_hw *hw, u8 index)
 }
 
 static const struct clk_ops clk_cpumux_ops = {
+	.determine_rate = __clk_mux_determine_rate,
 	.get_parent = clk_cpumux_get_parent,
 	.set_parent = clk_cpumux_set_parent,
 };
@@ -73,7 +74,7 @@ mtk_clk_register_cpumux(struct device *dev, const struct mtk_composite *mux,
 	init.ops = &clk_cpumux_ops;
 	init.parent_names = mux->parent_names;
 	init.num_parents = mux->num_parents;
-	init.flags = mux->flags;
+	init.flags = mux->flags | CLK_SET_RATE_NO_REPARENT;
 
 	cpumux->reg = mux->mux_reg;
 	cpumux->shift = mux->mux_shift;

-- 
2.39.2

