Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDF86D7D42
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbjDENCm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 09:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbjDENCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:02:40 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3397565BC;
        Wed,  5 Apr 2023 06:02:17 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pk2lE-0006xn-Nr; Wed, 05 Apr 2023 15:01:12 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org,
        Michael Walle <michael@walle.cc>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V4] nvmem: add explicit config option to read old syntax fixed OF
 cells
Date:   Wed, 05 Apr 2023 15:01:10 +0200
Message-ID: <4767237.ejJDZkT8p0@diego>
In-Reply-To: <20230403225540.1931-1-zajec5@gmail.com>
References: <20230403225540.1931-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 4. April 2023, 00:55:40 CEST schrieb Rafał Miłecki:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Binding for fixed NVMEM cells defined directly as NVMEM device subnodes
> has been deprecated. It has been replaced by the "fixed-layout" NVMEM
> layout binding.
> 
> New syntax is meant to be clearer and should help avoiding imprecise
> bindings.
> 
> NVMEM subsystem already supports the new binding. It should be a good
> idea to limit support for old syntax to existing drivers that actually
> support & use it (we can't break backward compatibility!). That way we
> additionally encourage new bindings & drivers to ignore deprecated
> binding.
> 
> It wasn't clear (to me) if rtc and w1 code actually uses old syntax
> fixed cells. I enabled them to don't risk any breakage.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> [for meson-{efuse,mx-efuse}.c]
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> [for mtk-efuse.c, nvmem/core.c, nvmem-provider.h]
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> [MT8192, MT8195 Chromebooks]
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> [for microchip-otpc.c]
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> [SAMA7G5-EK]
> Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>

> diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
> index e4579de5d014..adc8bc70cffa 100644
> --- a/drivers/nvmem/rockchip-efuse.c
> +++ b/drivers/nvmem/rockchip-efuse.c
> @@ -205,6 +205,7 @@ static int rockchip_rk3399_efuse_read(void *context, unsigned int offset,
>  
>  static struct nvmem_config econfig = {
>  	.name = "rockchip-efuse",
> +	.add_legacy_fixed_of_cells = true,
>  	.stride = 1,
>  	.word_size = 1,
>  	.read_only = true,

for rockchip-efuse.c
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


