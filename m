Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4ED6F7E2C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjEEHy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEHyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:54:25 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C6F1156B;
        Fri,  5 May 2023 00:54:20 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1puqFc-0006HD-Ii; Fri, 05 May 2023 09:53:12 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     soc@kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Persson <lars.persson@axis.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Rosin <peda@axentia.se>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Marek Vasut <marex@denx.de>, Qin Jian <qinjian@cqplus1.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Paul Barker <paul.barker@sancloud.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
Subject: Re: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
Date:   Fri, 05 May 2023 09:53:10 +0200
Message-ID: <4798301.GXAFRqVoOG@diego>
In-Reply-To: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
 <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  arch/arm/boot/dts/rockchip/Makefile                |   42 +
>  arch/arm/boot/dts/{ => rockchip}/rk3036-evb.dts    |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3036-kylin.dts  |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3036.dtsi       |    0
>  .../boot/dts/{ => rockchip}/rk3066a-bqcurie2.dts   |    2 +-
>  .../boot/dts/{ => rockchip}/rk3066a-marsboard.dts  |    2 +-
>  arch/arm/boot/dts/{ => rockchip}/rk3066a-mk808.dts |    0
>  .../boot/dts/{ => rockchip}/rk3066a-rayeager.dts   |    2 +-
>  arch/arm/boot/dts/{ => rockchip}/rk3066a.dtsi      |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3128-evb.dts    |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3128.dtsi       |    0
>  .../boot/dts/{ => rockchip}/rk3188-bqedison2qc.dts |    0
>  .../arm/boot/dts/{ => rockchip}/rk3188-px3-evb.dts |    0
>  .../boot/dts/{ => rockchip}/rk3188-radxarock.dts   |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3188.dtsi       |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3228-evb.dts    |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3229-evb.dts    |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3229-xms6.dts   |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3229.dtsi       |    0
>  arch/arm/boot/dts/{ => rockchip}/rk322x.dtsi       |    0
>  .../boot/dts/{ => rockchip}/rk3288-evb-act8846.dts |    0
>  .../boot/dts/{ => rockchip}/rk3288-evb-rk808.dts   |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3288-evb.dtsi   |    0
>  .../dts/{ => rockchip}/rk3288-firefly-beta.dts     |    0
>  .../{ => rockchip}/rk3288-firefly-reload-core.dtsi |    0
>  .../dts/{ => rockchip}/rk3288-firefly-reload.dts   |    0
>  .../arm/boot/dts/{ => rockchip}/rk3288-firefly.dts |    0
>  .../boot/dts/{ => rockchip}/rk3288-firefly.dtsi    |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3288-miqi.dts   |    0
>  .../boot/dts/{ => rockchip}/rk3288-phycore-rdk.dts |    0
>  .../dts/{ => rockchip}/rk3288-phycore-som.dtsi     |    0
>  .../boot/dts/{ => rockchip}/rk3288-popmetal.dts    |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3288-r89.dts    |    0
>  .../boot/dts/{ => rockchip}/rk3288-rock-pi-n8.dts  |    2 +-
>  .../boot/dts/{ => rockchip}/rk3288-rock2-som.dtsi  |    0
>  .../dts/{ => rockchip}/rk3288-rock2-square.dts     |    0
>  .../boot/dts/{ => rockchip}/rk3288-tinker-s.dts    |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3288-tinker.dts |    0
>  .../arm/boot/dts/{ => rockchip}/rk3288-tinker.dtsi |    0
>  .../{ => rockchip}/rk3288-veyron-analog-audio.dtsi |    0
>  .../dts/{ => rockchip}/rk3288-veyron-brain.dts     |    0
>  .../rk3288-veyron-broadcom-bluetooth.dtsi          |    0
>  .../{ => rockchip}/rk3288-veyron-chromebook.dtsi   |    2 +-
>  .../boot/dts/{ => rockchip}/rk3288-veyron-edp.dtsi |    0
>  .../dts/{ => rockchip}/rk3288-veyron-fievel.dts    |    0
>  .../boot/dts/{ => rockchip}/rk3288-veyron-jaq.dts  |    2 +-
>  .../dts/{ => rockchip}/rk3288-veyron-jerry.dts     |    2 +-
>  .../dts/{ => rockchip}/rk3288-veyron-mickey.dts    |    0
>  .../dts/{ => rockchip}/rk3288-veyron-mighty.dts    |    0
>  .../dts/{ => rockchip}/rk3288-veyron-minnie.dts    |    0
>  .../dts/{ => rockchip}/rk3288-veyron-pinky.dts     |    2 +-
>  .../dts/{ => rockchip}/rk3288-veyron-sdmmc.dtsi    |    0
>  .../dts/{ => rockchip}/rk3288-veyron-speedy.dts    |    2 +-
>  .../dts/{ => rockchip}/rk3288-veyron-tiger.dts     |    0
>  .../arm/boot/dts/{ => rockchip}/rk3288-veyron.dtsi |    0
>  .../boot/dts/{ => rockchip}/rk3288-vmarc-som.dtsi  |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3288-vyasa.dts  |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3288.dtsi       |    0
>  arch/arm/boot/dts/{ => rockchip}/rk3xxx.dtsi       |    0
>  .../rockchip-radxa-dalang-carrier.dtsi             |    0
>  .../boot/dts/{ => rockchip}/rv1108-elgin-r1.dts    |    0
>  arch/arm/boot/dts/{ => rockchip}/rv1108-evb.dts    |    0
>  arch/arm/boot/dts/{ => rockchip}/rv1108.dtsi       |    0
>  .../dts/{ => rockchip}/rv1126-edgeble-neu2-io.dts  |    0
>  .../dts/{ => rockchip}/rv1126-edgeble-neu2.dtsi    |    0
>  .../boot/dts/{ => rockchip}/rv1126-pinctrl.dtsi    |    0
>  arch/arm/boot/dts/{ => rockchip}/rv1126.dtsi       |    0

>  .../boot/dts/rockchip/rk3399pro-rock-pi-n10.dts    |    2 +-

for the Rockchip-parts:
Acked-by: Heiko Stuebner <heiko@sntech.de>


Thanks
Heiko


