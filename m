Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370AE6D5D5B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDDKW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjDDKW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:22:26 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA7130DC;
        Tue,  4 Apr 2023 03:22:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 01B82582134;
        Tue,  4 Apr 2023 06:22:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 04 Apr 2023 06:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680603733; x=1680610933; bh=WYf7JKf7bEdF8hHwKDdBz9r1xxeBm+Dh8ua
        SPYCTEi4=; b=H0hJm4LCoiaDFah1h+s2JN+EunVIvLAXy7aJ5/gJILt/0yLaYDM
        0mhqqudjgH+8+vfiriJ2W+NuNbWn+692hXg8Ffs6Kh9Gkfib6vY0v791cBYg3/6F
        zbPHVAada2G67RZ0WRyYuSJm9IMK+6qyE0kkquXoD3apc/32aNVLOJMf0CR3RSeb
        CSu3tiZ1GjiHCPPTbxG+5vlGZz/X1qtMC2n696o14yFPVtDwiUBVApizG0Ndg+ST
        qQ6B+1U7nc9qJa6w8oXasXw+aOgxHx+nEtP1MBT3l1zEG/N7AU8upXO9U0Ow/NW/
        VF9YMGoW7mEBwi7342vqIH+RBL8yZTv/Snw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680603733; x=1680610933; bh=WYf7JKf7bEdF8hHwKDdBz9r1xxeBm+Dh8ua
        SPYCTEi4=; b=R2okELTrtUsALUW4p9D7il0Y1qlBCZ4HT4lnU4N5n1jsqU+rEoO
        6ECGlzsHco9TUyBLaRVvu1RlOA5VMxJ2MozFdgxGZPYclS0D7iW7++RDrCJ2HitC
        sUYDKVRFJc4hE9W3SFQDsJPYNZMFnm5ItZeJxG+FOBLoulXKl/0T4GGe3lt4Iyuy
        eljoPwHv4/0cUnjvfcmFMk+skPnv1TYfdBX2GYQhoqk8HtIhxrAjDCqIIJESmgNP
        GCsYzn/Py6HrzFsfpn4Z/Qac8kFsBRWCLMQEtrHcGCnc4NA7Ir3xwO/jvDGStyvL
        Plcha2lMZydOBeGY79cuZp8FKmEZ5n7Ha7w==
X-ME-Sender: <xms:VforZKJPU1TqtY53Ll3aQkk46Eme0QN2wGb1mjq6oF6zINffmVXm9Q>
    <xme:VforZCKQUu4BCCUc4neyDW3OcKUKkeq9XLJZv8qt8Fo4eVTP2bzTKE1wKzrosZ1ED
    33IvtstXkxyRBkCXJA>
X-ME-Received: <xmr:VforZKtCXvlA0ky3saqqUcmtOp7KIrMVkGa_DFR-BvgWrePpgmc2p0AWEad_lHYEU0JQsUZ4CEy5kXibjqSEirz7yTVTLD8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepvedvleeijeegvdekffehkeehieelhfeggfffheetkeeuledvtdeuffeh
    teeltdffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:VforZPZwj-HMU23pTOD7DHwjluKWWl_0_swXHw59c3YTDPv2b_Lmnw>
    <xmx:VforZBbhm5zl49hnGjQOUxKUGx4OMGeLIfo4t7gRVRTeynr-qf1nEw>
    <xmx:VforZLA2x8-42zXsqXMAxXONu04Dfde__d85itiTkW_kgtdOjwJcbw>
    <xmx:VforZCnJVbzV2Mo6nKId7Os0otn3V1CCiw7z8GocMp07koP4sFPcjg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 06:22:12 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 04 Apr 2023 12:10:55 +0200
Subject: [PATCH v3 05/65] clk: actions: composite: Add a determine_rate
 hook for pass clk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221018-clk-range-checks-fixes-v3-5-9a1358472d52@cerno.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=5+q2ZWHTfCPw6PYw2bUudsGQiMT0hW8lELkDwWqjDVM=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCna37e8XCa/rEL9UtD96On1hxd7N7/0sffdtDVG/lqn9bfQ
 x4arOkpZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjCR/G2MDEvkn1l9ZDA5sX+F+Vo5vS
 3LDDz7+bh/rzF1evdxruUmSQuGfwpNt3XNn096nhyh93m121vOhyu1jynW70iZdjqjSKREgwcA
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

The Actions "Pass" clock implements a mux with a set_parent hook, but
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
 drivers/clk/actions/owl-composite.c | 1 +
 drivers/clk/actions/owl-composite.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/actions/owl-composite.c b/drivers/clk/actions/owl-composite.c
index 101706e0c66f..4c844a5613e4 100644
--- a/drivers/clk/actions/owl-composite.c
+++ b/drivers/clk/actions/owl-composite.c
@@ -189,6 +189,7 @@ const struct clk_ops owl_comp_fix_fact_ops = {
 
 const struct clk_ops owl_comp_pass_ops = {
 	/* mux_ops */
+	.determine_rate	= __clk_mux_determine_rate,
 	.get_parent	= owl_comp_get_parent,
 	.set_parent	= owl_comp_set_parent,
 
diff --git a/drivers/clk/actions/owl-composite.h b/drivers/clk/actions/owl-composite.h
index bca38bf8f218..0a0eecc78344 100644
--- a/drivers/clk/actions/owl-composite.h
+++ b/drivers/clk/actions/owl-composite.h
@@ -104,7 +104,7 @@ struct owl_composite {
 			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
 						     _parent,		\
 						     &owl_comp_pass_ops,\
-						     _flags),		\
+						     _flags | CLK_SET_RATE_NO_REPARENT), \
 		},							\
 	}
 

-- 
2.39.2

