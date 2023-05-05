Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6225D6F7E58
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjEEIE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjEEIE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:04:56 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601D17FEE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 01:04:53 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:83f:2c6b:b7ae:7358])
        by albert.telenet-ops.be with bizsmtp
        id sw3l290093nKn5u06w3lFr; Fri, 05 May 2023 10:04:50 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1puqPp-001AUW-An;
        Fri, 05 May 2023 10:03:45 +0200
Date:   Fri, 5 May 2023 10:03:45 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Rob Herring <robh@kernel.org>
cc:     soc@kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
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
        =?ISO-8859-15?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
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
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
Subject: Re: [PATCH 4/4] ARM: dts: Move .dts files to vendor
 sub-directories
In-Reply-To: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
Message-ID: <9d67cbbf-9be8-13c0-98fb-d0146bba79c8@linux-m68k.org>
References: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2023, Rob Herring wrote:
> The arm dts directory has grown to 1553 boards which makes it a bit
> unwieldy to maintain and use. Past attempts stalled out due to plans to
> move .dts files out of the kernel tree. Doing that is no longer planned
> (any time soon at least), so let's go ahead and group .dts files by
> vendors. This move aligns arm with arm64 .dts file structure.
>
> Doing this enables building subsets of dts files by vendor easily
> without changing kernel configs:
>
> make allyesconfig
> make arch/arm/boot/dts/ti/
>
> There's no change to dtbs_install as the flat structure is maintained on
> install.
>
> The naming of vendor directories is roughly in this order of preference:
> - Matching original and current SoC vendor prefix/name (e.g. ti, qcom)
> - Current vendor prefix/name if still actively sold (SoCs which have
>  been aquired) (e.g. nxp/imx)
> - Existing platform name for older platforms not sold/maintained by any
>  company (e.g. gemini, nspire)
>
> The whole move was scripted with the exception of MAINTAINERS.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

> arch/arm/boot/dts/renesas/Makefile                 |   33 +
> arch/arm/boot/dts/{ => renesas}/emev2-kzm9d.dts    |    0
> arch/arm/boot/dts/{ => renesas}/emev2.dtsi         |    0
> .../{ => renesas}/gr-peach-audiocamerashield.dtsi  |    0
> .../boot/dts/{ => renesas}/iwg20d-q7-common.dtsi   |    0
> .../boot/dts/{ => renesas}/iwg20d-q7-dbcm-ca.dtsi  |    0
> .../arm/boot/dts/{ => renesas}/r7s72100-genmai.dts |    0
> .../boot/dts/{ => renesas}/r7s72100-gr-peach.dts   |    0
> .../boot/dts/{ => renesas}/r7s72100-rskrza1.dts    |    0
> arch/arm/boot/dts/{ => renesas}/r7s72100.dtsi      |    0
> .../boot/dts/{ => renesas}/r7s9210-rza2mevb.dts    |    0
> arch/arm/boot/dts/{ => renesas}/r7s9210.dtsi       |    0
> .../arm/boot/dts/{ => renesas}/r8a73a4-ape6evm.dts |    0
> arch/arm/boot/dts/{ => renesas}/r8a73a4.dtsi       |    0
> .../dts/{ => renesas}/r8a7740-armadillo800eva.dts  |    0
> arch/arm/boot/dts/{ => renesas}/r8a7740.dtsi       |    0
> .../{ => renesas}/r8a7742-iwg21d-q7-dbcm-ca.dts    |    0
> .../r8a7742-iwg21d-q7-dbcm-ov5640-single.dtsi      |    0
> .../r8a7742-iwg21d-q7-dbcm-ov7725-single.dtsi      |    0
> .../boot/dts/{ => renesas}/r8a7742-iwg21d-q7.dts   |    0
> .../arm/boot/dts/{ => renesas}/r8a7742-iwg21m.dtsi |    0
> arch/arm/boot/dts/{ => renesas}/r8a7742.dtsi       |    0
> .../{ => renesas}/r8a7743-iwg20d-q7-dbcm-ca.dts    |    0
> .../boot/dts/{ => renesas}/r8a7743-iwg20d-q7.dts   |    0
> .../arm/boot/dts/{ => renesas}/r8a7743-iwg20m.dtsi |    0
> .../boot/dts/{ => renesas}/r8a7743-sk-rzg1m.dts    |    0
> arch/arm/boot/dts/{ => renesas}/r8a7743.dtsi       |    0
> .../{ => renesas}/r8a7744-iwg20d-q7-dbcm-ca.dts    |    0
> .../boot/dts/{ => renesas}/r8a7744-iwg20d-q7.dts   |    0
> .../arm/boot/dts/{ => renesas}/r8a7744-iwg20m.dtsi |    0
> arch/arm/boot/dts/{ => renesas}/r8a7744.dtsi       |    0
> .../r8a7745-iwg22d-sodimm-dbhd-ca.dts              |    0
> .../dts/{ => renesas}/r8a7745-iwg22d-sodimm.dts    |    0
> .../arm/boot/dts/{ => renesas}/r8a7745-iwg22m.dtsi |    0
> .../boot/dts/{ => renesas}/r8a7745-sk-rzg1e.dts    |    0
> arch/arm/boot/dts/{ => renesas}/r8a7745.dtsi       |    0
> .../boot/dts/{ => renesas}/r8a77470-iwg23s-sbc.dts |    0
> arch/arm/boot/dts/{ => renesas}/r8a77470.dtsi      |    0
> arch/arm/boot/dts/{ => renesas}/r8a7778-bockw.dts  |    0
> arch/arm/boot/dts/{ => renesas}/r8a7778.dtsi       |    0
> arch/arm/boot/dts/{ => renesas}/r8a7779-marzen.dts |    0
> arch/arm/boot/dts/{ => renesas}/r8a7779.dtsi       |    0
> arch/arm/boot/dts/{ => renesas}/r8a7790-lager.dts  |    0
> arch/arm/boot/dts/{ => renesas}/r8a7790-stout.dts  |    0
> arch/arm/boot/dts/{ => renesas}/r8a7790.dtsi       |    0
> .../arm/boot/dts/{ => renesas}/r8a7791-koelsch.dts |    0
> arch/arm/boot/dts/{ => renesas}/r8a7791-porter.dts |    0
> arch/arm/boot/dts/{ => renesas}/r8a7791.dtsi       |    0
> .../arm/boot/dts/{ => renesas}/r8a7792-blanche.dts |    0
> arch/arm/boot/dts/{ => renesas}/r8a7792-wheat.dts  |    0
> arch/arm/boot/dts/{ => renesas}/r8a7792.dtsi       |    0
> arch/arm/boot/dts/{ => renesas}/r8a7793-gose.dts   |    0
> arch/arm/boot/dts/{ => renesas}/r8a7793.dtsi       |    0
> arch/arm/boot/dts/{ => renesas}/r8a7794-alt.dts    |    0
> arch/arm/boot/dts/{ => renesas}/r8a7794-silk.dts   |    0
> arch/arm/boot/dts/{ => renesas}/r8a7794.dtsi       |    0
> .../dts/{ => renesas}/r8a77xx-aa121td01-panel.dtsi |    0
> .../dts/{ => renesas}/r9a06g032-rzn1d400-db.dts    |    0
> arch/arm/boot/dts/{ => renesas}/r9a06g032.dtsi     |    0
> arch/arm/boot/dts/{ => renesas}/sh73a0-kzm9g.dts   |    0
> arch/arm/boot/dts/{ => renesas}/sh73a0.dtsi        |    0

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2646,13 +2636,7 @@ C:	irc://irc.libera.chat/renesas-soc
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
> F:	Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
> F:	Documentation/devicetree/bindings/soc/renesas/
> -F:	arch/arm/boot/dts/emev2*
> -F:	arch/arm/boot/dts/gr-peach*
> -F:	arch/arm/boot/dts/iwg20d-q7*
> -F:	arch/arm/boot/dts/r7s*
> -F:	arch/arm/boot/dts/r8a*
> -F:	arch/arm/boot/dts/r9a*
> -F:	arch/arm/boot/dts/sh*
> +F:	arch/arm/boot/dts/renesas/
> F:	arch/arm/configs/shmobile_defconfig
> F:	arch/arm/include/debug/renesas-scif.S
> F:	arch/arm/mach-shmobile/

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
