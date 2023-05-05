Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816236F8360
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjEEM7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjEEM7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:59:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04E8C1D97D;
        Fri,  5 May 2023 05:58:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1143E2F4;
        Fri,  5 May 2023 05:59:42 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E01E3F64C;
        Fri,  5 May 2023 05:58:50 -0700 (PDT)
Date:   Fri, 5 May 2023 13:58:47 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     soc@kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
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
        Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
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
Subject: Re: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
Message-ID: <20230505135847.7e433a18@donnerap.cambridge.arm.com>
In-Reply-To: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
        <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 May 2023 22:29:29 -0500
Rob Herring <robh@kernel.org> wrote:

Hi,

> diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
> new file mode 100644
> index 000000000000..a9f068e90c8e
> --- /dev/null
> +++ b/arch/arm/boot/dts/allwinner/Makefile
> @@ -0,0 +1,159 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_MACH_SUN4I) += \
> +	sun4i-a10-a1000.dtb \
> +	sun4i-a10-ba10-tvbox.dtb \
> +	sun4i-a10-chuwi-v7-cw0825.dtb \
> +	sun4i-a10-cubieboard.dtb \
> +	sun4i-a10-dserve-dsrv9703c.dtb \
> +	sun4i-a10-gemei-g9.dtb \
> +	sun4i-a10-hackberry.dtb \
> +	sun4i-a10-hyundai-a7hd.dtb \
> +	sun4i-a10-inet1.dtb \
> +	sun4i-a10-inet97fv2.dtb \
> +	sun4i-a10-inet9f-rev03.dtb \
> +	sun4i-a10-itead-iteaduino-plus.dtb \
> +	sun4i-a10-jesurun-q5.dtb \
> +	sun4i-a10-marsboard.dtb \
> +	sun4i-a10-mini-xplus.dtb \
> +	sun4i-a10-mk802.dtb \
> +	sun4i-a10-mk802ii.dtb \
> +	sun4i-a10-olinuxino-lime.dtb \
> +	sun4i-a10-pcduino.dtb \
> +	sun4i-a10-pcduino2.dtb \
> +	sun4i-a10-pov-protab2-ips9.dtb \
> +	sun4i-a10-topwise-a721.dtb
> +dtb-$(CONFIG_MACH_SUN5I) += \
> +	sun5i-a10s-auxtek-t003.dtb \
> +	sun5i-a10s-auxtek-t004.dtb \
> +	sun5i-a10s-mk802.dtb \
> +	sun5i-a10s-olinuxino-micro.dtb \
> +	sun5i-a10s-r7-tv-dongle.dtb \
> +	sun5i-a10s-wobo-i5.dtb \
> +	sun5i-a13-difrnce-dit4350.dtb \
> +	sun5i-a13-empire-electronix-d709.dtb \
> +	sun5i-a13-empire-electronix-m712.dtb \
> +	sun5i-a13-hsg-h702.dtb \
> +	sun5i-a13-inet-98v-rev2.dtb \
> +	sun5i-a13-licheepi-one.dtb \
> +	sun5i-a13-olinuxino.dtb \
> +	sun5i-a13-olinuxino-micro.dtb \
> +	sun5i-a13-pocketbook-touch-lux-3.dtb \
> +	sun5i-a13-q8-tablet.dtb \
> +	sun5i-a13-utoo-p66.dtb \
> +	sun5i-gr8-chip-pro.dtb \
> +	sun5i-gr8-evb.dtb \
> +	sun5i-r8-chip.dtb
> +dtb-$(CONFIG_MACH_SUN6I) += \
> +	sun6i-a31-app4-evb1.dtb \
> +	sun6i-a31-colombus.dtb \
> +	sun6i-a31-hummingbird.dtb \
> +	sun6i-a31-i7.dtb \
> +	sun6i-a31-m9.dtb \
> +	sun6i-a31-mele-a1000g-quad.dtb \
> +	sun6i-a31s-colorfly-e708-q1.dtb \
> +	sun6i-a31s-cs908.dtb \
> +	sun6i-a31s-inet-q972.dtb \
> +	sun6i-a31s-primo81.dtb \
> +	sun6i-a31s-sina31s.dtb \
> +	sun6i-a31s-sinovoip-bpi-m2.dtb \
> +	sun6i-a31s-yones-toptech-bs1078-v2.dtb
> +dtb-$(CONFIG_MACH_SUN7I) += \
> +	sun7i-a20-bananapi.dtb \
> +	sun7i-a20-bananapi-m1-plus.dtb \
> +	sun7i-a20-bananapro.dtb \
> +	sun7i-a20-cubieboard2.dtb \
> +	sun7i-a20-cubietruck.dtb \
> +	sun7i-a20-haoyu-marsboard.dtb \
> +	sun7i-a20-hummingbird.dtb \
> +	sun7i-a20-itead-ibox.dtb \
> +	sun7i-a20-i12-tvbox.dtb \
> +	sun7i-a20-icnova-swac.dtb \
> +	sun7i-a20-lamobo-r1.dtb \
> +	sun7i-a20-linutronix-testbox-v2.dtb \
> +	sun7i-a20-m3.dtb \
> +	sun7i-a20-mk808c.dtb \
> +	sun7i-a20-olimex-som-evb.dtb \
> +	sun7i-a20-olimex-som-evb-emmc.dtb \
> +	sun7i-a20-olimex-som204-evb.dtb \
> +	sun7i-a20-olimex-som204-evb-emmc.dtb \
> +	sun7i-a20-olinuxino-lime.dtb \
> +	sun7i-a20-olinuxino-lime-emmc.dtb \
> +	sun7i-a20-olinuxino-lime2.dtb \
> +	sun7i-a20-olinuxino-lime2-emmc.dtb \
> +	sun7i-a20-olinuxino-micro.dtb \
> +	sun7i-a20-olinuxino-micro-emmc.dtb \
> +	sun7i-a20-orangepi.dtb \
> +	sun7i-a20-orangepi-mini.dtb \
> +	sun7i-a20-pcduino3.dtb \
> +	sun7i-a20-pcduino3-nano.dtb \
> +	sun7i-a20-wexler-tab7200.dtb \
> +	sun7i-a20-wits-pro-a20-dkt.dtb
> +dtb-$(CONFIG_MACH_SUN8I) += \
> +	sun8i-a23-evb.dtb \
> +	sun8i-a23-gt90h-v4.dtb \
> +	sun8i-a23-inet86dz.dtb \
> +	sun8i-a23-ippo-q8h-v5.dtb \
> +	sun8i-a23-ippo-q8h-v1.2.dtb \
> +	sun8i-a23-polaroid-mid2407pxe03.dtb \
> +	sun8i-a23-polaroid-mid2809pxe04.dtb \
> +	sun8i-a23-q8-tablet.dtb \
> +	sun8i-a33-et-q8-v1.6.dtb \
> +	sun8i-a33-ga10h-v1.1.dtb \
> +	sun8i-a33-inet-d978-rev2.dtb \
> +	sun8i-a33-ippo-q8h-v1.2.dtb \
> +	sun8i-a33-olinuxino.dtb \
> +	sun8i-a33-q8-tablet.dtb \
> +	sun8i-a33-sinlinx-sina33.dtb \
> +	sun8i-a83t-allwinner-h8homlet-v2.dtb \
> +	sun8i-a83t-bananapi-m3.dtb \
> +	sun8i-a83t-cubietruck-plus.dtb \
> +	sun8i-a83t-tbs-a711.dtb \
> +	sun8i-h2-plus-bananapi-m2-zero.dtb \
> +	sun8i-h2-plus-libretech-all-h3-cc.dtb \
> +	sun8i-h2-plus-orangepi-r1.dtb \
> +	sun8i-h2-plus-orangepi-zero.dtb \
> +	sun8i-h3-bananapi-m2-plus.dtb \
> +	sun8i-h3-bananapi-m2-plus-v1.2.dtb \
> +	sun8i-h3-beelink-x2.dtb \
> +	sun8i-h3-libretech-all-h3-cc.dtb \
> +	sun8i-h3-mapleboard-mp130.dtb \
> +	sun8i-h3-nanopi-duo2.dtb \
> +	sun8i-h3-nanopi-m1.dtb\
> +	\

Some minor mishap here, but doesn't affect the functionality. Could be
even fixed with a follow up patch, to avoid touching this patch again.

I compared all sunxi .dtb files before and after: they were identical.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> +	sun8i-h3-nanopi-m1-plus.dtb \
> +	sun8i-h3-nanopi-neo.dtb \
> +	sun8i-h3-nanopi-neo-air.dtb \

