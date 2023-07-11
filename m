Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2738174E8B9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGKING (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGKINE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:13:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F378FE3;
        Tue, 11 Jul 2023 01:13:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6971C660700A;
        Tue, 11 Jul 2023 09:12:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689063180;
        bh=2+yn6FDwMd8voKMx1WPt05JiOyMTQxbLsZaEtvbtNN4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fx8WIExUEuJPaY5MFu8knfLP/k0C26AMfNb/AvH/Fmm0WSmwyzjbdouviC0vRIt5c
         MKvJLE8w0cLrlZEwxmbFWfOjjLGUQZgFi0o1pLWqgdMYxBGlFBGIjiNaupLZ6FnB33
         j1HPiXlommzYaYv6ce4cvKcTdjN1ewdnVTlkRjRRehst4X7XEwQxnR9ySh21JtPk6b
         7KLhT/OtiV9F5v6WVi5j7pxhtZflk0tkK/vKZu9Q314nRK+CtbZPcevQ7M0A64UCcq
         2GUJjcluoW7Hk+VgSk0dx0uk8kgwhRiKCYyXOMoe3dlhEE5DcTiXTswvygvLYV31mr
         rt/T478FT4VDw==
Message-ID: <f0b9e2e4-b2c0-4336-0ec4-5afd9f1b6c72@collabora.com>
Date:   Tue, 11 Jul 2023 10:12:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 01/15] spi: Remove unneeded OF node NULL checks
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-2-andriy.shevchenko@linux.intel.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230710154932.68377-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/07/23 17:49, Andy Shevchenko ha scritto:
> In the couple of places the NULL check of OF node is implied by the call
> that takes it as a parameter. Drop the respective duplicate checks.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Validated against spi-mt65xx, spi-mt7621, spi-mtk-nor, spi-mtk-snfi;

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> # 
MediaTek

> ---
>   drivers/spi/spi.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 9291b2a0e887..8f3282a71c63 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2399,9 +2399,6 @@ static void of_register_spi_devices(struct spi_controller *ctlr)
>   	struct spi_device *spi;
>   	struct device_node *nc;
>   
> -	if (!ctlr->dev.of_node)
> -		return;
> -
>   	for_each_available_child_of_node(ctlr->dev.of_node, nc) {
>   		if (of_node_test_and_set_flag(nc, OF_POPULATED))
>   			continue;
> @@ -3134,7 +3131,7 @@ int spi_register_controller(struct spi_controller *ctlr)
>   		if (WARN(id < 0, "couldn't get idr"))
>   			return id == -ENOSPC ? -EBUSY : id;
>   		ctlr->bus_num = id;
> -	} else if (ctlr->dev.of_node) {
> +	} else {
>   		/* Allocate dynamic bus number using Linux idr */
>   		id = of_alias_get_id(ctlr->dev.of_node, "spi");
>   		if (id >= 0) {



