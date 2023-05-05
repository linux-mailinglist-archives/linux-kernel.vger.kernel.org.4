Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A0B6F7B8D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 05:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEEDaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 23:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjEED37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 23:29:59 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714DC14349;
        Thu,  4 May 2023 20:29:48 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3908c252609so738186b6e.1;
        Thu, 04 May 2023 20:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683257387; x=1685849387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1NMv8PxSP01dXj0x5XRRpwmH0Ujn0ilWXODaTAKVIs=;
        b=TLnXSDADy0F77XdKq1siGuVVw76BjSpqMlInEwKLY+8BG+1CZaj35G+4BWxRASqbHR
         SEcOTzzrn3wE27hHIvdQlcB/6YW1jXVkw0Rt79vwrXHFRqxEFHGfaT1XtMYrkhOvhpik
         r11vIFb3u3tUvV/JAo6uNdUKGzprTaScyv1dW6ydTHukQEmucI9tyq2ZWMW2Q7JYTV4L
         49rZWkGcwQ5ajyfjP10XIKZBDXLLxCOqygsGIhBRVKSsv0pz8OAJlaTzjkdqWjIrnRa6
         c/MRc8pKBgSIVHv8y6aJl0Gf9H074+kVe1hbXMLi0Ae4n/xZC3Q/VWhlfGdqK87OAEa1
         eOFA==
X-Gm-Message-State: AC+VfDxcJhrPKSTJLxYAE9qDyQ67MGeXGtpKaRDIAWE/GVL7AVYE/B1b
        hQHHfXyfZWQKV/oXnyIIwQ==
X-Google-Smtp-Source: ACHHUZ78T3zuaKKdeBwj4Y8da+uxLcdxkxyz+6x3Sj/YoCkyk2njIh4H7d2XpDvsrFy6jTHmhdtmZw==
X-Received: by 2002:a05:6808:1281:b0:38c:647b:e298 with SMTP id a1-20020a056808128100b0038c647be298mr3035948oiw.14.1683257386328;
        Thu, 04 May 2023 20:29:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l9-20020a544109000000b0039083786de1sm2271873oic.21.2023.05.04.20.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 20:29:44 -0700 (PDT)
Received: (nullmailer pid 1056852 invoked by uid 1000);
        Fri, 05 May 2023 03:29:31 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 04 May 2023 22:29:29 -0500
Subject: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
In-Reply-To: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
To:     soc@kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
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
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
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
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
X-Mailer: b4 0.13-dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm dts directory has grown to 1553 boards which makes it a bit
unwieldy to maintain and use. Past attempts stalled out due to plans to
move .dts files out of the kernel tree. Doing that is no longer planned
(any time soon at least), so let's go ahead and group .dts files by
vendors. This move aligns arm with arm64 .dts file structure.

Doing this enables building subsets of dts files by vendor easily
without changing kernel configs:

make allyesconfig
make arch/arm/boot/dts/ti/

There's no change to dtbs_install as the flat structure is maintained on
install.

The naming of vendor directories is roughly in this order of preference:
- Matching original and current SoC vendor prefix/name (e.g. ti, qcom)
- Current vendor prefix/name if still actively sold (SoCs which have
  been aquired) (e.g. nxp/imx)
- Existing platform name for older platforms not sold/maintained by any
  company (e.g. gemini, nspire)

The whole move was scripted with the exception of MAINTAINERS.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 MAINTAINERS                                        |  181 +--
 arch/arm/boot/dts/Makefile                         | 1719 +-------------------
 arch/arm/boot/dts/actions/Makefile                 |    7 +
 .../dts/{ => actions}/owl-s500-cubieboard6.dts     |    0
 .../dts/{ => actions}/owl-s500-guitar-bb-rev-b.dts |    0
 .../boot/dts/{ => actions}/owl-s500-guitar.dtsi    |    0
 .../dts/{ => actions}/owl-s500-labrador-base-m.dts |    0
 .../dts/{ => actions}/owl-s500-labrador-v2.dtsi    |    0
 .../dts/{ => actions}/owl-s500-roseapplepi.dts     |    0
 .../arm/boot/dts/{ => actions}/owl-s500-sparky.dts |    0
 arch/arm/boot/dts/{ => actions}/owl-s500.dtsi      |    0
 arch/arm/boot/dts/airoha/Makefile                  |    3 +
 arch/arm/boot/dts/{ => airoha}/en7523-evb.dts      |    0
 arch/arm/boot/dts/{ => airoha}/en7523.dtsi         |    0
 arch/arm/boot/dts/allwinner/Makefile               |  159 ++
 arch/arm/boot/dts/{ => allwinner}/axp152.dtsi      |    0
 arch/arm/boot/dts/{ => allwinner}/axp209.dtsi      |    0
 arch/arm/boot/dts/{ => allwinner}/axp223.dtsi      |    0
 arch/arm/boot/dts/{ => allwinner}/axp22x.dtsi      |    0
 arch/arm/boot/dts/{ => allwinner}/axp809.dtsi      |    0
 arch/arm/boot/dts/{ => allwinner}/axp81x.dtsi      |    0
 .../boot/dts/{ => allwinner}/sun4i-a10-a1000.dts   |    0
 .../dts/{ => allwinner}/sun4i-a10-ba10-tvbox.dts   |    0
 .../{ => allwinner}/sun4i-a10-chuwi-v7-cw0825.dts  |    0
 .../dts/{ => allwinner}/sun4i-a10-cubieboard.dts   |    0
 .../{ => allwinner}/sun4i-a10-dserve-dsrv9703c.dts |    0
 .../dts/{ => allwinner}/sun4i-a10-gemei-g9.dts     |    0
 .../dts/{ => allwinner}/sun4i-a10-hackberry.dts    |    0
 .../dts/{ => allwinner}/sun4i-a10-hyundai-a7hd.dts |    0
 .../boot/dts/{ => allwinner}/sun4i-a10-inet1.dts   |    0
 .../dts/{ => allwinner}/sun4i-a10-inet97fv2.dts    |    0
 .../dts/{ => allwinner}/sun4i-a10-inet9f-rev03.dts |    0
 .../sun4i-a10-itead-iteaduino-plus.dts             |    0
 .../dts/{ => allwinner}/sun4i-a10-jesurun-q5.dts   |    0
 .../dts/{ => allwinner}/sun4i-a10-marsboard.dts    |    0
 .../dts/{ => allwinner}/sun4i-a10-mini-xplus.dts   |    0
 .../boot/dts/{ => allwinner}/sun4i-a10-mk802.dts   |    0
 .../boot/dts/{ => allwinner}/sun4i-a10-mk802ii.dts |    0
 .../{ => allwinner}/sun4i-a10-olinuxino-lime.dts   |    0
 .../boot/dts/{ => allwinner}/sun4i-a10-pcduino.dts |    0
 .../dts/{ => allwinner}/sun4i-a10-pcduino2.dts     |    0
 .../{ => allwinner}/sun4i-a10-pov-protab2-ips9.dts |    0
 .../dts/{ => allwinner}/sun4i-a10-topwise-a721.dts |    0
 arch/arm/boot/dts/{ => allwinner}/sun4i-a10.dtsi   |    0
 .../dts/{ => allwinner}/sun5i-a10s-auxtek-t003.dts |    0
 .../dts/{ => allwinner}/sun5i-a10s-auxtek-t004.dts |    0
 .../boot/dts/{ => allwinner}/sun5i-a10s-mk802.dts  |    0
 .../{ => allwinner}/sun5i-a10s-olinuxino-micro.dts |    0
 .../{ => allwinner}/sun5i-a10s-r7-tv-dongle.dts    |    0
 .../dts/{ => allwinner}/sun5i-a10s-wobo-i5.dts     |    0
 arch/arm/boot/dts/{ => allwinner}/sun5i-a10s.dtsi  |    0
 .../{ => allwinner}/sun5i-a13-difrnce-dit4350.dts  |    0
 .../sun5i-a13-empire-electronix-d709.dts           |    0
 .../sun5i-a13-empire-electronix-m712.dts           |    0
 .../dts/{ => allwinner}/sun5i-a13-hsg-h702.dts     |    0
 .../{ => allwinner}/sun5i-a13-inet-98v-rev2.dts    |    0
 .../dts/{ => allwinner}/sun5i-a13-licheepi-one.dts |    0
 .../{ => allwinner}/sun5i-a13-olinuxino-micro.dts  |    0
 .../dts/{ => allwinner}/sun5i-a13-olinuxino.dts    |    0
 .../sun5i-a13-pocketbook-touch-lux-3.dts           |    0
 .../dts/{ => allwinner}/sun5i-a13-q8-tablet.dts    |    0
 .../dts/{ => allwinner}/sun5i-a13-utoo-p66.dts     |    0
 arch/arm/boot/dts/{ => allwinner}/sun5i-a13.dtsi   |    0
 .../dts/{ => allwinner}/sun5i-gr8-chip-pro.dts     |    0
 .../arm/boot/dts/{ => allwinner}/sun5i-gr8-evb.dts |    0
 arch/arm/boot/dts/{ => allwinner}/sun5i-gr8.dtsi   |    0
 .../arm/boot/dts/{ => allwinner}/sun5i-r8-chip.dts |    0
 arch/arm/boot/dts/{ => allwinner}/sun5i-r8.dtsi    |    0
 .../sun5i-reference-design-tablet.dtsi             |    0
 arch/arm/boot/dts/{ => allwinner}/sun5i.dtsi       |    0
 .../dts/{ => allwinner}/sun6i-a31-app4-evb1.dts    |    0
 .../dts/{ => allwinner}/sun6i-a31-colombus.dts     |    0
 .../dts/{ => allwinner}/sun6i-a31-hummingbird.dts  |    0
 arch/arm/boot/dts/{ => allwinner}/sun6i-a31-i7.dts |    0
 arch/arm/boot/dts/{ => allwinner}/sun6i-a31-m9.dts |    0
 .../{ => allwinner}/sun6i-a31-mele-a1000g-quad.dts |    0
 arch/arm/boot/dts/{ => allwinner}/sun6i-a31.dtsi   |    0
 .../sun6i-a31s-colorfly-e708-q1.dts                |    0
 .../boot/dts/{ => allwinner}/sun6i-a31s-cs908.dts  |    0
 .../dts/{ => allwinner}/sun6i-a31s-inet-q972.dts   |    0
 .../dts/{ => allwinner}/sun6i-a31s-primo81.dts     |    0
 .../{ => allwinner}/sun6i-a31s-sina31s-core.dtsi   |    0
 .../dts/{ => allwinner}/sun6i-a31s-sina31s.dts     |    0
 .../{ => allwinner}/sun6i-a31s-sinovoip-bpi-m2.dts |    0
 .../sun6i-a31s-yones-toptech-bs1078-v2.dts         |    0
 arch/arm/boot/dts/{ => allwinner}/sun6i-a31s.dtsi  |    0
 .../sun6i-reference-design-tablet.dtsi             |    0
 .../{ => allwinner}/sun7i-a20-bananapi-m1-plus.dts |    0
 .../dts/{ => allwinner}/sun7i-a20-bananapi.dts     |    0
 .../dts/{ => allwinner}/sun7i-a20-bananapro.dts    |    0
 .../dts/{ => allwinner}/sun7i-a20-cubieboard2.dts  |    0
 .../dts/{ => allwinner}/sun7i-a20-cubietruck.dts   |    0
 .../{ => allwinner}/sun7i-a20-haoyu-marsboard.dts  |    0
 .../dts/{ => allwinner}/sun7i-a20-hummingbird.dts  |    0
 .../dts/{ => allwinner}/sun7i-a20-i12-tvbox.dts    |    0
 .../dts/{ => allwinner}/sun7i-a20-icnova-swac.dts  |    0
 .../dts/{ => allwinner}/sun7i-a20-itead-ibox.dts   |    0
 .../dts/{ => allwinner}/sun7i-a20-lamobo-r1.dts    |    0
 .../sun7i-a20-linutronix-testbox-v2.dts            |    0
 arch/arm/boot/dts/{ => allwinner}/sun7i-a20-m3.dts |    0
 .../boot/dts/{ => allwinner}/sun7i-a20-mk808c.dts  |    0
 .../sun7i-a20-olimex-som-evb-emmc.dts              |    0
 .../{ => allwinner}/sun7i-a20-olimex-som-evb.dts   |    0
 .../sun7i-a20-olimex-som204-evb-emmc.dts           |    0
 .../sun7i-a20-olimex-som204-evb.dts                |    0
 .../sun7i-a20-olinuxino-lime-emmc.dts              |    0
 .../{ => allwinner}/sun7i-a20-olinuxino-lime.dts   |    0
 .../sun7i-a20-olinuxino-lime2-emmc.dts             |    0
 .../{ => allwinner}/sun7i-a20-olinuxino-lime2.dts  |    0
 .../sun7i-a20-olinuxino-micro-emmc.dts             |    0
 .../{ => allwinner}/sun7i-a20-olinuxino-micro.dts  |    0
 .../{ => allwinner}/sun7i-a20-orangepi-mini.dts    |    0
 .../dts/{ => allwinner}/sun7i-a20-orangepi.dts     |    0
 .../{ => allwinner}/sun7i-a20-pcduino3-nano.dts    |    0
 .../dts/{ => allwinner}/sun7i-a20-pcduino3.dts     |    0
 .../{ => allwinner}/sun7i-a20-wexler-tab7200.dts   |    0
 .../{ => allwinner}/sun7i-a20-wits-pro-a20-dkt.dts |    0
 arch/arm/boot/dts/{ => allwinner}/sun7i-a20.dtsi   |    0
 .../boot/dts/{ => allwinner}/sun8i-a23-a33.dtsi    |    0
 .../arm/boot/dts/{ => allwinner}/sun8i-a23-evb.dts |    0
 .../dts/{ => allwinner}/sun8i-a23-gt90h-v4.dts     |    0
 .../dts/{ => allwinner}/sun8i-a23-inet86dz.dts     |    0
 .../{ => allwinner}/sun8i-a23-ippo-q8h-v1.2.dts    |    0
 .../dts/{ => allwinner}/sun8i-a23-ippo-q8h-v5.dts  |    0
 .../sun8i-a23-polaroid-mid2407pxe03.dts            |    0
 .../sun8i-a23-polaroid-mid2809pxe04.dts            |    0
 .../dts/{ => allwinner}/sun8i-a23-q8-tablet.dts    |    0
 arch/arm/boot/dts/{ => allwinner}/sun8i-a23.dtsi   |    0
 .../dts/{ => allwinner}/sun8i-a33-et-q8-v1.6.dts   |    0
 .../dts/{ => allwinner}/sun8i-a33-ga10h-v1.1.dts   |    0
 .../{ => allwinner}/sun8i-a33-inet-d978-rev2.dts   |    0
 .../{ => allwinner}/sun8i-a33-ippo-q8h-v1.2.dts    |    0
 .../dts/{ => allwinner}/sun8i-a33-olinuxino.dts    |    0
 .../dts/{ => allwinner}/sun8i-a33-q8-tablet.dts    |    0
 .../{ => allwinner}/sun8i-a33-sinlinx-sina33.dts   |    0
 arch/arm/boot/dts/{ => allwinner}/sun8i-a33.dtsi   |    0
 .../sun8i-a83t-allwinner-h8homlet-v2.dts           |    0
 .../dts/{ => allwinner}/sun8i-a83t-bananapi-m3.dts |    0
 .../{ => allwinner}/sun8i-a83t-cubietruck-plus.dts |    0
 .../dts/{ => allwinner}/sun8i-a83t-tbs-a711.dts    |    0
 arch/arm/boot/dts/{ => allwinner}/sun8i-a83t.dtsi  |    0
 .../sun8i-h2-plus-bananapi-m2-zero.dts             |    0
 .../sun8i-h2-plus-libretech-all-h3-cc.dts          |    0
 .../{ => allwinner}/sun8i-h2-plus-orangepi-r1.dts  |    0
 .../sun8i-h2-plus-orangepi-zero.dts                |    0
 .../sun8i-h3-bananapi-m2-plus-v1.2.dts             |    0
 .../{ => allwinner}/sun8i-h3-bananapi-m2-plus.dts  |    0
 .../dts/{ => allwinner}/sun8i-h3-beelink-x2.dts    |    0
 .../sun8i-h3-emlid-neutis-n5h3-devboard.dts        |    0
 .../sun8i-h3-emlid-neutis-n5h3.dtsi                |    0
 .../sun8i-h3-libretech-all-h3-cc.dts               |    0
 .../{ => allwinner}/sun8i-h3-mapleboard-mp130.dts  |    0
 .../dts/{ => allwinner}/sun8i-h3-nanopi-duo2.dts   |    0
 .../{ => allwinner}/sun8i-h3-nanopi-m1-plus.dts    |    0
 .../dts/{ => allwinner}/sun8i-h3-nanopi-m1.dts     |    0
 .../{ => allwinner}/sun8i-h3-nanopi-neo-air.dts    |    0
 .../dts/{ => allwinner}/sun8i-h3-nanopi-neo.dts    |    0
 .../dts/{ => allwinner}/sun8i-h3-nanopi-r1.dts     |    0
 .../boot/dts/{ => allwinner}/sun8i-h3-nanopi.dtsi  |    0
 .../dts/{ => allwinner}/sun8i-h3-orangepi-2.dts    |    0
 .../dts/{ => allwinner}/sun8i-h3-orangepi-lite.dts |    0
 .../dts/{ => allwinner}/sun8i-h3-orangepi-one.dts  |    0
 .../{ => allwinner}/sun8i-h3-orangepi-pc-plus.dts  |    0
 .../dts/{ => allwinner}/sun8i-h3-orangepi-pc.dts   |    0
 .../dts/{ => allwinner}/sun8i-h3-orangepi-plus.dts |    0
 .../{ => allwinner}/sun8i-h3-orangepi-plus2e.dts   |    0
 .../sun8i-h3-orangepi-zero-plus2.dts               |    0
 .../dts/{ => allwinner}/sun8i-h3-rervision-dvk.dts |    0
 .../boot/dts/{ => allwinner}/sun8i-h3-zeropi.dts   |    0
 arch/arm/boot/dts/{ => allwinner}/sun8i-h3.dtsi    |    0
 .../boot/dts/{ => allwinner}/sun8i-q8-common.dtsi  |    0
 .../dts/{ => allwinner}/sun8i-r16-bananapi-m2m.dts |    0
 .../sun8i-r16-nintendo-nes-classic.dts             |    0
 .../sun8i-r16-nintendo-super-nes-classic.dts       |    0
 .../boot/dts/{ => allwinner}/sun8i-r16-parrot.dts  |    0
 .../sun8i-r40-bananapi-m2-ultra.dts                |    0
 .../dts/{ => allwinner}/sun8i-r40-cpu-opp.dtsi     |    0
 .../dts/{ => allwinner}/sun8i-r40-feta40i.dtsi     |    0
 .../dts/{ => allwinner}/sun8i-r40-oka40i-c.dts     |    0
 arch/arm/boot/dts/{ => allwinner}/sun8i-r40.dtsi   |    0
 .../sun8i-reference-design-tablet.dtsi             |    0
 .../{ => allwinner}/sun8i-s3-elimo-impetus.dtsi    |    0
 .../dts/{ => allwinner}/sun8i-s3-elimo-initium.dts |    0
 .../{ => allwinner}/sun8i-s3-lichee-zero-plus.dts  |    0
 .../boot/dts/{ => allwinner}/sun8i-s3-pinecube.dts |    0
 .../sun8i-t113s-mangopi-mq-r-t113.dts              |    0
 arch/arm/boot/dts/{ => allwinner}/sun8i-t113s.dtsi |    0
 .../dts/{ => allwinner}/sun8i-t3-cqa3t-bv3.dts     |    0
 .../dts/{ => allwinner}/sun8i-v3-sl631-imx179.dts  |    0
 .../boot/dts/{ => allwinner}/sun8i-v3-sl631.dtsi   |    0
 arch/arm/boot/dts/{ => allwinner}/sun8i-v3.dtsi    |    0
 .../sun8i-v3s-licheepi-zero-dock.dts               |    0
 .../{ => allwinner}/sun8i-v3s-licheepi-zero.dts    |    0
 arch/arm/boot/dts/{ => allwinner}/sun8i-v3s.dtsi   |    0
 .../sun8i-v40-bananapi-m2-berry.dts                |    0
 .../dts/{ => allwinner}/sun9i-a80-cubieboard4.dts  |    0
 .../boot/dts/{ => allwinner}/sun9i-a80-optimus.dts |    0
 arch/arm/boot/dts/{ => allwinner}/sun9i-a80.dtsi   |    0
 .../suniv-f1c100s-licheepi-nano.dts                |    0
 .../boot/dts/{ => allwinner}/suniv-f1c100s.dtsi    |    0
 .../{ => allwinner}/suniv-f1c200s-lctech-pi.dts    |    0
 .../suniv-f1c200s-popstick-v1.1.dts                |    0
 .../sunxi-bananapi-m2-plus-v1.2.dtsi               |    0
 .../{ => allwinner}/sunxi-bananapi-m2-plus.dtsi    |    0
 .../{ => allwinner}/sunxi-common-regulators.dtsi   |    0
 .../sunxi-d1s-t113-mangopi-mq-r.dtsi               |    0
 .../{ => allwinner}/sunxi-h3-h5-emlid-neutis.dtsi  |    0
 arch/arm/boot/dts/{ => allwinner}/sunxi-h3-h5.dtsi |    0
 .../{ => allwinner}/sunxi-itead-core-common.dtsi   |    0
 .../{ => allwinner}/sunxi-libretech-all-h3-cc.dtsi |    0
 .../{ => allwinner}/sunxi-libretech-all-h3-it.dtsi |    0
 .../sunxi-reference-design-tablet.dtsi             |    0
 arch/arm/boot/dts/alphascale/Makefile              |    3 +
 .../{ => alphascale}/alphascale-asm9260-devkit.dts |    0
 .../dts/{ => alphascale}/alphascale-asm9260.dtsi   |    0
 arch/arm/boot/dts/amazon/Makefile                  |    3 +
 arch/arm/boot/dts/{ => amazon}/alpine-db.dts       |    0
 arch/arm/boot/dts/{ => amazon}/alpine.dtsi         |    0
 arch/arm/boot/dts/amlogic/Makefile                 |    9 +
 arch/arm/boot/dts/{ => amlogic}/meson.dtsi         |    0
 arch/arm/boot/dts/{ => amlogic}/meson6-atv1200.dts |    0
 arch/arm/boot/dts/{ => amlogic}/meson6.dtsi        |    0
 .../boot/dts/{ => amlogic}/meson8-minix-neo-x8.dts |    0
 arch/arm/boot/dts/{ => amlogic}/meson8.dtsi        |    0
 arch/arm/boot/dts/{ => amlogic}/meson8b-ec100.dts  |    0
 arch/arm/boot/dts/{ => amlogic}/meson8b-mxq.dts    |    0
 .../boot/dts/{ => amlogic}/meson8b-odroidc1.dts    |    0
 arch/arm/boot/dts/{ => amlogic}/meson8b.dtsi       |    0
 .../boot/dts/{ => amlogic}/meson8m2-mxiii-plus.dts |    0
 arch/arm/boot/dts/{ => amlogic}/meson8m2.dtsi      |    0
 arch/arm/boot/dts/arm/Makefile                     |   30 +
 .../arm-realview-eb-11mp-bbrevd-ctrevb.dts         |    0
 .../dts/{ => arm}/arm-realview-eb-11mp-bbrevd.dts  |    0
 .../dts/{ => arm}/arm-realview-eb-11mp-ctrevb.dts  |    0
 .../boot/dts/{ => arm}/arm-realview-eb-11mp.dts    |    0
 .../dts/{ => arm}/arm-realview-eb-a9mp-bbrevd.dts  |    0
 .../boot/dts/{ => arm}/arm-realview-eb-a9mp.dts    |    0
 .../boot/dts/{ => arm}/arm-realview-eb-bbrevd.dts  |    0
 .../boot/dts/{ => arm}/arm-realview-eb-bbrevd.dtsi |    0
 .../arm/boot/dts/{ => arm}/arm-realview-eb-mp.dtsi |    0
 arch/arm/boot/dts/{ => arm}/arm-realview-eb.dts    |    0
 arch/arm/boot/dts/{ => arm}/arm-realview-eb.dtsi   |    0
 .../arm/boot/dts/{ => arm}/arm-realview-pb1176.dts |    0
 .../arm/boot/dts/{ => arm}/arm-realview-pb11mp.dts |    0
 arch/arm/boot/dts/{ => arm}/arm-realview-pba8.dts  |    0
 .../arm/boot/dts/{ => arm}/arm-realview-pbx-a9.dts |    0
 arch/arm/boot/dts/{ => arm}/arm-realview-pbx.dtsi  |    0
 arch/arm/boot/dts/{ => arm}/integrator.dtsi        |    0
 .../arm/boot/dts/{ => arm}/integratorap-im-pd1.dts |    0
 arch/arm/boot/dts/{ => arm}/integratorap.dts       |    0
 arch/arm/boot/dts/{ => arm}/integratorcp.dts       |    0
 arch/arm/boot/dts/{ => arm}/mps2-an385.dts         |    0
 arch/arm/boot/dts/{ => arm}/mps2-an399.dts         |    0
 arch/arm/boot/dts/{ => arm}/mps2.dtsi              |    2 +-
 arch/arm/boot/dts/{ => arm}/versatile-ab-ib2.dts   |    0
 arch/arm/boot/dts/{ => arm}/versatile-ab.dts       |    0
 arch/arm/boot/dts/{ => arm}/versatile-pb.dts       |    0
 arch/arm/boot/dts/{ => arm}/vexpress-v2m-rs1.dtsi  |    0
 arch/arm/boot/dts/{ => arm}/vexpress-v2m.dtsi      |    0
 .../boot/dts/{ => arm}/vexpress-v2p-ca15-tc1.dts   |    0
 .../boot/dts/{ => arm}/vexpress-v2p-ca15_a7.dts    |    0
 arch/arm/boot/dts/{ => arm}/vexpress-v2p-ca5s.dts  |    0
 arch/arm/boot/dts/{ => arm}/vexpress-v2p-ca9.dts   |    0
 arch/arm/boot/dts/aspeed/Makefile                  |   62 +
 .../boot/dts/{ => aspeed}/aspeed-ast2500-evb.dts   |    0
 .../dts/{ => aspeed}/aspeed-ast2600-evb-a1.dts     |    0
 .../boot/dts/{ => aspeed}/aspeed-ast2600-evb.dts   |    0
 .../dts/{ => aspeed}/aspeed-bmc-amd-daytonax.dts   |    0
 .../dts/{ => aspeed}/aspeed-bmc-amd-ethanolx.dts   |    0
 .../dts/{ => aspeed}/aspeed-bmc-ampere-mtjade.dts  |    0
 .../{ => aspeed}/aspeed-bmc-ampere-mtmitchell.dts  |    0
 .../aspeed-bmc-arm-stardragon4800-rep2.dts         |    0
 .../{ => aspeed}/aspeed-bmc-asrock-e3c246d4i.dts   |    0
 .../{ => aspeed}/aspeed-bmc-asrock-romed8hm3.dts   |    0
 .../{ => aspeed}/aspeed-bmc-bytedance-g220a.dts    |    0
 .../dts/{ => aspeed}/aspeed-bmc-delta-ahe50dc.dts  |    0
 .../{ => aspeed}/aspeed-bmc-facebook-bletchley.dts |    0
 .../aspeed-bmc-facebook-cloudripper.dts            |    0
 .../dts/{ => aspeed}/aspeed-bmc-facebook-cmm.dts   |    0
 .../{ => aspeed}/aspeed-bmc-facebook-elbert.dts    |    0
 .../dts/{ => aspeed}/aspeed-bmc-facebook-fuji.dts  |    0
 .../{ => aspeed}/aspeed-bmc-facebook-galaxy100.dts |    0
 .../aspeed-bmc-facebook-greatlakes.dts             |    0
 .../{ => aspeed}/aspeed-bmc-facebook-minipack.dts  |    0
 .../{ => aspeed}/aspeed-bmc-facebook-tiogapass.dts |    0
 .../{ => aspeed}/aspeed-bmc-facebook-wedge100.dts  |    0
 .../{ => aspeed}/aspeed-bmc-facebook-wedge40.dts   |    0
 .../{ => aspeed}/aspeed-bmc-facebook-wedge400.dts  |    0
 .../dts/{ => aspeed}/aspeed-bmc-facebook-yamp.dts  |    0
 .../aspeed-bmc-facebook-yosemitev2.dts             |    0
 .../dts/{ => aspeed}/aspeed-bmc-ibm-bonnell.dts    |    0
 .../dts/{ => aspeed}/aspeed-bmc-ibm-everest.dts    |    0
 .../{ => aspeed}/aspeed-bmc-ibm-rainier-1s4u.dts   |    0
 .../dts/{ => aspeed}/aspeed-bmc-ibm-rainier-4u.dts |    0
 .../dts/{ => aspeed}/aspeed-bmc-ibm-rainier.dts    |    0
 .../{ => aspeed}/aspeed-bmc-inspur-fp5280g2.dts    |    0
 .../{ => aspeed}/aspeed-bmc-inspur-nf5280m6.dts    |    0
 .../{ => aspeed}/aspeed-bmc-inspur-on5263m5.dts    |    0
 .../dts/{ => aspeed}/aspeed-bmc-intel-s2600wf.dts  |    0
 .../aspeed-bmc-inventec-transformers.dts           |    0
 .../dts/{ => aspeed}/aspeed-bmc-lenovo-hr630.dts   |    0
 .../{ => aspeed}/aspeed-bmc-lenovo-hr855xg2.dts    |    0
 .../{ => aspeed}/aspeed-bmc-microsoft-olympus.dts  |    0
 .../dts/{ => aspeed}/aspeed-bmc-opp-lanyang.dts    |    0
 .../dts/{ => aspeed}/aspeed-bmc-opp-mowgli.dts     |    0
 .../dts/{ => aspeed}/aspeed-bmc-opp-nicole.dts     |    0
 .../dts/{ => aspeed}/aspeed-bmc-opp-palmetto.dts   |    0
 .../dts/{ => aspeed}/aspeed-bmc-opp-romulus.dts    |    0
 .../boot/dts/{ => aspeed}/aspeed-bmc-opp-swift.dts |    0
 .../dts/{ => aspeed}/aspeed-bmc-opp-tacoma.dts     |    0
 .../dts/{ => aspeed}/aspeed-bmc-opp-vesnin.dts     |    0
 .../{ => aspeed}/aspeed-bmc-opp-witherspoon.dts    |    0
 .../boot/dts/{ => aspeed}/aspeed-bmc-opp-zaius.dts |    0
 .../{ => aspeed}/aspeed-bmc-portwell-neptune.dts   |    0
 .../dts/{ => aspeed}/aspeed-bmc-qcom-dc-scm-v1.dts |    0
 .../dts/{ => aspeed}/aspeed-bmc-quanta-q71l.dts    |    0
 .../dts/{ => aspeed}/aspeed-bmc-quanta-s6q.dts     |    0
 .../{ => aspeed}/aspeed-bmc-supermicro-x11spi.dts  |    0
 .../dts/{ => aspeed}/aspeed-bmc-tyan-s7106.dts     |    0
 .../dts/{ => aspeed}/aspeed-bmc-tyan-s8036.dts     |    0
 .../{ => aspeed}/aspeed-bmc-ufispace-ncplite.dts   |    0
 .../dts/{ => aspeed}/aspeed-bmc-vegman-n110.dts    |    0
 .../dts/{ => aspeed}/aspeed-bmc-vegman-rx20.dts    |    0
 .../dts/{ => aspeed}/aspeed-bmc-vegman-sx20.dts    |    0
 .../boot/dts/{ => aspeed}/aspeed-bmc-vegman.dtsi   |    0
 arch/arm/boot/dts/{ => aspeed}/aspeed-g4.dtsi      |    0
 arch/arm/boot/dts/{ => aspeed}/aspeed-g5.dtsi      |    0
 .../boot/dts/{ => aspeed}/aspeed-g6-pinctrl.dtsi   |    0
 arch/arm/boot/dts/{ => aspeed}/aspeed-g6.dtsi      |    0
 .../ast2400-facebook-netbmc-common.dtsi            |    0
 .../ast2500-facebook-netbmc-common.dtsi            |    0
 .../ast2600-facebook-netbmc-common.dtsi            |    0
 .../facebook-bmc-flash-layout-128.dtsi             |    0
 .../{ => aspeed}/facebook-bmc-flash-layout.dtsi    |    0
 .../arm/boot/dts/{ => aspeed}/ibm-power9-dual.dtsi |    0
 .../dts/{ => aspeed}/openbmc-flash-layout-128.dtsi |    0
 .../{ => aspeed}/openbmc-flash-layout-64-alt.dtsi  |    0
 .../dts/{ => aspeed}/openbmc-flash-layout-64.dtsi  |    0
 .../dts/{ => aspeed}/openbmc-flash-layout.dtsi     |    0
 arch/arm/boot/dts/axis/Makefile                    |    3 +
 arch/arm/boot/dts/{ => axis}/artpec6-devboard.dts  |    0
 arch/arm/boot/dts/{ => axis}/artpec6.dtsi          |    0
 arch/arm/boot/dts/broadcom/Makefile                |  107 ++
 .../boot/dts/{ => broadcom}/bcm-cygnus-clock.dtsi  |    0
 arch/arm/boot/dts/{ => broadcom}/bcm-cygnus.dtsi   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm-hr2.dtsi      |    0
 arch/arm/boot/dts/{ => broadcom}/bcm-nsp-ax.dtsi   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm-nsp.dtsi      |    0
 arch/arm/boot/dts/{ => broadcom}/bcm11351.dtsi     |    0
 .../boot/dts/{ => broadcom}/bcm21664-garnet.dts    |    0
 arch/arm/boot/dts/{ => broadcom}/bcm21664.dtsi     |    0
 .../boot/dts/{ => broadcom}/bcm23550-sparrow.dts   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm23550.dtsi     |    0
 .../boot/dts/{ => broadcom}/bcm2711-rpi-4-b.dts    |    0
 .../boot/dts/{ => broadcom}/bcm2711-rpi-400.dts    |    0
 .../boot/dts/{ => broadcom}/bcm2711-rpi-cm4-io.dts |    0
 .../boot/dts/{ => broadcom}/bcm2711-rpi-cm4.dtsi   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm2711-rpi.dtsi  |    0
 arch/arm/boot/dts/{ => broadcom}/bcm2711.dtsi      |    0
 arch/arm/boot/dts/{ => broadcom}/bcm28155-ap.dts   |    0
 .../boot/dts/{ => broadcom}/bcm2835-common.dtsi    |    0
 .../boot/dts/{ => broadcom}/bcm2835-rpi-a-plus.dts |    0
 arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi-a.dts |    0
 .../boot/dts/{ => broadcom}/bcm2835-rpi-b-plus.dts |    0
 .../boot/dts/{ => broadcom}/bcm2835-rpi-b-rev2.dts |    0
 arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi-b.dts |    0
 .../dts/{ => broadcom}/bcm2835-rpi-cm1-io1.dts     |    0
 .../boot/dts/{ => broadcom}/bcm2835-rpi-cm1.dtsi   |    0
 .../dts/{ => broadcom}/bcm2835-rpi-common.dtsi     |    0
 .../boot/dts/{ => broadcom}/bcm2835-rpi-zero-w.dts |    0
 .../boot/dts/{ => broadcom}/bcm2835-rpi-zero.dts   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi.dtsi  |    0
 arch/arm/boot/dts/{ => broadcom}/bcm2835.dtsi      |    0
 .../boot/dts/{ => broadcom}/bcm2836-rpi-2-b.dts    |    0
 arch/arm/boot/dts/{ => broadcom}/bcm2836-rpi.dtsi  |    0
 arch/arm/boot/dts/{ => broadcom}/bcm2836.dtsi      |    0
 .../dts/{ => broadcom}/bcm2837-rpi-3-a-plus.dts    |    0
 .../dts/{ => broadcom}/bcm2837-rpi-3-b-plus.dts    |    0
 .../boot/dts/{ => broadcom}/bcm2837-rpi-3-b.dts    |    0
 .../dts/{ => broadcom}/bcm2837-rpi-cm3-io3.dts     |    0
 .../boot/dts/{ => broadcom}/bcm2837-rpi-cm3.dtsi   |    0
 .../dts/{ => broadcom}/bcm2837-rpi-zero-2-w.dts    |    0
 arch/arm/boot/dts/{ => broadcom}/bcm2837.dtsi      |    0
 .../dts/{ => broadcom}/bcm283x-rpi-lan7515.dtsi    |    0
 .../{ => broadcom}/bcm283x-rpi-led-deprecated.dtsi |    0
 .../dts/{ => broadcom}/bcm283x-rpi-smsc9512.dtsi   |    0
 .../dts/{ => broadcom}/bcm283x-rpi-smsc9514.dtsi   |    0
 .../dts/{ => broadcom}/bcm283x-rpi-usb-host.dtsi   |    0
 .../dts/{ => broadcom}/bcm283x-rpi-usb-otg.dtsi    |    0
 .../{ => broadcom}/bcm283x-rpi-usb-peripheral.dtsi |    0
 .../dts/{ => broadcom}/bcm283x-rpi-wifi-bt.dtsi    |    0
 arch/arm/boot/dts/{ => broadcom}/bcm283x.dtsi      |    0
 .../dts/{ => broadcom}/bcm4708-asus-rt-ac56u.dts   |    0
 .../dts/{ => broadcom}/bcm4708-asus-rt-ac68u.dts   |    0
 .../bcm4708-buffalo-wzr-1166dhp-common.dtsi        |    0
 .../{ => broadcom}/bcm4708-buffalo-wzr-1166dhp.dts |    0
 .../bcm4708-buffalo-wzr-1166dhp2.dts               |    0
 .../{ => broadcom}/bcm4708-buffalo-wzr-1750dhp.dts |    0
 .../{ => broadcom}/bcm4708-linksys-ea6300-v1.dts   |    0
 .../{ => broadcom}/bcm4708-linksys-ea6500-v2.dts   |    0
 .../dts/{ => broadcom}/bcm4708-luxul-xap-1510.dts  |    0
 .../dts/{ => broadcom}/bcm4708-luxul-xwc-1000.dts  |    0
 .../dts/{ => broadcom}/bcm4708-netgear-r6250.dts   |    0
 .../{ => broadcom}/bcm4708-netgear-r6300-v2.dts    |    0
 .../dts/{ => broadcom}/bcm4708-smartrg-sr400ac.dts |    0
 arch/arm/boot/dts/{ => broadcom}/bcm4708.dtsi      |    0
 .../dts/{ => broadcom}/bcm47081-asus-rt-n18u.dts   |    0
 .../bcm47081-buffalo-wzr-600dhp2.dts               |    0
 .../{ => broadcom}/bcm47081-buffalo-wzr-900dhp.dts |    0
 .../dts/{ => broadcom}/bcm47081-luxul-xap-1410.dts |    0
 .../dts/{ => broadcom}/bcm47081-luxul-xwr-1200.dts |    0
 .../bcm47081-tplink-archer-c5-v2.dts               |    0
 arch/arm/boot/dts/{ => broadcom}/bcm47081.dtsi     |    0
 .../dts/{ => broadcom}/bcm4709-asus-rt-ac87u.dts   |    0
 .../{ => broadcom}/bcm4709-buffalo-wxr-1900dhp.dts |    0
 .../dts/{ => broadcom}/bcm4709-linksys-ea9200.dts  |    0
 .../dts/{ => broadcom}/bcm4709-netgear-r7000.dts   |    0
 .../dts/{ => broadcom}/bcm4709-netgear-r8000.dts   |    0
 .../{ => broadcom}/bcm4709-tplink-archer-c9-v1.dts |    0
 arch/arm/boot/dts/{ => broadcom}/bcm4709.dtsi      |    0
 .../dts/{ => broadcom}/bcm47094-asus-rt-ac88u.dts  |    0
 .../dts/{ => broadcom}/bcm47094-dlink-dir-885l.dts |    0
 .../dts/{ => broadcom}/bcm47094-dlink-dir-890l.dts |    0
 .../{ => broadcom}/bcm47094-linksys-panamera.dts   |    0
 .../dts/{ => broadcom}/bcm47094-luxul-abr-4500.dts |    0
 .../dts/{ => broadcom}/bcm47094-luxul-xap-1610.dts |    0
 .../dts/{ => broadcom}/bcm47094-luxul-xbr-4500.dts |    0
 .../dts/{ => broadcom}/bcm47094-luxul-xwc-2000.dts |    0
 .../dts/{ => broadcom}/bcm47094-luxul-xwr-3100.dts |    0
 .../{ => broadcom}/bcm47094-luxul-xwr-3150-v1.dts  |    0
 .../dts/{ => broadcom}/bcm47094-netgear-r8500.dts  |    0
 .../dts/{ => broadcom}/bcm47094-phicomm-k3.dts     |    0
 arch/arm/boot/dts/{ => broadcom}/bcm47094.dtsi     |    0
 .../dts/{ => broadcom}/bcm47189-luxul-xap-1440.dts |    0
 .../dts/{ => broadcom}/bcm47189-luxul-xap-810.dts  |    0
 .../boot/dts/{ => broadcom}/bcm47189-tenda-ac9.dts |    0
 arch/arm/boot/dts/{ => broadcom}/bcm47622.dtsi     |    0
 .../dts/{ => broadcom}/bcm53015-meraki-mr26.dts    |    0
 .../{ => broadcom}/bcm53016-dlink-dwl-8610ap.dts   |    0
 .../dts/{ => broadcom}/bcm53016-meraki-mr32.dts    |    0
 .../dts/{ => broadcom}/bcm5301x-nand-cs0-bch1.dtsi |    0
 .../dts/{ => broadcom}/bcm5301x-nand-cs0-bch4.dtsi |    0
 .../dts/{ => broadcom}/bcm5301x-nand-cs0-bch8.dtsi |    0
 .../boot/dts/{ => broadcom}/bcm5301x-nand-cs0.dtsi |    0
 arch/arm/boot/dts/{ => broadcom}/bcm5301x.dtsi     |    0
 .../{ => broadcom}/bcm53340-ubnt-unifi-switch8.dts |    0
 arch/arm/boot/dts/{ => broadcom}/bcm53573.dtsi     |    0
 arch/arm/boot/dts/{ => broadcom}/bcm59056.dtsi     |    0
 arch/arm/boot/dts/{ => broadcom}/bcm63138.dtsi     |    0
 arch/arm/boot/dts/{ => broadcom}/bcm63148.dtsi     |    0
 arch/arm/boot/dts/{ => broadcom}/bcm63178.dtsi     |    0
 arch/arm/boot/dts/{ => broadcom}/bcm6756.dtsi      |    0
 arch/arm/boot/dts/{ => broadcom}/bcm6846.dtsi      |    0
 arch/arm/boot/dts/{ => broadcom}/bcm6855.dtsi      |    0
 arch/arm/boot/dts/{ => broadcom}/bcm6878.dtsi      |    0
 .../dts/{ => broadcom}/bcm7445-bcm97445svmb.dts    |    0
 arch/arm/boot/dts/{ => broadcom}/bcm7445.dtsi      |    0
 .../boot/dts/{ => broadcom}/bcm911360_entphn.dts   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm911360k.dts    |    0
 arch/arm/boot/dts/{ => broadcom}/bcm94708.dts      |    0
 arch/arm/boot/dts/{ => broadcom}/bcm94709.dts      |    0
 .../boot/dts/{ => broadcom}/bcm947189acdbmr.dts    |    0
 arch/arm/boot/dts/{ => broadcom}/bcm947622.dts     |    0
 arch/arm/boot/dts/{ => broadcom}/bcm953012er.dts   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm953012hr.dts   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm953012k.dts    |    0
 arch/arm/boot/dts/{ => broadcom}/bcm958300k.dts    |    0
 arch/arm/boot/dts/{ => broadcom}/bcm958305k.dts    |    0
 arch/arm/boot/dts/{ => broadcom}/bcm958522er.dts   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm958525er.dts   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm958525xmc.dts  |    0
 arch/arm/boot/dts/{ => broadcom}/bcm958622hr.dts   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm958623hr.dts   |    0
 .../dts/{ => broadcom}/bcm958625-meraki-alamo.dtsi |    0
 .../{ => broadcom}/bcm958625-meraki-kingpin.dtsi   |    0
 .../{ => broadcom}/bcm958625-meraki-mx64-a0.dts    |    0
 .../dts/{ => broadcom}/bcm958625-meraki-mx64.dts   |    0
 .../{ => broadcom}/bcm958625-meraki-mx64w-a0.dts   |    0
 .../dts/{ => broadcom}/bcm958625-meraki-mx64w.dts  |    0
 .../dts/{ => broadcom}/bcm958625-meraki-mx65.dts   |    0
 .../dts/{ => broadcom}/bcm958625-meraki-mx65w.dts  |    0
 .../bcm958625-meraki-mx6x-common.dtsi              |    0
 arch/arm/boot/dts/{ => broadcom}/bcm958625hr.dts   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm958625k.dts    |    0
 arch/arm/boot/dts/{ => broadcom}/bcm963138.dts     |    0
 arch/arm/boot/dts/{ => broadcom}/bcm963138dvt.dts  |    0
 arch/arm/boot/dts/{ => broadcom}/bcm963148.dts     |    0
 arch/arm/boot/dts/{ => broadcom}/bcm963178.dts     |    0
 arch/arm/boot/dts/{ => broadcom}/bcm96756.dts      |    0
 arch/arm/boot/dts/{ => broadcom}/bcm96846.dts      |    0
 arch/arm/boot/dts/{ => broadcom}/bcm96855.dts      |    0
 arch/arm/boot/dts/{ => broadcom}/bcm96878.dts      |    0
 arch/arm/boot/dts/{ => broadcom}/bcm988312hr.dts   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm9hmidc.dtsi    |    0
 arch/arm/boot/dts/calxeda/Makefile                 |    4 +
 arch/arm/boot/dts/{ => calxeda}/ecx-2000.dts       |    0
 arch/arm/boot/dts/{ => calxeda}/ecx-common.dtsi    |    0
 arch/arm/boot/dts/{ => calxeda}/highbank.dts       |    0
 arch/arm/boot/dts/cirrus/Makefile                  |    3 +
 arch/arm/boot/dts/{ => cirrus}/ep7209.dtsi         |    0
 arch/arm/boot/dts/{ => cirrus}/ep7211-edb7211.dts  |    0
 arch/arm/boot/dts/{ => cirrus}/ep7211.dtsi         |    0
 arch/arm/boot/dts/cnxt/Makefile                    |    3 +
 arch/arm/boot/dts/{ => cnxt}/cx92755.dtsi          |    0
 arch/arm/boot/dts/{ => cnxt}/cx92755_equinox.dts   |    0
 arch/arm/boot/dts/gemini/Makefile                  |   12 +
 .../boot/dts/{ => gemini}/gemini-dlink-dir-685.dts |    0
 .../boot/dts/{ => gemini}/gemini-dlink-dns-313.dts |    0
 arch/arm/boot/dts/{ => gemini}/gemini-nas4220b.dts |    0
 arch/arm/boot/dts/{ => gemini}/gemini-ns2502.dts   |    0
 arch/arm/boot/dts/{ => gemini}/gemini-rut1xx.dts   |    0
 arch/arm/boot/dts/{ => gemini}/gemini-sl93512r.dts |    0
 arch/arm/boot/dts/{ => gemini}/gemini-sq201.dts    |    0
 arch/arm/boot/dts/{ => gemini}/gemini-ssi1328.dts  |    0
 arch/arm/boot/dts/{ => gemini}/gemini-wbd111.dts   |    0
 arch/arm/boot/dts/{ => gemini}/gemini-wbd222.dts   |    0
 arch/arm/boot/dts/{ => gemini}/gemini.dtsi         |    0
 arch/arm/boot/dts/hisilicon/Makefile               |   13 +
 arch/arm/boot/dts/{ => hisilicon}/hi3519-demb.dts  |    0
 arch/arm/boot/dts/{ => hisilicon}/hi3519.dtsi      |    0
 .../arm/boot/dts/{ => hisilicon}/hi3620-hi4511.dts |    0
 arch/arm/boot/dts/{ => hisilicon}/hi3620.dtsi      |    0
 arch/arm/boot/dts/{ => hisilicon}/hip01-ca9x2.dts  |    0
 arch/arm/boot/dts/{ => hisilicon}/hip01.dtsi       |    0
 arch/arm/boot/dts/{ => hisilicon}/hip04-d01.dts    |    0
 arch/arm/boot/dts/{ => hisilicon}/hip04.dtsi       |    0
 .../boot/dts/{ => hisilicon}/hisi-x5hd2-dkb.dts    |    0
 arch/arm/boot/dts/{ => hisilicon}/hisi-x5hd2.dtsi  |    0
 arch/arm/boot/dts/{ => hisilicon}/sd5203.dts       |    0
 arch/arm/boot/dts/hpe/Makefile                     |    3 +
 arch/arm/boot/dts/{ => hpe}/hpe-bmc-dl360gen10.dts |    0
 arch/arm/boot/dts/{ => hpe}/hpe-gxp.dtsi           |    0
 arch/arm/boot/dts/intel/Makefile                   |    5 +
 arch/arm/boot/dts/intel/axm/Makefile               |    3 +
 .../boot/dts/{ => intel/axm}/axm5516-amarillo.dts  |    0
 .../arm/boot/dts/{ => intel/axm}/axm5516-cpus.dtsi |    0
 arch/arm/boot/dts/{ => intel/axm}/axm55xx.dtsi     |    0
 arch/arm/boot/dts/intel/ixp/Makefile               |   19 +
 .../{ => intel/ixp}/intel-ixp42x-adi-coyote.dts    |    0
 .../{ => intel/ixp}/intel-ixp42x-arcom-vulcan.dts  |    0
 .../ixp}/intel-ixp42x-dlink-dsm-g600.dts           |    0
 .../{ => intel/ixp}/intel-ixp42x-freecom-fsg-3.dts |    0
 .../{ => intel/ixp}/intel-ixp42x-gateway-7001.dts  |    0
 .../ixp}/intel-ixp42x-gateworks-gw2348.dts         |    0
 .../ixp}/intel-ixp42x-goramo-multilink.dts         |    0
 .../ixp}/intel-ixp42x-iomega-nas100d.dts           |    0
 .../dts/{ => intel/ixp}/intel-ixp42x-ixdp425.dts   |    0
 .../dts/{ => intel/ixp}/intel-ixp42x-ixdpg425.dts  |    0
 .../{ => intel/ixp}/intel-ixp42x-linksys-nslu2.dts |    0
 .../ixp}/intel-ixp42x-linksys-wrv54g.dts           |    0
 .../ixp}/intel-ixp42x-netgear-wg302v1.dts          |    0
 .../ixp}/intel-ixp42x-welltech-epbx100.dts         |    0
 .../arm/boot/dts/{ => intel/ixp}/intel-ixp42x.dtsi |    0
 .../ixp}/intel-ixp43x-gateworks-gw2358.dts         |    0
 .../dts/{ => intel/ixp}/intel-ixp43x-kixrp435.dts  |    0
 .../arm/boot/dts/{ => intel/ixp}/intel-ixp43x.dtsi |    0
 .../dts/{ => intel/ixp}/intel-ixp45x-ixp46x.dtsi   |    0
 .../dts/{ => intel/ixp}/intel-ixp46x-ixdp465.dts   |    0
 .../ixp}/intel-ixp4xx-reference-design.dtsi        |    0
 .../arm/boot/dts/{ => intel/ixp}/intel-ixp4xx.dtsi |    0
 arch/arm/boot/dts/intel/pxa/Makefile               |    8 +
 arch/arm/boot/dts/{ => intel/pxa}/pxa25x.dtsi      |    0
 arch/arm/boot/dts/{ => intel/pxa}/pxa27x.dtsi      |    0
 arch/arm/boot/dts/{ => intel/pxa}/pxa2xx.dtsi      |    0
 .../{ => intel/pxa}/pxa300-raumfeld-common.dtsi    |    0
 .../{ => intel/pxa}/pxa300-raumfeld-connector.dts  |    0
 .../{ => intel/pxa}/pxa300-raumfeld-controller.dts |    0
 .../{ => intel/pxa}/pxa300-raumfeld-speaker-l.dts  |    0
 .../{ => intel/pxa}/pxa300-raumfeld-speaker-m.dts  |    0
 .../pxa}/pxa300-raumfeld-speaker-one.dts           |    0
 .../{ => intel/pxa}/pxa300-raumfeld-speaker-s.dts  |    0
 .../pxa}/pxa300-raumfeld-tuneable-clock.dtsi       |    0
 arch/arm/boot/dts/{ => intel/pxa}/pxa3xx.dtsi      |    0
 arch/arm/boot/dts/intel/socfpga/Makefile           |   17 +
 arch/arm/boot/dts/{ => intel/socfpga}/socfpga.dtsi |    0
 .../dts/{ => intel/socfpga}/socfpga_arria10.dtsi   |    0
 .../socfpga}/socfpga_arria10_chameleonv3.dts       |    0
 .../socfpga}/socfpga_arria10_mercury_aa1.dtsi      |    0
 .../socfpga}/socfpga_arria10_mercury_pe1.dts       |    0
 .../{ => intel/socfpga}/socfpga_arria10_socdk.dtsi |    0
 .../socfpga}/socfpga_arria10_socdk_nand.dts        |    0
 .../socfpga}/socfpga_arria10_socdk_qspi.dts        |    0
 .../socfpga}/socfpga_arria10_socdk_sdmmc.dts       |    0
 .../dts/{ => intel/socfpga}/socfpga_arria5.dtsi    |    0
 .../{ => intel/socfpga}/socfpga_arria5_socdk.dts   |    0
 .../dts/{ => intel/socfpga}/socfpga_cyclone5.dtsi  |    0
 .../socfpga}/socfpga_cyclone5_chameleon96.dts      |    0
 .../socfpga}/socfpga_cyclone5_de0_nano_soc.dts     |    0
 .../{ => intel/socfpga}/socfpga_cyclone5_mcv.dtsi  |    0
 .../socfpga}/socfpga_cyclone5_mcvevk.dts           |    0
 .../{ => intel/socfpga}/socfpga_cyclone5_socdk.dts |    0
 .../socfpga}/socfpga_cyclone5_sockit.dts           |    0
 .../socfpga}/socfpga_cyclone5_socrates.dts         |    0
 .../{ => intel/socfpga}/socfpga_cyclone5_sodia.dts |    0
 .../socfpga}/socfpga_cyclone5_vining_fpga.dts      |    0
 .../boot/dts/{ => intel/socfpga}/socfpga_vt.dts    |    0
 arch/arm/boot/dts/marvell/Makefile                 |  164 ++
 .../boot/dts/{ => marvell}/armada-370-c200-v2.dts  |    0
 arch/arm/boot/dts/{ => marvell}/armada-370-db.dts  |    0
 .../dts/{ => marvell}/armada-370-dlink-dns327l.dts |    0
 .../boot/dts/{ => marvell}/armada-370-mirabox.dts  |    0
 .../dts/{ => marvell}/armada-370-netgear-rn102.dts |    0
 .../dts/{ => marvell}/armada-370-netgear-rn104.dts |    0
 arch/arm/boot/dts/{ => marvell}/armada-370-rd.dts  |    0
 .../{ => marvell}/armada-370-seagate-nas-2bay.dts  |    0
 .../{ => marvell}/armada-370-seagate-nas-4bay.dts  |    0
 .../{ => marvell}/armada-370-seagate-nas-xbay.dtsi |    0
 .../armada-370-seagate-personal-cloud-2bay.dts     |    0
 .../armada-370-seagate-personal-cloud.dts          |    0
 .../armada-370-seagate-personal-cloud.dtsi         |    0
 .../{ => marvell}/armada-370-synology-ds213j.dts   |    0
 arch/arm/boot/dts/{ => marvell}/armada-370-xp.dtsi |    0
 arch/arm/boot/dts/{ => marvell}/armada-370.dtsi    |    0
 arch/arm/boot/dts/{ => marvell}/armada-375-db.dts  |    0
 arch/arm/boot/dts/{ => marvell}/armada-375.dtsi    |    0
 arch/arm/boot/dts/{ => marvell}/armada-380.dtsi    |    0
 .../{ => marvell}/armada-381-netgear-gs110emx.dts  |    0
 .../{ => marvell}/armada-382-rd-ac3x-48g4x2xl.dts  |    0
 .../boot/dts/{ => marvell}/armada-385-atl-x530.dts |    0
 .../{ => marvell}/armada-385-clearfog-gtr-l8.dts   |    0
 .../{ => marvell}/armada-385-clearfog-gtr-s4.dts   |    0
 .../dts/{ => marvell}/armada-385-clearfog-gtr.dtsi |    0
 .../{ => marvell}/armada-385-db-88f6820-amc.dts    |    0
 .../boot/dts/{ => marvell}/armada-385-db-ap.dts    |    0
 .../{ => marvell}/armada-385-linksys-caiman.dts    |    0
 .../dts/{ => marvell}/armada-385-linksys-cobra.dts |    0
 .../dts/{ => marvell}/armada-385-linksys-rango.dts |    0
 .../{ => marvell}/armada-385-linksys-shelby.dts    |    0
 .../boot/dts/{ => marvell}/armada-385-linksys.dtsi |    0
 .../{ => marvell}/armada-385-synology-ds116.dts    |    0
 .../dts/{ => marvell}/armada-385-turris-omnia.dts  |    0
 arch/arm/boot/dts/{ => marvell}/armada-385.dtsi    |    0
 .../dts/{ => marvell}/armada-388-clearfog-base.dts |    0
 .../dts/{ => marvell}/armada-388-clearfog-pro.dts  |    0
 .../boot/dts/{ => marvell}/armada-388-clearfog.dts |    0
 .../dts/{ => marvell}/armada-388-clearfog.dtsi     |    0
 arch/arm/boot/dts/{ => marvell}/armada-388-db.dts  |    0
 arch/arm/boot/dts/{ => marvell}/armada-388-gp.dts  |    0
 .../boot/dts/{ => marvell}/armada-388-helios4.dts  |    0
 arch/arm/boot/dts/{ => marvell}/armada-388-rd.dts  |    0
 arch/arm/boot/dts/{ => marvell}/armada-388.dtsi    |    0
 .../armada-38x-solidrun-microsom.dtsi              |    0
 arch/arm/boot/dts/{ => marvell}/armada-38x.dtsi    |    0
 arch/arm/boot/dts/{ => marvell}/armada-390-db.dts  |    0
 arch/arm/boot/dts/{ => marvell}/armada-390.dtsi    |    0
 arch/arm/boot/dts/{ => marvell}/armada-395-gp.dts  |    0
 arch/arm/boot/dts/{ => marvell}/armada-395.dtsi    |    0
 arch/arm/boot/dts/{ => marvell}/armada-398-db.dts  |    0
 arch/arm/boot/dts/{ => marvell}/armada-398.dtsi    |    0
 arch/arm/boot/dts/{ => marvell}/armada-39x.dtsi    |    0
 .../boot/dts/{ => marvell}/armada-xp-98dx3236.dtsi |    0
 .../boot/dts/{ => marvell}/armada-xp-98dx3336.dtsi |    0
 .../boot/dts/{ => marvell}/armada-xp-98dx4251.dtsi |    0
 .../boot/dts/{ => marvell}/armada-xp-axpwifiap.dts |    0
 .../{ => marvell}/armada-xp-crs305-1g-4s-bit.dts   |    0
 .../dts/{ => marvell}/armada-xp-crs305-1g-4s.dts   |    0
 .../dts/{ => marvell}/armada-xp-crs305-1g-4s.dtsi  |    0
 .../{ => marvell}/armada-xp-crs326-24g-2s-bit.dts  |    0
 .../dts/{ => marvell}/armada-xp-crs326-24g-2s.dts  |    0
 .../dts/{ => marvell}/armada-xp-crs326-24g-2s.dtsi |    0
 .../armada-xp-crs328-4c-20s-4s-bit.dts             |    0
 .../{ => marvell}/armada-xp-crs328-4c-20s-4s.dts   |    0
 .../{ => marvell}/armada-xp-crs328-4c-20s-4s.dtsi  |    0
 .../boot/dts/{ => marvell}/armada-xp-db-dxbc2.dts  |    0
 .../dts/{ => marvell}/armada-xp-db-xc3-24g4xg.dts  |    0
 arch/arm/boot/dts/{ => marvell}/armada-xp-db.dts   |    0
 arch/arm/boot/dts/{ => marvell}/armada-xp-gp.dts   |    0
 .../{ => marvell}/armada-xp-lenovo-ix4-300d.dts    |    0
 .../dts/{ => marvell}/armada-xp-linksys-mamba.dts  |    0
 .../boot/dts/{ => marvell}/armada-xp-matrix.dts    |    0
 .../boot/dts/{ => marvell}/armada-xp-mv78230.dtsi  |    0
 .../boot/dts/{ => marvell}/armada-xp-mv78260.dtsi  |    0
 .../boot/dts/{ => marvell}/armada-xp-mv78460.dtsi  |    0
 .../dts/{ => marvell}/armada-xp-netgear-rn2120.dts |    0
 .../{ => marvell}/armada-xp-openblocks-ax3-4.dts   |    0
 .../dts/{ => marvell}/armada-xp-synology-ds414.dts |    0
 arch/arm/boot/dts/{ => marvell}/armada-xp.dtsi     |    0
 arch/arm/boot/dts/{ => marvell}/dove-cm-a510.dtsi  |    0
 arch/arm/boot/dts/{ => marvell}/dove-cubox-es.dts  |    0
 arch/arm/boot/dts/{ => marvell}/dove-cubox.dts     |    0
 arch/arm/boot/dts/{ => marvell}/dove-d2plug.dts    |    0
 arch/arm/boot/dts/{ => marvell}/dove-d3plug.dts    |    0
 arch/arm/boot/dts/{ => marvell}/dove-dove-db.dts   |    0
 arch/arm/boot/dts/{ => marvell}/dove-sbc-a510.dts  |    0
 arch/arm/boot/dts/{ => marvell}/dove.dtsi          |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-6192.dtsi |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-6281.dtsi |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-6282.dtsi |    0
 .../boot/dts/{ => marvell}/kirkwood-98dx4122.dtsi  |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-b3.dts    |    0
 .../{ => marvell}/kirkwood-blackarmor-nas220.dts   |    0
 .../boot/dts/{ => marvell}/kirkwood-c200-v1.dts    |    0
 .../boot/dts/{ => marvell}/kirkwood-cloudbox.dts   |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-d2net.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-db-88f6281.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-db-88f6282.dts |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-db.dtsi   |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-dir665.dts |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-dns320.dts |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-dns325.dts |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-dnskw.dtsi |    0
 .../boot/dts/{ => marvell}/kirkwood-dockstar.dts   |    0
 .../boot/dts/{ => marvell}/kirkwood-dreamplug.dts  |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-ds109.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-ds110jv10.dts  |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-ds111.dts |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-ds112.dts |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-ds209.dts |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-ds210.dts |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-ds212.dts |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-ds212j.dts |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-ds409.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-ds409slim.dts  |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-ds411.dts |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-ds411j.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-ds411slim.dts  |    0
 .../boot/dts/{ => marvell}/kirkwood-goflexnet.dts  |    0
 .../kirkwood-guruplug-server-plus.dts              |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-ib62x0.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-iconnect.dts   |    0
 .../dts/{ => marvell}/kirkwood-iomega_ix2_200.dts  |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-is2.dts   |    0
 .../boot/dts/{ => marvell}/kirkwood-km_common.dtsi |    0
 .../dts/{ => marvell}/kirkwood-km_fixedeth.dts     |    0
 .../dts/{ => marvell}/kirkwood-km_kirkwood.dts     |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-l-50.dts  |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-laplug.dts |    0
 .../{ => marvell}/kirkwood-linkstation-6282.dtsi   |    0
 .../kirkwood-linkstation-duo-6281.dtsi             |    0
 .../{ => marvell}/kirkwood-linkstation-lsqvl.dts   |    0
 .../{ => marvell}/kirkwood-linkstation-lsvl.dts    |    0
 .../{ => marvell}/kirkwood-linkstation-lswsxl.dts  |    0
 .../{ => marvell}/kirkwood-linkstation-lswvl.dts   |    0
 .../{ => marvell}/kirkwood-linkstation-lswxl.dts   |    0
 .../dts/{ => marvell}/kirkwood-linkstation.dtsi    |    0
 .../dts/{ => marvell}/kirkwood-linksys-viper.dts   |    0
 .../boot/dts/{ => marvell}/kirkwood-lschlv2.dts    |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-lsxhl.dts |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-lsxl.dtsi |    0
 .../boot/dts/{ => marvell}/kirkwood-mplcec4.dts    |    0
 .../dts/{ => marvell}/kirkwood-mv88f6281gtw-ge.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-nas2big.dts    |    0
 .../boot/dts/{ => marvell}/kirkwood-net2big.dts    |    0
 .../boot/dts/{ => marvell}/kirkwood-net5big.dts    |    0
 .../kirkwood-netgear_readynas_duo_v2.dts           |    0
 .../kirkwood-netgear_readynas_nv+_v2.dts           |    0
 .../boot/dts/{ => marvell}/kirkwood-netxbig.dtsi   |    0
 .../dts/{ => marvell}/kirkwood-ns2-common.dtsi     |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-ns2.dts   |    0
 .../boot/dts/{ => marvell}/kirkwood-ns2lite.dts    |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-ns2max.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-ns2mini.dts    |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-nsa310.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-nsa310a.dts    |    0
 .../boot/dts/{ => marvell}/kirkwood-nsa310s.dts    |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-nsa320.dts |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-nsa325.dts |    0
 .../dts/{ => marvell}/kirkwood-nsa3x0-common.dtsi  |    0
 .../dts/{ => marvell}/kirkwood-openblocks_a6.dts   |    0
 .../dts/{ => marvell}/kirkwood-openblocks_a7.dts   |    0
 .../dts/{ => marvell}/kirkwood-openrd-base.dts     |    0
 .../dts/{ => marvell}/kirkwood-openrd-client.dts   |    0
 .../dts/{ => marvell}/kirkwood-openrd-ultimate.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-openrd.dtsi    |    0
 .../boot/dts/{ => marvell}/kirkwood-pogo_e02.dts   |    0
 .../{ => marvell}/kirkwood-pogoplug-series-4.dts   |    0
 .../boot/dts/{ => marvell}/kirkwood-rd88f6192.dts  |    0
 .../dts/{ => marvell}/kirkwood-rd88f6281-a.dts     |    0
 .../dts/{ => marvell}/kirkwood-rd88f6281-z0.dts    |    0
 .../boot/dts/{ => marvell}/kirkwood-rd88f6281.dtsi |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-rs212.dts |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-rs409.dts |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-rs411.dts |    0
 .../{ => marvell}/kirkwood-sheevaplug-common.dtsi  |    0
 .../{ => marvell}/kirkwood-sheevaplug-esata.dts    |    0
 .../boot/dts/{ => marvell}/kirkwood-sheevaplug.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-synology.dtsi  |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood-t5325.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-topkick.dts    |    0
 .../boot/dts/{ => marvell}/kirkwood-ts219-6281.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-ts219-6282.dts |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-ts219.dtsi |    0
 .../boot/dts/{ => marvell}/kirkwood-ts419-6281.dts |    0
 .../boot/dts/{ => marvell}/kirkwood-ts419-6282.dts |    0
 .../arm/boot/dts/{ => marvell}/kirkwood-ts419.dtsi |    0
 arch/arm/boot/dts/{ => marvell}/kirkwood.dtsi      |    0
 .../arm/boot/dts/{ => marvell}/mmp2-brownstone.dts |    0
 .../boot/dts/{ => marvell}/mmp2-olpc-xo-1-75.dts   |    0
 arch/arm/boot/dts/{ => marvell}/mmp2.dtsi          |    0
 .../arm/boot/dts/{ => marvell}/mmp3-dell-ariel.dts |    0
 arch/arm/boot/dts/{ => marvell}/mmp3.dtsi          |    0
 .../dts/{ => marvell}/mvebu-linkstation-fan.dtsi   |    0
 .../mvebu-linkstation-gpio-simple.dtsi             |    0
 .../boot/dts/{ => marvell}/orion5x-kuroboxpro.dts  |    0
 .../dts/{ => marvell}/orion5x-lacie-d2-network.dts |    0
 .../orion5x-lacie-ethernet-disk-mini-v2.dts        |    0
 .../{ => marvell}/orion5x-linkstation-lschl.dts    |    0
 .../dts/{ => marvell}/orion5x-linkstation-lsgl.dts |    0
 .../{ => marvell}/orion5x-linkstation-lswtgl.dts   |    0
 .../dts/{ => marvell}/orion5x-linkstation.dtsi     |    0
 arch/arm/boot/dts/{ => marvell}/orion5x-lswsgl.dts |    0
 .../orion5x-maxtor-shared-storage-2.dts            |    0
 .../boot/dts/{ => marvell}/orion5x-mv88f5181.dtsi  |    0
 .../boot/dts/{ => marvell}/orion5x-mv88f5182.dtsi  |    0
 .../dts/{ => marvell}/orion5x-netgear-wnr854t.dts  |    0
 .../dts/{ => marvell}/orion5x-rd88f5182-nas.dts    |    0
 arch/arm/boot/dts/{ => marvell}/orion5x.dtsi       |    0
 .../arm/boot/dts/{ => marvell}/pxa168-aspenite.dts |    0
 arch/arm/boot/dts/{ => marvell}/pxa168.dtsi        |    0
 arch/arm/boot/dts/{ => marvell}/pxa910-dkb.dts     |    0
 arch/arm/boot/dts/{ => marvell}/pxa910.dtsi        |    0
 arch/arm/boot/dts/mediatek/Makefile                |   15 +
 arch/arm/boot/dts/{ => mediatek}/mt2701-evb.dts    |    0
 arch/arm/boot/dts/{ => mediatek}/mt2701-pinfunc.h  |    0
 arch/arm/boot/dts/{ => mediatek}/mt2701.dtsi       |    0
 arch/arm/boot/dts/{ => mediatek}/mt6323.dtsi       |    0
 arch/arm/boot/dts/{ => mediatek}/mt6580-evbp1.dts  |    0
 arch/arm/boot/dts/{ => mediatek}/mt6580.dtsi       |    0
 .../{ => mediatek}/mt6582-prestigio-pmt5008-3g.dts |    0
 arch/arm/boot/dts/{ => mediatek}/mt6582.dtsi       |    0
 .../boot/dts/{ => mediatek}/mt6589-aquaris5.dts    |    0
 .../dts/{ => mediatek}/mt6589-fairphone-fp1.dts    |    0
 arch/arm/boot/dts/{ => mediatek}/mt6589.dtsi       |    0
 arch/arm/boot/dts/{ => mediatek}/mt6592-evb.dts    |    0
 arch/arm/boot/dts/{ => mediatek}/mt6592.dtsi       |    0
 arch/arm/boot/dts/{ => mediatek}/mt7623.dtsi       |    0
 .../boot/dts/{ => mediatek}/mt7623a-rfb-emmc.dts   |    0
 .../boot/dts/{ => mediatek}/mt7623a-rfb-nand.dts   |    0
 arch/arm/boot/dts/{ => mediatek}/mt7623a.dtsi      |    0
 .../dts/{ => mediatek}/mt7623n-bananapi-bpi-r2.dts |    0
 .../boot/dts/{ => mediatek}/mt7623n-rfb-emmc.dts   |    0
 arch/arm/boot/dts/{ => mediatek}/mt7623n.dtsi      |    0
 arch/arm/boot/dts/{ => mediatek}/mt7629-rfb.dts    |    0
 arch/arm/boot/dts/{ => mediatek}/mt7629.dtsi       |    0
 arch/arm/boot/dts/{ => mediatek}/mt8127-moose.dts  |    0
 arch/arm/boot/dts/{ => mediatek}/mt8127.dtsi       |    0
 arch/arm/boot/dts/{ => mediatek}/mt8135-evbp1.dts  |    0
 arch/arm/boot/dts/{ => mediatek}/mt8135.dtsi       |    0
 arch/arm/boot/dts/microchip/Makefile               |   82 +
 arch/arm/boot/dts/{ => microchip}/aks-cdu.dts      |    0
 arch/arm/boot/dts/{ => microchip}/animeo_ip.dts    |    0
 arch/arm/boot/dts/{ => microchip}/at91-ariag25.dts |    0
 .../boot/dts/{ => microchip}/at91-ariettag25.dts   |    0
 arch/arm/boot/dts/{ => microchip}/at91-cosino.dtsi |    0
 .../dts/{ => microchip}/at91-cosino_mega2560.dts   |    0
 .../boot/dts/{ => microchip}/at91-dvk_som60.dts    |    0
 .../dts/{ => microchip}/at91-dvk_su60_somc.dtsi    |    0
 .../{ => microchip}/at91-dvk_su60_somc_lcm.dtsi    |    0
 arch/arm/boot/dts/{ => microchip}/at91-foxg20.dts  |    0
 arch/arm/boot/dts/{ => microchip}/at91-gatwick.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91-kizbox.dts  |    0
 .../boot/dts/{ => microchip}/at91-kizbox2-2.dts    |    0
 .../dts/{ => microchip}/at91-kizbox2-common.dtsi   |    0
 .../boot/dts/{ => microchip}/at91-kizbox3-hs.dts   |    0
 .../dts/{ => microchip}/at91-kizbox3_common.dtsi   |    0
 .../dts/{ => microchip}/at91-kizboxmini-base.dts   |    0
 .../{ => microchip}/at91-kizboxmini-common.dtsi    |    0
 .../dts/{ => microchip}/at91-kizboxmini-mb.dts     |    0
 .../dts/{ => microchip}/at91-kizboxmini-rd.dts     |    0
 arch/arm/boot/dts/{ => microchip}/at91-linea.dtsi  |    0
 arch/arm/boot/dts/{ => microchip}/at91-lmu5000.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91-natte.dtsi  |    0
 .../dts/{ => microchip}/at91-nattis-2-natte-2.dts  |    0
 arch/arm/boot/dts/{ => microchip}/at91-q5xr5.dts   |    0
 .../boot/dts/{ => microchip}/at91-qil_a9260.dts    |    0
 .../boot/dts/{ => microchip}/at91-sam9_l9260.dts   |    0
 .../dts/{ => microchip}/at91-sam9x60_curiosity.dts |    0
 .../boot/dts/{ => microchip}/at91-sam9x60ek.dts    |    0
 .../dts/{ => microchip}/at91-sama5d27_som1.dtsi    |    0
 .../dts/{ => microchip}/at91-sama5d27_som1_ek.dts  |    0
 .../dts/{ => microchip}/at91-sama5d27_wlsom1.dtsi  |    0
 .../{ => microchip}/at91-sama5d27_wlsom1_ek.dts    |    0
 .../boot/dts/{ => microchip}/at91-sama5d2_icp.dts  |    0
 .../dts/{ => microchip}/at91-sama5d2_ptc_ek.dts    |    0
 .../dts/{ => microchip}/at91-sama5d2_xplained.dts  |    0
 .../boot/dts/{ => microchip}/at91-sama5d3_eds.dts  |    0
 .../{ => microchip}/at91-sama5d3_ksz9477_evb.dts   |    0
 .../dts/{ => microchip}/at91-sama5d3_xplained.dts  |    0
 .../dts/{ => microchip}/at91-sama5d4_ma5d4.dtsi    |    0
 .../dts/{ => microchip}/at91-sama5d4_ma5d4evk.dts  |    0
 .../dts/{ => microchip}/at91-sama5d4_xplained.dts  |    0
 .../boot/dts/{ => microchip}/at91-sama5d4ek.dts    |    0
 .../boot/dts/{ => microchip}/at91-sama7g5ek.dts    |    0
 .../arm/boot/dts/{ => microchip}/at91-smartkiz.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91-som60.dtsi  |    0
 .../arm/boot/dts/{ => microchip}/at91-tse850-3.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91-vinco.dts   |    0
 arch/arm/boot/dts/{ => microchip}/at91-wb45n.dts   |    0
 arch/arm/boot/dts/{ => microchip}/at91-wb45n.dtsi  |    0
 arch/arm/boot/dts/{ => microchip}/at91-wb50n.dts   |    0
 arch/arm/boot/dts/{ => microchip}/at91-wb50n.dtsi  |    0
 arch/arm/boot/dts/{ => microchip}/at91rm9200.dtsi  |    0
 .../boot/dts/{ => microchip}/at91rm9200_pqfp.dtsi  |    0
 arch/arm/boot/dts/{ => microchip}/at91rm9200ek.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9260.dtsi |    0
 .../arm/boot/dts/{ => microchip}/at91sam9260ek.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9261.dtsi |    0
 .../arm/boot/dts/{ => microchip}/at91sam9261ek.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9263.dtsi |    0
 .../arm/boot/dts/{ => microchip}/at91sam9263ek.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9g15.dtsi |    0
 .../arm/boot/dts/{ => microchip}/at91sam9g15ek.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9g20.dtsi |    0
 .../arm/boot/dts/{ => microchip}/at91sam9g20ek.dts |    0
 .../dts/{ => microchip}/at91sam9g20ek_2mmc.dts     |    0
 .../dts/{ => microchip}/at91sam9g20ek_common.dtsi  |    0
 .../at91sam9g25-gardena-smart-gateway.dts          |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9g25.dtsi |    0
 .../arm/boot/dts/{ => microchip}/at91sam9g25ek.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9g35.dtsi |    0
 .../arm/boot/dts/{ => microchip}/at91sam9g35ek.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9g45.dtsi |    0
 .../boot/dts/{ => microchip}/at91sam9m10g45ek.dts  |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9n12.dtsi |    0
 .../arm/boot/dts/{ => microchip}/at91sam9n12ek.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9rl.dtsi  |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9rlek.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9x25.dtsi |    0
 .../arm/boot/dts/{ => microchip}/at91sam9x25ek.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9x35.dtsi |    0
 .../arm/boot/dts/{ => microchip}/at91sam9x35ek.dts |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9x5.dtsi  |    0
 .../boot/dts/{ => microchip}/at91sam9x5_can.dtsi   |    0
 .../boot/dts/{ => microchip}/at91sam9x5_isi.dtsi   |    0
 .../boot/dts/{ => microchip}/at91sam9x5_lcd.dtsi   |    0
 .../boot/dts/{ => microchip}/at91sam9x5_macb0.dtsi |    0
 .../boot/dts/{ => microchip}/at91sam9x5_macb1.dtsi |    0
 .../dts/{ => microchip}/at91sam9x5_usart3.dtsi     |    0
 .../arm/boot/dts/{ => microchip}/at91sam9x5cm.dtsi |    0
 .../arm/boot/dts/{ => microchip}/at91sam9x5dm.dtsi |    0
 .../arm/boot/dts/{ => microchip}/at91sam9x5ek.dtsi |    0
 arch/arm/boot/dts/{ => microchip}/at91sam9xe.dtsi  |    0
 arch/arm/boot/dts/{ => microchip}/ethernut5.dts    |    0
 arch/arm/boot/dts/{ => microchip}/evk-pro3.dts     |    0
 arch/arm/boot/dts/{ => microchip}/ge863-pro3.dtsi  |    0
 .../lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts     |    0
 .../lan966x-kontron-kswitch-d10-mmt-8g.dts         |    0
 .../lan966x-kontron-kswitch-d10-mmt.dtsi           |    0
 .../boot/dts/{ => microchip}/lan966x-pcb8290.dts   |    0
 .../boot/dts/{ => microchip}/lan966x-pcb8291.dts   |    0
 .../boot/dts/{ => microchip}/lan966x-pcb8309.dts   |    0
 arch/arm/boot/dts/{ => microchip}/lan966x.dtsi     |    0
 arch/arm/boot/dts/{ => microchip}/mpa1600.dts      |    0
 arch/arm/boot/dts/{ => microchip}/pm9g45.dts       |    0
 arch/arm/boot/dts/{ => microchip}/sam9x60.dtsi     |    0
 .../arm/boot/dts/{ => microchip}/sama5d2-pinfunc.h |    0
 arch/arm/boot/dts/{ => microchip}/sama5d2.dtsi     |    0
 arch/arm/boot/dts/{ => microchip}/sama5d29.dtsi    |    0
 arch/arm/boot/dts/{ => microchip}/sama5d3.dtsi     |    0
 arch/arm/boot/dts/{ => microchip}/sama5d31.dtsi    |    0
 arch/arm/boot/dts/{ => microchip}/sama5d31ek.dts   |    0
 arch/arm/boot/dts/{ => microchip}/sama5d33.dtsi    |    0
 arch/arm/boot/dts/{ => microchip}/sama5d33ek.dts   |    0
 arch/arm/boot/dts/{ => microchip}/sama5d34.dtsi    |    0
 arch/arm/boot/dts/{ => microchip}/sama5d34ek.dts   |    0
 arch/arm/boot/dts/{ => microchip}/sama5d35.dtsi    |    0
 arch/arm/boot/dts/{ => microchip}/sama5d35ek.dts   |    0
 arch/arm/boot/dts/{ => microchip}/sama5d36.dtsi    |    0
 arch/arm/boot/dts/{ => microchip}/sama5d36ek.dts   |    0
 .../boot/dts/{ => microchip}/sama5d36ek_cmp.dts    |    0
 arch/arm/boot/dts/{ => microchip}/sama5d3_can.dtsi |    0
 .../arm/boot/dts/{ => microchip}/sama5d3_emac.dtsi |    0
 .../arm/boot/dts/{ => microchip}/sama5d3_gmac.dtsi |    0
 arch/arm/boot/dts/{ => microchip}/sama5d3_lcd.dtsi |    0
 .../arm/boot/dts/{ => microchip}/sama5d3_mci2.dtsi |    0
 .../arm/boot/dts/{ => microchip}/sama5d3_tcb1.dtsi |    0
 .../arm/boot/dts/{ => microchip}/sama5d3_uart.dtsi |    0
 arch/arm/boot/dts/{ => microchip}/sama5d3xcm.dtsi  |    0
 .../boot/dts/{ => microchip}/sama5d3xcm_cmp.dtsi   |    0
 arch/arm/boot/dts/{ => microchip}/sama5d3xdm.dtsi  |    0
 arch/arm/boot/dts/{ => microchip}/sama5d3xmb.dtsi  |    0
 .../boot/dts/{ => microchip}/sama5d3xmb_cmp.dtsi   |    0
 .../boot/dts/{ => microchip}/sama5d3xmb_emac.dtsi  |    0
 .../boot/dts/{ => microchip}/sama5d3xmb_gmac.dtsi  |    0
 arch/arm/boot/dts/{ => microchip}/sama5d4.dtsi     |    0
 .../arm/boot/dts/{ => microchip}/sama7g5-pinfunc.h |    0
 arch/arm/boot/dts/{ => microchip}/sama7g5.dtsi     |    0
 arch/arm/boot/dts/{ => microchip}/tny_a9260.dts    |    0
 .../boot/dts/{ => microchip}/tny_a9260_common.dtsi |    0
 arch/arm/boot/dts/{ => microchip}/tny_a9263.dts    |    0
 arch/arm/boot/dts/{ => microchip}/tny_a9g20.dts    |    0
 arch/arm/boot/dts/{ => microchip}/usb_a9260.dts    |    0
 .../boot/dts/{ => microchip}/usb_a9260_common.dtsi |    0
 arch/arm/boot/dts/{ => microchip}/usb_a9263.dts    |    0
 .../dts/{ => microchip}/usb_a9g20-dab-mmx.dtsi     |    0
 arch/arm/boot/dts/{ => microchip}/usb_a9g20.dts    |    0
 .../boot/dts/{ => microchip}/usb_a9g20_common.dtsi |    0
 .../arm/boot/dts/{ => microchip}/usb_a9g20_lpw.dts |    0
 arch/arm/boot/dts/moxa/Makefile                    |    3 +
 arch/arm/boot/dts/{ => moxa}/moxart-uc7112lx.dts   |    0
 arch/arm/boot/dts/{ => moxa}/moxart.dtsi           |    0
 arch/arm/boot/dts/nspire/Makefile                  |    5 +
 arch/arm/boot/dts/{ => nspire}/nspire-classic.dtsi |    0
 arch/arm/boot/dts/{ => nspire}/nspire-clp.dts      |    0
 arch/arm/boot/dts/{ => nspire}/nspire-cx.dts       |    0
 arch/arm/boot/dts/{ => nspire}/nspire-tp.dts       |    0
 arch/arm/boot/dts/{ => nspire}/nspire.dtsi         |    0
 arch/arm/boot/dts/nuvoton/Makefile                 |    9 +
 .../dts/{ => nuvoton}/nuvoton-common-npcm7xx.dtsi  |    0
 .../boot/dts/{ => nuvoton}/nuvoton-npcm730-gbs.dts |    0
 .../{ => nuvoton}/nuvoton-npcm730-gsj-gpio.dtsi    |    0
 .../boot/dts/{ => nuvoton}/nuvoton-npcm730-gsj.dts |    0
 .../dts/{ => nuvoton}/nuvoton-npcm730-kudo.dts     |    0
 .../boot/dts/{ => nuvoton}/nuvoton-npcm730.dtsi    |    0
 .../boot/dts/{ => nuvoton}/nuvoton-npcm750-evb.dts |    0
 .../{ => nuvoton}/nuvoton-npcm750-pincfg-evb.dtsi  |    0
 .../nuvoton-npcm750-runbmc-olympus-pincfg.dtsi     |    0
 .../nuvoton-npcm750-runbmc-olympus.dts             |    0
 .../boot/dts/{ => nuvoton}/nuvoton-npcm750.dtsi    |    0
 .../nuvoton-wpcm450-supermicro-x9sci-ln4f.dts      |    0
 .../boot/dts/{ => nuvoton}/nuvoton-wpcm450.dtsi    |    0
 arch/arm/boot/dts/nvidia/Makefile                  |   43 +
 .../boot/dts/{ => nvidia}/tegra114-asus-tf701t.dts |    0
 .../arm/boot/dts/{ => nvidia}/tegra114-dalmore.dts |    0
 arch/arm/boot/dts/{ => nvidia}/tegra114-roth.dts   |    0
 arch/arm/boot/dts/{ => nvidia}/tegra114-tn7.dts    |    0
 arch/arm/boot/dts/{ => nvidia}/tegra114.dtsi       |    0
 .../boot/dts/{ => nvidia}/tegra124-apalis-emc.dtsi |    0
 .../boot/dts/{ => nvidia}/tegra124-apalis-eval.dts |    0
 .../dts/{ => nvidia}/tegra124-apalis-v1.2-eval.dts |    0
 .../dts/{ => nvidia}/tegra124-apalis-v1.2.dtsi     |    0
 .../arm/boot/dts/{ => nvidia}/tegra124-apalis.dtsi |    0
 .../dts/{ => nvidia}/tegra124-jetson-tk1-emc.dtsi  |    0
 .../boot/dts/{ => nvidia}/tegra124-jetson-tk1.dts  |    0
 .../dts/{ => nvidia}/tegra124-nyan-big-emc.dtsi    |    0
 .../dts/{ => nvidia}/tegra124-nyan-big-fhd.dts     |    0
 .../boot/dts/{ => nvidia}/tegra124-nyan-big.dts    |    0
 .../dts/{ => nvidia}/tegra124-nyan-blaze-emc.dtsi  |    0
 .../boot/dts/{ => nvidia}/tegra124-nyan-blaze.dts  |    0
 arch/arm/boot/dts/{ => nvidia}/tegra124-nyan.dtsi  |    2 +-
 .../dts/{ => nvidia}/tegra124-peripherals-opp.dtsi |    0
 .../arm/boot/dts/{ => nvidia}/tegra124-venice2.dts |    2 +-
 arch/arm/boot/dts/{ => nvidia}/tegra124.dtsi       |    0
 .../dts/{ => nvidia}/tegra20-acer-a500-picasso.dts |    0
 .../boot/dts/{ => nvidia}/tegra20-asus-tf101.dts   |    0
 .../dts/{ => nvidia}/tegra20-colibri-eval-v3.dts   |    0
 .../boot/dts/{ => nvidia}/tegra20-colibri-iris.dts |    0
 .../arm/boot/dts/{ => nvidia}/tegra20-colibri.dtsi |    0
 .../{ => nvidia}/tegra20-cpu-opp-microvolt.dtsi    |    0
 .../arm/boot/dts/{ => nvidia}/tegra20-cpu-opp.dtsi |    0
 arch/arm/boot/dts/{ => nvidia}/tegra20-harmony.dts |    0
 .../boot/dts/{ => nvidia}/tegra20-medcom-wide.dts  |    0
 arch/arm/boot/dts/{ => nvidia}/tegra20-paz00.dts   |    0
 .../dts/{ => nvidia}/tegra20-peripherals-opp.dtsi  |    0
 arch/arm/boot/dts/{ => nvidia}/tegra20-plutux.dts  |    0
 .../arm/boot/dts/{ => nvidia}/tegra20-seaboard.dts |    0
 .../boot/dts/{ => nvidia}/tegra20-tamonten.dtsi    |    0
 arch/arm/boot/dts/{ => nvidia}/tegra20-tec.dts     |    0
 .../boot/dts/{ => nvidia}/tegra20-trimslice.dts    |    0
 arch/arm/boot/dts/{ => nvidia}/tegra20-ventana.dts |    0
 arch/arm/boot/dts/{ => nvidia}/tegra20.dtsi        |    0
 .../boot/dts/{ => nvidia}/tegra30-apalis-eval.dts  |    0
 .../dts/{ => nvidia}/tegra30-apalis-v1.1-eval.dts  |    0
 .../boot/dts/{ => nvidia}/tegra30-apalis-v1.1.dtsi |    0
 arch/arm/boot/dts/{ => nvidia}/tegra30-apalis.dtsi |    0
 .../{ => nvidia}/tegra30-asus-lvds-display.dtsi    |    0
 .../tegra30-asus-nexus7-grouper-E1565.dts          |    0
 .../tegra30-asus-nexus7-grouper-PM269.dts          |    0
 .../tegra30-asus-nexus7-grouper-common.dtsi        |    0
 .../tegra30-asus-nexus7-grouper-maxim-pmic.dtsi    |    0
 ...tegra30-asus-nexus7-grouper-memory-timings.dtsi |    0
 .../tegra30-asus-nexus7-grouper-ti-pmic.dtsi       |    0
 .../{ => nvidia}/tegra30-asus-nexus7-grouper.dtsi  |    0
 .../tegra30-asus-nexus7-tilapia-E1565.dts          |    0
 ...tegra30-asus-nexus7-tilapia-memory-timings.dtsi |    0
 .../{ => nvidia}/tegra30-asus-nexus7-tilapia.dtsi  |    0
 .../boot/dts/{ => nvidia}/tegra30-asus-tf201.dts   |    0
 .../boot/dts/{ => nvidia}/tegra30-asus-tf300t.dts  |    0
 .../boot/dts/{ => nvidia}/tegra30-asus-tf300tg.dts |    0
 .../boot/dts/{ => nvidia}/tegra30-asus-tf700t.dts  |    0
 .../tegra30-asus-transformer-common.dtsi           |    0
 arch/arm/boot/dts/{ => nvidia}/tegra30-beaver.dts  |    0
 .../boot/dts/{ => nvidia}/tegra30-cardhu-a02.dts   |    0
 .../boot/dts/{ => nvidia}/tegra30-cardhu-a04.dts   |    0
 arch/arm/boot/dts/{ => nvidia}/tegra30-cardhu.dtsi |    0
 .../dts/{ => nvidia}/tegra30-colibri-eval-v3.dts   |    0
 .../arm/boot/dts/{ => nvidia}/tegra30-colibri.dtsi |    0
 .../{ => nvidia}/tegra30-cpu-opp-microvolt.dtsi    |    0
 .../arm/boot/dts/{ => nvidia}/tegra30-cpu-opp.dtsi |    0
 arch/arm/boot/dts/{ => nvidia}/tegra30-ouya.dts    |    0
 .../dts/{ => nvidia}/tegra30-pegatron-chagall.dts  |    0
 .../dts/{ => nvidia}/tegra30-peripherals-opp.dtsi  |    0
 arch/arm/boot/dts/{ => nvidia}/tegra30.dtsi        |    0
 arch/arm/boot/dts/nxp/Makefile                     |    6 +
 arch/arm/boot/dts/nxp/imx/Makefile                 |  387 +++++
 arch/arm/boot/dts/{ => nxp/imx}/e60k02.dtsi        |    0
 arch/arm/boot/dts/{ => nxp/imx}/e70k02.dtsi        |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx1-ads.dts       |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx1-apf9328.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx1-pinfunc.h     |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx1.dtsi          |    0
 .../dts/{ => nxp/imx}/imx25-eukrea-cpuimx25.dtsi   |    0
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |    0
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts  |    0
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts   |    0
 .../imx}/imx25-eukrea-mbimxsd25-baseboard.dts      |    0
 .../arm/boot/dts/{ => nxp/imx}/imx25-karo-tx25.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx25-pdk.dts      |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx25-pinfunc.h    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx25.dtsi         |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx27-apf27.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx27-apf27dev.dts |    0
 .../dts/{ => nxp/imx}/imx27-eukrea-cpuimx27.dtsi   |    0
 .../imx}/imx27-eukrea-mbimxsd27-baseboard.dts      |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx27-pdk.dts      |    0
 .../{ => nxp/imx}/imx27-phytec-phycard-s-rdk.dts   |    0
 .../{ => nxp/imx}/imx27-phytec-phycard-s-som.dtsi  |    0
 .../dts/{ => nxp/imx}/imx27-phytec-phycore-rdk.dts |    0
 .../{ => nxp/imx}/imx27-phytec-phycore-som.dtsi    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx27-pinfunc.h    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx27.dtsi         |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx31-bug.dts      |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx31-lite.dts     |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx31.dtsi         |    0
 .../dts/{ => nxp/imx}/imx35-eukrea-cpuimx35.dtsi   |    0
 .../imx}/imx35-eukrea-mbimxsd35-baseboard.dts      |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx35-pdk.dts      |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx35-pinfunc.h    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx35.dtsi         |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx50-evk.dts      |    0
 .../arm/boot/dts/{ => nxp/imx}/imx50-kobo-aura.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx50-pinfunc.h    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx50.dtsi         |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx51-apf51.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx51-apf51dev.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx51-babbage.dts  |    0
 .../{ => nxp/imx}/imx51-digi-connectcore-jsk.dts   |    0
 .../{ => nxp/imx}/imx51-digi-connectcore-som.dtsi  |    0
 .../dts/{ => nxp/imx}/imx51-eukrea-cpuimx51.dtsi   |    0
 .../imx}/imx51-eukrea-mbimxsd51-baseboard.dts      |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx51-pinfunc.h    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx51-ts4800.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx51-zii-rdu1.dts |    0
 .../boot/dts/{ => nxp/imx}/imx51-zii-scu2-mezz.dts |    0
 .../boot/dts/{ => nxp/imx}/imx51-zii-scu3-esb.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx51.dtsi         |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-ard.dts      |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-cx9020.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-kp-ddc.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-kp-hsc.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-kp.dtsi      |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-m53.dtsi     |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-m53evk.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-m53menlo.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-mba53.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-pinfunc.h    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-ppd.dts      |    0
 .../boot/dts/{ => nxp/imx}/imx53-qsb-common.dtsi   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-qsb.dts      |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-qsrb.dts     |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-sk-imx53.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-smd.dts      |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-tqma53.dtsi  |    0
 .../arm/boot/dts/{ => nxp/imx}/imx53-tx53-x03x.dts |    0
 .../arm/boot/dts/{ => nxp/imx}/imx53-tx53-x13x.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53-tx53.dtsi    |    0
 .../arm/boot/dts/{ => nxp/imx}/imx53-usbarmory.dts |    0
 .../boot/dts/{ => nxp/imx}/imx53-voipac-bsb.dts    |    0
 .../dts/{ => nxp/imx}/imx53-voipac-dmm-668.dtsi    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx53.dtsi         |    0
 .../dts/{ => nxp/imx}/imx6-logicpd-baseboard.dtsi  |    0
 .../boot/dts/{ => nxp/imx}/imx6-logicpd-som.dtsi   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-alti6p.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-apf6dev.dts |    0
 .../dts/{ => nxp/imx}/imx6dl-aristainetos2_4.dts   |    0
 .../dts/{ => nxp/imx}/imx6dl-aristainetos2_7.dts   |    0
 .../dts/{ => nxp/imx}/imx6dl-aristainetos_4.dts    |    0
 .../dts/{ => nxp/imx}/imx6dl-aristainetos_7.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-b105pv2.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-b105v2.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-b125pv2.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-b125v2.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-b155v2.dts  |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6dl-b1x5pv2.dtsi |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-b1x5v2.dtsi |    0
 .../dts/{ => nxp/imx}/imx6dl-colibri-aster.dts     |    0
 .../dts/{ => nxp/imx}/imx6dl-colibri-eval-v3.dts   |    0
 .../dts/{ => nxp/imx}/imx6dl-colibri-iris-v2.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-colibri-iris.dts |    0
 .../{ => nxp/imx}/imx6dl-cubox-i-emmc-som-v15.dts  |    0
 .../dts/{ => nxp/imx}/imx6dl-cubox-i-som-v15.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-cubox-i.dts |    0
 .../dts/{ => nxp/imx}/imx6dl-dfi-fs700-m60.dts     |    0
 .../dts/{ => nxp/imx}/imx6dl-dhcom-picoitx.dts     |    0
 .../dts/{ => nxp/imx}/imx6dl-eckelmann-ci4x10.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-emcon-avari.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw51xx.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw52xx.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw53xx.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw54xx.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw551x.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw552x.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw553x.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw560x.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw5903.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw5904.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw5907.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw5910.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw5912.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-gw5913.dts  |    0
 .../imx}/imx6dl-hummingboard-emmc-som-v15.dts      |    0
 .../{ => nxp/imx}/imx6dl-hummingboard-som-v15.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-hummingboard.dts |    0
 .../imx}/imx6dl-hummingboard2-emmc-som-v15.dts     |    0
 .../{ => nxp/imx}/imx6dl-hummingboard2-som-v15.dts |    0
 .../dts/{ => nxp/imx}/imx6dl-hummingboard2.dts     |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-icore-mipi.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-icore-rqs.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-icore.dts   |    0
 .../dts/{ => nxp/imx}/imx6dl-kontron-samx6i.dtsi   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-lanmcu.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-mamoj.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-mba6.dtsi   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-mba6a.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-mba6b.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-nit6xlite.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-nitrogen6x.dts   |    0
 .../{ => nxp/imx}/imx6dl-phytec-mira-rdk-nand.dts  |    0
 .../dts/{ => nxp/imx}/imx6dl-phytec-pbab01.dts     |    0
 .../dts/{ => nxp/imx}/imx6dl-phytec-pfla02.dtsi    |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-pico-dwarf.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-pico-hobbit.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-pico-nymph.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-pico-pi.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-pinfunc.h   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-plybas.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-plym2m.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-prtmvt.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-prtrvt.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-prtvt7.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-qmx6.dtsi   |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-rex-basic.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-riotboard.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-sabreauto.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-sabrelite.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-sabresd.dts |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-savageboard.dts  |    0
 .../dts/{ => nxp/imx}/imx6dl-skov-revc-lt2.dts     |    0
 .../dts/{ => nxp/imx}/imx6dl-skov-revc-lt6.dts     |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-solidsense.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-tqma6a.dtsi |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-tqma6b.dtsi |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-ts4900.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-ts7970.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-tx6dl-comtft.dts |    0
 .../dts/{ => nxp/imx}/imx6dl-tx6s-8034-mb7.dts     |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-tx6s-8034.dts    |    0
 .../dts/{ => nxp/imx}/imx6dl-tx6s-8035-mb7.dts     |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-tx6s-8035.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-tx6u-801x.dts    |    0
 .../dts/{ => nxp/imx}/imx6dl-tx6u-8033-mb7.dts     |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-tx6u-8033.dts    |    0
 .../dts/{ => nxp/imx}/imx6dl-tx6u-80xx-mb7.dts     |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-tx6u-811x.dts    |    0
 .../dts/{ => nxp/imx}/imx6dl-tx6u-81xx-mb7.dts     |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-udoo.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-victgo.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl-vicut1.dts  |    0
 .../dts/{ => nxp/imx}/imx6dl-wandboard-revb1.dts   |    0
 .../dts/{ => nxp/imx}/imx6dl-wandboard-revd1.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-wandboard.dts    |    0
 .../dts/{ => nxp/imx}/imx6dl-yapp4-common.dtsi     |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-yapp4-draco.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-yapp4-hydra.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-yapp4-lynx.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-yapp4-orion.dts  |    0
 .../dts/{ => nxp/imx}/imx6dl-yapp4-phoenix.dts     |    0
 .../boot/dts/{ => nxp/imx}/imx6dl-yapp4-ursa.dts   |    0
 .../dts/{ => nxp/imx}/imx6dl-yapp43-common.dtsi    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6dl.dtsi        |    0
 .../boot/dts/{ => nxp/imx}/imx6q-apalis-eval.dts   |    0
 .../dts/{ => nxp/imx}/imx6q-apalis-ixora-v1.1.dts  |    0
 .../dts/{ => nxp/imx}/imx6q-apalis-ixora-v1.2.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6q-apalis-ixora.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-apf6dev.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-arm2.dts     |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-b450v3.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-b650v3.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-b850v3.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-ba16.dtsi    |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6q-bosch-acc.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-bx50v3.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-cm-fx6.dts   |    0
 .../{ => nxp/imx}/imx6q-cubox-i-emmc-som-v15.dts   |    0
 .../dts/{ => nxp/imx}/imx6q-cubox-i-som-v15.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-cubox-i.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6q-dfi-fs700-m60.dts |    0
 .../boot/dts/{ => nxp/imx}/imx6q-dhcom-pdk2.dts    |    0
 .../imx}/imx6q-display5-tianma-tm070-1280x768.dts  |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6q-display5.dtsi |    0
 .../boot/dts/{ => nxp/imx}/imx6q-dmo-edmqmx6.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-dms-ba16.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-ds.dts       |    0
 .../boot/dts/{ => nxp/imx}/imx6q-emcon-avari.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-evi.dts      |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gk802.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw51xx.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw52xx.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw53xx.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw5400-a.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw54xx.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw551x.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw552x.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw553x.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw560x.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw5903.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw5904.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw5907.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw5910.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw5912.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-gw5913.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-h100.dts     |    0
 .../imx}/imx6q-hummingboard-emmc-som-v15.dts       |    0
 .../{ => nxp/imx}/imx6q-hummingboard-som-v15.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6q-hummingboard.dts  |    0
 .../imx}/imx6q-hummingboard2-emmc-som-v15.dts      |    0
 .../{ => nxp/imx}/imx6q-hummingboard2-som-v15.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6q-hummingboard2.dts |    0
 .../boot/dts/{ => nxp/imx}/imx6q-icore-mipi.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6q-icore-ofcap10.dts |    0
 .../boot/dts/{ => nxp/imx}/imx6q-icore-ofcap12.dts |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6q-icore-rqs.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-icore.dts    |    0
 .../dts/{ => nxp/imx}/imx6q-kontron-samx6i.dtsi    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-kp-tpc.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-kp.dtsi      |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-logicpd.dts  |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6q-marsboard.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-mba6.dtsi    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-mba6a.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-mba6b.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-mccmon6.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6q-nitrogen6_max.dts |    0
 .../dts/{ => nxp/imx}/imx6q-nitrogen6_som2.dts     |    0
 .../boot/dts/{ => nxp/imx}/imx6q-nitrogen6x.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-novena.dts   |    0
 .../{ => nxp/imx}/imx6q-phytec-mira-rdk-emmc.dts   |    0
 .../{ => nxp/imx}/imx6q-phytec-mira-rdk-nand.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6q-phytec-pbab01.dts |    0
 .../dts/{ => nxp/imx}/imx6q-phytec-pfla02.dtsi     |    0
 .../boot/dts/{ => nxp/imx}/imx6q-pico-dwarf.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6q-pico-hobbit.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6q-pico-nymph.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-pico-pi.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-pinfunc.h    |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6q-pistachio.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-prti6q.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-prtwd2.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-rex-pro.dts  |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6q-sabreauto.dts |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6q-sabrelite.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-sabresd.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6q-savageboard.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-sbc6x.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6q-skov-revc-lt2.dts |    0
 .../boot/dts/{ => nxp/imx}/imx6q-skov-revc-lt6.dts |    0
 .../imx}/imx6q-skov-reve-mi1010ait-1cp1.dts        |    0
 .../boot/dts/{ => nxp/imx}/imx6q-solidsense.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-tbs2910.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-tqma6a.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-tqma6b.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-ts4900.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-ts7970.dts   |    0
 .../dts/{ => nxp/imx}/imx6q-tx6q-1010-comtft.dts   |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6q-tx6q-1010.dts |    0
 .../dts/{ => nxp/imx}/imx6q-tx6q-1020-comtft.dts   |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6q-tx6q-1020.dts |    0
 .../boot/dts/{ => nxp/imx}/imx6q-tx6q-1036-mb7.dts |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6q-tx6q-1036.dts |    0
 .../boot/dts/{ => nxp/imx}/imx6q-tx6q-10x0-mb7.dts |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6q-tx6q-1110.dts |    0
 .../boot/dts/{ => nxp/imx}/imx6q-tx6q-11x0-mb7.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-udoo.dts     |    0
 .../boot/dts/{ => nxp/imx}/imx6q-utilite-pro.dts   |    0
 .../dts/{ => nxp/imx}/imx6q-var-dt6customboard.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-vicut1.dts   |    0
 .../dts/{ => nxp/imx}/imx6q-wandboard-revb1.dts    |    0
 .../dts/{ => nxp/imx}/imx6q-wandboard-revd1.dts    |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6q-wandboard.dts |    0
 .../boot/dts/{ => nxp/imx}/imx6q-yapp4-crux.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6q-yapp4-pegasus.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q-zii-rdu2.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6q.dtsi         |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-apalis.dtsi |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qdl-apf6.dtsi  |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-apf6dev.dtsi    |    0
 .../dts/{ => nxp/imx}/imx6qdl-aristainetos.dtsi    |    0
 .../dts/{ => nxp/imx}/imx6qdl-aristainetos2.dtsi   |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-colibri.dtsi    |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-cubox-i.dtsi    |    0
 .../dts/{ => nxp/imx}/imx6qdl-dfi-fs700-m60.dtsi   |    0
 .../dts/{ => nxp/imx}/imx6qdl-dhcom-drc02.dtsi     |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-dhcom-pdk2.dtsi |    0
 .../dts/{ => nxp/imx}/imx6qdl-dhcom-picoitx.dtsi   |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-dhcom-som.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qdl-ds.dtsi    |    0
 .../dts/{ => nxp/imx}/imx6qdl-emcon-avari.dtsi     |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qdl-emcon.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw51xx.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw52xx.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw53xx.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw54xx.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw551x.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw552x.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw553x.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw560x.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw5903.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw5904.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw5907.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw5910.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw5912.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-gw5913.dtsi |    0
 .../dts/{ => nxp/imx}/imx6qdl-hummingboard.dtsi    |    0
 .../{ => nxp/imx}/imx6qdl-hummingboard2-emmc.dtsi  |    0
 .../dts/{ => nxp/imx}/imx6qdl-hummingboard2.dtsi   |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-icore-1.5.dtsi  |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-icore-rqs.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qdl-icore.dtsi |    0
 .../dts/{ => nxp/imx}/imx6qdl-kontron-samx6i.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qdl-mba6.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qdl-mba6a.dtsi |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qdl-mba6b.dtsi |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-nit6xlite.dtsi  |    0
 .../dts/{ => nxp/imx}/imx6qdl-nitrogen6_max.dtsi   |    0
 .../dts/{ => nxp/imx}/imx6qdl-nitrogen6_som2.dtsi  |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-nitrogen6x.dtsi |    0
 .../imx}/imx6qdl-phytec-mira-peb-av-02.dtsi        |    0
 .../imx}/imx6qdl-phytec-mira-peb-eval-01.dtsi      |    0
 .../imx}/imx6qdl-phytec-mira-peb-wlbt-05.dtsi      |    0
 .../dts/{ => nxp/imx}/imx6qdl-phytec-mira.dtsi     |    0
 .../dts/{ => nxp/imx}/imx6qdl-phytec-pbab01.dtsi   |    0
 .../dts/{ => nxp/imx}/imx6qdl-phytec-pfla02.dtsi   |    0
 .../{ => nxp/imx}/imx6qdl-phytec-phycore-som.dtsi  |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-pico-dwarf.dtsi |    0
 .../dts/{ => nxp/imx}/imx6qdl-pico-hobbit.dtsi     |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-pico-nymph.dtsi |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-pico-pi.dtsi    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qdl-pico.dtsi  |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-prti6q.dtsi |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qdl-rex.dtsi   |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-sabreauto.dtsi  |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-sabrelite.dtsi  |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-sabresd.dtsi    |    0
 .../dts/{ => nxp/imx}/imx6qdl-savageboard.dtsi     |    0
 .../dts/{ => nxp/imx}/imx6qdl-skov-cpu-revc.dtsi   |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-skov-cpu.dtsi   |    0
 .../dts/{ => nxp/imx}/imx6qdl-skov-revc-lt2.dtsi   |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-solidsense.dtsi |    0
 .../dts/{ => nxp/imx}/imx6qdl-sr-som-brcm.dtsi     |    0
 .../dts/{ => nxp/imx}/imx6qdl-sr-som-emmc.dtsi     |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-sr-som-ti.dtsi  |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-sr-som.dtsi |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qdl-tqma6.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-tqma6a.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-tqma6b.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-ts4900.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-ts7970.dtsi |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-tx6-lcd.dtsi    |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-tx6-lvds.dtsi   |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-tx6-mb7.dtsi    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qdl-tx6.dtsi   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qdl-udoo.dtsi  |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-var-dart.dtsi   |    0
 .../dts/{ => nxp/imx}/imx6qdl-vicut1-12inch.dtsi   |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qdl-vicut1.dtsi |    0
 .../dts/{ => nxp/imx}/imx6qdl-wandboard-revb1.dtsi |    0
 .../dts/{ => nxp/imx}/imx6qdl-wandboard-revc1.dtsi |    0
 .../dts/{ => nxp/imx}/imx6qdl-wandboard-revd1.dtsi |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-wandboard.dtsi  |    0
 .../boot/dts/{ => nxp/imx}/imx6qdl-zii-rdu2.dtsi   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qdl.dtsi       |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qp-mba6b.dts   |    0
 .../dts/{ => nxp/imx}/imx6qp-nitrogen6_max.dts     |    0
 .../dts/{ => nxp/imx}/imx6qp-nitrogen6_som2.dts    |    0
 .../{ => nxp/imx}/imx6qp-phytec-mira-rdk-nand.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qp-prtwd3.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6qp-sabreauto.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qp-sabresd.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qp-tqma6b.dtsi |    0
 .../dts/{ => nxp/imx}/imx6qp-tx6qp-8037-mb7.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6qp-tx6qp-8037.dts   |    0
 .../dts/{ => nxp/imx}/imx6qp-tx6qp-8137-mb7.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6qp-tx6qp-8137.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qp-vicutp.dts  |    0
 .../dts/{ => nxp/imx}/imx6qp-wandboard-revd1.dts   |    0
 .../dts/{ => nxp/imx}/imx6qp-yapp4-crux-plus.dts   |    0
 .../{ => nxp/imx}/imx6qp-yapp4-pegasus-plus.dts    |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6qp-zii-rdu2.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6qp.dtsi        |    0
 .../boot/dts/{ => nxp/imx}/imx6s-dhcom-drc02.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6sl-evk.dts     |    0
 .../boot/dts/{ => nxp/imx}/imx6sl-kobo-aura2.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6sl-pinfunc.h   |    0
 .../dts/{ => nxp/imx}/imx6sl-tolino-shine2hd.dts   |    0
 .../dts/{ => nxp/imx}/imx6sl-tolino-shine3.dts     |    0
 .../dts/{ => nxp/imx}/imx6sl-tolino-vision.dts     |    0
 .../dts/{ => nxp/imx}/imx6sl-tolino-vision5.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6sl-warp.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6sl.dtsi        |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6sll-evk.dts    |    0
 .../dts/{ => nxp/imx}/imx6sll-kobo-clarahd.dts     |    0
 .../dts/{ => nxp/imx}/imx6sll-kobo-librah2o.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6sll-pinfunc.h  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6sll.dtsi       |    0
 .../boot/dts/{ => nxp/imx}/imx6sx-nitrogen6sx.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6sx-pinfunc.h   |    0
 .../boot/dts/{ => nxp/imx}/imx6sx-sabreauto.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6sx-sdb-mqs.dts |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6sx-sdb-reva.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6sx-sdb-sai.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6sx-sdb.dts     |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6sx-sdb.dtsi    |    0
 .../{ => nxp/imx}/imx6sx-softing-vining-2000.dts   |    0
 .../dts/{ => nxp/imx}/imx6sx-udoo-neo-basic.dts    |    0
 .../dts/{ => nxp/imx}/imx6sx-udoo-neo-extended.dts |    0
 .../dts/{ => nxp/imx}/imx6sx-udoo-neo-full.dts     |    0
 .../boot/dts/{ => nxp/imx}/imx6sx-udoo-neo.dtsi    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6sx.dtsi        |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-14x14-evk.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-14x14-evk.dtsi   |    0
 .../{ => nxp/imx}/imx6ul-ccimx6ulsbcexpress.dts    |    0
 .../dts/{ => nxp/imx}/imx6ul-ccimx6ulsbcpro.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-ccimx6ulsom.dtsi |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6ul-geam.dts    |    0
 .../dts/{ => nxp/imx}/imx6ul-imx6ull-opos6ul.dtsi  |    0
 .../{ => nxp/imx}/imx6ul-imx6ull-opos6uldev.dtsi   |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-isiot-emmc.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-isiot-nand.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6ul-isiot.dtsi  |    0
 .../dts/{ => nxp/imx}/imx6ul-kontron-bl-43.dts     |    0
 .../{ => nxp/imx}/imx6ul-kontron-bl-common.dtsi    |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-kontron-bl.dts   |    0
 .../{ => nxp/imx}/imx6ul-kontron-sl-common.dtsi    |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-kontron-sl.dtsi  |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-liteboard.dts    |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6ul-litesom.dtsi |    0
 .../arm/boot/dts/{ => nxp/imx}/imx6ul-opos6ul.dtsi |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-opos6uldev.dts   |    0
 .../{ => nxp/imx}/imx6ul-phytec-phycore-som.dtsi   |    0
 .../imx}/imx6ul-phytec-segin-ff-rdk-emmc.dts       |    0
 .../imx}/imx6ul-phytec-segin-ff-rdk-nand.dts       |    0
 .../imx}/imx6ul-phytec-segin-peb-av-02.dtsi        |    0
 .../imx}/imx6ul-phytec-segin-peb-eval-01.dtsi      |    0
 .../imx}/imx6ul-phytec-segin-peb-wlbt-05.dtsi      |    0
 .../dts/{ => nxp/imx}/imx6ul-phytec-segin.dtsi     |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-pico-dwarf.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-pico-hobbit.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6ul-pico-pi.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6ul-pico.dtsi   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6ul-pinfunc.h   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6ul-prti6g.dts  |    0
 .../dts/{ => nxp/imx}/imx6ul-tqma6ul-common.dtsi   |    0
 .../dts/{ => nxp/imx}/imx6ul-tqma6ul1-mba6ulx.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-tqma6ul1.dtsi    |    0
 .../dts/{ => nxp/imx}/imx6ul-tqma6ul2-mba6ulx.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-tqma6ul2.dtsi    |    0
 .../dts/{ => nxp/imx}/imx6ul-tqma6ul2l-mba6ulx.dts |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-tqma6ul2l.dtsi   |    0
 .../dts/{ => nxp/imx}/imx6ul-tqma6ulx-common.dtsi  |    0
 .../dts/{ => nxp/imx}/imx6ul-tqma6ulxl-common.dtsi |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-tx6ul-0010.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6ul-tx6ul-0011.dts   |    0
 .../dts/{ => nxp/imx}/imx6ul-tx6ul-mainboard.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6ul-tx6ul.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6ul.dtsi        |    0
 .../boot/dts/{ => nxp/imx}/imx6ull-14x14-evk.dts   |    0
 .../dts/{ => nxp/imx}/imx6ull-colibri-aster.dts    |    0
 .../dts/{ => nxp/imx}/imx6ull-colibri-aster.dtsi   |    0
 .../{ => nxp/imx}/imx6ull-colibri-emmc-aster.dts   |    0
 .../{ => nxp/imx}/imx6ull-colibri-emmc-eval-v3.dts |    0
 .../{ => nxp/imx}/imx6ull-colibri-emmc-iris-v2.dts |    0
 .../{ => nxp/imx}/imx6ull-colibri-emmc-iris.dts    |    0
 .../imx}/imx6ull-colibri-emmc-nonwifi.dtsi         |    0
 .../dts/{ => nxp/imx}/imx6ull-colibri-eval-v3.dts  |    0
 .../dts/{ => nxp/imx}/imx6ull-colibri-eval-v3.dtsi |    0
 .../dts/{ => nxp/imx}/imx6ull-colibri-iris-v2.dts  |    0
 .../dts/{ => nxp/imx}/imx6ull-colibri-iris-v2.dtsi |    0
 .../dts/{ => nxp/imx}/imx6ull-colibri-iris.dts     |    0
 .../dts/{ => nxp/imx}/imx6ull-colibri-iris.dtsi    |    0
 .../dts/{ => nxp/imx}/imx6ull-colibri-nonwifi.dtsi |    0
 .../{ => nxp/imx}/imx6ull-colibri-wifi-aster.dts   |    0
 .../{ => nxp/imx}/imx6ull-colibri-wifi-eval-v3.dts |    0
 .../{ => nxp/imx}/imx6ull-colibri-wifi-iris-v2.dts |    0
 .../{ => nxp/imx}/imx6ull-colibri-wifi-iris.dts    |    0
 .../dts/{ => nxp/imx}/imx6ull-colibri-wifi.dtsi    |    0
 .../boot/dts/{ => nxp/imx}/imx6ull-colibri.dtsi    |    0
 .../boot/dts/{ => nxp/imx}/imx6ull-dhcom-drc02.dts |    0
 .../boot/dts/{ => nxp/imx}/imx6ull-dhcom-pdk2.dts  |    0
 .../dts/{ => nxp/imx}/imx6ull-dhcom-picoitx.dts    |    0
 .../imx}/imx6ull-dhcom-som-cfg-sdcard.dtsi         |    0
 .../boot/dts/{ => nxp/imx}/imx6ull-dhcom-som.dtsi  |    0
 .../boot/dts/{ => nxp/imx}/imx6ull-dhcor-som.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6ull-jozacp.dts |    0
 .../boot/dts/{ => nxp/imx}/imx6ull-kontron-bl.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx6ull-kontron-sl.dtsi |    0
 .../{ => nxp/imx}/imx6ull-myir-mys-6ulx-eval.dts   |    0
 .../dts/{ => nxp/imx}/imx6ull-myir-mys-6ulx.dtsi   |    0
 .../boot/dts/{ => nxp/imx}/imx6ull-opos6ul.dtsi    |    0
 .../boot/dts/{ => nxp/imx}/imx6ull-opos6uldev.dts  |    0
 .../{ => nxp/imx}/imx6ull-phytec-phycore-som.dtsi  |    0
 .../imx}/imx6ull-phytec-segin-ff-rdk-emmc.dts      |    0
 .../imx}/imx6ull-phytec-segin-ff-rdk-nand.dts      |    0
 .../imx}/imx6ull-phytec-segin-lc-rdk-nand.dts      |    0
 .../imx}/imx6ull-phytec-segin-peb-av-02.dtsi       |    0
 .../imx}/imx6ull-phytec-segin-peb-eval-01.dtsi     |    0
 .../imx}/imx6ull-phytec-segin-peb-wlbt-05.dtsi     |    0
 .../dts/{ => nxp/imx}/imx6ull-phytec-segin.dtsi    |    0
 .../{ => nxp/imx}/imx6ull-phytec-tauri-emmc.dts    |    0
 .../{ => nxp/imx}/imx6ull-phytec-tauri-nand.dts    |    0
 .../dts/{ => nxp/imx}/imx6ull-phytec-tauri.dtsi    |    0
 .../boot/dts/{ => nxp/imx}/imx6ull-pinfunc-snvs.h  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6ull-pinfunc.h  |    0
 .../dts/{ => nxp/imx}/imx6ull-tarragon-common.dtsi |    0
 .../dts/{ => nxp/imx}/imx6ull-tarragon-master.dts  |    0
 .../dts/{ => nxp/imx}/imx6ull-tarragon-micro.dts   |    0
 .../dts/{ => nxp/imx}/imx6ull-tarragon-slave.dts   |    0
 .../dts/{ => nxp/imx}/imx6ull-tarragon-slavext.dts |    0
 .../{ => nxp/imx}/imx6ull-tqma6ull2-mba6ulx.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx6ull-tqma6ull2.dtsi  |    0
 .../{ => nxp/imx}/imx6ull-tqma6ull2l-mba6ulx.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6ull-tqma6ull2l.dtsi |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6ull.dtsi       |    0
 .../boot/dts/{ => nxp/imx}/imx6ulz-14x14-evk.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx6ulz-bsh-smm-m2.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx6ulz.dtsi       |    0
 .../boot/dts/{ => nxp/imx}/imx7-colibri-aster.dtsi |    0
 .../dts/{ => nxp/imx}/imx7-colibri-eval-v3.dtsi    |    0
 .../dts/{ => nxp/imx}/imx7-colibri-iris-v2.dtsi    |    0
 .../boot/dts/{ => nxp/imx}/imx7-colibri-iris.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7-colibri.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7-mba7.dtsi     |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7-tqma7.dtsi    |    0
 .../boot/dts/{ => nxp/imx}/imx7d-cl-som-imx7.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx7d-colibri-aster.dts |    0
 .../dts/{ => nxp/imx}/imx7d-colibri-emmc-aster.dts |    0
 .../{ => nxp/imx}/imx7d-colibri-emmc-eval-v3.dts   |    0
 .../{ => nxp/imx}/imx7d-colibri-emmc-iris-v2.dts   |    0
 .../dts/{ => nxp/imx}/imx7d-colibri-emmc-iris.dts  |    0
 .../boot/dts/{ => nxp/imx}/imx7d-colibri-emmc.dtsi |    0
 .../dts/{ => nxp/imx}/imx7d-colibri-eval-v3.dts    |    0
 .../dts/{ => nxp/imx}/imx7d-colibri-iris-v2.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx7d-colibri-iris.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7d-colibri.dtsi |    0
 .../{ => nxp/imx}/imx7d-flex-concentrator-mfg.dts  |    0
 .../dts/{ => nxp/imx}/imx7d-flex-concentrator.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7d-mba7.dts     |    0
 .../arm/boot/dts/{ => nxp/imx}/imx7d-meerkat96.dts |    0
 .../arm/boot/dts/{ => nxp/imx}/imx7d-nitrogen7.dts |    0
 .../boot/dts/{ => nxp/imx}/imx7d-pico-dwarf.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx7d-pico-hobbit.dts   |    0
 .../boot/dts/{ => nxp/imx}/imx7d-pico-nymph.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7d-pico-pi.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7d-pico.dtsi    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7d-pinfunc.h    |    0
 .../boot/dts/{ => nxp/imx}/imx7d-remarkable2.dts   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7d-sbc-imx7.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7d-sdb-reva.dts |    0
 .../arm/boot/dts/{ => nxp/imx}/imx7d-sdb-sht11.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7d-sdb.dts      |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7d-smegw01.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7d-tqma7.dtsi   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7d-zii-rmu2.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7d-zii-rpu2.dts |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7d.dtsi         |    0
 .../boot/dts/{ => nxp/imx}/imx7s-colibri-aster.dts |    0
 .../dts/{ => nxp/imx}/imx7s-colibri-eval-v3.dts    |    0
 .../dts/{ => nxp/imx}/imx7s-colibri-iris-v2.dts    |    0
 .../boot/dts/{ => nxp/imx}/imx7s-colibri-iris.dts  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7s-colibri.dtsi |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7s-mba7.dts     |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7s-tqma7.dtsi   |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7s-warp.dts     |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7s.dtsi         |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7ulp-com.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7ulp-evk.dts    |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7ulp-pinfunc.h  |    0
 arch/arm/boot/dts/{ => nxp/imx}/imx7ulp.dtsi       |    0
 arch/arm/boot/dts/{ => nxp/imx}/imxrt1050-evk.dts  |    0
 .../arm/boot/dts/{ => nxp/imx}/imxrt1050-pinfunc.h |    0
 arch/arm/boot/dts/{ => nxp/imx}/imxrt1050.dtsi     |    2 +-
 .../arm/boot/dts/{ => nxp/imx}/imxrt1170-pinfunc.h |    0
 arch/arm/boot/dts/{ => nxp/imx}/mba6ulx.dtsi       |    0
 arch/arm/boot/dts/nxp/lpc/Makefile                 |    9 +
 arch/arm/boot/dts/{ => nxp/lpc}/lpc18xx.dtsi       |    2 +-
 arch/arm/boot/dts/{ => nxp/lpc}/lpc3250-ea3250.dts |    0
 .../arm/boot/dts/{ => nxp/lpc}/lpc3250-phy3250.dts |    0
 arch/arm/boot/dts/{ => nxp/lpc}/lpc32xx.dtsi       |    0
 arch/arm/boot/dts/{ => nxp/lpc}/lpc4337-ciaa.dts   |    0
 .../boot/dts/{ => nxp/lpc}/lpc4350-hitex-eval.dts  |    0
 arch/arm/boot/dts/{ => nxp/lpc}/lpc4350.dtsi       |    0
 .../dts/{ => nxp/lpc}/lpc4357-ea4357-devkit.dts    |    0
 .../boot/dts/{ => nxp/lpc}/lpc4357-myd-lpc4357.dts |    0
 arch/arm/boot/dts/{ => nxp/lpc}/lpc4357.dtsi       |    0
 arch/arm/boot/dts/nxp/ls/Makefile                  |    7 +
 arch/arm/boot/dts/{ => nxp/ls}/ls1021a-iot.dts     |    0
 .../dts/{ => nxp/ls}/ls1021a-moxa-uc-8410a.dts     |    0
 arch/arm/boot/dts/{ => nxp/ls}/ls1021a-qds.dts     |    0
 arch/arm/boot/dts/{ => nxp/ls}/ls1021a-tsn.dts     |    0
 arch/arm/boot/dts/{ => nxp/ls}/ls1021a-twr.dts     |    0
 arch/arm/boot/dts/{ => nxp/ls}/ls1021a.dtsi        |    0
 arch/arm/boot/dts/nxp/mxs/Makefile                 |   31 +
 arch/arm/boot/dts/{ => nxp/mxs}/imx23-evk.dts      |    0
 .../arm/boot/dts/{ => nxp/mxs}/imx23-olinuxino.dts |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx23-pinfunc.h    |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx23-sansa.dts    |    0
 .../boot/dts/{ => nxp/mxs}/imx23-stmp378x_devb.dts |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx23-xfi3.dts     |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx23.dtsi         |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-apf28.dts    |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-apf28dev.dts |    0
 .../boot/dts/{ => nxp/mxs}/imx28-apx4devkit.dts    |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-cfa10036.dts |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-cfa10037.dts |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-cfa10049.dts |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-cfa10055.dts |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-cfa10056.dts |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-cfa10057.dts |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-cfa10058.dts |    0
 .../dts/{ => nxp/mxs}/imx28-duckbill-2-485.dts     |    0
 .../dts/{ => nxp/mxs}/imx28-duckbill-2-enocean.dts |    0
 .../dts/{ => nxp/mxs}/imx28-duckbill-2-spi.dts     |    0
 .../boot/dts/{ => nxp/mxs}/imx28-duckbill-2.dts    |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-duckbill.dts |    0
 .../dts/{ => nxp/mxs}/imx28-eukrea-mbmx283lc.dts   |    0
 .../dts/{ => nxp/mxs}/imx28-eukrea-mbmx287lc.dts   |    0
 .../dts/{ => nxp/mxs}/imx28-eukrea-mbmx28lc.dtsi   |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-evk.dts      |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-lwe.dtsi     |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-m28.dtsi     |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-m28cu3.dts   |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-m28evk.dts   |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-pinfunc.h    |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-sps1.dts     |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-ts4600.dts   |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-tx28.dts     |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28-xea.dts      |    0
 arch/arm/boot/dts/{ => nxp/mxs}/imx28.dtsi         |    0
 arch/arm/boot/dts/{ => nxp/mxs}/mxs-pinfunc.h      |    0
 arch/arm/boot/dts/nxp/vf/Makefile                  |   16 +
 .../boot/dts/{ => nxp/vf}/vf-colibri-eval-v3.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf-colibri.dtsi     |    0
 .../dts/{ => nxp/vf}/vf500-colibri-eval-v3.dts     |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf500-colibri.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf500.dtsi          |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf610-bk4.dts       |    0
 .../dts/{ => nxp/vf}/vf610-colibri-eval-v3.dts     |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf610-colibri.dtsi  |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf610-cosmic.dts    |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf610-pinfunc.h     |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf610-twr.dts       |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf610-zii-cfu1.dts  |    0
 .../boot/dts/{ => nxp/vf}/vf610-zii-dev-rev-b.dts  |    0
 .../boot/dts/{ => nxp/vf}/vf610-zii-dev-rev-c.dts  |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf610-zii-dev.dtsi  |    0
 .../boot/dts/{ => nxp/vf}/vf610-zii-scu4-aib.dts   |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf610-zii-spb4.dts  |    0
 .../boot/dts/{ => nxp/vf}/vf610-zii-ssmb-dtu.dts   |    0
 .../boot/dts/{ => nxp/vf}/vf610-zii-ssmb-spu3.dts  |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf610.dtsi          |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf610m4-colibri.dts |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf610m4-cosmic.dts  |    0
 arch/arm/boot/dts/{ => nxp/vf}/vf610m4.dtsi        |    2 +-
 arch/arm/boot/dts/{ => nxp/vf}/vfxxx.dtsi          |    0
 arch/arm/boot/dts/qcom/Makefile                    |   44 +
 arch/arm/boot/dts/{ => qcom}/qcom-apq8016-sbc.dts  |    0
 .../dts/{ => qcom}/qcom-apq8026-asus-sparrow.dts   |    0
 .../{ => qcom}/qcom-apq8026-huawei-sturgeon.dts    |    0
 .../boot/dts/{ => qcom}/qcom-apq8026-lg-lenok.dts  |    0
 .../qcom-apq8026-samsung-matisse-wifi.dts          |    0
 .../dts/{ => qcom}/qcom-apq8060-dragonboard.dts    |    0
 .../{ => qcom}/qcom-apq8064-asus-nexus7-flo.dts    |    0
 .../boot/dts/{ => qcom}/qcom-apq8064-cm-qs600.dts  |    0
 .../boot/dts/{ => qcom}/qcom-apq8064-ifc6410.dts   |    0
 .../arm/boot/dts/{ => qcom}/qcom-apq8064-pins.dtsi |    0
 .../qcom-apq8064-sony-xperia-lagan-yuga.dts        |    0
 .../arm/boot/dts/{ => qcom}/qcom-apq8064-v2.0.dtsi |    0
 arch/arm/boot/dts/{ => qcom}/qcom-apq8064.dtsi     |    0
 .../dts/{ => qcom}/qcom-apq8074-dragonboard.dts    |    0
 .../boot/dts/{ => qcom}/qcom-apq8084-ifc6540.dts   |    0
 arch/arm/boot/dts/{ => qcom}/qcom-apq8084-mtp.dts  |    0
 arch/arm/boot/dts/{ => qcom}/qcom-apq8084.dtsi     |    0
 .../dts/{ => qcom}/qcom-ipq4018-ap120c-ac-bit.dts  |    0
 .../boot/dts/{ => qcom}/qcom-ipq4018-ap120c-ac.dts |    0
 .../dts/{ => qcom}/qcom-ipq4018-ap120c-ac.dtsi     |    0
 .../boot/dts/{ => qcom}/qcom-ipq4018-jalapeno.dts  |    0
 .../dts/{ => qcom}/qcom-ipq4019-ap.dk01.1-c1.dts   |    0
 .../dts/{ => qcom}/qcom-ipq4019-ap.dk01.1.dtsi     |    0
 .../dts/{ => qcom}/qcom-ipq4019-ap.dk04.1-c1.dts   |    0
 .../dts/{ => qcom}/qcom-ipq4019-ap.dk04.1-c3.dts   |    0
 .../dts/{ => qcom}/qcom-ipq4019-ap.dk04.1.dtsi     |    0
 .../dts/{ => qcom}/qcom-ipq4019-ap.dk07.1-c1.dts   |    0
 .../dts/{ => qcom}/qcom-ipq4019-ap.dk07.1-c2.dts   |    0
 .../dts/{ => qcom}/qcom-ipq4019-ap.dk07.1.dtsi     |    0
 arch/arm/boot/dts/{ => qcom}/qcom-ipq4019.dtsi     |    0
 .../boot/dts/{ => qcom}/qcom-ipq8062-smb208.dtsi   |    0
 arch/arm/boot/dts/{ => qcom}/qcom-ipq8062.dtsi     |    0
 .../arm/boot/dts/{ => qcom}/qcom-ipq8064-ap148.dts |    0
 .../boot/dts/{ => qcom}/qcom-ipq8064-rb3011.dts    |    0
 .../boot/dts/{ => qcom}/qcom-ipq8064-smb208.dtsi   |    0
 .../arm/boot/dts/{ => qcom}/qcom-ipq8064-v1.0.dtsi |    0
 .../dts/{ => qcom}/qcom-ipq8064-v2.0-smb208.dtsi   |    0
 .../arm/boot/dts/{ => qcom}/qcom-ipq8064-v2.0.dtsi |    0
 arch/arm/boot/dts/{ => qcom}/qcom-ipq8064.dtsi     |    0
 .../boot/dts/{ => qcom}/qcom-ipq8065-smb208.dtsi   |    0
 arch/arm/boot/dts/{ => qcom}/qcom-ipq8065.dtsi     |    0
 .../qcom-mdm9615-wp8548-mangoh-green.dts           |    0
 .../boot/dts/{ => qcom}/qcom-mdm9615-wp8548.dtsi   |    0
 arch/arm/boot/dts/{ => qcom}/qcom-mdm9615.dtsi     |    0
 .../dts/{ => qcom}/qcom-msm8226-samsung-s3ve3g.dts |    0
 arch/arm/boot/dts/{ => qcom}/qcom-msm8226.dtsi     |    0
 arch/arm/boot/dts/{ => qcom}/qcom-msm8660-surf.dts |    0
 arch/arm/boot/dts/{ => qcom}/qcom-msm8660.dtsi     |    0
 .../dts/{ => qcom}/qcom-msm8916-samsung-e5.dts     |    0
 .../dts/{ => qcom}/qcom-msm8916-samsung-e7.dts     |    0
 .../{ => qcom}/qcom-msm8916-samsung-grandmax.dts   |    0
 .../{ => qcom}/qcom-msm8916-samsung-serranove.dts  |    0
 arch/arm/boot/dts/{ => qcom}/qcom-msm8916-smp.dtsi |    0
 arch/arm/boot/dts/{ => qcom}/qcom-msm8960-cdp.dts  |    0
 arch/arm/boot/dts/{ => qcom}/qcom-msm8960.dtsi     |    0
 .../qcom-msm8974-lge-nexus5-hammerhead.dts         |    0
 .../qcom-msm8974-sony-xperia-rhine-amami.dts       |    0
 .../qcom-msm8974-sony-xperia-rhine-honami.dts      |    0
 .../{ => qcom}/qcom-msm8974-sony-xperia-rhine.dtsi |    0
 arch/arm/boot/dts/{ => qcom}/qcom-msm8974.dtsi     |    0
 .../{ => qcom}/qcom-msm8974pro-fairphone-fp2.dts   |    0
 .../{ => qcom}/qcom-msm8974pro-oneplus-bacon.dts   |    0
 .../{ => qcom}/qcom-msm8974pro-samsung-klte.dts    |    0
 .../qcom-msm8974pro-sony-xperia-shinano-castor.dts |    0
 arch/arm/boot/dts/{ => qcom}/qcom-msm8974pro.dtsi  |    0
 arch/arm/boot/dts/{ => qcom}/qcom-pm8226.dtsi      |    0
 arch/arm/boot/dts/{ => qcom}/qcom-pm8841.dtsi      |    0
 arch/arm/boot/dts/{ => qcom}/qcom-pm8941.dtsi      |    0
 arch/arm/boot/dts/{ => qcom}/qcom-pma8084.dtsi     |    0
 arch/arm/boot/dts/{ => qcom}/qcom-pmx55.dtsi       |    0
 arch/arm/boot/dts/{ => qcom}/qcom-pmx65.dtsi       |    0
 arch/arm/boot/dts/{ => qcom}/qcom-sdx55-mtp.dts    |    0
 arch/arm/boot/dts/{ => qcom}/qcom-sdx55-t55.dts    |    0
 .../dts/{ => qcom}/qcom-sdx55-telit-fn980-tlb.dts  |    0
 arch/arm/boot/dts/{ => qcom}/qcom-sdx55.dtsi       |    0
 arch/arm/boot/dts/{ => qcom}/qcom-sdx65-mtp.dts    |    0
 arch/arm/boot/dts/{ => qcom}/qcom-sdx65.dtsi       |    0
 arch/arm/boot/dts/realtek/Makefile                 |    4 +
 .../boot/dts/{ => realtek}/rtd1195-horseradish.dts |    0
 .../boot/dts/{ => realtek}/rtd1195-mele-x1000.dts  |    0
 arch/arm/boot/dts/{ => realtek}/rtd1195.dtsi       |    0
 arch/arm/boot/dts/renesas/Makefile                 |   33 +
 arch/arm/boot/dts/{ => renesas}/emev2-kzm9d.dts    |    0
 arch/arm/boot/dts/{ => renesas}/emev2.dtsi         |    0
 .../{ => renesas}/gr-peach-audiocamerashield.dtsi  |    0
 .../boot/dts/{ => renesas}/iwg20d-q7-common.dtsi   |    0
 .../boot/dts/{ => renesas}/iwg20d-q7-dbcm-ca.dtsi  |    0
 .../arm/boot/dts/{ => renesas}/r7s72100-genmai.dts |    0
 .../boot/dts/{ => renesas}/r7s72100-gr-peach.dts   |    0
 .../boot/dts/{ => renesas}/r7s72100-rskrza1.dts    |    0
 arch/arm/boot/dts/{ => renesas}/r7s72100.dtsi      |    0
 .../boot/dts/{ => renesas}/r7s9210-rza2mevb.dts    |    0
 arch/arm/boot/dts/{ => renesas}/r7s9210.dtsi       |    0
 .../arm/boot/dts/{ => renesas}/r8a73a4-ape6evm.dts |    0
 arch/arm/boot/dts/{ => renesas}/r8a73a4.dtsi       |    0
 .../dts/{ => renesas}/r8a7740-armadillo800eva.dts  |    0
 arch/arm/boot/dts/{ => renesas}/r8a7740.dtsi       |    0
 .../{ => renesas}/r8a7742-iwg21d-q7-dbcm-ca.dts    |    0
 .../r8a7742-iwg21d-q7-dbcm-ov5640-single.dtsi      |    0
 .../r8a7742-iwg21d-q7-dbcm-ov7725-single.dtsi      |    0
 .../boot/dts/{ => renesas}/r8a7742-iwg21d-q7.dts   |    0
 .../arm/boot/dts/{ => renesas}/r8a7742-iwg21m.dtsi |    0
 arch/arm/boot/dts/{ => renesas}/r8a7742.dtsi       |    0
 .../{ => renesas}/r8a7743-iwg20d-q7-dbcm-ca.dts    |    0
 .../boot/dts/{ => renesas}/r8a7743-iwg20d-q7.dts   |    0
 .../arm/boot/dts/{ => renesas}/r8a7743-iwg20m.dtsi |    0
 .../boot/dts/{ => renesas}/r8a7743-sk-rzg1m.dts    |    0
 arch/arm/boot/dts/{ => renesas}/r8a7743.dtsi       |    0
 .../{ => renesas}/r8a7744-iwg20d-q7-dbcm-ca.dts    |    0
 .../boot/dts/{ => renesas}/r8a7744-iwg20d-q7.dts   |    0
 .../arm/boot/dts/{ => renesas}/r8a7744-iwg20m.dtsi |    0
 arch/arm/boot/dts/{ => renesas}/r8a7744.dtsi       |    0
 .../r8a7745-iwg22d-sodimm-dbhd-ca.dts              |    0
 .../dts/{ => renesas}/r8a7745-iwg22d-sodimm.dts    |    0
 .../arm/boot/dts/{ => renesas}/r8a7745-iwg22m.dtsi |    0
 .../boot/dts/{ => renesas}/r8a7745-sk-rzg1e.dts    |    0
 arch/arm/boot/dts/{ => renesas}/r8a7745.dtsi       |    0
 .../boot/dts/{ => renesas}/r8a77470-iwg23s-sbc.dts |    0
 arch/arm/boot/dts/{ => renesas}/r8a77470.dtsi      |    0
 arch/arm/boot/dts/{ => renesas}/r8a7778-bockw.dts  |    0
 arch/arm/boot/dts/{ => renesas}/r8a7778.dtsi       |    0
 arch/arm/boot/dts/{ => renesas}/r8a7779-marzen.dts |    0
 arch/arm/boot/dts/{ => renesas}/r8a7779.dtsi       |    0
 arch/arm/boot/dts/{ => renesas}/r8a7790-lager.dts  |    0
 arch/arm/boot/dts/{ => renesas}/r8a7790-stout.dts  |    0
 arch/arm/boot/dts/{ => renesas}/r8a7790.dtsi       |    0
 .../arm/boot/dts/{ => renesas}/r8a7791-koelsch.dts |    0
 arch/arm/boot/dts/{ => renesas}/r8a7791-porter.dts |    0
 arch/arm/boot/dts/{ => renesas}/r8a7791.dtsi       |    0
 .../arm/boot/dts/{ => renesas}/r8a7792-blanche.dts |    0
 arch/arm/boot/dts/{ => renesas}/r8a7792-wheat.dts  |    0
 arch/arm/boot/dts/{ => renesas}/r8a7792.dtsi       |    0
 arch/arm/boot/dts/{ => renesas}/r8a7793-gose.dts   |    0
 arch/arm/boot/dts/{ => renesas}/r8a7793.dtsi       |    0
 arch/arm/boot/dts/{ => renesas}/r8a7794-alt.dts    |    0
 arch/arm/boot/dts/{ => renesas}/r8a7794-silk.dts   |    0
 arch/arm/boot/dts/{ => renesas}/r8a7794.dtsi       |    0
 .../dts/{ => renesas}/r8a77xx-aa121td01-panel.dtsi |    0
 .../dts/{ => renesas}/r9a06g032-rzn1d400-db.dts    |    0
 arch/arm/boot/dts/{ => renesas}/r9a06g032.dtsi     |    0
 arch/arm/boot/dts/{ => renesas}/sh73a0-kzm9g.dts   |    0
 arch/arm/boot/dts/{ => renesas}/sh73a0.dtsi        |    0
 arch/arm/boot/dts/rockchip/Makefile                |   42 +
 arch/arm/boot/dts/{ => rockchip}/rk3036-evb.dts    |    0
 arch/arm/boot/dts/{ => rockchip}/rk3036-kylin.dts  |    0
 arch/arm/boot/dts/{ => rockchip}/rk3036.dtsi       |    0
 .../boot/dts/{ => rockchip}/rk3066a-bqcurie2.dts   |    2 +-
 .../boot/dts/{ => rockchip}/rk3066a-marsboard.dts  |    2 +-
 arch/arm/boot/dts/{ => rockchip}/rk3066a-mk808.dts |    0
 .../boot/dts/{ => rockchip}/rk3066a-rayeager.dts   |    2 +-
 arch/arm/boot/dts/{ => rockchip}/rk3066a.dtsi      |    0
 arch/arm/boot/dts/{ => rockchip}/rk3128-evb.dts    |    0
 arch/arm/boot/dts/{ => rockchip}/rk3128.dtsi       |    0
 .../boot/dts/{ => rockchip}/rk3188-bqedison2qc.dts |    0
 .../arm/boot/dts/{ => rockchip}/rk3188-px3-evb.dts |    0
 .../boot/dts/{ => rockchip}/rk3188-radxarock.dts   |    0
 arch/arm/boot/dts/{ => rockchip}/rk3188.dtsi       |    0
 arch/arm/boot/dts/{ => rockchip}/rk3228-evb.dts    |    0
 arch/arm/boot/dts/{ => rockchip}/rk3229-evb.dts    |    0
 arch/arm/boot/dts/{ => rockchip}/rk3229-xms6.dts   |    0
 arch/arm/boot/dts/{ => rockchip}/rk3229.dtsi       |    0
 arch/arm/boot/dts/{ => rockchip}/rk322x.dtsi       |    0
 .../boot/dts/{ => rockchip}/rk3288-evb-act8846.dts |    0
 .../boot/dts/{ => rockchip}/rk3288-evb-rk808.dts   |    0
 arch/arm/boot/dts/{ => rockchip}/rk3288-evb.dtsi   |    0
 .../dts/{ => rockchip}/rk3288-firefly-beta.dts     |    0
 .../{ => rockchip}/rk3288-firefly-reload-core.dtsi |    0
 .../dts/{ => rockchip}/rk3288-firefly-reload.dts   |    0
 .../arm/boot/dts/{ => rockchip}/rk3288-firefly.dts |    0
 .../boot/dts/{ => rockchip}/rk3288-firefly.dtsi    |    0
 arch/arm/boot/dts/{ => rockchip}/rk3288-miqi.dts   |    0
 .../boot/dts/{ => rockchip}/rk3288-phycore-rdk.dts |    0
 .../dts/{ => rockchip}/rk3288-phycore-som.dtsi     |    0
 .../boot/dts/{ => rockchip}/rk3288-popmetal.dts    |    0
 arch/arm/boot/dts/{ => rockchip}/rk3288-r89.dts    |    0
 .../boot/dts/{ => rockchip}/rk3288-rock-pi-n8.dts  |    2 +-
 .../boot/dts/{ => rockchip}/rk3288-rock2-som.dtsi  |    0
 .../dts/{ => rockchip}/rk3288-rock2-square.dts     |    0
 .../boot/dts/{ => rockchip}/rk3288-tinker-s.dts    |    0
 arch/arm/boot/dts/{ => rockchip}/rk3288-tinker.dts |    0
 .../arm/boot/dts/{ => rockchip}/rk3288-tinker.dtsi |    0
 .../{ => rockchip}/rk3288-veyron-analog-audio.dtsi |    0
 .../dts/{ => rockchip}/rk3288-veyron-brain.dts     |    0
 .../rk3288-veyron-broadcom-bluetooth.dtsi          |    0
 .../{ => rockchip}/rk3288-veyron-chromebook.dtsi   |    2 +-
 .../boot/dts/{ => rockchip}/rk3288-veyron-edp.dtsi |    0
 .../dts/{ => rockchip}/rk3288-veyron-fievel.dts    |    0
 .../boot/dts/{ => rockchip}/rk3288-veyron-jaq.dts  |    2 +-
 .../dts/{ => rockchip}/rk3288-veyron-jerry.dts     |    2 +-
 .../dts/{ => rockchip}/rk3288-veyron-mickey.dts    |    0
 .../dts/{ => rockchip}/rk3288-veyron-mighty.dts    |    0
 .../dts/{ => rockchip}/rk3288-veyron-minnie.dts    |    0
 .../dts/{ => rockchip}/rk3288-veyron-pinky.dts     |    2 +-
 .../dts/{ => rockchip}/rk3288-veyron-sdmmc.dtsi    |    0
 .../dts/{ => rockchip}/rk3288-veyron-speedy.dts    |    2 +-
 .../dts/{ => rockchip}/rk3288-veyron-tiger.dts     |    0
 .../arm/boot/dts/{ => rockchip}/rk3288-veyron.dtsi |    0
 .../boot/dts/{ => rockchip}/rk3288-vmarc-som.dtsi  |    0
 arch/arm/boot/dts/{ => rockchip}/rk3288-vyasa.dts  |    0
 arch/arm/boot/dts/{ => rockchip}/rk3288.dtsi       |    0
 arch/arm/boot/dts/{ => rockchip}/rk3xxx.dtsi       |    0
 .../rockchip-radxa-dalang-carrier.dtsi             |    0
 .../boot/dts/{ => rockchip}/rv1108-elgin-r1.dts    |    0
 arch/arm/boot/dts/{ => rockchip}/rv1108-evb.dts    |    0
 arch/arm/boot/dts/{ => rockchip}/rv1108.dtsi       |    0
 .../dts/{ => rockchip}/rv1126-edgeble-neu2-io.dts  |    0
 .../dts/{ => rockchip}/rv1126-edgeble-neu2.dtsi    |    0
 .../boot/dts/{ => rockchip}/rv1126-pinctrl.dtsi    |    0
 arch/arm/boot/dts/{ => rockchip}/rv1126.dtsi       |    0
 arch/arm/boot/dts/samsung/Makefile                 |   54 +
 .../{ => samsung}/exynos-mfc-reserved-memory.dtsi  |    0
 arch/arm/boot/dts/{ => samsung}/exynos-pinctrl.h   |    0
 .../dts/{ => samsung}/exynos-syscon-restart.dtsi   |    0
 .../dts/{ => samsung}/exynos3250-artik5-eval.dts   |    0
 .../boot/dts/{ => samsung}/exynos3250-artik5.dtsi  |    0
 .../arm/boot/dts/{ => samsung}/exynos3250-monk.dts |    0
 .../boot/dts/{ => samsung}/exynos3250-pinctrl.dtsi |    0
 .../boot/dts/{ => samsung}/exynos3250-rinato.dts   |    0
 arch/arm/boot/dts/{ => samsung}/exynos3250.dtsi    |    0
 .../dts/{ => samsung}/exynos4-cpu-thermal.dtsi     |    0
 arch/arm/boot/dts/{ => samsung}/exynos4.dtsi       |    0
 .../boot/dts/{ => samsung}/exynos4210-i9100.dts    |    0
 .../boot/dts/{ => samsung}/exynos4210-origen.dts   |    0
 .../boot/dts/{ => samsung}/exynos4210-pinctrl.dtsi |    0
 .../boot/dts/{ => samsung}/exynos4210-smdkv310.dts |    0
 .../boot/dts/{ => samsung}/exynos4210-trats.dts    |    0
 .../{ => samsung}/exynos4210-universal_c210.dts    |    0
 arch/arm/boot/dts/{ => samsung}/exynos4210.dtsi    |    0
 .../dts/{ => samsung}/exynos4412-galaxy-s3.dtsi    |    0
 .../boot/dts/{ => samsung}/exynos4412-i9300.dts    |    0
 .../boot/dts/{ => samsung}/exynos4412-i9305.dts    |    0
 .../dts/{ => samsung}/exynos4412-itop-elite.dts    |    0
 .../{ => samsung}/exynos4412-itop-scp-core.dtsi    |    0
 .../boot/dts/{ => samsung}/exynos4412-midas.dtsi   |    0
 .../boot/dts/{ => samsung}/exynos4412-n710x.dts    |    0
 .../{ => samsung}/exynos4412-odroid-common.dtsi    |    0
 .../boot/dts/{ => samsung}/exynos4412-odroidu3.dts |    0
 .../boot/dts/{ => samsung}/exynos4412-odroidx.dts  |    0
 .../boot/dts/{ => samsung}/exynos4412-odroidx2.dts |    0
 .../boot/dts/{ => samsung}/exynos4412-origen.dts   |    0
 .../dts/{ => samsung}/exynos4412-p4note-n8010.dts  |    0
 .../boot/dts/{ => samsung}/exynos4412-p4note.dtsi  |    0
 .../boot/dts/{ => samsung}/exynos4412-pinctrl.dtsi |    0
 .../dts/{ => samsung}/exynos4412-ppmu-common.dtsi  |    0
 .../boot/dts/{ => samsung}/exynos4412-prime.dtsi   |    0
 .../boot/dts/{ => samsung}/exynos4412-smdk4412.dts |    0
 .../boot/dts/{ => samsung}/exynos4412-tiny4412.dts |    0
 .../boot/dts/{ => samsung}/exynos4412-trats2.dts   |    0
 arch/arm/boot/dts/{ => samsung}/exynos4412.dtsi    |    0
 arch/arm/boot/dts/{ => samsung}/exynos5.dtsi       |    0
 .../boot/dts/{ => samsung}/exynos5250-arndale.dts  |    0
 .../boot/dts/{ => samsung}/exynos5250-pinctrl.dtsi |    0
 .../boot/dts/{ => samsung}/exynos5250-smdk5250.dts |    0
 .../dts/{ => samsung}/exynos5250-snow-common.dtsi  |    2 +-
 .../dts/{ => samsung}/exynos5250-snow-rev5.dts     |    0
 .../arm/boot/dts/{ => samsung}/exynos5250-snow.dts |    0
 .../boot/dts/{ => samsung}/exynos5250-spring.dts   |    2 +-
 arch/arm/boot/dts/{ => samsung}/exynos5250.dtsi    |    0
 .../boot/dts/{ => samsung}/exynos5260-pinctrl.dtsi |    0
 .../dts/{ => samsung}/exynos5260-xyref5260.dts     |    0
 arch/arm/boot/dts/{ => samsung}/exynos5260.dtsi    |    0
 .../boot/dts/{ => samsung}/exynos5410-odroidxu.dts |    0
 .../boot/dts/{ => samsung}/exynos5410-pinctrl.dtsi |    0
 .../boot/dts/{ => samsung}/exynos5410-smdk5410.dts |    0
 arch/arm/boot/dts/{ => samsung}/exynos5410.dtsi    |    0
 .../dts/{ => samsung}/exynos5420-arndale-octa.dts  |    0
 .../dts/{ => samsung}/exynos5420-chagall-wifi.dts  |    0
 .../boot/dts/{ => samsung}/exynos5420-cpus.dtsi    |    0
 .../exynos5420-galaxy-tab-common.dtsi              |    0
 .../dts/{ => samsung}/exynos5420-klimt-wifi.dts    |    0
 .../dts/{ => samsung}/exynos5420-peach-pit.dts     |    4 +-
 .../boot/dts/{ => samsung}/exynos5420-pinctrl.dtsi |    0
 .../boot/dts/{ => samsung}/exynos5420-smdk5420.dts |    0
 .../dts/{ => samsung}/exynos5420-trip-points.dtsi  |    0
 arch/arm/boot/dts/{ => samsung}/exynos5420.dtsi    |    0
 .../boot/dts/{ => samsung}/exynos5422-cpus.dtsi    |    0
 .../dts/{ => samsung}/exynos5422-odroid-core.dtsi  |    0
 .../dts/{ => samsung}/exynos5422-odroidhc1.dts     |    0
 .../{ => samsung}/exynos5422-odroidxu3-audio.dtsi  |    0
 .../{ => samsung}/exynos5422-odroidxu3-common.dtsi |    0
 .../{ => samsung}/exynos5422-odroidxu3-lite.dts    |    0
 .../dts/{ => samsung}/exynos5422-odroidxu3.dts     |    0
 .../dts/{ => samsung}/exynos5422-odroidxu4.dts     |    0
 .../dts/{ => samsung}/exynos5422-samsung-k3g.dts   |    0
 .../{ => samsung}/exynos54xx-odroidxu-leds.dtsi    |    0
 arch/arm/boot/dts/{ => samsung}/exynos54xx.dtsi    |    0
 .../boot/dts/{ => samsung}/exynos5800-peach-pi.dts |    4 +-
 arch/arm/boot/dts/{ => samsung}/exynos5800.dtsi    |    0
 arch/arm/boot/dts/{ => samsung}/s3c6400.dtsi       |    0
 .../boot/dts/{ => samsung}/s3c6410-mini6410.dts    |    0
 .../boot/dts/{ => samsung}/s3c6410-smdk6410.dts    |    0
 arch/arm/boot/dts/{ => samsung}/s3c6410.dtsi       |    0
 .../boot/dts/{ => samsung}/s3c64xx-pinctrl.dtsi    |    0
 arch/arm/boot/dts/{ => samsung}/s3c64xx-pinctrl.h  |    0
 arch/arm/boot/dts/{ => samsung}/s3c64xx.dtsi       |    0
 arch/arm/boot/dts/{ => samsung}/s5pv210-aquila.dts |    0
 arch/arm/boot/dts/{ => samsung}/s5pv210-aries.dtsi |    0
 .../boot/dts/{ => samsung}/s5pv210-fascinate4g.dts |    0
 .../arm/boot/dts/{ => samsung}/s5pv210-galaxys.dts |    0
 arch/arm/boot/dts/{ => samsung}/s5pv210-goni.dts   |    0
 .../boot/dts/{ => samsung}/s5pv210-pinctrl.dtsi    |    0
 arch/arm/boot/dts/{ => samsung}/s5pv210-pinctrl.h  |    0
 .../boot/dts/{ => samsung}/s5pv210-smdkc110.dts    |    0
 .../boot/dts/{ => samsung}/s5pv210-smdkv210.dts    |    0
 .../boot/dts/{ => samsung}/s5pv210-torbreck.dts    |    0
 arch/arm/boot/dts/{ => samsung}/s5pv210.dtsi       |    0
 arch/arm/boot/dts/sigmastar/Makefile               |   10 +
 .../mstar-infinity-breadbee-common.dtsi            |    0
 .../mstar-infinity-msc313-breadbee_crust.dts       |    0
 .../dts/{ => sigmastar}/mstar-infinity-msc313.dtsi |    0
 .../boot/dts/{ => sigmastar}/mstar-infinity.dtsi   |    0
 .../mstar-infinity2m-ssd201-som2d01.dtsi           |    0
 ...tar-infinity2m-ssd202d-100ask-dongshanpione.dts |    0
 .../mstar-infinity2m-ssd202d-miyoo-mini.dts        |    0
 .../mstar-infinity2m-ssd202d-ssd201htv2.dts        |    0
 .../mstar-infinity2m-ssd202d-unitv2.dts            |    0
 ...y2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts |    0
 ...infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi |    0
 .../{ => sigmastar}/mstar-infinity2m-ssd202d.dtsi  |    0
 .../{ => sigmastar}/mstar-infinity2m-ssd20xd.dtsi  |    0
 .../boot/dts/{ => sigmastar}/mstar-infinity2m.dtsi |    0
 .../mstar-infinity3-msc313e-breadbee.dts           |    0
 .../{ => sigmastar}/mstar-infinity3-msc313e.dtsi   |    0
 .../boot/dts/{ => sigmastar}/mstar-infinity3.dtsi  |    0
 .../mstar-mercury5-ssc8336n-midrived08.dts         |    0
 .../{ => sigmastar}/mstar-mercury5-ssc8336n.dtsi   |    0
 .../boot/dts/{ => sigmastar}/mstar-mercury5.dtsi   |    0
 arch/arm/boot/dts/{ => sigmastar}/mstar-v7.dtsi    |    0
 arch/arm/boot/dts/socionext/Makefile               |   13 +
 .../boot/dts/{ => socionext}/milbeaut-m10v-evb.dts |    0
 .../boot/dts/{ => socionext}/milbeaut-m10v.dtsi    |    0
 .../boot/dts/{ => socionext}/uniphier-ld4-ref.dts  |    0
 .../arm/boot/dts/{ => socionext}/uniphier-ld4.dtsi |    0
 .../boot/dts/{ => socionext}/uniphier-ld6b-ref.dts |    0
 .../boot/dts/{ => socionext}/uniphier-ld6b.dtsi    |    0
 .../boot/dts/{ => socionext}/uniphier-pinctrl.dtsi |    0
 .../boot/dts/{ => socionext}/uniphier-pro4-ace.dts |    0
 .../boot/dts/{ => socionext}/uniphier-pro4-ref.dts |    0
 .../dts/{ => socionext}/uniphier-pro4-sanji.dts    |    0
 .../boot/dts/{ => socionext}/uniphier-pro4.dtsi    |    0
 .../dts/{ => socionext}/uniphier-pro5-epcore.dts   |    0
 .../dts/{ => socionext}/uniphier-pro5-proex.dts    |    0
 .../boot/dts/{ => socionext}/uniphier-pro5.dtsi    |    0
 .../dts/{ => socionext}/uniphier-pxs2-gentil.dts   |    0
 .../dts/{ => socionext}/uniphier-pxs2-vodka.dts    |    0
 .../boot/dts/{ => socionext}/uniphier-pxs2.dtsi    |    0
 .../dts/{ => socionext}/uniphier-ref-daughter.dtsi |    0
 .../boot/dts/{ => socionext}/uniphier-sld8-ref.dts |    0
 .../boot/dts/{ => socionext}/uniphier-sld8.dtsi    |    0
 .../dts/{ => socionext}/uniphier-support-card.dtsi |    0
 arch/arm/boot/dts/st/Makefile                      |   73 +
 arch/arm/boot/dts/{ => st}/spear1310-evb.dts       |    0
 arch/arm/boot/dts/{ => st}/spear1310.dtsi          |    0
 arch/arm/boot/dts/{ => st}/spear1340-evb.dts       |    0
 arch/arm/boot/dts/{ => st}/spear1340.dtsi          |    0
 arch/arm/boot/dts/{ => st}/spear13xx.dtsi          |    0
 arch/arm/boot/dts/{ => st}/spear300-evb.dts        |    0
 arch/arm/boot/dts/{ => st}/spear300.dtsi           |    0
 arch/arm/boot/dts/{ => st}/spear310-evb.dts        |    0
 arch/arm/boot/dts/{ => st}/spear310.dtsi           |    0
 arch/arm/boot/dts/{ => st}/spear320-evb.dts        |    0
 arch/arm/boot/dts/{ => st}/spear320-hmi.dts        |    0
 arch/arm/boot/dts/{ => st}/spear320.dtsi           |    0
 arch/arm/boot/dts/{ => st}/spear320s.dtsi          |    0
 arch/arm/boot/dts/{ => st}/spear3xx.dtsi           |    0
 arch/arm/boot/dts/{ => st}/spear600-evb.dts        |    0
 arch/arm/boot/dts/{ => st}/spear600.dtsi           |    0
 arch/arm/boot/dts/{ => st}/st-pincfg.h             |    0
 arch/arm/boot/dts/{ => st}/ste-ab8500.dtsi         |    0
 arch/arm/boot/dts/{ => st}/ste-ab8505.dtsi         |    0
 arch/arm/boot/dts/{ => st}/ste-db8500.dtsi         |    0
 arch/arm/boot/dts/{ => st}/ste-db8520.dtsi         |    0
 arch/arm/boot/dts/{ => st}/ste-db9500.dtsi         |    0
 arch/arm/boot/dts/{ => st}/ste-dbx5x0-pinctrl.dtsi |    0
 arch/arm/boot/dts/{ => st}/ste-dbx5x0.dtsi         |    0
 arch/arm/boot/dts/{ => st}/ste-href-ab8500.dtsi    |    0
 .../boot/dts/{ => st}/ste-href-family-pinctrl.dtsi |    0
 arch/arm/boot/dts/{ => st}/ste-href-stuib.dtsi     |    0
 .../boot/dts/{ => st}/ste-href-tvk1281618-r2.dtsi  |    0
 .../boot/dts/{ => st}/ste-href-tvk1281618-r3.dtsi  |    0
 arch/arm/boot/dts/{ => st}/ste-href.dtsi           |    0
 arch/arm/boot/dts/{ => st}/ste-href520-tvk.dts     |    0
 .../arm/boot/dts/{ => st}/ste-hrefprev60-stuib.dts |    0
 arch/arm/boot/dts/{ => st}/ste-hrefprev60-tvk.dts  |    0
 arch/arm/boot/dts/{ => st}/ste-hrefprev60.dtsi     |    0
 .../boot/dts/{ => st}/ste-hrefv60plus-stuib.dts    |    0
 arch/arm/boot/dts/{ => st}/ste-hrefv60plus-tvk.dts |    0
 arch/arm/boot/dts/{ => st}/ste-hrefv60plus.dtsi    |    0
 arch/arm/boot/dts/{ => st}/ste-nomadik-nhk15.dts   |    0
 .../arm/boot/dts/{ => st}/ste-nomadik-pinctrl.dtsi |    0
 arch/arm/boot/dts/{ => st}/ste-nomadik-s8815.dts   |    0
 .../arm/boot/dts/{ => st}/ste-nomadik-stn8815.dtsi |    0
 arch/arm/boot/dts/{ => st}/ste-snowball.dts        |    0
 .../dts/{ => st}/ste-ux500-samsung-codina-tmo.dts  |    0
 .../boot/dts/{ => st}/ste-ux500-samsung-codina.dts |    0
 .../boot/dts/{ => st}/ste-ux500-samsung-gavini.dts |    0
 .../boot/dts/{ => st}/ste-ux500-samsung-golden.dts |    0
 .../boot/dts/{ => st}/ste-ux500-samsung-janice.dts |    0
 .../boot/dts/{ => st}/ste-ux500-samsung-kyle.dts   |    0
 .../boot/dts/{ => st}/ste-ux500-samsung-skomer.dts |    0
 arch/arm/boot/dts/{ => st}/stih407-b2120.dts       |    0
 arch/arm/boot/dts/{ => st}/stih407-clock.dtsi      |    0
 arch/arm/boot/dts/{ => st}/stih407-family.dtsi     |    0
 arch/arm/boot/dts/{ => st}/stih407-pinctrl.dtsi    |    0
 arch/arm/boot/dts/{ => st}/stih407.dtsi            |    0
 arch/arm/boot/dts/{ => st}/stih410-b2120.dts       |    0
 arch/arm/boot/dts/{ => st}/stih410-b2260.dts       |    0
 arch/arm/boot/dts/{ => st}/stih410-clock.dtsi      |    0
 arch/arm/boot/dts/{ => st}/stih410-pinctrl.dtsi    |    0
 arch/arm/boot/dts/{ => st}/stih410.dtsi            |    0
 arch/arm/boot/dts/{ => st}/stih418-b2199.dts       |    0
 arch/arm/boot/dts/{ => st}/stih418-b2264.dts       |    0
 arch/arm/boot/dts/{ => st}/stih418-clock.dtsi      |    0
 arch/arm/boot/dts/{ => st}/stih418.dtsi            |    0
 arch/arm/boot/dts/{ => st}/stihxxx-b2120.dtsi      |    0
 arch/arm/boot/dts/{ => st}/stm32429i-eval.dts      |    0
 arch/arm/boot/dts/{ => st}/stm32746g-eval.dts      |    0
 arch/arm/boot/dts/{ => st}/stm32f4-pinctrl.dtsi    |    0
 arch/arm/boot/dts/{ => st}/stm32f429-disco.dts     |    0
 arch/arm/boot/dts/{ => st}/stm32f429-pinctrl.dtsi  |    0
 arch/arm/boot/dts/{ => st}/stm32f429.dtsi          |    2 +-
 arch/arm/boot/dts/{ => st}/stm32f469-disco.dts     |    0
 arch/arm/boot/dts/{ => st}/stm32f469-pinctrl.dtsi  |    0
 arch/arm/boot/dts/{ => st}/stm32f469.dtsi          |    0
 arch/arm/boot/dts/{ => st}/stm32f7-pinctrl.dtsi    |    0
 arch/arm/boot/dts/{ => st}/stm32f746-disco.dts     |    0
 arch/arm/boot/dts/{ => st}/stm32f746-pinctrl.dtsi  |    0
 arch/arm/boot/dts/{ => st}/stm32f746.dtsi          |    2 +-
 arch/arm/boot/dts/{ => st}/stm32f769-disco.dts     |    0
 arch/arm/boot/dts/{ => st}/stm32f769-pinctrl.dtsi  |    0
 arch/arm/boot/dts/{ => st}/stm32h7-pinctrl.dtsi    |    0
 arch/arm/boot/dts/{ => st}/stm32h743.dtsi          |    2 +-
 arch/arm/boot/dts/{ => st}/stm32h743i-disco.dts    |    0
 arch/arm/boot/dts/{ => st}/stm32h743i-eval.dts     |    0
 arch/arm/boot/dts/{ => st}/stm32h750.dtsi          |    0
 arch/arm/boot/dts/{ => st}/stm32h750i-art-pi.dts   |    0
 arch/arm/boot/dts/{ => st}/stm32mp13-pinctrl.dtsi  |    0
 arch/arm/boot/dts/{ => st}/stm32mp131.dtsi         |    0
 arch/arm/boot/dts/{ => st}/stm32mp133.dtsi         |    0
 arch/arm/boot/dts/{ => st}/stm32mp135.dtsi         |    0
 arch/arm/boot/dts/{ => st}/stm32mp135f-dk.dts      |    0
 arch/arm/boot/dts/{ => st}/stm32mp13xc.dtsi        |    0
 arch/arm/boot/dts/{ => st}/stm32mp13xf.dtsi        |    0
 arch/arm/boot/dts/{ => st}/stm32mp15-pinctrl.dtsi  |    0
 arch/arm/boot/dts/{ => st}/stm32mp15-scmi.dtsi     |    0
 arch/arm/boot/dts/{ => st}/stm32mp151.dtsi         |    0
 .../dts/{ => st}/stm32mp151a-dhcor-testbench.dts   |    0
 arch/arm/boot/dts/{ => st}/stm32mp151a-prtt1a.dts  |    0
 arch/arm/boot/dts/{ => st}/stm32mp151a-prtt1c.dts  |    0
 arch/arm/boot/dts/{ => st}/stm32mp151a-prtt1l.dtsi |    0
 arch/arm/boot/dts/{ => st}/stm32mp151a-prtt1s.dts  |    0
 arch/arm/boot/dts/{ => st}/stm32mp153.dtsi         |    0
 .../boot/dts/{ => st}/stm32mp153c-dhcom-drc02.dts  |    0
 .../dts/{ => st}/stm32mp153c-dhcor-drc-compact.dts |    0
 arch/arm/boot/dts/{ => st}/stm32mp157.dtsi         |    0
 .../boot/dts/{ => st}/stm32mp157a-avenger96.dts    |    0
 .../dts/{ => st}/stm32mp157a-dhcor-avenger96.dts   |    0
 .../arm/boot/dts/{ => st}/stm32mp157a-dk1-scmi.dts |    0
 arch/arm/boot/dts/{ => st}/stm32mp157a-dk1.dts     |    0
 .../stm32mp157a-icore-stm32mp1-ctouch2-of10.dts    |    0
 .../stm32mp157a-icore-stm32mp1-ctouch2.dts         |    0
 .../stm32mp157a-icore-stm32mp1-edimm2.2.dts        |    0
 .../dts/{ => st}/stm32mp157a-icore-stm32mp1.dtsi   |    0
 arch/arm/boot/dts/{ => st}/stm32mp157a-iot-box.dts |    0
 ...m32mp157a-microgea-stm32mp1-microdev2.0-of7.dts |    0
 .../stm32mp157a-microgea-stm32mp1-microdev2.0.dts  |    0
 .../{ => st}/stm32mp157a-microgea-stm32mp1.dtsi    |    0
 .../boot/dts/{ => st}/stm32mp157a-stinger96.dts    |    0
 .../boot/dts/{ => st}/stm32mp157a-stinger96.dtsi   |    0
 .../boot/dts/{ => st}/stm32mp157c-dhcom-pdk2.dts   |    0
 .../dts/{ => st}/stm32mp157c-dhcom-picoitx.dts     |    0
 .../arm/boot/dts/{ => st}/stm32mp157c-dk2-scmi.dts |    0
 arch/arm/boot/dts/{ => st}/stm32mp157c-dk2.dts     |    0
 .../arm/boot/dts/{ => st}/stm32mp157c-ed1-scmi.dts |    0
 arch/arm/boot/dts/{ => st}/stm32mp157c-ed1.dts     |    0
 .../boot/dts/{ => st}/stm32mp157c-emsbc-argon.dts  |    0
 .../dts/{ => st}/stm32mp157c-emstamp-argon.dtsi    |    0
 .../arm/boot/dts/{ => st}/stm32mp157c-ev1-scmi.dts |    0
 arch/arm/boot/dts/{ => st}/stm32mp157c-ev1.dts     |    0
 arch/arm/boot/dts/{ => st}/stm32mp157c-lxa-mc1.dts |    0
 .../boot/dts/{ => st}/stm32mp157c-odyssey-som.dtsi |    0
 arch/arm/boot/dts/{ => st}/stm32mp157c-odyssey.dts |    0
 arch/arm/boot/dts/{ => st}/stm32mp15xc.dtsi        |    0
 .../boot/dts/{ => st}/stm32mp15xx-dhcom-drc02.dtsi |    0
 .../boot/dts/{ => st}/stm32mp15xx-dhcom-pdk2.dtsi  |    0
 .../dts/{ => st}/stm32mp15xx-dhcom-picoitx.dtsi    |    0
 .../boot/dts/{ => st}/stm32mp15xx-dhcom-som.dtsi   |    0
 .../dts/{ => st}/stm32mp15xx-dhcor-avenger96.dtsi  |    0
 .../{ => st}/stm32mp15xx-dhcor-drc-compact.dtsi    |    0
 .../boot/dts/{ => st}/stm32mp15xx-dhcor-io1v8.dtsi |    0
 .../boot/dts/{ => st}/stm32mp15xx-dhcor-som.dtsi   |    0
 .../dts/{ => st}/stm32mp15xx-dhcor-testbench.dtsi  |    0
 arch/arm/boot/dts/{ => st}/stm32mp15xx-dkx.dtsi    |    0
 arch/arm/boot/dts/{ => st}/stm32mp15xx-osd32.dtsi  |    0
 .../boot/dts/{ => st}/stm32mp15xxaa-pinctrl.dtsi   |    0
 .../boot/dts/{ => st}/stm32mp15xxab-pinctrl.dtsi   |    0
 .../boot/dts/{ => st}/stm32mp15xxac-pinctrl.dtsi   |    0
 .../boot/dts/{ => st}/stm32mp15xxad-pinctrl.dtsi   |    0
 arch/arm/boot/dts/sunplus/Makefile                 |    3 +
 .../dts/{ => sunplus}/sunplus-sp7021-achip.dtsi    |    0
 .../dts/{ => sunplus}/sunplus-sp7021-demo-v3.dts   |    0
 .../arm/boot/dts/{ => sunplus}/sunplus-sp7021.dtsi |    0
 arch/arm/boot/dts/synaptics/Makefile               |    6 +
 .../dts/{ => synaptics}/berlin2-sony-nsz-gs7.dts   |    0
 arch/arm/boot/dts/{ => synaptics}/berlin2.dtsi     |    0
 .../berlin2cd-google-chromecast.dts                |    0
 .../{ => synaptics}/berlin2cd-valve-steamlink.dts  |    0
 arch/arm/boot/dts/{ => synaptics}/berlin2cd.dtsi   |    0
 .../dts/{ => synaptics}/berlin2q-marvell-dmp.dts   |    0
 arch/arm/boot/dts/{ => synaptics}/berlin2q.dtsi    |    0
 arch/arm/boot/dts/ti/Makefile                      |  174 ++
 .../arm/boot/dts/{ => ti}/am335x-baltos-ir2110.dts |    0
 .../arm/boot/dts/{ => ti}/am335x-baltos-ir3220.dts |    0
 .../arm/boot/dts/{ => ti}/am335x-baltos-ir5221.dts |    0
 arch/arm/boot/dts/{ => ti}/am335x-baltos-leds.dtsi |    0
 arch/arm/boot/dts/{ => ti}/am335x-baltos.dtsi      |    2 +-
 arch/arm/boot/dts/{ => ti}/am335x-base0033.dts     |    0
 arch/arm/boot/dts/{ => ti}/am335x-bone-common.dtsi |    2 +-
 arch/arm/boot/dts/{ => ti}/am335x-bone.dts         |    0
 .../boot/dts/{ => ti}/am335x-boneblack-common.dtsi |    0
 .../boot/dts/{ => ti}/am335x-boneblack-hdmi.dtsi   |    0
 .../dts/{ => ti}/am335x-boneblack-wireless.dts     |    0
 arch/arm/boot/dts/{ => ti}/am335x-boneblack.dts    |    0
 arch/arm/boot/dts/{ => ti}/am335x-boneblue.dts     |    2 +-
 .../boot/dts/{ => ti}/am335x-bonegreen-common.dtsi |    0
 .../dts/{ => ti}/am335x-bonegreen-wireless.dts     |    0
 arch/arm/boot/dts/{ => ti}/am335x-bonegreen.dts    |    0
 arch/arm/boot/dts/{ => ti}/am335x-chiliboard.dts   |    0
 arch/arm/boot/dts/{ => ti}/am335x-chilisom.dtsi    |    2 +-
 arch/arm/boot/dts/{ => ti}/am335x-cm-t335.dts      |    0
 arch/arm/boot/dts/{ => ti}/am335x-evm.dts          |    2 +-
 arch/arm/boot/dts/{ => ti}/am335x-evmsk.dts        |    2 +-
 arch/arm/boot/dts/{ => ti}/am335x-guardian.dts     |    2 +-
 arch/arm/boot/dts/{ => ti}/am335x-icev2.dts        |    2 +-
 arch/arm/boot/dts/{ => ti}/am335x-igep0033.dtsi    |    2 +-
 arch/arm/boot/dts/{ => ti}/am335x-lxm.dts          |    2 +-
 .../dts/{ => ti}/am335x-moxa-uc-2100-common.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/am335x-moxa-uc-2101.dts |    0
 .../dts/{ => ti}/am335x-moxa-uc-8100-common.dtsi   |    2 +-
 .../boot/dts/{ => ti}/am335x-moxa-uc-8100-me-t.dts |    0
 .../arm/boot/dts/{ => ti}/am335x-myirtech-myc.dtsi |    0
 arch/arm/boot/dts/{ => ti}/am335x-myirtech-myd.dts |    0
 arch/arm/boot/dts/{ => ti}/am335x-nano.dts         |    2 +-
 .../boot/dts/{ => ti}/am335x-netcan-plus-1xx.dts   |    0
 .../boot/dts/{ => ti}/am335x-netcom-plus-2xx.dts   |    0
 .../boot/dts/{ => ti}/am335x-netcom-plus-8xx.dts   |    0
 .../boot/dts/{ => ti}/am335x-osd3358-sm-red.dts    |    0
 .../boot/dts/{ => ti}/am335x-osd335x-common.dtsi   |    2 +-
 arch/arm/boot/dts/{ => ti}/am335x-pcm-953.dtsi     |    0
 arch/arm/boot/dts/{ => ti}/am335x-pdu001.dts       |    2 +-
 arch/arm/boot/dts/{ => ti}/am335x-pepper.dts       |    2 +-
 arch/arm/boot/dts/{ => ti}/am335x-phycore-rdk.dts  |    0
 arch/arm/boot/dts/{ => ti}/am335x-phycore-som.dtsi |    2 +-
 arch/arm/boot/dts/{ => ti}/am335x-pocketbeagle.dts |    0
 arch/arm/boot/dts/{ => ti}/am335x-regor-rdk.dts    |    0
 arch/arm/boot/dts/{ => ti}/am335x-regor.dtsi       |    0
 .../dts/{ => ti}/am335x-sancloud-bbe-common.dtsi   |    0
 .../{ => ti}/am335x-sancloud-bbe-extended-wifi.dts |    0
 .../boot/dts/{ => ti}/am335x-sancloud-bbe-lite.dts |    0
 arch/arm/boot/dts/{ => ti}/am335x-sancloud-bbe.dts |    0
 arch/arm/boot/dts/{ => ti}/am335x-sbc-t335.dts     |    0
 arch/arm/boot/dts/{ => ti}/am335x-shc.dts          |    0
 arch/arm/boot/dts/{ => ti}/am335x-sl50.dts         |    2 +-
 arch/arm/boot/dts/{ => ti}/am335x-wega-rdk.dts     |    0
 arch/arm/boot/dts/{ => ti}/am335x-wega.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/am33xx-clocks.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/am33xx-l4.dtsi          |    0
 arch/arm/boot/dts/{ => ti}/am33xx.dtsi             |    0
 arch/arm/boot/dts/{ => ti}/am3517-craneboard.dts   |    2 +-
 arch/arm/boot/dts/{ => ti}/am3517-evm-ui.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/am3517-evm.dts          |    0
 arch/arm/boot/dts/{ => ti}/am3517-som.dtsi         |    0
 arch/arm/boot/dts/{ => ti}/am3517.dtsi             |    0
 arch/arm/boot/dts/{ => ti}/am3517_mt_ventoux.dts   |    0
 arch/arm/boot/dts/{ => ti}/am35xx-clocks.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/am3703.dtsi             |    0
 arch/arm/boot/dts/{ => ti}/am3715.dtsi             |    0
 arch/arm/boot/dts/{ => ti}/am3874-iceboard.dts     |    0
 arch/arm/boot/dts/{ => ti}/am4372.dtsi             |    0
 arch/arm/boot/dts/{ => ti}/am437x-cm-t43.dts       |    0
 arch/arm/boot/dts/{ => ti}/am437x-gp-evm.dts       |    0
 arch/arm/boot/dts/{ => ti}/am437x-idk-evm.dts      |    0
 arch/arm/boot/dts/{ => ti}/am437x-l4.dtsi          |    0
 arch/arm/boot/dts/{ => ti}/am437x-sbc-t43.dts      |    0
 arch/arm/boot/dts/{ => ti}/am437x-sk-evm.dts       |    0
 arch/arm/boot/dts/{ => ti}/am43x-epos-evm.dts      |    0
 arch/arm/boot/dts/{ => ti}/am43xx-clocks.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/am57-pruss.dtsi         |    0
 arch/arm/boot/dts/{ => ti}/am5718.dtsi             |    0
 .../boot/dts/{ => ti}/am571x-idk-touchscreen.dtso  |    0
 arch/arm/boot/dts/{ => ti}/am571x-idk.dts          |    0
 arch/arm/boot/dts/{ => ti}/am5728.dtsi             |    0
 arch/arm/boot/dts/{ => ti}/am5729-beagleboneai.dts |    0
 arch/arm/boot/dts/{ => ti}/am572x-idk-common.dtsi  |    0
 .../boot/dts/{ => ti}/am572x-idk-touchscreen.dtso  |    0
 arch/arm/boot/dts/{ => ti}/am572x-idk.dts          |    0
 arch/arm/boot/dts/{ => ti}/am5748.dtsi             |    0
 arch/arm/boot/dts/{ => ti}/am574x-idk.dts          |    0
 .../dts/{ => ti}/am57xx-beagle-x15-common.dtsi     |    0
 .../boot/dts/{ => ti}/am57xx-beagle-x15-revb1.dts  |    0
 .../boot/dts/{ => ti}/am57xx-beagle-x15-revc.dts   |    0
 arch/arm/boot/dts/{ => ti}/am57xx-beagle-x15.dts   |    0
 arch/arm/boot/dts/{ => ti}/am57xx-cl-som-am57x.dts |    0
 .../boot/dts/{ => ti}/am57xx-commercial-grade.dtsi |    0
 arch/arm/boot/dts/{ => ti}/am57xx-evm.dtso         |    0
 arch/arm/boot/dts/{ => ti}/am57xx-idk-common.dtsi  |    0
 .../dts/{ => ti}/am57xx-idk-lcd-osd101t2045.dtso   |    0
 .../dts/{ => ti}/am57xx-idk-lcd-osd101t2587.dtso   |    0
 .../boot/dts/{ => ti}/am57xx-industrial-grade.dtsi |    0
 arch/arm/boot/dts/{ => ti}/am57xx-sbc-am57x.dts    |    0
 arch/arm/boot/dts/{ => ti}/compulab-sb-som.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/da850-enbw-cmc.dts      |    0
 arch/arm/boot/dts/{ => ti}/da850-evm.dts           |    2 +-
 arch/arm/boot/dts/{ => ti}/da850-lcdk.dts          |    0
 arch/arm/boot/dts/{ => ti}/da850-lego-ev3.dts      |    0
 arch/arm/boot/dts/{ => ti}/da850.dtsi              |    0
 arch/arm/boot/dts/{ => ti}/dm3725.dtsi             |    0
 arch/arm/boot/dts/{ => ti}/dm8148-evm.dts          |    0
 arch/arm/boot/dts/{ => ti}/dm8148-t410.dts         |    0
 arch/arm/boot/dts/{ => ti}/dm814x-clocks.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/dm814x.dtsi             |    0
 arch/arm/boot/dts/{ => ti}/dm8168-evm.dts          |    0
 arch/arm/boot/dts/{ => ti}/dm816x-clocks.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/dm816x.dtsi             |    0
 arch/arm/boot/dts/{ => ti}/dra62x-clocks.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/dra62x-j5eco-evm.dts    |    0
 arch/arm/boot/dts/{ => ti}/dra62x.dtsi             |    0
 .../arm/boot/dts/{ => ti}/dra7-dspeve-thermal.dtsi |    0
 arch/arm/boot/dts/{ => ti}/dra7-evm-common.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/dra7-evm.dts            |    0
 .../arm/boot/dts/{ => ti}/dra7-ipu-dsp-common.dtsi |    0
 arch/arm/boot/dts/{ => ti}/dra7-iva-thermal.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/dra7-l4.dtsi            |    0
 arch/arm/boot/dts/{ => ti}/dra7-mmc-iodelay.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/dra7.dtsi               |    0
 arch/arm/boot/dts/{ => ti}/dra71-evm.dts           |    0
 arch/arm/boot/dts/{ => ti}/dra71x.dtsi             |    0
 arch/arm/boot/dts/{ => ti}/dra72-evm-common.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/dra72-evm-revc.dts      |    0
 arch/arm/boot/dts/{ => ti}/dra72-evm-tps65917.dtsi |    0
 arch/arm/boot/dts/{ => ti}/dra72-evm.dts           |    0
 arch/arm/boot/dts/{ => ti}/dra72x-mmc-iodelay.dtsi |    0
 arch/arm/boot/dts/{ => ti}/dra72x.dtsi             |    0
 .../boot/dts/{ => ti}/dra74-ipu-dsp-common.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/dra74x-mmc-iodelay.dtsi |    0
 arch/arm/boot/dts/{ => ti}/dra74x-p.dtsi           |    0
 arch/arm/boot/dts/{ => ti}/dra74x.dtsi             |    0
 arch/arm/boot/dts/{ => ti}/dra76-evm.dts           |    0
 arch/arm/boot/dts/{ => ti}/dra76x-mmc-iodelay.dtsi |    0
 arch/arm/boot/dts/{ => ti}/dra76x.dtsi             |    0
 arch/arm/boot/dts/{ => ti}/dra7xx-clocks.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/elpida_ecb240abacn.dtsi |    0
 arch/arm/boot/dts/{ => ti}/keystone-clocks.dtsi    |    0
 .../arm/boot/dts/{ => ti}/keystone-k2e-clocks.dtsi |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2e-evm.dts    |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2e-netcp.dtsi |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2e.dtsi       |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2g-evm.dts    |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2g-ice.dts    |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2g-netcp.dtsi |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2g.dtsi       |    0
 .../boot/dts/{ => ti}/keystone-k2hk-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2hk-evm.dts   |    0
 .../arm/boot/dts/{ => ti}/keystone-k2hk-netcp.dtsi |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2hk.dtsi      |    0
 .../arm/boot/dts/{ => ti}/keystone-k2l-clocks.dtsi |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2l-evm.dts    |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2l-netcp.dtsi |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2l.dtsi       |    0
 arch/arm/boot/dts/{ => ti}/keystone.dtsi           |    0
 .../dts/{ => ti}/logicpd-som-lv-35xx-devkit.dts    |    0
 .../dts/{ => ti}/logicpd-som-lv-37xx-devkit.dts    |    0
 .../dts/{ => ti}/logicpd-som-lv-baseboard.dtsi     |    0
 arch/arm/boot/dts/{ => ti}/logicpd-som-lv.dtsi     |    0
 .../dts/{ => ti}/logicpd-torpedo-35xx-devkit.dts   |    0
 .../{ => ti}/logicpd-torpedo-37xx-devkit-28.dts    |    0
 .../dts/{ => ti}/logicpd-torpedo-37xx-devkit.dts   |    0
 .../dts/{ => ti}/logicpd-torpedo-baseboard.dtsi    |    0
 .../arm/boot/dts/{ => ti}/logicpd-torpedo-som.dtsi |    0
 .../boot/dts/{ => ti}/motorola-cpcap-mapphone.dtsi |    0
 .../dts/{ => ti}/motorola-mapphone-common.dtsi     |    0
 arch/arm/boot/dts/{ => ti}/omap-gpmc-smsc911x.dtsi |    0
 arch/arm/boot/dts/{ => ti}/omap-gpmc-smsc9221.dtsi |    0
 arch/arm/boot/dts/{ => ti}/omap-zoom-common.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/omap2.dtsi              |    0
 arch/arm/boot/dts/{ => ti}/omap2420-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap2420-h4.dts         |    0
 arch/arm/boot/dts/{ => ti}/omap2420-n800.dts       |    0
 arch/arm/boot/dts/{ => ti}/omap2420-n810-wimax.dts |    0
 arch/arm/boot/dts/{ => ti}/omap2420-n810.dts       |    0
 .../boot/dts/{ => ti}/omap2420-n8x0-common.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap2420.dtsi           |    0
 arch/arm/boot/dts/{ => ti}/omap2430-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap2430-sdp.dts        |    0
 arch/arm/boot/dts/{ => ti}/omap2430.dtsi           |    0
 arch/arm/boot/dts/{ => ti}/omap24xx-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap3-beagle-ab4.dts    |    0
 arch/arm/boot/dts/{ => ti}/omap3-beagle-xm-ab.dts  |    0
 arch/arm/boot/dts/{ => ti}/omap3-beagle-xm.dts     |    0
 arch/arm/boot/dts/{ => ti}/omap3-beagle.dts        |    0
 arch/arm/boot/dts/{ => ti}/omap3-cm-t3517.dts      |    0
 arch/arm/boot/dts/{ => ti}/omap3-cm-t3530.dts      |    0
 arch/arm/boot/dts/{ => ti}/omap3-cm-t3730.dts      |    0
 arch/arm/boot/dts/{ => ti}/omap3-cm-t3x.dtsi       |    0
 arch/arm/boot/dts/{ => ti}/omap3-cm-t3x30.dtsi     |    0
 arch/arm/boot/dts/{ => ti}/omap3-cpu-thermal.dtsi  |    0
 .../boot/dts/{ => ti}/omap3-devkit8000-common.dtsi |    0
 .../dts/{ => ti}/omap3-devkit8000-lcd-common.dtsi  |    0
 .../boot/dts/{ => ti}/omap3-devkit8000-lcd43.dts   |    0
 .../boot/dts/{ => ti}/omap3-devkit8000-lcd70.dts   |    0
 arch/arm/boot/dts/{ => ti}/omap3-devkit8000.dts    |    0
 arch/arm/boot/dts/{ => ti}/omap3-echo.dts          |    2 +-
 arch/arm/boot/dts/{ => ti}/omap3-evm-37xx.dts      |    0
 arch/arm/boot/dts/{ => ti}/omap3-evm-common.dtsi   |    0
 .../dts/{ => ti}/omap3-evm-processor-common.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/omap3-evm.dts           |    0
 arch/arm/boot/dts/{ => ti}/omap3-gta04.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/omap3-gta04a3.dts       |    0
 arch/arm/boot/dts/{ => ti}/omap3-gta04a4.dts       |    0
 arch/arm/boot/dts/{ => ti}/omap3-gta04a5.dts       |    0
 arch/arm/boot/dts/{ => ti}/omap3-gta04a5one.dts    |    0
 arch/arm/boot/dts/{ => ti}/omap3-ha-common.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap3-ha-lcd.dts        |    0
 arch/arm/boot/dts/{ => ti}/omap3-ha.dts            |    0
 arch/arm/boot/dts/{ => ti}/omap3-igep.dtsi         |    0
 .../boot/dts/{ => ti}/omap3-igep0020-common.dtsi   |    0
 .../arm/boot/dts/{ => ti}/omap3-igep0020-rev-f.dts |    0
 arch/arm/boot/dts/{ => ti}/omap3-igep0020.dts      |    0
 .../boot/dts/{ => ti}/omap3-igep0030-common.dtsi   |    0
 .../arm/boot/dts/{ => ti}/omap3-igep0030-rev-g.dts |    0
 arch/arm/boot/dts/{ => ti}/omap3-igep0030.dts      |    0
 arch/arm/boot/dts/{ => ti}/omap3-ldp.dts           |    0
 arch/arm/boot/dts/{ => ti}/omap3-lilly-a83x.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/omap3-lilly-dbb056.dts  |    0
 arch/arm/boot/dts/{ => ti}/omap3-n9.dts            |    0
 arch/arm/boot/dts/{ => ti}/omap3-n900.dts          |    0
 arch/arm/boot/dts/{ => ti}/omap3-n950-n9.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/omap3-n950.dts          |    0
 .../dts/{ => ti}/omap3-overo-alto35-common.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap3-overo-alto35.dts  |    0
 arch/arm/boot/dts/{ => ti}/omap3-overo-base.dtsi   |    0
 .../{ => ti}/omap3-overo-chestnut43-common.dtsi    |    0
 .../boot/dts/{ => ti}/omap3-overo-chestnut43.dts   |    0
 .../boot/dts/{ => ti}/omap3-overo-common-dvi.dtsi  |    0
 .../dts/{ => ti}/omap3-overo-common-lcd35.dtsi     |    0
 .../dts/{ => ti}/omap3-overo-common-lcd43.dtsi     |    0
 .../{ => ti}/omap3-overo-common-peripherals.dtsi   |    0
 .../dts/{ => ti}/omap3-overo-gallop43-common.dtsi  |    0
 .../arm/boot/dts/{ => ti}/omap3-overo-gallop43.dts |    0
 .../dts/{ => ti}/omap3-overo-palo35-common.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap3-overo-palo35.dts  |    0
 .../dts/{ => ti}/omap3-overo-palo43-common.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap3-overo-palo43.dts  |    0
 .../boot/dts/{ => ti}/omap3-overo-storm-alto35.dts |    0
 .../dts/{ => ti}/omap3-overo-storm-chestnut43.dts  |    0
 .../dts/{ => ti}/omap3-overo-storm-gallop43.dts    |    0
 .../boot/dts/{ => ti}/omap3-overo-storm-palo35.dts |    0
 .../boot/dts/{ => ti}/omap3-overo-storm-palo43.dts |    0
 .../boot/dts/{ => ti}/omap3-overo-storm-summit.dts |    0
 .../boot/dts/{ => ti}/omap3-overo-storm-tobi.dts   |    0
 .../dts/{ => ti}/omap3-overo-storm-tobiduo.dts     |    0
 arch/arm/boot/dts/{ => ti}/omap3-overo-storm.dtsi  |    0
 .../dts/{ => ti}/omap3-overo-summit-common.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap3-overo-summit.dts  |    0
 .../boot/dts/{ => ti}/omap3-overo-tobi-common.dtsi |    0
 arch/arm/boot/dts/{ => ti}/omap3-overo-tobi.dts    |    0
 .../dts/{ => ti}/omap3-overo-tobiduo-common.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/omap3-overo-tobiduo.dts |    0
 arch/arm/boot/dts/{ => ti}/omap3-overo.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/omap3-pandora-1ghz.dts  |    0
 .../arm/boot/dts/{ => ti}/omap3-pandora-600mhz.dts |    0
 .../boot/dts/{ => ti}/omap3-pandora-common.dtsi    |    0
 .../{ => ti}/omap3-panel-sharp-ls037v7dw01.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap3-sb-t35.dtsi       |    0
 arch/arm/boot/dts/{ => ti}/omap3-sbc-t3517.dts     |    0
 arch/arm/boot/dts/{ => ti}/omap3-sbc-t3530.dts     |    0
 arch/arm/boot/dts/{ => ti}/omap3-sbc-t3730.dts     |    0
 arch/arm/boot/dts/{ => ti}/omap3-sniper.dts        |    0
 arch/arm/boot/dts/{ => ti}/omap3-tao3530.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/omap3-thunder.dts       |    0
 arch/arm/boot/dts/{ => ti}/omap3-zoom3.dts         |    0
 arch/arm/boot/dts/{ => ti}/omap3.dtsi              |    0
 arch/arm/boot/dts/{ => ti}/omap3430-sdp.dts        |    0
 arch/arm/boot/dts/{ => ti}/omap3430es1-clocks.dtsi |    0
 .../dts/{ => ti}/omap34xx-omap36xx-clocks.dtsi     |    0
 arch/arm/boot/dts/{ => ti}/omap34xx.dtsi           |    0
 .../omap36xx-am35xx-omap3430es2plus-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap36xx-clocks.dtsi    |    0
 .../{ => ti}/omap36xx-omap3430es2plus-clocks.dtsi  |    0
 arch/arm/boot/dts/{ => ti}/omap36xx.dtsi           |    0
 arch/arm/boot/dts/{ => ti}/omap3xxx-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap4-cpu-thermal.dtsi  |    0
 .../boot/dts/{ => ti}/omap4-droid-bionic-xt875.dts |    0
 arch/arm/boot/dts/{ => ti}/omap4-droid4-xt894.dts  |    0
 .../arm/boot/dts/{ => ti}/omap4-duovero-parlor.dts |    0
 arch/arm/boot/dts/{ => ti}/omap4-duovero.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/omap4-kc1.dts           |    0
 arch/arm/boot/dts/{ => ti}/omap4-l4-abe.dtsi       |    0
 arch/arm/boot/dts/{ => ti}/omap4-l4.dtsi           |    0
 arch/arm/boot/dts/{ => ti}/omap4-mcpdm.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/omap4-panda-a4.dts      |    0
 arch/arm/boot/dts/{ => ti}/omap4-panda-common.dtsi |    0
 arch/arm/boot/dts/{ => ti}/omap4-panda-es.dts      |    0
 arch/arm/boot/dts/{ => ti}/omap4-panda.dts         |    0
 arch/arm/boot/dts/{ => ti}/omap4-sdp-es23plus.dts  |    0
 arch/arm/boot/dts/{ => ti}/omap4-sdp.dts           |    0
 arch/arm/boot/dts/{ => ti}/omap4-var-dvk-om44.dts  |    0
 .../dts/{ => ti}/omap4-var-om44customboard.dtsi    |    0
 .../boot/dts/{ => ti}/omap4-var-som-om44-wlan.dtsi |    0
 arch/arm/boot/dts/{ => ti}/omap4-var-som-om44.dtsi |    0
 arch/arm/boot/dts/{ => ti}/omap4-var-stk-om44.dts  |    0
 arch/arm/boot/dts/{ => ti}/omap4.dtsi              |    0
 arch/arm/boot/dts/{ => ti}/omap443x-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap443x.dtsi           |    0
 arch/arm/boot/dts/{ => ti}/omap4460.dtsi           |    0
 arch/arm/boot/dts/{ => ti}/omap446x-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap44xx-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap5-board-common.dtsi |    0
 arch/arm/boot/dts/{ => ti}/omap5-cm-t54.dts        |    0
 arch/arm/boot/dts/{ => ti}/omap5-core-thermal.dtsi |    0
 arch/arm/boot/dts/{ => ti}/omap5-gpu-thermal.dtsi  |    0
 arch/arm/boot/dts/{ => ti}/omap5-igep0050.dts      |    0
 arch/arm/boot/dts/{ => ti}/omap5-l4-abe.dtsi       |    0
 arch/arm/boot/dts/{ => ti}/omap5-l4.dtsi           |    0
 arch/arm/boot/dts/{ => ti}/omap5-sbc-t54.dts       |    0
 arch/arm/boot/dts/{ => ti}/omap5-uevm.dts          |    0
 arch/arm/boot/dts/{ => ti}/omap5.dtsi              |    0
 arch/arm/boot/dts/{ => ti}/omap54xx-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/twl4030.dtsi            |    0
 arch/arm/boot/dts/{ => ti}/twl4030_omap3.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/twl6030.dtsi            |    0
 arch/arm/boot/dts/{ => ti}/twl6030_omap4.dtsi      |    0
 arch/arm/boot/dts/unisoc/Makefile                  |    4 +
 .../dts/{ => unisoc}/rda8810pl-orangepi-2g-iot.dts |    0
 .../dts/{ => unisoc}/rda8810pl-orangepi-i96.dts    |    0
 arch/arm/boot/dts/{ => unisoc}/rda8810pl.dtsi      |    0
 arch/arm/boot/dts/vt8500/Makefile                  |    7 +
 arch/arm/boot/dts/{ => vt8500}/vt8500-bv07.dts     |    0
 arch/arm/boot/dts/{ => vt8500}/vt8500.dtsi         |    0
 arch/arm/boot/dts/{ => vt8500}/wm8505-ref.dts      |    0
 arch/arm/boot/dts/{ => vt8500}/wm8505.dtsi         |    0
 arch/arm/boot/dts/{ => vt8500}/wm8650-mid.dts      |    0
 arch/arm/boot/dts/{ => vt8500}/wm8650.dtsi         |    0
 arch/arm/boot/dts/{ => vt8500}/wm8750-apc8750.dts  |    0
 arch/arm/boot/dts/{ => vt8500}/wm8750.dtsi         |    0
 arch/arm/boot/dts/{ => vt8500}/wm8850-w70v2.dts    |    0
 arch/arm/boot/dts/{ => vt8500}/wm8850.dtsi         |    0
 arch/arm/boot/dts/xen/Makefile                     |    3 +
 arch/arm/boot/dts/{ => xen}/xenvm-4.2.dts          |    0
 arch/arm/boot/dts/xilinx/Makefile                  |   17 +
 arch/arm/boot/dts/{ => xilinx}/zynq-7000.dtsi      |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-cc108.dts      |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-ebaz4205.dts   |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-microzed.dts   |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-parallella.dts |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-zc702.dts      |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-zc706.dts      |    0
 .../arm/boot/dts/{ => xilinx}/zynq-zc770-xm010.dts |    0
 .../arm/boot/dts/{ => xilinx}/zynq-zc770-xm011.dts |    0
 .../arm/boot/dts/{ => xilinx}/zynq-zc770-xm012.dts |    0
 .../arm/boot/dts/{ => xilinx}/zynq-zc770-xm013.dts |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-zed.dts        |    0
 .../boot/dts/{ => xilinx}/zynq-zturn-common.dtsi   |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-zturn-v5.dts   |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-zturn.dts      |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-zybo-z7.dts    |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-zybo.dts       |    0
 .../allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts  |    2 +-
 .../dts/allwinner/sun50i-h5-bananapi-m2-plus.dts   |    2 +-
 .../dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi   |    2 +-
 .../allwinner/sun50i-h5-libretech-all-h3-cc.dts    |    2 +-
 .../allwinner/sun50i-h5-libretech-all-h3-it.dts    |    2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       |    2 +-
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      |    2 +-
 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts   |    2 +-
 arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dts   |    2 +-
 .../arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts |    2 +-
 .../boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts     |    2 +-
 .../boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts     |    2 +-
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   |    2 +-
 .../boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts      |    2 +-
 .../boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts     |    2 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |    2 +-
 arch/arm64/boot/dts/exynos/exynos7885.dtsi         |    2 +-
 .../boot/dts/rockchip/rk3399pro-rock-pi-n10.dts    |    2 +-
 .../arm64/boot/dts/socionext/uniphier-pinctrl.dtsi |    2 +-
 .../boot/dts/socionext/uniphier-ref-daughter.dtsi  |    2 +-
 .../boot/dts/socionext/uniphier-support-card.dtsi  |    2 +-
 2652 files changed, 1923 insertions(+), 1847 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3583a7f8a521..6fa074f24036 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1647,9 +1647,9 @@ F:	Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
 F:	Documentation/devicetree/bindings/i2c/arm,i2c-versatile.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
 F:	Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
-F:	arch/arm/boot/dts/arm-realview-*
-F:	arch/arm/boot/dts/integrator*
-F:	arch/arm/boot/dts/versatile*
+F:	arch/arm/boot/dts/arm/arm-realview-*
+F:	arch/arm/boot/dts/arm/integrator*
+F:	arch/arm/boot/dts/arm/versatile*
 F:	arch/arm/mach-versatile/
 F:	drivers/bus/arm-integrator-lm.c
 F:	drivers/clk/versatile/
@@ -1836,7 +1836,7 @@ F:	Documentation/devicetree/bindings/net/actions,owl-emac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,*
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
-F:	arch/arm/boot/dts/owl-*
+F:	arch/arm/boot/dts/actions/
 F:	arch/arm/mach-actions/
 F:	arch/arm64/boot/dts/actions/
 F:	drivers/clk/actions/
@@ -1909,7 +1909,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-amlogic@lists.infradead.org
 S:	Maintained
 W:	http://linux-meson.com/
-F:	arch/arm/boot/dts/meson*
+F:	arch/arm/boot/dts/amlogic/
 F:	arch/arm/mach-meson/
 F:	arch/arm64/boot/dts/amlogic/
 F:	drivers/mmc/host/meson*
@@ -1923,7 +1923,7 @@ M:	Tsahee Zidenberg <tsahee@annapurnalabs.com>
 M:	Antoine Tenart <atenart@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/boot/dts/alpine*
+F:	arch/arm/boot/dts/amazon/
 F:	arch/arm/mach-alpine/
 F:	arch/arm64/boot/dts/amazon/
 F:	drivers/*/*alpine*
@@ -1992,7 +1992,7 @@ M:	Lars Persson <lars.persson@axis.com>
 L:	linux-arm-kernel@axis.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
-F:	arch/arm/boot/dts/artpec6*
+F:	arch/arm/boot/dts/axis/
 F:	arch/arm/mach-artpec
 F:	drivers/clk/axis
 F:	drivers/crypto/axis
@@ -2020,7 +2020,7 @@ S:	Supported
 Q:	https://patchwork.ozlabs.org/project/linux-aspeed/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
 F:	Documentation/devicetree/bindings/arm/aspeed/
-F:	arch/arm/boot/dts/aspeed-*
+F:	arch/arm/boot/dts/aspeed/
 F:	arch/arm/mach-aspeed/
 N:	aspeed
 
@@ -2039,8 +2039,7 @@ ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Andre Przywara <andre.przywara@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/boot/dts/ecx-*.dts*
-F:	arch/arm/boot/dts/highbank.dts
+F:	arch/arm/boot/dts/calxeda/
 F:	arch/arm/mach-highbank/
 
 ARM/CAVIUM THUNDER NETWORK DRIVER
@@ -2087,7 +2086,7 @@ ARM/CONEXANT DIGICOLOR MACHINE SUPPORT
 M:	Baruch Siach <baruch@tkos.co.il>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/boot/dts/cx92755*
+F:	arch/arm/boot/dts/cnxt/
 N:	digicolor
 
 ARM/CORESIGHT FRAMEWORK AND DRIVERS
@@ -2127,7 +2126,7 @@ F:	Documentation/devicetree/bindings/arm/gemini.yaml
 F:	Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml
 F:	Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
 F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
-F:	arch/arm/boot/dts/gemini*
+F:	arch/arm/boot/dts/gemini/
 F:	arch/arm/mach-gemini/
 F:	drivers/crypto/gemini/
 F:	drivers/net/ethernet/cortina/
@@ -2193,7 +2192,7 @@ M:	Li Yang <leoyang.li@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
-F:	arch/arm/boot/dts/ls1021a*
+F:	arch/arm/boot/dts/nxp/ls/
 F:	arch/arm64/boot/dts/freescale/fsl-*
 F:	arch/arm64/boot/dts/freescale/qoriq-*
 
@@ -2205,7 +2204,7 @@ R:	Stefan Agner <stefan@agner.ch>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
-F:	arch/arm/boot/dts/vf*
+F:	arch/arm/boot/dts/nxp/vf/
 F:	arch/arm/mach-imx/*vf610*
 
 ARM/GUMSTIX MACHINE SUPPORT
@@ -2219,9 +2218,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 W:	http://www.hisilicon.com
 T:	git https://github.com/hisilicon/linux-hisi.git
-F:	arch/arm/boot/dts/hi3*
-F:	arch/arm/boot/dts/hip*
-F:	arch/arm/boot/dts/hisi*
+F:	arch/arm/boot/dts/hisilicon/
 F:	arch/arm/mach-hisi/
 F:	arch/arm64/boot/dts/hisilicon/
 
@@ -2243,8 +2240,7 @@ F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
 F:	Documentation/devicetree/bindings/i2c/hpe,gxp-i2c.yaml
 F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
-F:	arch/arm/boot/dts/hpe-bmc*
-F:	arch/arm/boot/dts/hpe-gxp*
+F:	arch/arm/boot/dts/hpe/
 F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
 F:	drivers/hwmon/gxp-fan-ctrl.c
@@ -2258,7 +2254,7 @@ M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-omap@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/boot/dts/omap3-igep*
+F:	arch/arm/boot/dts/ti/omap3-igep*
 
 ARM/INTEL IXP4XX ARM ARCHITECTURE
 M:	Linus Walleij <linusw@kernel.org>
@@ -2271,7 +2267,7 @@ F:	Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion*
 F:	Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
 F:	Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
-F:	arch/arm/boot/dts/intel-ixp*
+F:	arch/arm/boot/dts/intel/ixp/
 F:	arch/arm/mach-ixp4xx/
 F:	drivers/bus/intel-ixp4xx-eb.c
 F:	drivers/clocksource/timer-ixp4xx.c
@@ -2303,7 +2299,7 @@ M:	Vladimir Zapolskiy <vz@mleia.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-lpc2k.txt
-F:	arch/arm/boot/dts/lpc43*
+F:	arch/arm/boot/dts/nxp/lpc/lpc43*
 F:	drivers/i2c/busses/i2c-lpc2k.c
 F:	drivers/memory/pl172.c
 F:	drivers/mtd/spi-nor/controllers/nxp-spifi.c
@@ -2316,7 +2312,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://github.com/vzapolskiy/linux-lpc32xx.git
 F:	Documentation/devicetree/bindings/i2c/i2c-pnx.txt
-F:	arch/arm/boot/dts/lpc32*
+F:	arch/arm/boot/dts/nxp/lpc/lpc32*
 F:	arch/arm/mach-lpc32xx/
 F:	drivers/i2c/busses/i2c-pnx.c
 F:	drivers/net/ethernet/nxp/lpc_eth.c
@@ -2334,8 +2330,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git
 F:	Documentation/devicetree/bindings/arm/marvell/marvell,dove.txt
 F:	Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
 F:	Documentation/devicetree/bindings/soc/dove/
-F:	arch/arm/boot/dts/dove*
-F:	arch/arm/boot/dts/orion5x*
+F:	arch/arm/boot/dts/marvell/dove*
+F:	arch/arm/boot/dts/marvell/orion5x*
 F:	arch/arm/mach-dove/
 F:	arch/arm/mach-mv78xx0/
 F:	arch/arm/mach-orion5x/
@@ -2350,8 +2346,8 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git
 F:	Documentation/devicetree/bindings/arm/marvell/
-F:	arch/arm/boot/dts/armada*
-F:	arch/arm/boot/dts/kirkwood*
+F:	arch/arm/boot/dts/marvell/armada*
+F:	arch/arm/boot/dts/marvell/kirkwood*
 F:	arch/arm/configs/mvebu_*_defconfig
 F:	arch/arm/mach-mvebu/
 F:	arch/arm64/boot/dts/marvell/armada*
@@ -2385,10 +2381,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	https://mtk.wiki.kernel.org/
 C:	irc://irc.libera.chat/linux-mediatek
-F:	arch/arm/boot/dts/mt2*
-F:	arch/arm/boot/dts/mt6*
-F:	arch/arm/boot/dts/mt7*
-F:	arch/arm/boot/dts/mt8*
+F:	arch/arm/boot/dts/mediatek/
 F:	arch/arm/mach-mediatek/
 F:	arch/arm64/boot/dts/mediatek/
 F:	drivers/soc/mediatek/
@@ -2412,10 +2405,8 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 W:	http://www.linux4sam.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
-F:	arch/arm/boot/dts/at91*.dts
-F:	arch/arm/boot/dts/at91*.dtsi
-F:	arch/arm/boot/dts/sama*.dts
-F:	arch/arm/boot/dts/sama*.dtsi
+F:	arch/arm/boot/dts/microchip/at91*
+F:	arch/arm/boot/dts/microchip/sama*
 F:	arch/arm/include/debug/at91.S
 F:	arch/arm/mach-at91/
 F:	drivers/memory/atmel*
@@ -2451,7 +2442,7 @@ M:	Taichi Sugaya <sugaya.taichi@socionext.com>
 M:	Takao Orito <orito.takao@socionext.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/boot/dts/milbeaut*
+F:	arch/arm/boot/dts/socionext/milbeaut*
 F:	arch/arm/mach-milbeaut/
 N:	milbeaut
 
@@ -2465,7 +2456,7 @@ T:	git git://github.com/linux-chenxing/linux.git
 F:	Documentation/devicetree/bindings/arm/mstar/*
 F:	Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
 F:	Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
-F:	arch/arm/boot/dts/mstar-*
+F:	arch/arm/boot/dts/sigmastar/
 F:	arch/arm/mach-mstar/
 F:	drivers/clk/mstar/
 F:	drivers/clocksource/timer-msc313e.c
@@ -2484,7 +2475,7 @@ F:	Documentation/devicetree/bindings/arm/ste-*
 F:	Documentation/devicetree/bindings/arm/ux500.yaml
 F:	Documentation/devicetree/bindings/arm/ux500/
 F:	Documentation/devicetree/bindings/i2c/st,nomadik-i2c.yaml
-F:	arch/arm/boot/dts/ste-*
+F:	arch/arm/boot/dts/st/ste-*
 F:	arch/arm/mach-nomadik/
 F:	arch/arm/mach-ux500/
 F:	drivers/clk/clk-nomadik.c
@@ -2514,7 +2505,7 @@ F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
 F:	Documentation/devicetree/bindings/arm/npcm/*
 F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
-F:	arch/arm/boot/dts/nuvoton-npcm*
+F:	arch/arm/boot/dts/nuvoton/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
 F:	arch/arm64/boot/dts/nuvoton/
 F:	drivers/*/*npcm*
@@ -2529,7 +2520,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
 W:	https://github.com/neuschaefer/wpcm450/wiki
 F:	Documentation/devicetree/bindings/*/*wpcm*
-F:	arch/arm/boot/dts/nuvoton-wpcm450*
+F:	arch/arm/boot/dts/nuvoton/nuvoton-wpcm450*
 F:	arch/arm/configs/wpcm450_defconfig
 F:	arch/arm/mach-npcm/wpcm450.c
 F:	drivers/*/*/*wpcm*
@@ -2570,8 +2561,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
 F:	Documentation/devicetree/bindings/*/qcom*
 F:	Documentation/devicetree/bindings/soc/qcom/
-F:	arch/arm/boot/dts/qcom-*.dts
-F:	arch/arm/boot/dts/qcom-*.dtsi
+F:	arch/arm/boot/dts/qcom/
 F:	arch/arm/configs/qcom_defconfig
 F:	arch/arm/mach-qcom/
 F:	arch/arm64/boot/dts/qcom/
@@ -2620,7 +2610,7 @@ F:	Documentation/devicetree/bindings/gpio/gpio-rda.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
 F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.yaml
 F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
-F:	arch/arm/boot/dts/rda8810pl-*
+F:	arch/arm/boot/dts/unisoc/
 F:	drivers/clocksource/timer-rda.c
 F:	drivers/gpio/gpio-rda.c
 F:	drivers/irqchip/irq-rda-intc.c
@@ -2632,7 +2622,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-realtek-soc@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/realtek.yaml
-F:	arch/arm/boot/dts/rtd*
+F:	arch/arm/boot/dts/realtek/
 F:	arch/arm/mach-realtek/
 F:	arch/arm64/boot/dts/realtek/
 
@@ -2646,13 +2636,7 @@ C:	irc://irc.libera.chat/renesas-soc
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
 F:	Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
 F:	Documentation/devicetree/bindings/soc/renesas/
-F:	arch/arm/boot/dts/emev2*
-F:	arch/arm/boot/dts/gr-peach*
-F:	arch/arm/boot/dts/iwg20d-q7*
-F:	arch/arm/boot/dts/r7s*
-F:	arch/arm/boot/dts/r8a*
-F:	arch/arm/boot/dts/r9a*
-F:	arch/arm/boot/dts/sh*
+F:	arch/arm/boot/dts/renesas/
 F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
@@ -2684,8 +2668,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
 F:	Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
 F:	Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
 F:	Documentation/devicetree/bindings/spi/spi-rockchip.yaml
-F:	arch/arm/boot/dts/rk3*
-F:	arch/arm/boot/dts/rv11*
+F:	arch/arm/boot/dts/rockchip/
 F:	arch/arm/mach-rockchip/
 F:	drivers/*/*/*rockchip*
 F:	drivers/*/*rockchip*
@@ -2709,9 +2692,7 @@ F:	Documentation/devicetree/bindings/arm/samsung/
 F:	Documentation/devicetree/bindings/hwinfo/samsung,*
 F:	Documentation/devicetree/bindings/power/pd-samsung.yaml
 F:	Documentation/devicetree/bindings/soc/samsung/
-F:	arch/arm/boot/dts/exynos*
-F:	arch/arm/boot/dts/s3c*
-F:	arch/arm/boot/dts/s5p*
+F:	arch/arm/boot/dts/samsung/
 F:	arch/arm/mach-exynos*/
 F:	arch/arm/mach-s3c/
 F:	arch/arm/mach-s5p*/
@@ -2771,7 +2752,7 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 W:	http://www.rocketboards.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
-F:	arch/arm/boot/dts/socfpga*
+F:	arch/arm/boot/dts/intel/socfpga/
 F:	arch/arm/configs/socfpga_defconfig
 F:	arch/arm/mach-socfpga/
 F:	arch/arm64/boot/dts/altera/
@@ -2804,7 +2785,7 @@ S:	Maintained
 W:	http://www.stlinux.com
 F:	Documentation/devicetree/bindings/spi/st,ssc-spi.yaml
 F:	Documentation/devicetree/bindings/i2c/st,sti-i2c.yaml
-F:	arch/arm/boot/dts/sti*
+F:	arch/arm/boot/dts/st/sti*
 F:	arch/arm/mach-sti/
 F:	drivers/ata/ahci_st.c
 F:	drivers/char/hw_random/st-rng.c
@@ -2837,7 +2818,7 @@ L:	linux-stm32@st-md-mailman.stormreply.com (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
-F:	arch/arm/boot/dts/stm32*
+F:	arch/arm/boot/dts/st/stm32*
 F:	arch/arm/mach-stm32/
 F:	drivers/clocksource/armv7m_systick.c
 N:	stm32
@@ -2852,7 +2833,7 @@ F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
-F:	arch/arm/boot/dts/sunplus-sp7021*.dts*
+F:	arch/arm/boot/dts/sunplus/
 F:	arch/arm/configs/sp7021_*defconfig
 F:	arch/arm/mach-sunplus/
 F:	drivers/irqchip/irq-sp7021-intc.c
@@ -2865,7 +2846,7 @@ M:	Jisheng Zhang <jszhang@kernel.org>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/boot/dts/berlin*
+F:	arch/arm/boot/dts/synaptics/
 F:	arch/arm/mach-berlin/
 F:	arch/arm64/boot/dts/synaptics/
 
@@ -2907,7 +2888,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-F:	arch/arm/boot/dts/keystone-*
+F:	arch/arm/boot/dts/ti/keystone-*
 F:	arch/arm/mach-keystone/
 
 ARM/TEXAS INSTRUMENT KEYSTONE CLOCK FRAMEWORK
@@ -2972,7 +2953,7 @@ F:	Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
 F:	Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
 F:	Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
 F:	Documentation/devicetree/bindings/soc/socionext/socionext,uniphier*.yaml
-F:	arch/arm/boot/dts/uniphier*
+F:	arch/arm/boot/dts/socionext/uniphier*
 F:	arch/arm/include/asm/hardware/cache-uniphier.h
 F:	arch/arm/mach-uniphier/
 F:	arch/arm/mm/cache-uniphier.c
@@ -2997,7 +2978,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	*/*/*/vexpress*
 F:	*/*/vexpress*
-F:	arch/arm/boot/dts/vexpress*
+F:	arch/arm/boot/dts/arm/vexpress*
 F:	arch/arm/mach-versatile/
 F:	arch/arm64/boot/dts/arm/
 F:	drivers/clk/versatile/clk-vexpress-osc.c
@@ -3404,10 +3385,10 @@ AXENTIA ARM DEVICES
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/boot/dts/at91-linea.dtsi
-F:	arch/arm/boot/dts/at91-natte.dtsi
-F:	arch/arm/boot/dts/at91-nattis-2-natte-2.dts
-F:	arch/arm/boot/dts/at91-tse850-3.dts
+F:	arch/arm/boot/dts/microchip/at91-linea.dtsi
+F:	arch/arm/boot/dts/microchip/at91-natte.dtsi
+F:	arch/arm/boot/dts/microchip/at91-nattis-2-natte-2.dts
+F:	arch/arm/boot/dts/microchip/at91-tse850-3.dts
 
 AXENTIA ASOC DRIVERS
 M:	Peter Rosin <peda@axentia.se>
@@ -3991,9 +3972,9 @@ M:	Rafał Miłecki <zajec5@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/boot/dts/bcm470*
-F:	arch/arm/boot/dts/bcm5301*
-F:	arch/arm/boot/dts/bcm953012*
+F:	arch/arm/boot/dts/broadcom/bcm470*
+F:	arch/arm/boot/dts/broadcom/bcm5301*
+F:	arch/arm/boot/dts/broadcom/bcm953012*
 F:	arch/arm/mach-bcm/bcm_5301x.c
 
 BROADCOM BCM53573 ARM ARCHITECTURE
@@ -4002,8 +3983,8 @@ M:	Rafał Miłecki <rafal@milecki.pl>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/boot/dts/bcm47189*
-F:	arch/arm/boot/dts/bcm53573*
+F:	arch/arm/boot/dts/broadcom/bcm47189*
+F:	arch/arm/boot/dts/broadcom/bcm53573*
 
 BROADCOM BCM63XX/BCM33XX UDC DRIVER
 M:	Kevin Cernekee <cernekee@gmail.com>
@@ -4018,7 +3999,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git https://github.com/broadcom/stblinux.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
-F:	arch/arm/boot/dts/bcm7*.dts*
+F:	arch/arm/boot/dts/broadcom/bcm7*.dts*
 F:	arch/arm/include/asm/hardware/cache-b15-rac.h
 F:	arch/arm/mach-bcm/*brcmstb*
 F:	arch/arm/mm/cache-b15-rac.c
@@ -5989,15 +5970,15 @@ DH ELECTRONICS IMX6 DHCOM/DHCOR BOARD SUPPORT
 M:	Christoph Niedermaier <cniedermaier@dh-electronics.com>
 L:	kernel@dh-electronics.com
 S:	Maintained
-F:	arch/arm/boot/dts/imx6*-dhcom-*
-F:	arch/arm/boot/dts/imx6*-dhcor-*
+F:	arch/arm/boot/dts/nxp/imx/imx6*-dhcom-*
+F:	arch/arm/boot/dts/nxp/imx/imx6*-dhcor-*
 
 DH ELECTRONICS STM32MP1 DHCOM/DHCOR BOARD SUPPORT
 M:	Marek Vasut <marex@denx.de>
 L:	kernel@dh-electronics.com
 S:	Maintained
-F:	arch/arm/boot/dts/stm32mp1*-dhcom-*
-F:	arch/arm/boot/dts/stm32mp1*-dhcor-*
+F:	arch/arm/boot/dts/st/stm32mp1*-dhcom-*
+F:	arch/arm/boot/dts/st/stm32mp1*-dhcor-*
 
 DIALOG SEMICONDUCTOR DRIVERS
 M:	Support Opensource <support.opensource@diasemi.com>
@@ -11668,7 +11649,7 @@ LEGO MINDSTORMS EV3
 R:	David Lechner <david@lechnology.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/lego,ev3-battery.yaml
-F:	arch/arm/boot/dts/da850-lego-ev3.dts
+F:	arch/arm/boot/dts/ti/da850-lego-ev3.dts
 F:	drivers/power/supply/lego_ev3_battery.c
 
 LEGO USB Tower driver
@@ -13931,12 +13912,12 @@ MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
 M:	Luka Kovacic <luka.kovacic@sartura.hr>
 M:	Luka Perkov <luka.perkov@sartura.hr>
 S:	Maintained
-F:	arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts
-F:	arch/arm/boot/dts/armada-xp-crs305-1g-4s.dts
-F:	arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts
-F:	arch/arm/boot/dts/armada-xp-crs326-24g-2s.dts
-F:	arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dts
-F:	arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dts
+F:	arch/arm/boot/dts/marvell/armada-xp-crs305-1g-4s-bit.dts
+F:	arch/arm/boot/dts/marvell/armada-xp-crs305-1g-4s.dts
+F:	arch/arm/boot/dts/marvell/armada-xp-crs326-24g-2s-bit.dts
+F:	arch/arm/boot/dts/marvell/armada-xp-crs326-24g-2s.dts
+F:	arch/arm/boot/dts/marvell/armada-xp-crs328-4c-20s-4s-bit.dts
+F:	arch/arm/boot/dts/marvell/armada-xp-crs328-4c-20s-4s.dts
 
 MIPI CCS, SMIA AND SMIA++ IMAGE SENSOR DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
@@ -14040,7 +14021,7 @@ R:	Lubomir Rintel <lkundrak@v3.sk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Odd Fixes
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp.git
-F:	arch/arm/boot/dts/mmp*
+F:	arch/arm/boot/dts/marvell/mmp*
 F:	arch/arm/mach-mmp/
 F:	include/linux/soc/mmp/
 
@@ -15156,13 +15137,7 @@ M:	Tony Lindgren <tony@atomide.com>
 L:	linux-omap@vger.kernel.org
 L:	devicetree@vger.kernel.org
 S:	Maintained
-F:	arch/arm/boot/dts/*am3*
-F:	arch/arm/boot/dts/*am4*
-F:	arch/arm/boot/dts/*am5*
-F:	arch/arm/boot/dts/*dra7*
-F:	arch/arm/boot/dts/*omap*
-F:	arch/arm/boot/dts/logicpd-som-lv*
-F:	arch/arm/boot/dts/logicpd-torpedo*
+F:	arch/arm/boot/dts/ti/
 
 OMAP DISPLAY SUBSYSTEM and FRAMEBUFFER SUPPORT (DSS2)
 L:	linux-omap@vger.kernel.org
@@ -15270,7 +15245,7 @@ OMAP/NEWFLOW NANOBONE MACHINE SUPPORT
 M:	Mark Jackson <mpfj@newflow.co.uk>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
-F:	arch/arm/boot/dts/am335x-nano.dts
+F:	arch/arm/boot/dts/ti/am335x-nano.dts
 
 OMAP1 SUPPORT
 M:	Aaro Koskinen <aaro.koskinen@iki.fi>
@@ -17010,7 +16985,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://github.com/hzhuang1/linux.git
 T:	git git://github.com/rjarzmik/linux.git
-F:	arch/arm/boot/dts/pxa*
+F:	arch/arm/boot/dts/intel/pxa/
 F:	arch/arm/mach-pxa/
 F:	drivers/dma/pxa*
 F:	drivers/pcmcia/pxa2xx*
@@ -18589,7 +18564,7 @@ SANCLOUD BEAGLEBONE ENHANCED DEVICE TREE
 M:	Paul Barker <paul.barker@sancloud.com>
 R:	Marc Murphy <marc.murphy@sancloud.com>
 S:	Supported
-F:	arch/arm/boot/dts/am335x-sancloud*
+F:	arch/arm/boot/dts/ti/am335x-sancloud*
 
 SC1200 WDT DRIVER
 M:	Zwane Mwaikambo <zwanem@gmail.com>
@@ -19402,15 +19377,15 @@ F:	include/uapi/linux/raid/
 SOLIDRUN CLEARFOG SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 S:	Maintained
-F:	arch/arm/boot/dts/armada-388-clearfog*
-F:	arch/arm/boot/dts/armada-38x-solidrun-*
+F:	arch/arm/boot/dts/marvell/armada-388-clearfog*
+F:	arch/arm/boot/dts/marvell/armada-38x-solidrun-*
 
 SOLIDRUN CUBOX-I/HUMMINGBOARD SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 S:	Maintained
-F:	arch/arm/boot/dts/imx6*-cubox-i*
-F:	arch/arm/boot/dts/imx6*-hummingboard*
-F:	arch/arm/boot/dts/imx6*-sr-*
+F:	arch/arm/boot/dts/nxp/imx/imx6*-cubox-i*
+F:	arch/arm/boot/dts/nxp/imx/imx6*-hummingboard*
+F:	arch/arm/boot/dts/nxp/imx/imx6*-sr-*
 
 SONIC NETWORK DRIVER
 M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
@@ -19695,7 +19670,7 @@ M:	soc@kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://www.st.com/spear
-F:	arch/arm/boot/dts/spear*
+F:	arch/arm/boot/dts/st/spear*
 F:	arch/arm/mach-spear/
 F:	drivers/clk/spear/
 F:	drivers/pinctrl/spear/
@@ -20880,7 +20855,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
 F:	Documentation/devicetree/bindings/i2c/i2c-davinci.txt
-F:	arch/arm/boot/dts/da850*
+F:	arch/arm/boot/dts/ti/da850*
 F:	arch/arm/mach-davinci/
 F:	drivers/i2c/busses/i2c-davinci.c
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3cf1bf724e8e..efe38eb25301 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1,1680 +1,41 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_ALPINE) += \
-	alpine-db.dtb
-dtb-$(CONFIG_MACH_ARTPEC6) += \
-	artpec6-devboard.dtb
-dtb-$(CONFIG_MACH_ASM9260) += \
-	alphascale-asm9260-devkit.dtb
-# Keep at91 dtb files sorted alphabetically for each SoC
-dtb-$(CONFIG_SOC_AT91RM9200) += \
-	at91rm9200ek.dtb \
-	mpa1600.dtb
-dtb-$(CONFIG_SOC_AT91SAM9) += \
-	animeo_ip.dtb \
-	at91-qil_a9260.dtb \
-	aks-cdu.dtb \
-	ethernut5.dtb \
-	evk-pro3.dtb \
-	tny_a9260.dtb \
-	usb_a9260.dtb \
-	at91sam9260ek.dtb \
-	at91sam9261ek.dtb \
-	at91sam9263ek.dtb \
-	at91-sam9_l9260.dtb \
-	tny_a9263.dtb \
-	usb_a9263.dtb \
-	at91-foxg20.dtb \
-	at91-kizbox.dtb \
-	at91-lmu5000.dtb \
-	at91sam9g20ek.dtb \
-	at91sam9g20ek_2mmc.dtb \
-	tny_a9g20.dtb \
-	usb_a9g20.dtb \
-	usb_a9g20_lpw.dtb \
-	at91sam9m10g45ek.dtb \
-	pm9g45.dtb \
-	at91sam9n12ek.dtb \
-	at91sam9rlek.dtb \
-	at91-ariag25.dtb \
-	at91-ariettag25.dtb \
-	at91-cosino_mega2560.dtb \
-	at91-kizboxmini-base.dtb \
-	at91-kizboxmini-mb.dtb \
-	at91-kizboxmini-rd.dtb \
-	at91-q5xr5.dtb \
-	at91-smartkiz.dtb \
-	at91-wb45n.dtb \
-	at91sam9g15ek.dtb \
-	at91sam9g25-gardena-smart-gateway.dtb \
-	at91sam9g25ek.dtb \
-	at91sam9g35ek.dtb \
-	at91sam9x25ek.dtb \
-	at91sam9x35ek.dtb
-dtb-$(CONFIG_SOC_SAM9X60) += \
-	at91-sam9x60_curiosity.dtb \
-	at91-sam9x60ek.dtb
-dtb-$(CONFIG_SOC_SAM_V7) += \
-	at91-kizbox2-2.dtb \
-	at91-kizbox3-hs.dtb \
-	at91-nattis-2-natte-2.dtb \
-	at91-sama5d27_som1_ek.dtb \
-	at91-sama5d27_wlsom1_ek.dtb \
-	at91-sama5d2_icp.dtb \
-	at91-sama5d2_ptc_ek.dtb \
-	at91-sama5d2_xplained.dtb \
-	at91-sama5d3_eds.dtb \
-	at91-sama5d3_ksz9477_evb.dtb \
-	at91-sama5d3_xplained.dtb \
-	at91-dvk_som60.dtb \
-	at91-gatwick.dtb \
-	at91-tse850-3.dtb \
-	at91-wb50n.dtb \
-	sama5d31ek.dtb \
-	sama5d33ek.dtb \
-	sama5d34ek.dtb \
-	sama5d35ek.dtb \
-	sama5d36ek.dtb \
-	sama5d36ek_cmp.dtb \
-	at91-sama5d4_ma5d4evk.dtb \
-	at91-sama5d4_xplained.dtb \
-	at91-sama5d4ek.dtb \
-	at91-vinco.dtb
-dtb-$(CONFIG_SOC_SAMA7G5) += \
-	at91-sama7g5ek.dtb
-dtb-$(CONFIG_SOC_SP7021) += \
-	sunplus-sp7021-demo-v3.dtb
-dtb-$(CONFIG_ARCH_AXXIA) += \
-	axm5516-amarillo.dtb
-dtb-$(CONFIG_ARCH_BCM2835) += \
-	bcm2835-rpi-b.dtb \
-	bcm2835-rpi-a.dtb \
-	bcm2835-rpi-b-rev2.dtb \
-	bcm2835-rpi-b-plus.dtb \
-	bcm2835-rpi-a-plus.dtb \
-	bcm2835-rpi-cm1-io1.dtb \
-	bcm2836-rpi-2-b.dtb \
-	bcm2837-rpi-3-a-plus.dtb \
-	bcm2837-rpi-3-b.dtb \
-	bcm2837-rpi-3-b-plus.dtb \
-	bcm2837-rpi-cm3-io3.dtb \
-	bcm2837-rpi-zero-2-w.dtb \
-	bcm2711-rpi-400.dtb \
-	bcm2711-rpi-4-b.dtb \
-	bcm2711-rpi-cm4-io.dtb \
-	bcm2835-rpi-zero.dtb \
-	bcm2835-rpi-zero-w.dtb
-dtb-$(CONFIG_ARCH_BCM_5301X) += \
-	bcm4708-asus-rt-ac56u.dtb \
-	bcm4708-asus-rt-ac68u.dtb \
-	bcm4708-buffalo-wzr-1750dhp.dtb \
-	bcm4708-buffalo-wzr-1166dhp.dtb \
-	bcm4708-buffalo-wzr-1166dhp2.dtb \
-	bcm4708-linksys-ea6300-v1.dtb \
-	bcm4708-linksys-ea6500-v2.dtb \
-	bcm4708-luxul-xap-1510.dtb \
-	bcm4708-luxul-xwc-1000.dtb \
-	bcm4708-netgear-r6250.dtb \
-	bcm4708-netgear-r6300-v2.dtb \
-	bcm4708-smartrg-sr400ac.dtb \
-	bcm47081-asus-rt-n18u.dtb \
-	bcm47081-buffalo-wzr-600dhp2.dtb \
-	bcm47081-buffalo-wzr-900dhp.dtb \
-	bcm47081-luxul-xap-1410.dtb \
-	bcm47081-luxul-xwr-1200.dtb \
-	bcm47081-tplink-archer-c5-v2.dtb \
-	bcm4709-asus-rt-ac87u.dtb \
-	bcm4709-buffalo-wxr-1900dhp.dtb \
-	bcm4709-linksys-ea9200.dtb \
-	bcm4709-netgear-r7000.dtb \
-	bcm4709-netgear-r8000.dtb \
-	bcm4709-tplink-archer-c9-v1.dtb \
-	bcm47094-asus-rt-ac88u.dtb \
-	bcm47094-dlink-dir-885l.dtb \
-	bcm47094-dlink-dir-890l.dtb \
-	bcm47094-linksys-panamera.dtb \
-	bcm47094-luxul-abr-4500.dtb \
-	bcm47094-luxul-xap-1610.dtb \
-	bcm47094-luxul-xbr-4500.dtb \
-	bcm47094-luxul-xwc-2000.dtb \
-	bcm47094-luxul-xwr-3100.dtb \
-	bcm47094-luxul-xwr-3150-v1.dtb \
-	bcm47094-netgear-r8500.dtb \
-	bcm47094-phicomm-k3.dtb \
-	bcm53015-meraki-mr26.dtb \
-	bcm53016-dlink-dwl-8610ap.dtb \
-	bcm53016-meraki-mr32.dtb \
-	bcm94708.dtb \
-	bcm94709.dtb \
-	bcm953012er.dtb \
-	bcm953012hr.dtb \
-	bcm953012k.dtb
-dtb-$(CONFIG_ARCH_BCM_53573) += \
-	bcm47189-luxul-xap-1440.dtb \
-	bcm47189-luxul-xap-810.dtb \
-	bcm47189-tenda-ac9.dtb \
-	bcm947189acdbmr.dtb
-dtb-$(CONFIG_ARCH_BCM_CYGNUS) += \
-	bcm911360_entphn.dtb \
-	bcm911360k.dtb \
-	bcm958300k.dtb \
-	bcm958305k.dtb
-dtb-$(CONFIG_ARCH_BCM_HR2) += \
-	bcm53340-ubnt-unifi-switch8.dtb
-dtb-$(CONFIG_ARCH_BCM_MOBILE) += \
-	bcm28155-ap.dtb \
-	bcm21664-garnet.dtb \
-	bcm23550-sparrow.dtb
-dtb-$(CONFIG_ARCH_BCM_NSP) += \
-	bcm958522er.dtb \
-	bcm958525er.dtb \
-	bcm958525xmc.dtb \
-	bcm958622hr.dtb \
-	bcm958623hr.dtb \
-	bcm958625-meraki-mx64.dtb \
-	bcm958625-meraki-mx64-a0.dtb \
-	bcm958625-meraki-mx64w.dtb \
-	bcm958625-meraki-mx64w-a0.dtb \
-	bcm958625-meraki-mx65.dtb \
-	bcm958625-meraki-mx65w.dtb \
-	bcm958625hr.dtb \
-	bcm988312hr.dtb \
-	bcm958625k.dtb
-dtb-$(CONFIG_ARCH_BERLIN) += \
-	berlin2-sony-nsz-gs7.dtb \
-	berlin2cd-google-chromecast.dtb \
-	berlin2cd-valve-steamlink.dtb \
-	berlin2q-marvell-dmp.dtb
-dtb-$(CONFIG_ARCH_BRCMSTB) += \
-	bcm7445-bcm97445svmb.dtb
-dtb-$(CONFIG_ARCH_BCMBCA) += \
-	bcm947622.dtb \
-	bcm963138.dtb \
-	bcm963138dvt.dtb \
-	bcm963148.dtb \
-	bcm963178.dtb \
-	bcm96756.dtb \
-	bcm96846.dtb \
-	bcm96855.dtb \
-	bcm96878.dtb
-dtb-$(CONFIG_ARCH_CLPS711X) += \
-	ep7211-edb7211.dtb
-dtb-$(CONFIG_ARCH_DAVINCI) += \
-	da850-lcdk.dtb \
-	da850-enbw-cmc.dtb \
-	da850-evm.dtb \
-	da850-lego-ev3.dtb
-dtb-$(CONFIG_ARCH_DIGICOLOR) += \
-	cx92755_equinox.dtb
-dtb-$(CONFIG_ARCH_AIROHA) += \
-	en7523-evb.dtb
-dtb-$(CONFIG_ARCH_EXYNOS3) += \
-	exynos3250-artik5-eval.dtb \
-	exynos3250-monk.dtb \
-	exynos3250-rinato.dtb
-dtb-$(CONFIG_ARCH_EXYNOS4) += \
-	exynos4210-i9100.dtb \
-	exynos4210-origen.dtb \
-	exynos4210-smdkv310.dtb \
-	exynos4210-trats.dtb \
-	exynos4210-universal_c210.dtb \
-	exynos4412-i9300.dtb \
-	exynos4412-i9305.dtb \
-	exynos4412-itop-elite.dtb \
-	exynos4412-n710x.dtb \
-	exynos4412-odroidu3.dtb \
-	exynos4412-odroidx.dtb \
-	exynos4412-odroidx2.dtb \
-	exynos4412-origen.dtb \
-	exynos4412-p4note-n8010.dtb \
-	exynos4412-smdk4412.dtb \
-	exynos4412-tiny4412.dtb \
-	exynos4412-trats2.dtb
-dtb-$(CONFIG_ARCH_EXYNOS5) += \
-	exynos5250-arndale.dtb \
-	exynos5250-smdk5250.dtb \
-	exynos5250-snow.dtb \
-	exynos5250-snow-rev5.dtb \
-	exynos5250-spring.dtb \
-	exynos5260-xyref5260.dtb \
-	exynos5410-odroidxu.dtb \
-	exynos5410-smdk5410.dtb \
-	exynos5420-arndale-octa.dtb \
-	exynos5420-peach-pit.dtb \
-	exynos5420-smdk5420.dtb \
-	exynos5420-chagall-wifi.dtb \
-	exynos5420-klimt-wifi.dtb \
-	exynos5422-odroidhc1.dtb \
-	exynos5422-odroidxu3.dtb \
-	exynos5422-odroidxu3-lite.dtb \
-	exynos5422-odroidxu4.dtb \
-	exynos5422-samsung-k3g.dtb \
-	exynos5800-peach-pi.dtb
-dtb-$(CONFIG_ARCH_GEMINI) += \
-	gemini-dlink-dir-685.dtb \
-	gemini-dlink-dns-313.dtb \
-	gemini-nas4220b.dtb \
-	gemini-ns2502.dtb \
-	gemini-rut1xx.dtb \
-	gemini-sl93512r.dtb \
-	gemini-sq201.dtb \
-	gemini-ssi1328.dtb \
-	gemini-wbd111.dtb \
-	gemini-wbd222.dtb
-dtb-$(CONFIG_ARCH_HI3xxx) += \
-	hi3620-hi4511.dtb
-dtb-$(CONFIG_ARCH_HIGHBANK) += \
-	highbank.dtb \
-	ecx-2000.dtb
-dtb-$(CONFIG_ARCH_HIP01) += \
-	hip01-ca9x2.dtb
-dtb-$(CONFIG_ARCH_HIP04) += \
-	hip04-d01.dtb
-dtb-$(CONFIG_ARCH_HISI) += \
-	hi3519-demb.dtb
-dtb-$(CONFIG_ARCH_HIX5HD2) += \
-	hisi-x5hd2-dkb.dtb
-dtb-$(CONFIG_ARCH_HPE_GXP) += \
-	hpe-bmc-dl360gen10.dtb
-dtb-$(CONFIG_ARCH_INTEGRATOR) += \
-	integratorap.dtb \
-	integratorap-im-pd1.dtb \
-	integratorcp.dtb
-dtb-$(CONFIG_ARCH_IXP4XX) += \
-	intel-ixp42x-linksys-nslu2.dtb \
-	intel-ixp42x-linksys-wrv54g.dtb \
-	intel-ixp42x-freecom-fsg-3.dtb \
-	intel-ixp42x-welltech-epbx100.dtb \
-	intel-ixp42x-ixdp425.dtb \
-	intel-ixp43x-kixrp435.dtb \
-	intel-ixp46x-ixdp465.dtb \
-	intel-ixp42x-adi-coyote.dtb \
-	intel-ixp42x-ixdpg425.dtb \
-	intel-ixp42x-goramo-multilink.dtb \
-	intel-ixp42x-iomega-nas100d.dtb \
-	intel-ixp42x-dlink-dsm-g600.dtb \
-	intel-ixp42x-gateworks-gw2348.dtb \
-	intel-ixp43x-gateworks-gw2358.dtb \
-	intel-ixp42x-netgear-wg302v1.dtb \
-	intel-ixp42x-arcom-vulcan.dtb \
-	intel-ixp42x-gateway-7001.dtb
-dtb-$(CONFIG_ARCH_KEYSTONE) += \
-	keystone-k2hk-evm.dtb \
-	keystone-k2l-evm.dtb \
-	keystone-k2e-evm.dtb \
-	keystone-k2g-evm.dtb \
-	keystone-k2g-ice.dtb
-dtb-$(CONFIG_MACH_KIRKWOOD) += \
-	kirkwood-b3.dtb \
-	kirkwood-blackarmor-nas220.dtb \
-	kirkwood-c200-v1.dtb \
-	kirkwood-cloudbox.dtb \
-	kirkwood-d2net.dtb \
-	kirkwood-db-88f6281.dtb \
-	kirkwood-db-88f6282.dtb \
-	kirkwood-dir665.dtb \
-	kirkwood-dns320.dtb \
-	kirkwood-dns325.dtb \
-	kirkwood-dockstar.dtb \
-	kirkwood-dreamplug.dtb \
-	kirkwood-ds109.dtb \
-	kirkwood-ds110jv10.dtb \
-	kirkwood-ds111.dtb \
-	kirkwood-ds112.dtb \
-	kirkwood-ds209.dtb \
-	kirkwood-ds210.dtb \
-	kirkwood-ds212.dtb \
-	kirkwood-ds212j.dtb \
-	kirkwood-ds409.dtb \
-	kirkwood-ds409slim.dtb \
-	kirkwood-ds411.dtb \
-	kirkwood-ds411j.dtb \
-	kirkwood-ds411slim.dtb \
-	kirkwood-goflexnet.dtb \
-	kirkwood-guruplug-server-plus.dtb \
-	kirkwood-ib62x0.dtb \
-	kirkwood-iconnect.dtb \
-	kirkwood-iomega_ix2_200.dtb \
-	kirkwood-is2.dtb \
-	kirkwood-km_fixedeth.dtb \
-	kirkwood-km_kirkwood.dtb \
-	kirkwood-l-50.dtb \
-	kirkwood-laplug.dtb \
-	kirkwood-linkstation-lsqvl.dtb \
-	kirkwood-linkstation-lsvl.dtb \
-	kirkwood-linkstation-lswsxl.dtb \
-	kirkwood-linkstation-lswvl.dtb \
-	kirkwood-linkstation-lswxl.dtb \
-	kirkwood-linksys-viper.dtb \
-	kirkwood-lschlv2.dtb \
-	kirkwood-lsxhl.dtb \
-	kirkwood-mplcec4.dtb \
-	kirkwood-mv88f6281gtw-ge.dtb \
-	kirkwood-nas2big.dtb \
-	kirkwood-net2big.dtb \
-	kirkwood-net5big.dtb \
-	kirkwood-netgear_readynas_duo_v2.dtb \
-	kirkwood-netgear_readynas_nv+_v2.dtb \
-	kirkwood-ns2.dtb \
-	kirkwood-ns2lite.dtb \
-	kirkwood-ns2max.dtb \
-	kirkwood-ns2mini.dtb \
-	kirkwood-nsa310.dtb \
-	kirkwood-nsa310a.dtb \
-	kirkwood-nsa310s.dtb \
-	kirkwood-nsa320.dtb \
-	kirkwood-nsa325.dtb \
-	kirkwood-openblocks_a6.dtb \
-	kirkwood-openblocks_a7.dtb \
-	kirkwood-openrd-base.dtb \
-	kirkwood-openrd-client.dtb \
-	kirkwood-openrd-ultimate.dtb \
-	kirkwood-pogo_e02.dtb \
-	kirkwood-pogoplug-series-4.dtb \
-	kirkwood-rd88f6192.dtb \
-	kirkwood-rd88f6281-z0.dtb \
-	kirkwood-rd88f6281-a.dtb \
-	kirkwood-rs212.dtb \
-	kirkwood-rs409.dtb \
-	kirkwood-rs411.dtb \
-	kirkwood-sheevaplug.dtb \
-	kirkwood-sheevaplug-esata.dtb \
-	kirkwood-t5325.dtb \
-	kirkwood-topkick.dtb \
-	kirkwood-ts219-6281.dtb \
-	kirkwood-ts219-6282.dtb \
-	kirkwood-ts419-6281.dtb \
-	kirkwood-ts419-6282.dtb
-dtb-$(CONFIG_ARCH_LPC18XX) += \
-	lpc4337-ciaa.dtb \
-	lpc4350-hitex-eval.dtb \
-	lpc4357-ea4357-devkit.dtb \
-	lpc4357-myd-lpc4357.dtb
-dtb-$(CONFIG_ARCH_LPC32XX) += \
-	lpc3250-ea3250.dtb \
-	lpc3250-phy3250.dtb
-dtb-$(CONFIG_ARCH_WPCM450) += \
-	nuvoton-wpcm450-supermicro-x9sci-ln4f.dtb
-dtb-$(CONFIG_ARCH_NPCM7XX) += \
-	nuvoton-npcm730-gsj.dtb \
-	nuvoton-npcm730-gbs.dtb \
-	nuvoton-npcm730-kudo.dtb \
-	nuvoton-npcm750-evb.dtb \
-	nuvoton-npcm750-runbmc-olympus.dtb
-dtb-$(CONFIG_MACH_MESON6) += \
-	meson6-atv1200.dtb
-dtb-$(CONFIG_MACH_MESON8) += \
-	meson8-minix-neo-x8.dtb \
-	meson8b-ec100.dtb \
-	meson8b-mxq.dtb \
-	meson8b-odroidc1.dtb \
-	meson8m2-mxiii-plus.dtb
-dtb-$(CONFIG_ARCH_MMP) += \
-	pxa168-aspenite.dtb \
-	pxa910-dkb.dtb \
-	mmp2-brownstone.dtb \
-	mmp2-olpc-xo-1-75.dtb \
-	mmp3-dell-ariel.dtb
-dtb-$(CONFIG_ARCH_MPS2) += \
-	mps2-an385.dtb \
-	mps2-an399.dtb
-dtb-$(CONFIG_ARCH_MOXART) += \
-	moxart-uc7112lx.dtb
-dtb-$(CONFIG_ARCH_SD5203) += \
-	sd5203.dtb
-dtb-$(CONFIG_SOC_IMX1) += \
-	imx1-ads.dtb \
-	imx1-apf9328.dtb
-dtb-$(CONFIG_SOC_IMX25) += \
-	imx25-eukrea-mbimxsd25-baseboard.dtb \
-	imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb \
-	imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb \
-	imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb \
-	imx25-karo-tx25.dtb \
-	imx25-pdk.dtb
-dtb-$(CONFIG_SOC_IMX27) += \
-	imx27-apf27.dtb \
-	imx27-apf27dev.dtb \
-	imx27-eukrea-mbimxsd27-baseboard.dtb \
-	imx27-pdk.dtb \
-	imx27-phytec-phycore-rdk.dtb \
-	imx27-phytec-phycard-s-rdk.dtb
-dtb-$(CONFIG_SOC_IMX31) += \
-	imx31-bug.dtb \
-	imx31-lite.dtb
-dtb-$(CONFIG_SOC_IMX35) += \
-	imx35-eukrea-mbimxsd35-baseboard.dtb \
-	imx35-pdk.dtb
-dtb-$(CONFIG_SOC_IMX50) += \
-	imx50-evk.dtb \
-	imx50-kobo-aura.dtb
-dtb-$(CONFIG_SOC_IMX51) += \
-	imx51-apf51.dtb \
-	imx51-apf51dev.dtb \
-	imx51-babbage.dtb \
-	imx51-digi-connectcore-jsk.dtb \
-	imx51-eukrea-mbimxsd51-baseboard.dtb \
-	imx51-ts4800.dtb \
-	imx51-zii-rdu1.dtb \
-	imx51-zii-scu2-mezz.dtb \
-	imx51-zii-scu3-esb.dtb
-dtb-$(CONFIG_SOC_IMX53) += \
-	imx53-ard.dtb \
-	imx53-cx9020.dtb \
-	imx53-kp-ddc.dtb \
-	imx53-kp-hsc.dtb \
-	imx53-m53evk.dtb \
-	imx53-m53menlo.dtb \
-	imx53-mba53.dtb \
-	imx53-ppd.dtb \
-	imx53-qsb.dtb \
-	imx53-qsrb.dtb \
-	imx53-sk-imx53.dtb \
-	imx53-smd.dtb \
-	imx53-tx53-x03x.dtb \
-	imx53-tx53-x13x.dtb \
-	imx53-usbarmory.dtb \
-	imx53-voipac-bsb.dtb
-dtb-$(CONFIG_SOC_IMX6Q) += \
-	imx6dl-alti6p.dtb \
-	imx6dl-apf6dev.dtb \
-	imx6dl-aristainetos_4.dtb \
-	imx6dl-aristainetos_7.dtb \
-	imx6dl-aristainetos2_4.dtb \
-	imx6dl-aristainetos2_7.dtb \
-	imx6dl-colibri-aster.dtb \
-	imx6dl-colibri-eval-v3.dtb \
-	imx6dl-colibri-iris.dtb \
-	imx6dl-colibri-iris-v2.dtb \
-	imx6dl-cubox-i.dtb \
-	imx6dl-cubox-i-emmc-som-v15.dtb \
-	imx6dl-cubox-i-som-v15.dtb \
-	imx6dl-dfi-fs700-m60.dtb \
-	imx6dl-dhcom-picoitx.dtb \
-	imx6dl-eckelmann-ci4x10.dtb \
-	imx6dl-emcon-avari.dtb \
-	imx6dl-gw51xx.dtb \
-	imx6dl-gw52xx.dtb \
-	imx6dl-gw53xx.dtb \
-	imx6dl-gw54xx.dtb \
-	imx6dl-gw551x.dtb \
-	imx6dl-gw552x.dtb \
-	imx6dl-gw553x.dtb \
-	imx6dl-gw560x.dtb \
-	imx6dl-gw5903.dtb \
-	imx6dl-gw5904.dtb \
-	imx6dl-gw5907.dtb \
-	imx6dl-gw5910.dtb \
-	imx6dl-gw5912.dtb \
-	imx6dl-gw5913.dtb \
-	imx6dl-hummingboard.dtb \
-	imx6dl-hummingboard-emmc-som-v15.dtb \
-	imx6dl-hummingboard-som-v15.dtb \
-	imx6dl-hummingboard2.dtb \
-	imx6dl-hummingboard2-emmc-som-v15.dtb \
-	imx6dl-hummingboard2-som-v15.dtb \
-	imx6dl-icore.dtb \
-	imx6dl-icore-mipi.dtb \
-	imx6dl-icore-rqs.dtb \
-	imx6dl-lanmcu.dtb \
-	imx6dl-mamoj.dtb \
-	imx6dl-mba6a.dtb \
-	imx6dl-mba6b.dtb \
-	imx6dl-nit6xlite.dtb \
-	imx6dl-nitrogen6x.dtb \
-	imx6dl-phytec-mira-rdk-nand.dtb \
-	imx6dl-phytec-pbab01.dtb \
-	imx6dl-pico-dwarf.dtb \
-	imx6dl-pico-hobbit.dtb \
-	imx6dl-pico-nymph.dtb \
-	imx6dl-pico-pi.dtb \
-	imx6dl-plybas.dtb \
-	imx6dl-plym2m.dtb \
-	imx6dl-prtmvt.dtb \
-	imx6dl-prtrvt.dtb \
-	imx6dl-prtvt7.dtb \
-	imx6dl-rex-basic.dtb \
-	imx6dl-riotboard.dtb \
-	imx6dl-sabreauto.dtb \
-	imx6dl-sabrelite.dtb \
-	imx6dl-sabresd.dtb \
-	imx6dl-savageboard.dtb \
-	imx6dl-skov-revc-lt2.dtb \
-	imx6dl-skov-revc-lt6.dtb \
-	imx6dl-solidsense.dtb \
-	imx6dl-ts4900.dtb \
-	imx6dl-ts7970.dtb \
-	imx6dl-tx6dl-comtft.dtb \
-	imx6dl-tx6s-8034.dtb \
-	imx6dl-tx6s-8034-mb7.dtb \
-	imx6dl-tx6s-8035.dtb \
-	imx6dl-tx6s-8035-mb7.dtb \
-	imx6dl-tx6u-801x.dtb \
-	imx6dl-tx6u-80xx-mb7.dtb \
-	imx6dl-tx6u-8033.dtb \
-	imx6dl-tx6u-8033-mb7.dtb \
-	imx6dl-tx6u-811x.dtb \
-	imx6dl-tx6u-81xx-mb7.dtb \
-	imx6dl-udoo.dtb \
-	imx6dl-victgo.dtb \
-	imx6dl-vicut1.dtb \
-	imx6dl-wandboard.dtb \
-	imx6dl-wandboard-revb1.dtb \
-	imx6dl-wandboard-revd1.dtb \
-	imx6dl-yapp4-draco.dtb \
-	imx6dl-yapp4-hydra.dtb \
-	imx6dl-yapp4-lynx.dtb \
-	imx6dl-yapp4-orion.dtb \
-	imx6dl-yapp4-phoenix.dtb \
-	imx6dl-yapp4-ursa.dtb \
-	imx6q-apalis-eval.dtb \
-	imx6q-apalis-ixora.dtb \
-	imx6q-apalis-ixora-v1.1.dtb \
-	imx6q-apalis-ixora-v1.2.dtb \
-	imx6q-apf6dev.dtb \
-	imx6q-arm2.dtb \
-	imx6q-b450v3.dtb \
-	imx6q-b650v3.dtb \
-	imx6q-b850v3.dtb \
-	imx6q-bosch-acc.dtb \
-	imx6q-cm-fx6.dtb \
-	imx6q-cubox-i.dtb \
-	imx6q-cubox-i-emmc-som-v15.dtb \
-	imx6q-cubox-i-som-v15.dtb \
-	imx6q-dfi-fs700-m60.dtb \
-	imx6q-dhcom-pdk2.dtb \
-	imx6q-display5-tianma-tm070-1280x768.dtb \
-	imx6q-dmo-edmqmx6.dtb \
-	imx6q-dms-ba16.dtb \
-	imx6q-ds.dtb \
-	imx6q-emcon-avari.dtb \
-	imx6q-evi.dtb \
-	imx6dl-b105pv2.dtb \
-	imx6dl-b105v2.dtb \
-	imx6dl-b125v2.dtb \
-	imx6dl-b125pv2.dtb \
-	imx6dl-b155v2.dtb \
-	imx6q-gk802.dtb \
-	imx6q-gw51xx.dtb \
-	imx6q-gw52xx.dtb \
-	imx6q-gw53xx.dtb \
-	imx6q-gw5400-a.dtb \
-	imx6q-gw54xx.dtb \
-	imx6q-gw551x.dtb \
-	imx6q-gw552x.dtb \
-	imx6q-gw553x.dtb \
-	imx6q-gw560x.dtb \
-	imx6q-gw5903.dtb \
-	imx6q-gw5904.dtb \
-	imx6q-gw5907.dtb \
-	imx6q-gw5910.dtb \
-	imx6q-gw5912.dtb \
-	imx6q-gw5913.dtb \
-	imx6q-h100.dtb \
-	imx6q-hummingboard.dtb \
-	imx6q-hummingboard-emmc-som-v15.dtb \
-	imx6q-hummingboard-som-v15.dtb \
-	imx6q-hummingboard2.dtb \
-	imx6q-hummingboard2-emmc-som-v15.dtb \
-	imx6q-hummingboard2-som-v15.dtb \
-	imx6q-icore.dtb \
-	imx6q-icore-mipi.dtb \
-	imx6q-icore-ofcap10.dtb \
-	imx6q-icore-ofcap12.dtb \
-	imx6q-icore-rqs.dtb \
-	imx6q-kp-tpc.dtb \
-	imx6q-logicpd.dtb \
-	imx6q-marsboard.dtb \
-	imx6q-mba6a.dtb \
-	imx6q-mba6b.dtb \
-	imx6q-mccmon6.dtb \
-	imx6q-nitrogen6x.dtb \
-	imx6q-nitrogen6_max.dtb \
-	imx6q-nitrogen6_som2.dtb \
-	imx6q-novena.dtb \
-	imx6q-phytec-mira-rdk-emmc.dtb \
-	imx6q-phytec-mira-rdk-nand.dtb \
-	imx6q-phytec-pbab01.dtb \
-	imx6q-pico-dwarf.dtb \
-	imx6q-pico-hobbit.dtb \
-	imx6q-pico-nymph.dtb \
-	imx6q-pico-pi.dtb \
-	imx6q-pistachio.dtb \
-	imx6q-prti6q.dtb \
-	imx6q-prtwd2.dtb \
-	imx6q-rex-pro.dtb \
-	imx6q-sabreauto.dtb \
-	imx6q-sabrelite.dtb \
-	imx6q-sabresd.dtb \
-	imx6q-savageboard.dtb \
-	imx6q-sbc6x.dtb \
-	imx6q-skov-revc-lt2.dtb \
-	imx6q-skov-revc-lt6.dtb \
-	imx6q-skov-reve-mi1010ait-1cp1.dtb \
-	imx6q-solidsense.dtb \
-	imx6q-tbs2910.dtb \
-	imx6q-ts4900.dtb \
-	imx6q-ts7970.dtb \
-	imx6q-tx6q-1010.dtb \
-	imx6q-tx6q-1010-comtft.dtb \
-	imx6q-tx6q-1020.dtb \
-	imx6q-tx6q-1020-comtft.dtb \
-	imx6q-tx6q-1036.dtb \
-	imx6q-tx6q-1036-mb7.dtb \
-	imx6q-tx6q-10x0-mb7.dtb \
-	imx6q-tx6q-1110.dtb \
-	imx6q-tx6q-11x0-mb7.dtb \
-	imx6q-udoo.dtb \
-	imx6q-utilite-pro.dtb \
-	imx6q-var-dt6customboard.dtb \
-	imx6q-vicut1.dtb \
-	imx6q-wandboard.dtb \
-	imx6q-wandboard-revb1.dtb \
-	imx6q-wandboard-revd1.dtb \
-	imx6q-yapp4-crux.dtb \
-	imx6q-yapp4-pegasus.dtb \
-	imx6q-zii-rdu2.dtb \
-	imx6qp-mba6b.dtb \
-	imx6qp-nitrogen6_max.dtb \
-	imx6qp-nitrogen6_som2.dtb \
-	imx6qp-phytec-mira-rdk-nand.dtb \
-	imx6qp-prtwd3.dtb \
-	imx6qp-sabreauto.dtb \
-	imx6qp-sabresd.dtb \
-	imx6qp-tx6qp-8037.dtb \
-	imx6qp-tx6qp-8037-mb7.dtb \
-	imx6qp-tx6qp-8137.dtb \
-	imx6qp-tx6qp-8137-mb7.dtb \
-	imx6qp-vicutp.dtb \
-	imx6qp-wandboard-revd1.dtb \
-	imx6qp-yapp4-crux-plus.dtb \
-	imx6qp-yapp4-pegasus-plus.dtb \
-	imx6qp-zii-rdu2.dtb \
-	imx6s-dhcom-drc02.dtb
-dtb-$(CONFIG_SOC_IMX6SL) += \
-	imx6sl-evk.dtb \
-	imx6sl-kobo-aura2.dtb \
-	imx6sl-tolino-shine2hd.dtb \
-	imx6sl-tolino-shine3.dtb \
-	imx6sl-tolino-vision.dtb \
-	imx6sl-tolino-vision5.dtb \
-	imx6sl-warp.dtb
-dtb-$(CONFIG_SOC_IMX6SLL) += \
-	imx6sll-evk.dtb \
-	imx6sll-kobo-clarahd.dtb \
-	imx6sll-kobo-librah2o.dtb
-dtb-$(CONFIG_SOC_IMX6SX) += \
-	imx6sx-nitrogen6sx.dtb \
-	imx6sx-sabreauto.dtb \
-	imx6sx-sdb-reva.dtb \
-	imx6sx-sdb-sai.dtb \
-	imx6sx-sdb.dtb \
-	imx6sx-sdb-mqs.dtb \
-	imx6sx-softing-vining-2000.dtb \
-	imx6sx-udoo-neo-basic.dtb \
-	imx6sx-udoo-neo-extended.dtb \
-	imx6sx-udoo-neo-full.dtb
-dtb-$(CONFIG_SOC_IMX6UL) += \
-	imx6ul-14x14-evk.dtb \
-	imx6ul-ccimx6ulsbcexpress.dtb \
-	imx6ul-ccimx6ulsbcpro.dtb \
-	imx6ul-geam.dtb \
-	imx6ul-isiot-emmc.dtb \
-	imx6ul-isiot-nand.dtb \
-	imx6ul-kontron-bl.dtb \
-	imx6ul-kontron-bl-43.dtb \
-	imx6ul-liteboard.dtb \
-	imx6ul-tqma6ul1-mba6ulx.dtb \
-	imx6ul-tqma6ul2-mba6ulx.dtb \
-	imx6ul-tqma6ul2l-mba6ulx.dtb \
-	imx6ul-opos6uldev.dtb \
-	imx6ul-pico-dwarf.dtb \
-	imx6ul-pico-hobbit.dtb \
-	imx6ul-pico-pi.dtb \
-	imx6ul-phytec-segin-ff-rdk-emmc.dtb \
-	imx6ul-phytec-segin-ff-rdk-nand.dtb \
-	imx6ul-prti6g.dtb \
-	imx6ul-tx6ul-0010.dtb \
-	imx6ul-tx6ul-0011.dtb \
-	imx6ul-tx6ul-mainboard.dtb \
-	imx6ull-14x14-evk.dtb \
-	imx6ull-colibri-aster.dtb \
-	imx6ull-colibri-emmc-aster.dtb \
-	imx6ull-colibri-emmc-eval-v3.dtb \
-	imx6ull-colibri-emmc-iris.dtb \
-	imx6ull-colibri-emmc-iris-v2.dtb \
-	imx6ull-colibri-eval-v3.dtb \
-	imx6ull-colibri-iris.dtb \
-	imx6ull-colibri-iris-v2.dtb \
-	imx6ull-colibri-wifi-aster.dtb \
-	imx6ull-colibri-wifi-eval-v3.dtb \
-	imx6ull-colibri-wifi-iris.dtb \
-	imx6ull-colibri-wifi-iris-v2.dtb \
-	imx6ull-dhcom-drc02.dtb \
-	imx6ull-dhcom-pdk2.dtb \
-	imx6ull-dhcom-picoitx.dtb \
-	imx6ull-jozacp.dtb \
-	imx6ull-kontron-bl.dtb \
-	imx6ull-myir-mys-6ulx-eval.dtb \
-	imx6ull-opos6uldev.dtb \
-	imx6ull-phytec-segin-ff-rdk-nand.dtb \
-	imx6ull-phytec-segin-ff-rdk-emmc.dtb \
-	imx6ull-phytec-segin-lc-rdk-nand.dtb \
-	imx6ull-phytec-tauri-emmc.dtb \
-	imx6ull-phytec-tauri-nand.dtb \
-	imx6ull-tarragon-master.dtb \
-	imx6ull-tarragon-micro.dtb \
-	imx6ull-tarragon-slave.dtb \
-	imx6ull-tarragon-slavext.dtb \
-	imx6ull-tqma6ull2-mba6ulx.dtb \
-	imx6ull-tqma6ull2l-mba6ulx.dtb \
-	imx6ulz-14x14-evk.dtb \
-	imx6ulz-bsh-smm-m2.dtb
-dtb-$(CONFIG_SOC_IMX7D) += \
-	imx7d-cl-som-imx7.dtb \
-	imx7d-colibri-aster.dtb \
-	imx7d-colibri-emmc-aster.dtb \
-	imx7d-colibri-emmc-iris.dtb \
-	imx7d-colibri-emmc-iris-v2.dtb \
-	imx7d-colibri-emmc-eval-v3.dtb \
-	imx7d-colibri-eval-v3.dtb \
-	imx7d-colibri-iris.dtb \
-	imx7d-colibri-iris-v2.dtb \
-	imx7d-flex-concentrator.dtb \
-	imx7d-flex-concentrator-mfg.dtb \
-	imx7d-mba7.dtb \
-	imx7d-meerkat96.dtb \
-	imx7d-nitrogen7.dtb \
-	imx7d-pico-dwarf.dtb \
-	imx7d-pico-hobbit.dtb \
-	imx7d-pico-nymph.dtb \
-	imx7d-pico-pi.dtb \
-	imx7d-remarkable2.dtb \
-	imx7d-sbc-imx7.dtb \
-	imx7d-sdb.dtb \
-	imx7d-sdb-reva.dtb \
-	imx7d-sdb-sht11.dtb \
-	imx7d-smegw01.dtb \
-	imx7d-zii-rmu2.dtb \
-	imx7d-zii-rpu2.dtb \
-	imx7s-colibri-aster.dtb \
-	imx7s-colibri-eval-v3.dtb \
-	imx7s-colibri-iris.dtb \
-	imx7s-colibri-iris-v2.dtb \
-	imx7s-mba7.dtb \
-	imx7s-warp.dtb
-dtb-$(CONFIG_SOC_IMX7ULP) += \
-	imx7ulp-com.dtb \
-	imx7ulp-evk.dtb
-dtb-$(CONFIG_SOC_IMXRT) += \
-	imxrt1050-evk.dtb
-dtb-$(CONFIG_SOC_LAN966) += \
-	lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb \
-	lan966x-kontron-kswitch-d10-mmt-8g.dtb \
-	lan966x-pcb8290.dtb \
-	lan966x-pcb8291.dtb \
-	lan966x-pcb8309.dtb
-dtb-$(CONFIG_SOC_LS1021A) += \
-	ls1021a-iot.dtb \
-	ls1021a-moxa-uc-8410a.dtb \
-	ls1021a-qds.dtb \
-	ls1021a-tsn.dtb \
-	ls1021a-twr.dtb
-dtb-$(CONFIG_SOC_VF610) += \
-	vf500-colibri-eval-v3.dtb \
-	vf610-bk4.dtb \
-	vf610-colibri-eval-v3.dtb \
-	vf610m4-colibri.dtb \
-	vf610-cosmic.dtb \
-	vf610m4-cosmic.dtb \
-	vf610-twr.dtb \
-	vf610-zii-cfu1.dtb \
-	vf610-zii-dev-rev-b.dtb \
-	vf610-zii-dev-rev-c.dtb \
-	vf610-zii-scu4-aib.dtb \
-	vf610-zii-spb4.dtb \
-	vf610-zii-ssmb-dtu.dtb \
-	vf610-zii-ssmb-spu3.dtb
-dtb-$(CONFIG_ARCH_MXS) += \
-	imx23-evk.dtb \
-	imx23-olinuxino.dtb \
-	imx23-sansa.dtb \
-	imx23-stmp378x_devb.dtb \
-	imx23-xfi3.dtb \
-	imx28-apf28.dtb \
-	imx28-apf28dev.dtb \
-	imx28-apx4devkit.dtb \
-	imx28-cfa10036.dtb \
-	imx28-cfa10037.dtb \
-	imx28-cfa10049.dtb \
-	imx28-cfa10055.dtb \
-	imx28-cfa10056.dtb \
-	imx28-cfa10057.dtb \
-	imx28-cfa10058.dtb \
-	imx28-duckbill-2-485.dtb \
-	imx28-duckbill-2.dtb \
-	imx28-duckbill-2-enocean.dtb \
-	imx28-duckbill-2-spi.dtb \
-	imx28-duckbill.dtb \
-	imx28-eukrea-mbmx283lc.dtb \
-	imx28-eukrea-mbmx287lc.dtb \
-	imx28-evk.dtb \
-	imx28-m28cu3.dtb \
-	imx28-m28evk.dtb \
-	imx28-sps1.dtb \
-	imx28-ts4600.dtb \
-	imx28-tx28.dtb \
-	imx28-xea.dtb
-dtb-$(CONFIG_ARCH_NOMADIK) += \
-	ste-nomadik-s8815.dtb \
-	ste-nomadik-nhk15.dtb
-dtb-$(CONFIG_ARCH_NSPIRE) += \
-	nspire-cx.dtb \
-	nspire-tp.dtb \
-	nspire-clp.dtb
-dtb-$(CONFIG_ARCH_OMAP2) += \
-	omap2420-h4.dtb \
-	omap2420-n800.dtb \
-	omap2420-n810.dtb \
-	omap2420-n810-wimax.dtb \
-	omap2430-sdp.dtb
-dtb-$(CONFIG_ARCH_OMAP3) += \
-	am3517-craneboard.dtb \
-	am3517-evm.dtb \
-	am3517_mt_ventoux.dtb \
-	logicpd-torpedo-35xx-devkit.dtb \
-	logicpd-torpedo-37xx-devkit.dtb \
-	logicpd-torpedo-37xx-devkit-28.dtb \
-	logicpd-som-lv-35xx-devkit.dtb \
-	logicpd-som-lv-37xx-devkit.dtb \
-	omap3430-sdp.dtb \
-	omap3-beagle.dtb \
-	omap3-beagle-ab4.dtb \
-	omap3-beagle-xm.dtb \
-	omap3-beagle-xm-ab.dtb \
-	omap3-cm-t3517.dtb \
-	omap3-cm-t3530.dtb \
-	omap3-cm-t3730.dtb \
-	omap3-devkit8000.dtb \
-	omap3-devkit8000-lcd43.dtb \
-	omap3-devkit8000-lcd70.dtb \
-	omap3-echo.dtb \
-	omap3-evm.dtb \
-	omap3-evm-37xx.dtb \
-	omap3-gta04a3.dtb \
-	omap3-gta04a4.dtb \
-	omap3-gta04a5.dtb \
-	omap3-gta04a5one.dtb \
-	omap3-ha.dtb \
-	omap3-ha-lcd.dtb \
-	omap3-igep0020.dtb \
-	omap3-igep0020-rev-f.dtb \
-	omap3-igep0030.dtb \
-	omap3-igep0030-rev-g.dtb \
-	omap3-ldp.dtb \
-	omap3-lilly-dbb056.dtb \
-	omap3-n900.dtb \
-	omap3-n9.dtb \
-	omap3-n950.dtb \
-	omap3-overo-alto35.dtb \
-	omap3-overo-chestnut43.dtb \
-	omap3-overo-gallop43.dtb \
-	omap3-overo-palo35.dtb \
-	omap3-overo-palo43.dtb \
-	omap3-overo-storm-alto35.dtb \
-	omap3-overo-storm-chestnut43.dtb \
-	omap3-overo-storm-gallop43.dtb \
-	omap3-overo-storm-palo35.dtb \
-	omap3-overo-storm-palo43.dtb \
-	omap3-overo-storm-summit.dtb \
-	omap3-overo-storm-tobi.dtb \
-	omap3-overo-storm-tobiduo.dtb \
-	omap3-overo-summit.dtb \
-	omap3-overo-tobi.dtb \
-	omap3-overo-tobiduo.dtb \
-	omap3-pandora-600mhz.dtb \
-	omap3-pandora-1ghz.dtb \
-	omap3-sbc-t3517.dtb \
-	omap3-sbc-t3530.dtb \
-	omap3-sbc-t3730.dtb \
-	omap3-sniper.dtb \
-	omap3-thunder.dtb \
-	omap3-zoom3.dtb
-dtb-$(CONFIG_SOC_TI81XX) += \
-	am3874-iceboard.dtb \
-	dm8148-evm.dtb \
-	dm8148-t410.dtb \
-	dm8168-evm.dtb \
-	dra62x-j5eco-evm.dtb
-dtb-$(CONFIG_SOC_AM33XX) += \
-	am335x-baltos-ir2110.dtb \
-	am335x-baltos-ir3220.dtb \
-	am335x-baltos-ir5221.dtb \
-	am335x-base0033.dtb \
-	am335x-bone.dtb \
-	am335x-boneblack.dtb \
-	am335x-boneblack-wireless.dtb \
-	am335x-boneblue.dtb \
-	am335x-bonegreen.dtb \
-	am335x-bonegreen-wireless.dtb \
-	am335x-chiliboard.dtb \
-	am335x-cm-t335.dtb \
-	am335x-evm.dtb \
-	am335x-evmsk.dtb \
-	am335x-guardian.dtb \
-	am335x-icev2.dtb \
-	am335x-lxm.dtb \
-	am335x-moxa-uc-2101.dtb \
-	am335x-moxa-uc-8100-me-t.dtb \
-	am335x-myirtech-myd.dtb \
-	am335x-nano.dtb \
-	am335x-netcan-plus-1xx.dtb \
-	am335x-netcom-plus-2xx.dtb \
-	am335x-netcom-plus-8xx.dtb \
-	am335x-pdu001.dtb \
-	am335x-pepper.dtb \
-	am335x-phycore-rdk.dtb \
-	am335x-pocketbeagle.dtb \
-	am335x-regor-rdk.dtb \
-	am335x-sancloud-bbe.dtb \
-	am335x-sancloud-bbe-lite.dtb \
-	am335x-sancloud-bbe-extended-wifi.dtb \
-	am335x-shc.dtb \
-	am335x-sbc-t335.dtb \
-	am335x-sl50.dtb \
-	am335x-wega-rdk.dtb \
-	am335x-osd3358-sm-red.dtb
-dtb-$(CONFIG_ARCH_OMAP4) += \
-	omap4-droid-bionic-xt875.dtb \
-	omap4-droid4-xt894.dtb \
-	omap4-duovero-parlor.dtb \
-	omap4-kc1.dtb \
-	omap4-panda.dtb \
-	omap4-panda-a4.dtb \
-	omap4-panda-es.dtb \
-	omap4-sdp.dtb \
-	omap4-sdp-es23plus.dtb \
-	omap4-var-dvk-om44.dtb \
-	omap4-var-stk-om44.dtb
-dtb-$(CONFIG_SOC_AM43XX) += \
-	am43x-epos-evm.dtb \
-	am437x-cm-t43.dtb \
-	am437x-gp-evm.dtb \
-	am437x-idk-evm.dtb \
-	am437x-sbc-t43.dtb \
-	am437x-sk-evm.dtb
-dtb-$(CONFIG_SOC_OMAP5) += \
-	omap5-cm-t54.dtb \
-	omap5-igep0050.dtb \
-	omap5-sbc-t54.dtb \
-	omap5-uevm.dtb
-am57xx-evm-dtbs := am57xx-beagle-x15.dtb am57xx-evm.dtbo
-am57xx-evm-reva3-dtbs := am57xx-beagle-x15-revc.dtb am57xx-evm.dtbo
-dtb-$(CONFIG_SOC_DRA7XX) += \
-	am57xx-beagle-x15.dtb \
-	am57xx-beagle-x15-revb1.dtb \
-	am57xx-beagle-x15-revc.dtb \
-	am57xx-evm.dtb \
-	am57xx-evm-reva3.dtb \
-	am5729-beagleboneai.dtb \
-	am57xx-cl-som-am57x.dtb \
-	am57xx-sbc-am57x.dtb \
-	am572x-idk.dtb \
-	am572x-idk-touchscreen.dtbo \
-	am571x-idk.dtb \
-	am571x-idk-touchscreen.dtbo \
-	am574x-idk.dtb \
-	am57xx-idk-lcd-osd101t2045.dtbo \
-	am57xx-idk-lcd-osd101t2587.dtbo \
-	dra7-evm.dtb \
-	dra72-evm.dtb \
-	dra72-evm-revc.dtb \
-	dra71-evm.dtb \
-	dra76-evm.dtb
-dtb-$(CONFIG_ARCH_ORION5X) += \
-	orion5x-kuroboxpro.dtb \
-	orion5x-lacie-d2-network.dtb \
-	orion5x-lacie-ethernet-disk-mini-v2.dtb \
-	orion5x-linkstation-lsgl.dtb \
-	orion5x-linkstation-lswtgl.dtb \
-	orion5x-linkstation-lschl.dtb \
-	orion5x-lswsgl.dtb \
-	orion5x-maxtor-shared-storage-2.dtb \
-	orion5x-netgear-wnr854t.dtb \
-	orion5x-rd88f5182-nas.dtb
-dtb-$(CONFIG_ARCH_ACTIONS) += \
-	owl-s500-cubieboard6.dtb \
-	owl-s500-guitar-bb-rev-b.dtb \
-	owl-s500-labrador-base-m.dtb \
-	owl-s500-roseapplepi.dtb \
-	owl-s500-sparky.dtb
-dtb-$(CONFIG_ARCH_PXA) += \
-	pxa300-raumfeld-connector.dtb \
-	pxa300-raumfeld-controller.dtb \
-	pxa300-raumfeld-speaker-l.dtb \
-	pxa300-raumfeld-speaker-m.dtb \
-	pxa300-raumfeld-speaker-one.dtb \
-	pxa300-raumfeld-speaker-s.dtb
-dtb-$(CONFIG_ARCH_QCOM) += \
-	qcom-apq8016-sbc.dtb \
-	qcom-apq8026-asus-sparrow.dtb \
-	qcom-apq8026-huawei-sturgeon.dtb \
-	qcom-apq8026-lg-lenok.dtb \
-	qcom-apq8026-samsung-matisse-wifi.dtb \
-	qcom-apq8060-dragonboard.dtb \
-	qcom-apq8064-cm-qs600.dtb \
-	qcom-apq8064-ifc6410.dtb \
-	qcom-apq8064-sony-xperia-lagan-yuga.dtb \
-	qcom-apq8064-asus-nexus7-flo.dtb \
-	qcom-apq8074-dragonboard.dtb \
-	qcom-apq8084-ifc6540.dtb \
-	qcom-apq8084-mtp.dtb \
-	qcom-ipq4018-ap120c-ac.dtb \
-	qcom-ipq4018-ap120c-ac-bit.dtb \
-	qcom-ipq4018-jalapeno.dtb \
-	qcom-ipq4019-ap.dk01.1-c1.dtb \
-	qcom-ipq4019-ap.dk04.1-c1.dtb \
-	qcom-ipq4019-ap.dk04.1-c3.dtb \
-	qcom-ipq4019-ap.dk07.1-c1.dtb \
-	qcom-ipq4019-ap.dk07.1-c2.dtb \
-	qcom-ipq8064-ap148.dtb \
-	qcom-ipq8064-rb3011.dtb \
-	qcom-msm8226-samsung-s3ve3g.dtb \
-	qcom-msm8660-surf.dtb \
-	qcom-msm8916-samsung-e5.dtb \
-	qcom-msm8916-samsung-e7.dtb \
-	qcom-msm8916-samsung-grandmax.dtb \
-	qcom-msm8916-samsung-serranove.dtb \
-	qcom-msm8960-cdp.dtb \
-	qcom-msm8974-lge-nexus5-hammerhead.dtb \
-	qcom-msm8974-sony-xperia-rhine-amami.dtb \
-	qcom-msm8974-sony-xperia-rhine-honami.dtb \
-	qcom-msm8974pro-fairphone-fp2.dtb \
-	qcom-msm8974pro-oneplus-bacon.dtb \
-	qcom-msm8974pro-samsung-klte.dtb \
-	qcom-msm8974pro-sony-xperia-shinano-castor.dtb \
-	qcom-mdm9615-wp8548-mangoh-green.dtb \
-	qcom-sdx55-mtp.dtb \
-	qcom-sdx55-t55.dtb \
-	qcom-sdx55-telit-fn980-tlb.dtb \
-	qcom-sdx65-mtp.dtb
-dtb-$(CONFIG_ARCH_RDA) += \
-	rda8810pl-orangepi-2g-iot.dtb \
-	rda8810pl-orangepi-i96.dtb
-dtb-$(CONFIG_ARCH_REALTEK) += \
-	rtd1195-horseradish.dtb \
-	rtd1195-mele-x1000.dtb
-dtb-$(CONFIG_ARCH_REALVIEW) += \
-	arm-realview-pb1176.dtb \
-	arm-realview-pb11mp.dtb \
-	arm-realview-eb.dtb \
-	arm-realview-eb-bbrevd.dtb \
-	arm-realview-eb-11mp.dtb \
-	arm-realview-eb-11mp-bbrevd.dtb \
-	arm-realview-eb-11mp-ctrevb.dtb \
-	arm-realview-eb-11mp-bbrevd-ctrevb.dtb \
-	arm-realview-eb-a9mp.dtb \
-	arm-realview-eb-a9mp-bbrevd.dtb \
-	arm-realview-pba8.dtb \
-	arm-realview-pbx-a9.dtb
-dtb-$(CONFIG_ARCH_RENESAS) += \
-	emev2-kzm9d.dtb \
-	r7s72100-genmai.dtb \
-	r7s72100-gr-peach.dtb \
-	r7s72100-rskrza1.dtb \
-	r7s9210-rza2mevb.dtb \
-	r8a73a4-ape6evm.dtb \
-	r8a7740-armadillo800eva.dtb \
-	r8a7742-iwg21d-q7.dtb \
-	r8a7742-iwg21d-q7-dbcm-ca.dtb \
-	r8a7743-iwg20d-q7.dtb \
-	r8a7743-iwg20d-q7-dbcm-ca.dtb \
-	r8a7743-sk-rzg1m.dtb \
-	r8a7744-iwg20d-q7.dtb \
-	r8a7744-iwg20d-q7-dbcm-ca.dtb \
-	r8a7745-iwg22d-sodimm.dtb \
-	r8a7745-iwg22d-sodimm-dbhd-ca.dtb \
-	r8a7745-sk-rzg1e.dtb \
-	r8a77470-iwg23s-sbc.dtb \
-	r8a7778-bockw.dtb \
-	r8a7779-marzen.dtb \
-	r8a7790-lager.dtb \
-	r8a7790-stout.dtb \
-	r8a7791-koelsch.dtb \
-	r8a7791-porter.dtb \
-	r8a7792-blanche.dtb \
-	r8a7792-wheat.dtb \
-	r8a7793-gose.dtb \
-	r8a7794-alt.dtb \
-	r8a7794-silk.dtb \
-	r9a06g032-rzn1d400-db.dtb \
-	sh73a0-kzm9g.dtb
-dtb-$(CONFIG_ARCH_ROCKCHIP) += \
-	rv1108-elgin-r1.dtb \
-	rv1108-evb.dtb \
-	rv1126-edgeble-neu2-io.dtb \
-	rk3036-evb.dtb \
-	rk3036-kylin.dtb \
-	rk3066a-bqcurie2.dtb \
-	rk3066a-marsboard.dtb \
-	rk3066a-mk808.dtb \
-	rk3066a-rayeager.dtb \
-	rk3128-evb.dtb \
-	rk3188-bqedison2qc.dtb \
-	rk3188-px3-evb.dtb \
-	rk3188-radxarock.dtb \
-	rk3228-evb.dtb \
-	rk3229-evb.dtb \
-	rk3229-xms6.dtb \
-	rk3288-evb-act8846.dtb \
-	rk3288-evb-rk808.dtb \
-	rk3288-firefly-beta.dtb \
-	rk3288-firefly.dtb \
-	rk3288-firefly-reload.dtb \
-	rk3288-miqi.dtb \
-	rk3288-phycore-rdk.dtb \
-	rk3288-popmetal.dtb \
-	rk3288-r89.dtb \
-	rk3288-rock2-square.dtb \
-	rk3288-rock-pi-n8.dtb \
-	rk3288-tinker.dtb \
-	rk3288-tinker-s.dtb \
-	rk3288-veyron-brain.dtb \
-	rk3288-veyron-fievel.dtb \
-	rk3288-veyron-jaq.dtb \
-	rk3288-veyron-jerry.dtb \
-	rk3288-veyron-mickey.dtb \
-	rk3288-veyron-mighty.dtb \
-	rk3288-veyron-minnie.dtb \
-	rk3288-veyron-pinky.dtb \
-	rk3288-veyron-speedy.dtb \
-	rk3288-veyron-tiger.dtb \
-	rk3288-vyasa.dtb
-dtb-$(CONFIG_ARCH_S3C64XX) += \
-	s3c6410-mini6410.dtb \
-	s3c6410-smdk6410.dtb
-dtb-$(CONFIG_ARCH_S5PV210) += \
-	s5pv210-aquila.dtb \
-	s5pv210-fascinate4g.dtb \
-	s5pv210-galaxys.dtb \
-	s5pv210-goni.dtb \
-	s5pv210-smdkc110.dtb \
-	s5pv210-smdkv210.dtb \
-	s5pv210-torbreck.dtb
-dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
-	socfpga_arria5_socdk.dtb \
-	socfpga_arria10_chameleonv3.dtb \
-	socfpga_arria10_mercury_pe1.dtb \
-	socfpga_arria10_socdk_nand.dtb \
-	socfpga_arria10_socdk_qspi.dtb \
-	socfpga_arria10_socdk_sdmmc.dtb \
-	socfpga_cyclone5_chameleon96.dtb \
-	socfpga_cyclone5_mcvevk.dtb \
-	socfpga_cyclone5_socdk.dtb \
-	socfpga_cyclone5_de0_nano_soc.dtb \
-	socfpga_cyclone5_sockit.dtb \
-	socfpga_cyclone5_socrates.dtb \
-	socfpga_cyclone5_sodia.dtb \
-	socfpga_cyclone5_vining_fpga.dtb \
-	socfpga_vt.dtb
-dtb-$(CONFIG_ARCH_SPEAR13XX) += \
-	spear1310-evb.dtb \
-	spear1340-evb.dtb
-dtb-$(CONFIG_ARCH_SPEAR3XX) += \
-	spear300-evb.dtb \
-	spear310-evb.dtb \
-	spear320-evb.dtb \
-	spear320-hmi.dtb
-dtb-$(CONFIG_ARCH_SPEAR6XX) += \
-	spear600-evb.dtb
-dtb-$(CONFIG_ARCH_STI) += \
-	stih407-b2120.dtb \
-	stih410-b2120.dtb \
-	stih410-b2260.dtb \
-	stih418-b2199.dtb \
-	stih418-b2264.dtb
-dtb-$(CONFIG_ARCH_STM32) += \
-	stm32f429-disco.dtb \
-	stm32f469-disco.dtb \
-	stm32f746-disco.dtb \
-	stm32f769-disco.dtb \
-	stm32429i-eval.dtb \
-	stm32746g-eval.dtb \
-	stm32h743i-eval.dtb \
-	stm32h743i-disco.dtb \
-	stm32h750i-art-pi.dtb \
-	stm32mp135f-dk.dtb \
-	stm32mp151a-prtt1a.dtb \
-	stm32mp151a-prtt1c.dtb \
-	stm32mp151a-prtt1s.dtb \
-	stm32mp151a-dhcor-testbench.dtb \
-	stm32mp153c-dhcom-drc02.dtb \
-	stm32mp153c-dhcor-drc-compact.dtb \
-	stm32mp157a-avenger96.dtb \
-	stm32mp157a-dhcor-avenger96.dtb \
-	stm32mp157a-dk1.dtb \
-	stm32mp157a-dk1-scmi.dtb \
-	stm32mp157a-iot-box.dtb \
-	stm32mp157a-microgea-stm32mp1-microdev2.0.dtb \
-	stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dtb \
-	stm32mp157a-icore-stm32mp1-ctouch2.dtb \
-	stm32mp157a-icore-stm32mp1-ctouch2-of10.dtb \
-	stm32mp157a-icore-stm32mp1-edimm2.2.dtb \
-	stm32mp157a-stinger96.dtb \
-	stm32mp157c-dhcom-pdk2.dtb \
-	stm32mp157c-dhcom-picoitx.dtb \
-	stm32mp157c-dk2.dtb \
-	stm32mp157c-dk2-scmi.dtb \
-	stm32mp157c-ed1.dtb \
-	stm32mp157c-ed1-scmi.dtb \
-	stm32mp157c-emsbc-argon.dtb \
-	stm32mp157c-ev1.dtb \
-	stm32mp157c-ev1-scmi.dtb \
-	stm32mp157c-lxa-mc1.dtb \
-	stm32mp157c-odyssey.dtb
-dtb-$(CONFIG_MACH_SUN4I) += \
-	sun4i-a10-a1000.dtb \
-	sun4i-a10-ba10-tvbox.dtb \
-	sun4i-a10-chuwi-v7-cw0825.dtb \
-	sun4i-a10-cubieboard.dtb \
-	sun4i-a10-dserve-dsrv9703c.dtb \
-	sun4i-a10-gemei-g9.dtb \
-	sun4i-a10-hackberry.dtb \
-	sun4i-a10-hyundai-a7hd.dtb \
-	sun4i-a10-inet1.dtb \
-	sun4i-a10-inet97fv2.dtb \
-	sun4i-a10-inet9f-rev03.dtb \
-	sun4i-a10-itead-iteaduino-plus.dtb \
-	sun4i-a10-jesurun-q5.dtb \
-	sun4i-a10-marsboard.dtb \
-	sun4i-a10-mini-xplus.dtb \
-	sun4i-a10-mk802.dtb \
-	sun4i-a10-mk802ii.dtb \
-	sun4i-a10-olinuxino-lime.dtb \
-	sun4i-a10-pcduino.dtb \
-	sun4i-a10-pcduino2.dtb \
-	sun4i-a10-pov-protab2-ips9.dtb \
-	sun4i-a10-topwise-a721.dtb
-dtb-$(CONFIG_MACH_SUN5I) += \
-	sun5i-a10s-auxtek-t003.dtb \
-	sun5i-a10s-auxtek-t004.dtb \
-	sun5i-a10s-mk802.dtb \
-	sun5i-a10s-olinuxino-micro.dtb \
-	sun5i-a10s-r7-tv-dongle.dtb \
-	sun5i-a10s-wobo-i5.dtb \
-	sun5i-a13-difrnce-dit4350.dtb \
-	sun5i-a13-empire-electronix-d709.dtb \
-	sun5i-a13-empire-electronix-m712.dtb \
-	sun5i-a13-hsg-h702.dtb \
-	sun5i-a13-inet-98v-rev2.dtb \
-	sun5i-a13-licheepi-one.dtb \
-	sun5i-a13-olinuxino.dtb \
-	sun5i-a13-olinuxino-micro.dtb \
-	sun5i-a13-pocketbook-touch-lux-3.dtb \
-	sun5i-a13-q8-tablet.dtb \
-	sun5i-a13-utoo-p66.dtb \
-	sun5i-gr8-chip-pro.dtb \
-	sun5i-gr8-evb.dtb \
-	sun5i-r8-chip.dtb
-dtb-$(CONFIG_MACH_SUN6I) += \
-	sun6i-a31-app4-evb1.dtb \
-	sun6i-a31-colombus.dtb \
-	sun6i-a31-hummingbird.dtb \
-	sun6i-a31-i7.dtb \
-	sun6i-a31-m9.dtb \
-	sun6i-a31-mele-a1000g-quad.dtb \
-	sun6i-a31s-colorfly-e708-q1.dtb \
-	sun6i-a31s-cs908.dtb \
-	sun6i-a31s-inet-q972.dtb \
-	sun6i-a31s-primo81.dtb \
-	sun6i-a31s-sina31s.dtb \
-	sun6i-a31s-sinovoip-bpi-m2.dtb \
-	sun6i-a31s-yones-toptech-bs1078-v2.dtb
-dtb-$(CONFIG_MACH_SUN7I) += \
-	sun7i-a20-bananapi.dtb \
-	sun7i-a20-bananapi-m1-plus.dtb \
-	sun7i-a20-bananapro.dtb \
-	sun7i-a20-cubieboard2.dtb \
-	sun7i-a20-cubietruck.dtb \
-	sun7i-a20-haoyu-marsboard.dtb \
-	sun7i-a20-hummingbird.dtb \
-	sun7i-a20-itead-ibox.dtb \
-	sun7i-a20-i12-tvbox.dtb \
-	sun7i-a20-icnova-swac.dtb \
-	sun7i-a20-lamobo-r1.dtb \
-	sun7i-a20-linutronix-testbox-v2.dtb \
-	sun7i-a20-m3.dtb \
-	sun7i-a20-mk808c.dtb \
-	sun7i-a20-olimex-som-evb.dtb \
-	sun7i-a20-olimex-som-evb-emmc.dtb \
-	sun7i-a20-olimex-som204-evb.dtb \
-	sun7i-a20-olimex-som204-evb-emmc.dtb \
-	sun7i-a20-olinuxino-lime.dtb \
-	sun7i-a20-olinuxino-lime-emmc.dtb \
-	sun7i-a20-olinuxino-lime2.dtb \
-	sun7i-a20-olinuxino-lime2-emmc.dtb \
-	sun7i-a20-olinuxino-micro.dtb \
-	sun7i-a20-olinuxino-micro-emmc.dtb \
-	sun7i-a20-orangepi.dtb \
-	sun7i-a20-orangepi-mini.dtb \
-	sun7i-a20-pcduino3.dtb \
-	sun7i-a20-pcduino3-nano.dtb \
-	sun7i-a20-wexler-tab7200.dtb \
-	sun7i-a20-wits-pro-a20-dkt.dtb
-dtb-$(CONFIG_MACH_SUN8I) += \
-	sun8i-a23-evb.dtb \
-	sun8i-a23-gt90h-v4.dtb \
-	sun8i-a23-inet86dz.dtb \
-	sun8i-a23-ippo-q8h-v5.dtb \
-	sun8i-a23-ippo-q8h-v1.2.dtb \
-	sun8i-a23-polaroid-mid2407pxe03.dtb \
-	sun8i-a23-polaroid-mid2809pxe04.dtb \
-	sun8i-a23-q8-tablet.dtb \
-	sun8i-a33-et-q8-v1.6.dtb \
-	sun8i-a33-ga10h-v1.1.dtb \
-	sun8i-a33-inet-d978-rev2.dtb \
-	sun8i-a33-ippo-q8h-v1.2.dtb \
-	sun8i-a33-olinuxino.dtb \
-	sun8i-a33-q8-tablet.dtb \
-	sun8i-a33-sinlinx-sina33.dtb \
-	sun8i-a83t-allwinner-h8homlet-v2.dtb \
-	sun8i-a83t-bananapi-m3.dtb \
-	sun8i-a83t-cubietruck-plus.dtb \
-	sun8i-a83t-tbs-a711.dtb \
-	sun8i-h2-plus-bananapi-m2-zero.dtb \
-	sun8i-h2-plus-libretech-all-h3-cc.dtb \
-	sun8i-h2-plus-orangepi-r1.dtb \
-	sun8i-h2-plus-orangepi-zero.dtb \
-	sun8i-h3-bananapi-m2-plus.dtb \
-	sun8i-h3-bananapi-m2-plus-v1.2.dtb \
-	sun8i-h3-beelink-x2.dtb \
-	sun8i-h3-libretech-all-h3-cc.dtb \
-	sun8i-h3-mapleboard-mp130.dtb \
-	sun8i-h3-nanopi-duo2.dtb \
-	sun8i-h3-nanopi-m1.dtb	\
-	sun8i-h3-nanopi-m1-plus.dtb \
-	sun8i-h3-nanopi-neo.dtb \
-	sun8i-h3-nanopi-neo-air.dtb \
-	sun8i-h3-nanopi-r1.dtb \
-	sun8i-h3-orangepi-2.dtb \
-	sun8i-h3-orangepi-lite.dtb \
-	sun8i-h3-orangepi-one.dtb \
-	sun8i-h3-orangepi-pc.dtb \
-	sun8i-h3-orangepi-pc-plus.dtb \
-	sun8i-h3-orangepi-plus.dtb \
-	sun8i-h3-orangepi-plus2e.dtb \
-	sun8i-h3-orangepi-zero-plus2.dtb \
-	sun8i-h3-rervision-dvk.dtb \
-	sun8i-h3-zeropi.dtb \
-	sun8i-h3-emlid-neutis-n5h3-devboard.dtb \
-	sun8i-r16-bananapi-m2m.dtb \
-	sun8i-r16-nintendo-nes-classic.dtb \
-	sun8i-r16-nintendo-super-nes-classic.dtb \
-	sun8i-r16-parrot.dtb \
-	sun8i-r40-bananapi-m2-ultra.dtb \
-	sun8i-r40-oka40i-c.dtb \
-	sun8i-s3-elimo-initium.dtb \
-	sun8i-s3-lichee-zero-plus.dtb \
-	sun8i-s3-pinecube.dtb \
-	sun8i-t113s-mangopi-mq-r-t113.dtb \
-	sun8i-t3-cqa3t-bv3.dtb \
-	sun8i-v3-sl631-imx179.dtb \
-	sun8i-v3s-licheepi-zero.dtb \
-	sun8i-v3s-licheepi-zero-dock.dtb \
-	sun8i-v40-bananapi-m2-berry.dtb
-dtb-$(CONFIG_MACH_SUN9I) += \
-	sun9i-a80-optimus.dtb \
-	sun9i-a80-cubieboard4.dtb
-dtb-$(CONFIG_MACH_SUNIV) += \
-	suniv-f1c100s-licheepi-nano.dtb \
-	suniv-f1c200s-lctech-pi.dtb \
-	suniv-f1c200s-popstick-v1.1.dtb
-dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
-	tegra20-acer-a500-picasso.dtb \
-	tegra20-asus-tf101.dtb \
-	tegra20-harmony.dtb \
-	tegra20-colibri-eval-v3.dtb \
-	tegra20-colibri-iris.dtb \
-	tegra20-medcom-wide.dtb \
-	tegra20-paz00.dtb \
-	tegra20-plutux.dtb \
-	tegra20-seaboard.dtb \
-	tegra20-tec.dtb \
-	tegra20-trimslice.dtb \
-	tegra20-ventana.dtb
-dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += \
-	tegra30-apalis-eval.dtb \
-	tegra30-apalis-v1.1-eval.dtb \
-	tegra30-asus-nexus7-grouper-PM269.dtb \
-	tegra30-asus-nexus7-grouper-E1565.dtb \
-	tegra30-asus-nexus7-tilapia-E1565.dtb \
-	tegra30-asus-tf201.dtb \
-	tegra30-asus-tf300t.dtb \
-	tegra30-asus-tf300tg.dtb \
-	tegra30-asus-tf700t.dtb \
-	tegra30-beaver.dtb \
-	tegra30-cardhu-a02.dtb \
-	tegra30-cardhu-a04.dtb \
-	tegra30-colibri-eval-v3.dtb \
-	tegra30-ouya.dtb \
-	tegra30-pegatron-chagall.dtb
-dtb-$(CONFIG_ARCH_TEGRA_114_SOC) += \
-	tegra114-asus-tf701t.dtb \
-	tegra114-dalmore.dtb \
-	tegra114-roth.dtb \
-	tegra114-tn7.dtb
-dtb-$(CONFIG_ARCH_TEGRA_124_SOC) += \
-	tegra124-apalis-eval.dtb \
-	tegra124-apalis-v1.2-eval.dtb \
-	tegra124-jetson-tk1.dtb \
-	tegra124-nyan-big.dtb \
-	tegra124-nyan-big-fhd.dtb \
-	tegra124-nyan-blaze.dtb \
-	tegra124-venice2.dtb
-dtb-$(CONFIG_ARCH_U8500) += \
-	ste-snowball.dtb \
-	ste-hrefprev60-stuib.dtb \
-	ste-hrefprev60-tvk.dtb \
-	ste-hrefv60plus-stuib.dtb \
-	ste-hrefv60plus-tvk.dtb \
-	ste-href520-tvk.dtb \
-	ste-ux500-samsung-golden.dtb \
-	ste-ux500-samsung-janice.dtb \
-	ste-ux500-samsung-gavini.dtb \
-	ste-ux500-samsung-codina.dtb \
-	ste-ux500-samsung-codina-tmo.dtb \
-	ste-ux500-samsung-skomer.dtb \
-	ste-ux500-samsung-kyle.dtb
-dtb-$(CONFIG_ARCH_UNIPHIER) += \
-	uniphier-ld4-ref.dtb \
-	uniphier-ld6b-ref.dtb \
-	uniphier-pro4-ace.dtb \
-	uniphier-pro4-ref.dtb \
-	uniphier-pro4-sanji.dtb \
-	uniphier-pro5-epcore.dtb \
-	uniphier-pro5-proex.dtb \
-	uniphier-pxs2-gentil.dtb \
-	uniphier-pxs2-vodka.dtb \
-	uniphier-sld8-ref.dtb
-dtb-$(CONFIG_ARCH_VERSATILE) += \
-	versatile-ab.dtb \
-	versatile-ab-ib2.dtb \
-	versatile-pb.dtb
-dtb-$(CONFIG_ARCH_VEXPRESS) += \
-	vexpress-v2p-ca5s.dtb \
-	vexpress-v2p-ca9.dtb \
-	vexpress-v2p-ca15-tc1.dtb \
-	vexpress-v2p-ca15_a7.dtb
-dtb-$(CONFIG_ARCH_VIRT) += \
-	xenvm-4.2.dtb
-dtb-$(CONFIG_ARCH_VT8500) += \
-	vt8500-bv07.dtb \
-	wm8505-ref.dtb \
-	wm8650-mid.dtb \
-	wm8750-apc8750.dtb \
-	wm8850-w70v2.dtb
-dtb-$(CONFIG_ARCH_ZYNQ) += \
-	zynq-cc108.dtb \
-	zynq-ebaz4205.dtb \
-	zynq-microzed.dtb \
-	zynq-parallella.dtb \
-	zynq-zc702.dtb \
-	zynq-zc706.dtb \
-	zynq-zc770-xm010.dtb \
-	zynq-zc770-xm011.dtb \
-	zynq-zc770-xm012.dtb \
-	zynq-zc770-xm013.dtb \
-	zynq-zed.dtb \
-	zynq-zturn.dtb \
-	zynq-zturn-v5.dtb \
-	zynq-zybo.dtb \
-	zynq-zybo-z7.dtb
-dtb-$(CONFIG_MACH_ARMADA_370) += \
-	armada-370-c200-v2.dtb \
-	armada-370-db.dtb \
-	armada-370-dlink-dns327l.dtb \
-	armada-370-mirabox.dtb \
-	armada-370-netgear-rn102.dtb \
-	armada-370-netgear-rn104.dtb \
-	armada-370-rd.dtb \
-	armada-370-seagate-nas-2bay.dtb \
-	armada-370-seagate-nas-4bay.dtb \
-	armada-370-seagate-personal-cloud.dtb \
-	armada-370-seagate-personal-cloud-2bay.dtb \
-	armada-370-synology-ds213j.dtb
-dtb-$(CONFIG_MACH_ARMADA_375) += \
-	armada-375-db.dtb
-dtb-$(CONFIG_MACH_ARMADA_38X) += \
-	armada-381-netgear-gs110emx.dtb \
-	armada-382-rd-ac3x-48g4x2xl.dtb \
-	armada-385-atl-x530.dtb\
-	armada-385-clearfog-gtr-s4.dtb \
-	armada-385-clearfog-gtr-l8.dtb \
-	armada-385-db-88f6820-amc.dtb \
-	armada-385-db-ap.dtb \
-	armada-385-linksys-caiman.dtb \
-	armada-385-linksys-cobra.dtb \
-	armada-385-linksys-rango.dtb \
-	armada-385-linksys-shelby.dtb \
-	armada-385-synology-ds116.dtb \
-	armada-385-turris-omnia.dtb \
-	armada-388-clearfog.dtb \
-	armada-388-clearfog-base.dtb \
-	armada-388-clearfog-pro.dtb \
-	armada-388-db.dtb \
-	armada-388-gp.dtb \
-	armada-388-helios4.dtb \
-	armada-388-rd.dtb
-dtb-$(CONFIG_MACH_ARMADA_39X) += \
-	armada-390-db.dtb \
-	armada-395-gp.dtb \
-	armada-398-db.dtb
-dtb-$(CONFIG_MACH_ARMADA_XP) += \
-	armada-xp-axpwifiap.dtb \
-	armada-xp-crs305-1g-4s.dtb \
-	armada-xp-crs305-1g-4s-bit.dtb \
-	armada-xp-crs326-24g-2s.dtb \
-	armada-xp-crs326-24g-2s-bit.dtb \
-	armada-xp-crs328-4c-20s-4s.dtb \
-	armada-xp-crs328-4c-20s-4s-bit.dtb \
-	armada-xp-db.dtb \
-	armada-xp-db-dxbc2.dtb \
-	armada-xp-db-xc3-24g4xg.dtb \
-	armada-xp-gp.dtb \
-	armada-xp-lenovo-ix4-300d.dtb \
-	armada-xp-linksys-mamba.dtb \
-	armada-xp-matrix.dtb \
-	armada-xp-netgear-rn2120.dtb \
-	armada-xp-openblocks-ax3-4.dtb \
-	armada-xp-synology-ds414.dtb
-dtb-$(CONFIG_MACH_DOVE) += \
-	dove-cubox.dtb \
-	dove-cubox-es.dtb \
-	dove-d2plug.dtb \
-	dove-d3plug.dtb \
-	dove-dove-db.dtb \
-	dove-sbc-a510.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += \
-	mt2701-evb.dtb \
-	mt6580-evbp1.dtb \
-	mt6582-prestigio-pmt5008-3g.dtb \
-	mt6589-aquaris5.dtb \
-	mt6589-fairphone-fp1.dtb \
-	mt6592-evb.dtb \
-	mt7623a-rfb-emmc.dtb \
-	mt7623a-rfb-nand.dtb \
-	mt7623n-rfb-emmc.dtb \
-	mt7623n-bananapi-bpi-r2.dtb \
-	mt7629-rfb.dtb \
-	mt8127-moose.dtb \
-	mt8135-evbp1.dtb
-dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
-dtb-$(CONFIG_ARCH_MSTARV7) += \
-	mstar-infinity-msc313-breadbee_crust.dtb \
-	mstar-infinity2m-ssd202d-100ask-dongshanpione.dtb \
-	mstar-infinity2m-ssd202d-miyoo-mini.dtb \
-	mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dtb \
-	mstar-infinity2m-ssd202d-ssd201htv2.dtb \
-	mstar-infinity2m-ssd202d-unitv2.dtb \
-	mstar-infinity3-msc313e-breadbee.dtb \
-	mstar-mercury5-ssc8336n-midrived08.dtb
-dtb-$(CONFIG_ARCH_ASPEED) += \
-	aspeed-ast2500-evb.dtb \
-	aspeed-ast2600-evb-a1.dtb \
-	aspeed-ast2600-evb.dtb \
-	aspeed-bmc-amd-daytonax.dtb \
-	aspeed-bmc-amd-ethanolx.dtb \
-	aspeed-bmc-ampere-mtjade.dtb \
-	aspeed-bmc-ampere-mtmitchell.dtb \
-	aspeed-bmc-arm-stardragon4800-rep2.dtb \
-	aspeed-bmc-asrock-e3c246d4i.dtb \
-	aspeed-bmc-asrock-romed8hm3.dtb \
-	aspeed-bmc-bytedance-g220a.dtb \
-	aspeed-bmc-delta-ahe50dc.dtb \
-	aspeed-bmc-facebook-bletchley.dtb \
-	aspeed-bmc-facebook-cloudripper.dtb \
-	aspeed-bmc-facebook-cmm.dtb \
-	aspeed-bmc-facebook-elbert.dtb \
-	aspeed-bmc-facebook-fuji.dtb \
-	aspeed-bmc-facebook-galaxy100.dtb \
-	aspeed-bmc-facebook-greatlakes.dtb \
-	aspeed-bmc-facebook-minipack.dtb \
-	aspeed-bmc-facebook-tiogapass.dtb \
-	aspeed-bmc-facebook-wedge40.dtb \
-	aspeed-bmc-facebook-wedge100.dtb \
-	aspeed-bmc-facebook-wedge400.dtb \
-	aspeed-bmc-facebook-yamp.dtb \
-	aspeed-bmc-facebook-yosemitev2.dtb \
-	aspeed-bmc-ibm-bonnell.dtb \
-	aspeed-bmc-ibm-everest.dtb \
-	aspeed-bmc-ibm-rainier.dtb \
-	aspeed-bmc-ibm-rainier-1s4u.dtb \
-	aspeed-bmc-ibm-rainier-4u.dtb \
-	aspeed-bmc-intel-s2600wf.dtb \
-	aspeed-bmc-inspur-fp5280g2.dtb \
-	aspeed-bmc-inspur-nf5280m6.dtb \
-	aspeed-bmc-inspur-on5263m5.dtb \
-	aspeed-bmc-lenovo-hr630.dtb \
-	aspeed-bmc-lenovo-hr855xg2.dtb \
-	aspeed-bmc-microsoft-olympus.dtb \
-	aspeed-bmc-opp-lanyang.dtb \
-	aspeed-bmc-opp-mowgli.dtb \
-	aspeed-bmc-opp-nicole.dtb \
-	aspeed-bmc-opp-palmetto.dtb \
-	aspeed-bmc-opp-romulus.dtb \
-	aspeed-bmc-opp-swift.dtb \
-	aspeed-bmc-opp-tacoma.dtb \
-	aspeed-bmc-opp-vesnin.dtb \
-	aspeed-bmc-opp-witherspoon.dtb \
-	aspeed-bmc-opp-zaius.dtb \
-	aspeed-bmc-portwell-neptune.dtb \
-	aspeed-bmc-qcom-dc-scm-v1.dtb \
-	aspeed-bmc-quanta-q71l.dtb \
-	aspeed-bmc-quanta-s6q.dtb \
-	aspeed-bmc-supermicro-x11spi.dtb \
-	aspeed-bmc-inventec-transformers.dtb \
-	aspeed-bmc-tyan-s7106.dtb \
-	aspeed-bmc-tyan-s8036.dtb \
-	aspeed-bmc-ufispace-ncplite.dtb \
-	aspeed-bmc-vegman-n110.dtb \
-	aspeed-bmc-vegman-rx20.dtb \
-	aspeed-bmc-vegman-sx20.dtb
+subdir-y += actions
+subdir-y += airoha
+subdir-y += allwinner
+subdir-y += alphascale
+subdir-y += amazon
+subdir-y += amlogic
+subdir-y += arm
+subdir-y += aspeed
+subdir-y += axis
+subdir-y += broadcom
+subdir-y += calxeda
+subdir-y += cirrus
+subdir-y += cnxt
+subdir-y += gemini
+subdir-y += hisilicon
+subdir-y += hpe
+subdir-y += intel
+subdir-y += marvell
+subdir-y += mediatek
+subdir-y += microchip
+subdir-y += moxa
+subdir-y += nspire
+subdir-y += nuvoton
+subdir-y += nvidia
+subdir-y += nxp
+subdir-y += qcom
+subdir-y += realtek
+subdir-y += renesas
+subdir-y += rockchip
+subdir-y += samsung
+subdir-y += sigmastar
+subdir-y += socionext
+subdir-y += st
+subdir-y += sunplus
+subdir-y += synaptics
+subdir-y += ti
+subdir-y += unisoc
+subdir-y += vt8500
+subdir-y += xen
+subdir-y += xilinx
diff --git a/arch/arm/boot/dts/actions/Makefile b/arch/arm/boot/dts/actions/Makefile
new file mode 100644
index 000000000000..f384e4a48e6f
--- /dev/null
+++ b/arch/arm/boot/dts/actions/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_ACTIONS) += \
+	owl-s500-cubieboard6.dtb \
+	owl-s500-guitar-bb-rev-b.dtb \
+	owl-s500-labrador-base-m.dtb \
+	owl-s500-roseapplepi.dtb \
+	owl-s500-sparky.dtb
diff --git a/arch/arm/boot/dts/owl-s500-cubieboard6.dts b/arch/arm/boot/dts/actions/owl-s500-cubieboard6.dts
similarity index 100%
rename from arch/arm/boot/dts/owl-s500-cubieboard6.dts
rename to arch/arm/boot/dts/actions/owl-s500-cubieboard6.dts
diff --git a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts b/arch/arm/boot/dts/actions/owl-s500-guitar-bb-rev-b.dts
similarity index 100%
rename from arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
rename to arch/arm/boot/dts/actions/owl-s500-guitar-bb-rev-b.dts
diff --git a/arch/arm/boot/dts/owl-s500-guitar.dtsi b/arch/arm/boot/dts/actions/owl-s500-guitar.dtsi
similarity index 100%
rename from arch/arm/boot/dts/owl-s500-guitar.dtsi
rename to arch/arm/boot/dts/actions/owl-s500-guitar.dtsi
diff --git a/arch/arm/boot/dts/owl-s500-labrador-base-m.dts b/arch/arm/boot/dts/actions/owl-s500-labrador-base-m.dts
similarity index 100%
rename from arch/arm/boot/dts/owl-s500-labrador-base-m.dts
rename to arch/arm/boot/dts/actions/owl-s500-labrador-base-m.dts
diff --git a/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi b/arch/arm/boot/dts/actions/owl-s500-labrador-v2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
rename to arch/arm/boot/dts/actions/owl-s500-labrador-v2.dtsi
diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/actions/owl-s500-roseapplepi.dts
similarity index 100%
rename from arch/arm/boot/dts/owl-s500-roseapplepi.dts
rename to arch/arm/boot/dts/actions/owl-s500-roseapplepi.dts
diff --git a/arch/arm/boot/dts/owl-s500-sparky.dts b/arch/arm/boot/dts/actions/owl-s500-sparky.dts
similarity index 100%
rename from arch/arm/boot/dts/owl-s500-sparky.dts
rename to arch/arm/boot/dts/actions/owl-s500-sparky.dts
diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/actions/owl-s500.dtsi
similarity index 100%
rename from arch/arm/boot/dts/owl-s500.dtsi
rename to arch/arm/boot/dts/actions/owl-s500.dtsi
diff --git a/arch/arm/boot/dts/airoha/Makefile b/arch/arm/boot/dts/airoha/Makefile
new file mode 100644
index 000000000000..00c31389f622
--- /dev/null
+++ b/arch/arm/boot/dts/airoha/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_AIROHA) += \
+	en7523-evb.dtb
diff --git a/arch/arm/boot/dts/en7523-evb.dts b/arch/arm/boot/dts/airoha/en7523-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/en7523-evb.dts
rename to arch/arm/boot/dts/airoha/en7523-evb.dts
diff --git a/arch/arm/boot/dts/en7523.dtsi b/arch/arm/boot/dts/airoha/en7523.dtsi
similarity index 100%
rename from arch/arm/boot/dts/en7523.dtsi
rename to arch/arm/boot/dts/airoha/en7523.dtsi
diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
new file mode 100644
index 000000000000..a9f068e90c8e
--- /dev/null
+++ b/arch/arm/boot/dts/allwinner/Makefile
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_MACH_SUN4I) += \
+	sun4i-a10-a1000.dtb \
+	sun4i-a10-ba10-tvbox.dtb \
+	sun4i-a10-chuwi-v7-cw0825.dtb \
+	sun4i-a10-cubieboard.dtb \
+	sun4i-a10-dserve-dsrv9703c.dtb \
+	sun4i-a10-gemei-g9.dtb \
+	sun4i-a10-hackberry.dtb \
+	sun4i-a10-hyundai-a7hd.dtb \
+	sun4i-a10-inet1.dtb \
+	sun4i-a10-inet97fv2.dtb \
+	sun4i-a10-inet9f-rev03.dtb \
+	sun4i-a10-itead-iteaduino-plus.dtb \
+	sun4i-a10-jesurun-q5.dtb \
+	sun4i-a10-marsboard.dtb \
+	sun4i-a10-mini-xplus.dtb \
+	sun4i-a10-mk802.dtb \
+	sun4i-a10-mk802ii.dtb \
+	sun4i-a10-olinuxino-lime.dtb \
+	sun4i-a10-pcduino.dtb \
+	sun4i-a10-pcduino2.dtb \
+	sun4i-a10-pov-protab2-ips9.dtb \
+	sun4i-a10-topwise-a721.dtb
+dtb-$(CONFIG_MACH_SUN5I) += \
+	sun5i-a10s-auxtek-t003.dtb \
+	sun5i-a10s-auxtek-t004.dtb \
+	sun5i-a10s-mk802.dtb \
+	sun5i-a10s-olinuxino-micro.dtb \
+	sun5i-a10s-r7-tv-dongle.dtb \
+	sun5i-a10s-wobo-i5.dtb \
+	sun5i-a13-difrnce-dit4350.dtb \
+	sun5i-a13-empire-electronix-d709.dtb \
+	sun5i-a13-empire-electronix-m712.dtb \
+	sun5i-a13-hsg-h702.dtb \
+	sun5i-a13-inet-98v-rev2.dtb \
+	sun5i-a13-licheepi-one.dtb \
+	sun5i-a13-olinuxino.dtb \
+	sun5i-a13-olinuxino-micro.dtb \
+	sun5i-a13-pocketbook-touch-lux-3.dtb \
+	sun5i-a13-q8-tablet.dtb \
+	sun5i-a13-utoo-p66.dtb \
+	sun5i-gr8-chip-pro.dtb \
+	sun5i-gr8-evb.dtb \
+	sun5i-r8-chip.dtb
+dtb-$(CONFIG_MACH_SUN6I) += \
+	sun6i-a31-app4-evb1.dtb \
+	sun6i-a31-colombus.dtb \
+	sun6i-a31-hummingbird.dtb \
+	sun6i-a31-i7.dtb \
+	sun6i-a31-m9.dtb \
+	sun6i-a31-mele-a1000g-quad.dtb \
+	sun6i-a31s-colorfly-e708-q1.dtb \
+	sun6i-a31s-cs908.dtb \
+	sun6i-a31s-inet-q972.dtb \
+	sun6i-a31s-primo81.dtb \
+	sun6i-a31s-sina31s.dtb \
+	sun6i-a31s-sinovoip-bpi-m2.dtb \
+	sun6i-a31s-yones-toptech-bs1078-v2.dtb
+dtb-$(CONFIG_MACH_SUN7I) += \
+	sun7i-a20-bananapi.dtb \
+	sun7i-a20-bananapi-m1-plus.dtb \
+	sun7i-a20-bananapro.dtb \
+	sun7i-a20-cubieboard2.dtb \
+	sun7i-a20-cubietruck.dtb \
+	sun7i-a20-haoyu-marsboard.dtb \
+	sun7i-a20-hummingbird.dtb \
+	sun7i-a20-itead-ibox.dtb \
+	sun7i-a20-i12-tvbox.dtb \
+	sun7i-a20-icnova-swac.dtb \
+	sun7i-a20-lamobo-r1.dtb \
+	sun7i-a20-linutronix-testbox-v2.dtb \
+	sun7i-a20-m3.dtb \
+	sun7i-a20-mk808c.dtb \
+	sun7i-a20-olimex-som-evb.dtb \
+	sun7i-a20-olimex-som-evb-emmc.dtb \
+	sun7i-a20-olimex-som204-evb.dtb \
+	sun7i-a20-olimex-som204-evb-emmc.dtb \
+	sun7i-a20-olinuxino-lime.dtb \
+	sun7i-a20-olinuxino-lime-emmc.dtb \
+	sun7i-a20-olinuxino-lime2.dtb \
+	sun7i-a20-olinuxino-lime2-emmc.dtb \
+	sun7i-a20-olinuxino-micro.dtb \
+	sun7i-a20-olinuxino-micro-emmc.dtb \
+	sun7i-a20-orangepi.dtb \
+	sun7i-a20-orangepi-mini.dtb \
+	sun7i-a20-pcduino3.dtb \
+	sun7i-a20-pcduino3-nano.dtb \
+	sun7i-a20-wexler-tab7200.dtb \
+	sun7i-a20-wits-pro-a20-dkt.dtb
+dtb-$(CONFIG_MACH_SUN8I) += \
+	sun8i-a23-evb.dtb \
+	sun8i-a23-gt90h-v4.dtb \
+	sun8i-a23-inet86dz.dtb \
+	sun8i-a23-ippo-q8h-v5.dtb \
+	sun8i-a23-ippo-q8h-v1.2.dtb \
+	sun8i-a23-polaroid-mid2407pxe03.dtb \
+	sun8i-a23-polaroid-mid2809pxe04.dtb \
+	sun8i-a23-q8-tablet.dtb \
+	sun8i-a33-et-q8-v1.6.dtb \
+	sun8i-a33-ga10h-v1.1.dtb \
+	sun8i-a33-inet-d978-rev2.dtb \
+	sun8i-a33-ippo-q8h-v1.2.dtb \
+	sun8i-a33-olinuxino.dtb \
+	sun8i-a33-q8-tablet.dtb \
+	sun8i-a33-sinlinx-sina33.dtb \
+	sun8i-a83t-allwinner-h8homlet-v2.dtb \
+	sun8i-a83t-bananapi-m3.dtb \
+	sun8i-a83t-cubietruck-plus.dtb \
+	sun8i-a83t-tbs-a711.dtb \
+	sun8i-h2-plus-bananapi-m2-zero.dtb \
+	sun8i-h2-plus-libretech-all-h3-cc.dtb \
+	sun8i-h2-plus-orangepi-r1.dtb \
+	sun8i-h2-plus-orangepi-zero.dtb \
+	sun8i-h3-bananapi-m2-plus.dtb \
+	sun8i-h3-bananapi-m2-plus-v1.2.dtb \
+	sun8i-h3-beelink-x2.dtb \
+	sun8i-h3-libretech-all-h3-cc.dtb \
+	sun8i-h3-mapleboard-mp130.dtb \
+	sun8i-h3-nanopi-duo2.dtb \
+	sun8i-h3-nanopi-m1.dtb\
+	\
+	sun8i-h3-nanopi-m1-plus.dtb \
+	sun8i-h3-nanopi-neo.dtb \
+	sun8i-h3-nanopi-neo-air.dtb \
+	sun8i-h3-nanopi-r1.dtb \
+	sun8i-h3-orangepi-2.dtb \
+	sun8i-h3-orangepi-lite.dtb \
+	sun8i-h3-orangepi-one.dtb \
+	sun8i-h3-orangepi-pc.dtb \
+	sun8i-h3-orangepi-pc-plus.dtb \
+	sun8i-h3-orangepi-plus.dtb \
+	sun8i-h3-orangepi-plus2e.dtb \
+	sun8i-h3-orangepi-zero-plus2.dtb \
+	sun8i-h3-rervision-dvk.dtb \
+	sun8i-h3-zeropi.dtb \
+	sun8i-h3-emlid-neutis-n5h3-devboard.dtb \
+	sun8i-r16-bananapi-m2m.dtb \
+	sun8i-r16-nintendo-nes-classic.dtb \
+	sun8i-r16-nintendo-super-nes-classic.dtb \
+	sun8i-r16-parrot.dtb \
+	sun8i-r40-bananapi-m2-ultra.dtb \
+	sun8i-r40-oka40i-c.dtb \
+	sun8i-s3-elimo-initium.dtb \
+	sun8i-s3-lichee-zero-plus.dtb \
+	sun8i-s3-pinecube.dtb \
+	sun8i-t113s-mangopi-mq-r-t113.dtb \
+	sun8i-t3-cqa3t-bv3.dtb \
+	sun8i-v3-sl631-imx179.dtb \
+	sun8i-v3s-licheepi-zero.dtb \
+	sun8i-v3s-licheepi-zero-dock.dtb \
+	sun8i-v40-bananapi-m2-berry.dtb
+dtb-$(CONFIG_MACH_SUN9I) += \
+	sun9i-a80-optimus.dtb \
+	sun9i-a80-cubieboard4.dtb
+dtb-$(CONFIG_MACH_SUNIV) += \
+	suniv-f1c100s-licheepi-nano.dtb \
+	suniv-f1c200s-lctech-pi.dtb \
+	suniv-f1c200s-popstick-v1.1.dtb
diff --git a/arch/arm/boot/dts/axp152.dtsi b/arch/arm/boot/dts/allwinner/axp152.dtsi
similarity index 100%
rename from arch/arm/boot/dts/axp152.dtsi
rename to arch/arm/boot/dts/allwinner/axp152.dtsi
diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/allwinner/axp209.dtsi
similarity index 100%
rename from arch/arm/boot/dts/axp209.dtsi
rename to arch/arm/boot/dts/allwinner/axp209.dtsi
diff --git a/arch/arm/boot/dts/axp223.dtsi b/arch/arm/boot/dts/allwinner/axp223.dtsi
similarity index 100%
rename from arch/arm/boot/dts/axp223.dtsi
rename to arch/arm/boot/dts/allwinner/axp223.dtsi
diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/allwinner/axp22x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/axp22x.dtsi
rename to arch/arm/boot/dts/allwinner/axp22x.dtsi
diff --git a/arch/arm/boot/dts/axp809.dtsi b/arch/arm/boot/dts/allwinner/axp809.dtsi
similarity index 100%
rename from arch/arm/boot/dts/axp809.dtsi
rename to arch/arm/boot/dts/allwinner/axp809.dtsi
diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/allwinner/axp81x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/axp81x.dtsi
rename to arch/arm/boot/dts/allwinner/axp81x.dtsi
diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-a1000.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-a1000.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-a1000.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-ba10-tvbox.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-ba10-tvbox.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-chuwi-v7-cw0825.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-chuwi-v7-cw0825.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-cubieboard.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-cubieboard.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-cubieboard.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-dserve-dsrv9703c.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-dserve-dsrv9703c.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-gemei-g9.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-gemei-g9.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-hackberry.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-hackberry.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-hackberry.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-hyundai-a7hd.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-hyundai-a7hd.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-inet1.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-inet1.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-inet1.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-inet1.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-inet97fv2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-inet97fv2.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-inet9f-rev03.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-inet9f-rev03.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-itead-iteaduino-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-itead-iteaduino-plus.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-jesurun-q5.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-jesurun-q5.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-marsboard.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-marsboard.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-marsboard.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-mini-xplus.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-mini-xplus.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-mk802.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-mk802.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-mk802.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-mk802.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-mk802ii.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-mk802ii.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-mk802ii.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-mk802ii.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-olinuxino-lime.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-olinuxino-lime.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-pcduino.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-pcduino.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-pcduino.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino2.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-pcduino2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-pcduino2.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-pcduino2.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-pov-protab2-ips9.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-pov-protab2-ips9.dts
diff --git a/arch/arm/boot/dts/sun4i-a10-topwise-a721.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-topwise-a721.dts
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10-topwise-a721.dts
rename to arch/arm/boot/dts/allwinner/sun4i-a10-topwise-a721.dts
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/allwinner/sun4i-a10.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun4i-a10.dtsi
rename to arch/arm/boot/dts/allwinner/sun4i-a10.dtsi
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts b/arch/arm/boot/dts/allwinner/sun5i-a10s-auxtek-t003.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a10s-auxtek-t003.dts
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/allwinner/sun5i-a10s-auxtek-t004.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a10s-auxtek-t004.dts
diff --git a/arch/arm/boot/dts/sun5i-a10s-mk802.dts b/arch/arm/boot/dts/allwinner/sun5i-a10s-mk802.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a10s-mk802.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a10s-mk802.dts
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/allwinner/sun5i-a10s-olinuxino-micro.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a10s-olinuxino-micro.dts
diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/allwinner/sun5i-a10s-r7-tv-dongle.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a10s-r7-tv-dongle.dts
diff --git a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts b/arch/arm/boot/dts/allwinner/sun5i-a10s-wobo-i5.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a10s-wobo-i5.dts
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/allwinner/sun5i-a10s.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a10s.dtsi
rename to arch/arm/boot/dts/allwinner/sun5i-a10s.dtsi
diff --git a/arch/arm/boot/dts/sun5i-a13-difrnce-dit4350.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-difrnce-dit4350.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a13-difrnce-dit4350.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a13-difrnce-dit4350.dts
diff --git a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-empire-electronix-d709.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a13-empire-electronix-d709.dts
diff --git a/arch/arm/boot/dts/sun5i-a13-empire-electronix-m712.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-empire-electronix-m712.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a13-empire-electronix-m712.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a13-empire-electronix-m712.dts
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-hsg-h702.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a13-hsg-h702.dts
diff --git a/arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-inet-98v-rev2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a13-inet-98v-rev2.dts
diff --git a/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-licheepi-one.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a13-licheepi-one.dts
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-olinuxino-micro.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a13-olinuxino-micro.dts
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-olinuxino.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a13-olinuxino.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a13-olinuxino.dts
diff --git a/arch/arm/boot/dts/sun5i-a13-pocketbook-touch-lux-3.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-touch-lux-3.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a13-pocketbook-touch-lux-3.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-touch-lux-3.dts
diff --git a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-q8-tablet.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a13-q8-tablet.dts
diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-utoo-p66.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
rename to arch/arm/boot/dts/allwinner/sun5i-a13-utoo-p66.dts
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/allwinner/sun5i-a13.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun5i-a13.dtsi
rename to arch/arm/boot/dts/allwinner/sun5i-a13.dtsi
diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts b/arch/arm/boot/dts/allwinner/sun5i-gr8-chip-pro.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
rename to arch/arm/boot/dts/allwinner/sun5i-gr8-chip-pro.dts
diff --git a/arch/arm/boot/dts/sun5i-gr8-evb.dts b/arch/arm/boot/dts/allwinner/sun5i-gr8-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-gr8-evb.dts
rename to arch/arm/boot/dts/allwinner/sun5i-gr8-evb.dts
diff --git a/arch/arm/boot/dts/sun5i-gr8.dtsi b/arch/arm/boot/dts/allwinner/sun5i-gr8.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun5i-gr8.dtsi
rename to arch/arm/boot/dts/allwinner/sun5i-gr8.dtsi
diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/allwinner/sun5i-r8-chip.dts
similarity index 100%
rename from arch/arm/boot/dts/sun5i-r8-chip.dts
rename to arch/arm/boot/dts/allwinner/sun5i-r8-chip.dts
diff --git a/arch/arm/boot/dts/sun5i-r8.dtsi b/arch/arm/boot/dts/allwinner/sun5i-r8.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun5i-r8.dtsi
rename to arch/arm/boot/dts/allwinner/sun5i-r8.dtsi
diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/allwinner/sun5i-reference-design-tablet.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
rename to arch/arm/boot/dts/allwinner/sun5i-reference-design-tablet.dtsi
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/allwinner/sun5i.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun5i.dtsi
rename to arch/arm/boot/dts/allwinner/sun5i.dtsi
diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/allwinner/sun6i-a31-app4-evb1.dts
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
rename to arch/arm/boot/dts/allwinner/sun6i-a31-app4-evb1.dts
diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/allwinner/sun6i-a31-colombus.dts
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31-colombus.dts
rename to arch/arm/boot/dts/allwinner/sun6i-a31-colombus.dts
diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/allwinner/sun6i-a31-hummingbird.dts
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31-hummingbird.dts
rename to arch/arm/boot/dts/allwinner/sun6i-a31-hummingbird.dts
diff --git a/arch/arm/boot/dts/sun6i-a31-i7.dts b/arch/arm/boot/dts/allwinner/sun6i-a31-i7.dts
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31-i7.dts
rename to arch/arm/boot/dts/allwinner/sun6i-a31-i7.dts
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/allwinner/sun6i-a31-m9.dts
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31-m9.dts
rename to arch/arm/boot/dts/allwinner/sun6i-a31-m9.dts
diff --git a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts b/arch/arm/boot/dts/allwinner/sun6i-a31-mele-a1000g-quad.dts
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
rename to arch/arm/boot/dts/allwinner/sun6i-a31-mele-a1000g-quad.dts
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/allwinner/sun6i-a31.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31.dtsi
rename to arch/arm/boot/dts/allwinner/sun6i-a31.dtsi
diff --git a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts b/arch/arm/boot/dts/allwinner/sun6i-a31s-colorfly-e708-q1.dts
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
rename to arch/arm/boot/dts/allwinner/sun6i-a31s-colorfly-e708-q1.dts
diff --git a/arch/arm/boot/dts/sun6i-a31s-cs908.dts b/arch/arm/boot/dts/allwinner/sun6i-a31s-cs908.dts
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31s-cs908.dts
rename to arch/arm/boot/dts/allwinner/sun6i-a31s-cs908.dts
diff --git a/arch/arm/boot/dts/sun6i-a31s-inet-q972.dts b/arch/arm/boot/dts/allwinner/sun6i-a31s-inet-q972.dts
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31s-inet-q972.dts
rename to arch/arm/boot/dts/allwinner/sun6i-a31s-inet-q972.dts
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/allwinner/sun6i-a31s-primo81.dts
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31s-primo81.dts
rename to arch/arm/boot/dts/allwinner/sun6i-a31s-primo81.dts
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi b/arch/arm/boot/dts/allwinner/sun6i-a31s-sina31s-core.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
rename to arch/arm/boot/dts/allwinner/sun6i-a31s-sina31s-core.dtsi
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/allwinner/sun6i-a31s-sina31s.dts
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31s-sina31s.dts
rename to arch/arm/boot/dts/allwinner/sun6i-a31s-sina31s.dts
diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/allwinner/sun6i-a31s-sinovoip-bpi-m2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
rename to arch/arm/boot/dts/allwinner/sun6i-a31s-sinovoip-bpi-m2.dts
diff --git a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts b/arch/arm/boot/dts/allwinner/sun6i-a31s-yones-toptech-bs1078-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
rename to arch/arm/boot/dts/allwinner/sun6i-a31s-yones-toptech-bs1078-v2.dts
diff --git a/arch/arm/boot/dts/sun6i-a31s.dtsi b/arch/arm/boot/dts/allwinner/sun6i-a31s.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun6i-a31s.dtsi
rename to arch/arm/boot/dts/allwinner/sun6i-a31s.dtsi
diff --git a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi b/arch/arm/boot/dts/allwinner/sun6i-reference-design-tablet.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
rename to arch/arm/boot/dts/allwinner/sun6i-reference-design-tablet.dtsi
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi-m1-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-bananapi-m1-plus.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-bananapi.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-bananapro.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-bananapro.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-bananapro.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-cubieboard2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-cubieboard2.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-cubietruck.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-cubietruck.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-cubietruck.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-haoyu-marsboard.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-haoyu-marsboard.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-hummingbird.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-hummingbird.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-hummingbird.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-i12-tvbox.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-i12-tvbox.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-icnova-swac.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-icnova-swac.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-itead-ibox.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-itead-ibox.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-lamobo-r1.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-lamobo-r1.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-linutronix-testbox-v2.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-linutronix-testbox-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-linutronix-testbox-v2.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-linutronix-testbox-v2.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-m3.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-m3.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-m3.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-mk808c.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-mk808c.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-mk808c.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-mk808c.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som-evb-emmc.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som-evb-emmc.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som-evb.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som204-evb-emmc.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som204-evb-emmc.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som204-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-olimex-som204-evb.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime-emmc.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-lime-emmc.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-olinuxino-lime-emmc.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-lime-emmc.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-lime.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-lime.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-lime2-emmc.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-lime2-emmc.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-lime2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-lime2.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-micro-emmc.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-micro-emmc.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-micro.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-olinuxino-micro.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-orangepi-mini.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-orangepi-mini.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-orangepi.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-orangepi.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-orangepi.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-pcduino3-nano.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-pcduino3-nano.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-pcduino3.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-pcduino3.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-pcduino3.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-wexler-tab7200.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-wexler-tab7200.dts
diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-wits-pro-a20-dkt.dts
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
rename to arch/arm/boot/dts/allwinner/sun7i-a20-wits-pro-a20-dkt.dts
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/allwinner/sun7i-a20.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun7i-a20.dtsi
rename to arch/arm/boot/dts/allwinner/sun7i-a20.dtsi
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/allwinner/sun8i-a23-a33.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a23-a33.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-a23-a33.dtsi
diff --git a/arch/arm/boot/dts/sun8i-a23-evb.dts b/arch/arm/boot/dts/allwinner/sun8i-a23-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a23-evb.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a23-evb.dts
diff --git a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts b/arch/arm/boot/dts/allwinner/sun8i-a23-gt90h-v4.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a23-gt90h-v4.dts
diff --git a/arch/arm/boot/dts/sun8i-a23-inet86dz.dts b/arch/arm/boot/dts/allwinner/sun8i-a23-inet86dz.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a23-inet86dz.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a23-inet86dz.dts
diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts b/arch/arm/boot/dts/allwinner/sun8i-a23-ippo-q8h-v1.2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a23-ippo-q8h-v1.2.dts
diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/allwinner/sun8i-a23-ippo-q8h-v5.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a23-ippo-q8h-v5.dts
diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts b/arch/arm/boot/dts/allwinner/sun8i-a23-polaroid-mid2407pxe03.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a23-polaroid-mid2407pxe03.dts
diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts b/arch/arm/boot/dts/allwinner/sun8i-a23-polaroid-mid2809pxe04.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a23-polaroid-mid2809pxe04.dts
diff --git a/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts b/arch/arm/boot/dts/allwinner/sun8i-a23-q8-tablet.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a23-q8-tablet.dts
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/allwinner/sun8i-a23.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a23.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-a23.dtsi
diff --git a/arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts b/arch/arm/boot/dts/allwinner/sun8i-a33-et-q8-v1.6.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a33-et-q8-v1.6.dts
diff --git a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts b/arch/arm/boot/dts/allwinner/sun8i-a33-ga10h-v1.1.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a33-ga10h-v1.1.dts
diff --git a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/allwinner/sun8i-a33-inet-d978-rev2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a33-inet-d978-rev2.dts
diff --git a/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts b/arch/arm/boot/dts/allwinner/sun8i-a33-ippo-q8h-v1.2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a33-ippo-q8h-v1.2.dts
diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/allwinner/sun8i-a33-olinuxino.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a33-olinuxino.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a33-olinuxino.dts
diff --git a/arch/arm/boot/dts/sun8i-a33-q8-tablet.dts b/arch/arm/boot/dts/allwinner/sun8i-a33-q8-tablet.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a33-q8-tablet.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a33-q8-tablet.dts
diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/allwinner/sun8i-a33-sinlinx-sina33.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a33-sinlinx-sina33.dts
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/allwinner/sun8i-a33.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a33.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-a33.dtsi
diff --git a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts b/arch/arm/boot/dts/allwinner/sun8i-a83t-allwinner-h8homlet-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a83t-allwinner-h8homlet-v2.dts
diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/allwinner/sun8i-a83t-bananapi-m3.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a83t-bananapi-m3.dts
diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/allwinner/sun8i-a83t-cubietruck-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a83t-cubietruck-plus.dts
diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/allwinner/sun8i-a83t-tbs-a711.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
rename to arch/arm/boot/dts/allwinner/sun8i-a83t-tbs-a711.dts
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/allwinner/sun8i-a83t.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-a83t.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-a83t.dtsi
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-bananapi-m2-zero.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h2-plus-bananapi-m2-zero.dts
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dts b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-libretech-all-h3-cc.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h2-plus-libretech-all-h3-cc.dts
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-r1.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-r1.dts
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-zero.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-zero.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-bananapi-m2-plus-v1.2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-bananapi-m2-plus-v1.2.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-bananapi-m2-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-bananapi-m2-plus.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-beelink-x2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-beelink-x2.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3-devboard.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-emlid-neutis-n5h3-devboard.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3-devboard.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-emlid-neutis-n5h3-devboard.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3.dtsi b/arch/arm/boot/dts/allwinner/sun8i-h3-emlid-neutis-n5h3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-h3-emlid-neutis-n5h3.dtsi
diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-libretech-all-h3-cc.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-libretech-all-h3-cc.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-mapleboard-mp130.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-mapleboard-mp130.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-duo2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-duo2.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-m1-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-m1-plus.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-m1.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-m1.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-neo-air.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-neo-air.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-neo.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-neo.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-r1.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-r1.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-h3-nanopi.dtsi
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-2.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-lite.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-lite.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-one.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-one.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-pc-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-pc-plus.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-pc.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-pc.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-plus.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-plus2e.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-plus2e.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-rervision-dvk.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-rervision-dvk.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-rervision-dvk.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-rervision-dvk.dts
diff --git a/arch/arm/boot/dts/sun8i-h3-zeropi.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-zeropi.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3-zeropi.dts
rename to arch/arm/boot/dts/allwinner/sun8i-h3-zeropi.dts
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/allwinner/sun8i-h3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-h3.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-h3.dtsi
diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-q8-common.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi
diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/allwinner/sun8i-r16-bananapi-m2m.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
rename to arch/arm/boot/dts/allwinner/sun8i-r16-bananapi-m2m.dts
diff --git a/arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts b/arch/arm/boot/dts/allwinner/sun8i-r16-nintendo-nes-classic.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts
rename to arch/arm/boot/dts/allwinner/sun8i-r16-nintendo-nes-classic.dts
diff --git a/arch/arm/boot/dts/sun8i-r16-nintendo-super-nes-classic.dts b/arch/arm/boot/dts/allwinner/sun8i-r16-nintendo-super-nes-classic.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-r16-nintendo-super-nes-classic.dts
rename to arch/arm/boot/dts/allwinner/sun8i-r16-nintendo-super-nes-classic.dts
diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/allwinner/sun8i-r16-parrot.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-r16-parrot.dts
rename to arch/arm/boot/dts/allwinner/sun8i-r16-parrot.dts
diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
rename to arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts
diff --git a/arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi b/arch/arm/boot/dts/allwinner/sun8i-r40-cpu-opp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-r40-cpu-opp.dtsi
diff --git a/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
diff --git a/arch/arm/boot/dts/sun8i-r40-oka40i-c.dts b/arch/arm/boot/dts/allwinner/sun8i-r40-oka40i-c.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-r40-oka40i-c.dts
rename to arch/arm/boot/dts/allwinner/sun8i-r40-oka40i-c.dts
diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/allwinner/sun8i-r40.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-r40.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-r40.dtsi
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/allwinner/sun8i-reference-design-tablet.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-reference-design-tablet.dtsi
diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi b/arch/arm/boot/dts/allwinner/sun8i-s3-elimo-impetus.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-s3-elimo-impetus.dtsi
diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts b/arch/arm/boot/dts/allwinner/sun8i-s3-elimo-initium.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
rename to arch/arm/boot/dts/allwinner/sun8i-s3-elimo-initium.dts
diff --git a/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dts b/arch/arm/boot/dts/allwinner/sun8i-s3-lichee-zero-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dts
rename to arch/arm/boot/dts/allwinner/sun8i-s3-lichee-zero-plus.dts
diff --git a/arch/arm/boot/dts/sun8i-s3-pinecube.dts b/arch/arm/boot/dts/allwinner/sun8i-s3-pinecube.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-s3-pinecube.dts
rename to arch/arm/boot/dts/allwinner/sun8i-s3-pinecube.dts
diff --git a/arch/arm/boot/dts/sun8i-t113s-mangopi-mq-r-t113.dts b/arch/arm/boot/dts/allwinner/sun8i-t113s-mangopi-mq-r-t113.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-t113s-mangopi-mq-r-t113.dts
rename to arch/arm/boot/dts/allwinner/sun8i-t113s-mangopi-mq-r-t113.dts
diff --git a/arch/arm/boot/dts/sun8i-t113s.dtsi b/arch/arm/boot/dts/allwinner/sun8i-t113s.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-t113s.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-t113s.dtsi
diff --git a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts b/arch/arm/boot/dts/allwinner/sun8i-t3-cqa3t-bv3.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
rename to arch/arm/boot/dts/allwinner/sun8i-t3-cqa3t-bv3.dts
diff --git a/arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts b/arch/arm/boot/dts/allwinner/sun8i-v3-sl631-imx179.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts
rename to arch/arm/boot/dts/allwinner/sun8i-v3-sl631-imx179.dts
diff --git a/arch/arm/boot/dts/sun8i-v3-sl631.dtsi b/arch/arm/boot/dts/allwinner/sun8i-v3-sl631.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-v3-sl631.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-v3-sl631.dtsi
diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi b/arch/arm/boot/dts/allwinner/sun8i-v3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-v3.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-v3.dtsi
diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/allwinner/sun8i-v3s-licheepi-zero-dock.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
rename to arch/arm/boot/dts/allwinner/sun8i-v3s-licheepi-zero-dock.dts
diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/boot/dts/allwinner/sun8i-v3s-licheepi-zero.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
rename to arch/arm/boot/dts/allwinner/sun8i-v3s-licheepi-zero.dts
diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun8i-v3s.dtsi
rename to arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi
diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/allwinner/sun8i-v40-bananapi-m2-berry.dts
similarity index 100%
rename from arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
rename to arch/arm/boot/dts/allwinner/sun8i-v40-bananapi-m2-berry.dts
diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/allwinner/sun9i-a80-cubieboard4.dts
similarity index 100%
rename from arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
rename to arch/arm/boot/dts/allwinner/sun9i-a80-cubieboard4.dts
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/allwinner/sun9i-a80-optimus.dts
similarity index 100%
rename from arch/arm/boot/dts/sun9i-a80-optimus.dts
rename to arch/arm/boot/dts/allwinner/sun9i-a80-optimus.dts
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/allwinner/sun9i-a80.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun9i-a80.dtsi
rename to arch/arm/boot/dts/allwinner/sun9i-a80.dtsi
diff --git a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts
similarity index 100%
rename from arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
rename to arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts
diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
similarity index 100%
rename from arch/arm/boot/dts/suniv-f1c100s.dtsi
rename to arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
diff --git a/arch/arm/boot/dts/suniv-f1c200s-lctech-pi.dts b/arch/arm/boot/dts/allwinner/suniv-f1c200s-lctech-pi.dts
similarity index 100%
rename from arch/arm/boot/dts/suniv-f1c200s-lctech-pi.dts
rename to arch/arm/boot/dts/allwinner/suniv-f1c200s-lctech-pi.dts
diff --git a/arch/arm/boot/dts/suniv-f1c200s-popstick-v1.1.dts b/arch/arm/boot/dts/allwinner/suniv-f1c200s-popstick-v1.1.dts
similarity index 100%
rename from arch/arm/boot/dts/suniv-f1c200s-popstick-v1.1.dts
rename to arch/arm/boot/dts/allwinner/suniv-f1c200s-popstick-v1.1.dts
diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi b/arch/arm/boot/dts/allwinner/sunxi-bananapi-m2-plus-v1.2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
rename to arch/arm/boot/dts/allwinner/sunxi-bananapi-m2-plus-v1.2.dtsi
diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/allwinner/sunxi-bananapi-m2-plus.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
rename to arch/arm/boot/dts/allwinner/sunxi-bananapi-m2-plus.dtsi
diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/allwinner/sunxi-common-regulators.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sunxi-common-regulators.dtsi
rename to arch/arm/boot/dts/allwinner/sunxi-common-regulators.dtsi
diff --git a/arch/arm/boot/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi b/arch/arm/boot/dts/allwinner/sunxi-d1s-t113-mangopi-mq-r.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi
rename to arch/arm/boot/dts/allwinner/sunxi-d1s-t113-mangopi-mq-r.dtsi
diff --git a/arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi b/arch/arm/boot/dts/allwinner/sunxi-h3-h5-emlid-neutis.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi
rename to arch/arm/boot/dts/allwinner/sunxi-h3-h5-emlid-neutis.dtsi
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/allwinner/sunxi-h3-h5.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sunxi-h3-h5.dtsi
rename to arch/arm/boot/dts/allwinner/sunxi-h3-h5.dtsi
diff --git a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi b/arch/arm/boot/dts/allwinner/sunxi-itead-core-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sunxi-itead-core-common.dtsi
rename to arch/arm/boot/dts/allwinner/sunxi-itead-core-common.dtsi
diff --git a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi b/arch/arm/boot/dts/allwinner/sunxi-libretech-all-h3-cc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
rename to arch/arm/boot/dts/allwinner/sunxi-libretech-all-h3-cc.dtsi
diff --git a/arch/arm/boot/dts/sunxi-libretech-all-h3-it.dtsi b/arch/arm/boot/dts/allwinner/sunxi-libretech-all-h3-it.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sunxi-libretech-all-h3-it.dtsi
rename to arch/arm/boot/dts/allwinner/sunxi-libretech-all-h3-it.dtsi
diff --git a/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi b/arch/arm/boot/dts/allwinner/sunxi-reference-design-tablet.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
rename to arch/arm/boot/dts/allwinner/sunxi-reference-design-tablet.dtsi
diff --git a/arch/arm/boot/dts/alphascale/Makefile b/arch/arm/boot/dts/alphascale/Makefile
new file mode 100644
index 000000000000..f2d326989bc7
--- /dev/null
+++ b/arch/arm/boot/dts/alphascale/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_MACH_ASM9260) += \
+	alphascale-asm9260-devkit.dtb
diff --git a/arch/arm/boot/dts/alphascale-asm9260-devkit.dts b/arch/arm/boot/dts/alphascale/alphascale-asm9260-devkit.dts
similarity index 100%
rename from arch/arm/boot/dts/alphascale-asm9260-devkit.dts
rename to arch/arm/boot/dts/alphascale/alphascale-asm9260-devkit.dts
diff --git a/arch/arm/boot/dts/alphascale-asm9260.dtsi b/arch/arm/boot/dts/alphascale/alphascale-asm9260.dtsi
similarity index 100%
rename from arch/arm/boot/dts/alphascale-asm9260.dtsi
rename to arch/arm/boot/dts/alphascale/alphascale-asm9260.dtsi
diff --git a/arch/arm/boot/dts/amazon/Makefile b/arch/arm/boot/dts/amazon/Makefile
new file mode 100644
index 000000000000..be7d4e63882b
--- /dev/null
+++ b/arch/arm/boot/dts/amazon/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_ALPINE) += \
+	alpine-db.dtb
diff --git a/arch/arm/boot/dts/alpine-db.dts b/arch/arm/boot/dts/amazon/alpine-db.dts
similarity index 100%
rename from arch/arm/boot/dts/alpine-db.dts
rename to arch/arm/boot/dts/amazon/alpine-db.dts
diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/amazon/alpine.dtsi
similarity index 100%
rename from arch/arm/boot/dts/alpine.dtsi
rename to arch/arm/boot/dts/amazon/alpine.dtsi
diff --git a/arch/arm/boot/dts/amlogic/Makefile b/arch/arm/boot/dts/amlogic/Makefile
new file mode 100644
index 000000000000..a84310780ea3
--- /dev/null
+++ b/arch/arm/boot/dts/amlogic/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_MACH_MESON6) += \
+	meson6-atv1200.dtb
+dtb-$(CONFIG_MACH_MESON8) += \
+	meson8-minix-neo-x8.dtb \
+	meson8b-ec100.dtb \
+	meson8b-mxq.dtb \
+	meson8b-odroidc1.dtb \
+	meson8m2-mxiii-plus.dtb
diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/amlogic/meson.dtsi
similarity index 100%
rename from arch/arm/boot/dts/meson.dtsi
rename to arch/arm/boot/dts/amlogic/meson.dtsi
diff --git a/arch/arm/boot/dts/meson6-atv1200.dts b/arch/arm/boot/dts/amlogic/meson6-atv1200.dts
similarity index 100%
rename from arch/arm/boot/dts/meson6-atv1200.dts
rename to arch/arm/boot/dts/amlogic/meson6-atv1200.dts
diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/amlogic/meson6.dtsi
similarity index 100%
rename from arch/arm/boot/dts/meson6.dtsi
rename to arch/arm/boot/dts/amlogic/meson6.dtsi
diff --git a/arch/arm/boot/dts/meson8-minix-neo-x8.dts b/arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts
similarity index 100%
rename from arch/arm/boot/dts/meson8-minix-neo-x8.dts
rename to arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/amlogic/meson8.dtsi
similarity index 100%
rename from arch/arm/boot/dts/meson8.dtsi
rename to arch/arm/boot/dts/amlogic/meson8.dtsi
diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
similarity index 100%
rename from arch/arm/boot/dts/meson8b-ec100.dts
rename to arch/arm/boot/dts/amlogic/meson8b-ec100.dts
diff --git a/arch/arm/boot/dts/meson8b-mxq.dts b/arch/arm/boot/dts/amlogic/meson8b-mxq.dts
similarity index 100%
rename from arch/arm/boot/dts/meson8b-mxq.dts
rename to arch/arm/boot/dts/amlogic/meson8b-mxq.dts
diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
similarity index 100%
rename from arch/arm/boot/dts/meson8b-odroidc1.dts
rename to arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/amlogic/meson8b.dtsi
similarity index 100%
rename from arch/arm/boot/dts/meson8b.dtsi
rename to arch/arm/boot/dts/amlogic/meson8b.dtsi
diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/meson8m2-mxiii-plus.dts
rename to arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts
diff --git a/arch/arm/boot/dts/meson8m2.dtsi b/arch/arm/boot/dts/amlogic/meson8m2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/meson8m2.dtsi
rename to arch/arm/boot/dts/amlogic/meson8m2.dtsi
diff --git a/arch/arm/boot/dts/arm/Makefile b/arch/arm/boot/dts/arm/Makefile
new file mode 100644
index 000000000000..07ebb64e2cd0
--- /dev/null
+++ b/arch/arm/boot/dts/arm/Makefile
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_INTEGRATOR) += \
+	integratorap.dtb \
+	integratorap-im-pd1.dtb \
+	integratorcp.dtb
+dtb-$(CONFIG_ARCH_MPS2) += \
+	mps2-an385.dtb \
+	mps2-an399.dtb
+dtb-$(CONFIG_ARCH_REALVIEW) += \
+	arm-realview-pb1176.dtb \
+	arm-realview-pb11mp.dtb \
+	arm-realview-eb.dtb \
+	arm-realview-eb-bbrevd.dtb \
+	arm-realview-eb-11mp.dtb \
+	arm-realview-eb-11mp-bbrevd.dtb \
+	arm-realview-eb-11mp-ctrevb.dtb \
+	arm-realview-eb-11mp-bbrevd-ctrevb.dtb \
+	arm-realview-eb-a9mp.dtb \
+	arm-realview-eb-a9mp-bbrevd.dtb \
+	arm-realview-pba8.dtb \
+	arm-realview-pbx-a9.dtb
+dtb-$(CONFIG_ARCH_VERSATILE) += \
+	versatile-ab.dtb \
+	versatile-ab-ib2.dtb \
+	versatile-pb.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS) += \
+	vexpress-v2p-ca5s.dtb \
+	vexpress-v2p-ca9.dtb \
+	vexpress-v2p-ca15-tc1.dtb \
+	vexpress-v2p-ca15_a7.dtb
diff --git a/arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd-ctrevb.dts b/arch/arm/boot/dts/arm/arm-realview-eb-11mp-bbrevd-ctrevb.dts
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd-ctrevb.dts
rename to arch/arm/boot/dts/arm/arm-realview-eb-11mp-bbrevd-ctrevb.dts
diff --git a/arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd.dts b/arch/arm/boot/dts/arm/arm-realview-eb-11mp-bbrevd.dts
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd.dts
rename to arch/arm/boot/dts/arm/arm-realview-eb-11mp-bbrevd.dts
diff --git a/arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dts b/arch/arm/boot/dts/arm/arm-realview-eb-11mp-ctrevb.dts
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dts
rename to arch/arm/boot/dts/arm/arm-realview-eb-11mp-ctrevb.dts
diff --git a/arch/arm/boot/dts/arm-realview-eb-11mp.dts b/arch/arm/boot/dts/arm/arm-realview-eb-11mp.dts
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-eb-11mp.dts
rename to arch/arm/boot/dts/arm/arm-realview-eb-11mp.dts
diff --git a/arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dts b/arch/arm/boot/dts/arm/arm-realview-eb-a9mp-bbrevd.dts
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dts
rename to arch/arm/boot/dts/arm/arm-realview-eb-a9mp-bbrevd.dts
diff --git a/arch/arm/boot/dts/arm-realview-eb-a9mp.dts b/arch/arm/boot/dts/arm/arm-realview-eb-a9mp.dts
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-eb-a9mp.dts
rename to arch/arm/boot/dts/arm/arm-realview-eb-a9mp.dts
diff --git a/arch/arm/boot/dts/arm-realview-eb-bbrevd.dts b/arch/arm/boot/dts/arm/arm-realview-eb-bbrevd.dts
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-eb-bbrevd.dts
rename to arch/arm/boot/dts/arm/arm-realview-eb-bbrevd.dts
diff --git a/arch/arm/boot/dts/arm-realview-eb-bbrevd.dtsi b/arch/arm/boot/dts/arm/arm-realview-eb-bbrevd.dtsi
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-eb-bbrevd.dtsi
rename to arch/arm/boot/dts/arm/arm-realview-eb-bbrevd.dtsi
diff --git a/arch/arm/boot/dts/arm-realview-eb-mp.dtsi b/arch/arm/boot/dts/arm/arm-realview-eb-mp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-eb-mp.dtsi
rename to arch/arm/boot/dts/arm/arm-realview-eb-mp.dtsi
diff --git a/arch/arm/boot/dts/arm-realview-eb.dts b/arch/arm/boot/dts/arm/arm-realview-eb.dts
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-eb.dts
rename to arch/arm/boot/dts/arm/arm-realview-eb.dts
diff --git a/arch/arm/boot/dts/arm-realview-eb.dtsi b/arch/arm/boot/dts/arm/arm-realview-eb.dtsi
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-eb.dtsi
rename to arch/arm/boot/dts/arm/arm-realview-eb.dtsi
diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm/arm-realview-pb1176.dts
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-pb1176.dts
rename to arch/arm/boot/dts/arm/arm-realview-pb1176.dts
diff --git a/arch/arm/boot/dts/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm/arm-realview-pb11mp.dts
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-pb11mp.dts
rename to arch/arm/boot/dts/arm/arm-realview-pb11mp.dts
diff --git a/arch/arm/boot/dts/arm-realview-pba8.dts b/arch/arm/boot/dts/arm/arm-realview-pba8.dts
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-pba8.dts
rename to arch/arm/boot/dts/arm/arm-realview-pba8.dts
diff --git a/arch/arm/boot/dts/arm-realview-pbx-a9.dts b/arch/arm/boot/dts/arm/arm-realview-pbx-a9.dts
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-pbx-a9.dts
rename to arch/arm/boot/dts/arm/arm-realview-pbx-a9.dts
diff --git a/arch/arm/boot/dts/arm-realview-pbx.dtsi b/arch/arm/boot/dts/arm/arm-realview-pbx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/arm-realview-pbx.dtsi
rename to arch/arm/boot/dts/arm/arm-realview-pbx.dtsi
diff --git a/arch/arm/boot/dts/integrator.dtsi b/arch/arm/boot/dts/arm/integrator.dtsi
similarity index 100%
rename from arch/arm/boot/dts/integrator.dtsi
rename to arch/arm/boot/dts/arm/integrator.dtsi
diff --git a/arch/arm/boot/dts/integratorap-im-pd1.dts b/arch/arm/boot/dts/arm/integratorap-im-pd1.dts
similarity index 100%
rename from arch/arm/boot/dts/integratorap-im-pd1.dts
rename to arch/arm/boot/dts/arm/integratorap-im-pd1.dts
diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/arm/integratorap.dts
similarity index 100%
rename from arch/arm/boot/dts/integratorap.dts
rename to arch/arm/boot/dts/arm/integratorap.dts
diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/arm/integratorcp.dts
similarity index 100%
rename from arch/arm/boot/dts/integratorcp.dts
rename to arch/arm/boot/dts/arm/integratorcp.dts
diff --git a/arch/arm/boot/dts/mps2-an385.dts b/arch/arm/boot/dts/arm/mps2-an385.dts
similarity index 100%
rename from arch/arm/boot/dts/mps2-an385.dts
rename to arch/arm/boot/dts/arm/mps2-an385.dts
diff --git a/arch/arm/boot/dts/mps2-an399.dts b/arch/arm/boot/dts/arm/mps2-an399.dts
similarity index 100%
rename from arch/arm/boot/dts/mps2-an399.dts
rename to arch/arm/boot/dts/arm/mps2-an399.dts
diff --git a/arch/arm/boot/dts/mps2.dtsi b/arch/arm/boot/dts/arm/mps2.dtsi
similarity index 99%
rename from arch/arm/boot/dts/mps2.dtsi
rename to arch/arm/boot/dts/arm/mps2.dtsi
index b99577d411b1..ce308820765b 100644
--- a/arch/arm/boot/dts/mps2.dtsi
+++ b/arch/arm/boot/dts/arm/mps2.dtsi
@@ -42,7 +42,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "armv7-m.dtsi"
+#include "../armv7-m.dtsi"
 
 / {
 	#address-cells = <1>;
diff --git a/arch/arm/boot/dts/versatile-ab-ib2.dts b/arch/arm/boot/dts/arm/versatile-ab-ib2.dts
similarity index 100%
rename from arch/arm/boot/dts/versatile-ab-ib2.dts
rename to arch/arm/boot/dts/arm/versatile-ab-ib2.dts
diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/arm/versatile-ab.dts
similarity index 100%
rename from arch/arm/boot/dts/versatile-ab.dts
rename to arch/arm/boot/dts/arm/versatile-ab.dts
diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/arm/versatile-pb.dts
similarity index 100%
rename from arch/arm/boot/dts/versatile-pb.dts
rename to arch/arm/boot/dts/arm/versatile-pb.dts
diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/arm/vexpress-v2m-rs1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
rename to arch/arm/boot/dts/arm/vexpress-v2m-rs1.dtsi
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/arm/vexpress-v2m.dtsi
similarity index 100%
rename from arch/arm/boot/dts/vexpress-v2m.dtsi
rename to arch/arm/boot/dts/arm/vexpress-v2m.dtsi
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/arm/vexpress-v2p-ca15-tc1.dts
similarity index 100%
rename from arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
rename to arch/arm/boot/dts/arm/vexpress-v2p-ca15-tc1.dts
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/arm/vexpress-v2p-ca15_a7.dts
similarity index 100%
rename from arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
rename to arch/arm/boot/dts/arm/vexpress-v2p-ca15_a7.dts
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/arm/vexpress-v2p-ca5s.dts
similarity index 100%
rename from arch/arm/boot/dts/vexpress-v2p-ca5s.dts
rename to arch/arm/boot/dts/arm/vexpress-v2p-ca5s.dts
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts
similarity index 100%
rename from arch/arm/boot/dts/vexpress-v2p-ca9.dts
rename to arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts
diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
new file mode 100644
index 000000000000..c68984322a86
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_ASPEED) += \
+	aspeed-ast2500-evb.dtb \
+	aspeed-ast2600-evb-a1.dtb \
+	aspeed-ast2600-evb.dtb \
+	aspeed-bmc-amd-daytonax.dtb \
+	aspeed-bmc-amd-ethanolx.dtb \
+	aspeed-bmc-ampere-mtjade.dtb \
+	aspeed-bmc-ampere-mtmitchell.dtb \
+	aspeed-bmc-arm-stardragon4800-rep2.dtb \
+	aspeed-bmc-asrock-e3c246d4i.dtb \
+	aspeed-bmc-asrock-romed8hm3.dtb \
+	aspeed-bmc-bytedance-g220a.dtb \
+	aspeed-bmc-delta-ahe50dc.dtb \
+	aspeed-bmc-facebook-bletchley.dtb \
+	aspeed-bmc-facebook-cloudripper.dtb \
+	aspeed-bmc-facebook-cmm.dtb \
+	aspeed-bmc-facebook-elbert.dtb \
+	aspeed-bmc-facebook-fuji.dtb \
+	aspeed-bmc-facebook-galaxy100.dtb \
+	aspeed-bmc-facebook-greatlakes.dtb \
+	aspeed-bmc-facebook-minipack.dtb \
+	aspeed-bmc-facebook-tiogapass.dtb \
+	aspeed-bmc-facebook-wedge40.dtb \
+	aspeed-bmc-facebook-wedge100.dtb \
+	aspeed-bmc-facebook-wedge400.dtb \
+	aspeed-bmc-facebook-yamp.dtb \
+	aspeed-bmc-facebook-yosemitev2.dtb \
+	aspeed-bmc-ibm-bonnell.dtb \
+	aspeed-bmc-ibm-everest.dtb \
+	aspeed-bmc-ibm-rainier.dtb \
+	aspeed-bmc-ibm-rainier-1s4u.dtb \
+	aspeed-bmc-ibm-rainier-4u.dtb \
+	aspeed-bmc-intel-s2600wf.dtb \
+	aspeed-bmc-inspur-fp5280g2.dtb \
+	aspeed-bmc-inspur-nf5280m6.dtb \
+	aspeed-bmc-inspur-on5263m5.dtb \
+	aspeed-bmc-lenovo-hr630.dtb \
+	aspeed-bmc-lenovo-hr855xg2.dtb \
+	aspeed-bmc-microsoft-olympus.dtb \
+	aspeed-bmc-opp-lanyang.dtb \
+	aspeed-bmc-opp-mowgli.dtb \
+	aspeed-bmc-opp-nicole.dtb \
+	aspeed-bmc-opp-palmetto.dtb \
+	aspeed-bmc-opp-romulus.dtb \
+	aspeed-bmc-opp-swift.dtb \
+	aspeed-bmc-opp-tacoma.dtb \
+	aspeed-bmc-opp-vesnin.dtb \
+	aspeed-bmc-opp-witherspoon.dtb \
+	aspeed-bmc-opp-zaius.dtb \
+	aspeed-bmc-portwell-neptune.dtb \
+	aspeed-bmc-qcom-dc-scm-v1.dtb \
+	aspeed-bmc-quanta-q71l.dtb \
+	aspeed-bmc-quanta-s6q.dtb \
+	aspeed-bmc-supermicro-x11spi.dtb \
+	aspeed-bmc-inventec-transformers.dtb \
+	aspeed-bmc-tyan-s7106.dtb \
+	aspeed-bmc-tyan-s8036.dtb \
+	aspeed-bmc-ufispace-ncplite.dtb \
+	aspeed-bmc-vegman-n110.dtb \
+	aspeed-bmc-vegman-rx20.dtb \
+	aspeed-bmc-vegman-sx20.dtb
diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-ast2500-evb.dts
rename to arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dts
diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
rename to arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dts
diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-ast2600-evb.dts
rename to arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-daytonax.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-amd-daytonax.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-ethanolx.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-amd-ethanolx.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cloudripper.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cloudripper.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-tiogapass.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-tiogapass.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-nf5280m6.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-nf5280m6.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-inspur-nf5280m6.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-nf5280m6.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-inventec-transformers.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-inventec-transformers.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-microsoft-olympus.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-microsoft-olympus.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-microsoft-olympus.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-microsoft-olympus.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-vesnin.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-opp-vesnin.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-portwell-neptune.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-portwell-neptune.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-qcom-dc-scm-v1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-qcom-dc-scm-v1.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-q71l.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-q71l.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-quanta-s6q.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-quanta-s6q.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-supermicro-x11spi.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-supermicro-x11spi.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s7106.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s7106.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s8036.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s8036.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-vegman-n110.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-n110.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-vegman-n110.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-n110.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-vegman-rx20.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-vegman-rx20.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-vegman-sx20.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-sx20.dts
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-vegman-sx20.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-sx20.dts
diff --git a/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi
similarity index 100%
rename from arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi
diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/aspeed-g4.dtsi
rename to arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
similarity index 100%
rename from arch/arm/boot/dts/aspeed-g5.dtsi
rename to arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
diff --git a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
rename to arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
similarity index 100%
rename from arch/arm/boot/dts/aspeed-g6.dtsi
rename to arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
diff --git a/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2400-facebook-netbmc-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi
rename to arch/arm/boot/dts/aspeed/ast2400-facebook-netbmc-common.dtsi
diff --git a/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
rename to arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi
diff --git a/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
rename to arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
diff --git a/arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128.dtsi
similarity index 100%
rename from arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi
rename to arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128.dtsi
diff --git a/arch/arm/boot/dts/facebook-bmc-flash-layout.dtsi b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout.dtsi
similarity index 100%
rename from arch/arm/boot/dts/facebook-bmc-flash-layout.dtsi
rename to arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout.dtsi
diff --git a/arch/arm/boot/dts/ibm-power9-dual.dtsi b/arch/arm/boot/dts/aspeed/ibm-power9-dual.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ibm-power9-dual.dtsi
rename to arch/arm/boot/dts/aspeed/ibm-power9-dual.dtsi
diff --git a/arch/arm/boot/dts/openbmc-flash-layout-128.dtsi b/arch/arm/boot/dts/aspeed/openbmc-flash-layout-128.dtsi
similarity index 100%
rename from arch/arm/boot/dts/openbmc-flash-layout-128.dtsi
rename to arch/arm/boot/dts/aspeed/openbmc-flash-layout-128.dtsi
diff --git a/arch/arm/boot/dts/openbmc-flash-layout-64-alt.dtsi b/arch/arm/boot/dts/aspeed/openbmc-flash-layout-64-alt.dtsi
similarity index 100%
rename from arch/arm/boot/dts/openbmc-flash-layout-64-alt.dtsi
rename to arch/arm/boot/dts/aspeed/openbmc-flash-layout-64-alt.dtsi
diff --git a/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi b/arch/arm/boot/dts/aspeed/openbmc-flash-layout-64.dtsi
similarity index 100%
rename from arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
rename to arch/arm/boot/dts/aspeed/openbmc-flash-layout-64.dtsi
diff --git a/arch/arm/boot/dts/openbmc-flash-layout.dtsi b/arch/arm/boot/dts/aspeed/openbmc-flash-layout.dtsi
similarity index 100%
rename from arch/arm/boot/dts/openbmc-flash-layout.dtsi
rename to arch/arm/boot/dts/aspeed/openbmc-flash-layout.dtsi
diff --git a/arch/arm/boot/dts/axis/Makefile b/arch/arm/boot/dts/axis/Makefile
new file mode 100644
index 000000000000..19177c4bc635
--- /dev/null
+++ b/arch/arm/boot/dts/axis/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_MACH_ARTPEC6) += \
+	artpec6-devboard.dtb
diff --git a/arch/arm/boot/dts/artpec6-devboard.dts b/arch/arm/boot/dts/axis/artpec6-devboard.dts
similarity index 100%
rename from arch/arm/boot/dts/artpec6-devboard.dts
rename to arch/arm/boot/dts/axis/artpec6-devboard.dts
diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
similarity index 100%
rename from arch/arm/boot/dts/artpec6.dtsi
rename to arch/arm/boot/dts/axis/artpec6.dtsi
diff --git a/arch/arm/boot/dts/broadcom/Makefile b/arch/arm/boot/dts/broadcom/Makefile
new file mode 100644
index 000000000000..980e3ff0136d
--- /dev/null
+++ b/arch/arm/boot/dts/broadcom/Makefile
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_BCM2835) += \
+	bcm2835-rpi-b.dtb \
+	bcm2835-rpi-a.dtb \
+	bcm2835-rpi-b-rev2.dtb \
+	bcm2835-rpi-b-plus.dtb \
+	bcm2835-rpi-a-plus.dtb \
+	bcm2835-rpi-cm1-io1.dtb \
+	bcm2836-rpi-2-b.dtb \
+	bcm2837-rpi-3-a-plus.dtb \
+	bcm2837-rpi-3-b.dtb \
+	bcm2837-rpi-3-b-plus.dtb \
+	bcm2837-rpi-cm3-io3.dtb \
+	bcm2837-rpi-zero-2-w.dtb \
+	bcm2711-rpi-400.dtb \
+	bcm2711-rpi-4-b.dtb \
+	bcm2711-rpi-cm4-io.dtb \
+	bcm2835-rpi-zero.dtb \
+	bcm2835-rpi-zero-w.dtb
+dtb-$(CONFIG_ARCH_BCMBCA) += \
+	bcm947622.dtb \
+	bcm963138.dtb \
+	bcm963138dvt.dtb \
+	bcm963148.dtb \
+	bcm963178.dtb \
+	bcm96756.dtb \
+	bcm96846.dtb \
+	bcm96855.dtb \
+	bcm96878.dtb
+dtb-$(CONFIG_ARCH_BCM_5301X) += \
+	bcm4708-asus-rt-ac56u.dtb \
+	bcm4708-asus-rt-ac68u.dtb \
+	bcm4708-buffalo-wzr-1750dhp.dtb \
+	bcm4708-buffalo-wzr-1166dhp.dtb \
+	bcm4708-buffalo-wzr-1166dhp2.dtb \
+	bcm4708-linksys-ea6300-v1.dtb \
+	bcm4708-linksys-ea6500-v2.dtb \
+	bcm4708-luxul-xap-1510.dtb \
+	bcm4708-luxul-xwc-1000.dtb \
+	bcm4708-netgear-r6250.dtb \
+	bcm4708-netgear-r6300-v2.dtb \
+	bcm4708-smartrg-sr400ac.dtb \
+	bcm47081-asus-rt-n18u.dtb \
+	bcm47081-buffalo-wzr-600dhp2.dtb \
+	bcm47081-buffalo-wzr-900dhp.dtb \
+	bcm47081-luxul-xap-1410.dtb \
+	bcm47081-luxul-xwr-1200.dtb \
+	bcm47081-tplink-archer-c5-v2.dtb \
+	bcm4709-asus-rt-ac87u.dtb \
+	bcm4709-buffalo-wxr-1900dhp.dtb \
+	bcm4709-linksys-ea9200.dtb \
+	bcm4709-netgear-r7000.dtb \
+	bcm4709-netgear-r8000.dtb \
+	bcm4709-tplink-archer-c9-v1.dtb \
+	bcm47094-asus-rt-ac88u.dtb \
+	bcm47094-dlink-dir-885l.dtb \
+	bcm47094-dlink-dir-890l.dtb \
+	bcm47094-linksys-panamera.dtb \
+	bcm47094-luxul-abr-4500.dtb \
+	bcm47094-luxul-xap-1610.dtb \
+	bcm47094-luxul-xbr-4500.dtb \
+	bcm47094-luxul-xwc-2000.dtb \
+	bcm47094-luxul-xwr-3100.dtb \
+	bcm47094-luxul-xwr-3150-v1.dtb \
+	bcm47094-netgear-r8500.dtb \
+	bcm47094-phicomm-k3.dtb \
+	bcm53015-meraki-mr26.dtb \
+	bcm53016-dlink-dwl-8610ap.dtb \
+	bcm53016-meraki-mr32.dtb \
+	bcm94708.dtb \
+	bcm94709.dtb \
+	bcm953012er.dtb \
+	bcm953012hr.dtb \
+	bcm953012k.dtb
+dtb-$(CONFIG_ARCH_BCM_53573) += \
+	bcm47189-luxul-xap-1440.dtb \
+	bcm47189-luxul-xap-810.dtb \
+	bcm47189-tenda-ac9.dtb \
+	bcm947189acdbmr.dtb
+dtb-$(CONFIG_ARCH_BCM_CYGNUS) += \
+	bcm911360_entphn.dtb \
+	bcm911360k.dtb \
+	bcm958300k.dtb \
+	bcm958305k.dtb
+dtb-$(CONFIG_ARCH_BCM_HR2) += \
+	bcm53340-ubnt-unifi-switch8.dtb
+dtb-$(CONFIG_ARCH_BCM_MOBILE) += \
+	bcm28155-ap.dtb \
+	bcm21664-garnet.dtb \
+	bcm23550-sparrow.dtb
+dtb-$(CONFIG_ARCH_BCM_NSP) += \
+	bcm958522er.dtb \
+	bcm958525er.dtb \
+	bcm958525xmc.dtb \
+	bcm958622hr.dtb \
+	bcm958623hr.dtb \
+	bcm958625-meraki-mx64.dtb \
+	bcm958625-meraki-mx64-a0.dtb \
+	bcm958625-meraki-mx64w.dtb \
+	bcm958625-meraki-mx64w-a0.dtb \
+	bcm958625-meraki-mx65.dtb \
+	bcm958625-meraki-mx65w.dtb \
+	bcm958625hr.dtb \
+	bcm988312hr.dtb \
+	bcm958625k.dtb
+dtb-$(CONFIG_ARCH_BRCMSTB) += \
+	bcm7445-bcm97445svmb.dtb
diff --git a/arch/arm/boot/dts/bcm-cygnus-clock.dtsi b/arch/arm/boot/dts/broadcom/bcm-cygnus-clock.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm-cygnus-clock.dtsi
rename to arch/arm/boot/dts/broadcom/bcm-cygnus-clock.dtsi
diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/broadcom/bcm-cygnus.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm-cygnus.dtsi
rename to arch/arm/boot/dts/broadcom/bcm-cygnus.dtsi
diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/broadcom/bcm-hr2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm-hr2.dtsi
rename to arch/arm/boot/dts/broadcom/bcm-hr2.dtsi
diff --git a/arch/arm/boot/dts/bcm-nsp-ax.dtsi b/arch/arm/boot/dts/broadcom/bcm-nsp-ax.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm-nsp-ax.dtsi
rename to arch/arm/boot/dts/broadcom/bcm-nsp-ax.dtsi
diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/broadcom/bcm-nsp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm-nsp.dtsi
rename to arch/arm/boot/dts/broadcom/bcm-nsp.dtsi
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/broadcom/bcm11351.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm11351.dtsi
rename to arch/arm/boot/dts/broadcom/bcm11351.dtsi
diff --git a/arch/arm/boot/dts/bcm21664-garnet.dts b/arch/arm/boot/dts/broadcom/bcm21664-garnet.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm21664-garnet.dts
rename to arch/arm/boot/dts/broadcom/bcm21664-garnet.dts
diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/broadcom/bcm21664.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm21664.dtsi
rename to arch/arm/boot/dts/broadcom/bcm21664.dtsi
diff --git a/arch/arm/boot/dts/bcm23550-sparrow.dts b/arch/arm/boot/dts/broadcom/bcm23550-sparrow.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm23550-sparrow.dts
rename to arch/arm/boot/dts/broadcom/bcm23550-sparrow.dts
diff --git a/arch/arm/boot/dts/bcm23550.dtsi b/arch/arm/boot/dts/broadcom/bcm23550.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm23550.dtsi
rename to arch/arm/boot/dts/broadcom/bcm23550.dtsi
diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2711-rpi-4-b.dts
rename to arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
diff --git a/arch/arm/boot/dts/bcm2711-rpi-400.dts b/arch/arm/boot/dts/broadcom/bcm2711-rpi-400.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2711-rpi-400.dts
rename to arch/arm/boot/dts/broadcom/bcm2711-rpi-400.dts
diff --git a/arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts b/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts
rename to arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
diff --git a/arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi b/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi
rename to arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4.dtsi
diff --git a/arch/arm/boot/dts/bcm2711-rpi.dtsi b/arch/arm/boot/dts/broadcom/bcm2711-rpi.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm2711-rpi.dtsi
rename to arch/arm/boot/dts/broadcom/bcm2711-rpi.dtsi
diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm2711.dtsi
rename to arch/arm/boot/dts/broadcom/bcm2711.dtsi
diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/broadcom/bcm28155-ap.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm28155-ap.dts
rename to arch/arm/boot/dts/broadcom/bcm28155-ap.dts
diff --git a/arch/arm/boot/dts/bcm2835-common.dtsi b/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm2835-common.dtsi
rename to arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/broadcom/bcm2835-rpi-a-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
rename to arch/arm/boot/dts/broadcom/bcm2835-rpi-a-plus.dts
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/broadcom/bcm2835-rpi-a.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2835-rpi-a.dts
rename to arch/arm/boot/dts/broadcom/bcm2835-rpi-a.dts
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/broadcom/bcm2835-rpi-b-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
rename to arch/arm/boot/dts/broadcom/bcm2835-rpi-b-plus.dts
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/broadcom/bcm2835-rpi-b-rev2.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
rename to arch/arm/boot/dts/broadcom/bcm2835-rpi-b-rev2.dts
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/broadcom/bcm2835-rpi-b.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2835-rpi-b.dts
rename to arch/arm/boot/dts/broadcom/bcm2835-rpi-b.dts
diff --git a/arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts b/arch/arm/boot/dts/broadcom/bcm2835-rpi-cm1-io1.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
rename to arch/arm/boot/dts/broadcom/bcm2835-rpi-cm1-io1.dts
diff --git a/arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi b/arch/arm/boot/dts/broadcom/bcm2835-rpi-cm1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
rename to arch/arm/boot/dts/broadcom/bcm2835-rpi-cm1.dtsi
diff --git a/arch/arm/boot/dts/bcm2835-rpi-common.dtsi b/arch/arm/boot/dts/broadcom/bcm2835-rpi-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm2835-rpi-common.dtsi
rename to arch/arm/boot/dts/broadcom/bcm2835-rpi-common.dtsi
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/broadcom/bcm2835-rpi-zero-w.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
rename to arch/arm/boot/dts/broadcom/bcm2835-rpi-zero-w.dts
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero.dts b/arch/arm/boot/dts/broadcom/bcm2835-rpi-zero.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2835-rpi-zero.dts
rename to arch/arm/boot/dts/broadcom/bcm2835-rpi-zero.dts
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/broadcom/bcm2835-rpi.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm2835-rpi.dtsi
rename to arch/arm/boot/dts/broadcom/bcm2835-rpi.dtsi
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/broadcom/bcm2835.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm2835.dtsi
rename to arch/arm/boot/dts/broadcom/bcm2835.dtsi
diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/broadcom/bcm2836-rpi-2-b.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2836-rpi-2-b.dts
rename to arch/arm/boot/dts/broadcom/bcm2836-rpi-2-b.dts
diff --git a/arch/arm/boot/dts/bcm2836-rpi.dtsi b/arch/arm/boot/dts/broadcom/bcm2836-rpi.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm2836-rpi.dtsi
rename to arch/arm/boot/dts/broadcom/bcm2836-rpi.dtsi
diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/broadcom/bcm2836.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm2836.dtsi
rename to arch/arm/boot/dts/broadcom/bcm2836.dtsi
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts b/arch/arm/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
rename to arch/arm/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
rename to arch/arm/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/broadcom/bcm2837-rpi-3-b.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2837-rpi-3-b.dts
rename to arch/arm/boot/dts/broadcom/bcm2837-rpi-3-b.dts
diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts b/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
rename to arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi b/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
rename to arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3.dtsi
diff --git a/arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts b/arch/arm/boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts
rename to arch/arm/boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts
diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/broadcom/bcm2837.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm2837.dtsi
rename to arch/arm/boot/dts/broadcom/bcm2837.dtsi
diff --git a/arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi b/arch/arm/boot/dts/broadcom/bcm283x-rpi-lan7515.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
rename to arch/arm/boot/dts/broadcom/bcm283x-rpi-lan7515.dtsi
diff --git a/arch/arm/boot/dts/bcm283x-rpi-led-deprecated.dtsi b/arch/arm/boot/dts/broadcom/bcm283x-rpi-led-deprecated.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm283x-rpi-led-deprecated.dtsi
rename to arch/arm/boot/dts/broadcom/bcm283x-rpi-led-deprecated.dtsi
diff --git a/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi b/arch/arm/boot/dts/broadcom/bcm283x-rpi-smsc9512.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
rename to arch/arm/boot/dts/broadcom/bcm283x-rpi-smsc9512.dtsi
diff --git a/arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi b/arch/arm/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
rename to arch/arm/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
diff --git a/arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi b/arch/arm/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi
rename to arch/arm/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
diff --git a/arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi b/arch/arm/boot/dts/broadcom/bcm283x-rpi-usb-otg.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi
rename to arch/arm/boot/dts/broadcom/bcm283x-rpi-usb-otg.dtsi
diff --git a/arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi b/arch/arm/boot/dts/broadcom/bcm283x-rpi-usb-peripheral.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi
rename to arch/arm/boot/dts/broadcom/bcm283x-rpi-usb-peripheral.dtsi
diff --git a/arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi b/arch/arm/boot/dts/broadcom/bcm283x-rpi-wifi-bt.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi
rename to arch/arm/boot/dts/broadcom/bcm283x-rpi-wifi-bt.dtsi
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/broadcom/bcm283x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm283x.dtsi
rename to arch/arm/boot/dts/broadcom/bcm283x.dtsi
diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts b/arch/arm/boot/dts/broadcom/bcm4708-asus-rt-ac56u.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
rename to arch/arm/boot/dts/broadcom/bcm4708-asus-rt-ac56u.dts
diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts b/arch/arm/boot/dts/broadcom/bcm4708-asus-rt-ac68u.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
rename to arch/arm/boot/dts/broadcom/bcm4708-asus-rt-ac68u.dts
diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp-common.dtsi b/arch/arm/boot/dts/broadcom/bcm4708-buffalo-wzr-1166dhp-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp-common.dtsi
rename to arch/arm/boot/dts/broadcom/bcm4708-buffalo-wzr-1166dhp-common.dtsi
diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dts b/arch/arm/boot/dts/broadcom/bcm4708-buffalo-wzr-1166dhp.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dts
rename to arch/arm/boot/dts/broadcom/bcm4708-buffalo-wzr-1166dhp.dts
diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dts b/arch/arm/boot/dts/broadcom/bcm4708-buffalo-wzr-1166dhp2.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dts
rename to arch/arm/boot/dts/broadcom/bcm4708-buffalo-wzr-1166dhp2.dts
diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/broadcom/bcm4708-buffalo-wzr-1750dhp.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
rename to arch/arm/boot/dts/broadcom/bcm4708-buffalo-wzr-1750dhp.dts
diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts b/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6300-v1.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
rename to arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6300-v1.dts
diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts b/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
rename to arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts b/arch/arm/boot/dts/broadcom/bcm4708-luxul-xap-1510.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
rename to arch/arm/boot/dts/broadcom/bcm4708-luxul-xap-1510.dts
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/broadcom/bcm4708-luxul-xwc-1000.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
rename to arch/arm/boot/dts/broadcom/bcm4708-luxul-xwc-1000.dts
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/broadcom/bcm4708-netgear-r6250.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4708-netgear-r6250.dts
rename to arch/arm/boot/dts/broadcom/bcm4708-netgear-r6250.dts
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/broadcom/bcm4708-netgear-r6300-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
rename to arch/arm/boot/dts/broadcom/bcm4708-netgear-r6300-v2.dts
diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/broadcom/bcm4708-smartrg-sr400ac.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
rename to arch/arm/boot/dts/broadcom/bcm4708-smartrg-sr400ac.dts
diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/broadcom/bcm4708.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm4708.dtsi
rename to arch/arm/boot/dts/broadcom/bcm4708.dtsi
diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/broadcom/bcm47081-asus-rt-n18u.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
rename to arch/arm/boot/dts/broadcom/bcm47081-asus-rt-n18u.dts
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/broadcom/bcm47081-buffalo-wzr-600dhp2.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
rename to arch/arm/boot/dts/broadcom/bcm47081-buffalo-wzr-600dhp2.dts
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts b/arch/arm/boot/dts/broadcom/bcm47081-buffalo-wzr-900dhp.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
rename to arch/arm/boot/dts/broadcom/bcm47081-buffalo-wzr-900dhp.dts
diff --git a/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts b/arch/arm/boot/dts/broadcom/bcm47081-luxul-xap-1410.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
rename to arch/arm/boot/dts/broadcom/bcm47081-luxul-xap-1410.dts
diff --git a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts b/arch/arm/boot/dts/broadcom/bcm47081-luxul-xwr-1200.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
rename to arch/arm/boot/dts/broadcom/bcm47081-luxul-xwr-1200.dts
diff --git a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts b/arch/arm/boot/dts/broadcom/bcm47081-tplink-archer-c5-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
rename to arch/arm/boot/dts/broadcom/bcm47081-tplink-archer-c5-v2.dts
diff --git a/arch/arm/boot/dts/bcm47081.dtsi b/arch/arm/boot/dts/broadcom/bcm47081.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm47081.dtsi
rename to arch/arm/boot/dts/broadcom/bcm47081.dtsi
diff --git a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts b/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac87u.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
rename to arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac87u.dts
diff --git a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts b/arch/arm/boot/dts/broadcom/bcm4709-buffalo-wxr-1900dhp.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
rename to arch/arm/boot/dts/broadcom/bcm4709-buffalo-wxr-1900dhp.dts
diff --git a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts b/arch/arm/boot/dts/broadcom/bcm4709-linksys-ea9200.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
rename to arch/arm/boot/dts/broadcom/bcm4709-linksys-ea9200.dts
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts b/arch/arm/boot/dts/broadcom/bcm4709-netgear-r7000.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4709-netgear-r7000.dts
rename to arch/arm/boot/dts/broadcom/bcm4709-netgear-r7000.dts
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4709-netgear-r8000.dts
rename to arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts
diff --git a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts b/arch/arm/boot/dts/broadcom/bcm4709-tplink-archer-c9-v1.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
rename to arch/arm/boot/dts/broadcom/bcm4709-tplink-archer-c9-v1.dts
diff --git a/arch/arm/boot/dts/bcm4709.dtsi b/arch/arm/boot/dts/broadcom/bcm4709.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm4709.dtsi
rename to arch/arm/boot/dts/broadcom/bcm4709.dtsi
diff --git a/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts
rename to arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-885l.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
rename to arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-885l.dts
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts b/arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-890l.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
rename to arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-890l.dts
diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/broadcom/bcm47094-linksys-panamera.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47094-linksys-panamera.dts
rename to arch/arm/boot/dts/broadcom/bcm47094-linksys-panamera.dts
diff --git a/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts b/arch/arm/boot/dts/broadcom/bcm47094-luxul-abr-4500.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
rename to arch/arm/boot/dts/broadcom/bcm47094-luxul-abr-4500.dts
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xap-1610.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts
rename to arch/arm/boot/dts/broadcom/bcm47094-luxul-xap-1610.dts
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xbr-4500.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
rename to arch/arm/boot/dts/broadcom/bcm47094-luxul-xbr-4500.dts
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwc-2000.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts
rename to arch/arm/boot/dts/broadcom/bcm47094-luxul-xwc-2000.dts
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3100.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
rename to arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3100.dts
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
rename to arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts
diff --git a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts b/arch/arm/boot/dts/broadcom/bcm47094-netgear-r8500.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47094-netgear-r8500.dts
rename to arch/arm/boot/dts/broadcom/bcm47094-netgear-r8500.dts
diff --git a/arch/arm/boot/dts/bcm47094-phicomm-k3.dts b/arch/arm/boot/dts/broadcom/bcm47094-phicomm-k3.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47094-phicomm-k3.dts
rename to arch/arm/boot/dts/broadcom/bcm47094-phicomm-k3.dts
diff --git a/arch/arm/boot/dts/bcm47094.dtsi b/arch/arm/boot/dts/broadcom/bcm47094.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm47094.dtsi
rename to arch/arm/boot/dts/broadcom/bcm47094.dtsi
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts b/arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-1440.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
rename to arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-1440.dts
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts b/arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-810.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
rename to arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-810.dts
diff --git a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts b/arch/arm/boot/dts/broadcom/bcm47189-tenda-ac9.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm47189-tenda-ac9.dts
rename to arch/arm/boot/dts/broadcom/bcm47189-tenda-ac9.dts
diff --git a/arch/arm/boot/dts/bcm47622.dtsi b/arch/arm/boot/dts/broadcom/bcm47622.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm47622.dtsi
rename to arch/arm/boot/dts/broadcom/bcm47622.dtsi
diff --git a/arch/arm/boot/dts/bcm53015-meraki-mr26.dts b/arch/arm/boot/dts/broadcom/bcm53015-meraki-mr26.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm53015-meraki-mr26.dts
rename to arch/arm/boot/dts/broadcom/bcm53015-meraki-mr26.dts
diff --git a/arch/arm/boot/dts/bcm53016-dlink-dwl-8610ap.dts b/arch/arm/boot/dts/broadcom/bcm53016-dlink-dwl-8610ap.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm53016-dlink-dwl-8610ap.dts
rename to arch/arm/boot/dts/broadcom/bcm53016-dlink-dwl-8610ap.dts
diff --git a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts b/arch/arm/boot/dts/broadcom/bcm53016-meraki-mr32.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm53016-meraki-mr32.dts
rename to arch/arm/boot/dts/broadcom/bcm53016-meraki-mr32.dts
diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi b/arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0-bch1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi
rename to arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0-bch1.dtsi
diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi b/arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0-bch4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi
rename to arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0-bch4.dtsi
diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi b/arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0-bch8.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi
rename to arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0-bch8.dtsi
diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi b/arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
rename to arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0.dtsi
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/broadcom/bcm5301x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm5301x.dtsi
rename to arch/arm/boot/dts/broadcom/bcm5301x.dtsi
diff --git a/arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts b/arch/arm/boot/dts/broadcom/bcm53340-ubnt-unifi-switch8.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts
rename to arch/arm/boot/dts/broadcom/bcm53340-ubnt-unifi-switch8.dts
diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/broadcom/bcm53573.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm53573.dtsi
rename to arch/arm/boot/dts/broadcom/bcm53573.dtsi
diff --git a/arch/arm/boot/dts/bcm59056.dtsi b/arch/arm/boot/dts/broadcom/bcm59056.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm59056.dtsi
rename to arch/arm/boot/dts/broadcom/bcm59056.dtsi
diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/broadcom/bcm63138.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm63138.dtsi
rename to arch/arm/boot/dts/broadcom/bcm63138.dtsi
diff --git a/arch/arm/boot/dts/bcm63148.dtsi b/arch/arm/boot/dts/broadcom/bcm63148.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm63148.dtsi
rename to arch/arm/boot/dts/broadcom/bcm63148.dtsi
diff --git a/arch/arm/boot/dts/bcm63178.dtsi b/arch/arm/boot/dts/broadcom/bcm63178.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm63178.dtsi
rename to arch/arm/boot/dts/broadcom/bcm63178.dtsi
diff --git a/arch/arm/boot/dts/bcm6756.dtsi b/arch/arm/boot/dts/broadcom/bcm6756.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm6756.dtsi
rename to arch/arm/boot/dts/broadcom/bcm6756.dtsi
diff --git a/arch/arm/boot/dts/bcm6846.dtsi b/arch/arm/boot/dts/broadcom/bcm6846.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm6846.dtsi
rename to arch/arm/boot/dts/broadcom/bcm6846.dtsi
diff --git a/arch/arm/boot/dts/bcm6855.dtsi b/arch/arm/boot/dts/broadcom/bcm6855.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm6855.dtsi
rename to arch/arm/boot/dts/broadcom/bcm6855.dtsi
diff --git a/arch/arm/boot/dts/bcm6878.dtsi b/arch/arm/boot/dts/broadcom/bcm6878.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm6878.dtsi
rename to arch/arm/boot/dts/broadcom/bcm6878.dtsi
diff --git a/arch/arm/boot/dts/bcm7445-bcm97445svmb.dts b/arch/arm/boot/dts/broadcom/bcm7445-bcm97445svmb.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm7445-bcm97445svmb.dts
rename to arch/arm/boot/dts/broadcom/bcm7445-bcm97445svmb.dts
diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/broadcom/bcm7445.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm7445.dtsi
rename to arch/arm/boot/dts/broadcom/bcm7445.dtsi
diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/broadcom/bcm911360_entphn.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm911360_entphn.dts
rename to arch/arm/boot/dts/broadcom/bcm911360_entphn.dts
diff --git a/arch/arm/boot/dts/bcm911360k.dts b/arch/arm/boot/dts/broadcom/bcm911360k.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm911360k.dts
rename to arch/arm/boot/dts/broadcom/bcm911360k.dts
diff --git a/arch/arm/boot/dts/bcm94708.dts b/arch/arm/boot/dts/broadcom/bcm94708.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm94708.dts
rename to arch/arm/boot/dts/broadcom/bcm94708.dts
diff --git a/arch/arm/boot/dts/bcm94709.dts b/arch/arm/boot/dts/broadcom/bcm94709.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm94709.dts
rename to arch/arm/boot/dts/broadcom/bcm94709.dts
diff --git a/arch/arm/boot/dts/bcm947189acdbmr.dts b/arch/arm/boot/dts/broadcom/bcm947189acdbmr.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm947189acdbmr.dts
rename to arch/arm/boot/dts/broadcom/bcm947189acdbmr.dts
diff --git a/arch/arm/boot/dts/bcm947622.dts b/arch/arm/boot/dts/broadcom/bcm947622.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm947622.dts
rename to arch/arm/boot/dts/broadcom/bcm947622.dts
diff --git a/arch/arm/boot/dts/bcm953012er.dts b/arch/arm/boot/dts/broadcom/bcm953012er.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm953012er.dts
rename to arch/arm/boot/dts/broadcom/bcm953012er.dts
diff --git a/arch/arm/boot/dts/bcm953012hr.dts b/arch/arm/boot/dts/broadcom/bcm953012hr.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm953012hr.dts
rename to arch/arm/boot/dts/broadcom/bcm953012hr.dts
diff --git a/arch/arm/boot/dts/bcm953012k.dts b/arch/arm/boot/dts/broadcom/bcm953012k.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm953012k.dts
rename to arch/arm/boot/dts/broadcom/bcm953012k.dts
diff --git a/arch/arm/boot/dts/bcm958300k.dts b/arch/arm/boot/dts/broadcom/bcm958300k.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958300k.dts
rename to arch/arm/boot/dts/broadcom/bcm958300k.dts
diff --git a/arch/arm/boot/dts/bcm958305k.dts b/arch/arm/boot/dts/broadcom/bcm958305k.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958305k.dts
rename to arch/arm/boot/dts/broadcom/bcm958305k.dts
diff --git a/arch/arm/boot/dts/bcm958522er.dts b/arch/arm/boot/dts/broadcom/bcm958522er.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958522er.dts
rename to arch/arm/boot/dts/broadcom/bcm958522er.dts
diff --git a/arch/arm/boot/dts/bcm958525er.dts b/arch/arm/boot/dts/broadcom/bcm958525er.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958525er.dts
rename to arch/arm/boot/dts/broadcom/bcm958525er.dts
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/broadcom/bcm958525xmc.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958525xmc.dts
rename to arch/arm/boot/dts/broadcom/bcm958525xmc.dts
diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/broadcom/bcm958622hr.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958622hr.dts
rename to arch/arm/boot/dts/broadcom/bcm958622hr.dts
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/broadcom/bcm958623hr.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958623hr.dts
rename to arch/arm/boot/dts/broadcom/bcm958623hr.dts
diff --git a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi b/arch/arm/boot/dts/broadcom/bcm958625-meraki-alamo.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
rename to arch/arm/boot/dts/broadcom/bcm958625-meraki-alamo.dtsi
diff --git a/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi b/arch/arm/boot/dts/broadcom/bcm958625-meraki-kingpin.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
rename to arch/arm/boot/dts/broadcom/bcm958625-meraki-kingpin.dtsi
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dts b/arch/arm/boot/dts/broadcom/bcm958625-meraki-mx64-a0.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dts
rename to arch/arm/boot/dts/broadcom/bcm958625-meraki-mx64-a0.dts
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx64.dts b/arch/arm/boot/dts/broadcom/bcm958625-meraki-mx64.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958625-meraki-mx64.dts
rename to arch/arm/boot/dts/broadcom/bcm958625-meraki-mx64.dts
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dts b/arch/arm/boot/dts/broadcom/bcm958625-meraki-mx64w-a0.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dts
rename to arch/arm/boot/dts/broadcom/bcm958625-meraki-mx64w-a0.dts
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx64w.dts b/arch/arm/boot/dts/broadcom/bcm958625-meraki-mx64w.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958625-meraki-mx64w.dts
rename to arch/arm/boot/dts/broadcom/bcm958625-meraki-mx64w.dts
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx65.dts b/arch/arm/boot/dts/broadcom/bcm958625-meraki-mx65.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958625-meraki-mx65.dts
rename to arch/arm/boot/dts/broadcom/bcm958625-meraki-mx65.dts
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx65w.dts b/arch/arm/boot/dts/broadcom/bcm958625-meraki-mx65w.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958625-meraki-mx65w.dts
rename to arch/arm/boot/dts/broadcom/bcm958625-meraki-mx65w.dts
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi b/arch/arm/boot/dts/broadcom/bcm958625-meraki-mx6x-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
rename to arch/arm/boot/dts/broadcom/bcm958625-meraki-mx6x-common.dtsi
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958625hr.dts
rename to arch/arm/boot/dts/broadcom/bcm958625hr.dts
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/broadcom/bcm958625k.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm958625k.dts
rename to arch/arm/boot/dts/broadcom/bcm958625k.dts
diff --git a/arch/arm/boot/dts/bcm963138.dts b/arch/arm/boot/dts/broadcom/bcm963138.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm963138.dts
rename to arch/arm/boot/dts/broadcom/bcm963138.dts
diff --git a/arch/arm/boot/dts/bcm963138dvt.dts b/arch/arm/boot/dts/broadcom/bcm963138dvt.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm963138dvt.dts
rename to arch/arm/boot/dts/broadcom/bcm963138dvt.dts
diff --git a/arch/arm/boot/dts/bcm963148.dts b/arch/arm/boot/dts/broadcom/bcm963148.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm963148.dts
rename to arch/arm/boot/dts/broadcom/bcm963148.dts
diff --git a/arch/arm/boot/dts/bcm963178.dts b/arch/arm/boot/dts/broadcom/bcm963178.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm963178.dts
rename to arch/arm/boot/dts/broadcom/bcm963178.dts
diff --git a/arch/arm/boot/dts/bcm96756.dts b/arch/arm/boot/dts/broadcom/bcm96756.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm96756.dts
rename to arch/arm/boot/dts/broadcom/bcm96756.dts
diff --git a/arch/arm/boot/dts/bcm96846.dts b/arch/arm/boot/dts/broadcom/bcm96846.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm96846.dts
rename to arch/arm/boot/dts/broadcom/bcm96846.dts
diff --git a/arch/arm/boot/dts/bcm96855.dts b/arch/arm/boot/dts/broadcom/bcm96855.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm96855.dts
rename to arch/arm/boot/dts/broadcom/bcm96855.dts
diff --git a/arch/arm/boot/dts/bcm96878.dts b/arch/arm/boot/dts/broadcom/bcm96878.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm96878.dts
rename to arch/arm/boot/dts/broadcom/bcm96878.dts
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/broadcom/bcm988312hr.dts
similarity index 100%
rename from arch/arm/boot/dts/bcm988312hr.dts
rename to arch/arm/boot/dts/broadcom/bcm988312hr.dts
diff --git a/arch/arm/boot/dts/bcm9hmidc.dtsi b/arch/arm/boot/dts/broadcom/bcm9hmidc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/bcm9hmidc.dtsi
rename to arch/arm/boot/dts/broadcom/bcm9hmidc.dtsi
diff --git a/arch/arm/boot/dts/calxeda/Makefile b/arch/arm/boot/dts/calxeda/Makefile
new file mode 100644
index 000000000000..5ae145da003e
--- /dev/null
+++ b/arch/arm/boot/dts/calxeda/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_HIGHBANK) += \
+	highbank.dtb \
+	ecx-2000.dtb
diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/calxeda/ecx-2000.dts
similarity index 100%
rename from arch/arm/boot/dts/ecx-2000.dts
rename to arch/arm/boot/dts/calxeda/ecx-2000.dts
diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/calxeda/ecx-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ecx-common.dtsi
rename to arch/arm/boot/dts/calxeda/ecx-common.dtsi
diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/calxeda/highbank.dts
similarity index 100%
rename from arch/arm/boot/dts/highbank.dts
rename to arch/arm/boot/dts/calxeda/highbank.dts
diff --git a/arch/arm/boot/dts/cirrus/Makefile b/arch/arm/boot/dts/cirrus/Makefile
new file mode 100644
index 000000000000..1dabbeb08210
--- /dev/null
+++ b/arch/arm/boot/dts/cirrus/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_CLPS711X) += \
+	ep7211-edb7211.dtb
diff --git a/arch/arm/boot/dts/ep7209.dtsi b/arch/arm/boot/dts/cirrus/ep7209.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ep7209.dtsi
rename to arch/arm/boot/dts/cirrus/ep7209.dtsi
diff --git a/arch/arm/boot/dts/ep7211-edb7211.dts b/arch/arm/boot/dts/cirrus/ep7211-edb7211.dts
similarity index 100%
rename from arch/arm/boot/dts/ep7211-edb7211.dts
rename to arch/arm/boot/dts/cirrus/ep7211-edb7211.dts
diff --git a/arch/arm/boot/dts/ep7211.dtsi b/arch/arm/boot/dts/cirrus/ep7211.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ep7211.dtsi
rename to arch/arm/boot/dts/cirrus/ep7211.dtsi
diff --git a/arch/arm/boot/dts/cnxt/Makefile b/arch/arm/boot/dts/cnxt/Makefile
new file mode 100644
index 000000000000..2771cefd1b3c
--- /dev/null
+++ b/arch/arm/boot/dts/cnxt/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_DIGICOLOR) += \
+	cx92755_equinox.dtb
diff --git a/arch/arm/boot/dts/cx92755.dtsi b/arch/arm/boot/dts/cnxt/cx92755.dtsi
similarity index 100%
rename from arch/arm/boot/dts/cx92755.dtsi
rename to arch/arm/boot/dts/cnxt/cx92755.dtsi
diff --git a/arch/arm/boot/dts/cx92755_equinox.dts b/arch/arm/boot/dts/cnxt/cx92755_equinox.dts
similarity index 100%
rename from arch/arm/boot/dts/cx92755_equinox.dts
rename to arch/arm/boot/dts/cnxt/cx92755_equinox.dts
diff --git a/arch/arm/boot/dts/gemini/Makefile b/arch/arm/boot/dts/gemini/Makefile
new file mode 100644
index 000000000000..f9f63ce3eb49
--- /dev/null
+++ b/arch/arm/boot/dts/gemini/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_GEMINI) += \
+	gemini-dlink-dir-685.dtb \
+	gemini-dlink-dns-313.dtb \
+	gemini-nas4220b.dtb \
+	gemini-ns2502.dtb \
+	gemini-rut1xx.dtb \
+	gemini-sl93512r.dtb \
+	gemini-sq201.dtb \
+	gemini-ssi1328.dtb \
+	gemini-wbd111.dtb \
+	gemini-wbd222.dtb
diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts
similarity index 100%
rename from arch/arm/boot/dts/gemini-dlink-dir-685.dts
rename to arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts
diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini/gemini-dlink-dns-313.dts
similarity index 100%
rename from arch/arm/boot/dts/gemini-dlink-dns-313.dts
rename to arch/arm/boot/dts/gemini/gemini-dlink-dns-313.dts
diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini/gemini-nas4220b.dts
similarity index 100%
rename from arch/arm/boot/dts/gemini-nas4220b.dts
rename to arch/arm/boot/dts/gemini/gemini-nas4220b.dts
diff --git a/arch/arm/boot/dts/gemini-ns2502.dts b/arch/arm/boot/dts/gemini/gemini-ns2502.dts
similarity index 100%
rename from arch/arm/boot/dts/gemini-ns2502.dts
rename to arch/arm/boot/dts/gemini/gemini-ns2502.dts
diff --git a/arch/arm/boot/dts/gemini-rut1xx.dts b/arch/arm/boot/dts/gemini/gemini-rut1xx.dts
similarity index 100%
rename from arch/arm/boot/dts/gemini-rut1xx.dts
rename to arch/arm/boot/dts/gemini/gemini-rut1xx.dts
diff --git a/arch/arm/boot/dts/gemini-sl93512r.dts b/arch/arm/boot/dts/gemini/gemini-sl93512r.dts
similarity index 100%
rename from arch/arm/boot/dts/gemini-sl93512r.dts
rename to arch/arm/boot/dts/gemini/gemini-sl93512r.dts
diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini/gemini-sq201.dts
similarity index 100%
rename from arch/arm/boot/dts/gemini-sq201.dts
rename to arch/arm/boot/dts/gemini/gemini-sq201.dts
diff --git a/arch/arm/boot/dts/gemini-ssi1328.dts b/arch/arm/boot/dts/gemini/gemini-ssi1328.dts
similarity index 100%
rename from arch/arm/boot/dts/gemini-ssi1328.dts
rename to arch/arm/boot/dts/gemini/gemini-ssi1328.dts
diff --git a/arch/arm/boot/dts/gemini-wbd111.dts b/arch/arm/boot/dts/gemini/gemini-wbd111.dts
similarity index 100%
rename from arch/arm/boot/dts/gemini-wbd111.dts
rename to arch/arm/boot/dts/gemini/gemini-wbd111.dts
diff --git a/arch/arm/boot/dts/gemini-wbd222.dts b/arch/arm/boot/dts/gemini/gemini-wbd222.dts
similarity index 100%
rename from arch/arm/boot/dts/gemini-wbd222.dts
rename to arch/arm/boot/dts/gemini/gemini-wbd222.dts
diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini/gemini.dtsi
similarity index 100%
rename from arch/arm/boot/dts/gemini.dtsi
rename to arch/arm/boot/dts/gemini/gemini.dtsi
diff --git a/arch/arm/boot/dts/hisilicon/Makefile b/arch/arm/boot/dts/hisilicon/Makefile
new file mode 100644
index 000000000000..5ce0512c0010
--- /dev/null
+++ b/arch/arm/boot/dts/hisilicon/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_HI3xxx) += \
+	hi3620-hi4511.dtb
+dtb-$(CONFIG_ARCH_HIP01) += \
+	hip01-ca9x2.dtb
+dtb-$(CONFIG_ARCH_HIP04) += \
+	hip04-d01.dtb
+dtb-$(CONFIG_ARCH_HISI) += \
+	hi3519-demb.dtb
+dtb-$(CONFIG_ARCH_HIX5HD2) += \
+	hisi-x5hd2-dkb.dtb
+dtb-$(CONFIG_ARCH_SD5203) += \
+	sd5203.dtb
diff --git a/arch/arm/boot/dts/hi3519-demb.dts b/arch/arm/boot/dts/hisilicon/hi3519-demb.dts
similarity index 100%
rename from arch/arm/boot/dts/hi3519-demb.dts
rename to arch/arm/boot/dts/hisilicon/hi3519-demb.dts
diff --git a/arch/arm/boot/dts/hi3519.dtsi b/arch/arm/boot/dts/hisilicon/hi3519.dtsi
similarity index 100%
rename from arch/arm/boot/dts/hi3519.dtsi
rename to arch/arm/boot/dts/hisilicon/hi3519.dtsi
diff --git a/arch/arm/boot/dts/hi3620-hi4511.dts b/arch/arm/boot/dts/hisilicon/hi3620-hi4511.dts
similarity index 100%
rename from arch/arm/boot/dts/hi3620-hi4511.dts
rename to arch/arm/boot/dts/hisilicon/hi3620-hi4511.dts
diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hisilicon/hi3620.dtsi
similarity index 100%
rename from arch/arm/boot/dts/hi3620.dtsi
rename to arch/arm/boot/dts/hisilicon/hi3620.dtsi
diff --git a/arch/arm/boot/dts/hip01-ca9x2.dts b/arch/arm/boot/dts/hisilicon/hip01-ca9x2.dts
similarity index 100%
rename from arch/arm/boot/dts/hip01-ca9x2.dts
rename to arch/arm/boot/dts/hisilicon/hip01-ca9x2.dts
diff --git a/arch/arm/boot/dts/hip01.dtsi b/arch/arm/boot/dts/hisilicon/hip01.dtsi
similarity index 100%
rename from arch/arm/boot/dts/hip01.dtsi
rename to arch/arm/boot/dts/hisilicon/hip01.dtsi
diff --git a/arch/arm/boot/dts/hip04-d01.dts b/arch/arm/boot/dts/hisilicon/hip04-d01.dts
similarity index 100%
rename from arch/arm/boot/dts/hip04-d01.dts
rename to arch/arm/boot/dts/hisilicon/hip04-d01.dts
diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hisilicon/hip04.dtsi
similarity index 100%
rename from arch/arm/boot/dts/hip04.dtsi
rename to arch/arm/boot/dts/hisilicon/hip04.dtsi
diff --git a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts b/arch/arm/boot/dts/hisilicon/hisi-x5hd2-dkb.dts
similarity index 100%
rename from arch/arm/boot/dts/hisi-x5hd2-dkb.dts
rename to arch/arm/boot/dts/hisilicon/hisi-x5hd2-dkb.dts
diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisilicon/hisi-x5hd2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/hisi-x5hd2.dtsi
rename to arch/arm/boot/dts/hisilicon/hisi-x5hd2.dtsi
diff --git a/arch/arm/boot/dts/sd5203.dts b/arch/arm/boot/dts/hisilicon/sd5203.dts
similarity index 100%
rename from arch/arm/boot/dts/sd5203.dts
rename to arch/arm/boot/dts/hisilicon/sd5203.dts
diff --git a/arch/arm/boot/dts/hpe/Makefile b/arch/arm/boot/dts/hpe/Makefile
new file mode 100644
index 000000000000..e175b1732cdb
--- /dev/null
+++ b/arch/arm/boot/dts/hpe/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_HPE_GXP) += \
+	hpe-bmc-dl360gen10.dtb
diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts b/arch/arm/boot/dts/hpe/hpe-bmc-dl360gen10.dts
similarity index 100%
rename from arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
rename to arch/arm/boot/dts/hpe/hpe-bmc-dl360gen10.dts
diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe/hpe-gxp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/hpe-gxp.dtsi
rename to arch/arm/boot/dts/hpe/hpe-gxp.dtsi
diff --git a/arch/arm/boot/dts/intel/Makefile b/arch/arm/boot/dts/intel/Makefile
new file mode 100644
index 000000000000..c5fc845deb61
--- /dev/null
+++ b/arch/arm/boot/dts/intel/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+subdir-y += axm
+subdir-y += ixp
+subdir-y += pxa
+subdir-y += socfpga
diff --git a/arch/arm/boot/dts/intel/axm/Makefile b/arch/arm/boot/dts/intel/axm/Makefile
new file mode 100644
index 000000000000..b6cdf55857aa
--- /dev/null
+++ b/arch/arm/boot/dts/intel/axm/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_AXXIA) += \
+	axm5516-amarillo.dtb
diff --git a/arch/arm/boot/dts/axm5516-amarillo.dts b/arch/arm/boot/dts/intel/axm/axm5516-amarillo.dts
similarity index 100%
rename from arch/arm/boot/dts/axm5516-amarillo.dts
rename to arch/arm/boot/dts/intel/axm/axm5516-amarillo.dts
diff --git a/arch/arm/boot/dts/axm5516-cpus.dtsi b/arch/arm/boot/dts/intel/axm/axm5516-cpus.dtsi
similarity index 100%
rename from arch/arm/boot/dts/axm5516-cpus.dtsi
rename to arch/arm/boot/dts/intel/axm/axm5516-cpus.dtsi
diff --git a/arch/arm/boot/dts/axm55xx.dtsi b/arch/arm/boot/dts/intel/axm/axm55xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/axm55xx.dtsi
rename to arch/arm/boot/dts/intel/axm/axm55xx.dtsi
diff --git a/arch/arm/boot/dts/intel/ixp/Makefile b/arch/arm/boot/dts/intel/ixp/Makefile
new file mode 100644
index 000000000000..1a25ce3cf84f
--- /dev/null
+++ b/arch/arm/boot/dts/intel/ixp/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_IXP4XX) += \
+	intel-ixp42x-linksys-nslu2.dtb \
+	intel-ixp42x-linksys-wrv54g.dtb \
+	intel-ixp42x-freecom-fsg-3.dtb \
+	intel-ixp42x-welltech-epbx100.dtb \
+	intel-ixp42x-ixdp425.dtb \
+	intel-ixp43x-kixrp435.dtb \
+	intel-ixp46x-ixdp465.dtb \
+	intel-ixp42x-adi-coyote.dtb \
+	intel-ixp42x-ixdpg425.dtb \
+	intel-ixp42x-goramo-multilink.dtb \
+	intel-ixp42x-iomega-nas100d.dtb \
+	intel-ixp42x-dlink-dsm-g600.dtb \
+	intel-ixp42x-gateworks-gw2348.dtb \
+	intel-ixp43x-gateworks-gw2358.dtb \
+	intel-ixp42x-netgear-wg302v1.dtb \
+	intel-ixp42x-arcom-vulcan.dtb \
+	intel-ixp42x-gateway-7001.dtb
diff --git a/arch/arm/boot/dts/intel-ixp42x-adi-coyote.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-adi-coyote.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-adi-coyote.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-adi-coyote.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-arcom-vulcan.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-arcom-vulcan.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x-dlink-dsm-g600.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-dlink-dsm-g600.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-dlink-dsm-g600.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-dlink-dsm-g600.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x-freecom-fsg-3.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-freecom-fsg-3.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-freecom-fsg-3.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-freecom-fsg-3.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x-gateway-7001.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-gateway-7001.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x-gateworks-gw2348.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateworks-gw2348.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-gateworks-gw2348.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateworks-gw2348.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x-goramo-multilink.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-goramo-multilink.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x-iomega-nas100d.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-iomega-nas100d.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-iomega-nas100d.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-iomega-nas100d.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x-ixdp425.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-ixdp425.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-ixdp425.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-ixdp425.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x-ixdpg425.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-ixdpg425.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-ixdpg425.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-ixdpg425.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-nslu2.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-nslu2.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x-linksys-wrv54g.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-linksys-wrv54g.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x-netgear-wg302v1.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-netgear-wg302v1.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-netgear-wg302v1.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-netgear-wg302v1.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-welltech-epbx100.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x-welltech-epbx100.dts
diff --git a/arch/arm/boot/dts/intel-ixp42x.dtsi b/arch/arm/boot/dts/intel/ixp/intel-ixp42x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp42x.dtsi
rename to arch/arm/boot/dts/intel/ixp/intel-ixp42x.dtsi
diff --git a/arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp43x-gateworks-gw2358.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp43x-gateworks-gw2358.dts
diff --git a/arch/arm/boot/dts/intel-ixp43x-kixrp435.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp43x-kixrp435.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp43x-kixrp435.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp43x-kixrp435.dts
diff --git a/arch/arm/boot/dts/intel-ixp43x.dtsi b/arch/arm/boot/dts/intel/ixp/intel-ixp43x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp43x.dtsi
rename to arch/arm/boot/dts/intel/ixp/intel-ixp43x.dtsi
diff --git a/arch/arm/boot/dts/intel-ixp45x-ixp46x.dtsi b/arch/arm/boot/dts/intel/ixp/intel-ixp45x-ixp46x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp45x-ixp46x.dtsi
rename to arch/arm/boot/dts/intel/ixp/intel-ixp45x-ixp46x.dtsi
diff --git a/arch/arm/boot/dts/intel-ixp46x-ixdp465.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp46x-ixdp465.dts
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp46x-ixdp465.dts
rename to arch/arm/boot/dts/intel/ixp/intel-ixp46x-ixdp465.dts
diff --git a/arch/arm/boot/dts/intel-ixp4xx-reference-design.dtsi b/arch/arm/boot/dts/intel/ixp/intel-ixp4xx-reference-design.dtsi
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp4xx-reference-design.dtsi
rename to arch/arm/boot/dts/intel/ixp/intel-ixp4xx-reference-design.dtsi
diff --git a/arch/arm/boot/dts/intel-ixp4xx.dtsi b/arch/arm/boot/dts/intel/ixp/intel-ixp4xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/intel-ixp4xx.dtsi
rename to arch/arm/boot/dts/intel/ixp/intel-ixp4xx.dtsi
diff --git a/arch/arm/boot/dts/intel/pxa/Makefile b/arch/arm/boot/dts/intel/pxa/Makefile
new file mode 100644
index 000000000000..24d5240f08e7
--- /dev/null
+++ b/arch/arm/boot/dts/intel/pxa/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_PXA) += \
+	pxa300-raumfeld-connector.dtb \
+	pxa300-raumfeld-controller.dtb \
+	pxa300-raumfeld-speaker-l.dtb \
+	pxa300-raumfeld-speaker-m.dtb \
+	pxa300-raumfeld-speaker-one.dtb \
+	pxa300-raumfeld-speaker-s.dtb
diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/intel/pxa/pxa25x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/pxa25x.dtsi
rename to arch/arm/boot/dts/intel/pxa/pxa25x.dtsi
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/intel/pxa/pxa27x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/pxa27x.dtsi
rename to arch/arm/boot/dts/intel/pxa/pxa27x.dtsi
diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/intel/pxa/pxa2xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/pxa2xx.dtsi
rename to arch/arm/boot/dts/intel/pxa/pxa2xx.dtsi
diff --git a/arch/arm/boot/dts/pxa300-raumfeld-common.dtsi b/arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/pxa300-raumfeld-common.dtsi
rename to arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-common.dtsi
diff --git a/arch/arm/boot/dts/pxa300-raumfeld-connector.dts b/arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-connector.dts
similarity index 100%
rename from arch/arm/boot/dts/pxa300-raumfeld-connector.dts
rename to arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-connector.dts
diff --git a/arch/arm/boot/dts/pxa300-raumfeld-controller.dts b/arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-controller.dts
similarity index 100%
rename from arch/arm/boot/dts/pxa300-raumfeld-controller.dts
rename to arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-controller.dts
diff --git a/arch/arm/boot/dts/pxa300-raumfeld-speaker-l.dts b/arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-speaker-l.dts
similarity index 100%
rename from arch/arm/boot/dts/pxa300-raumfeld-speaker-l.dts
rename to arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-speaker-l.dts
diff --git a/arch/arm/boot/dts/pxa300-raumfeld-speaker-m.dts b/arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-speaker-m.dts
similarity index 100%
rename from arch/arm/boot/dts/pxa300-raumfeld-speaker-m.dts
rename to arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-speaker-m.dts
diff --git a/arch/arm/boot/dts/pxa300-raumfeld-speaker-one.dts b/arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-speaker-one.dts
similarity index 100%
rename from arch/arm/boot/dts/pxa300-raumfeld-speaker-one.dts
rename to arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-speaker-one.dts
diff --git a/arch/arm/boot/dts/pxa300-raumfeld-speaker-s.dts b/arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-speaker-s.dts
similarity index 100%
rename from arch/arm/boot/dts/pxa300-raumfeld-speaker-s.dts
rename to arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-speaker-s.dts
diff --git a/arch/arm/boot/dts/pxa300-raumfeld-tuneable-clock.dtsi b/arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-tuneable-clock.dtsi
similarity index 100%
rename from arch/arm/boot/dts/pxa300-raumfeld-tuneable-clock.dtsi
rename to arch/arm/boot/dts/intel/pxa/pxa300-raumfeld-tuneable-clock.dtsi
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/intel/pxa/pxa3xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/pxa3xx.dtsi
rename to arch/arm/boot/dts/intel/pxa/pxa3xx.dtsi
diff --git a/arch/arm/boot/dts/intel/socfpga/Makefile b/arch/arm/boot/dts/intel/socfpga/Makefile
new file mode 100644
index 000000000000..c467828aeb4b
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
+	socfpga_arria5_socdk.dtb \
+	socfpga_arria10_chameleonv3.dtb \
+	socfpga_arria10_mercury_pe1.dtb \
+	socfpga_arria10_socdk_nand.dtb \
+	socfpga_arria10_socdk_qspi.dtb \
+	socfpga_arria10_socdk_sdmmc.dtb \
+	socfpga_cyclone5_chameleon96.dtb \
+	socfpga_cyclone5_mcvevk.dtb \
+	socfpga_cyclone5_socdk.dtb \
+	socfpga_cyclone5_de0_nano_soc.dtb \
+	socfpga_cyclone5_sockit.dtb \
+	socfpga_cyclone5_socrates.dtb \
+	socfpga_cyclone5_sodia.dtb \
+	socfpga_cyclone5_vining_fpga.dtb \
+	socfpga_vt.dtb
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
similarity index 100%
rename from arch/arm/boot/dts/socfpga.dtsi
rename to arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
similarity index 100%
rename from arch/arm/boot/dts/socfpga_arria10.dtsi
rename to arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
diff --git a/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
diff --git a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
rename to arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi
diff --git a/arch/arm/boot/dts/socfpga_arria10_mercury_pe1.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_arria10_mercury_pe1.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_socdk.dtsi
similarity index 100%
rename from arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
rename to arch/arm/boot/dts/intel/socfpga/socfpga_arria10_socdk.dtsi
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_socdk_nand.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_arria10_socdk_nand.dts
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_socdk_qspi.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_arria10_socdk_qspi.dts
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_socdk_sdmmc.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_arria10_socdk_sdmmc.dts
diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria5.dtsi
similarity index 100%
rename from arch/arm/boot/dts/socfpga_arria5.dtsi
rename to arch/arm/boot/dts/intel/socfpga/socfpga_arria5.dtsi
diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria5_socdk.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_arria5_socdk.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_arria5_socdk.dts
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5.dtsi
similarity index 100%
rename from arch/arm/boot/dts/socfpga_cyclone5.dtsi
rename to arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5.dtsi
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_chameleon96.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_chameleon96.dts
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_de0_nano_soc.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_de0_nano_soc.dts
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mcv.dtsi
similarity index 100%
rename from arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
rename to arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mcv.dtsi
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mcvevk.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mcvevk.dts
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_socdk.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_socdk.dts
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sockit.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sockit.dts
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_socrates.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_socrates.dts
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_vining_fpga.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_vining_fpga.dts
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_vt.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_vt.dts
rename to arch/arm/boot/dts/intel/socfpga/socfpga_vt.dts
diff --git a/arch/arm/boot/dts/marvell/Makefile b/arch/arm/boot/dts/marvell/Makefile
new file mode 100644
index 000000000000..6247b9a53d67
--- /dev/null
+++ b/arch/arm/boot/dts/marvell/Makefile
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_MMP) += \
+	pxa168-aspenite.dtb \
+	pxa910-dkb.dtb \
+	mmp2-brownstone.dtb \
+	mmp2-olpc-xo-1-75.dtb \
+	mmp3-dell-ariel.dtb
+dtb-$(CONFIG_ARCH_ORION5X) += \
+	orion5x-kuroboxpro.dtb \
+	orion5x-lacie-d2-network.dtb \
+	orion5x-lacie-ethernet-disk-mini-v2.dtb \
+	orion5x-linkstation-lsgl.dtb \
+	orion5x-linkstation-lswtgl.dtb \
+	orion5x-linkstation-lschl.dtb \
+	orion5x-lswsgl.dtb \
+	orion5x-maxtor-shared-storage-2.dtb \
+	orion5x-netgear-wnr854t.dtb \
+	orion5x-rd88f5182-nas.dtb
+dtb-$(CONFIG_MACH_ARMADA_370) += \
+	armada-370-c200-v2.dtb \
+	armada-370-db.dtb \
+	armada-370-dlink-dns327l.dtb \
+	armada-370-mirabox.dtb \
+	armada-370-netgear-rn102.dtb \
+	armada-370-netgear-rn104.dtb \
+	armada-370-rd.dtb \
+	armada-370-seagate-nas-2bay.dtb \
+	armada-370-seagate-nas-4bay.dtb \
+	armada-370-seagate-personal-cloud.dtb \
+	armada-370-seagate-personal-cloud-2bay.dtb \
+	armada-370-synology-ds213j.dtb
+dtb-$(CONFIG_MACH_ARMADA_375) += \
+	armada-375-db.dtb
+dtb-$(CONFIG_MACH_ARMADA_38X) += \
+	armada-381-netgear-gs110emx.dtb \
+	armada-382-rd-ac3x-48g4x2xl.dtb \
+	armada-385-atl-x530.dtb\
+	armada-385-clearfog-gtr-s4.dtb \
+	armada-385-clearfog-gtr-l8.dtb \
+	armada-385-db-88f6820-amc.dtb \
+	armada-385-db-ap.dtb \
+	armada-385-linksys-caiman.dtb \
+	armada-385-linksys-cobra.dtb \
+	armada-385-linksys-rango.dtb \
+	armada-385-linksys-shelby.dtb \
+	armada-385-synology-ds116.dtb \
+	armada-385-turris-omnia.dtb \
+	armada-388-clearfog.dtb \
+	armada-388-clearfog-base.dtb \
+	armada-388-clearfog-pro.dtb \
+	armada-388-db.dtb \
+	armada-388-gp.dtb \
+	armada-388-helios4.dtb \
+	armada-388-rd.dtb
+dtb-$(CONFIG_MACH_ARMADA_39X) += \
+	armada-390-db.dtb \
+	armada-395-gp.dtb \
+	armada-398-db.dtb
+dtb-$(CONFIG_MACH_ARMADA_XP) += \
+	armada-xp-axpwifiap.dtb \
+	armada-xp-crs305-1g-4s.dtb \
+	armada-xp-crs305-1g-4s-bit.dtb \
+	armada-xp-crs326-24g-2s.dtb \
+	armada-xp-crs326-24g-2s-bit.dtb \
+	armada-xp-crs328-4c-20s-4s.dtb \
+	armada-xp-crs328-4c-20s-4s-bit.dtb \
+	armada-xp-db.dtb \
+	armada-xp-db-dxbc2.dtb \
+	armada-xp-db-xc3-24g4xg.dtb \
+	armada-xp-gp.dtb \
+	armada-xp-lenovo-ix4-300d.dtb \
+	armada-xp-linksys-mamba.dtb \
+	armada-xp-matrix.dtb \
+	armada-xp-netgear-rn2120.dtb \
+	armada-xp-openblocks-ax3-4.dtb \
+	armada-xp-synology-ds414.dtb
+dtb-$(CONFIG_MACH_DOVE) += \
+	dove-cubox.dtb \
+	dove-cubox-es.dtb \
+	dove-d2plug.dtb \
+	dove-d3plug.dtb \
+	dove-dove-db.dtb \
+	dove-sbc-a510.dtb
+dtb-$(CONFIG_MACH_KIRKWOOD) += \
+	kirkwood-b3.dtb \
+	kirkwood-blackarmor-nas220.dtb \
+	kirkwood-c200-v1.dtb \
+	kirkwood-cloudbox.dtb \
+	kirkwood-d2net.dtb \
+	kirkwood-db-88f6281.dtb \
+	kirkwood-db-88f6282.dtb \
+	kirkwood-dir665.dtb \
+	kirkwood-dns320.dtb \
+	kirkwood-dns325.dtb \
+	kirkwood-dockstar.dtb \
+	kirkwood-dreamplug.dtb \
+	kirkwood-ds109.dtb \
+	kirkwood-ds110jv10.dtb \
+	kirkwood-ds111.dtb \
+	kirkwood-ds112.dtb \
+	kirkwood-ds209.dtb \
+	kirkwood-ds210.dtb \
+	kirkwood-ds212.dtb \
+	kirkwood-ds212j.dtb \
+	kirkwood-ds409.dtb \
+	kirkwood-ds409slim.dtb \
+	kirkwood-ds411.dtb \
+	kirkwood-ds411j.dtb \
+	kirkwood-ds411slim.dtb \
+	kirkwood-goflexnet.dtb \
+	kirkwood-guruplug-server-plus.dtb \
+	kirkwood-ib62x0.dtb \
+	kirkwood-iconnect.dtb \
+	kirkwood-iomega_ix2_200.dtb \
+	kirkwood-is2.dtb \
+	kirkwood-km_fixedeth.dtb \
+	kirkwood-km_kirkwood.dtb \
+	kirkwood-l-50.dtb \
+	kirkwood-laplug.dtb \
+	kirkwood-linkstation-lsqvl.dtb \
+	kirkwood-linkstation-lsvl.dtb \
+	kirkwood-linkstation-lswsxl.dtb \
+	kirkwood-linkstation-lswvl.dtb \
+	kirkwood-linkstation-lswxl.dtb \
+	kirkwood-linksys-viper.dtb \
+	kirkwood-lschlv2.dtb \
+	kirkwood-lsxhl.dtb \
+	kirkwood-mplcec4.dtb \
+	kirkwood-mv88f6281gtw-ge.dtb \
+	kirkwood-nas2big.dtb \
+	kirkwood-net2big.dtb \
+	kirkwood-net5big.dtb \
+	kirkwood-netgear_readynas_duo_v2.dtb \
+	kirkwood-netgear_readynas_nv+_v2.dtb \
+	kirkwood-ns2.dtb \
+	kirkwood-ns2lite.dtb \
+	kirkwood-ns2max.dtb \
+	kirkwood-ns2mini.dtb \
+	kirkwood-nsa310.dtb \
+	kirkwood-nsa310a.dtb \
+	kirkwood-nsa310s.dtb \
+	kirkwood-nsa320.dtb \
+	kirkwood-nsa325.dtb \
+	kirkwood-openblocks_a6.dtb \
+	kirkwood-openblocks_a7.dtb \
+	kirkwood-openrd-base.dtb \
+	kirkwood-openrd-client.dtb \
+	kirkwood-openrd-ultimate.dtb \
+	kirkwood-pogo_e02.dtb \
+	kirkwood-pogoplug-series-4.dtb \
+	kirkwood-rd88f6192.dtb \
+	kirkwood-rd88f6281-z0.dtb \
+	kirkwood-rd88f6281-a.dtb \
+	kirkwood-rs212.dtb \
+	kirkwood-rs409.dtb \
+	kirkwood-rs411.dtb \
+	kirkwood-sheevaplug.dtb \
+	kirkwood-sheevaplug-esata.dtb \
+	kirkwood-t5325.dtb \
+	kirkwood-topkick.dtb \
+	kirkwood-ts219-6281.dtb \
+	kirkwood-ts219-6282.dtb \
+	kirkwood-ts419-6281.dtb \
+	kirkwood-ts419-6282.dtb
diff --git a/arch/arm/boot/dts/armada-370-c200-v2.dts b/arch/arm/boot/dts/marvell/armada-370-c200-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-370-c200-v2.dts
rename to arch/arm/boot/dts/marvell/armada-370-c200-v2.dts
diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/marvell/armada-370-db.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-370-db.dts
rename to arch/arm/boot/dts/marvell/armada-370-db.dts
diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/marvell/armada-370-dlink-dns327l.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-370-dlink-dns327l.dts
rename to arch/arm/boot/dts/marvell/armada-370-dlink-dns327l.dts
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/marvell/armada-370-mirabox.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-370-mirabox.dts
rename to arch/arm/boot/dts/marvell/armada-370-mirabox.dts
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/marvell/armada-370-netgear-rn102.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-370-netgear-rn102.dts
rename to arch/arm/boot/dts/marvell/armada-370-netgear-rn102.dts
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/marvell/armada-370-netgear-rn104.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-370-netgear-rn104.dts
rename to arch/arm/boot/dts/marvell/armada-370-netgear-rn104.dts
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/marvell/armada-370-rd.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-370-rd.dts
rename to arch/arm/boot/dts/marvell/armada-370-rd.dts
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-2bay.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts
rename to arch/arm/boot/dts/marvell/armada-370-seagate-nas-2bay.dts
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
rename to arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-xbay.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
rename to arch/arm/boot/dts/marvell/armada-370-seagate-nas-xbay.dtsi
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts b/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud-2bay.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
rename to arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud-2bay.dts
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts b/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
rename to arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud.dts
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
rename to arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud.dtsi
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-370-synology-ds213j.dts
rename to arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/marvell/armada-370-xp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-370-xp.dtsi
rename to arch/arm/boot/dts/marvell/armada-370-xp.dtsi
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/marvell/armada-370.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-370.dtsi
rename to arch/arm/boot/dts/marvell/armada-370.dtsi
diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/marvell/armada-375-db.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-375-db.dts
rename to arch/arm/boot/dts/marvell/armada-375-db.dts
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/marvell/armada-375.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-375.dtsi
rename to arch/arm/boot/dts/marvell/armada-375.dtsi
diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/marvell/armada-380.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-380.dtsi
rename to arch/arm/boot/dts/marvell/armada-380.dtsi
diff --git a/arch/arm/boot/dts/armada-381-netgear-gs110emx.dts b/arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-381-netgear-gs110emx.dts
rename to arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts
diff --git a/arch/arm/boot/dts/armada-382-rd-ac3x-48g4x2xl.dts b/arch/arm/boot/dts/marvell/armada-382-rd-ac3x-48g4x2xl.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-382-rd-ac3x-48g4x2xl.dts
rename to arch/arm/boot/dts/marvell/armada-382-rd-ac3x-48g4x2xl.dts
diff --git a/arch/arm/boot/dts/armada-385-atl-x530.dts b/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-385-atl-x530.dts
rename to arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
diff --git a/arch/arm/boot/dts/armada-385-clearfog-gtr-l8.dts b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-385-clearfog-gtr-l8.dts
rename to arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
diff --git a/arch/arm/boot/dts/armada-385-clearfog-gtr-s4.dts b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-385-clearfog-gtr-s4.dts
rename to arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
diff --git a/arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi
rename to arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
diff --git a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts b/arch/arm/boot/dts/marvell/armada-385-db-88f6820-amc.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
rename to arch/arm/boot/dts/marvell/armada-385-db-88f6820-amc.dts
diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/marvell/armada-385-db-ap.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-385-db-ap.dts
rename to arch/arm/boot/dts/marvell/armada-385-db-ap.dts
diff --git a/arch/arm/boot/dts/armada-385-linksys-caiman.dts b/arch/arm/boot/dts/marvell/armada-385-linksys-caiman.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-385-linksys-caiman.dts
rename to arch/arm/boot/dts/marvell/armada-385-linksys-caiman.dts
diff --git a/arch/arm/boot/dts/armada-385-linksys-cobra.dts b/arch/arm/boot/dts/marvell/armada-385-linksys-cobra.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-385-linksys-cobra.dts
rename to arch/arm/boot/dts/marvell/armada-385-linksys-cobra.dts
diff --git a/arch/arm/boot/dts/armada-385-linksys-rango.dts b/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-385-linksys-rango.dts
rename to arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts
diff --git a/arch/arm/boot/dts/armada-385-linksys-shelby.dts b/arch/arm/boot/dts/marvell/armada-385-linksys-shelby.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-385-linksys-shelby.dts
rename to arch/arm/boot/dts/marvell/armada-385-linksys-shelby.dts
diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/marvell/armada-385-linksys.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-385-linksys.dtsi
rename to arch/arm/boot/dts/marvell/armada-385-linksys.dtsi
diff --git a/arch/arm/boot/dts/armada-385-synology-ds116.dts b/arch/arm/boot/dts/marvell/armada-385-synology-ds116.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-385-synology-ds116.dts
rename to arch/arm/boot/dts/marvell/armada-385-synology-ds116.dts
diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-385-turris-omnia.dts
rename to arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/marvell/armada-385.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-385.dtsi
rename to arch/arm/boot/dts/marvell/armada-385.dtsi
diff --git a/arch/arm/boot/dts/armada-388-clearfog-base.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-388-clearfog-base.dts
rename to arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
diff --git a/arch/arm/boot/dts/armada-388-clearfog-pro.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog-pro.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-388-clearfog-pro.dts
rename to arch/arm/boot/dts/marvell/armada-388-clearfog-pro.dts
diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-388-clearfog.dts
rename to arch/arm/boot/dts/marvell/armada-388-clearfog.dts
diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/marvell/armada-388-clearfog.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-388-clearfog.dtsi
rename to arch/arm/boot/dts/marvell/armada-388-clearfog.dtsi
diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/marvell/armada-388-db.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-388-db.dts
rename to arch/arm/boot/dts/marvell/armada-388-db.dts
diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/marvell/armada-388-gp.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-388-gp.dts
rename to arch/arm/boot/dts/marvell/armada-388-gp.dts
diff --git a/arch/arm/boot/dts/armada-388-helios4.dts b/arch/arm/boot/dts/marvell/armada-388-helios4.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-388-helios4.dts
rename to arch/arm/boot/dts/marvell/armada-388-helios4.dts
diff --git a/arch/arm/boot/dts/armada-388-rd.dts b/arch/arm/boot/dts/marvell/armada-388-rd.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-388-rd.dts
rename to arch/arm/boot/dts/marvell/armada-388-rd.dts
diff --git a/arch/arm/boot/dts/armada-388.dtsi b/arch/arm/boot/dts/marvell/armada-388.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-388.dtsi
rename to arch/arm/boot/dts/marvell/armada-388.dtsi
diff --git a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi b/arch/arm/boot/dts/marvell/armada-38x-solidrun-microsom.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
rename to arch/arm/boot/dts/marvell/armada-38x-solidrun-microsom.dtsi
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/marvell/armada-38x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-38x.dtsi
rename to arch/arm/boot/dts/marvell/armada-38x.dtsi
diff --git a/arch/arm/boot/dts/armada-390-db.dts b/arch/arm/boot/dts/marvell/armada-390-db.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-390-db.dts
rename to arch/arm/boot/dts/marvell/armada-390-db.dts
diff --git a/arch/arm/boot/dts/armada-390.dtsi b/arch/arm/boot/dts/marvell/armada-390.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-390.dtsi
rename to arch/arm/boot/dts/marvell/armada-390.dtsi
diff --git a/arch/arm/boot/dts/armada-395-gp.dts b/arch/arm/boot/dts/marvell/armada-395-gp.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-395-gp.dts
rename to arch/arm/boot/dts/marvell/armada-395-gp.dts
diff --git a/arch/arm/boot/dts/armada-395.dtsi b/arch/arm/boot/dts/marvell/armada-395.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-395.dtsi
rename to arch/arm/boot/dts/marvell/armada-395.dtsi
diff --git a/arch/arm/boot/dts/armada-398-db.dts b/arch/arm/boot/dts/marvell/armada-398-db.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-398-db.dts
rename to arch/arm/boot/dts/marvell/armada-398-db.dts
diff --git a/arch/arm/boot/dts/armada-398.dtsi b/arch/arm/boot/dts/marvell/armada-398.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-398.dtsi
rename to arch/arm/boot/dts/marvell/armada-398.dtsi
diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/marvell/armada-39x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-39x.dtsi
rename to arch/arm/boot/dts/marvell/armada-39x.dtsi
diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/marvell/armada-xp-98dx3236.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-98dx3236.dtsi
rename to arch/arm/boot/dts/marvell/armada-xp-98dx3236.dtsi
diff --git a/arch/arm/boot/dts/armada-xp-98dx3336.dtsi b/arch/arm/boot/dts/marvell/armada-xp-98dx3336.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-98dx3336.dtsi
rename to arch/arm/boot/dts/marvell/armada-xp-98dx3336.dtsi
diff --git a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi b/arch/arm/boot/dts/marvell/armada-xp-98dx4251.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-98dx4251.dtsi
rename to arch/arm/boot/dts/marvell/armada-xp-98dx4251.dtsi
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/marvell/armada-xp-axpwifiap.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-axpwifiap.dts
rename to arch/arm/boot/dts/marvell/armada-xp-axpwifiap.dts
diff --git a/arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts b/arch/arm/boot/dts/marvell/armada-xp-crs305-1g-4s-bit.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts
rename to arch/arm/boot/dts/marvell/armada-xp-crs305-1g-4s-bit.dts
diff --git a/arch/arm/boot/dts/armada-xp-crs305-1g-4s.dts b/arch/arm/boot/dts/marvell/armada-xp-crs305-1g-4s.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-crs305-1g-4s.dts
rename to arch/arm/boot/dts/marvell/armada-xp-crs305-1g-4s.dts
diff --git a/arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi b/arch/arm/boot/dts/marvell/armada-xp-crs305-1g-4s.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi
rename to arch/arm/boot/dts/marvell/armada-xp-crs305-1g-4s.dtsi
diff --git a/arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts b/arch/arm/boot/dts/marvell/armada-xp-crs326-24g-2s-bit.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts
rename to arch/arm/boot/dts/marvell/armada-xp-crs326-24g-2s-bit.dts
diff --git a/arch/arm/boot/dts/armada-xp-crs326-24g-2s.dts b/arch/arm/boot/dts/marvell/armada-xp-crs326-24g-2s.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-crs326-24g-2s.dts
rename to arch/arm/boot/dts/marvell/armada-xp-crs326-24g-2s.dts
diff --git a/arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi b/arch/arm/boot/dts/marvell/armada-xp-crs326-24g-2s.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi
rename to arch/arm/boot/dts/marvell/armada-xp-crs326-24g-2s.dtsi
diff --git a/arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dts b/arch/arm/boot/dts/marvell/armada-xp-crs328-4c-20s-4s-bit.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dts
rename to arch/arm/boot/dts/marvell/armada-xp-crs328-4c-20s-4s-bit.dts
diff --git a/arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dts b/arch/arm/boot/dts/marvell/armada-xp-crs328-4c-20s-4s.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dts
rename to arch/arm/boot/dts/marvell/armada-xp-crs328-4c-20s-4s.dts
diff --git a/arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dtsi b/arch/arm/boot/dts/marvell/armada-xp-crs328-4c-20s-4s.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dtsi
rename to arch/arm/boot/dts/marvell/armada-xp-crs328-4c-20s-4s.dtsi
diff --git a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts b/arch/arm/boot/dts/marvell/armada-xp-db-dxbc2.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-db-dxbc2.dts
rename to arch/arm/boot/dts/marvell/armada-xp-db-dxbc2.dts
diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boot/dts/marvell/armada-xp-db-xc3-24g4xg.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
rename to arch/arm/boot/dts/marvell/armada-xp-db-xc3-24g4xg.dts
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/marvell/armada-xp-db.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-db.dts
rename to arch/arm/boot/dts/marvell/armada-xp-db.dts
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/marvell/armada-xp-gp.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-gp.dts
rename to arch/arm/boot/dts/marvell/armada-xp-gp.dts
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/marvell/armada-xp-lenovo-ix4-300d.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
rename to arch/arm/boot/dts/marvell/armada-xp-lenovo-ix4-300d.dts
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-linksys-mamba.dts
rename to arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/marvell/armada-xp-matrix.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-matrix.dts
rename to arch/arm/boot/dts/marvell/armada-xp-matrix.dts
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/marvell/armada-xp-mv78230.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-mv78230.dtsi
rename to arch/arm/boot/dts/marvell/armada-xp-mv78230.dtsi
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/marvell/armada-xp-mv78260.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-mv78260.dtsi
rename to arch/arm/boot/dts/marvell/armada-xp-mv78260.dtsi
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/marvell/armada-xp-mv78460.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-mv78460.dtsi
rename to arch/arm/boot/dts/marvell/armada-xp-mv78460.dtsi
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/marvell/armada-xp-netgear-rn2120.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
rename to arch/arm/boot/dts/marvell/armada-xp-netgear-rn2120.dts
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/marvell/armada-xp-openblocks-ax3-4.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
rename to arch/arm/boot/dts/marvell/armada-xp-openblocks-ax3-4.dts
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/marvell/armada-xp-synology-ds414.dts
similarity index 100%
rename from arch/arm/boot/dts/armada-xp-synology-ds414.dts
rename to arch/arm/boot/dts/marvell/armada-xp-synology-ds414.dts
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/marvell/armada-xp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/armada-xp.dtsi
rename to arch/arm/boot/dts/marvell/armada-xp.dtsi
diff --git a/arch/arm/boot/dts/dove-cm-a510.dtsi b/arch/arm/boot/dts/marvell/dove-cm-a510.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dove-cm-a510.dtsi
rename to arch/arm/boot/dts/marvell/dove-cm-a510.dtsi
diff --git a/arch/arm/boot/dts/dove-cubox-es.dts b/arch/arm/boot/dts/marvell/dove-cubox-es.dts
similarity index 100%
rename from arch/arm/boot/dts/dove-cubox-es.dts
rename to arch/arm/boot/dts/marvell/dove-cubox-es.dts
diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/marvell/dove-cubox.dts
similarity index 100%
rename from arch/arm/boot/dts/dove-cubox.dts
rename to arch/arm/boot/dts/marvell/dove-cubox.dts
diff --git a/arch/arm/boot/dts/dove-d2plug.dts b/arch/arm/boot/dts/marvell/dove-d2plug.dts
similarity index 100%
rename from arch/arm/boot/dts/dove-d2plug.dts
rename to arch/arm/boot/dts/marvell/dove-d2plug.dts
diff --git a/arch/arm/boot/dts/dove-d3plug.dts b/arch/arm/boot/dts/marvell/dove-d3plug.dts
similarity index 100%
rename from arch/arm/boot/dts/dove-d3plug.dts
rename to arch/arm/boot/dts/marvell/dove-d3plug.dts
diff --git a/arch/arm/boot/dts/dove-dove-db.dts b/arch/arm/boot/dts/marvell/dove-dove-db.dts
similarity index 100%
rename from arch/arm/boot/dts/dove-dove-db.dts
rename to arch/arm/boot/dts/marvell/dove-dove-db.dts
diff --git a/arch/arm/boot/dts/dove-sbc-a510.dts b/arch/arm/boot/dts/marvell/dove-sbc-a510.dts
similarity index 100%
rename from arch/arm/boot/dts/dove-sbc-a510.dts
rename to arch/arm/boot/dts/marvell/dove-sbc-a510.dts
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/marvell/dove.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dove.dtsi
rename to arch/arm/boot/dts/marvell/dove.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-6192.dtsi b/arch/arm/boot/dts/marvell/kirkwood-6192.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-6192.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-6192.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/marvell/kirkwood-6281.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-6281.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-6281.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/marvell/kirkwood-6282.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-6282.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-6282.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi b/arch/arm/boot/dts/marvell/kirkwood-98dx4122.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-98dx4122.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-98dx4122.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-b3.dts b/arch/arm/boot/dts/marvell/kirkwood-b3.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-b3.dts
rename to arch/arm/boot/dts/marvell/kirkwood-b3.dts
diff --git a/arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts b/arch/arm/boot/dts/marvell/kirkwood-blackarmor-nas220.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts
rename to arch/arm/boot/dts/marvell/kirkwood-blackarmor-nas220.dts
diff --git a/arch/arm/boot/dts/kirkwood-c200-v1.dts b/arch/arm/boot/dts/marvell/kirkwood-c200-v1.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-c200-v1.dts
rename to arch/arm/boot/dts/marvell/kirkwood-c200-v1.dts
diff --git a/arch/arm/boot/dts/kirkwood-cloudbox.dts b/arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-cloudbox.dts
rename to arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts
diff --git a/arch/arm/boot/dts/kirkwood-d2net.dts b/arch/arm/boot/dts/marvell/kirkwood-d2net.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-d2net.dts
rename to arch/arm/boot/dts/marvell/kirkwood-d2net.dts
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6281.dts b/arch/arm/boot/dts/marvell/kirkwood-db-88f6281.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-db-88f6281.dts
rename to arch/arm/boot/dts/marvell/kirkwood-db-88f6281.dts
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6282.dts b/arch/arm/boot/dts/marvell/kirkwood-db-88f6282.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-db-88f6282.dts
rename to arch/arm/boot/dts/marvell/kirkwood-db-88f6282.dts
diff --git a/arch/arm/boot/dts/kirkwood-db.dtsi b/arch/arm/boot/dts/marvell/kirkwood-db.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-db.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-db.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-dir665.dts b/arch/arm/boot/dts/marvell/kirkwood-dir665.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-dir665.dts
rename to arch/arm/boot/dts/marvell/kirkwood-dir665.dts
diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/marvell/kirkwood-dns320.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-dns320.dts
rename to arch/arm/boot/dts/marvell/kirkwood-dns320.dts
diff --git a/arch/arm/boot/dts/kirkwood-dns325.dts b/arch/arm/boot/dts/marvell/kirkwood-dns325.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-dns325.dts
rename to arch/arm/boot/dts/marvell/kirkwood-dns325.dts
diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-dnskw.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-dockstar.dts b/arch/arm/boot/dts/marvell/kirkwood-dockstar.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-dockstar.dts
rename to arch/arm/boot/dts/marvell/kirkwood-dockstar.dts
diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/marvell/kirkwood-dreamplug.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-dreamplug.dts
rename to arch/arm/boot/dts/marvell/kirkwood-dreamplug.dts
diff --git a/arch/arm/boot/dts/kirkwood-ds109.dts b/arch/arm/boot/dts/marvell/kirkwood-ds109.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ds109.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ds109.dts
diff --git a/arch/arm/boot/dts/kirkwood-ds110jv10.dts b/arch/arm/boot/dts/marvell/kirkwood-ds110jv10.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ds110jv10.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ds110jv10.dts
diff --git a/arch/arm/boot/dts/kirkwood-ds111.dts b/arch/arm/boot/dts/marvell/kirkwood-ds111.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ds111.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ds111.dts
diff --git a/arch/arm/boot/dts/kirkwood-ds112.dts b/arch/arm/boot/dts/marvell/kirkwood-ds112.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ds112.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ds112.dts
diff --git a/arch/arm/boot/dts/kirkwood-ds209.dts b/arch/arm/boot/dts/marvell/kirkwood-ds209.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ds209.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ds209.dts
diff --git a/arch/arm/boot/dts/kirkwood-ds210.dts b/arch/arm/boot/dts/marvell/kirkwood-ds210.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ds210.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ds210.dts
diff --git a/arch/arm/boot/dts/kirkwood-ds212.dts b/arch/arm/boot/dts/marvell/kirkwood-ds212.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ds212.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ds212.dts
diff --git a/arch/arm/boot/dts/kirkwood-ds212j.dts b/arch/arm/boot/dts/marvell/kirkwood-ds212j.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ds212j.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ds212j.dts
diff --git a/arch/arm/boot/dts/kirkwood-ds409.dts b/arch/arm/boot/dts/marvell/kirkwood-ds409.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ds409.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ds409.dts
diff --git a/arch/arm/boot/dts/kirkwood-ds409slim.dts b/arch/arm/boot/dts/marvell/kirkwood-ds409slim.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ds409slim.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ds409slim.dts
diff --git a/arch/arm/boot/dts/kirkwood-ds411.dts b/arch/arm/boot/dts/marvell/kirkwood-ds411.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ds411.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ds411.dts
diff --git a/arch/arm/boot/dts/kirkwood-ds411j.dts b/arch/arm/boot/dts/marvell/kirkwood-ds411j.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ds411j.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ds411j.dts
diff --git a/arch/arm/boot/dts/kirkwood-ds411slim.dts b/arch/arm/boot/dts/marvell/kirkwood-ds411slim.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ds411slim.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ds411slim.dts
diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts b/arch/arm/boot/dts/marvell/kirkwood-goflexnet.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-goflexnet.dts
rename to arch/arm/boot/dts/marvell/kirkwood-goflexnet.dts
diff --git a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/boot/dts/marvell/kirkwood-guruplug-server-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
rename to arch/arm/boot/dts/marvell/kirkwood-guruplug-server-plus.dts
diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ib62x0.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts
diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/marvell/kirkwood-iconnect.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-iconnect.dts
rename to arch/arm/boot/dts/marvell/kirkwood-iconnect.dts
diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
rename to arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts
diff --git a/arch/arm/boot/dts/kirkwood-is2.dts b/arch/arm/boot/dts/marvell/kirkwood-is2.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-is2.dts
rename to arch/arm/boot/dts/marvell/kirkwood-is2.dts
diff --git a/arch/arm/boot/dts/kirkwood-km_common.dtsi b/arch/arm/boot/dts/marvell/kirkwood-km_common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-km_common.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-km_common.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-km_fixedeth.dts b/arch/arm/boot/dts/marvell/kirkwood-km_fixedeth.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-km_fixedeth.dts
rename to arch/arm/boot/dts/marvell/kirkwood-km_fixedeth.dts
diff --git a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts b/arch/arm/boot/dts/marvell/kirkwood-km_kirkwood.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-km_kirkwood.dts
rename to arch/arm/boot/dts/marvell/kirkwood-km_kirkwood.dts
diff --git a/arch/arm/boot/dts/kirkwood-l-50.dts b/arch/arm/boot/dts/marvell/kirkwood-l-50.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-l-50.dts
rename to arch/arm/boot/dts/marvell/kirkwood-l-50.dts
diff --git a/arch/arm/boot/dts/kirkwood-laplug.dts b/arch/arm/boot/dts/marvell/kirkwood-laplug.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-laplug.dts
rename to arch/arm/boot/dts/marvell/kirkwood-laplug.dts
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi b/arch/arm/boot/dts/marvell/kirkwood-linkstation-6282.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-linkstation-6282.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-duo-6281.dtsi b/arch/arm/boot/dts/marvell/kirkwood-linkstation-duo-6281.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-linkstation-duo-6281.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-linkstation-duo-6281.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts b/arch/arm/boot/dts/marvell/kirkwood-linkstation-lsqvl.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts
rename to arch/arm/boot/dts/marvell/kirkwood-linkstation-lsqvl.dts
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts b/arch/arm/boot/dts/marvell/kirkwood-linkstation-lsvl.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts
rename to arch/arm/boot/dts/marvell/kirkwood-linkstation-lsvl.dts
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts b/arch/arm/boot/dts/marvell/kirkwood-linkstation-lswsxl.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts
rename to arch/arm/boot/dts/marvell/kirkwood-linkstation-lswsxl.dts
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts b/arch/arm/boot/dts/marvell/kirkwood-linkstation-lswvl.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts
rename to arch/arm/boot/dts/marvell/kirkwood-linkstation-lswvl.dts
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts b/arch/arm/boot/dts/marvell/kirkwood-linkstation-lswxl.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts
rename to arch/arm/boot/dts/marvell/kirkwood-linkstation-lswxl.dts
diff --git a/arch/arm/boot/dts/kirkwood-linkstation.dtsi b/arch/arm/boot/dts/marvell/kirkwood-linkstation.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-linkstation.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-linkstation.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-linksys-viper.dts b/arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-linksys-viper.dts
rename to arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts
diff --git a/arch/arm/boot/dts/kirkwood-lschlv2.dts b/arch/arm/boot/dts/marvell/kirkwood-lschlv2.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-lschlv2.dts
rename to arch/arm/boot/dts/marvell/kirkwood-lschlv2.dts
diff --git a/arch/arm/boot/dts/kirkwood-lsxhl.dts b/arch/arm/boot/dts/marvell/kirkwood-lsxhl.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-lsxhl.dts
rename to arch/arm/boot/dts/marvell/kirkwood-lsxhl.dts
diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-lsxl.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/marvell/kirkwood-mplcec4.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-mplcec4.dts
rename to arch/arm/boot/dts/marvell/kirkwood-mplcec4.dts
diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
rename to arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts
diff --git a/arch/arm/boot/dts/kirkwood-nas2big.dts b/arch/arm/boot/dts/marvell/kirkwood-nas2big.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-nas2big.dts
rename to arch/arm/boot/dts/marvell/kirkwood-nas2big.dts
diff --git a/arch/arm/boot/dts/kirkwood-net2big.dts b/arch/arm/boot/dts/marvell/kirkwood-net2big.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-net2big.dts
rename to arch/arm/boot/dts/marvell/kirkwood-net2big.dts
diff --git a/arch/arm/boot/dts/kirkwood-net5big.dts b/arch/arm/boot/dts/marvell/kirkwood-net5big.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-net5big.dts
rename to arch/arm/boot/dts/marvell/kirkwood-net5big.dts
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/marvell/kirkwood-netgear_readynas_duo_v2.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
rename to arch/arm/boot/dts/marvell/kirkwood-netgear_readynas_duo_v2.dts
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts b/arch/arm/boot/dts/marvell/kirkwood-netgear_readynas_nv+_v2.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
rename to arch/arm/boot/dts/marvell/kirkwood-netgear_readynas_nv+_v2.dts
diff --git a/arch/arm/boot/dts/kirkwood-netxbig.dtsi b/arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-netxbig.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ns2-common.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-ns2.dts b/arch/arm/boot/dts/marvell/kirkwood-ns2.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ns2.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ns2.dts
diff --git a/arch/arm/boot/dts/kirkwood-ns2lite.dts b/arch/arm/boot/dts/marvell/kirkwood-ns2lite.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ns2lite.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ns2lite.dts
diff --git a/arch/arm/boot/dts/kirkwood-ns2max.dts b/arch/arm/boot/dts/marvell/kirkwood-ns2max.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ns2max.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ns2max.dts
diff --git a/arch/arm/boot/dts/kirkwood-ns2mini.dts b/arch/arm/boot/dts/marvell/kirkwood-ns2mini.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ns2mini.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ns2mini.dts
diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/marvell/kirkwood-nsa310.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-nsa310.dts
rename to arch/arm/boot/dts/marvell/kirkwood-nsa310.dts
diff --git a/arch/arm/boot/dts/kirkwood-nsa310a.dts b/arch/arm/boot/dts/marvell/kirkwood-nsa310a.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-nsa310a.dts
rename to arch/arm/boot/dts/marvell/kirkwood-nsa310a.dts
diff --git a/arch/arm/boot/dts/kirkwood-nsa310s.dts b/arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-nsa310s.dts
rename to arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts
diff --git a/arch/arm/boot/dts/kirkwood-nsa320.dts b/arch/arm/boot/dts/marvell/kirkwood-nsa320.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-nsa320.dts
rename to arch/arm/boot/dts/marvell/kirkwood-nsa320.dts
diff --git a/arch/arm/boot/dts/kirkwood-nsa325.dts b/arch/arm/boot/dts/marvell/kirkwood-nsa325.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-nsa325.dts
rename to arch/arm/boot/dts/marvell/kirkwood-nsa325.dts
diff --git a/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi b/arch/arm/boot/dts/marvell/kirkwood-nsa3x0-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-nsa3x0-common.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/marvell/kirkwood-openblocks_a6.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-openblocks_a6.dts
rename to arch/arm/boot/dts/marvell/kirkwood-openblocks_a6.dts
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-openblocks_a7.dts
rename to arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
diff --git a/arch/arm/boot/dts/kirkwood-openrd-base.dts b/arch/arm/boot/dts/marvell/kirkwood-openrd-base.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-openrd-base.dts
rename to arch/arm/boot/dts/marvell/kirkwood-openrd-base.dts
diff --git a/arch/arm/boot/dts/kirkwood-openrd-client.dts b/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-openrd-client.dts
rename to arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts
diff --git a/arch/arm/boot/dts/kirkwood-openrd-ultimate.dts b/arch/arm/boot/dts/marvell/kirkwood-openrd-ultimate.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-openrd-ultimate.dts
rename to arch/arm/boot/dts/marvell/kirkwood-openrd-ultimate.dts
diff --git a/arch/arm/boot/dts/kirkwood-openrd.dtsi b/arch/arm/boot/dts/marvell/kirkwood-openrd.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-openrd.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-openrd.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-pogo_e02.dts b/arch/arm/boot/dts/marvell/kirkwood-pogo_e02.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-pogo_e02.dts
rename to arch/arm/boot/dts/marvell/kirkwood-pogo_e02.dts
diff --git a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts b/arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
rename to arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6192.dts b/arch/arm/boot/dts/marvell/kirkwood-rd88f6192.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-rd88f6192.dts
rename to arch/arm/boot/dts/marvell/kirkwood-rd88f6192.dts
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-a.dts b/arch/arm/boot/dts/marvell/kirkwood-rd88f6281-a.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-rd88f6281-a.dts
rename to arch/arm/boot/dts/marvell/kirkwood-rd88f6281-a.dts
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts b/arch/arm/boot/dts/marvell/kirkwood-rd88f6281-z0.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
rename to arch/arm/boot/dts/marvell/kirkwood-rd88f6281-z0.dts
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi b/arch/arm/boot/dts/marvell/kirkwood-rd88f6281.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-rd88f6281.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-rs212.dts b/arch/arm/boot/dts/marvell/kirkwood-rs212.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-rs212.dts
rename to arch/arm/boot/dts/marvell/kirkwood-rs212.dts
diff --git a/arch/arm/boot/dts/kirkwood-rs409.dts b/arch/arm/boot/dts/marvell/kirkwood-rs409.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-rs409.dts
rename to arch/arm/boot/dts/marvell/kirkwood-rs409.dts
diff --git a/arch/arm/boot/dts/kirkwood-rs411.dts b/arch/arm/boot/dts/marvell/kirkwood-rs411.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-rs411.dts
rename to arch/arm/boot/dts/marvell/kirkwood-rs411.dts
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi b/arch/arm/boot/dts/marvell/kirkwood-sheevaplug-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-sheevaplug-common.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts b/arch/arm/boot/dts/marvell/kirkwood-sheevaplug-esata.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
rename to arch/arm/boot/dts/marvell/kirkwood-sheevaplug-esata.dts
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug.dts b/arch/arm/boot/dts/marvell/kirkwood-sheevaplug.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-sheevaplug.dts
rename to arch/arm/boot/dts/marvell/kirkwood-sheevaplug.dts
diff --git a/arch/arm/boot/dts/kirkwood-synology.dtsi b/arch/arm/boot/dts/marvell/kirkwood-synology.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-synology.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-synology.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/marvell/kirkwood-t5325.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-t5325.dts
rename to arch/arm/boot/dts/marvell/kirkwood-t5325.dts
diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/marvell/kirkwood-topkick.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-topkick.dts
rename to arch/arm/boot/dts/marvell/kirkwood-topkick.dts
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6281.dts b/arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ts219-6281.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ts219-6282.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/marvell/kirkwood-ts219.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ts219.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-ts219.dtsi
diff --git a/arch/arm/boot/dts/kirkwood-ts419-6281.dts b/arch/arm/boot/dts/marvell/kirkwood-ts419-6281.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ts419-6281.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ts419-6281.dts
diff --git a/arch/arm/boot/dts/kirkwood-ts419-6282.dts b/arch/arm/boot/dts/marvell/kirkwood-ts419-6282.dts
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ts419-6282.dts
rename to arch/arm/boot/dts/marvell/kirkwood-ts419-6282.dts
diff --git a/arch/arm/boot/dts/kirkwood-ts419.dtsi b/arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-ts419.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/marvell/kirkwood.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood.dtsi
rename to arch/arm/boot/dts/marvell/kirkwood.dtsi
diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
similarity index 100%
rename from arch/arm/boot/dts/mmp2-brownstone.dts
rename to arch/arm/boot/dts/marvell/mmp2-brownstone.dts
diff --git a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts b/arch/arm/boot/dts/marvell/mmp2-olpc-xo-1-75.dts
similarity index 100%
rename from arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
rename to arch/arm/boot/dts/marvell/mmp2-olpc-xo-1-75.dts
diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/marvell/mmp2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mmp2.dtsi
rename to arch/arm/boot/dts/marvell/mmp2.dtsi
diff --git a/arch/arm/boot/dts/mmp3-dell-ariel.dts b/arch/arm/boot/dts/marvell/mmp3-dell-ariel.dts
similarity index 100%
rename from arch/arm/boot/dts/mmp3-dell-ariel.dts
rename to arch/arm/boot/dts/marvell/mmp3-dell-ariel.dts
diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/marvell/mmp3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mmp3.dtsi
rename to arch/arm/boot/dts/marvell/mmp3.dtsi
diff --git a/arch/arm/boot/dts/mvebu-linkstation-fan.dtsi b/arch/arm/boot/dts/marvell/mvebu-linkstation-fan.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mvebu-linkstation-fan.dtsi
rename to arch/arm/boot/dts/marvell/mvebu-linkstation-fan.dtsi
diff --git a/arch/arm/boot/dts/mvebu-linkstation-gpio-simple.dtsi b/arch/arm/boot/dts/marvell/mvebu-linkstation-gpio-simple.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mvebu-linkstation-gpio-simple.dtsi
rename to arch/arm/boot/dts/marvell/mvebu-linkstation-gpio-simple.dtsi
diff --git a/arch/arm/boot/dts/orion5x-kuroboxpro.dts b/arch/arm/boot/dts/marvell/orion5x-kuroboxpro.dts
similarity index 100%
rename from arch/arm/boot/dts/orion5x-kuroboxpro.dts
rename to arch/arm/boot/dts/marvell/orion5x-kuroboxpro.dts
diff --git a/arch/arm/boot/dts/orion5x-lacie-d2-network.dts b/arch/arm/boot/dts/marvell/orion5x-lacie-d2-network.dts
similarity index 100%
rename from arch/arm/boot/dts/orion5x-lacie-d2-network.dts
rename to arch/arm/boot/dts/marvell/orion5x-lacie-d2-network.dts
diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/marvell/orion5x-lacie-ethernet-disk-mini-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
rename to arch/arm/boot/dts/marvell/orion5x-lacie-ethernet-disk-mini-v2.dts
diff --git a/arch/arm/boot/dts/orion5x-linkstation-lschl.dts b/arch/arm/boot/dts/marvell/orion5x-linkstation-lschl.dts
similarity index 100%
rename from arch/arm/boot/dts/orion5x-linkstation-lschl.dts
rename to arch/arm/boot/dts/marvell/orion5x-linkstation-lschl.dts
diff --git a/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts b/arch/arm/boot/dts/marvell/orion5x-linkstation-lsgl.dts
similarity index 100%
rename from arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
rename to arch/arm/boot/dts/marvell/orion5x-linkstation-lsgl.dts
diff --git a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts b/arch/arm/boot/dts/marvell/orion5x-linkstation-lswtgl.dts
similarity index 100%
rename from arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
rename to arch/arm/boot/dts/marvell/orion5x-linkstation-lswtgl.dts
diff --git a/arch/arm/boot/dts/orion5x-linkstation.dtsi b/arch/arm/boot/dts/marvell/orion5x-linkstation.dtsi
similarity index 100%
rename from arch/arm/boot/dts/orion5x-linkstation.dtsi
rename to arch/arm/boot/dts/marvell/orion5x-linkstation.dtsi
diff --git a/arch/arm/boot/dts/orion5x-lswsgl.dts b/arch/arm/boot/dts/marvell/orion5x-lswsgl.dts
similarity index 100%
rename from arch/arm/boot/dts/orion5x-lswsgl.dts
rename to arch/arm/boot/dts/marvell/orion5x-lswsgl.dts
diff --git a/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts b/arch/arm/boot/dts/marvell/orion5x-maxtor-shared-storage-2.dts
similarity index 100%
rename from arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
rename to arch/arm/boot/dts/marvell/orion5x-maxtor-shared-storage-2.dts
diff --git a/arch/arm/boot/dts/orion5x-mv88f5181.dtsi b/arch/arm/boot/dts/marvell/orion5x-mv88f5181.dtsi
similarity index 100%
rename from arch/arm/boot/dts/orion5x-mv88f5181.dtsi
rename to arch/arm/boot/dts/marvell/orion5x-mv88f5181.dtsi
diff --git a/arch/arm/boot/dts/orion5x-mv88f5182.dtsi b/arch/arm/boot/dts/marvell/orion5x-mv88f5182.dtsi
similarity index 100%
rename from arch/arm/boot/dts/orion5x-mv88f5182.dtsi
rename to arch/arm/boot/dts/marvell/orion5x-mv88f5182.dtsi
diff --git a/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts b/arch/arm/boot/dts/marvell/orion5x-netgear-wnr854t.dts
similarity index 100%
rename from arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
rename to arch/arm/boot/dts/marvell/orion5x-netgear-wnr854t.dts
diff --git a/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts b/arch/arm/boot/dts/marvell/orion5x-rd88f5182-nas.dts
similarity index 100%
rename from arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
rename to arch/arm/boot/dts/marvell/orion5x-rd88f5182-nas.dts
diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/marvell/orion5x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/orion5x.dtsi
rename to arch/arm/boot/dts/marvell/orion5x.dtsi
diff --git a/arch/arm/boot/dts/pxa168-aspenite.dts b/arch/arm/boot/dts/marvell/pxa168-aspenite.dts
similarity index 100%
rename from arch/arm/boot/dts/pxa168-aspenite.dts
rename to arch/arm/boot/dts/marvell/pxa168-aspenite.dts
diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/marvell/pxa168.dtsi
similarity index 100%
rename from arch/arm/boot/dts/pxa168.dtsi
rename to arch/arm/boot/dts/marvell/pxa168.dtsi
diff --git a/arch/arm/boot/dts/pxa910-dkb.dts b/arch/arm/boot/dts/marvell/pxa910-dkb.dts
similarity index 100%
rename from arch/arm/boot/dts/pxa910-dkb.dts
rename to arch/arm/boot/dts/marvell/pxa910-dkb.dts
diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/marvell/pxa910.dtsi
similarity index 100%
rename from arch/arm/boot/dts/pxa910.dtsi
rename to arch/arm/boot/dts/marvell/pxa910.dtsi
diff --git a/arch/arm/boot/dts/mediatek/Makefile b/arch/arm/boot/dts/mediatek/Makefile
new file mode 100644
index 000000000000..1957947cb41c
--- /dev/null
+++ b/arch/arm/boot/dts/mediatek/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_MEDIATEK) += \
+	mt2701-evb.dtb \
+	mt6580-evbp1.dtb \
+	mt6582-prestigio-pmt5008-3g.dtb \
+	mt6589-aquaris5.dtb \
+	mt6589-fairphone-fp1.dtb \
+	mt6592-evb.dtb \
+	mt7623a-rfb-emmc.dtb \
+	mt7623a-rfb-nand.dtb \
+	mt7623n-rfb-emmc.dtb \
+	mt7623n-bananapi-bpi-r2.dtb \
+	mt7629-rfb.dtb \
+	mt8127-moose.dtb \
+	mt8135-evbp1.dtb
diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mediatek/mt2701-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/mt2701-evb.dts
rename to arch/arm/boot/dts/mediatek/mt2701-evb.dts
diff --git a/arch/arm/boot/dts/mt2701-pinfunc.h b/arch/arm/boot/dts/mediatek/mt2701-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/mt2701-pinfunc.h
rename to arch/arm/boot/dts/mediatek/mt2701-pinfunc.h
diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mediatek/mt2701.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mt2701.dtsi
rename to arch/arm/boot/dts/mediatek/mt2701.dtsi
diff --git a/arch/arm/boot/dts/mt6323.dtsi b/arch/arm/boot/dts/mediatek/mt6323.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mt6323.dtsi
rename to arch/arm/boot/dts/mediatek/mt6323.dtsi
diff --git a/arch/arm/boot/dts/mt6580-evbp1.dts b/arch/arm/boot/dts/mediatek/mt6580-evbp1.dts
similarity index 100%
rename from arch/arm/boot/dts/mt6580-evbp1.dts
rename to arch/arm/boot/dts/mediatek/mt6580-evbp1.dts
diff --git a/arch/arm/boot/dts/mt6580.dtsi b/arch/arm/boot/dts/mediatek/mt6580.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mt6580.dtsi
rename to arch/arm/boot/dts/mediatek/mt6580.dtsi
diff --git a/arch/arm/boot/dts/mt6582-prestigio-pmt5008-3g.dts b/arch/arm/boot/dts/mediatek/mt6582-prestigio-pmt5008-3g.dts
similarity index 100%
rename from arch/arm/boot/dts/mt6582-prestigio-pmt5008-3g.dts
rename to arch/arm/boot/dts/mediatek/mt6582-prestigio-pmt5008-3g.dts
diff --git a/arch/arm/boot/dts/mt6582.dtsi b/arch/arm/boot/dts/mediatek/mt6582.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mt6582.dtsi
rename to arch/arm/boot/dts/mediatek/mt6582.dtsi
diff --git a/arch/arm/boot/dts/mt6589-aquaris5.dts b/arch/arm/boot/dts/mediatek/mt6589-aquaris5.dts
similarity index 100%
rename from arch/arm/boot/dts/mt6589-aquaris5.dts
rename to arch/arm/boot/dts/mediatek/mt6589-aquaris5.dts
diff --git a/arch/arm/boot/dts/mt6589-fairphone-fp1.dts b/arch/arm/boot/dts/mediatek/mt6589-fairphone-fp1.dts
similarity index 100%
rename from arch/arm/boot/dts/mt6589-fairphone-fp1.dts
rename to arch/arm/boot/dts/mediatek/mt6589-fairphone-fp1.dts
diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mediatek/mt6589.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mt6589.dtsi
rename to arch/arm/boot/dts/mediatek/mt6589.dtsi
diff --git a/arch/arm/boot/dts/mt6592-evb.dts b/arch/arm/boot/dts/mediatek/mt6592-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/mt6592-evb.dts
rename to arch/arm/boot/dts/mediatek/mt6592-evb.dts
diff --git a/arch/arm/boot/dts/mt6592.dtsi b/arch/arm/boot/dts/mediatek/mt6592.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mt6592.dtsi
rename to arch/arm/boot/dts/mediatek/mt6592.dtsi
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mediatek/mt7623.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mt7623.dtsi
rename to arch/arm/boot/dts/mediatek/mt7623.dtsi
diff --git a/arch/arm/boot/dts/mt7623a-rfb-emmc.dts b/arch/arm/boot/dts/mediatek/mt7623a-rfb-emmc.dts
similarity index 100%
rename from arch/arm/boot/dts/mt7623a-rfb-emmc.dts
rename to arch/arm/boot/dts/mediatek/mt7623a-rfb-emmc.dts
diff --git a/arch/arm/boot/dts/mt7623a-rfb-nand.dts b/arch/arm/boot/dts/mediatek/mt7623a-rfb-nand.dts
similarity index 100%
rename from arch/arm/boot/dts/mt7623a-rfb-nand.dts
rename to arch/arm/boot/dts/mediatek/mt7623a-rfb-nand.dts
diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mediatek/mt7623a.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mt7623a.dtsi
rename to arch/arm/boot/dts/mediatek/mt7623a.dtsi
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mediatek/mt7623n-bananapi-bpi-r2.dts
similarity index 100%
rename from arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
rename to arch/arm/boot/dts/mediatek/mt7623n-bananapi-bpi-r2.dts
diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mediatek/mt7623n-rfb-emmc.dts
similarity index 100%
rename from arch/arm/boot/dts/mt7623n-rfb-emmc.dts
rename to arch/arm/boot/dts/mediatek/mt7623n-rfb-emmc.dts
diff --git a/arch/arm/boot/dts/mt7623n.dtsi b/arch/arm/boot/dts/mediatek/mt7623n.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mt7623n.dtsi
rename to arch/arm/boot/dts/mediatek/mt7623n.dtsi
diff --git a/arch/arm/boot/dts/mt7629-rfb.dts b/arch/arm/boot/dts/mediatek/mt7629-rfb.dts
similarity index 100%
rename from arch/arm/boot/dts/mt7629-rfb.dts
rename to arch/arm/boot/dts/mediatek/mt7629-rfb.dts
diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mediatek/mt7629.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mt7629.dtsi
rename to arch/arm/boot/dts/mediatek/mt7629.dtsi
diff --git a/arch/arm/boot/dts/mt8127-moose.dts b/arch/arm/boot/dts/mediatek/mt8127-moose.dts
similarity index 100%
rename from arch/arm/boot/dts/mt8127-moose.dts
rename to arch/arm/boot/dts/mediatek/mt8127-moose.dts
diff --git a/arch/arm/boot/dts/mt8127.dtsi b/arch/arm/boot/dts/mediatek/mt8127.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mt8127.dtsi
rename to arch/arm/boot/dts/mediatek/mt8127.dtsi
diff --git a/arch/arm/boot/dts/mt8135-evbp1.dts b/arch/arm/boot/dts/mediatek/mt8135-evbp1.dts
similarity index 100%
rename from arch/arm/boot/dts/mt8135-evbp1.dts
rename to arch/arm/boot/dts/mediatek/mt8135-evbp1.dts
diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mediatek/mt8135.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mt8135.dtsi
rename to arch/arm/boot/dts/mediatek/mt8135.dtsi
diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
new file mode 100644
index 000000000000..d2a7310f093b
--- /dev/null
+++ b/arch/arm/boot/dts/microchip/Makefile
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_SOC_AT91RM9200) += \
+	at91rm9200ek.dtb \
+	mpa1600.dtb
+dtb-$(CONFIG_SOC_AT91SAM9) += \
+	animeo_ip.dtb \
+	at91-qil_a9260.dtb \
+	aks-cdu.dtb \
+	ethernut5.dtb \
+	evk-pro3.dtb \
+	tny_a9260.dtb \
+	usb_a9260.dtb \
+	at91sam9260ek.dtb \
+	at91sam9261ek.dtb \
+	at91sam9263ek.dtb \
+	at91-sam9_l9260.dtb \
+	tny_a9263.dtb \
+	usb_a9263.dtb \
+	at91-foxg20.dtb \
+	at91-kizbox.dtb \
+	at91-lmu5000.dtb \
+	at91sam9g20ek.dtb \
+	at91sam9g20ek_2mmc.dtb \
+	tny_a9g20.dtb \
+	usb_a9g20.dtb \
+	usb_a9g20_lpw.dtb \
+	at91sam9m10g45ek.dtb \
+	pm9g45.dtb \
+	at91sam9n12ek.dtb \
+	at91sam9rlek.dtb \
+	at91-ariag25.dtb \
+	at91-ariettag25.dtb \
+	at91-cosino_mega2560.dtb \
+	at91-kizboxmini-base.dtb \
+	at91-kizboxmini-mb.dtb \
+	at91-kizboxmini-rd.dtb \
+	at91-q5xr5.dtb \
+	at91-smartkiz.dtb \
+	at91-wb45n.dtb \
+	at91sam9g15ek.dtb \
+	at91sam9g25-gardena-smart-gateway.dtb \
+	at91sam9g25ek.dtb \
+	at91sam9g35ek.dtb \
+	at91sam9x25ek.dtb \
+	at91sam9x35ek.dtb
+dtb-$(CONFIG_SOC_LAN966) += \
+	lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb \
+	lan966x-kontron-kswitch-d10-mmt-8g.dtb \
+	lan966x-pcb8290.dtb \
+	lan966x-pcb8291.dtb \
+	lan966x-pcb8309.dtb
+dtb-$(CONFIG_SOC_SAM9X60) += \
+	at91-sam9x60_curiosity.dtb \
+	at91-sam9x60ek.dtb
+dtb-$(CONFIG_SOC_SAMA7G5) += \
+	at91-sama7g5ek.dtb
+dtb-$(CONFIG_SOC_SAM_V7) += \
+	at91-kizbox2-2.dtb \
+	at91-kizbox3-hs.dtb \
+	at91-nattis-2-natte-2.dtb \
+	at91-sama5d27_som1_ek.dtb \
+	at91-sama5d27_wlsom1_ek.dtb \
+	at91-sama5d2_icp.dtb \
+	at91-sama5d2_ptc_ek.dtb \
+	at91-sama5d2_xplained.dtb \
+	at91-sama5d3_eds.dtb \
+	at91-sama5d3_ksz9477_evb.dtb \
+	at91-sama5d3_xplained.dtb \
+	at91-dvk_som60.dtb \
+	at91-gatwick.dtb \
+	at91-tse850-3.dtb \
+	at91-wb50n.dtb \
+	sama5d31ek.dtb \
+	sama5d33ek.dtb \
+	sama5d34ek.dtb \
+	sama5d35ek.dtb \
+	sama5d36ek.dtb \
+	sama5d36ek_cmp.dtb \
+	at91-sama5d4_ma5d4evk.dtb \
+	at91-sama5d4_xplained.dtb \
+	at91-sama5d4ek.dtb \
+	at91-vinco.dtb
diff --git a/arch/arm/boot/dts/aks-cdu.dts b/arch/arm/boot/dts/microchip/aks-cdu.dts
similarity index 100%
rename from arch/arm/boot/dts/aks-cdu.dts
rename to arch/arm/boot/dts/microchip/aks-cdu.dts
diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/microchip/animeo_ip.dts
similarity index 100%
rename from arch/arm/boot/dts/animeo_ip.dts
rename to arch/arm/boot/dts/microchip/animeo_ip.dts
diff --git a/arch/arm/boot/dts/at91-ariag25.dts b/arch/arm/boot/dts/microchip/at91-ariag25.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-ariag25.dts
rename to arch/arm/boot/dts/microchip/at91-ariag25.dts
diff --git a/arch/arm/boot/dts/at91-ariettag25.dts b/arch/arm/boot/dts/microchip/at91-ariettag25.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-ariettag25.dts
rename to arch/arm/boot/dts/microchip/at91-ariettag25.dts
diff --git a/arch/arm/boot/dts/at91-cosino.dtsi b/arch/arm/boot/dts/microchip/at91-cosino.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-cosino.dtsi
rename to arch/arm/boot/dts/microchip/at91-cosino.dtsi
diff --git a/arch/arm/boot/dts/at91-cosino_mega2560.dts b/arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-cosino_mega2560.dts
rename to arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts
diff --git a/arch/arm/boot/dts/at91-dvk_som60.dts b/arch/arm/boot/dts/microchip/at91-dvk_som60.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-dvk_som60.dts
rename to arch/arm/boot/dts/microchip/at91-dvk_som60.dts
diff --git a/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi b/arch/arm/boot/dts/microchip/at91-dvk_su60_somc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
rename to arch/arm/boot/dts/microchip/at91-dvk_su60_somc.dtsi
diff --git a/arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi b/arch/arm/boot/dts/microchip/at91-dvk_su60_somc_lcm.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi
rename to arch/arm/boot/dts/microchip/at91-dvk_su60_somc_lcm.dtsi
diff --git a/arch/arm/boot/dts/at91-foxg20.dts b/arch/arm/boot/dts/microchip/at91-foxg20.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-foxg20.dts
rename to arch/arm/boot/dts/microchip/at91-foxg20.dts
diff --git a/arch/arm/boot/dts/at91-gatwick.dts b/arch/arm/boot/dts/microchip/at91-gatwick.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-gatwick.dts
rename to arch/arm/boot/dts/microchip/at91-gatwick.dts
diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/microchip/at91-kizbox.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-kizbox.dts
rename to arch/arm/boot/dts/microchip/at91-kizbox.dts
diff --git a/arch/arm/boot/dts/at91-kizbox2-2.dts b/arch/arm/boot/dts/microchip/at91-kizbox2-2.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-kizbox2-2.dts
rename to arch/arm/boot/dts/microchip/at91-kizbox2-2.dts
diff --git a/arch/arm/boot/dts/at91-kizbox2-common.dtsi b/arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-kizbox2-common.dtsi
rename to arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi
diff --git a/arch/arm/boot/dts/at91-kizbox3-hs.dts b/arch/arm/boot/dts/microchip/at91-kizbox3-hs.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-kizbox3-hs.dts
rename to arch/arm/boot/dts/microchip/at91-kizbox3-hs.dts
diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts/microchip/at91-kizbox3_common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-kizbox3_common.dtsi
rename to arch/arm/boot/dts/microchip/at91-kizbox3_common.dtsi
diff --git a/arch/arm/boot/dts/at91-kizboxmini-base.dts b/arch/arm/boot/dts/microchip/at91-kizboxmini-base.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-kizboxmini-base.dts
rename to arch/arm/boot/dts/microchip/at91-kizboxmini-base.dts
diff --git a/arch/arm/boot/dts/at91-kizboxmini-common.dtsi b/arch/arm/boot/dts/microchip/at91-kizboxmini-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-kizboxmini-common.dtsi
rename to arch/arm/boot/dts/microchip/at91-kizboxmini-common.dtsi
diff --git a/arch/arm/boot/dts/at91-kizboxmini-mb.dts b/arch/arm/boot/dts/microchip/at91-kizboxmini-mb.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-kizboxmini-mb.dts
rename to arch/arm/boot/dts/microchip/at91-kizboxmini-mb.dts
diff --git a/arch/arm/boot/dts/at91-kizboxmini-rd.dts b/arch/arm/boot/dts/microchip/at91-kizboxmini-rd.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-kizboxmini-rd.dts
rename to arch/arm/boot/dts/microchip/at91-kizboxmini-rd.dts
diff --git a/arch/arm/boot/dts/at91-linea.dtsi b/arch/arm/boot/dts/microchip/at91-linea.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-linea.dtsi
rename to arch/arm/boot/dts/microchip/at91-linea.dtsi
diff --git a/arch/arm/boot/dts/at91-lmu5000.dts b/arch/arm/boot/dts/microchip/at91-lmu5000.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-lmu5000.dts
rename to arch/arm/boot/dts/microchip/at91-lmu5000.dts
diff --git a/arch/arm/boot/dts/at91-natte.dtsi b/arch/arm/boot/dts/microchip/at91-natte.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-natte.dtsi
rename to arch/arm/boot/dts/microchip/at91-natte.dtsi
diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/microchip/at91-nattis-2-natte-2.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-nattis-2-natte-2.dts
rename to arch/arm/boot/dts/microchip/at91-nattis-2-natte-2.dts
diff --git a/arch/arm/boot/dts/at91-q5xr5.dts b/arch/arm/boot/dts/microchip/at91-q5xr5.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-q5xr5.dts
rename to arch/arm/boot/dts/microchip/at91-q5xr5.dts
diff --git a/arch/arm/boot/dts/at91-qil_a9260.dts b/arch/arm/boot/dts/microchip/at91-qil_a9260.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-qil_a9260.dts
rename to arch/arm/boot/dts/microchip/at91-qil_a9260.dts
diff --git a/arch/arm/boot/dts/at91-sam9_l9260.dts b/arch/arm/boot/dts/microchip/at91-sam9_l9260.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sam9_l9260.dts
rename to arch/arm/boot/dts/microchip/at91-sam9_l9260.dts
diff --git a/arch/arm/boot/dts/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sam9x60_curiosity.dts
rename to arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sam9x60ek.dts
rename to arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d27_som1.dtsi
rename to arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi
diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
rename to arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
rename to arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
rename to arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d2_icp.dts
rename to arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
rename to arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d2_xplained.dts
rename to arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
diff --git a/arch/arm/boot/dts/at91-sama5d3_eds.dts b/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d3_eds.dts
rename to arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
diff --git a/arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dts b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dts
rename to arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d3_xplained.dts
rename to arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts
diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d4_ma5d4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
rename to arch/arm/boot/dts/microchip/at91-sama5d4_ma5d4.dtsi
diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts b/arch/arm/boot/dts/microchip/at91-sama5d4_ma5d4evk.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
rename to arch/arm/boot/dts/microchip/at91-sama5d4_ma5d4evk.dts
diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d4_xplained.dts
rename to arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts
diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d4ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sama5d4ek.dts
rename to arch/arm/boot/dts/microchip/at91-sama5d4ek.dts
diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-sama7g5ek.dts
rename to arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
diff --git a/arch/arm/boot/dts/at91-smartkiz.dts b/arch/arm/boot/dts/microchip/at91-smartkiz.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-smartkiz.dts
rename to arch/arm/boot/dts/microchip/at91-smartkiz.dts
diff --git a/arch/arm/boot/dts/at91-som60.dtsi b/arch/arm/boot/dts/microchip/at91-som60.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-som60.dtsi
rename to arch/arm/boot/dts/microchip/at91-som60.dtsi
diff --git a/arch/arm/boot/dts/at91-tse850-3.dts b/arch/arm/boot/dts/microchip/at91-tse850-3.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-tse850-3.dts
rename to arch/arm/boot/dts/microchip/at91-tse850-3.dts
diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/microchip/at91-vinco.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-vinco.dts
rename to arch/arm/boot/dts/microchip/at91-vinco.dts
diff --git a/arch/arm/boot/dts/at91-wb45n.dts b/arch/arm/boot/dts/microchip/at91-wb45n.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-wb45n.dts
rename to arch/arm/boot/dts/microchip/at91-wb45n.dts
diff --git a/arch/arm/boot/dts/at91-wb45n.dtsi b/arch/arm/boot/dts/microchip/at91-wb45n.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-wb45n.dtsi
rename to arch/arm/boot/dts/microchip/at91-wb45n.dtsi
diff --git a/arch/arm/boot/dts/at91-wb50n.dts b/arch/arm/boot/dts/microchip/at91-wb50n.dts
similarity index 100%
rename from arch/arm/boot/dts/at91-wb50n.dts
rename to arch/arm/boot/dts/microchip/at91-wb50n.dts
diff --git a/arch/arm/boot/dts/at91-wb50n.dtsi b/arch/arm/boot/dts/microchip/at91-wb50n.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91-wb50n.dtsi
rename to arch/arm/boot/dts/microchip/at91-wb50n.dtsi
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/microchip/at91rm9200.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91rm9200.dtsi
rename to arch/arm/boot/dts/microchip/at91rm9200.dtsi
diff --git a/arch/arm/boot/dts/at91rm9200_pqfp.dtsi b/arch/arm/boot/dts/microchip/at91rm9200_pqfp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91rm9200_pqfp.dtsi
rename to arch/arm/boot/dts/microchip/at91rm9200_pqfp.dtsi
diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/microchip/at91rm9200ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91rm9200ek.dts
rename to arch/arm/boot/dts/microchip/at91rm9200ek.dts
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/microchip/at91sam9260.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9260.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9260.dtsi
diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/microchip/at91sam9260ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9260ek.dts
rename to arch/arm/boot/dts/microchip/at91sam9260ek.dts
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/microchip/at91sam9261.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9261.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9261.dtsi
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/microchip/at91sam9261ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9261ek.dts
rename to arch/arm/boot/dts/microchip/at91sam9261ek.dts
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/microchip/at91sam9263.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9263.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9263.dtsi
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9263ek.dts
rename to arch/arm/boot/dts/microchip/at91sam9263ek.dts
diff --git a/arch/arm/boot/dts/at91sam9g15.dtsi b/arch/arm/boot/dts/microchip/at91sam9g15.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g15.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9g15.dtsi
diff --git a/arch/arm/boot/dts/at91sam9g15ek.dts b/arch/arm/boot/dts/microchip/at91sam9g15ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g15ek.dts
rename to arch/arm/boot/dts/microchip/at91sam9g15ek.dts
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/microchip/at91sam9g20.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g20.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9g20.dtsi
diff --git a/arch/arm/boot/dts/at91sam9g20ek.dts b/arch/arm/boot/dts/microchip/at91sam9g20ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g20ek.dts
rename to arch/arm/boot/dts/microchip/at91sam9g20ek.dts
diff --git a/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts b/arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
rename to arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g20ek_common.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi
diff --git a/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts b/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
rename to arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/microchip/at91sam9g25.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g25.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9g25.dtsi
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/microchip/at91sam9g25ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g25ek.dts
rename to arch/arm/boot/dts/microchip/at91sam9g25ek.dts
diff --git a/arch/arm/boot/dts/at91sam9g35.dtsi b/arch/arm/boot/dts/microchip/at91sam9g35.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g35.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9g35.dtsi
diff --git a/arch/arm/boot/dts/at91sam9g35ek.dts b/arch/arm/boot/dts/microchip/at91sam9g35ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g35ek.dts
rename to arch/arm/boot/dts/microchip/at91sam9g35ek.dts
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g45.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9g45.dtsi
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9m10g45ek.dts
rename to arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/microchip/at91sam9n12.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9n12.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9n12.dtsi
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/microchip/at91sam9n12ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9n12ek.dts
rename to arch/arm/boot/dts/microchip/at91sam9n12ek.dts
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/microchip/at91sam9rl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9rl.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9rl.dtsi
diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/microchip/at91sam9rlek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9rlek.dts
rename to arch/arm/boot/dts/microchip/at91sam9rlek.dts
diff --git a/arch/arm/boot/dts/at91sam9x25.dtsi b/arch/arm/boot/dts/microchip/at91sam9x25.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x25.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9x25.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x25ek.dts b/arch/arm/boot/dts/microchip/at91sam9x25ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x25ek.dts
rename to arch/arm/boot/dts/microchip/at91sam9x25ek.dts
diff --git a/arch/arm/boot/dts/at91sam9x35.dtsi b/arch/arm/boot/dts/microchip/at91sam9x35.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x35.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9x35.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x35ek.dts b/arch/arm/boot/dts/microchip/at91sam9x35ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x35ek.dts
rename to arch/arm/boot/dts/microchip/at91sam9x35ek.dts
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x5.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9x5.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x5_can.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5_can.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x5_can.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9x5_can.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x5_isi.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5_isi.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x5_isi.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9x5_isi.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x5_lcd.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5_lcd.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x5_lcd.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9x5_lcd.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x5_macb0.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5_macb0.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x5_macb0.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9x5_macb0.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x5_macb1.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5_macb1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x5_macb1.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9x5_macb1.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5_usart3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x5_usart3.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9x5_usart3.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x5cm.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x5dm.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5dm.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x5dm.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9x5dm.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5ek.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x5ek.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9x5ek.dtsi
diff --git a/arch/arm/boot/dts/at91sam9xe.dtsi b/arch/arm/boot/dts/microchip/at91sam9xe.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9xe.dtsi
rename to arch/arm/boot/dts/microchip/at91sam9xe.dtsi
diff --git a/arch/arm/boot/dts/ethernut5.dts b/arch/arm/boot/dts/microchip/ethernut5.dts
similarity index 100%
rename from arch/arm/boot/dts/ethernut5.dts
rename to arch/arm/boot/dts/microchip/ethernut5.dts
diff --git a/arch/arm/boot/dts/evk-pro3.dts b/arch/arm/boot/dts/microchip/evk-pro3.dts
similarity index 100%
rename from arch/arm/boot/dts/evk-pro3.dts
rename to arch/arm/boot/dts/microchip/evk-pro3.dts
diff --git a/arch/arm/boot/dts/ge863-pro3.dtsi b/arch/arm/boot/dts/microchip/ge863-pro3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ge863-pro3.dtsi
rename to arch/arm/boot/dts/microchip/ge863-pro3.dtsi
diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts b/arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
similarity index 100%
rename from arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
rename to arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts b/arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt-8g.dts
similarity index 100%
rename from arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
rename to arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt-8g.dts
diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi b/arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt.dtsi
similarity index 100%
rename from arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
rename to arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt.dtsi
diff --git a/arch/arm/boot/dts/lan966x-pcb8290.dts b/arch/arm/boot/dts/microchip/lan966x-pcb8290.dts
similarity index 100%
rename from arch/arm/boot/dts/lan966x-pcb8290.dts
rename to arch/arm/boot/dts/microchip/lan966x-pcb8290.dts
diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/microchip/lan966x-pcb8291.dts
similarity index 100%
rename from arch/arm/boot/dts/lan966x-pcb8291.dts
rename to arch/arm/boot/dts/microchip/lan966x-pcb8291.dts
diff --git a/arch/arm/boot/dts/lan966x-pcb8309.dts b/arch/arm/boot/dts/microchip/lan966x-pcb8309.dts
similarity index 100%
rename from arch/arm/boot/dts/lan966x-pcb8309.dts
rename to arch/arm/boot/dts/microchip/lan966x-pcb8309.dts
diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/microchip/lan966x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/lan966x.dtsi
rename to arch/arm/boot/dts/microchip/lan966x.dtsi
diff --git a/arch/arm/boot/dts/mpa1600.dts b/arch/arm/boot/dts/microchip/mpa1600.dts
similarity index 100%
rename from arch/arm/boot/dts/mpa1600.dts
rename to arch/arm/boot/dts/microchip/mpa1600.dts
diff --git a/arch/arm/boot/dts/pm9g45.dts b/arch/arm/boot/dts/microchip/pm9g45.dts
similarity index 100%
rename from arch/arm/boot/dts/pm9g45.dts
rename to arch/arm/boot/dts/microchip/pm9g45.dts
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sam9x60.dtsi
rename to arch/arm/boot/dts/microchip/sam9x60.dtsi
diff --git a/arch/arm/boot/dts/sama5d2-pinfunc.h b/arch/arm/boot/dts/microchip/sama5d2-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/sama5d2-pinfunc.h
rename to arch/arm/boot/dts/microchip/sama5d2-pinfunc.h
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/microchip/sama5d2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d2.dtsi
rename to arch/arm/boot/dts/microchip/sama5d2.dtsi
diff --git a/arch/arm/boot/dts/sama5d29.dtsi b/arch/arm/boot/dts/microchip/sama5d29.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d29.dtsi
rename to arch/arm/boot/dts/microchip/sama5d29.dtsi
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/microchip/sama5d3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3.dtsi
diff --git a/arch/arm/boot/dts/sama5d31.dtsi b/arch/arm/boot/dts/microchip/sama5d31.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d31.dtsi
rename to arch/arm/boot/dts/microchip/sama5d31.dtsi
diff --git a/arch/arm/boot/dts/sama5d31ek.dts b/arch/arm/boot/dts/microchip/sama5d31ek.dts
similarity index 100%
rename from arch/arm/boot/dts/sama5d31ek.dts
rename to arch/arm/boot/dts/microchip/sama5d31ek.dts
diff --git a/arch/arm/boot/dts/sama5d33.dtsi b/arch/arm/boot/dts/microchip/sama5d33.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d33.dtsi
rename to arch/arm/boot/dts/microchip/sama5d33.dtsi
diff --git a/arch/arm/boot/dts/sama5d33ek.dts b/arch/arm/boot/dts/microchip/sama5d33ek.dts
similarity index 100%
rename from arch/arm/boot/dts/sama5d33ek.dts
rename to arch/arm/boot/dts/microchip/sama5d33ek.dts
diff --git a/arch/arm/boot/dts/sama5d34.dtsi b/arch/arm/boot/dts/microchip/sama5d34.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d34.dtsi
rename to arch/arm/boot/dts/microchip/sama5d34.dtsi
diff --git a/arch/arm/boot/dts/sama5d34ek.dts b/arch/arm/boot/dts/microchip/sama5d34ek.dts
similarity index 100%
rename from arch/arm/boot/dts/sama5d34ek.dts
rename to arch/arm/boot/dts/microchip/sama5d34ek.dts
diff --git a/arch/arm/boot/dts/sama5d35.dtsi b/arch/arm/boot/dts/microchip/sama5d35.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d35.dtsi
rename to arch/arm/boot/dts/microchip/sama5d35.dtsi
diff --git a/arch/arm/boot/dts/sama5d35ek.dts b/arch/arm/boot/dts/microchip/sama5d35ek.dts
similarity index 100%
rename from arch/arm/boot/dts/sama5d35ek.dts
rename to arch/arm/boot/dts/microchip/sama5d35ek.dts
diff --git a/arch/arm/boot/dts/sama5d36.dtsi b/arch/arm/boot/dts/microchip/sama5d36.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d36.dtsi
rename to arch/arm/boot/dts/microchip/sama5d36.dtsi
diff --git a/arch/arm/boot/dts/sama5d36ek.dts b/arch/arm/boot/dts/microchip/sama5d36ek.dts
similarity index 100%
rename from arch/arm/boot/dts/sama5d36ek.dts
rename to arch/arm/boot/dts/microchip/sama5d36ek.dts
diff --git a/arch/arm/boot/dts/sama5d36ek_cmp.dts b/arch/arm/boot/dts/microchip/sama5d36ek_cmp.dts
similarity index 100%
rename from arch/arm/boot/dts/sama5d36ek_cmp.dts
rename to arch/arm/boot/dts/microchip/sama5d36ek_cmp.dts
diff --git a/arch/arm/boot/dts/sama5d3_can.dtsi b/arch/arm/boot/dts/microchip/sama5d3_can.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3_can.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3_can.dtsi
diff --git a/arch/arm/boot/dts/sama5d3_emac.dtsi b/arch/arm/boot/dts/microchip/sama5d3_emac.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3_emac.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3_emac.dtsi
diff --git a/arch/arm/boot/dts/sama5d3_gmac.dtsi b/arch/arm/boot/dts/microchip/sama5d3_gmac.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3_gmac.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3_gmac.dtsi
diff --git a/arch/arm/boot/dts/sama5d3_lcd.dtsi b/arch/arm/boot/dts/microchip/sama5d3_lcd.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3_lcd.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3_lcd.dtsi
diff --git a/arch/arm/boot/dts/sama5d3_mci2.dtsi b/arch/arm/boot/dts/microchip/sama5d3_mci2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3_mci2.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3_mci2.dtsi
diff --git a/arch/arm/boot/dts/sama5d3_tcb1.dtsi b/arch/arm/boot/dts/microchip/sama5d3_tcb1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3_tcb1.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3_tcb1.dtsi
diff --git a/arch/arm/boot/dts/sama5d3_uart.dtsi b/arch/arm/boot/dts/microchip/sama5d3_uart.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3_uart.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3_uart.dtsi
diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/microchip/sama5d3xcm.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3xcm.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3xcm.dtsi
diff --git a/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi b/arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi
diff --git a/arch/arm/boot/dts/sama5d3xdm.dtsi b/arch/arm/boot/dts/microchip/sama5d3xdm.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3xdm.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3xdm.dtsi
diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/microchip/sama5d3xmb.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3xmb.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3xmb.dtsi
diff --git a/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi b/arch/arm/boot/dts/microchip/sama5d3xmb_cmp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3xmb_cmp.dtsi
diff --git a/arch/arm/boot/dts/sama5d3xmb_emac.dtsi b/arch/arm/boot/dts/microchip/sama5d3xmb_emac.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3xmb_emac.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3xmb_emac.dtsi
diff --git a/arch/arm/boot/dts/sama5d3xmb_gmac.dtsi b/arch/arm/boot/dts/microchip/sama5d3xmb_gmac.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d3xmb_gmac.dtsi
rename to arch/arm/boot/dts/microchip/sama5d3xmb_gmac.dtsi
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/microchip/sama5d4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama5d4.dtsi
rename to arch/arm/boot/dts/microchip/sama5d4.dtsi
diff --git a/arch/arm/boot/dts/sama7g5-pinfunc.h b/arch/arm/boot/dts/microchip/sama7g5-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/sama7g5-pinfunc.h
rename to arch/arm/boot/dts/microchip/sama7g5-pinfunc.h
diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sama7g5.dtsi
rename to arch/arm/boot/dts/microchip/sama7g5.dtsi
diff --git a/arch/arm/boot/dts/tny_a9260.dts b/arch/arm/boot/dts/microchip/tny_a9260.dts
similarity index 100%
rename from arch/arm/boot/dts/tny_a9260.dts
rename to arch/arm/boot/dts/microchip/tny_a9260.dts
diff --git a/arch/arm/boot/dts/tny_a9260_common.dtsi b/arch/arm/boot/dts/microchip/tny_a9260_common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tny_a9260_common.dtsi
rename to arch/arm/boot/dts/microchip/tny_a9260_common.dtsi
diff --git a/arch/arm/boot/dts/tny_a9263.dts b/arch/arm/boot/dts/microchip/tny_a9263.dts
similarity index 100%
rename from arch/arm/boot/dts/tny_a9263.dts
rename to arch/arm/boot/dts/microchip/tny_a9263.dts
diff --git a/arch/arm/boot/dts/tny_a9g20.dts b/arch/arm/boot/dts/microchip/tny_a9g20.dts
similarity index 100%
rename from arch/arm/boot/dts/tny_a9g20.dts
rename to arch/arm/boot/dts/microchip/tny_a9g20.dts
diff --git a/arch/arm/boot/dts/usb_a9260.dts b/arch/arm/boot/dts/microchip/usb_a9260.dts
similarity index 100%
rename from arch/arm/boot/dts/usb_a9260.dts
rename to arch/arm/boot/dts/microchip/usb_a9260.dts
diff --git a/arch/arm/boot/dts/usb_a9260_common.dtsi b/arch/arm/boot/dts/microchip/usb_a9260_common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/usb_a9260_common.dtsi
rename to arch/arm/boot/dts/microchip/usb_a9260_common.dtsi
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/microchip/usb_a9263.dts
similarity index 100%
rename from arch/arm/boot/dts/usb_a9263.dts
rename to arch/arm/boot/dts/microchip/usb_a9263.dts
diff --git a/arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi b/arch/arm/boot/dts/microchip/usb_a9g20-dab-mmx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi
rename to arch/arm/boot/dts/microchip/usb_a9g20-dab-mmx.dtsi
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/microchip/usb_a9g20.dts
similarity index 100%
rename from arch/arm/boot/dts/usb_a9g20.dts
rename to arch/arm/boot/dts/microchip/usb_a9g20.dts
diff --git a/arch/arm/boot/dts/usb_a9g20_common.dtsi b/arch/arm/boot/dts/microchip/usb_a9g20_common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/usb_a9g20_common.dtsi
rename to arch/arm/boot/dts/microchip/usb_a9g20_common.dtsi
diff --git a/arch/arm/boot/dts/usb_a9g20_lpw.dts b/arch/arm/boot/dts/microchip/usb_a9g20_lpw.dts
similarity index 100%
rename from arch/arm/boot/dts/usb_a9g20_lpw.dts
rename to arch/arm/boot/dts/microchip/usb_a9g20_lpw.dts
diff --git a/arch/arm/boot/dts/moxa/Makefile b/arch/arm/boot/dts/moxa/Makefile
new file mode 100644
index 000000000000..d61ce8d4e732
--- /dev/null
+++ b/arch/arm/boot/dts/moxa/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_MOXART) += \
+	moxart-uc7112lx.dtb
diff --git a/arch/arm/boot/dts/moxart-uc7112lx.dts b/arch/arm/boot/dts/moxa/moxart-uc7112lx.dts
similarity index 100%
rename from arch/arm/boot/dts/moxart-uc7112lx.dts
rename to arch/arm/boot/dts/moxa/moxart-uc7112lx.dts
diff --git a/arch/arm/boot/dts/moxart.dtsi b/arch/arm/boot/dts/moxa/moxart.dtsi
similarity index 100%
rename from arch/arm/boot/dts/moxart.dtsi
rename to arch/arm/boot/dts/moxa/moxart.dtsi
diff --git a/arch/arm/boot/dts/nspire/Makefile b/arch/arm/boot/dts/nspire/Makefile
new file mode 100644
index 000000000000..82a2515bdd46
--- /dev/null
+++ b/arch/arm/boot/dts/nspire/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_NSPIRE) += \
+	nspire-cx.dtb \
+	nspire-tp.dtb \
+	nspire-clp.dtb
diff --git a/arch/arm/boot/dts/nspire-classic.dtsi b/arch/arm/boot/dts/nspire/nspire-classic.dtsi
similarity index 100%
rename from arch/arm/boot/dts/nspire-classic.dtsi
rename to arch/arm/boot/dts/nspire/nspire-classic.dtsi
diff --git a/arch/arm/boot/dts/nspire-clp.dts b/arch/arm/boot/dts/nspire/nspire-clp.dts
similarity index 100%
rename from arch/arm/boot/dts/nspire-clp.dts
rename to arch/arm/boot/dts/nspire/nspire-clp.dts
diff --git a/arch/arm/boot/dts/nspire-cx.dts b/arch/arm/boot/dts/nspire/nspire-cx.dts
similarity index 100%
rename from arch/arm/boot/dts/nspire-cx.dts
rename to arch/arm/boot/dts/nspire/nspire-cx.dts
diff --git a/arch/arm/boot/dts/nspire-tp.dts b/arch/arm/boot/dts/nspire/nspire-tp.dts
similarity index 100%
rename from arch/arm/boot/dts/nspire-tp.dts
rename to arch/arm/boot/dts/nspire/nspire-tp.dts
diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire/nspire.dtsi
similarity index 100%
rename from arch/arm/boot/dts/nspire.dtsi
rename to arch/arm/boot/dts/nspire/nspire.dtsi
diff --git a/arch/arm/boot/dts/nuvoton/Makefile b/arch/arm/boot/dts/nuvoton/Makefile
new file mode 100644
index 000000000000..89c157dad312
--- /dev/null
+++ b/arch/arm/boot/dts/nuvoton/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_NPCM7XX) += \
+	nuvoton-npcm730-gsj.dtb \
+	nuvoton-npcm730-gbs.dtb \
+	nuvoton-npcm730-kudo.dtb \
+	nuvoton-npcm750-evb.dtb \
+	nuvoton-npcm750-runbmc-olympus.dtb
+dtb-$(CONFIG_ARCH_WPCM450) += \
+	nuvoton-wpcm450-supermicro-x9sci-ln4f.dtb
diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
rename to arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts
similarity index 100%
rename from arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
rename to arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts
diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gsj-gpio.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj-gpio.dtsi
similarity index 100%
rename from arch/arm/boot/dts/nuvoton-npcm730-gsj-gpio.dtsi
rename to arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj-gpio.dtsi
diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dts
similarity index 100%
rename from arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
rename to arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dts
diff --git a/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
similarity index 100%
rename from arch/arm/boot/dts/nuvoton-npcm730-kudo.dts
rename to arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
diff --git a/arch/arm/boot/dts/nuvoton-npcm730.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730.dtsi
similarity index 100%
rename from arch/arm/boot/dts/nuvoton-npcm730.dtsi
rename to arch/arm/boot/dts/nuvoton/nuvoton-npcm730.dtsi
diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/nuvoton-npcm750-evb.dts
rename to arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dts
diff --git a/arch/arm/boot/dts/nuvoton-npcm750-pincfg-evb.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-pincfg-evb.dtsi
similarity index 100%
rename from arch/arm/boot/dts/nuvoton-npcm750-pincfg-evb.dtsi
rename to arch/arm/boot/dts/nuvoton/nuvoton-npcm750-pincfg-evb.dtsi
diff --git a/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus-pincfg.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus-pincfg.dtsi
similarity index 100%
rename from arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus-pincfg.dtsi
rename to arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus-pincfg.dtsi
diff --git a/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
similarity index 100%
rename from arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts
rename to arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi
similarity index 100%
rename from arch/arm/boot/dts/nuvoton-npcm750.dtsi
rename to arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi
diff --git a/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts b/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
similarity index 100%
rename from arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
rename to arch/arm/boot/dts/nuvoton/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
similarity index 100%
rename from arch/arm/boot/dts/nuvoton-wpcm450.dtsi
rename to arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
diff --git a/arch/arm/boot/dts/nvidia/Makefile b/arch/arm/boot/dts/nvidia/Makefile
new file mode 100644
index 000000000000..60091bf7e48b
--- /dev/null
+++ b/arch/arm/boot/dts/nvidia/Makefile
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_TEGRA_114_SOC) += \
+	tegra114-asus-tf701t.dtb \
+	tegra114-dalmore.dtb \
+	tegra114-roth.dtb \
+	tegra114-tn7.dtb
+dtb-$(CONFIG_ARCH_TEGRA_124_SOC) += \
+	tegra124-apalis-eval.dtb \
+	tegra124-apalis-v1.2-eval.dtb \
+	tegra124-jetson-tk1.dtb \
+	tegra124-nyan-big.dtb \
+	tegra124-nyan-big-fhd.dtb \
+	tegra124-nyan-blaze.dtb \
+	tegra124-venice2.dtb
+dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
+	tegra20-acer-a500-picasso.dtb \
+	tegra20-asus-tf101.dtb \
+	tegra20-harmony.dtb \
+	tegra20-colibri-eval-v3.dtb \
+	tegra20-colibri-iris.dtb \
+	tegra20-medcom-wide.dtb \
+	tegra20-paz00.dtb \
+	tegra20-plutux.dtb \
+	tegra20-seaboard.dtb \
+	tegra20-tec.dtb \
+	tegra20-trimslice.dtb \
+	tegra20-ventana.dtb
+dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += \
+	tegra30-apalis-eval.dtb \
+	tegra30-apalis-v1.1-eval.dtb \
+	tegra30-asus-nexus7-grouper-PM269.dtb \
+	tegra30-asus-nexus7-grouper-E1565.dtb \
+	tegra30-asus-nexus7-tilapia-E1565.dtb \
+	tegra30-asus-tf201.dtb \
+	tegra30-asus-tf300t.dtb \
+	tegra30-asus-tf300tg.dtb \
+	tegra30-asus-tf700t.dtb \
+	tegra30-beaver.dtb \
+	tegra30-cardhu-a02.dtb \
+	tegra30-cardhu-a04.dtb \
+	tegra30-colibri-eval-v3.dtb \
+	tegra30-ouya.dtb \
+	tegra30-pegatron-chagall.dtb
diff --git a/arch/arm/boot/dts/tegra114-asus-tf701t.dts b/arch/arm/boot/dts/nvidia/tegra114-asus-tf701t.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra114-asus-tf701t.dts
rename to arch/arm/boot/dts/nvidia/tegra114-asus-tf701t.dts
diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/nvidia/tegra114-dalmore.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra114-dalmore.dts
rename to arch/arm/boot/dts/nvidia/tegra114-dalmore.dts
diff --git a/arch/arm/boot/dts/tegra114-roth.dts b/arch/arm/boot/dts/nvidia/tegra114-roth.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra114-roth.dts
rename to arch/arm/boot/dts/nvidia/tegra114-roth.dts
diff --git a/arch/arm/boot/dts/tegra114-tn7.dts b/arch/arm/boot/dts/nvidia/tegra114-tn7.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra114-tn7.dts
rename to arch/arm/boot/dts/nvidia/tegra114-tn7.dts
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra114.dtsi
rename to arch/arm/boot/dts/nvidia/tegra114.dtsi
diff --git a/arch/arm/boot/dts/tegra124-apalis-emc.dtsi b/arch/arm/boot/dts/nvidia/tegra124-apalis-emc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra124-apalis-emc.dtsi
rename to arch/arm/boot/dts/nvidia/tegra124-apalis-emc.dtsi
diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/nvidia/tegra124-apalis-eval.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra124-apalis-eval.dts
rename to arch/arm/boot/dts/nvidia/tegra124-apalis-eval.dts
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/nvidia/tegra124-apalis-v1.2-eval.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
rename to arch/arm/boot/dts/nvidia/tegra124-apalis-v1.2-eval.dts
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/nvidia/tegra124-apalis-v1.2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
rename to arch/arm/boot/dts/nvidia/tegra124-apalis-v1.2.dtsi
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/nvidia/tegra124-apalis.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra124-apalis.dtsi
rename to arch/arm/boot/dts/nvidia/tegra124-apalis.dtsi
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi b/arch/arm/boot/dts/nvidia/tegra124-jetson-tk1-emc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi
rename to arch/arm/boot/dts/nvidia/tegra124-jetson-tk1-emc.dtsi
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/nvidia/tegra124-jetson-tk1.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra124-jetson-tk1.dts
rename to arch/arm/boot/dts/nvidia/tegra124-jetson-tk1.dts
diff --git a/arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi b/arch/arm/boot/dts/nvidia/tegra124-nyan-big-emc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi
rename to arch/arm/boot/dts/nvidia/tegra124-nyan-big-emc.dtsi
diff --git a/arch/arm/boot/dts/tegra124-nyan-big-fhd.dts b/arch/arm/boot/dts/nvidia/tegra124-nyan-big-fhd.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra124-nyan-big-fhd.dts
rename to arch/arm/boot/dts/nvidia/tegra124-nyan-big-fhd.dts
diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts b/arch/arm/boot/dts/nvidia/tegra124-nyan-big.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra124-nyan-big.dts
rename to arch/arm/boot/dts/nvidia/tegra124-nyan-big.dts
diff --git a/arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi b/arch/arm/boot/dts/nvidia/tegra124-nyan-blaze-emc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi
rename to arch/arm/boot/dts/nvidia/tegra124-nyan-blaze-emc.dtsi
diff --git a/arch/arm/boot/dts/tegra124-nyan-blaze.dts b/arch/arm/boot/dts/nvidia/tegra124-nyan-blaze.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra124-nyan-blaze.dts
rename to arch/arm/boot/dts/nvidia/tegra124-nyan-blaze.dts
diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/nvidia/tegra124-nyan.dtsi
similarity index 99%
rename from arch/arm/boot/dts/tegra124-nyan.dtsi
rename to arch/arm/boot/dts/nvidia/tegra124-nyan.dtsi
index 56952333ae28..0c35ca2e9121 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra124-nyan.dtsi
@@ -833,4 +833,4 @@ map0 {
 	};
 };
 
-#include "cros-ec-keyboard.dtsi"
+#include "../cros-ec-keyboard.dtsi"
diff --git a/arch/arm/boot/dts/tegra124-peripherals-opp.dtsi b/arch/arm/boot/dts/nvidia/tegra124-peripherals-opp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra124-peripherals-opp.dtsi
rename to arch/arm/boot/dts/nvidia/tegra124-peripherals-opp.dtsi
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/nvidia/tegra124-venice2.dts
similarity index 99%
rename from arch/arm/boot/dts/tegra124-venice2.dts
rename to arch/arm/boot/dts/nvidia/tegra124-venice2.dts
index 7e739879c00c..c697301c443c 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/nvidia/tegra124-venice2.dts
@@ -1253,4 +1253,4 @@ sound {
 	};
 };
 
-#include "cros-ec-keyboard.dtsi"
+#include "../cros-ec-keyboard.dtsi"
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/nvidia/tegra124.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra124.dtsi
rename to arch/arm/boot/dts/nvidia/tegra124.dtsi
diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/nvidia/tegra20-acer-a500-picasso.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
rename to arch/arm/boot/dts/nvidia/tegra20-acer-a500-picasso.dts
diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra20-asus-tf101.dts
rename to arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
diff --git a/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts b/arch/arm/boot/dts/nvidia/tegra20-colibri-eval-v3.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
rename to arch/arm/boot/dts/nvidia/tegra20-colibri-eval-v3.dts
diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/nvidia/tegra20-colibri-iris.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra20-colibri-iris.dts
rename to arch/arm/boot/dts/nvidia/tegra20-colibri-iris.dts
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra20-colibri.dtsi
rename to arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi
diff --git a/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi b/arch/arm/boot/dts/nvidia/tegra20-cpu-opp-microvolt.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
rename to arch/arm/boot/dts/nvidia/tegra20-cpu-opp-microvolt.dtsi
diff --git a/arch/arm/boot/dts/tegra20-cpu-opp.dtsi b/arch/arm/boot/dts/nvidia/tegra20-cpu-opp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra20-cpu-opp.dtsi
rename to arch/arm/boot/dts/nvidia/tegra20-cpu-opp.dtsi
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/nvidia/tegra20-harmony.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra20-harmony.dts
rename to arch/arm/boot/dts/nvidia/tegra20-harmony.dts
diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/nvidia/tegra20-medcom-wide.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra20-medcom-wide.dts
rename to arch/arm/boot/dts/nvidia/tegra20-medcom-wide.dts
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/nvidia/tegra20-paz00.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra20-paz00.dts
rename to arch/arm/boot/dts/nvidia/tegra20-paz00.dts
diff --git a/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi b/arch/arm/boot/dts/nvidia/tegra20-peripherals-opp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
rename to arch/arm/boot/dts/nvidia/tegra20-peripherals-opp.dtsi
diff --git a/arch/arm/boot/dts/tegra20-plutux.dts b/arch/arm/boot/dts/nvidia/tegra20-plutux.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra20-plutux.dts
rename to arch/arm/boot/dts/nvidia/tegra20-plutux.dts
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/nvidia/tegra20-seaboard.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra20-seaboard.dts
rename to arch/arm/boot/dts/nvidia/tegra20-seaboard.dts
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/nvidia/tegra20-tamonten.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra20-tamonten.dtsi
rename to arch/arm/boot/dts/nvidia/tegra20-tamonten.dtsi
diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/nvidia/tegra20-tec.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra20-tec.dts
rename to arch/arm/boot/dts/nvidia/tegra20-tec.dts
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/nvidia/tegra20-trimslice.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra20-trimslice.dts
rename to arch/arm/boot/dts/nvidia/tegra20-trimslice.dts
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/nvidia/tegra20-ventana.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra20-ventana.dts
rename to arch/arm/boot/dts/nvidia/tegra20-ventana.dts
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/nvidia/tegra20.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra20.dtsi
rename to arch/arm/boot/dts/nvidia/tegra20.dtsi
diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/nvidia/tegra30-apalis-eval.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-apalis-eval.dts
rename to arch/arm/boot/dts/nvidia/tegra30-apalis-eval.dts
diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts b/arch/arm/boot/dts/nvidia/tegra30-apalis-v1.1-eval.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
rename to arch/arm/boot/dts/nvidia/tegra30-apalis-v1.1-eval.dts
diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi b/arch/arm/boot/dts/nvidia/tegra30-apalis-v1.1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-apalis-v1.1.dtsi
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/nvidia/tegra30-apalis.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-apalis.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-apalis.dtsi
diff --git a/arch/arm/boot/dts/tegra30-asus-lvds-display.dtsi b/arch/arm/boot/dts/nvidia/tegra30-asus-lvds-display.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-lvds-display.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-asus-lvds-display.dtsi
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-E1565.dts b/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-E1565.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-nexus7-grouper-E1565.dts
rename to arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-E1565.dts
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-PM269.dts b/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-PM269.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-nexus7-grouper-PM269.dts
rename to arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-PM269.dts
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-common.dtsi
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi b/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-memory-timings.dtsi b/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-memory-timings.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-nexus7-grouper-memory-timings.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-memory-timings.dtsi
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi b/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-ti-pmic.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-ti-pmic.dtsi
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dtsi b/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper.dtsi
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-tilapia-E1565.dts b/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-tilapia-E1565.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-nexus7-tilapia-E1565.dts
rename to arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-tilapia-E1565.dts
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-tilapia-memory-timings.dtsi b/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-tilapia-memory-timings.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-nexus7-tilapia-memory-timings.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-tilapia-memory-timings.dtsi
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi b/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-tilapia.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-tilapia.dtsi
diff --git a/arch/arm/boot/dts/tegra30-asus-tf201.dts b/arch/arm/boot/dts/nvidia/tegra30-asus-tf201.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-tf201.dts
rename to arch/arm/boot/dts/nvidia/tegra30-asus-tf201.dts
diff --git a/arch/arm/boot/dts/tegra30-asus-tf300t.dts b/arch/arm/boot/dts/nvidia/tegra30-asus-tf300t.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-tf300t.dts
rename to arch/arm/boot/dts/nvidia/tegra30-asus-tf300t.dts
diff --git a/arch/arm/boot/dts/tegra30-asus-tf300tg.dts b/arch/arm/boot/dts/nvidia/tegra30-asus-tf300tg.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-tf300tg.dts
rename to arch/arm/boot/dts/nvidia/tegra30-asus-tf300tg.dts
diff --git a/arch/arm/boot/dts/tegra30-asus-tf700t.dts b/arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-tf700t.dts
rename to arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dts
diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arch/arm/boot/dts/nvidia/tegra30-asus-transformer-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-asus-transformer-common.dtsi
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/nvidia/tegra30-beaver.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-beaver.dts
rename to arch/arm/boot/dts/nvidia/tegra30-beaver.dts
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a02.dts b/arch/arm/boot/dts/nvidia/tegra30-cardhu-a02.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-cardhu-a02.dts
rename to arch/arm/boot/dts/nvidia/tegra30-cardhu-a02.dts
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/nvidia/tegra30-cardhu-a04.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-cardhu-a04.dts
rename to arch/arm/boot/dts/nvidia/tegra30-cardhu-a04.dts
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/nvidia/tegra30-cardhu.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-cardhu.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-cardhu.dtsi
diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/nvidia/tegra30-colibri-eval-v3.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
rename to arch/arm/boot/dts/nvidia/tegra30-colibri-eval-v3.dts
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/nvidia/tegra30-colibri.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-colibri.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-colibri.dtsi
diff --git a/arch/arm/boot/dts/tegra30-cpu-opp-microvolt.dtsi b/arch/arm/boot/dts/nvidia/tegra30-cpu-opp-microvolt.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-cpu-opp-microvolt.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-cpu-opp-microvolt.dtsi
diff --git a/arch/arm/boot/dts/tegra30-cpu-opp.dtsi b/arch/arm/boot/dts/nvidia/tegra30-cpu-opp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-cpu-opp.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-cpu-opp.dtsi
diff --git a/arch/arm/boot/dts/tegra30-ouya.dts b/arch/arm/boot/dts/nvidia/tegra30-ouya.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-ouya.dts
rename to arch/arm/boot/dts/nvidia/tegra30-ouya.dts
diff --git a/arch/arm/boot/dts/tegra30-pegatron-chagall.dts b/arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra30-pegatron-chagall.dts
rename to arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dts
diff --git a/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi b/arch/arm/boot/dts/nvidia/tegra30-peripherals-opp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30-peripherals-opp.dtsi
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/nvidia/tegra30.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tegra30.dtsi
rename to arch/arm/boot/dts/nvidia/tegra30.dtsi
diff --git a/arch/arm/boot/dts/nxp/Makefile b/arch/arm/boot/dts/nxp/Makefile
new file mode 100644
index 000000000000..db44e7a0a198
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+subdir-y += imx
+subdir-y += lpc
+subdir-y += ls
+subdir-y += mxs
+subdir-y += vf
diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
new file mode 100644
index 000000000000..88736c711aa5
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -0,0 +1,387 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_SOC_IMX1) += \
+	imx1-ads.dtb \
+	imx1-apf9328.dtb
+dtb-$(CONFIG_SOC_IMX25) += \
+	imx25-eukrea-mbimxsd25-baseboard.dtb \
+	imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb \
+	imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb \
+	imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb \
+	imx25-karo-tx25.dtb \
+	imx25-pdk.dtb
+dtb-$(CONFIG_SOC_IMX27) += \
+	imx27-apf27.dtb \
+	imx27-apf27dev.dtb \
+	imx27-eukrea-mbimxsd27-baseboard.dtb \
+	imx27-pdk.dtb \
+	imx27-phytec-phycore-rdk.dtb \
+	imx27-phytec-phycard-s-rdk.dtb
+dtb-$(CONFIG_SOC_IMX31) += \
+	imx31-bug.dtb \
+	imx31-lite.dtb
+dtb-$(CONFIG_SOC_IMX35) += \
+	imx35-eukrea-mbimxsd35-baseboard.dtb \
+	imx35-pdk.dtb
+dtb-$(CONFIG_SOC_IMX50) += \
+	imx50-evk.dtb \
+	imx50-kobo-aura.dtb
+dtb-$(CONFIG_SOC_IMX51) += \
+	imx51-apf51.dtb \
+	imx51-apf51dev.dtb \
+	imx51-babbage.dtb \
+	imx51-digi-connectcore-jsk.dtb \
+	imx51-eukrea-mbimxsd51-baseboard.dtb \
+	imx51-ts4800.dtb \
+	imx51-zii-rdu1.dtb \
+	imx51-zii-scu2-mezz.dtb \
+	imx51-zii-scu3-esb.dtb
+dtb-$(CONFIG_SOC_IMX53) += \
+	imx53-ard.dtb \
+	imx53-cx9020.dtb \
+	imx53-kp-ddc.dtb \
+	imx53-kp-hsc.dtb \
+	imx53-m53evk.dtb \
+	imx53-m53menlo.dtb \
+	imx53-mba53.dtb \
+	imx53-ppd.dtb \
+	imx53-qsb.dtb \
+	imx53-qsrb.dtb \
+	imx53-sk-imx53.dtb \
+	imx53-smd.dtb \
+	imx53-tx53-x03x.dtb \
+	imx53-tx53-x13x.dtb \
+	imx53-usbarmory.dtb \
+	imx53-voipac-bsb.dtb
+dtb-$(CONFIG_SOC_IMX6Q) += \
+	imx6dl-alti6p.dtb \
+	imx6dl-apf6dev.dtb \
+	imx6dl-aristainetos_4.dtb \
+	imx6dl-aristainetos_7.dtb \
+	imx6dl-aristainetos2_4.dtb \
+	imx6dl-aristainetos2_7.dtb \
+	imx6dl-colibri-aster.dtb \
+	imx6dl-colibri-eval-v3.dtb \
+	imx6dl-colibri-iris.dtb \
+	imx6dl-colibri-iris-v2.dtb \
+	imx6dl-cubox-i.dtb \
+	imx6dl-cubox-i-emmc-som-v15.dtb \
+	imx6dl-cubox-i-som-v15.dtb \
+	imx6dl-dfi-fs700-m60.dtb \
+	imx6dl-dhcom-picoitx.dtb \
+	imx6dl-eckelmann-ci4x10.dtb \
+	imx6dl-emcon-avari.dtb \
+	imx6dl-gw51xx.dtb \
+	imx6dl-gw52xx.dtb \
+	imx6dl-gw53xx.dtb \
+	imx6dl-gw54xx.dtb \
+	imx6dl-gw551x.dtb \
+	imx6dl-gw552x.dtb \
+	imx6dl-gw553x.dtb \
+	imx6dl-gw560x.dtb \
+	imx6dl-gw5903.dtb \
+	imx6dl-gw5904.dtb \
+	imx6dl-gw5907.dtb \
+	imx6dl-gw5910.dtb \
+	imx6dl-gw5912.dtb \
+	imx6dl-gw5913.dtb \
+	imx6dl-hummingboard.dtb \
+	imx6dl-hummingboard-emmc-som-v15.dtb \
+	imx6dl-hummingboard-som-v15.dtb \
+	imx6dl-hummingboard2.dtb \
+	imx6dl-hummingboard2-emmc-som-v15.dtb \
+	imx6dl-hummingboard2-som-v15.dtb \
+	imx6dl-icore.dtb \
+	imx6dl-icore-mipi.dtb \
+	imx6dl-icore-rqs.dtb \
+	imx6dl-lanmcu.dtb \
+	imx6dl-mamoj.dtb \
+	imx6dl-mba6a.dtb \
+	imx6dl-mba6b.dtb \
+	imx6dl-nit6xlite.dtb \
+	imx6dl-nitrogen6x.dtb \
+	imx6dl-phytec-mira-rdk-nand.dtb \
+	imx6dl-phytec-pbab01.dtb \
+	imx6dl-pico-dwarf.dtb \
+	imx6dl-pico-hobbit.dtb \
+	imx6dl-pico-nymph.dtb \
+	imx6dl-pico-pi.dtb \
+	imx6dl-plybas.dtb \
+	imx6dl-plym2m.dtb \
+	imx6dl-prtmvt.dtb \
+	imx6dl-prtrvt.dtb \
+	imx6dl-prtvt7.dtb \
+	imx6dl-rex-basic.dtb \
+	imx6dl-riotboard.dtb \
+	imx6dl-sabreauto.dtb \
+	imx6dl-sabrelite.dtb \
+	imx6dl-sabresd.dtb \
+	imx6dl-savageboard.dtb \
+	imx6dl-skov-revc-lt2.dtb \
+	imx6dl-skov-revc-lt6.dtb \
+	imx6dl-solidsense.dtb \
+	imx6dl-ts4900.dtb \
+	imx6dl-ts7970.dtb \
+	imx6dl-tx6dl-comtft.dtb \
+	imx6dl-tx6s-8034.dtb \
+	imx6dl-tx6s-8034-mb7.dtb \
+	imx6dl-tx6s-8035.dtb \
+	imx6dl-tx6s-8035-mb7.dtb \
+	imx6dl-tx6u-801x.dtb \
+	imx6dl-tx6u-80xx-mb7.dtb \
+	imx6dl-tx6u-8033.dtb \
+	imx6dl-tx6u-8033-mb7.dtb \
+	imx6dl-tx6u-811x.dtb \
+	imx6dl-tx6u-81xx-mb7.dtb \
+	imx6dl-udoo.dtb \
+	imx6dl-victgo.dtb \
+	imx6dl-vicut1.dtb \
+	imx6dl-wandboard.dtb \
+	imx6dl-wandboard-revb1.dtb \
+	imx6dl-wandboard-revd1.dtb \
+	imx6dl-yapp4-draco.dtb \
+	imx6dl-yapp4-hydra.dtb \
+	imx6dl-yapp4-lynx.dtb \
+	imx6dl-yapp4-orion.dtb \
+	imx6dl-yapp4-phoenix.dtb \
+	imx6dl-yapp4-ursa.dtb \
+	imx6q-apalis-eval.dtb \
+	imx6q-apalis-ixora.dtb \
+	imx6q-apalis-ixora-v1.1.dtb \
+	imx6q-apalis-ixora-v1.2.dtb \
+	imx6q-apf6dev.dtb \
+	imx6q-arm2.dtb \
+	imx6q-b450v3.dtb \
+	imx6q-b650v3.dtb \
+	imx6q-b850v3.dtb \
+	imx6q-bosch-acc.dtb \
+	imx6q-cm-fx6.dtb \
+	imx6q-cubox-i.dtb \
+	imx6q-cubox-i-emmc-som-v15.dtb \
+	imx6q-cubox-i-som-v15.dtb \
+	imx6q-dfi-fs700-m60.dtb \
+	imx6q-dhcom-pdk2.dtb \
+	imx6q-display5-tianma-tm070-1280x768.dtb \
+	imx6q-dmo-edmqmx6.dtb \
+	imx6q-dms-ba16.dtb \
+	imx6q-ds.dtb \
+	imx6q-emcon-avari.dtb \
+	imx6q-evi.dtb \
+	imx6dl-b105pv2.dtb \
+	imx6dl-b105v2.dtb \
+	imx6dl-b125v2.dtb \
+	imx6dl-b125pv2.dtb \
+	imx6dl-b155v2.dtb \
+	imx6q-gk802.dtb \
+	imx6q-gw51xx.dtb \
+	imx6q-gw52xx.dtb \
+	imx6q-gw53xx.dtb \
+	imx6q-gw5400-a.dtb \
+	imx6q-gw54xx.dtb \
+	imx6q-gw551x.dtb \
+	imx6q-gw552x.dtb \
+	imx6q-gw553x.dtb \
+	imx6q-gw560x.dtb \
+	imx6q-gw5903.dtb \
+	imx6q-gw5904.dtb \
+	imx6q-gw5907.dtb \
+	imx6q-gw5910.dtb \
+	imx6q-gw5912.dtb \
+	imx6q-gw5913.dtb \
+	imx6q-h100.dtb \
+	imx6q-hummingboard.dtb \
+	imx6q-hummingboard-emmc-som-v15.dtb \
+	imx6q-hummingboard-som-v15.dtb \
+	imx6q-hummingboard2.dtb \
+	imx6q-hummingboard2-emmc-som-v15.dtb \
+	imx6q-hummingboard2-som-v15.dtb \
+	imx6q-icore.dtb \
+	imx6q-icore-mipi.dtb \
+	imx6q-icore-ofcap10.dtb \
+	imx6q-icore-ofcap12.dtb \
+	imx6q-icore-rqs.dtb \
+	imx6q-kp-tpc.dtb \
+	imx6q-logicpd.dtb \
+	imx6q-marsboard.dtb \
+	imx6q-mba6a.dtb \
+	imx6q-mba6b.dtb \
+	imx6q-mccmon6.dtb \
+	imx6q-nitrogen6x.dtb \
+	imx6q-nitrogen6_max.dtb \
+	imx6q-nitrogen6_som2.dtb \
+	imx6q-novena.dtb \
+	imx6q-phytec-mira-rdk-emmc.dtb \
+	imx6q-phytec-mira-rdk-nand.dtb \
+	imx6q-phytec-pbab01.dtb \
+	imx6q-pico-dwarf.dtb \
+	imx6q-pico-hobbit.dtb \
+	imx6q-pico-nymph.dtb \
+	imx6q-pico-pi.dtb \
+	imx6q-pistachio.dtb \
+	imx6q-prti6q.dtb \
+	imx6q-prtwd2.dtb \
+	imx6q-rex-pro.dtb \
+	imx6q-sabreauto.dtb \
+	imx6q-sabrelite.dtb \
+	imx6q-sabresd.dtb \
+	imx6q-savageboard.dtb \
+	imx6q-sbc6x.dtb \
+	imx6q-skov-revc-lt2.dtb \
+	imx6q-skov-revc-lt6.dtb \
+	imx6q-skov-reve-mi1010ait-1cp1.dtb \
+	imx6q-solidsense.dtb \
+	imx6q-tbs2910.dtb \
+	imx6q-ts4900.dtb \
+	imx6q-ts7970.dtb \
+	imx6q-tx6q-1010.dtb \
+	imx6q-tx6q-1010-comtft.dtb \
+	imx6q-tx6q-1020.dtb \
+	imx6q-tx6q-1020-comtft.dtb \
+	imx6q-tx6q-1036.dtb \
+	imx6q-tx6q-1036-mb7.dtb \
+	imx6q-tx6q-10x0-mb7.dtb \
+	imx6q-tx6q-1110.dtb \
+	imx6q-tx6q-11x0-mb7.dtb \
+	imx6q-udoo.dtb \
+	imx6q-utilite-pro.dtb \
+	imx6q-var-dt6customboard.dtb \
+	imx6q-vicut1.dtb \
+	imx6q-wandboard.dtb \
+	imx6q-wandboard-revb1.dtb \
+	imx6q-wandboard-revd1.dtb \
+	imx6q-yapp4-crux.dtb \
+	imx6q-yapp4-pegasus.dtb \
+	imx6q-zii-rdu2.dtb \
+	imx6qp-mba6b.dtb \
+	imx6qp-nitrogen6_max.dtb \
+	imx6qp-nitrogen6_som2.dtb \
+	imx6qp-phytec-mira-rdk-nand.dtb \
+	imx6qp-prtwd3.dtb \
+	imx6qp-sabreauto.dtb \
+	imx6qp-sabresd.dtb \
+	imx6qp-tx6qp-8037.dtb \
+	imx6qp-tx6qp-8037-mb7.dtb \
+	imx6qp-tx6qp-8137.dtb \
+	imx6qp-tx6qp-8137-mb7.dtb \
+	imx6qp-vicutp.dtb \
+	imx6qp-wandboard-revd1.dtb \
+	imx6qp-yapp4-crux-plus.dtb \
+	imx6qp-yapp4-pegasus-plus.dtb \
+	imx6qp-zii-rdu2.dtb \
+	imx6s-dhcom-drc02.dtb
+dtb-$(CONFIG_SOC_IMX6SL) += \
+	imx6sl-evk.dtb \
+	imx6sl-kobo-aura2.dtb \
+	imx6sl-tolino-shine2hd.dtb \
+	imx6sl-tolino-shine3.dtb \
+	imx6sl-tolino-vision.dtb \
+	imx6sl-tolino-vision5.dtb \
+	imx6sl-warp.dtb
+dtb-$(CONFIG_SOC_IMX6SLL) += \
+	imx6sll-evk.dtb \
+	imx6sll-kobo-clarahd.dtb \
+	imx6sll-kobo-librah2o.dtb
+dtb-$(CONFIG_SOC_IMX6SX) += \
+	imx6sx-nitrogen6sx.dtb \
+	imx6sx-sabreauto.dtb \
+	imx6sx-sdb-reva.dtb \
+	imx6sx-sdb-sai.dtb \
+	imx6sx-sdb.dtb \
+	imx6sx-sdb-mqs.dtb \
+	imx6sx-softing-vining-2000.dtb \
+	imx6sx-udoo-neo-basic.dtb \
+	imx6sx-udoo-neo-extended.dtb \
+	imx6sx-udoo-neo-full.dtb
+dtb-$(CONFIG_SOC_IMX6UL) += \
+	imx6ul-14x14-evk.dtb \
+	imx6ul-ccimx6ulsbcexpress.dtb \
+	imx6ul-ccimx6ulsbcpro.dtb \
+	imx6ul-geam.dtb \
+	imx6ul-isiot-emmc.dtb \
+	imx6ul-isiot-nand.dtb \
+	imx6ul-kontron-bl.dtb \
+	imx6ul-kontron-bl-43.dtb \
+	imx6ul-liteboard.dtb \
+	imx6ul-tqma6ul1-mba6ulx.dtb \
+	imx6ul-tqma6ul2-mba6ulx.dtb \
+	imx6ul-tqma6ul2l-mba6ulx.dtb \
+	imx6ul-opos6uldev.dtb \
+	imx6ul-pico-dwarf.dtb \
+	imx6ul-pico-hobbit.dtb \
+	imx6ul-pico-pi.dtb \
+	imx6ul-phytec-segin-ff-rdk-emmc.dtb \
+	imx6ul-phytec-segin-ff-rdk-nand.dtb \
+	imx6ul-prti6g.dtb \
+	imx6ul-tx6ul-0010.dtb \
+	imx6ul-tx6ul-0011.dtb \
+	imx6ul-tx6ul-mainboard.dtb \
+	imx6ull-14x14-evk.dtb \
+	imx6ull-colibri-aster.dtb \
+	imx6ull-colibri-emmc-aster.dtb \
+	imx6ull-colibri-emmc-eval-v3.dtb \
+	imx6ull-colibri-emmc-iris.dtb \
+	imx6ull-colibri-emmc-iris-v2.dtb \
+	imx6ull-colibri-eval-v3.dtb \
+	imx6ull-colibri-iris.dtb \
+	imx6ull-colibri-iris-v2.dtb \
+	imx6ull-colibri-wifi-aster.dtb \
+	imx6ull-colibri-wifi-eval-v3.dtb \
+	imx6ull-colibri-wifi-iris.dtb \
+	imx6ull-colibri-wifi-iris-v2.dtb \
+	imx6ull-dhcom-drc02.dtb \
+	imx6ull-dhcom-pdk2.dtb \
+	imx6ull-dhcom-picoitx.dtb \
+	imx6ull-jozacp.dtb \
+	imx6ull-kontron-bl.dtb \
+	imx6ull-myir-mys-6ulx-eval.dtb \
+	imx6ull-opos6uldev.dtb \
+	imx6ull-phytec-segin-ff-rdk-nand.dtb \
+	imx6ull-phytec-segin-ff-rdk-emmc.dtb \
+	imx6ull-phytec-segin-lc-rdk-nand.dtb \
+	imx6ull-phytec-tauri-emmc.dtb \
+	imx6ull-phytec-tauri-nand.dtb \
+	imx6ull-tarragon-master.dtb \
+	imx6ull-tarragon-micro.dtb \
+	imx6ull-tarragon-slave.dtb \
+	imx6ull-tarragon-slavext.dtb \
+	imx6ull-tqma6ull2-mba6ulx.dtb \
+	imx6ull-tqma6ull2l-mba6ulx.dtb \
+	imx6ulz-14x14-evk.dtb \
+	imx6ulz-bsh-smm-m2.dtb
+dtb-$(CONFIG_SOC_IMX7D) += \
+	imx7d-cl-som-imx7.dtb \
+	imx7d-colibri-aster.dtb \
+	imx7d-colibri-emmc-aster.dtb \
+	imx7d-colibri-emmc-iris.dtb \
+	imx7d-colibri-emmc-iris-v2.dtb \
+	imx7d-colibri-emmc-eval-v3.dtb \
+	imx7d-colibri-eval-v3.dtb \
+	imx7d-colibri-iris.dtb \
+	imx7d-colibri-iris-v2.dtb \
+	imx7d-flex-concentrator.dtb \
+	imx7d-flex-concentrator-mfg.dtb \
+	imx7d-mba7.dtb \
+	imx7d-meerkat96.dtb \
+	imx7d-nitrogen7.dtb \
+	imx7d-pico-dwarf.dtb \
+	imx7d-pico-hobbit.dtb \
+	imx7d-pico-nymph.dtb \
+	imx7d-pico-pi.dtb \
+	imx7d-remarkable2.dtb \
+	imx7d-sbc-imx7.dtb \
+	imx7d-sdb.dtb \
+	imx7d-sdb-reva.dtb \
+	imx7d-sdb-sht11.dtb \
+	imx7d-smegw01.dtb \
+	imx7d-zii-rmu2.dtb \
+	imx7d-zii-rpu2.dtb \
+	imx7s-colibri-aster.dtb \
+	imx7s-colibri-eval-v3.dtb \
+	imx7s-colibri-iris.dtb \
+	imx7s-colibri-iris-v2.dtb \
+	imx7s-mba7.dtb \
+	imx7s-warp.dtb
+dtb-$(CONFIG_SOC_IMX7ULP) += \
+	imx7ulp-com.dtb \
+	imx7ulp-evk.dtb
+dtb-$(CONFIG_SOC_IMXRT) += \
+	imxrt1050-evk.dtb
diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/nxp/imx/e60k02.dtsi
similarity index 100%
rename from arch/arm/boot/dts/e60k02.dtsi
rename to arch/arm/boot/dts/nxp/imx/e60k02.dtsi
diff --git a/arch/arm/boot/dts/e70k02.dtsi b/arch/arm/boot/dts/nxp/imx/e70k02.dtsi
similarity index 100%
rename from arch/arm/boot/dts/e70k02.dtsi
rename to arch/arm/boot/dts/nxp/imx/e70k02.dtsi
diff --git a/arch/arm/boot/dts/imx1-ads.dts b/arch/arm/boot/dts/nxp/imx/imx1-ads.dts
similarity index 100%
rename from arch/arm/boot/dts/imx1-ads.dts
rename to arch/arm/boot/dts/nxp/imx/imx1-ads.dts
diff --git a/arch/arm/boot/dts/imx1-apf9328.dts b/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
similarity index 100%
rename from arch/arm/boot/dts/imx1-apf9328.dts
rename to arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
diff --git a/arch/arm/boot/dts/imx1-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx1-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx1-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx1-pinfunc.h
diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/nxp/imx/imx1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx1.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx1.dtsi
diff --git a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-cpuimx25.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx25-eukrea-cpuimx25.dtsi
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
similarity index 100%
rename from arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
rename to arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
similarity index 100%
rename from arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
rename to arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
similarity index 100%
rename from arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
rename to arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard.dts
diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/nxp/imx/imx25-karo-tx25.dts
similarity index 100%
rename from arch/arm/boot/dts/imx25-karo-tx25.dts
rename to arch/arm/boot/dts/nxp/imx/imx25-karo-tx25.dts
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/nxp/imx/imx25-pdk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx25-pdk.dts
rename to arch/arm/boot/dts/nxp/imx/imx25-pdk.dts
diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx25-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx25-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx25-pinfunc.h
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/nxp/imx/imx25.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx25.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx25.dtsi
diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/nxp/imx/imx27-apf27.dts
similarity index 100%
rename from arch/arm/boot/dts/imx27-apf27.dts
rename to arch/arm/boot/dts/nxp/imx/imx27-apf27.dts
diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts
similarity index 100%
rename from arch/arm/boot/dts/imx27-apf27dev.dts
rename to arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts
diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
diff --git a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts b/arch/arm/boot/dts/nxp/imx/imx27-eukrea-mbimxsd27-baseboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx27-eukrea-mbimxsd27-baseboard.dts
diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/nxp/imx/imx27-pdk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx27-pdk.dts
rename to arch/arm/boot/dts/nxp/imx/imx27-pdk.dts
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-rdk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
rename to arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-rdk.dts
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-som.dtsi
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
rename to arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dts
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi
diff --git a/arch/arm/boot/dts/imx27-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx27-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx27-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx27-pinfunc.h
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/nxp/imx/imx27.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx27.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx27.dtsi
diff --git a/arch/arm/boot/dts/imx31-bug.dts b/arch/arm/boot/dts/nxp/imx/imx31-bug.dts
similarity index 100%
rename from arch/arm/boot/dts/imx31-bug.dts
rename to arch/arm/boot/dts/nxp/imx/imx31-bug.dts
diff --git a/arch/arm/boot/dts/imx31-lite.dts b/arch/arm/boot/dts/nxp/imx/imx31-lite.dts
similarity index 100%
rename from arch/arm/boot/dts/imx31-lite.dts
rename to arch/arm/boot/dts/nxp/imx/imx31-lite.dts
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/nxp/imx/imx31.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx31.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx31.dtsi
diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot/dts/nxp/imx/imx35-eukrea-cpuimx35.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx35-eukrea-cpuimx35.dtsi
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts b/arch/arm/boot/dts/nxp/imx/imx35-eukrea-mbimxsd35-baseboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx35-eukrea-mbimxsd35-baseboard.dts
diff --git a/arch/arm/boot/dts/imx35-pdk.dts b/arch/arm/boot/dts/nxp/imx/imx35-pdk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx35-pdk.dts
rename to arch/arm/boot/dts/nxp/imx/imx35-pdk.dts
diff --git a/arch/arm/boot/dts/imx35-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx35-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx35-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx35-pinfunc.h
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/nxp/imx/imx35.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx35.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx35.dtsi
diff --git a/arch/arm/boot/dts/imx50-evk.dts b/arch/arm/boot/dts/nxp/imx/imx50-evk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx50-evk.dts
rename to arch/arm/boot/dts/nxp/imx/imx50-evk.dts
diff --git a/arch/arm/boot/dts/imx50-kobo-aura.dts b/arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts
similarity index 100%
rename from arch/arm/boot/dts/imx50-kobo-aura.dts
rename to arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts
diff --git a/arch/arm/boot/dts/imx50-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx50-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx50-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx50-pinfunc.h
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/nxp/imx/imx50.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx50.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx50.dtsi
diff --git a/arch/arm/boot/dts/imx51-apf51.dts b/arch/arm/boot/dts/nxp/imx/imx51-apf51.dts
similarity index 100%
rename from arch/arm/boot/dts/imx51-apf51.dts
rename to arch/arm/boot/dts/nxp/imx/imx51-apf51.dts
diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/nxp/imx/imx51-apf51dev.dts
similarity index 100%
rename from arch/arm/boot/dts/imx51-apf51dev.dts
rename to arch/arm/boot/dts/nxp/imx/imx51-apf51dev.dts
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/nxp/imx/imx51-babbage.dts
similarity index 100%
rename from arch/arm/boot/dts/imx51-babbage.dts
rename to arch/arm/boot/dts/nxp/imx/imx51-babbage.dts
diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts b/arch/arm/boot/dts/nxp/imx/imx51-digi-connectcore-jsk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
rename to arch/arm/boot/dts/nxp/imx/imx51-digi-connectcore-jsk.dts
diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx51-digi-connectcore-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx51-digi-connectcore-som.dtsi
diff --git a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi b/arch/arm/boot/dts/nxp/imx/imx51-eukrea-cpuimx51.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx51-eukrea-cpuimx51.dtsi
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/nxp/imx/imx51-eukrea-mbimxsd51-baseboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx51-eukrea-mbimxsd51-baseboard.dts
diff --git a/arch/arm/boot/dts/imx51-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx51-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx51-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx51-pinfunc.h
diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts
similarity index 100%
rename from arch/arm/boot/dts/imx51-ts4800.dts
rename to arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts
diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/nxp/imx/imx51-zii-rdu1.dts
similarity index 100%
rename from arch/arm/boot/dts/imx51-zii-rdu1.dts
rename to arch/arm/boot/dts/nxp/imx/imx51-zii-rdu1.dts
diff --git a/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts b/arch/arm/boot/dts/nxp/imx/imx51-zii-scu2-mezz.dts
similarity index 100%
rename from arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
rename to arch/arm/boot/dts/nxp/imx/imx51-zii-scu2-mezz.dts
diff --git a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts b/arch/arm/boot/dts/nxp/imx/imx51-zii-scu3-esb.dts
similarity index 100%
rename from arch/arm/boot/dts/imx51-zii-scu3-esb.dts
rename to arch/arm/boot/dts/nxp/imx/imx51-zii-scu3-esb.dts
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/nxp/imx/imx51.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx51.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx51.dtsi
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/nxp/imx/imx53-ard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-ard.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-ard.dts
diff --git a/arch/arm/boot/dts/imx53-cx9020.dts b/arch/arm/boot/dts/nxp/imx/imx53-cx9020.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-cx9020.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-cx9020.dts
diff --git a/arch/arm/boot/dts/imx53-kp-ddc.dts b/arch/arm/boot/dts/nxp/imx/imx53-kp-ddc.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-kp-ddc.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-kp-ddc.dts
diff --git a/arch/arm/boot/dts/imx53-kp-hsc.dts b/arch/arm/boot/dts/nxp/imx/imx53-kp-hsc.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-kp-hsc.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-kp-hsc.dts
diff --git a/arch/arm/boot/dts/imx53-kp.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx53-kp.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi
diff --git a/arch/arm/boot/dts/imx53-m53.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-m53.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx53-m53.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx53-m53.dtsi
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/nxp/imx/imx53-m53evk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-m53evk.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-m53evk.dts
diff --git a/arch/arm/boot/dts/imx53-m53menlo.dts b/arch/arm/boot/dts/nxp/imx/imx53-m53menlo.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-m53menlo.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-m53menlo.dts
diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/nxp/imx/imx53-mba53.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-mba53.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-mba53.dts
diff --git a/arch/arm/boot/dts/imx53-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx53-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx53-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx53-pinfunc.h
diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/nxp/imx/imx53-ppd.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-ppd.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-ppd.dts
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx53-qsb-common.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/nxp/imx/imx53-qsb.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-qsb.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-qsb.dts
diff --git a/arch/arm/boot/dts/imx53-qsrb.dts b/arch/arm/boot/dts/nxp/imx/imx53-qsrb.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-qsrb.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-qsrb.dts
diff --git a/arch/arm/boot/dts/imx53-sk-imx53.dts b/arch/arm/boot/dts/nxp/imx/imx53-sk-imx53.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-sk-imx53.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-sk-imx53.dts
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/nxp/imx/imx53-smd.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-smd.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-smd.dts
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx53-tqma53.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi
diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/nxp/imx/imx53-tx53-x03x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-tx53-x03x.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-tx53-x03x.dts
diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/nxp/imx/imx53-tx53-x13x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-tx53-x13x.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-tx53-x13x.dts
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-tx53.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx53-tx53.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx53-tx53.dtsi
diff --git a/arch/arm/boot/dts/imx53-usbarmory.dts b/arch/arm/boot/dts/nxp/imx/imx53-usbarmory.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-usbarmory.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-usbarmory.dts
diff --git a/arch/arm/boot/dts/imx53-voipac-bsb.dts b/arch/arm/boot/dts/nxp/imx/imx53-voipac-bsb.dts
similarity index 100%
rename from arch/arm/boot/dts/imx53-voipac-bsb.dts
rename to arch/arm/boot/dts/nxp/imx/imx53-voipac-bsb.dts
diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-voipac-dmm-668.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx53-voipac-dmm-668.dtsi
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/nxp/imx/imx53.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx53.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx53.dtsi
diff --git a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6-logicpd-baseboard.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6-logicpd-baseboard.dtsi
diff --git a/arch/arm/boot/dts/imx6-logicpd-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6-logicpd-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6-logicpd-som.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6-logicpd-som.dtsi
diff --git a/arch/arm/boot/dts/imx6dl-alti6p.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-alti6p.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts
diff --git a/arch/arm/boot/dts/imx6dl-apf6dev.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-apf6dev.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-apf6dev.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-apf6dev.dts
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-aristainetos_4.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dts
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-aristainetos_7.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_7.dts
diff --git a/arch/arm/boot/dts/imx6dl-b105pv2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-b105pv2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dts
diff --git a/arch/arm/boot/dts/imx6dl-b105v2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-b105v2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dts
diff --git a/arch/arm/boot/dts/imx6dl-b125pv2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b125pv2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-b125pv2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-b125pv2.dts
diff --git a/arch/arm/boot/dts/imx6dl-b125v2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-b125v2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dts
diff --git a/arch/arm/boot/dts/imx6dl-b155v2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-b155v2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dts
diff --git a/arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5pv2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6dl-b1x5pv2.dtsi
diff --git a/arch/arm/boot/dts/imx6dl-b1x5v2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-b1x5v2.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi
diff --git a/arch/arm/boot/dts/imx6dl-colibri-aster.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-colibri-aster.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-colibri-aster.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-colibri-aster.dts
diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-colibri-eval-v3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-colibri-eval-v3.dts
diff --git a/arch/arm/boot/dts/imx6dl-colibri-iris-v2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-colibri-iris-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-colibri-iris-v2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-colibri-iris-v2.dts
diff --git a/arch/arm/boot/dts/imx6dl-colibri-iris.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-colibri-iris.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-colibri-iris.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-colibri-iris.dts
diff --git a/arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-emmc-som-v15.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-emmc-som-v15.dts
diff --git a/arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-som-v15.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-som-v15.dts
diff --git a/arch/arm/boot/dts/imx6dl-cubox-i.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-cubox-i.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i.dts
diff --git a/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-dfi-fs700-m60.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-dfi-fs700-m60.dts
diff --git a/arch/arm/boot/dts/imx6dl-dhcom-picoitx.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-dhcom-picoitx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-dhcom-picoitx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-dhcom-picoitx.dts
diff --git a/arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts
diff --git a/arch/arm/boot/dts/imx6dl-emcon-avari.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-emcon-avari.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw51xx.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw51xx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw51xx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw51xx.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw52xx.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw52xx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw52xx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw52xx.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw53xx.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw53xx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw53xx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw53xx.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw54xx.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw54xx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw54xx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw54xx.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw551x.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw551x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw551x.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw551x.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw552x.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw552x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw552x.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw552x.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw553x.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw553x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw553x.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw553x.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw560x.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw560x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw560x.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw560x.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw5903.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw5903.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw5903.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw5903.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw5904.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw5904.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw5904.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw5904.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw5907.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw5907.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw5907.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw5907.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw5910.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw5910.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw5910.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw5910.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw5912.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw5912.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw5912.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw5912.dts
diff --git a/arch/arm/boot/dts/imx6dl-gw5913.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-gw5913.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-gw5913.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-gw5913.dts
diff --git a/arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-hummingboard-emmc-som-v15.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-hummingboard-emmc-som-v15.dts
diff --git a/arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-hummingboard-som-v15.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-hummingboard-som-v15.dts
diff --git a/arch/arm/boot/dts/imx6dl-hummingboard.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-hummingboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-hummingboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-hummingboard.dts
diff --git a/arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-hummingboard2-emmc-som-v15.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-hummingboard2-emmc-som-v15.dts
diff --git a/arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-hummingboard2-som-v15.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-hummingboard2-som-v15.dts
diff --git a/arch/arm/boot/dts/imx6dl-hummingboard2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-hummingboard2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-hummingboard2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-hummingboard2.dts
diff --git a/arch/arm/boot/dts/imx6dl-icore-mipi.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-icore-mipi.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-icore-mipi.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-icore-mipi.dts
diff --git a/arch/arm/boot/dts/imx6dl-icore-rqs.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-icore-rqs.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-icore-rqs.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-icore-rqs.dts
diff --git a/arch/arm/boot/dts/imx6dl-icore.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-icore.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-icore.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-icore.dts
diff --git a/arch/arm/boot/dts/imx6dl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-kontron-samx6i.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i.dtsi
diff --git a/arch/arm/boot/dts/imx6dl-lanmcu.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-lanmcu.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-mamoj.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-mamoj.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-mamoj.dts
diff --git a/arch/arm/boot/dts/imx6dl-mba6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-mba6.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-mba6.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6dl-mba6.dtsi
diff --git a/arch/arm/boot/dts/imx6dl-mba6a.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-mba6a.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-mba6a.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-mba6a.dts
diff --git a/arch/arm/boot/dts/imx6dl-mba6b.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-mba6b.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-mba6b.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-mba6b.dts
diff --git a/arch/arm/boot/dts/imx6dl-nit6xlite.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-nit6xlite.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-nit6xlite.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-nit6xlite.dts
diff --git a/arch/arm/boot/dts/imx6dl-nitrogen6x.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-nitrogen6x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-nitrogen6x.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-nitrogen6x.dts
diff --git a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-phytec-mira-rdk-nand.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-phytec-mira-rdk-nand.dts
diff --git a/arch/arm/boot/dts/imx6dl-phytec-pbab01.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-phytec-pbab01.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-phytec-pbab01.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-phytec-pbab01.dts
diff --git a/arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-phytec-pfla02.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6dl-phytec-pfla02.dtsi
diff --git a/arch/arm/boot/dts/imx6dl-pico-dwarf.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-pico-dwarf.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-pico-dwarf.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-pico-dwarf.dts
diff --git a/arch/arm/boot/dts/imx6dl-pico-hobbit.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-pico-hobbit.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-pico-hobbit.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-pico-hobbit.dts
diff --git a/arch/arm/boot/dts/imx6dl-pico-nymph.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-pico-nymph.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-pico-nymph.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-pico-nymph.dts
diff --git a/arch/arm/boot/dts/imx6dl-pico-pi.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-pico-pi.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-pico-pi.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-pico-pi.dts
diff --git a/arch/arm/boot/dts/imx6dl-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx6dl-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx6dl-pinfunc.h
diff --git a/arch/arm/boot/dts/imx6dl-plybas.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-plybas.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts
diff --git a/arch/arm/boot/dts/imx6dl-plym2m.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-plym2m.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts
diff --git a/arch/arm/boot/dts/imx6dl-prtmvt.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-prtmvt.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts
diff --git a/arch/arm/boot/dts/imx6dl-prtrvt.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-prtrvt.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-prtrvt.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-prtrvt.dts
diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-prtvt7.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts
diff --git a/arch/arm/boot/dts/imx6dl-qmx6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-qmx6.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
diff --git a/arch/arm/boot/dts/imx6dl-rex-basic.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-rex-basic.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-rex-basic.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-rex-basic.dts
diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-riotboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-riotboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-riotboard.dts
diff --git a/arch/arm/boot/dts/imx6dl-sabreauto.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-sabreauto.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-sabreauto.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-sabreauto.dts
diff --git a/arch/arm/boot/dts/imx6dl-sabrelite.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-sabrelite.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-sabrelite.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-sabrelite.dts
diff --git a/arch/arm/boot/dts/imx6dl-sabresd.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-sabresd.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-sabresd.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-sabresd.dts
diff --git a/arch/arm/boot/dts/imx6dl-savageboard.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-savageboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-savageboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-savageboard.dts
diff --git a/arch/arm/boot/dts/imx6dl-skov-revc-lt2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-skov-revc-lt2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-skov-revc-lt2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-skov-revc-lt2.dts
diff --git a/arch/arm/boot/dts/imx6dl-skov-revc-lt6.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-skov-revc-lt6.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-skov-revc-lt6.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-skov-revc-lt6.dts
diff --git a/arch/arm/boot/dts/imx6dl-solidsense.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-solidsense.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-solidsense.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-solidsense.dts
diff --git a/arch/arm/boot/dts/imx6dl-tqma6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-tqma6a.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi
diff --git a/arch/arm/boot/dts/imx6dl-tqma6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-tqma6b.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi
diff --git a/arch/arm/boot/dts/imx6dl-ts4900.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-ts4900.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-ts4900.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-ts4900.dts
diff --git a/arch/arm/boot/dts/imx6dl-ts7970.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-ts7970.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-ts7970.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-ts7970.dts
diff --git a/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-tx6dl-comtft.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-tx6dl-comtft.dts
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-tx6s-8034-mb7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-tx6s-8034-mb7.dts
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8034.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-tx6s-8034.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-tx6s-8034.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-tx6s-8034.dts
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-tx6s-8035-mb7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-tx6s-8035-mb7.dts
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8035.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-tx6s-8035.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-tx6s-8035.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-tx6s-8035.dts
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-801x.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-801x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-tx6u-801x.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-801x.dts
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-8033-mb7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-8033-mb7.dts
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-8033.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-8033.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-tx6u-8033.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-8033.dts
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-80xx-mb7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-80xx-mb7.dts
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-811x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-tx6u-811x.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-811x.dts
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-81xx-mb7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-81xx-mb7.dts
diff --git a/arch/arm/boot/dts/imx6dl-udoo.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-udoo.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-udoo.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-udoo.dts
diff --git a/arch/arm/boot/dts/imx6dl-victgo.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-victgo.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
diff --git a/arch/arm/boot/dts/imx6dl-vicut1.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-vicut1.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-vicut1.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-vicut1.dts
diff --git a/arch/arm/boot/dts/imx6dl-wandboard-revb1.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-wandboard-revb1.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-wandboard-revb1.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-wandboard-revb1.dts
diff --git a/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-wandboard-revd1.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-wandboard-revd1.dts
diff --git a/arch/arm/boot/dts/imx6dl-wandboard.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-wandboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-wandboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-wandboard.dts
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-draco.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-draco.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-yapp4-draco.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-draco.dts
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-hydra.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-hydra.dts
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-lynx.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-lynx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-yapp4-lynx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-lynx.dts
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-orion.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-orion.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-yapp4-orion.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-orion.dts
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-phoenix.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-phoenix.dts
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-ursa.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-ursa.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-yapp4-ursa.dts
rename to arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-ursa.dts
diff --git a/arch/arm/boot/dts/imx6dl-yapp43-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6dl-yapp43-common.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi
diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6dl.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6dl.dtsi
diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-apalis-eval.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval.dts
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.1.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.1.dts
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-apalis-ixora.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora.dts
diff --git a/arch/arm/boot/dts/imx6q-apf6dev.dts b/arch/arm/boot/dts/nxp/imx/imx6q-apf6dev.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-apf6dev.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-apf6dev.dts
diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-arm2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-arm2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-arm2.dts
diff --git a/arch/arm/boot/dts/imx6q-b450v3.dts b/arch/arm/boot/dts/nxp/imx/imx6q-b450v3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-b450v3.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-b450v3.dts
diff --git a/arch/arm/boot/dts/imx6q-b650v3.dts b/arch/arm/boot/dts/nxp/imx/imx6q-b650v3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-b650v3.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-b650v3.dts
diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/nxp/imx/imx6q-b850v3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-b850v3.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-b850v3.dts
diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6q-ba16.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi
diff --git a/arch/arm/boot/dts/imx6q-bosch-acc.dts b/arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-bosch-acc.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts
diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6q-bx50v3.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi
diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-cm-fx6.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
diff --git a/arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-emmc-som-v15.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-emmc-som-v15.dts
diff --git a/arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-som-v15.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-som-v15.dts
diff --git a/arch/arm/boot/dts/imx6q-cubox-i.dts b/arch/arm/boot/dts/nxp/imx/imx6q-cubox-i.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-cubox-i.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-cubox-i.dts
diff --git a/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts b/arch/arm/boot/dts/nxp/imx/imx6q-dfi-fs700-m60.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-dfi-fs700-m60.dts
diff --git a/arch/arm/boot/dts/imx6q-dhcom-pdk2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-dhcom-pdk2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-dhcom-pdk2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-dhcom-pdk2.dts
diff --git a/arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dts b/arch/arm/boot/dts/nxp/imx/imx6q-display5-tianma-tm070-1280x768.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-display5-tianma-tm070-1280x768.dts
diff --git a/arch/arm/boot/dts/imx6q-display5.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-display5.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6q-display5.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6q-display5.dtsi
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
diff --git a/arch/arm/boot/dts/imx6q-dms-ba16.dts b/arch/arm/boot/dts/nxp/imx/imx6q-dms-ba16.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-dms-ba16.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-dms-ba16.dts
diff --git a/arch/arm/boot/dts/imx6q-ds.dts b/arch/arm/boot/dts/nxp/imx/imx6q-ds.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-ds.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-ds.dts
diff --git a/arch/arm/boot/dts/imx6q-emcon-avari.dts b/arch/arm/boot/dts/nxp/imx/imx6q-emcon-avari.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-emcon-avari.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-emcon-avari.dts
diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-evi.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
diff --git a/arch/arm/boot/dts/imx6q-gk802.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gk802.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gk802.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gk802.dts
diff --git a/arch/arm/boot/dts/imx6q-gw51xx.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw51xx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw51xx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw51xx.dts
diff --git a/arch/arm/boot/dts/imx6q-gw52xx.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw52xx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw52xx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw52xx.dts
diff --git a/arch/arm/boot/dts/imx6q-gw53xx.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw53xx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw53xx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw53xx.dts
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw5400-a.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw5400-a.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw5400-a.dts
diff --git a/arch/arm/boot/dts/imx6q-gw54xx.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw54xx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw54xx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw54xx.dts
diff --git a/arch/arm/boot/dts/imx6q-gw551x.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw551x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw551x.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw551x.dts
diff --git a/arch/arm/boot/dts/imx6q-gw552x.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw552x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw552x.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw552x.dts
diff --git a/arch/arm/boot/dts/imx6q-gw553x.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw553x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw553x.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw553x.dts
diff --git a/arch/arm/boot/dts/imx6q-gw560x.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw560x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw560x.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw560x.dts
diff --git a/arch/arm/boot/dts/imx6q-gw5903.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw5903.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw5903.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw5903.dts
diff --git a/arch/arm/boot/dts/imx6q-gw5904.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw5904.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw5904.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw5904.dts
diff --git a/arch/arm/boot/dts/imx6q-gw5907.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw5907.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw5907.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw5907.dts
diff --git a/arch/arm/boot/dts/imx6q-gw5910.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw5910.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw5910.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw5910.dts
diff --git a/arch/arm/boot/dts/imx6q-gw5912.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw5912.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw5912.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw5912.dts
diff --git a/arch/arm/boot/dts/imx6q-gw5913.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw5913.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-gw5913.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-gw5913.dts
diff --git a/arch/arm/boot/dts/imx6q-h100.dts b/arch/arm/boot/dts/nxp/imx/imx6q-h100.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-h100.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-h100.dts
diff --git a/arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6q-hummingboard-emmc-som-v15.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-hummingboard-emmc-som-v15.dts
diff --git a/arch/arm/boot/dts/imx6q-hummingboard-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6q-hummingboard-som-v15.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-hummingboard-som-v15.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-hummingboard-som-v15.dts
diff --git a/arch/arm/boot/dts/imx6q-hummingboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-hummingboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-hummingboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-hummingboard.dts
diff --git a/arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6q-hummingboard2-emmc-som-v15.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-hummingboard2-emmc-som-v15.dts
diff --git a/arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dts b/arch/arm/boot/dts/nxp/imx/imx6q-hummingboard2-som-v15.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-hummingboard2-som-v15.dts
diff --git a/arch/arm/boot/dts/imx6q-hummingboard2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-hummingboard2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-hummingboard2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-hummingboard2.dts
diff --git a/arch/arm/boot/dts/imx6q-icore-mipi.dts b/arch/arm/boot/dts/nxp/imx/imx6q-icore-mipi.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-icore-mipi.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-icore-mipi.dts
diff --git a/arch/arm/boot/dts/imx6q-icore-ofcap10.dts b/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-icore-ofcap10.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts
diff --git a/arch/arm/boot/dts/imx6q-icore-ofcap12.dts b/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-icore-ofcap12.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts
diff --git a/arch/arm/boot/dts/imx6q-icore-rqs.dts b/arch/arm/boot/dts/nxp/imx/imx6q-icore-rqs.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-icore-rqs.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-icore-rqs.dts
diff --git a/arch/arm/boot/dts/imx6q-icore.dts b/arch/arm/boot/dts/nxp/imx/imx6q-icore.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-icore.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-icore.dts
diff --git a/arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i.dtsi
diff --git a/arch/arm/boot/dts/imx6q-kp-tpc.dts b/arch/arm/boot/dts/nxp/imx/imx6q-kp-tpc.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-kp-tpc.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-kp-tpc.dts
diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-kp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6q-kp.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6q-kp.dtsi
diff --git a/arch/arm/boot/dts/imx6q-logicpd.dts b/arch/arm/boot/dts/nxp/imx/imx6q-logicpd.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-logicpd.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-logicpd.dts
diff --git a/arch/arm/boot/dts/imx6q-marsboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-marsboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-marsboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-marsboard.dts
diff --git a/arch/arm/boot/dts/imx6q-mba6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-mba6.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6q-mba6.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6q-mba6.dtsi
diff --git a/arch/arm/boot/dts/imx6q-mba6a.dts b/arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-mba6a.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dts
diff --git a/arch/arm/boot/dts/imx6q-mba6b.dts b/arch/arm/boot/dts/nxp/imx/imx6q-mba6b.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-mba6b.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-mba6b.dts
diff --git a/arch/arm/boot/dts/imx6q-mccmon6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-mccmon6.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-mccmon6.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-mccmon6.dts
diff --git a/arch/arm/boot/dts/imx6q-nitrogen6_max.dts b/arch/arm/boot/dts/nxp/imx/imx6q-nitrogen6_max.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-nitrogen6_max.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-nitrogen6_max.dts
diff --git a/arch/arm/boot/dts/imx6q-nitrogen6_som2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-nitrogen6_som2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-nitrogen6_som2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-nitrogen6_som2.dts
diff --git a/arch/arm/boot/dts/imx6q-nitrogen6x.dts b/arch/arm/boot/dts/nxp/imx/imx6q-nitrogen6x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-nitrogen6x.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-nitrogen6x.dts
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/nxp/imx/imx6q-novena.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-novena.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-novena.dts
diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts b/arch/arm/boot/dts/nxp/imx/imx6q-phytec-mira-rdk-emmc.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-phytec-mira-rdk-emmc.dts
diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/nxp/imx/imx6q-phytec-mira-rdk-nand.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-phytec-mira-rdk-nand.dts
diff --git a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts b/arch/arm/boot/dts/nxp/imx/imx6q-phytec-pbab01.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-phytec-pbab01.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-phytec-pbab01.dts
diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-phytec-pfla02.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6q-phytec-pfla02.dtsi
diff --git a/arch/arm/boot/dts/imx6q-pico-dwarf.dts b/arch/arm/boot/dts/nxp/imx/imx6q-pico-dwarf.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-pico-dwarf.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-pico-dwarf.dts
diff --git a/arch/arm/boot/dts/imx6q-pico-hobbit.dts b/arch/arm/boot/dts/nxp/imx/imx6q-pico-hobbit.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-pico-hobbit.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-pico-hobbit.dts
diff --git a/arch/arm/boot/dts/imx6q-pico-nymph.dts b/arch/arm/boot/dts/nxp/imx/imx6q-pico-nymph.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-pico-nymph.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-pico-nymph.dts
diff --git a/arch/arm/boot/dts/imx6q-pico-pi.dts b/arch/arm/boot/dts/nxp/imx/imx6q-pico-pi.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-pico-pi.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-pico-pi.dts
diff --git a/arch/arm/boot/dts/imx6q-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx6q-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx6q-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx6q-pinfunc.h
diff --git a/arch/arm/boot/dts/imx6q-pistachio.dts b/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-pistachio.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
diff --git a/arch/arm/boot/dts/imx6q-prti6q.dts b/arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-prti6q.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts
diff --git a/arch/arm/boot/dts/imx6q-prtwd2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-prtwd2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts
diff --git a/arch/arm/boot/dts/imx6q-rex-pro.dts b/arch/arm/boot/dts/nxp/imx/imx6q-rex-pro.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-rex-pro.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-rex-pro.dts
diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-sabreauto.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dts
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/nxp/imx/imx6q-sabrelite.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-sabrelite.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-sabrelite.dts
diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/nxp/imx/imx6q-sabresd.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-sabresd.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-sabresd.dts
diff --git a/arch/arm/boot/dts/imx6q-savageboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-savageboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-savageboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-savageboard.dts
diff --git a/arch/arm/boot/dts/imx6q-sbc6x.dts b/arch/arm/boot/dts/nxp/imx/imx6q-sbc6x.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-sbc6x.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-sbc6x.dts
diff --git a/arch/arm/boot/dts/imx6q-skov-revc-lt2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-skov-revc-lt2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-skov-revc-lt2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-skov-revc-lt2.dts
diff --git a/arch/arm/boot/dts/imx6q-skov-revc-lt6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-skov-revc-lt6.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-skov-revc-lt6.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-skov-revc-lt6.dts
diff --git a/arch/arm/boot/dts/imx6q-skov-reve-mi1010ait-1cp1.dts b/arch/arm/boot/dts/nxp/imx/imx6q-skov-reve-mi1010ait-1cp1.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-skov-reve-mi1010ait-1cp1.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-skov-reve-mi1010ait-1cp1.dts
diff --git a/arch/arm/boot/dts/imx6q-solidsense.dts b/arch/arm/boot/dts/nxp/imx/imx6q-solidsense.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-solidsense.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-solidsense.dts
diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-tbs2910.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
diff --git a/arch/arm/boot/dts/imx6q-tqma6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6q-tqma6a.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi
diff --git a/arch/arm/boot/dts/imx6q-tqma6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-tqma6b.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6q-tqma6b.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6q-tqma6b.dtsi
diff --git a/arch/arm/boot/dts/imx6q-ts4900.dts b/arch/arm/boot/dts/nxp/imx/imx6q-ts4900.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-ts4900.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-ts4900.dts
diff --git a/arch/arm/boot/dts/imx6q-ts7970.dts b/arch/arm/boot/dts/nxp/imx/imx6q-ts7970.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-ts7970.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-ts7970.dts
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts b/arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1010-comtft.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1010-comtft.dts
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1010.dts b/arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1010.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-tx6q-1010.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1010.dts
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts b/arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1020-comtft.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1020-comtft.dts
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1020.dts b/arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1020.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-tx6q-1020.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1020.dts
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dts b/arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1036-mb7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1036-mb7.dts
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1036.dts b/arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1036.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-tx6q-1036.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1036.dts
diff --git a/arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dts b/arch/arm/boot/dts/nxp/imx/imx6q-tx6q-10x0-mb7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-tx6q-10x0-mb7.dts
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1110.dts b/arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1110.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-tx6q-1110.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1110.dts
diff --git a/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts b/arch/arm/boot/dts/nxp/imx/imx6q-tx6q-11x0-mb7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-tx6q-11x0-mb7.dts
diff --git a/arch/arm/boot/dts/imx6q-udoo.dts b/arch/arm/boot/dts/nxp/imx/imx6q-udoo.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-udoo.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-udoo.dts
diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-utilite-pro.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
diff --git a/arch/arm/boot/dts/imx6q-var-dt6customboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-var-dt6customboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-var-dt6customboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-var-dt6customboard.dts
diff --git a/arch/arm/boot/dts/imx6q-vicut1.dts b/arch/arm/boot/dts/nxp/imx/imx6q-vicut1.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-vicut1.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-vicut1.dts
diff --git a/arch/arm/boot/dts/imx6q-wandboard-revb1.dts b/arch/arm/boot/dts/nxp/imx/imx6q-wandboard-revb1.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-wandboard-revb1.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-wandboard-revb1.dts
diff --git a/arch/arm/boot/dts/imx6q-wandboard-revd1.dts b/arch/arm/boot/dts/nxp/imx/imx6q-wandboard-revd1.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-wandboard-revd1.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-wandboard-revd1.dts
diff --git a/arch/arm/boot/dts/imx6q-wandboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-wandboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-wandboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-wandboard.dts
diff --git a/arch/arm/boot/dts/imx6q-yapp4-crux.dts b/arch/arm/boot/dts/nxp/imx/imx6q-yapp4-crux.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-yapp4-crux.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-yapp4-crux.dts
diff --git a/arch/arm/boot/dts/imx6q-yapp4-pegasus.dts b/arch/arm/boot/dts/nxp/imx/imx6q-yapp4-pegasus.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-yapp4-pegasus.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-yapp4-pegasus.dts
diff --git a/arch/arm/boot/dts/imx6q-zii-rdu2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-zii-rdu2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6q-zii-rdu2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6q-zii-rdu2.dts
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6q.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6q.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-apalis.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-apf6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apf6.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-apf6.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-apf6.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apf6dev.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-apf6dev.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-colibri.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-dfi-fs700-m60.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-dfi-fs700-m60.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-dhcom-drc02.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-dhcom-drc02.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-dhcom-drc02.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-dhcom-drc02.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-dhcom-pdk2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-dhcom-pdk2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-dhcom-pdk2.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-dhcom-pdk2.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-dhcom-picoitx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-dhcom-picoitx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-dhcom-picoitx.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-dhcom-picoitx.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-dhcom-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-dhcom-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-dhcom-som.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-dhcom-som.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-ds.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-ds.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-ds.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-ds.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon-avari.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-emcon-avari.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-emcon.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw551x.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw552x.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw553x.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw560x.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw5903.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw5904.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw5907.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw5907.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw5910.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw5912.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw5912.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-gw5913.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-gw5913.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2-emmc.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard2-emmc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-hummingboard2-emmc.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard2-emmc.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard2.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-icore-1.5.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-icore-1.5.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-icore-rqs.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-icore-rqs.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-icore.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-icore.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-icore.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-mba6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-mba6.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-mba6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-mba6a.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-mba6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-mba6b.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-av-02.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-av-02.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-eval-01.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-phytec-mira-peb-eval-01.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-wlbt-05.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-wlbt-05.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pbab01.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pbab01.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-pico-dwarf.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-pico-dwarf.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-pico-dwarf.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-pico-dwarf.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-pico-hobbit.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-pico-hobbit.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-pico-hobbit.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-pico-hobbit.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-pico-nymph.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-pico-nymph.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-pico-nymph.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-pico-nymph.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-pico-pi.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-pico-pi.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-pico-pi.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-pico-pi.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-pico.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-pico.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-pico.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-pico.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-prti6q.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-prti6q.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-prti6q.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-prti6q.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-rex.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-rex.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-rex.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-sabresd.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-savageboard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-savageboard.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu-revc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu-revc.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-skov-cpu.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-skov-cpu.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-skov-revc-lt2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-revc-lt2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-skov-revc-lt2.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-skov-revc-lt2.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-solidsense.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-solidsense.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-solidsense.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-solidsense.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-sr-som-brcm.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som-brcm.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-sr-som-brcm.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som-brcm.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-sr-som-emmc.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som-emmc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-sr-som-emmc.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som-emmc.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som-ti.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som-ti.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-sr-som.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-tqma6.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-tqma6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-tqma6b.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-ts4900.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-ts4900.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-ts7970.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-ts7970.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lvds.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lvds.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-tx6.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-udoo.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-udoo.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-udoo.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-var-dart.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-dart.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-var-dart.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-var-dart.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-vicut1-12inch.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-vicut1-12inch.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-vicut1-12inch.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-vicut1-12inch.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-vicut1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-vicut1.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-vicut1.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-wandboard-revb1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-wandboard-revb1.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-wandboard-revc1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-wandboard-revc1.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-wandboard-revd1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-wandboard-revd1.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-wandboard.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-wandboard.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-wandboard.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-zii-rdu2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl-zii-rdu2.dtsi
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
diff --git a/arch/arm/boot/dts/imx6qp-mba6b.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-mba6b.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-mba6b.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-mba6b.dts
diff --git a/arch/arm/boot/dts/imx6qp-nitrogen6_max.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-nitrogen6_max.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-nitrogen6_max.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-nitrogen6_max.dts
diff --git a/arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-nitrogen6_som2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-nitrogen6_som2.dts
diff --git a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-phytec-mira-rdk-nand.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-phytec-mira-rdk-nand.dts
diff --git a/arch/arm/boot/dts/imx6qp-prtwd3.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-prtwd3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-prtwd3.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-prtwd3.dts
diff --git a/arch/arm/boot/dts/imx6qp-sabreauto.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-sabreauto.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-sabresd.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-sabresd.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-sabresd.dts
diff --git a/arch/arm/boot/dts/imx6qp-tqma6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qp-tqma6b.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-tqma6b.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qp-tqma6b.dtsi
diff --git a/arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-tx6qp-8037-mb7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-tx6qp-8037-mb7.dts
diff --git a/arch/arm/boot/dts/imx6qp-tx6qp-8037.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-tx6qp-8037.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-tx6qp-8037.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-tx6qp-8037.dts
diff --git a/arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-tx6qp-8137-mb7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-tx6qp-8137-mb7.dts
diff --git a/arch/arm/boot/dts/imx6qp-tx6qp-8137.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-tx6qp-8137.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-tx6qp-8137.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-tx6qp-8137.dts
diff --git a/arch/arm/boot/dts/imx6qp-vicutp.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-vicutp.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-vicutp.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-vicutp.dts
diff --git a/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-wandboard-revd1.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-wandboard-revd1.dts
diff --git a/arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-yapp4-crux-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-yapp4-crux-plus.dts
diff --git a/arch/arm/boot/dts/imx6qp-yapp4-pegasus-plus.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-yapp4-pegasus-plus.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-yapp4-pegasus-plus.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-yapp4-pegasus-plus.dts
diff --git a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-zii-rdu2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6qp-zii-rdu2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6qp-zii-rdu2.dts
diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qp.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6qp.dtsi
diff --git a/arch/arm/boot/dts/imx6s-dhcom-drc02.dts b/arch/arm/boot/dts/nxp/imx/imx6s-dhcom-drc02.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6s-dhcom-drc02.dts
rename to arch/arm/boot/dts/nxp/imx/imx6s-dhcom-drc02.dts
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-evk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sl-evk.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sl-evk.dts
diff --git a/arch/arm/boot/dts/imx6sl-kobo-aura2.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-kobo-aura2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sl-kobo-aura2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sl-kobo-aura2.dts
diff --git a/arch/arm/boot/dts/imx6sl-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx6sl-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx6sl-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx6sl-pinfunc.h
diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sl-tolino-shine3.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine3.dts
diff --git a/arch/arm/boot/dts/imx6sl-tolino-vision.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sl-tolino-vision.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts
diff --git a/arch/arm/boot/dts/imx6sl-tolino-vision5.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sl-tolino-vision5.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts
diff --git a/arch/arm/boot/dts/imx6sl-warp.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-warp.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sl-warp.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sl-warp.dts
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6sl.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6sl.dtsi
diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/nxp/imx/imx6sll-evk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sll-evk.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sll-evk.dts
diff --git a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts b/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd.dts
diff --git a/arch/arm/boot/dts/imx6sll-kobo-librah2o.dts b/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sll-kobo-librah2o.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts
diff --git a/arch/arm/boot/dts/imx6sll-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx6sll-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx6sll-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx6sll-pinfunc.h
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sll.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6sll.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6sll.dtsi
diff --git a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts
diff --git a/arch/arm/boot/dts/imx6sx-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx6sx-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx6sx-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx6sx-pinfunc.h
diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/nxp/imx/imx6sx-sabreauto.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sx-sabreauto.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sx-sabreauto.dts
diff --git a/arch/arm/boot/dts/imx6sx-sdb-mqs.dts b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb-mqs.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sx-sdb-mqs.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sx-sdb-mqs.dts
diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb-reva.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sx-sdb-reva.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sx-sdb-reva.dts
diff --git a/arch/arm/boot/dts/imx6sx-sdb-sai.dts b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb-sai.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sx-sdb-sai.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sx-sdb-sai.dts
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sx-sdb.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dts
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6sx-sdb.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
diff --git a/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts b/arch/arm/boot/dts/nxp/imx/imx6sx-softing-vining-2000.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sx-softing-vining-2000.dts
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts b/arch/arm/boot/dts/nxp/imx/imx6sx-udoo-neo-basic.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sx-udoo-neo-basic.dts
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts b/arch/arm/boot/dts/nxp/imx/imx6sx-udoo-neo-extended.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sx-udoo-neo-extended.dts
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts b/arch/arm/boot/dts/nxp/imx/imx6sx-udoo-neo-full.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
rename to arch/arm/boot/dts/nxp/imx/imx6sx-udoo-neo-full.dts
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-udoo-neo.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6sx-udoo-neo.dtsi
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6sx.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-14x14-evk.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dts
diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcexpress.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcexpress.dts
diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcpro.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcpro.dts
diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsom.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsom.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-geam.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-geam.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
diff --git a/arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6ul.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6ul.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-isiot-emmc.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-isiot-emmc.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-isiot-emmc.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-isiot-emmc.dts
diff --git a/arch/arm/boot/dts/imx6ul-isiot-nand.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-isiot-nand.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-isiot-nand.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-isiot-nand.dts
diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-isiot.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-43.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-kontron-bl-43.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-43.dts
diff --git a/arch/arm/boot/dts/imx6ul-kontron-bl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-kontron-bl-common.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-kontron-bl.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-kontron-bl.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl.dts
diff --git a/arch/arm/boot/dts/imx6ul-kontron-sl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-kontron-sl-common.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-kontron-sl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-kontron-sl.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-liteboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-liteboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts
diff --git a/arch/arm/boot/dts/imx6ul-litesom.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-litesom.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-litesom.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-litesom.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-opos6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-opos6ul.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-opos6ul.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-opos6ul.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-opos6uldev.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-opos6uldev.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-opos6uldev.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-opos6uldev.dts
diff --git a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-phycore-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-phytec-phycore-som.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-ff-rdk-emmc.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-ff-rdk-emmc.dts
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-ff-rdk-nand.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-ff-rdk-nand.dts
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-peb-av-02.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-av-02.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-phytec-segin-peb-av-02.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-av-02.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-peb-eval-01.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-phytec-segin-peb-eval-01.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-wlbt-05.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-wlbt-05.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-pico-dwarf.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-pico-dwarf.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dts
diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-pico-hobbit.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-pico-hobbit.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-pico-hobbit.dts
diff --git a/arch/arm/boot/dts/imx6ul-pico-pi.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-pico-pi.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-pico-pi.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-pico-pi.dts
diff --git a/arch/arm/boot/dts/imx6ul-pico.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-pico.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx6ul-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx6ul-pinfunc.h
diff --git a/arch/arm/boot/dts/imx6ul-prti6g.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-prti6g.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-prti6g.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-prti6g.dts
diff --git a/arch/arm/boot/dts/imx6ul-tqma6ul-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-tqma6ul-common.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-tqma6ul1-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-tqma6ul1-mba6ulx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts
diff --git a/arch/arm/boot/dts/imx6ul-tqma6ul1.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-tqma6ul1.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-tqma6ul2-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2-mba6ulx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-tqma6ul2-mba6ulx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2-mba6ulx.dts
diff --git a/arch/arm/boot/dts/imx6ul-tqma6ul2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-tqma6ul2.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-tqma6ul2l-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-tqma6ul2l-mba6ulx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts
diff --git a/arch/arm/boot/dts/imx6ul-tqma6ul2l.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-tqma6ul2l.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-tqma6ulx-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulx-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-tqma6ulx-common.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulx-common.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-tqma6ulxl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulxl-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-tqma6ulxl-common.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulxl-common.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul-0010.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0010.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-tx6ul-0010.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0010.dts
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul-0011.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0011.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-tx6ul-0011.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0011.dts
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-mainboard.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-mainboard.dts
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-tx6ul.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-14x14-evk.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-14x14-evk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-14x14-evk.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-14x14-evk.dts
diff --git a/arch/arm/boot/dts/imx6ull-colibri-aster.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-aster.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dts
diff --git a/arch/arm/boot/dts/imx6ull-colibri-aster.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-aster.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-aster.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-aster.dts
diff --git a/arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-eval-v3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-eval-v3.dts
diff --git a/arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-iris-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-iris-v2.dts
diff --git a/arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-iris.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-iris.dts
diff --git a/arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-nonwifi.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-emmc-nonwifi.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-eval-v3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-eval-v3.dts
diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-eval-v3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-eval-v3.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-iris-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-iris-v2.dts
diff --git a/arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-iris-v2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-iris-v2.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-colibri-iris.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-iris.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-iris.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-iris.dts
diff --git a/arch/arm/boot/dts/imx6ull-colibri-iris.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-iris.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-iris.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-iris.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-nonwifi.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-nonwifi.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-wifi-aster.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-wifi-aster.dts
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-wifi-eval-v3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-wifi-eval-v3.dts
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-wifi-iris-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-wifi-iris-v2.dts
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-wifi-iris.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-wifi-iris.dts
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-wifi.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri-wifi.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-colibri.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-dhcom-drc02.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-drc02.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-dhcom-drc02.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-drc02.dts
diff --git a/arch/arm/boot/dts/imx6ull-dhcom-pdk2.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-dhcom-pdk2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
diff --git a/arch/arm/boot/dts/imx6ull-dhcom-picoitx.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-picoitx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-dhcom-picoitx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-picoitx.dts
diff --git a/arch/arm/boot/dts/imx6ull-dhcom-som-cfg-sdcard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som-cfg-sdcard.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-dhcom-som-cfg-sdcard.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som-cfg-sdcard.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-dhcom-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-dhcom-som.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-dhcor-som.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-som.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-jozacp.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-jozacp.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-jozacp.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-jozacp.dts
diff --git a/arch/arm/boot/dts/imx6ull-kontron-bl.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-kontron-bl.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-kontron-bl.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-kontron-bl.dts
diff --git a/arch/arm/boot/dts/imx6ull-kontron-sl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-kontron-sl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-kontron-sl.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-kontron-sl.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx-eval.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx-eval.dts
diff --git a/arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-opos6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-opos6ul.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-opos6ul.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-opos6ul.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-opos6uldev.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-opos6uldev.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-opos6uldev.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-opos6uldev.dts
diff --git a/arch/arm/boot/dts/imx6ull-phytec-phycore-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-phycore-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-phytec-phycore-som.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-phytec-phycore-som.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin-ff-rdk-emmc.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin-ff-rdk-emmc.dts
diff --git a/arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin-ff-rdk-nand.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin-ff-rdk-nand.dts
diff --git a/arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin-lc-rdk-nand.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin-lc-rdk-nand.dts
diff --git a/arch/arm/boot/dts/imx6ull-phytec-segin-peb-av-02.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin-peb-av-02.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-phytec-segin-peb-av-02.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin-peb-av-02.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-phytec-segin-peb-eval-01.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin-peb-eval-01.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-phytec-segin-peb-eval-01.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin-peb-eval-01.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-phytec-segin-peb-wlbt-05.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin-peb-wlbt-05.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-phytec-segin-peb-wlbt-05.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin-peb-wlbt-05.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-phytec-segin.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-phytec-segin.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-phytec-segin.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-phytec-tauri-emmc.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri-emmc.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-phytec-tauri-emmc.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri-emmc.dts
diff --git a/arch/arm/boot/dts/imx6ull-phytec-tauri-nand.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri-nand.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-phytec-tauri-nand.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri-nand.dts
diff --git a/arch/arm/boot/dts/imx6ull-phytec-tauri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-phytec-tauri.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h b/arch/arm/boot/dts/nxp/imx/imx6ull-pinfunc-snvs.h
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
rename to arch/arm/boot/dts/nxp/imx/imx6ull-pinfunc-snvs.h
diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx6ull-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx6ull-pinfunc.h
diff --git a/arch/arm/boot/dts/imx6ull-tarragon-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-tarragon-common.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-common.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-tarragon-master.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-master.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-tarragon-master.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-master.dts
diff --git a/arch/arm/boot/dts/imx6ull-tarragon-micro.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-micro.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-tarragon-micro.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-micro.dts
diff --git a/arch/arm/boot/dts/imx6ull-tarragon-slave.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-slave.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-tarragon-slave.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-slave.dts
diff --git a/arch/arm/boot/dts/imx6ull-tarragon-slavext.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-slavext.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-tarragon-slavext.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-slavext.dts
diff --git a/arch/arm/boot/dts/imx6ull-tqma6ull2-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2-mba6ulx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-tqma6ull2-mba6ulx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2-mba6ulx.dts
diff --git a/arch/arm/boot/dts/imx6ull-tqma6ull2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-tqma6ull2.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2.dtsi
diff --git a/arch/arm/boot/dts/imx6ull-tqma6ull2l-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l-mba6ulx.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-tqma6ull2l-mba6ulx.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l-mba6ulx.dts
diff --git a/arch/arm/boot/dts/imx6ull-tqma6ull2l.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull-tqma6ull2l.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l.dtsi
diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ull.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ull.dtsi
diff --git a/arch/arm/boot/dts/imx6ulz-14x14-evk.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-14x14-evk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ulz-14x14-evk.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ulz-14x14-evk.dts
diff --git a/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
rename to arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts
diff --git a/arch/arm/boot/dts/imx6ulz.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ulz.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ulz.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx6ulz.dtsi
diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-colibri-aster.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7-colibri-aster.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7-colibri-aster.dtsi
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-colibri-eval-v3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7-colibri-eval-v3.dtsi
diff --git a/arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-colibri-iris-v2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7-colibri-iris-v2.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7-colibri-iris-v2.dtsi
diff --git a/arch/arm/boot/dts/imx7-colibri-iris.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-colibri-iris.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7-colibri-iris.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7-colibri-iris.dtsi
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7-colibri.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7-mba7.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
diff --git a/arch/arm/boot/dts/imx7-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7-tqma7.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/nxp/imx/imx7d-cl-som-imx7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-cl-som-imx7.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-cl-som-imx7.dts
diff --git a/arch/arm/boot/dts/imx7d-colibri-aster.dts b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-aster.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-colibri-aster.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-colibri-aster.dts
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-aster.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-aster.dts
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-eval-v3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-eval-v3.dts
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-iris-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-iris-v2.dts
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-iris.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-colibri-emmc-iris.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-iris.dts
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc.dtsi
diff --git a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-eval-v3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-colibri-eval-v3.dts
diff --git a/arch/arm/boot/dts/imx7d-colibri-iris-v2.dts b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-iris-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-colibri-iris-v2.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-colibri-iris-v2.dts
diff --git a/arch/arm/boot/dts/imx7d-colibri-iris.dts b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-iris.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-colibri-iris.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-colibri-iris.dts
diff --git a/arch/arm/boot/dts/imx7d-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d-colibri.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7d-colibri.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7d-colibri.dtsi
diff --git a/arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dts b/arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator-mfg.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator-mfg.dts
diff --git a/arch/arm/boot/dts/imx7d-flex-concentrator.dts b/arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-flex-concentrator.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts
diff --git a/arch/arm/boot/dts/imx7d-mba7.dts b/arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-mba7.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts
diff --git a/arch/arm/boot/dts/imx7d-meerkat96.dts b/arch/arm/boot/dts/nxp/imx/imx7d-meerkat96.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-meerkat96.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-meerkat96.dts
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-nitrogen7.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
diff --git a/arch/arm/boot/dts/imx7d-pico-dwarf.dts b/arch/arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-pico-dwarf.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dts
diff --git a/arch/arm/boot/dts/imx7d-pico-hobbit.dts b/arch/arm/boot/dts/nxp/imx/imx7d-pico-hobbit.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-pico-hobbit.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-pico-hobbit.dts
diff --git a/arch/arm/boot/dts/imx7d-pico-nymph.dts b/arch/arm/boot/dts/nxp/imx/imx7d-pico-nymph.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-pico-nymph.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-pico-nymph.dts
diff --git a/arch/arm/boot/dts/imx7d-pico-pi.dts b/arch/arm/boot/dts/nxp/imx/imx7d-pico-pi.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-pico-pi.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-pico-pi.dts
diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d-pico.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7d-pico.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7d-pico.dtsi
diff --git a/arch/arm/boot/dts/imx7d-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx7d-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx7d-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx7d-pinfunc.h
diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/nxp/imx/imx7d-remarkable2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-remarkable2.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-remarkable2.dts
diff --git a/arch/arm/boot/dts/imx7d-sbc-imx7.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sbc-imx7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-sbc-imx7.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-sbc-imx7.dts
diff --git a/arch/arm/boot/dts/imx7d-sdb-reva.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sdb-reva.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-sdb-reva.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-sdb-reva.dts
diff --git a/arch/arm/boot/dts/imx7d-sdb-sht11.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sdb-sht11.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-sdb-sht11.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-sdb-sht11.dts
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-sdb.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
diff --git a/arch/arm/boot/dts/imx7d-smegw01.dts b/arch/arm/boot/dts/nxp/imx/imx7d-smegw01.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-smegw01.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-smegw01.dts
diff --git a/arch/arm/boot/dts/imx7d-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d-tqma7.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7d-tqma7.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7d-tqma7.dtsi
diff --git a/arch/arm/boot/dts/imx7d-zii-rmu2.dts b/arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-zii-rmu2.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts
diff --git a/arch/arm/boot/dts/imx7d-zii-rpu2.dts b/arch/arm/boot/dts/nxp/imx/imx7d-zii-rpu2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7d-zii-rpu2.dts
rename to arch/arm/boot/dts/nxp/imx/imx7d-zii-rpu2.dts
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7d.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7d.dtsi
diff --git a/arch/arm/boot/dts/imx7s-colibri-aster.dts b/arch/arm/boot/dts/nxp/imx/imx7s-colibri-aster.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7s-colibri-aster.dts
rename to arch/arm/boot/dts/nxp/imx/imx7s-colibri-aster.dts
diff --git a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts b/arch/arm/boot/dts/nxp/imx/imx7s-colibri-eval-v3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
rename to arch/arm/boot/dts/nxp/imx/imx7s-colibri-eval-v3.dts
diff --git a/arch/arm/boot/dts/imx7s-colibri-iris-v2.dts b/arch/arm/boot/dts/nxp/imx/imx7s-colibri-iris-v2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7s-colibri-iris-v2.dts
rename to arch/arm/boot/dts/nxp/imx/imx7s-colibri-iris-v2.dts
diff --git a/arch/arm/boot/dts/imx7s-colibri-iris.dts b/arch/arm/boot/dts/nxp/imx/imx7s-colibri-iris.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7s-colibri-iris.dts
rename to arch/arm/boot/dts/nxp/imx/imx7s-colibri-iris.dts
diff --git a/arch/arm/boot/dts/imx7s-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s-colibri.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7s-colibri.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7s-colibri.dtsi
diff --git a/arch/arm/boot/dts/imx7s-mba7.dts b/arch/arm/boot/dts/nxp/imx/imx7s-mba7.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7s-mba7.dts
rename to arch/arm/boot/dts/nxp/imx/imx7s-mba7.dts
diff --git a/arch/arm/boot/dts/imx7s-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s-tqma7.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7s-tqma7.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7s-tqma7.dtsi
diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7s-warp.dts
rename to arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7s.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7s.dtsi
diff --git a/arch/arm/boot/dts/imx7ulp-com.dts b/arch/arm/boot/dts/nxp/imx/imx7ulp-com.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7ulp-com.dts
rename to arch/arm/boot/dts/nxp/imx/imx7ulp-com.dts
diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/nxp/imx/imx7ulp-evk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx7ulp-evk.dts
rename to arch/arm/boot/dts/nxp/imx/imx7ulp-evk.dts
diff --git a/arch/arm/boot/dts/imx7ulp-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imx7ulp-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx7ulp-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imx7ulp-pinfunc.h
diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/nxp/imx/imx7ulp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx7ulp.dtsi
rename to arch/arm/boot/dts/nxp/imx/imx7ulp.dtsi
diff --git a/arch/arm/boot/dts/imxrt1050-evk.dts b/arch/arm/boot/dts/nxp/imx/imxrt1050-evk.dts
similarity index 100%
rename from arch/arm/boot/dts/imxrt1050-evk.dts
rename to arch/arm/boot/dts/nxp/imx/imxrt1050-evk.dts
diff --git a/arch/arm/boot/dts/imxrt1050-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imxrt1050-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imxrt1050-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imxrt1050-pinfunc.h
diff --git a/arch/arm/boot/dts/imxrt1050.dtsi b/arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi
similarity index 99%
rename from arch/arm/boot/dts/imxrt1050.dtsi
rename to arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi
index 852861558b47..dd714d235d5f 100644
--- a/arch/arm/boot/dts/imxrt1050.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi
@@ -4,7 +4,7 @@
  * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
  */
 
-#include "armv7-m.dtsi"
+#include "../../armv7-m.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/imxrt1050-clock.h>
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm/boot/dts/imxrt1170-pinfunc.h b/arch/arm/boot/dts/nxp/imx/imxrt1170-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imxrt1170-pinfunc.h
rename to arch/arm/boot/dts/nxp/imx/imxrt1170-pinfunc.h
diff --git a/arch/arm/boot/dts/mba6ulx.dtsi b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mba6ulx.dtsi
rename to arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
diff --git a/arch/arm/boot/dts/nxp/lpc/Makefile b/arch/arm/boot/dts/nxp/lpc/Makefile
new file mode 100644
index 000000000000..56b9a0ebb917
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/lpc/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_LPC18XX) += \
+	lpc4337-ciaa.dtb \
+	lpc4350-hitex-eval.dtb \
+	lpc4357-ea4357-devkit.dtb \
+	lpc4357-myd-lpc4357.dtb
+dtb-$(CONFIG_ARCH_LPC32XX) += \
+	lpc3250-ea3250.dtb \
+	lpc3250-phy3250.dtb
diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi
similarity index 99%
rename from arch/arm/boot/dts/lpc18xx.dtsi
rename to arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi
index 1bb686a7b3ec..9cf09c183b85 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi
@@ -11,7 +11,7 @@
  *
  */
 
-#include "armv7-m.dtsi"
+#include "../../armv7-m.dtsi"
 
 #include "dt-bindings/clock/lpc18xx-cgu.h"
 #include "dt-bindings/clock/lpc18xx-ccu.h"
diff --git a/arch/arm/boot/dts/lpc3250-ea3250.dts b/arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dts
similarity index 100%
rename from arch/arm/boot/dts/lpc3250-ea3250.dts
rename to arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dts
diff --git a/arch/arm/boot/dts/lpc3250-phy3250.dts b/arch/arm/boot/dts/nxp/lpc/lpc3250-phy3250.dts
similarity index 100%
rename from arch/arm/boot/dts/lpc3250-phy3250.dts
rename to arch/arm/boot/dts/nxp/lpc/lpc3250-phy3250.dts
diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/lpc32xx.dtsi
rename to arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
diff --git a/arch/arm/boot/dts/lpc4337-ciaa.dts b/arch/arm/boot/dts/nxp/lpc/lpc4337-ciaa.dts
similarity index 100%
rename from arch/arm/boot/dts/lpc4337-ciaa.dts
rename to arch/arm/boot/dts/nxp/lpc/lpc4337-ciaa.dts
diff --git a/arch/arm/boot/dts/lpc4350-hitex-eval.dts b/arch/arm/boot/dts/nxp/lpc/lpc4350-hitex-eval.dts
similarity index 100%
rename from arch/arm/boot/dts/lpc4350-hitex-eval.dts
rename to arch/arm/boot/dts/nxp/lpc/lpc4350-hitex-eval.dts
diff --git a/arch/arm/boot/dts/lpc4350.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc4350.dtsi
similarity index 100%
rename from arch/arm/boot/dts/lpc4350.dtsi
rename to arch/arm/boot/dts/nxp/lpc/lpc4350.dtsi
diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/nxp/lpc/lpc4357-ea4357-devkit.dts
similarity index 100%
rename from arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
rename to arch/arm/boot/dts/nxp/lpc/lpc4357-ea4357-devkit.dts
diff --git a/arch/arm/boot/dts/lpc4357-myd-lpc4357.dts b/arch/arm/boot/dts/nxp/lpc/lpc4357-myd-lpc4357.dts
similarity index 100%
rename from arch/arm/boot/dts/lpc4357-myd-lpc4357.dts
rename to arch/arm/boot/dts/nxp/lpc/lpc4357-myd-lpc4357.dts
diff --git a/arch/arm/boot/dts/lpc4357.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc4357.dtsi
similarity index 100%
rename from arch/arm/boot/dts/lpc4357.dtsi
rename to arch/arm/boot/dts/nxp/lpc/lpc4357.dtsi
diff --git a/arch/arm/boot/dts/nxp/ls/Makefile b/arch/arm/boot/dts/nxp/ls/Makefile
new file mode 100644
index 000000000000..3cb1d516f6fb
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/ls/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_SOC_LS1021A) += \
+	ls1021a-iot.dtb \
+	ls1021a-moxa-uc-8410a.dtb \
+	ls1021a-qds.dtb \
+	ls1021a-tsn.dtb \
+	ls1021a-twr.dtb
diff --git a/arch/arm/boot/dts/ls1021a-iot.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
similarity index 100%
rename from arch/arm/boot/dts/ls1021a-iot.dts
rename to arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
diff --git a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-moxa-uc-8410a.dts
similarity index 100%
rename from arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
rename to arch/arm/boot/dts/nxp/ls/ls1021a-moxa-uc-8410a.dts
diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
similarity index 100%
rename from arch/arm/boot/dts/ls1021a-qds.dts
rename to arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
diff --git a/arch/arm/boot/dts/ls1021a-tsn.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
similarity index 100%
rename from arch/arm/boot/dts/ls1021a-tsn.dts
rename to arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts
similarity index 100%
rename from arch/arm/boot/dts/ls1021a-twr.dts
rename to arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ls1021a.dtsi
rename to arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
diff --git a/arch/arm/boot/dts/nxp/mxs/Makefile b/arch/arm/boot/dts/nxp/mxs/Makefile
new file mode 100644
index 000000000000..a430d04f9c69
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/mxs/Makefile
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_MXS) += \
+	imx23-evk.dtb \
+	imx23-olinuxino.dtb \
+	imx23-sansa.dtb \
+	imx23-stmp378x_devb.dtb \
+	imx23-xfi3.dtb \
+	imx28-apf28.dtb \
+	imx28-apf28dev.dtb \
+	imx28-apx4devkit.dtb \
+	imx28-cfa10036.dtb \
+	imx28-cfa10037.dtb \
+	imx28-cfa10049.dtb \
+	imx28-cfa10055.dtb \
+	imx28-cfa10056.dtb \
+	imx28-cfa10057.dtb \
+	imx28-cfa10058.dtb \
+	imx28-duckbill-2-485.dtb \
+	imx28-duckbill-2.dtb \
+	imx28-duckbill-2-enocean.dtb \
+	imx28-duckbill-2-spi.dtb \
+	imx28-duckbill.dtb \
+	imx28-eukrea-mbmx283lc.dtb \
+	imx28-eukrea-mbmx287lc.dtb \
+	imx28-evk.dtb \
+	imx28-m28cu3.dtb \
+	imx28-m28evk.dtb \
+	imx28-sps1.dtb \
+	imx28-ts4600.dtb \
+	imx28-tx28.dtb \
+	imx28-xea.dtb
diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/nxp/mxs/imx23-evk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx23-evk.dts
rename to arch/arm/boot/dts/nxp/mxs/imx23-evk.dts
diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dts
similarity index 100%
rename from arch/arm/boot/dts/imx23-olinuxino.dts
rename to arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dts
diff --git a/arch/arm/boot/dts/imx23-pinfunc.h b/arch/arm/boot/dts/nxp/mxs/imx23-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx23-pinfunc.h
rename to arch/arm/boot/dts/nxp/mxs/imx23-pinfunc.h
diff --git a/arch/arm/boot/dts/imx23-sansa.dts b/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
similarity index 100%
rename from arch/arm/boot/dts/imx23-sansa.dts
rename to arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
diff --git a/arch/arm/boot/dts/imx23-stmp378x_devb.dts b/arch/arm/boot/dts/nxp/mxs/imx23-stmp378x_devb.dts
similarity index 100%
rename from arch/arm/boot/dts/imx23-stmp378x_devb.dts
rename to arch/arm/boot/dts/nxp/mxs/imx23-stmp378x_devb.dts
diff --git a/arch/arm/boot/dts/imx23-xfi3.dts b/arch/arm/boot/dts/nxp/mxs/imx23-xfi3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx23-xfi3.dts
rename to arch/arm/boot/dts/nxp/mxs/imx23-xfi3.dts
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/nxp/mxs/imx23.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx23.dtsi
rename to arch/arm/boot/dts/nxp/mxs/imx23.dtsi
diff --git a/arch/arm/boot/dts/imx28-apf28.dts b/arch/arm/boot/dts/nxp/mxs/imx28-apf28.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-apf28.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-apf28.dts
diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/nxp/mxs/imx28-apf28dev.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-apf28dev.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-apf28dev.dts
diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/nxp/mxs/imx28-apx4devkit.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-apx4devkit.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-apx4devkit.dts
diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10036.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-cfa10036.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-cfa10036.dts
diff --git a/arch/arm/boot/dts/imx28-cfa10037.dts b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10037.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-cfa10037.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-cfa10037.dts
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10049.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-cfa10049.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-cfa10049.dts
diff --git a/arch/arm/boot/dts/imx28-cfa10055.dts b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10055.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-cfa10055.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-cfa10055.dts
diff --git a/arch/arm/boot/dts/imx28-cfa10056.dts b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10056.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-cfa10056.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-cfa10056.dts
diff --git a/arch/arm/boot/dts/imx28-cfa10057.dts b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10057.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-cfa10057.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-cfa10057.dts
diff --git a/arch/arm/boot/dts/imx28-cfa10058.dts b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10058.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-cfa10058.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-cfa10058.dts
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-485.dts b/arch/arm/boot/dts/nxp/mxs/imx28-duckbill-2-485.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-duckbill-2-485.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-duckbill-2-485.dts
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts b/arch/arm/boot/dts/nxp/mxs/imx28-duckbill-2-enocean.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-duckbill-2-enocean.dts
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-spi.dts b/arch/arm/boot/dts/nxp/mxs/imx28-duckbill-2-spi.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-duckbill-2-spi.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-duckbill-2-spi.dts
diff --git a/arch/arm/boot/dts/imx28-duckbill-2.dts b/arch/arm/boot/dts/nxp/mxs/imx28-duckbill-2.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-duckbill-2.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-duckbill-2.dts
diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/nxp/mxs/imx28-duckbill.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-duckbill.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-duckbill.dts
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts b/arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx283lc.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx283lc.dts
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts b/arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx287lc.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx287lc.dts
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx28lc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
rename to arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx28lc.dtsi
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/nxp/mxs/imx28-evk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-evk.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-evk.dts
diff --git a/arch/arm/boot/dts/imx28-lwe.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx28-lwe.dtsi
rename to arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28-m28.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx28-m28.dtsi
rename to arch/arm/boot/dts/nxp/mxs/imx28-m28.dtsi
diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/nxp/mxs/imx28-m28cu3.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-m28cu3.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-m28cu3.dts
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-m28evk.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts
diff --git a/arch/arm/boot/dts/imx28-pinfunc.h b/arch/arm/boot/dts/nxp/mxs/imx28-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/imx28-pinfunc.h
rename to arch/arm/boot/dts/nxp/mxs/imx28-pinfunc.h
diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/nxp/mxs/imx28-sps1.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-sps1.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-sps1.dts
diff --git a/arch/arm/boot/dts/imx28-ts4600.dts b/arch/arm/boot/dts/nxp/mxs/imx28-ts4600.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-ts4600.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-ts4600.dts
diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/nxp/mxs/imx28-tx28.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-tx28.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-tx28.dts
diff --git a/arch/arm/boot/dts/imx28-xea.dts b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
similarity index 100%
rename from arch/arm/boot/dts/imx28-xea.dts
rename to arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx28.dtsi
rename to arch/arm/boot/dts/nxp/mxs/imx28.dtsi
diff --git a/arch/arm/boot/dts/mxs-pinfunc.h b/arch/arm/boot/dts/nxp/mxs/mxs-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/mxs-pinfunc.h
rename to arch/arm/boot/dts/nxp/mxs/mxs-pinfunc.h
diff --git a/arch/arm/boot/dts/nxp/vf/Makefile b/arch/arm/boot/dts/nxp/vf/Makefile
new file mode 100644
index 000000000000..0a4a7f9dd43e
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/vf/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_SOC_VF610) += \
+	vf500-colibri-eval-v3.dtb \
+	vf610-bk4.dtb \
+	vf610-colibri-eval-v3.dtb \
+	vf610m4-colibri.dtb \
+	vf610-cosmic.dtb \
+	vf610m4-cosmic.dtb \
+	vf610-twr.dtb \
+	vf610-zii-cfu1.dtb \
+	vf610-zii-dev-rev-b.dtb \
+	vf610-zii-dev-rev-c.dtb \
+	vf610-zii-scu4-aib.dtb \
+	vf610-zii-spb4.dtb \
+	vf610-zii-ssmb-dtu.dtb \
+	vf610-zii-ssmb-spu3.dtb
diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/nxp/vf/vf-colibri-eval-v3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
rename to arch/arm/boot/dts/nxp/vf/vf-colibri-eval-v3.dtsi
diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/nxp/vf/vf-colibri.dtsi
similarity index 100%
rename from arch/arm/boot/dts/vf-colibri.dtsi
rename to arch/arm/boot/dts/nxp/vf/vf-colibri.dtsi
diff --git a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts b/arch/arm/boot/dts/nxp/vf/vf500-colibri-eval-v3.dts
similarity index 100%
rename from arch/arm/boot/dts/vf500-colibri-eval-v3.dts
rename to arch/arm/boot/dts/nxp/vf/vf500-colibri-eval-v3.dts
diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi b/arch/arm/boot/dts/nxp/vf/vf500-colibri.dtsi
similarity index 100%
rename from arch/arm/boot/dts/vf500-colibri.dtsi
rename to arch/arm/boot/dts/nxp/vf/vf500-colibri.dtsi
diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/nxp/vf/vf500.dtsi
similarity index 100%
rename from arch/arm/boot/dts/vf500.dtsi
rename to arch/arm/boot/dts/nxp/vf/vf500.dtsi
diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/nxp/vf/vf610-bk4.dts
similarity index 100%
rename from arch/arm/boot/dts/vf610-bk4.dts
rename to arch/arm/boot/dts/nxp/vf/vf610-bk4.dts
diff --git a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts b/arch/arm/boot/dts/nxp/vf/vf610-colibri-eval-v3.dts
similarity index 100%
rename from arch/arm/boot/dts/vf610-colibri-eval-v3.dts
rename to arch/arm/boot/dts/nxp/vf/vf610-colibri-eval-v3.dts
diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/nxp/vf/vf610-colibri.dtsi
similarity index 100%
rename from arch/arm/boot/dts/vf610-colibri.dtsi
rename to arch/arm/boot/dts/nxp/vf/vf610-colibri.dtsi
diff --git a/arch/arm/boot/dts/vf610-cosmic.dts b/arch/arm/boot/dts/nxp/vf/vf610-cosmic.dts
similarity index 100%
rename from arch/arm/boot/dts/vf610-cosmic.dts
rename to arch/arm/boot/dts/nxp/vf/vf610-cosmic.dts
diff --git a/arch/arm/boot/dts/vf610-pinfunc.h b/arch/arm/boot/dts/nxp/vf/vf610-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/vf610-pinfunc.h
rename to arch/arm/boot/dts/nxp/vf/vf610-pinfunc.h
diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/nxp/vf/vf610-twr.dts
similarity index 100%
rename from arch/arm/boot/dts/vf610-twr.dts
rename to arch/arm/boot/dts/nxp/vf/vf610-twr.dts
diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts
similarity index 100%
rename from arch/arm/boot/dts/vf610-zii-cfu1.dts
rename to arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts
diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
similarity index 100%
rename from arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
rename to arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-c.dts
similarity index 100%
rename from arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
rename to arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-c.dts
diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/nxp/vf/vf610-zii-dev.dtsi
similarity index 100%
rename from arch/arm/boot/dts/vf610-zii-dev.dtsi
rename to arch/arm/boot/dts/nxp/vf/vf610-zii-dev.dtsi
diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts
similarity index 100%
rename from arch/arm/boot/dts/vf610-zii-scu4-aib.dts
rename to arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts
diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts
similarity index 100%
rename from arch/arm/boot/dts/vf610-zii-spb4.dts
rename to arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
similarity index 100%
rename from arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
rename to arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts
similarity index 100%
rename from arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
rename to arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts
diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/nxp/vf/vf610.dtsi
similarity index 100%
rename from arch/arm/boot/dts/vf610.dtsi
rename to arch/arm/boot/dts/nxp/vf/vf610.dtsi
diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/nxp/vf/vf610m4-colibri.dts
similarity index 100%
rename from arch/arm/boot/dts/vf610m4-colibri.dts
rename to arch/arm/boot/dts/nxp/vf/vf610m4-colibri.dts
diff --git a/arch/arm/boot/dts/vf610m4-cosmic.dts b/arch/arm/boot/dts/nxp/vf/vf610m4-cosmic.dts
similarity index 100%
rename from arch/arm/boot/dts/vf610m4-cosmic.dts
rename to arch/arm/boot/dts/nxp/vf/vf610m4-cosmic.dts
diff --git a/arch/arm/boot/dts/vf610m4.dtsi b/arch/arm/boot/dts/nxp/vf/vf610m4.dtsi
similarity index 98%
rename from arch/arm/boot/dts/vf610m4.dtsi
rename to arch/arm/boot/dts/nxp/vf/vf610m4.dtsi
index 76bbfd5e32b6..2bb331a87721 100644
--- a/arch/arm/boot/dts/vf610m4.dtsi
+++ b/arch/arm/boot/dts/nxp/vf/vf610m4.dtsi
@@ -42,7 +42,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "armv7-m.dtsi"
+#include "../../armv7-m.dtsi"
 #include "vfxxx.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/vfxxx.dtsi
rename to arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
new file mode 100644
index 000000000000..3452194adc5d
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/Makefile
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_QCOM) += \
+	qcom-apq8016-sbc.dtb \
+	qcom-apq8026-asus-sparrow.dtb \
+	qcom-apq8026-huawei-sturgeon.dtb \
+	qcom-apq8026-lg-lenok.dtb \
+	qcom-apq8026-samsung-matisse-wifi.dtb \
+	qcom-apq8060-dragonboard.dtb \
+	qcom-apq8064-cm-qs600.dtb \
+	qcom-apq8064-ifc6410.dtb \
+	qcom-apq8064-sony-xperia-lagan-yuga.dtb \
+	qcom-apq8064-asus-nexus7-flo.dtb \
+	qcom-apq8074-dragonboard.dtb \
+	qcom-apq8084-ifc6540.dtb \
+	qcom-apq8084-mtp.dtb \
+	qcom-ipq4018-ap120c-ac.dtb \
+	qcom-ipq4018-ap120c-ac-bit.dtb \
+	qcom-ipq4018-jalapeno.dtb \
+	qcom-ipq4019-ap.dk01.1-c1.dtb \
+	qcom-ipq4019-ap.dk04.1-c1.dtb \
+	qcom-ipq4019-ap.dk04.1-c3.dtb \
+	qcom-ipq4019-ap.dk07.1-c1.dtb \
+	qcom-ipq4019-ap.dk07.1-c2.dtb \
+	qcom-ipq8064-ap148.dtb \
+	qcom-ipq8064-rb3011.dtb \
+	qcom-msm8226-samsung-s3ve3g.dtb \
+	qcom-msm8660-surf.dtb \
+	qcom-msm8916-samsung-e5.dtb \
+	qcom-msm8916-samsung-e7.dtb \
+	qcom-msm8916-samsung-grandmax.dtb \
+	qcom-msm8916-samsung-serranove.dtb \
+	qcom-msm8960-cdp.dtb \
+	qcom-msm8974-lge-nexus5-hammerhead.dtb \
+	qcom-msm8974-sony-xperia-rhine-amami.dtb \
+	qcom-msm8974-sony-xperia-rhine-honami.dtb \
+	qcom-msm8974pro-fairphone-fp2.dtb \
+	qcom-msm8974pro-oneplus-bacon.dtb \
+	qcom-msm8974pro-samsung-klte.dtb \
+	qcom-msm8974pro-sony-xperia-shinano-castor.dtb \
+	qcom-mdm9615-wp8548-mangoh-green.dtb \
+	qcom-sdx55-mtp.dtb \
+	qcom-sdx55-t55.dtb \
+	qcom-sdx55-telit-fn980-tlb.dtb \
+	qcom-sdx65-mtp.dtb
diff --git a/arch/arm/boot/dts/qcom-apq8016-sbc.dts b/arch/arm/boot/dts/qcom/qcom-apq8016-sbc.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8016-sbc.dts
rename to arch/arm/boot/dts/qcom/qcom-apq8016-sbc.dts
diff --git a/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
rename to arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts
diff --git a/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
rename to arch/arm/boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts
diff --git a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
rename to arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts
diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
rename to arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
rename to arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
rename to arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
rename to arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
rename to arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8064-pins.dtsi
rename to arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi
diff --git a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts
rename to arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
diff --git a/arch/arm/boot/dts/qcom-apq8064-v2.0.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064-v2.0.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8064-v2.0.dtsi
rename to arch/arm/boot/dts/qcom/qcom-apq8064-v2.0.dtsi
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8064.dtsi
rename to arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
rename to arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts
diff --git a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts b/arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
rename to arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts
diff --git a/arch/arm/boot/dts/qcom-apq8084-mtp.dts b/arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8084-mtp.dts
rename to arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8084.dtsi
rename to arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts b/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac-bit.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
rename to arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac-bit.dts
diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts b/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
rename to arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dts
diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts b/arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts
rename to arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dts b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1-c1.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dts
rename to arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1-c1.dts
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1-c1.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
rename to arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1-c1.dts
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1-c3.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
rename to arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1-c3.dts
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1-c1.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
rename to arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1-c1.dts
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1-c2.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
rename to arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1-c2.dts
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk07.1.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq4019.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq8062-smb208.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8062-smb208.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq8062-smb208.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq8062-smb208.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq8062.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq8062.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts b/arch/arm/boot/dts/qcom/qcom-ipq8064-ap148.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq8064-ap148.dts
rename to arch/arm/boot/dts/qcom/qcom-ipq8064-ap148.dts
diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom/qcom-ipq8064-rb3011.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
rename to arch/arm/boot/dts/qcom/qcom-ipq8064-rb3011.dts
diff --git a/arch/arm/boot/dts/qcom-ipq8064-smb208.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064-smb208.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq8064-smb208.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq8064-smb208.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064-v1.0.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq8064-v1.0.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064-v2.0-smb208.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq8064-v2.0-smb208.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064-v2.0.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq8064-v2.0.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq8064.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq8065-smb208.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8065-smb208.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq8065-smb208.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq8065-smb208.dtsi
diff --git a/arch/arm/boot/dts/qcom-ipq8065.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-ipq8065.dtsi
rename to arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi
diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts b/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548-mangoh-green.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
rename to arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548-mangoh-green.dts
diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi b/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
rename to arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-mdm9615.dtsi
rename to arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
diff --git a/arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts b/arch/arm/boot/dts/qcom/qcom-msm8226-samsung-s3ve3g.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8226-samsung-s3ve3g.dts
diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8226.dtsi
rename to arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
diff --git a/arch/arm/boot/dts/qcom-msm8660-surf.dts b/arch/arm/boot/dts/qcom/qcom-msm8660-surf.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8660-surf.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8660-surf.dts
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8660.dtsi
rename to arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
diff --git a/arch/arm/boot/dts/qcom-msm8916-samsung-e5.dts b/arch/arm/boot/dts/qcom/qcom-msm8916-samsung-e5.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8916-samsung-e5.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8916-samsung-e5.dts
diff --git a/arch/arm/boot/dts/qcom-msm8916-samsung-e7.dts b/arch/arm/boot/dts/qcom/qcom-msm8916-samsung-e7.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8916-samsung-e7.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8916-samsung-e7.dts
diff --git a/arch/arm/boot/dts/qcom-msm8916-samsung-grandmax.dts b/arch/arm/boot/dts/qcom/qcom-msm8916-samsung-grandmax.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8916-samsung-grandmax.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8916-samsung-grandmax.dts
diff --git a/arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dts b/arch/arm/boot/dts/qcom/qcom-msm8916-samsung-serranove.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8916-samsung-serranove.dts
diff --git a/arch/arm/boot/dts/qcom-msm8916-smp.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8916-smp.dtsi
rename to arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi
diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8960-cdp.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8960.dtsi
rename to arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dts b/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine-amami.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine-amami.dts
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dts b/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine-honami.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine-honami.dts
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
rename to arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974.dtsi
rename to arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-oneplus-bacon.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8974pro-oneplus-bacon.dts
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
rename to arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
diff --git a/arch/arm/boot/dts/qcom-msm8974pro.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974pro.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974pro.dtsi
rename to arch/arm/boot/dts/qcom/qcom-msm8974pro.dtsi
diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-pm8226.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-pm8226.dtsi
rename to arch/arm/boot/dts/qcom/qcom-pm8226.dtsi
diff --git a/arch/arm/boot/dts/qcom-pm8841.dtsi b/arch/arm/boot/dts/qcom/qcom-pm8841.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-pm8841.dtsi
rename to arch/arm/boot/dts/qcom/qcom-pm8841.dtsi
diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom/qcom-pm8941.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-pm8941.dtsi
rename to arch/arm/boot/dts/qcom/qcom-pm8941.dtsi
diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom/qcom-pma8084.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-pma8084.dtsi
rename to arch/arm/boot/dts/qcom/qcom-pma8084.dtsi
diff --git a/arch/arm/boot/dts/qcom-pmx55.dtsi b/arch/arm/boot/dts/qcom/qcom-pmx55.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-pmx55.dtsi
rename to arch/arm/boot/dts/qcom/qcom-pmx55.dtsi
diff --git a/arch/arm/boot/dts/qcom-pmx65.dtsi b/arch/arm/boot/dts/qcom/qcom-pmx65.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-pmx65.dtsi
rename to arch/arm/boot/dts/qcom/qcom-pmx65.dtsi
diff --git a/arch/arm/boot/dts/qcom-sdx55-mtp.dts b/arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-sdx55-mtp.dts
rename to arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts
diff --git a/arch/arm/boot/dts/qcom-sdx55-t55.dts b/arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-sdx55-t55.dts
rename to arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts
diff --git a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts b/arch/arm/boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
rename to arch/arm/boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts
diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-sdx55.dtsi
rename to arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-sdx65-mtp.dts
rename to arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-sdx65.dtsi
rename to arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
diff --git a/arch/arm/boot/dts/realtek/Makefile b/arch/arm/boot/dts/realtek/Makefile
new file mode 100644
index 000000000000..c83671b5560f
--- /dev/null
+++ b/arch/arm/boot/dts/realtek/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_REALTEK) += \
+	rtd1195-horseradish.dtb \
+	rtd1195-mele-x1000.dtb
diff --git a/arch/arm/boot/dts/rtd1195-horseradish.dts b/arch/arm/boot/dts/realtek/rtd1195-horseradish.dts
similarity index 100%
rename from arch/arm/boot/dts/rtd1195-horseradish.dts
rename to arch/arm/boot/dts/realtek/rtd1195-horseradish.dts
diff --git a/arch/arm/boot/dts/rtd1195-mele-x1000.dts b/arch/arm/boot/dts/realtek/rtd1195-mele-x1000.dts
similarity index 100%
rename from arch/arm/boot/dts/rtd1195-mele-x1000.dts
rename to arch/arm/boot/dts/realtek/rtd1195-mele-x1000.dts
diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/realtek/rtd1195.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rtd1195.dtsi
rename to arch/arm/boot/dts/realtek/rtd1195.dtsi
diff --git a/arch/arm/boot/dts/renesas/Makefile b/arch/arm/boot/dts/renesas/Makefile
new file mode 100644
index 000000000000..833a02447ecf
--- /dev/null
+++ b/arch/arm/boot/dts/renesas/Makefile
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_RENESAS) += \
+	emev2-kzm9d.dtb \
+	r7s72100-genmai.dtb \
+	r7s72100-gr-peach.dtb \
+	r7s72100-rskrza1.dtb \
+	r7s9210-rza2mevb.dtb \
+	r8a73a4-ape6evm.dtb \
+	r8a7740-armadillo800eva.dtb \
+	r8a7742-iwg21d-q7.dtb \
+	r8a7742-iwg21d-q7-dbcm-ca.dtb \
+	r8a7743-iwg20d-q7.dtb \
+	r8a7743-iwg20d-q7-dbcm-ca.dtb \
+	r8a7743-sk-rzg1m.dtb \
+	r8a7744-iwg20d-q7.dtb \
+	r8a7744-iwg20d-q7-dbcm-ca.dtb \
+	r8a7745-iwg22d-sodimm.dtb \
+	r8a7745-iwg22d-sodimm-dbhd-ca.dtb \
+	r8a7745-sk-rzg1e.dtb \
+	r8a77470-iwg23s-sbc.dtb \
+	r8a7778-bockw.dtb \
+	r8a7779-marzen.dtb \
+	r8a7790-lager.dtb \
+	r8a7790-stout.dtb \
+	r8a7791-koelsch.dtb \
+	r8a7791-porter.dtb \
+	r8a7792-blanche.dtb \
+	r8a7792-wheat.dtb \
+	r8a7793-gose.dtb \
+	r8a7794-alt.dtb \
+	r8a7794-silk.dtb \
+	r9a06g032-rzn1d400-db.dtb \
+	sh73a0-kzm9g.dtb
diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/renesas/emev2-kzm9d.dts
similarity index 100%
rename from arch/arm/boot/dts/emev2-kzm9d.dts
rename to arch/arm/boot/dts/renesas/emev2-kzm9d.dts
diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/renesas/emev2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/emev2.dtsi
rename to arch/arm/boot/dts/renesas/emev2.dtsi
diff --git a/arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi b/arch/arm/boot/dts/renesas/gr-peach-audiocamerashield.dtsi
similarity index 100%
rename from arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi
rename to arch/arm/boot/dts/renesas/gr-peach-audiocamerashield.dtsi
diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/renesas/iwg20d-q7-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/iwg20d-q7-common.dtsi
rename to arch/arm/boot/dts/renesas/iwg20d-q7-common.dtsi
diff --git a/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi b/arch/arm/boot/dts/renesas/iwg20d-q7-dbcm-ca.dtsi
similarity index 100%
rename from arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
rename to arch/arm/boot/dts/renesas/iwg20d-q7-dbcm-ca.dtsi
diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/renesas/r7s72100-genmai.dts
similarity index 100%
rename from arch/arm/boot/dts/r7s72100-genmai.dts
rename to arch/arm/boot/dts/renesas/r7s72100-genmai.dts
diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/renesas/r7s72100-gr-peach.dts
similarity index 100%
rename from arch/arm/boot/dts/r7s72100-gr-peach.dts
rename to arch/arm/boot/dts/renesas/r7s72100-gr-peach.dts
diff --git a/arch/arm/boot/dts/r7s72100-rskrza1.dts b/arch/arm/boot/dts/renesas/r7s72100-rskrza1.dts
similarity index 100%
rename from arch/arm/boot/dts/r7s72100-rskrza1.dts
rename to arch/arm/boot/dts/renesas/r7s72100-rskrza1.dts
diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/renesas/r7s72100.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r7s72100.dtsi
rename to arch/arm/boot/dts/renesas/r7s72100.dtsi
diff --git a/arch/arm/boot/dts/r7s9210-rza2mevb.dts b/arch/arm/boot/dts/renesas/r7s9210-rza2mevb.dts
similarity index 100%
rename from arch/arm/boot/dts/r7s9210-rza2mevb.dts
rename to arch/arm/boot/dts/renesas/r7s9210-rza2mevb.dts
diff --git a/arch/arm/boot/dts/r7s9210.dtsi b/arch/arm/boot/dts/renesas/r7s9210.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r7s9210.dtsi
rename to arch/arm/boot/dts/renesas/r7s9210.dtsi
diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/renesas/r8a73a4-ape6evm.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a73a4-ape6evm.dts
rename to arch/arm/boot/dts/renesas/r8a73a4-ape6evm.dts
diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/renesas/r8a73a4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a73a4.dtsi
rename to arch/arm/boot/dts/renesas/r8a73a4.dtsi
diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7740-armadillo800eva.dts
rename to arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/renesas/r8a7740.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7740.dtsi
rename to arch/arm/boot/dts/renesas/r8a7740.dtsi
diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts b/arch/arm/boot/dts/renesas/r8a7742-iwg21d-q7-dbcm-ca.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts
rename to arch/arm/boot/dts/renesas/r8a7742-iwg21d-q7-dbcm-ca.dts
diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ov5640-single.dtsi b/arch/arm/boot/dts/renesas/r8a7742-iwg21d-q7-dbcm-ov5640-single.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ov5640-single.dtsi
rename to arch/arm/boot/dts/renesas/r8a7742-iwg21d-q7-dbcm-ov5640-single.dtsi
diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ov7725-single.dtsi b/arch/arm/boot/dts/renesas/r8a7742-iwg21d-q7-dbcm-ov7725-single.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ov7725-single.dtsi
rename to arch/arm/boot/dts/renesas/r8a7742-iwg21d-q7-dbcm-ov7725-single.dtsi
diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts b/arch/arm/boot/dts/renesas/r8a7742-iwg21d-q7.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
rename to arch/arm/boot/dts/renesas/r8a7742-iwg21d-q7.dts
diff --git a/arch/arm/boot/dts/r8a7742-iwg21m.dtsi b/arch/arm/boot/dts/renesas/r8a7742-iwg21m.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7742-iwg21m.dtsi
rename to arch/arm/boot/dts/renesas/r8a7742-iwg21m.dtsi
diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/renesas/r8a7742.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7742.dtsi
rename to arch/arm/boot/dts/renesas/r8a7742.dtsi
diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts b/arch/arm/boot/dts/renesas/r8a7743-iwg20d-q7-dbcm-ca.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts
rename to arch/arm/boot/dts/renesas/r8a7743-iwg20d-q7-dbcm-ca.dts
diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/renesas/r8a7743-iwg20d-q7.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
rename to arch/arm/boot/dts/renesas/r8a7743-iwg20d-q7.dts
diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/renesas/r8a7743-iwg20m.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7743-iwg20m.dtsi
rename to arch/arm/boot/dts/renesas/r8a7743-iwg20m.dtsi
diff --git a/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts b/arch/arm/boot/dts/renesas/r8a7743-sk-rzg1m.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
rename to arch/arm/boot/dts/renesas/r8a7743-sk-rzg1m.dts
diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/renesas/r8a7743.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7743.dtsi
rename to arch/arm/boot/dts/renesas/r8a7743.dtsi
diff --git a/arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts b/arch/arm/boot/dts/renesas/r8a7744-iwg20d-q7-dbcm-ca.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts
rename to arch/arm/boot/dts/renesas/r8a7744-iwg20d-q7-dbcm-ca.dts
diff --git a/arch/arm/boot/dts/r8a7744-iwg20d-q7.dts b/arch/arm/boot/dts/renesas/r8a7744-iwg20d-q7.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7744-iwg20d-q7.dts
rename to arch/arm/boot/dts/renesas/r8a7744-iwg20d-q7.dts
diff --git a/arch/arm/boot/dts/r8a7744-iwg20m.dtsi b/arch/arm/boot/dts/renesas/r8a7744-iwg20m.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7744-iwg20m.dtsi
rename to arch/arm/boot/dts/renesas/r8a7744-iwg20m.dtsi
diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/renesas/r8a7744.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7744.dtsi
rename to arch/arm/boot/dts/renesas/r8a7744.dtsi
diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts b/arch/arm/boot/dts/renesas/r8a7745-iwg22d-sodimm-dbhd-ca.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
rename to arch/arm/boot/dts/renesas/r8a7745-iwg22d-sodimm-dbhd-ca.dts
diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/renesas/r8a7745-iwg22d-sodimm.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
rename to arch/arm/boot/dts/renesas/r8a7745-iwg22d-sodimm.dts
diff --git a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi b/arch/arm/boot/dts/renesas/r8a7745-iwg22m.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7745-iwg22m.dtsi
rename to arch/arm/boot/dts/renesas/r8a7745-iwg22m.dtsi
diff --git a/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts b/arch/arm/boot/dts/renesas/r8a7745-sk-rzg1e.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
rename to arch/arm/boot/dts/renesas/r8a7745-sk-rzg1e.dts
diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/renesas/r8a7745.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7745.dtsi
rename to arch/arm/boot/dts/renesas/r8a7745.dtsi
diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/renesas/r8a77470-iwg23s-sbc.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
rename to arch/arm/boot/dts/renesas/r8a77470-iwg23s-sbc.dts
diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/renesas/r8a77470.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a77470.dtsi
rename to arch/arm/boot/dts/renesas/r8a77470.dtsi
diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/renesas/r8a7778-bockw.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7778-bockw.dts
rename to arch/arm/boot/dts/renesas/r8a7778-bockw.dts
diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/renesas/r8a7778.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7778.dtsi
rename to arch/arm/boot/dts/renesas/r8a7778.dtsi
diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/renesas/r8a7779-marzen.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7779-marzen.dts
rename to arch/arm/boot/dts/renesas/r8a7779-marzen.dts
diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/renesas/r8a7779.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7779.dtsi
rename to arch/arm/boot/dts/renesas/r8a7779.dtsi
diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/renesas/r8a7790-lager.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7790-lager.dts
rename to arch/arm/boot/dts/renesas/r8a7790-lager.dts
diff --git a/arch/arm/boot/dts/r8a7790-stout.dts b/arch/arm/boot/dts/renesas/r8a7790-stout.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7790-stout.dts
rename to arch/arm/boot/dts/renesas/r8a7790-stout.dts
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/renesas/r8a7790.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7790.dtsi
rename to arch/arm/boot/dts/renesas/r8a7790.dtsi
diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/renesas/r8a7791-koelsch.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7791-koelsch.dts
rename to arch/arm/boot/dts/renesas/r8a7791-koelsch.dts
diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/renesas/r8a7791-porter.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7791-porter.dts
rename to arch/arm/boot/dts/renesas/r8a7791-porter.dts
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/renesas/r8a7791.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7791.dtsi
rename to arch/arm/boot/dts/renesas/r8a7791.dtsi
diff --git a/arch/arm/boot/dts/r8a7792-blanche.dts b/arch/arm/boot/dts/renesas/r8a7792-blanche.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7792-blanche.dts
rename to arch/arm/boot/dts/renesas/r8a7792-blanche.dts
diff --git a/arch/arm/boot/dts/r8a7792-wheat.dts b/arch/arm/boot/dts/renesas/r8a7792-wheat.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7792-wheat.dts
rename to arch/arm/boot/dts/renesas/r8a7792-wheat.dts
diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/renesas/r8a7792.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7792.dtsi
rename to arch/arm/boot/dts/renesas/r8a7792.dtsi
diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/renesas/r8a7793-gose.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7793-gose.dts
rename to arch/arm/boot/dts/renesas/r8a7793-gose.dts
diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/renesas/r8a7793.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7793.dtsi
rename to arch/arm/boot/dts/renesas/r8a7793.dtsi
diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/renesas/r8a7794-alt.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7794-alt.dts
rename to arch/arm/boot/dts/renesas/r8a7794-alt.dts
diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/renesas/r8a7794-silk.dts
similarity index 100%
rename from arch/arm/boot/dts/r8a7794-silk.dts
rename to arch/arm/boot/dts/renesas/r8a7794-silk.dts
diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/renesas/r8a7794.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a7794.dtsi
rename to arch/arm/boot/dts/renesas/r8a7794.dtsi
diff --git a/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi b/arch/arm/boot/dts/renesas/r8a77xx-aa121td01-panel.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi
rename to arch/arm/boot/dts/renesas/r8a77xx-aa121td01-panel.dtsi
diff --git a/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts b/arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts
similarity index 100%
rename from arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
rename to arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts
diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
similarity index 100%
rename from arch/arm/boot/dts/r9a06g032.dtsi
rename to arch/arm/boot/dts/renesas/r9a06g032.dtsi
diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/renesas/sh73a0-kzm9g.dts
similarity index 100%
rename from arch/arm/boot/dts/sh73a0-kzm9g.dts
rename to arch/arm/boot/dts/renesas/sh73a0-kzm9g.dts
diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/renesas/sh73a0.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sh73a0.dtsi
rename to arch/arm/boot/dts/renesas/sh73a0.dtsi
diff --git a/arch/arm/boot/dts/rockchip/Makefile b/arch/arm/boot/dts/rockchip/Makefile
new file mode 100644
index 000000000000..0f46e18fe275
--- /dev/null
+++ b/arch/arm/boot/dts/rockchip/Makefile
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_ROCKCHIP) += \
+	rv1108-elgin-r1.dtb \
+	rv1108-evb.dtb \
+	rv1126-edgeble-neu2-io.dtb \
+	rk3036-evb.dtb \
+	rk3036-kylin.dtb \
+	rk3066a-bqcurie2.dtb \
+	rk3066a-marsboard.dtb \
+	rk3066a-mk808.dtb \
+	rk3066a-rayeager.dtb \
+	rk3128-evb.dtb \
+	rk3188-bqedison2qc.dtb \
+	rk3188-px3-evb.dtb \
+	rk3188-radxarock.dtb \
+	rk3228-evb.dtb \
+	rk3229-evb.dtb \
+	rk3229-xms6.dtb \
+	rk3288-evb-act8846.dtb \
+	rk3288-evb-rk808.dtb \
+	rk3288-firefly-beta.dtb \
+	rk3288-firefly.dtb \
+	rk3288-firefly-reload.dtb \
+	rk3288-miqi.dtb \
+	rk3288-phycore-rdk.dtb \
+	rk3288-popmetal.dtb \
+	rk3288-r89.dtb \
+	rk3288-rock2-square.dtb \
+	rk3288-rock-pi-n8.dtb \
+	rk3288-tinker.dtb \
+	rk3288-tinker-s.dtb \
+	rk3288-veyron-brain.dtb \
+	rk3288-veyron-fievel.dtb \
+	rk3288-veyron-jaq.dtb \
+	rk3288-veyron-jerry.dtb \
+	rk3288-veyron-mickey.dtb \
+	rk3288-veyron-mighty.dtb \
+	rk3288-veyron-minnie.dtb \
+	rk3288-veyron-pinky.dtb \
+	rk3288-veyron-speedy.dtb \
+	rk3288-veyron-tiger.dtb \
+	rk3288-vyasa.dtb
diff --git a/arch/arm/boot/dts/rk3036-evb.dts b/arch/arm/boot/dts/rockchip/rk3036-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3036-evb.dts
rename to arch/arm/boot/dts/rockchip/rk3036-evb.dts
diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3036-kylin.dts
rename to arch/arm/boot/dts/rockchip/rk3036-kylin.dts
diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3036.dtsi
rename to arch/arm/boot/dts/rockchip/rk3036.dtsi
diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rockchip/rk3066a-bqcurie2.dts
similarity index 99%
rename from arch/arm/boot/dts/rk3066a-bqcurie2.dts
rename to arch/arm/boot/dts/rockchip/rk3066a-bqcurie2.dts
index 962b4d1291db..f924d4d64c3d 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rockchip/rk3066a-bqcurie2.dts
@@ -159,7 +159,7 @@ vcc28_cif: regulator@12 {
 };
 
 /* must be included after &tps gets defined */
-#include "tps65910.dtsi"
+#include "../tps65910.dtsi"
 
 &mmc0 { /* sdmmc */
 	status = "okay";
diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rockchip/rk3066a-marsboard.dts
similarity index 99%
rename from arch/arm/boot/dts/rk3066a-marsboard.dts
rename to arch/arm/boot/dts/rockchip/rk3066a-marsboard.dts
index 8beecd628282..f6e8d49a02ef 100644
--- a/arch/arm/boot/dts/rk3066a-marsboard.dts
+++ b/arch/arm/boot/dts/rockchip/rk3066a-marsboard.dts
@@ -147,7 +147,7 @@ vcc28_cif: regulator@12 {
 };
 
 /* must be included after &tps gets defined */
-#include "tps65910.dtsi"
+#include "../tps65910.dtsi"
 
 &emac {
 	phy = <&phy0>;
diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rockchip/rk3066a-mk808.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3066a-mk808.dts
rename to arch/arm/boot/dts/rockchip/rk3066a-mk808.dts
diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rockchip/rk3066a-rayeager.dts
similarity index 99%
rename from arch/arm/boot/dts/rk3066a-rayeager.dts
rename to arch/arm/boot/dts/rockchip/rk3066a-rayeager.dts
index 3eee42137b6d..29d8e5bf88f5 100644
--- a/arch/arm/boot/dts/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rockchip/rk3066a-rayeager.dts
@@ -296,7 +296,7 @@ vcc28_cif: regulator@12 {
 	};
 };
 
-#include "tps65910.dtsi"
+#include "../tps65910.dtsi"
 
 &i2c2 {
 	status = "okay";
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3066a.dtsi
rename to arch/arm/boot/dts/rockchip/rk3066a.dtsi
diff --git a/arch/arm/boot/dts/rk3128-evb.dts b/arch/arm/boot/dts/rockchip/rk3128-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3128-evb.dts
rename to arch/arm/boot/dts/rockchip/rk3128-evb.dts
diff --git a/arch/arm/boot/dts/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3128.dtsi
rename to arch/arm/boot/dts/rockchip/rk3128.dtsi
diff --git a/arch/arm/boot/dts/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rockchip/rk3188-bqedison2qc.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3188-bqedison2qc.dts
rename to arch/arm/boot/dts/rockchip/rk3188-bqedison2qc.dts
diff --git a/arch/arm/boot/dts/rk3188-px3-evb.dts b/arch/arm/boot/dts/rockchip/rk3188-px3-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3188-px3-evb.dts
rename to arch/arm/boot/dts/rockchip/rk3188-px3-evb.dts
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rockchip/rk3188-radxarock.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3188-radxarock.dts
rename to arch/arm/boot/dts/rockchip/rk3188-radxarock.dts
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rockchip/rk3188.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3188.dtsi
rename to arch/arm/boot/dts/rockchip/rk3188.dtsi
diff --git a/arch/arm/boot/dts/rk3228-evb.dts b/arch/arm/boot/dts/rockchip/rk3228-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3228-evb.dts
rename to arch/arm/boot/dts/rockchip/rk3228-evb.dts
diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rockchip/rk3229-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3229-evb.dts
rename to arch/arm/boot/dts/rockchip/rk3229-evb.dts
diff --git a/arch/arm/boot/dts/rk3229-xms6.dts b/arch/arm/boot/dts/rockchip/rk3229-xms6.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3229-xms6.dts
rename to arch/arm/boot/dts/rockchip/rk3229-xms6.dts
diff --git a/arch/arm/boot/dts/rk3229.dtsi b/arch/arm/boot/dts/rockchip/rk3229.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3229.dtsi
rename to arch/arm/boot/dts/rockchip/rk3229.dtsi
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rockchip/rk322x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk322x.dtsi
rename to arch/arm/boot/dts/rockchip/rk322x.dtsi
diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rockchip/rk3288-evb-act8846.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-evb-act8846.dts
rename to arch/arm/boot/dts/rockchip/rk3288-evb-act8846.dts
diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rockchip/rk3288-evb-rk808.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-evb-rk808.dts
rename to arch/arm/boot/dts/rockchip/rk3288-evb-rk808.dts
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rockchip/rk3288-evb.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3288-evb.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288-evb.dtsi
diff --git a/arch/arm/boot/dts/rk3288-firefly-beta.dts b/arch/arm/boot/dts/rockchip/rk3288-firefly-beta.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-firefly-beta.dts
rename to arch/arm/boot/dts/rockchip/rk3288-firefly-beta.dts
diff --git a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi b/arch/arm/boot/dts/rockchip/rk3288-firefly-reload-core.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288-firefly-reload-core.dtsi
diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rockchip/rk3288-firefly-reload.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-firefly-reload.dts
rename to arch/arm/boot/dts/rockchip/rk3288-firefly-reload.dts
diff --git a/arch/arm/boot/dts/rk3288-firefly.dts b/arch/arm/boot/dts/rockchip/rk3288-firefly.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-firefly.dts
rename to arch/arm/boot/dts/rockchip/rk3288-firefly.dts
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rockchip/rk3288-firefly.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3288-firefly.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288-firefly.dtsi
diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rockchip/rk3288-miqi.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-miqi.dts
rename to arch/arm/boot/dts/rockchip/rk3288-miqi.dts
diff --git a/arch/arm/boot/dts/rk3288-phycore-rdk.dts b/arch/arm/boot/dts/rockchip/rk3288-phycore-rdk.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-phycore-rdk.dts
rename to arch/arm/boot/dts/rockchip/rk3288-phycore-rdk.dts
diff --git a/arch/arm/boot/dts/rk3288-phycore-som.dtsi b/arch/arm/boot/dts/rockchip/rk3288-phycore-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3288-phycore-som.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288-phycore-som.dtsi
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rockchip/rk3288-popmetal.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-popmetal.dts
rename to arch/arm/boot/dts/rockchip/rk3288-popmetal.dts
diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rockchip/rk3288-r89.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-r89.dts
rename to arch/arm/boot/dts/rockchip/rk3288-r89.dts
diff --git a/arch/arm/boot/dts/rk3288-rock-pi-n8.dts b/arch/arm/boot/dts/rockchip/rk3288-rock-pi-n8.dts
similarity index 86%
rename from arch/arm/boot/dts/rk3288-rock-pi-n8.dts
rename to arch/arm/boot/dts/rockchip/rk3288-rock-pi-n8.dts
index b19593021713..673466d264be 100644
--- a/arch/arm/boot/dts/rk3288-rock-pi-n8.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-rock-pi-n8.dts
@@ -7,7 +7,7 @@
 
 /dts-v1/;
 #include "rk3288.dtsi"
-#include <arm/rockchip-radxa-dalang-carrier.dtsi>
+#include <arm/rockchip/rockchip-radxa-dalang-carrier.dtsi>
 #include "rk3288-vmarc-som.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rockchip/rk3288-rock2-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3288-rock2-som.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288-rock2-som.dtsi
diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rockchip/rk3288-rock2-square.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-rock2-square.dts
rename to arch/arm/boot/dts/rockchip/rk3288-rock2-square.dts
diff --git a/arch/arm/boot/dts/rk3288-tinker-s.dts b/arch/arm/boot/dts/rockchip/rk3288-tinker-s.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-tinker-s.dts
rename to arch/arm/boot/dts/rockchip/rk3288-tinker-s.dts
diff --git a/arch/arm/boot/dts/rk3288-tinker.dts b/arch/arm/boot/dts/rockchip/rk3288-tinker.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-tinker.dts
rename to arch/arm/boot/dts/rockchip/rk3288-tinker.dts
diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rockchip/rk3288-tinker.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3288-tinker.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288-tinker.dtsi
diff --git a/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi b/arch/arm/boot/dts/rockchip/rk3288-veyron-analog-audio.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-analog-audio.dtsi
diff --git a/arch/arm/boot/dts/rk3288-veyron-brain.dts b/arch/arm/boot/dts/rockchip/rk3288-veyron-brain.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-veyron-brain.dts
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-brain.dts
diff --git a/arch/arm/boot/dts/rk3288-veyron-broadcom-bluetooth.dtsi b/arch/arm/boot/dts/rockchip/rk3288-veyron-broadcom-bluetooth.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3288-veyron-broadcom-bluetooth.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-broadcom-bluetooth.dtsi
diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rockchip/rk3288-veyron-chromebook.dtsi
similarity index 99%
rename from arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-chromebook.dtsi
index 700bb548d6b2..092316be67f7 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288-veyron-chromebook.dtsi
@@ -181,4 +181,4 @@ usbotg_pwren_h: usbotg-pwren-h {
 	};
 };
 
-#include "cros-ec-keyboard.dtsi"
+#include "../cros-ec-keyboard.dtsi"
diff --git a/arch/arm/boot/dts/rk3288-veyron-edp.dtsi b/arch/arm/boot/dts/rockchip/rk3288-veyron-edp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3288-veyron-edp.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-edp.dtsi
diff --git a/arch/arm/boot/dts/rk3288-veyron-fievel.dts b/arch/arm/boot/dts/rockchip/rk3288-veyron-fievel.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-veyron-fievel.dts
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-fievel.dts
diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rockchip/rk3288-veyron-jaq.dts
similarity index 99%
rename from arch/arm/boot/dts/rk3288-veyron-jaq.dts
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-jaq.dts
index 4a148cf1defc..0d4c50e05558 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-veyron-jaq.dts
@@ -8,7 +8,7 @@
 /dts-v1/;
 
 #include "rk3288-veyron-chromebook.dtsi"
-#include "cros-ec-sbs.dtsi"
+#include "../cros-ec-sbs.dtsi"
 
 / {
 	model = "Google Jaq";
diff --git a/arch/arm/boot/dts/rk3288-veyron-jerry.dts b/arch/arm/boot/dts/rockchip/rk3288-veyron-jerry.dts
similarity index 99%
rename from arch/arm/boot/dts/rk3288-veyron-jerry.dts
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-jerry.dts
index 2c916c50dda5..6894763979f0 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-veyron-jerry.dts
@@ -7,7 +7,7 @@
 
 /dts-v1/;
 #include "rk3288-veyron-chromebook.dtsi"
-#include "cros-ec-sbs.dtsi"
+#include "../cros-ec-sbs.dtsi"
 
 / {
 	model = "Google Jerry";
diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rockchip/rk3288-veyron-mickey.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-veyron-mickey.dts
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-mickey.dts
diff --git a/arch/arm/boot/dts/rk3288-veyron-mighty.dts b/arch/arm/boot/dts/rockchip/rk3288-veyron-mighty.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-veyron-mighty.dts
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-mighty.dts
diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rockchip/rk3288-veyron-minnie.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-veyron-minnie.dts
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-minnie.dts
diff --git a/arch/arm/boot/dts/rk3288-veyron-pinky.dts b/arch/arm/boot/dts/rockchip/rk3288-veyron-pinky.dts
similarity index 98%
rename from arch/arm/boot/dts/rk3288-veyron-pinky.dts
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-pinky.dts
index e2a4e6232eb5..6337238891eb 100644
--- a/arch/arm/boot/dts/rk3288-veyron-pinky.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-veyron-pinky.dts
@@ -7,7 +7,7 @@
 
 /dts-v1/;
 #include "rk3288-veyron-chromebook.dtsi"
-#include "cros-ec-sbs.dtsi"
+#include "../cros-ec-sbs.dtsi"
 
 / {
 	model = "Google Pinky";
diff --git a/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi b/arch/arm/boot/dts/rockchip/rk3288-veyron-sdmmc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-sdmmc.dtsi
diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rockchip/rk3288-veyron-speedy.dts
similarity index 99%
rename from arch/arm/boot/dts/rk3288-veyron-speedy.dts
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-speedy.dts
index 4a3ea934d03e..336cd2be5265 100644
--- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-veyron-speedy.dts
@@ -8,7 +8,7 @@
 /dts-v1/;
 #include "rk3288-veyron-chromebook.dtsi"
 #include "rk3288-veyron-broadcom-bluetooth.dtsi"
-#include "cros-ec-sbs.dtsi"
+#include "../cros-ec-sbs.dtsi"
 
 / {
 	model = "Google Speedy";
diff --git a/arch/arm/boot/dts/rk3288-veyron-tiger.dts b/arch/arm/boot/dts/rockchip/rk3288-veyron-tiger.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-veyron-tiger.dts
rename to arch/arm/boot/dts/rockchip/rk3288-veyron-tiger.dts
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3288-veyron.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi
diff --git a/arch/arm/boot/dts/rk3288-vmarc-som.dtsi b/arch/arm/boot/dts/rockchip/rk3288-vmarc-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3288-vmarc-som.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288-vmarc-som.dtsi
diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rockchip/rk3288-vyasa.dts
similarity index 100%
rename from arch/arm/boot/dts/rk3288-vyasa.dts
rename to arch/arm/boot/dts/rockchip/rk3288-vyasa.dts
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rockchip/rk3288.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3288.dtsi
rename to arch/arm/boot/dts/rockchip/rk3288.dtsi
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rockchip/rk3xxx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rk3xxx.dtsi
rename to arch/arm/boot/dts/rockchip/rk3xxx.dtsi
diff --git a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/boot/dts/rockchip/rockchip-radxa-dalang-carrier.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
rename to arch/arm/boot/dts/rockchip/rockchip-radxa-dalang-carrier.dtsi
diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
similarity index 100%
rename from arch/arm/boot/dts/rv1108-elgin-r1.dts
rename to arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rockchip/rv1108-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/rv1108-evb.dts
rename to arch/arm/boot/dts/rockchip/rv1108-evb.dts
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rockchip/rv1108.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rv1108.dtsi
rename to arch/arm/boot/dts/rockchip/rv1108.dtsi
diff --git a/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts b/arch/arm/boot/dts/rockchip/rv1126-edgeble-neu2-io.dts
similarity index 100%
rename from arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
rename to arch/arm/boot/dts/rockchip/rv1126-edgeble-neu2-io.dts
diff --git a/arch/arm/boot/dts/rv1126-edgeble-neu2.dtsi b/arch/arm/boot/dts/rockchip/rv1126-edgeble-neu2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rv1126-edgeble-neu2.dtsi
rename to arch/arm/boot/dts/rockchip/rv1126-edgeble-neu2.dtsi
diff --git a/arch/arm/boot/dts/rv1126-pinctrl.dtsi b/arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rv1126-pinctrl.dtsi
rename to arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/rv1126.dtsi b/arch/arm/boot/dts/rockchip/rv1126.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rv1126.dtsi
rename to arch/arm/boot/dts/rockchip/rv1126.dtsi
diff --git a/arch/arm/boot/dts/samsung/Makefile b/arch/arm/boot/dts/samsung/Makefile
new file mode 100644
index 000000000000..c8d067abdd59
--- /dev/null
+++ b/arch/arm/boot/dts/samsung/Makefile
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_EXYNOS3) += \
+	exynos3250-artik5-eval.dtb \
+	exynos3250-monk.dtb \
+	exynos3250-rinato.dtb
+dtb-$(CONFIG_ARCH_EXYNOS4) += \
+	exynos4210-i9100.dtb \
+	exynos4210-origen.dtb \
+	exynos4210-smdkv310.dtb \
+	exynos4210-trats.dtb \
+	exynos4210-universal_c210.dtb \
+	exynos4412-i9300.dtb \
+	exynos4412-i9305.dtb \
+	exynos4412-itop-elite.dtb \
+	exynos4412-n710x.dtb \
+	exynos4412-odroidu3.dtb \
+	exynos4412-odroidx.dtb \
+	exynos4412-odroidx2.dtb \
+	exynos4412-origen.dtb \
+	exynos4412-p4note-n8010.dtb \
+	exynos4412-smdk4412.dtb \
+	exynos4412-tiny4412.dtb \
+	exynos4412-trats2.dtb
+dtb-$(CONFIG_ARCH_EXYNOS5) += \
+	exynos5250-arndale.dtb \
+	exynos5250-smdk5250.dtb \
+	exynos5250-snow.dtb \
+	exynos5250-snow-rev5.dtb \
+	exynos5250-spring.dtb \
+	exynos5260-xyref5260.dtb \
+	exynos5410-odroidxu.dtb \
+	exynos5410-smdk5410.dtb \
+	exynos5420-arndale-octa.dtb \
+	exynos5420-peach-pit.dtb \
+	exynos5420-smdk5420.dtb \
+	exynos5420-chagall-wifi.dtb \
+	exynos5420-klimt-wifi.dtb \
+	exynos5422-odroidhc1.dtb \
+	exynos5422-odroidxu3.dtb \
+	exynos5422-odroidxu3-lite.dtb \
+	exynos5422-odroidxu4.dtb \
+	exynos5422-samsung-k3g.dtb \
+	exynos5800-peach-pi.dtb
+dtb-$(CONFIG_ARCH_S3C64XX) += \
+	s3c6410-mini6410.dtb \
+	s3c6410-smdk6410.dtb
+dtb-$(CONFIG_ARCH_S5PV210) += \
+	s5pv210-aquila.dtb \
+	s5pv210-fascinate4g.dtb \
+	s5pv210-galaxys.dtb \
+	s5pv210-goni.dtb \
+	s5pv210-smdkc110.dtb \
+	s5pv210-smdkv210.dtb \
+	s5pv210-torbreck.dtb
diff --git a/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi b/arch/arm/boot/dts/samsung/exynos-mfc-reserved-memory.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
rename to arch/arm/boot/dts/samsung/exynos-mfc-reserved-memory.dtsi
diff --git a/arch/arm/boot/dts/exynos-pinctrl.h b/arch/arm/boot/dts/samsung/exynos-pinctrl.h
similarity index 100%
rename from arch/arm/boot/dts/exynos-pinctrl.h
rename to arch/arm/boot/dts/samsung/exynos-pinctrl.h
diff --git a/arch/arm/boot/dts/exynos-syscon-restart.dtsi b/arch/arm/boot/dts/samsung/exynos-syscon-restart.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos-syscon-restart.dtsi
rename to arch/arm/boot/dts/samsung/exynos-syscon-restart.dtsi
diff --git a/arch/arm/boot/dts/exynos3250-artik5-eval.dts b/arch/arm/boot/dts/samsung/exynos3250-artik5-eval.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos3250-artik5-eval.dts
rename to arch/arm/boot/dts/samsung/exynos3250-artik5-eval.dts
diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/samsung/exynos3250-artik5.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos3250-artik5.dtsi
rename to arch/arm/boot/dts/samsung/exynos3250-artik5.dtsi
diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/samsung/exynos3250-monk.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos3250-monk.dts
rename to arch/arm/boot/dts/samsung/exynos3250-monk.dts
diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/samsung/exynos3250-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos3250-pinctrl.dtsi
rename to arch/arm/boot/dts/samsung/exynos3250-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/samsung/exynos3250-rinato.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos3250-rinato.dts
rename to arch/arm/boot/dts/samsung/exynos3250-rinato.dts
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/samsung/exynos3250.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos3250.dtsi
rename to arch/arm/boot/dts/samsung/exynos3250.dtsi
diff --git a/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi b/arch/arm/boot/dts/samsung/exynos4-cpu-thermal.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
rename to arch/arm/boot/dts/samsung/exynos4-cpu-thermal.dtsi
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/samsung/exynos4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos4.dtsi
rename to arch/arm/boot/dts/samsung/exynos4.dtsi
diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4210-i9100.dts
rename to arch/arm/boot/dts/samsung/exynos4210-i9100.dts
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/samsung/exynos4210-origen.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4210-origen.dts
rename to arch/arm/boot/dts/samsung/exynos4210-origen.dts
diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/samsung/exynos4210-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos4210-pinctrl.dtsi
rename to arch/arm/boot/dts/samsung/exynos4210-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4210-smdkv310.dts
rename to arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/samsung/exynos4210-trats.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4210-trats.dts
rename to arch/arm/boot/dts/samsung/exynos4210-trats.dts
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4210-universal_c210.dts
rename to arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/samsung/exynos4210.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos4210.dtsi
rename to arch/arm/boot/dts/samsung/exynos4210.dtsi
diff --git a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi b/arch/arm/boot/dts/samsung/exynos4412-galaxy-s3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
rename to arch/arm/boot/dts/samsung/exynos4412-galaxy-s3.dtsi
diff --git a/arch/arm/boot/dts/exynos4412-i9300.dts b/arch/arm/boot/dts/samsung/exynos4412-i9300.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-i9300.dts
rename to arch/arm/boot/dts/samsung/exynos4412-i9300.dts
diff --git a/arch/arm/boot/dts/exynos4412-i9305.dts b/arch/arm/boot/dts/samsung/exynos4412-i9305.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-i9305.dts
rename to arch/arm/boot/dts/samsung/exynos4412-i9305.dts
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/samsung/exynos4412-itop-elite.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-itop-elite.dts
rename to arch/arm/boot/dts/samsung/exynos4412-itop-elite.dts
diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/samsung/exynos4412-itop-scp-core.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
rename to arch/arm/boot/dts/samsung/exynos4412-itop-scp-core.dtsi
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-midas.dtsi
rename to arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
diff --git a/arch/arm/boot/dts/exynos4412-n710x.dts b/arch/arm/boot/dts/samsung/exynos4412-n710x.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-n710x.dts
rename to arch/arm/boot/dts/samsung/exynos4412-n710x.dts
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/samsung/exynos4412-odroid-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-odroid-common.dtsi
rename to arch/arm/boot/dts/samsung/exynos4412-odroid-common.dtsi
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/samsung/exynos4412-odroidu3.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-odroidu3.dts
rename to arch/arm/boot/dts/samsung/exynos4412-odroidu3.dts
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/samsung/exynos4412-odroidx.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-odroidx.dts
rename to arch/arm/boot/dts/samsung/exynos4412-odroidx.dts
diff --git a/arch/arm/boot/dts/exynos4412-odroidx2.dts b/arch/arm/boot/dts/samsung/exynos4412-odroidx2.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-odroidx2.dts
rename to arch/arm/boot/dts/samsung/exynos4412-odroidx2.dts
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/samsung/exynos4412-origen.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-origen.dts
rename to arch/arm/boot/dts/samsung/exynos4412-origen.dts
diff --git a/arch/arm/boot/dts/exynos4412-p4note-n8010.dts b/arch/arm/boot/dts/samsung/exynos4412-p4note-n8010.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-p4note-n8010.dts
rename to arch/arm/boot/dts/samsung/exynos4412-p4note-n8010.dts
diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-p4note.dtsi
rename to arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
diff --git a/arch/arm/boot/dts/exynos4412-pinctrl.dtsi b/arch/arm/boot/dts/samsung/exynos4412-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-pinctrl.dtsi
rename to arch/arm/boot/dts/samsung/exynos4412-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi b/arch/arm/boot/dts/samsung/exynos4412-ppmu-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
rename to arch/arm/boot/dts/samsung/exynos4412-ppmu-common.dtsi
diff --git a/arch/arm/boot/dts/exynos4412-prime.dtsi b/arch/arm/boot/dts/samsung/exynos4412-prime.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-prime.dtsi
rename to arch/arm/boot/dts/samsung/exynos4412-prime.dtsi
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-smdk4412.dts
rename to arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/samsung/exynos4412-tiny4412.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-tiny4412.dts
rename to arch/arm/boot/dts/samsung/exynos4412-tiny4412.dts
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/samsung/exynos4412-trats2.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos4412-trats2.dts
rename to arch/arm/boot/dts/samsung/exynos4412-trats2.dts
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/samsung/exynos4412.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos4412.dtsi
rename to arch/arm/boot/dts/samsung/exynos4412.dtsi
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/samsung/exynos5.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5.dtsi
rename to arch/arm/boot/dts/samsung/exynos5.dtsi
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/samsung/exynos5250-arndale.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5250-arndale.dts
rename to arch/arm/boot/dts/samsung/exynos5250-arndale.dts
diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/samsung/exynos5250-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5250-pinctrl.dtsi
rename to arch/arm/boot/dts/samsung/exynos5250-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5250-smdk5250.dts
rename to arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts
diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/samsung/exynos5250-snow-common.dtsi
similarity index 99%
rename from arch/arm/boot/dts/exynos5250-snow-common.dtsi
rename to arch/arm/boot/dts/samsung/exynos5250-snow-common.dtsi
index 59b2cc35c37b..c82e2762e07c 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos5250-snow-common.dtsi
@@ -715,4 +715,4 @@ &usbdrd_phy {
 	vbus-supply = <&usb3_vbus_reg>;
 };
 
-#include "cros-ec-keyboard.dtsi"
+#include "../cros-ec-keyboard.dtsi"
diff --git a/arch/arm/boot/dts/exynos5250-snow-rev5.dts b/arch/arm/boot/dts/samsung/exynos5250-snow-rev5.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5250-snow-rev5.dts
rename to arch/arm/boot/dts/samsung/exynos5250-snow-rev5.dts
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/samsung/exynos5250-snow.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5250-snow.dts
rename to arch/arm/boot/dts/samsung/exynos5250-snow.dts
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/samsung/exynos5250-spring.dts
similarity index 99%
rename from arch/arm/boot/dts/exynos5250-spring.dts
rename to arch/arm/boot/dts/samsung/exynos5250-spring.dts
index c12bb17631b7..d126fccdcaf3 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/samsung/exynos5250-spring.dts
@@ -564,4 +564,4 @@ &usbdrd {
 	vdd33-supply = <&ldo12_reg>;
 };
 
-#include "cros-ec-keyboard.dtsi"
+#include "../cros-ec-keyboard.dtsi"
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/samsung/exynos5250.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5250.dtsi
rename to arch/arm/boot/dts/samsung/exynos5250.dtsi
diff --git a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi b/arch/arm/boot/dts/samsung/exynos5260-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5260-pinctrl.dtsi
rename to arch/arm/boot/dts/samsung/exynos5260-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/samsung/exynos5260-xyref5260.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5260-xyref5260.dts
rename to arch/arm/boot/dts/samsung/exynos5260-xyref5260.dts
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/samsung/exynos5260.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5260.dtsi
rename to arch/arm/boot/dts/samsung/exynos5260.dtsi
diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/samsung/exynos5410-odroidxu.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5410-odroidxu.dts
rename to arch/arm/boot/dts/samsung/exynos5410-odroidxu.dts
diff --git a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi b/arch/arm/boot/dts/samsung/exynos5410-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5410-pinctrl.dtsi
rename to arch/arm/boot/dts/samsung/exynos5410-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/samsung/exynos5410-smdk5410.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5410-smdk5410.dts
rename to arch/arm/boot/dts/samsung/exynos5410-smdk5410.dts
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/samsung/exynos5410.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5410.dtsi
rename to arch/arm/boot/dts/samsung/exynos5410.dtsi
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/samsung/exynos5420-arndale-octa.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5420-arndale-octa.dts
rename to arch/arm/boot/dts/samsung/exynos5420-arndale-octa.dts
diff --git a/arch/arm/boot/dts/exynos5420-chagall-wifi.dts b/arch/arm/boot/dts/samsung/exynos5420-chagall-wifi.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5420-chagall-wifi.dts
rename to arch/arm/boot/dts/samsung/exynos5420-chagall-wifi.dts
diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/samsung/exynos5420-cpus.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5420-cpus.dtsi
rename to arch/arm/boot/dts/samsung/exynos5420-cpus.dtsi
diff --git a/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi b/arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
rename to arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi
diff --git a/arch/arm/boot/dts/exynos5420-klimt-wifi.dts b/arch/arm/boot/dts/samsung/exynos5420-klimt-wifi.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5420-klimt-wifi.dts
rename to arch/arm/boot/dts/samsung/exynos5420-klimt-wifi.dts
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/samsung/exynos5420-peach-pit.dts
similarity index 99%
rename from arch/arm/boot/dts/exynos5420-peach-pit.dts
rename to arch/arm/boot/dts/samsung/exynos5420-peach-pit.dts
index 7a48f2b32819..4e757b6e28e1 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/samsung/exynos5420-peach-pit.dts
@@ -1122,5 +1122,5 @@ &watchdog {
 	timeout-sec = <32>;
 };
 
-#include "cros-ec-keyboard.dtsi"
-#include "cros-adc-thermistors.dtsi"
+#include "../cros-ec-keyboard.dtsi"
+#include "../cros-adc-thermistors.dtsi"
diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/samsung/exynos5420-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5420-pinctrl.dtsi
rename to arch/arm/boot/dts/samsung/exynos5420-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/samsung/exynos5420-smdk5420.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5420-smdk5420.dts
rename to arch/arm/boot/dts/samsung/exynos5420-smdk5420.dts
diff --git a/arch/arm/boot/dts/exynos5420-trip-points.dtsi b/arch/arm/boot/dts/samsung/exynos5420-trip-points.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5420-trip-points.dtsi
rename to arch/arm/boot/dts/samsung/exynos5420-trip-points.dtsi
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/samsung/exynos5420.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5420.dtsi
rename to arch/arm/boot/dts/samsung/exynos5420.dtsi
diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/samsung/exynos5422-cpus.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5422-cpus.dtsi
rename to arch/arm/boot/dts/samsung/exynos5422-cpus.dtsi
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/samsung/exynos5422-odroid-core.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5422-odroid-core.dtsi
rename to arch/arm/boot/dts/samsung/exynos5422-odroid-core.dtsi
diff --git a/arch/arm/boot/dts/exynos5422-odroidhc1.dts b/arch/arm/boot/dts/samsung/exynos5422-odroidhc1.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5422-odroidhc1.dts
rename to arch/arm/boot/dts/samsung/exynos5422-odroidhc1.dts
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-audio.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
rename to arch/arm/boot/dts/samsung/exynos5422-odroidxu3-audio.dtsi
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
rename to arch/arm/boot/dts/samsung/exynos5422-odroidxu3-common.dtsi
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts b/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-lite.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
rename to arch/arm/boot/dts/samsung/exynos5422-odroidxu3-lite.dts
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/samsung/exynos5422-odroidxu3.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5422-odroidxu3.dts
rename to arch/arm/boot/dts/samsung/exynos5422-odroidxu3.dts
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/samsung/exynos5422-odroidxu4.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5422-odroidxu4.dts
rename to arch/arm/boot/dts/samsung/exynos5422-odroidxu4.dts
diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/samsung/exynos5422-samsung-k3g.dts
similarity index 100%
rename from arch/arm/boot/dts/exynos5422-samsung-k3g.dts
rename to arch/arm/boot/dts/samsung/exynos5422-samsung-k3g.dts
diff --git a/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi b/arch/arm/boot/dts/samsung/exynos54xx-odroidxu-leds.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
rename to arch/arm/boot/dts/samsung/exynos54xx-odroidxu-leds.dtsi
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/samsung/exynos54xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos54xx.dtsi
rename to arch/arm/boot/dts/samsung/exynos54xx.dtsi
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/samsung/exynos5800-peach-pi.dts
similarity index 99%
rename from arch/arm/boot/dts/exynos5800-peach-pi.dts
rename to arch/arm/boot/dts/samsung/exynos5800-peach-pi.dts
index 1f544f12da6c..f91bc4ae008e 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/samsung/exynos5800-peach-pi.dts
@@ -1104,5 +1104,5 @@ &watchdog {
 	timeout-sec = <32>;
 };
 
-#include "cros-ec-keyboard.dtsi"
-#include "cros-adc-thermistors.dtsi"
+#include "../cros-ec-keyboard.dtsi"
+#include "../cros-adc-thermistors.dtsi"
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/samsung/exynos5800.dtsi
similarity index 100%
rename from arch/arm/boot/dts/exynos5800.dtsi
rename to arch/arm/boot/dts/samsung/exynos5800.dtsi
diff --git a/arch/arm/boot/dts/s3c6400.dtsi b/arch/arm/boot/dts/samsung/s3c6400.dtsi
similarity index 100%
rename from arch/arm/boot/dts/s3c6400.dtsi
rename to arch/arm/boot/dts/samsung/s3c6400.dtsi
diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/samsung/s3c6410-mini6410.dts
similarity index 100%
rename from arch/arm/boot/dts/s3c6410-mini6410.dts
rename to arch/arm/boot/dts/samsung/s3c6410-mini6410.dts
diff --git a/arch/arm/boot/dts/s3c6410-smdk6410.dts b/arch/arm/boot/dts/samsung/s3c6410-smdk6410.dts
similarity index 100%
rename from arch/arm/boot/dts/s3c6410-smdk6410.dts
rename to arch/arm/boot/dts/samsung/s3c6410-smdk6410.dts
diff --git a/arch/arm/boot/dts/s3c6410.dtsi b/arch/arm/boot/dts/samsung/s3c6410.dtsi
similarity index 100%
rename from arch/arm/boot/dts/s3c6410.dtsi
rename to arch/arm/boot/dts/samsung/s3c6410.dtsi
diff --git a/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi b/arch/arm/boot/dts/samsung/s3c64xx-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
rename to arch/arm/boot/dts/samsung/s3c64xx-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/s3c64xx-pinctrl.h b/arch/arm/boot/dts/samsung/s3c64xx-pinctrl.h
similarity index 100%
rename from arch/arm/boot/dts/s3c64xx-pinctrl.h
rename to arch/arm/boot/dts/samsung/s3c64xx-pinctrl.h
diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/samsung/s3c64xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/s3c64xx.dtsi
rename to arch/arm/boot/dts/samsung/s3c64xx.dtsi
diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/samsung/s5pv210-aquila.dts
similarity index 100%
rename from arch/arm/boot/dts/s5pv210-aquila.dts
rename to arch/arm/boot/dts/samsung/s5pv210-aquila.dts
diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/samsung/s5pv210-aries.dtsi
similarity index 100%
rename from arch/arm/boot/dts/s5pv210-aries.dtsi
rename to arch/arm/boot/dts/samsung/s5pv210-aries.dtsi
diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/samsung/s5pv210-fascinate4g.dts
similarity index 100%
rename from arch/arm/boot/dts/s5pv210-fascinate4g.dts
rename to arch/arm/boot/dts/samsung/s5pv210-fascinate4g.dts
diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/samsung/s5pv210-galaxys.dts
similarity index 100%
rename from arch/arm/boot/dts/s5pv210-galaxys.dts
rename to arch/arm/boot/dts/samsung/s5pv210-galaxys.dts
diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/samsung/s5pv210-goni.dts
similarity index 100%
rename from arch/arm/boot/dts/s5pv210-goni.dts
rename to arch/arm/boot/dts/samsung/s5pv210-goni.dts
diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/samsung/s5pv210-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/s5pv210-pinctrl.dtsi
rename to arch/arm/boot/dts/samsung/s5pv210-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.h b/arch/arm/boot/dts/samsung/s5pv210-pinctrl.h
similarity index 100%
rename from arch/arm/boot/dts/s5pv210-pinctrl.h
rename to arch/arm/boot/dts/samsung/s5pv210-pinctrl.h
diff --git a/arch/arm/boot/dts/s5pv210-smdkc110.dts b/arch/arm/boot/dts/samsung/s5pv210-smdkc110.dts
similarity index 100%
rename from arch/arm/boot/dts/s5pv210-smdkc110.dts
rename to arch/arm/boot/dts/samsung/s5pv210-smdkc110.dts
diff --git a/arch/arm/boot/dts/s5pv210-smdkv210.dts b/arch/arm/boot/dts/samsung/s5pv210-smdkv210.dts
similarity index 100%
rename from arch/arm/boot/dts/s5pv210-smdkv210.dts
rename to arch/arm/boot/dts/samsung/s5pv210-smdkv210.dts
diff --git a/arch/arm/boot/dts/s5pv210-torbreck.dts b/arch/arm/boot/dts/samsung/s5pv210-torbreck.dts
similarity index 100%
rename from arch/arm/boot/dts/s5pv210-torbreck.dts
rename to arch/arm/boot/dts/samsung/s5pv210-torbreck.dts
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/samsung/s5pv210.dtsi
similarity index 100%
rename from arch/arm/boot/dts/s5pv210.dtsi
rename to arch/arm/boot/dts/samsung/s5pv210.dtsi
diff --git a/arch/arm/boot/dts/sigmastar/Makefile b/arch/arm/boot/dts/sigmastar/Makefile
new file mode 100644
index 000000000000..b07eaf5d8add
--- /dev/null
+++ b/arch/arm/boot/dts/sigmastar/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_MSTARV7) += \
+	mstar-infinity-msc313-breadbee_crust.dtb \
+	mstar-infinity2m-ssd202d-100ask-dongshanpione.dtb \
+	mstar-infinity2m-ssd202d-miyoo-mini.dtb \
+	mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dtb \
+	mstar-infinity2m-ssd202d-ssd201htv2.dtb \
+	mstar-infinity2m-ssd202d-unitv2.dtb \
+	mstar-infinity3-msc313e-breadbee.dtb \
+	mstar-mercury5-ssc8336n-midrived08.dtb
diff --git a/arch/arm/boot/dts/mstar-infinity-breadbee-common.dtsi b/arch/arm/boot/dts/sigmastar/mstar-infinity-breadbee-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity-breadbee-common.dtsi
rename to arch/arm/boot/dts/sigmastar/mstar-infinity-breadbee-common.dtsi
diff --git a/arch/arm/boot/dts/mstar-infinity-msc313-breadbee_crust.dts b/arch/arm/boot/dts/sigmastar/mstar-infinity-msc313-breadbee_crust.dts
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity-msc313-breadbee_crust.dts
rename to arch/arm/boot/dts/sigmastar/mstar-infinity-msc313-breadbee_crust.dts
diff --git a/arch/arm/boot/dts/mstar-infinity-msc313.dtsi b/arch/arm/boot/dts/sigmastar/mstar-infinity-msc313.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity-msc313.dtsi
rename to arch/arm/boot/dts/sigmastar/mstar-infinity-msc313.dtsi
diff --git a/arch/arm/boot/dts/mstar-infinity.dtsi b/arch/arm/boot/dts/sigmastar/mstar-infinity.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity.dtsi
rename to arch/arm/boot/dts/sigmastar/mstar-infinity.dtsi
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi b/arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd201-som2d01.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi
rename to arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd201-som2d01.dtsi
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-100ask-dongshanpione.dts b/arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d-100ask-dongshanpione.dts
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity2m-ssd202d-100ask-dongshanpione.dts
rename to arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d-100ask-dongshanpione.dts
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-miyoo-mini.dts b/arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d-miyoo-mini.dts
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity2m-ssd202d-miyoo-mini.dts
rename to arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d-miyoo-mini.dts
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-ssd201htv2.dts b/arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d-ssd201htv2.dts
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity2m-ssd202d-ssd201htv2.dts
rename to arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d-ssd201htv2.dts
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts b/arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d-unitv2.dts
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
rename to arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d-unitv2.dts
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts b/arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
rename to arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi b/arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi
rename to arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d.dtsi b/arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity2m-ssd202d.dtsi
rename to arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd202d.dtsi
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi b/arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd20xd.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi
rename to arch/arm/boot/dts/sigmastar/mstar-infinity2m-ssd20xd.dtsi
diff --git a/arch/arm/boot/dts/mstar-infinity2m.dtsi b/arch/arm/boot/dts/sigmastar/mstar-infinity2m.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity2m.dtsi
rename to arch/arm/boot/dts/sigmastar/mstar-infinity2m.dtsi
diff --git a/arch/arm/boot/dts/mstar-infinity3-msc313e-breadbee.dts b/arch/arm/boot/dts/sigmastar/mstar-infinity3-msc313e-breadbee.dts
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity3-msc313e-breadbee.dts
rename to arch/arm/boot/dts/sigmastar/mstar-infinity3-msc313e-breadbee.dts
diff --git a/arch/arm/boot/dts/mstar-infinity3-msc313e.dtsi b/arch/arm/boot/dts/sigmastar/mstar-infinity3-msc313e.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity3-msc313e.dtsi
rename to arch/arm/boot/dts/sigmastar/mstar-infinity3-msc313e.dtsi
diff --git a/arch/arm/boot/dts/mstar-infinity3.dtsi b/arch/arm/boot/dts/sigmastar/mstar-infinity3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mstar-infinity3.dtsi
rename to arch/arm/boot/dts/sigmastar/mstar-infinity3.dtsi
diff --git a/arch/arm/boot/dts/mstar-mercury5-ssc8336n-midrived08.dts b/arch/arm/boot/dts/sigmastar/mstar-mercury5-ssc8336n-midrived08.dts
similarity index 100%
rename from arch/arm/boot/dts/mstar-mercury5-ssc8336n-midrived08.dts
rename to arch/arm/boot/dts/sigmastar/mstar-mercury5-ssc8336n-midrived08.dts
diff --git a/arch/arm/boot/dts/mstar-mercury5-ssc8336n.dtsi b/arch/arm/boot/dts/sigmastar/mstar-mercury5-ssc8336n.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mstar-mercury5-ssc8336n.dtsi
rename to arch/arm/boot/dts/sigmastar/mstar-mercury5-ssc8336n.dtsi
diff --git a/arch/arm/boot/dts/mstar-mercury5.dtsi b/arch/arm/boot/dts/sigmastar/mstar-mercury5.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mstar-mercury5.dtsi
rename to arch/arm/boot/dts/sigmastar/mstar-mercury5.dtsi
diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/sigmastar/mstar-v7.dtsi
similarity index 100%
rename from arch/arm/boot/dts/mstar-v7.dtsi
rename to arch/arm/boot/dts/sigmastar/mstar-v7.dtsi
diff --git a/arch/arm/boot/dts/socionext/Makefile b/arch/arm/boot/dts/socionext/Makefile
new file mode 100644
index 000000000000..dab4275f6bd6
--- /dev/null
+++ b/arch/arm/boot/dts/socionext/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
+dtb-$(CONFIG_ARCH_UNIPHIER) += \
+	uniphier-ld4-ref.dtb \
+	uniphier-ld6b-ref.dtb \
+	uniphier-pro4-ace.dtb \
+	uniphier-pro4-ref.dtb \
+	uniphier-pro4-sanji.dtb \
+	uniphier-pro5-epcore.dtb \
+	uniphier-pro5-proex.dtb \
+	uniphier-pxs2-gentil.dtb \
+	uniphier-pxs2-vodka.dtb \
+	uniphier-sld8-ref.dtb
diff --git a/arch/arm/boot/dts/milbeaut-m10v-evb.dts b/arch/arm/boot/dts/socionext/milbeaut-m10v-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/milbeaut-m10v-evb.dts
rename to arch/arm/boot/dts/socionext/milbeaut-m10v-evb.dts
diff --git a/arch/arm/boot/dts/milbeaut-m10v.dtsi b/arch/arm/boot/dts/socionext/milbeaut-m10v.dtsi
similarity index 100%
rename from arch/arm/boot/dts/milbeaut-m10v.dtsi
rename to arch/arm/boot/dts/socionext/milbeaut-m10v.dtsi
diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/socionext/uniphier-ld4-ref.dts
similarity index 100%
rename from arch/arm/boot/dts/uniphier-ld4-ref.dts
rename to arch/arm/boot/dts/socionext/uniphier-ld4-ref.dts
diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/socionext/uniphier-ld4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/uniphier-ld4.dtsi
rename to arch/arm/boot/dts/socionext/uniphier-ld4.dtsi
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/socionext/uniphier-ld6b-ref.dts
similarity index 100%
rename from arch/arm/boot/dts/uniphier-ld6b-ref.dts
rename to arch/arm/boot/dts/socionext/uniphier-ld6b-ref.dts
diff --git a/arch/arm/boot/dts/uniphier-ld6b.dtsi b/arch/arm/boot/dts/socionext/uniphier-ld6b.dtsi
similarity index 100%
rename from arch/arm/boot/dts/uniphier-ld6b.dtsi
rename to arch/arm/boot/dts/socionext/uniphier-ld6b.dtsi
diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/socionext/uniphier-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/uniphier-pinctrl.dtsi
rename to arch/arm/boot/dts/socionext/uniphier-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/uniphier-pro4-ace.dts b/arch/arm/boot/dts/socionext/uniphier-pro4-ace.dts
similarity index 100%
rename from arch/arm/boot/dts/uniphier-pro4-ace.dts
rename to arch/arm/boot/dts/socionext/uniphier-pro4-ace.dts
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/socionext/uniphier-pro4-ref.dts
similarity index 100%
rename from arch/arm/boot/dts/uniphier-pro4-ref.dts
rename to arch/arm/boot/dts/socionext/uniphier-pro4-ref.dts
diff --git a/arch/arm/boot/dts/uniphier-pro4-sanji.dts b/arch/arm/boot/dts/socionext/uniphier-pro4-sanji.dts
similarity index 100%
rename from arch/arm/boot/dts/uniphier-pro4-sanji.dts
rename to arch/arm/boot/dts/socionext/uniphier-pro4-sanji.dts
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/socionext/uniphier-pro4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/uniphier-pro4.dtsi
rename to arch/arm/boot/dts/socionext/uniphier-pro4.dtsi
diff --git a/arch/arm/boot/dts/uniphier-pro5-epcore.dts b/arch/arm/boot/dts/socionext/uniphier-pro5-epcore.dts
similarity index 100%
rename from arch/arm/boot/dts/uniphier-pro5-epcore.dts
rename to arch/arm/boot/dts/socionext/uniphier-pro5-epcore.dts
diff --git a/arch/arm/boot/dts/uniphier-pro5-proex.dts b/arch/arm/boot/dts/socionext/uniphier-pro5-proex.dts
similarity index 100%
rename from arch/arm/boot/dts/uniphier-pro5-proex.dts
rename to arch/arm/boot/dts/socionext/uniphier-pro5-proex.dts
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/socionext/uniphier-pro5.dtsi
similarity index 100%
rename from arch/arm/boot/dts/uniphier-pro5.dtsi
rename to arch/arm/boot/dts/socionext/uniphier-pro5.dtsi
diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/socionext/uniphier-pxs2-gentil.dts
similarity index 100%
rename from arch/arm/boot/dts/uniphier-pxs2-gentil.dts
rename to arch/arm/boot/dts/socionext/uniphier-pxs2-gentil.dts
diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/socionext/uniphier-pxs2-vodka.dts
similarity index 100%
rename from arch/arm/boot/dts/uniphier-pxs2-vodka.dts
rename to arch/arm/boot/dts/socionext/uniphier-pxs2-vodka.dts
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/socionext/uniphier-pxs2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/uniphier-pxs2.dtsi
rename to arch/arm/boot/dts/socionext/uniphier-pxs2.dtsi
diff --git a/arch/arm/boot/dts/uniphier-ref-daughter.dtsi b/arch/arm/boot/dts/socionext/uniphier-ref-daughter.dtsi
similarity index 100%
rename from arch/arm/boot/dts/uniphier-ref-daughter.dtsi
rename to arch/arm/boot/dts/socionext/uniphier-ref-daughter.dtsi
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/socionext/uniphier-sld8-ref.dts
similarity index 100%
rename from arch/arm/boot/dts/uniphier-sld8-ref.dts
rename to arch/arm/boot/dts/socionext/uniphier-sld8-ref.dts
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/socionext/uniphier-sld8.dtsi
similarity index 100%
rename from arch/arm/boot/dts/uniphier-sld8.dtsi
rename to arch/arm/boot/dts/socionext/uniphier-sld8.dtsi
diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/boot/dts/socionext/uniphier-support-card.dtsi
similarity index 100%
rename from arch/arm/boot/dts/uniphier-support-card.dtsi
rename to arch/arm/boot/dts/socionext/uniphier-support-card.dtsi
diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
new file mode 100644
index 000000000000..2ca43dbcfa8f
--- /dev/null
+++ b/arch/arm/boot/dts/st/Makefile
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_NOMADIK) += \
+	ste-nomadik-s8815.dtb \
+	ste-nomadik-nhk15.dtb
+dtb-$(CONFIG_ARCH_SPEAR13XX) += \
+	spear1310-evb.dtb \
+	spear1340-evb.dtb
+dtb-$(CONFIG_ARCH_SPEAR3XX) += \
+	spear300-evb.dtb \
+	spear310-evb.dtb \
+	spear320-evb.dtb \
+	spear320-hmi.dtb
+dtb-$(CONFIG_ARCH_SPEAR6XX) += \
+	spear600-evb.dtb
+dtb-$(CONFIG_ARCH_STI) += \
+	stih407-b2120.dtb \
+	stih410-b2120.dtb \
+	stih410-b2260.dtb \
+	stih418-b2199.dtb \
+	stih418-b2264.dtb
+dtb-$(CONFIG_ARCH_STM32) += \
+	stm32f429-disco.dtb \
+	stm32f469-disco.dtb \
+	stm32f746-disco.dtb \
+	stm32f769-disco.dtb \
+	stm32429i-eval.dtb \
+	stm32746g-eval.dtb \
+	stm32h743i-eval.dtb \
+	stm32h743i-disco.dtb \
+	stm32h750i-art-pi.dtb \
+	stm32mp135f-dk.dtb \
+	stm32mp151a-prtt1a.dtb \
+	stm32mp151a-prtt1c.dtb \
+	stm32mp151a-prtt1s.dtb \
+	stm32mp151a-dhcor-testbench.dtb \
+	stm32mp153c-dhcom-drc02.dtb \
+	stm32mp153c-dhcor-drc-compact.dtb \
+	stm32mp157a-avenger96.dtb \
+	stm32mp157a-dhcor-avenger96.dtb \
+	stm32mp157a-dk1.dtb \
+	stm32mp157a-dk1-scmi.dtb \
+	stm32mp157a-iot-box.dtb \
+	stm32mp157a-microgea-stm32mp1-microdev2.0.dtb \
+	stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dtb \
+	stm32mp157a-icore-stm32mp1-ctouch2.dtb \
+	stm32mp157a-icore-stm32mp1-ctouch2-of10.dtb \
+	stm32mp157a-icore-stm32mp1-edimm2.2.dtb \
+	stm32mp157a-stinger96.dtb \
+	stm32mp157c-dhcom-pdk2.dtb \
+	stm32mp157c-dhcom-picoitx.dtb \
+	stm32mp157c-dk2.dtb \
+	stm32mp157c-dk2-scmi.dtb \
+	stm32mp157c-ed1.dtb \
+	stm32mp157c-ed1-scmi.dtb \
+	stm32mp157c-emsbc-argon.dtb \
+	stm32mp157c-ev1.dtb \
+	stm32mp157c-ev1-scmi.dtb \
+	stm32mp157c-lxa-mc1.dtb \
+	stm32mp157c-odyssey.dtb
+dtb-$(CONFIG_ARCH_U8500) += \
+	ste-snowball.dtb \
+	ste-hrefprev60-stuib.dtb \
+	ste-hrefprev60-tvk.dtb \
+	ste-hrefv60plus-stuib.dtb \
+	ste-hrefv60plus-tvk.dtb \
+	ste-href520-tvk.dtb \
+	ste-ux500-samsung-golden.dtb \
+	ste-ux500-samsung-janice.dtb \
+	ste-ux500-samsung-gavini.dtb \
+	ste-ux500-samsung-codina.dtb \
+	ste-ux500-samsung-codina-tmo.dtb \
+	ste-ux500-samsung-skomer.dtb \
+	ste-ux500-samsung-kyle.dtb
diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/st/spear1310-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/spear1310-evb.dts
rename to arch/arm/boot/dts/st/spear1310-evb.dts
diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/st/spear1310.dtsi
similarity index 100%
rename from arch/arm/boot/dts/spear1310.dtsi
rename to arch/arm/boot/dts/st/spear1310.dtsi
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/st/spear1340-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/spear1340-evb.dts
rename to arch/arm/boot/dts/st/spear1340-evb.dts
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/st/spear1340.dtsi
similarity index 100%
rename from arch/arm/boot/dts/spear1340.dtsi
rename to arch/arm/boot/dts/st/spear1340.dtsi
diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/st/spear13xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/spear13xx.dtsi
rename to arch/arm/boot/dts/st/spear13xx.dtsi
diff --git a/arch/arm/boot/dts/spear300-evb.dts b/arch/arm/boot/dts/st/spear300-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/spear300-evb.dts
rename to arch/arm/boot/dts/st/spear300-evb.dts
diff --git a/arch/arm/boot/dts/spear300.dtsi b/arch/arm/boot/dts/st/spear300.dtsi
similarity index 100%
rename from arch/arm/boot/dts/spear300.dtsi
rename to arch/arm/boot/dts/st/spear300.dtsi
diff --git a/arch/arm/boot/dts/spear310-evb.dts b/arch/arm/boot/dts/st/spear310-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/spear310-evb.dts
rename to arch/arm/boot/dts/st/spear310-evb.dts
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/st/spear310.dtsi
similarity index 100%
rename from arch/arm/boot/dts/spear310.dtsi
rename to arch/arm/boot/dts/st/spear310.dtsi
diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/st/spear320-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/spear320-evb.dts
rename to arch/arm/boot/dts/st/spear320-evb.dts
diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/st/spear320-hmi.dts
similarity index 100%
rename from arch/arm/boot/dts/spear320-hmi.dts
rename to arch/arm/boot/dts/st/spear320-hmi.dts
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/st/spear320.dtsi
similarity index 100%
rename from arch/arm/boot/dts/spear320.dtsi
rename to arch/arm/boot/dts/st/spear320.dtsi
diff --git a/arch/arm/boot/dts/spear320s.dtsi b/arch/arm/boot/dts/st/spear320s.dtsi
similarity index 100%
rename from arch/arm/boot/dts/spear320s.dtsi
rename to arch/arm/boot/dts/st/spear320s.dtsi
diff --git a/arch/arm/boot/dts/spear3xx.dtsi b/arch/arm/boot/dts/st/spear3xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/spear3xx.dtsi
rename to arch/arm/boot/dts/st/spear3xx.dtsi
diff --git a/arch/arm/boot/dts/spear600-evb.dts b/arch/arm/boot/dts/st/spear600-evb.dts
similarity index 100%
rename from arch/arm/boot/dts/spear600-evb.dts
rename to arch/arm/boot/dts/st/spear600-evb.dts
diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/st/spear600.dtsi
similarity index 100%
rename from arch/arm/boot/dts/spear600.dtsi
rename to arch/arm/boot/dts/st/spear600.dtsi
diff --git a/arch/arm/boot/dts/st-pincfg.h b/arch/arm/boot/dts/st/st-pincfg.h
similarity index 100%
rename from arch/arm/boot/dts/st-pincfg.h
rename to arch/arm/boot/dts/st/st-pincfg.h
diff --git a/arch/arm/boot/dts/ste-ab8500.dtsi b/arch/arm/boot/dts/st/ste-ab8500.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-ab8500.dtsi
rename to arch/arm/boot/dts/st/ste-ab8500.dtsi
diff --git a/arch/arm/boot/dts/ste-ab8505.dtsi b/arch/arm/boot/dts/st/ste-ab8505.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-ab8505.dtsi
rename to arch/arm/boot/dts/st/ste-ab8505.dtsi
diff --git a/arch/arm/boot/dts/ste-db8500.dtsi b/arch/arm/boot/dts/st/ste-db8500.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-db8500.dtsi
rename to arch/arm/boot/dts/st/ste-db8500.dtsi
diff --git a/arch/arm/boot/dts/ste-db8520.dtsi b/arch/arm/boot/dts/st/ste-db8520.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-db8520.dtsi
rename to arch/arm/boot/dts/st/ste-db8520.dtsi
diff --git a/arch/arm/boot/dts/ste-db9500.dtsi b/arch/arm/boot/dts/st/ste-db9500.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-db9500.dtsi
rename to arch/arm/boot/dts/st/ste-db9500.dtsi
diff --git a/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi b/arch/arm/boot/dts/st/ste-dbx5x0-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
rename to arch/arm/boot/dts/st/ste-dbx5x0-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-dbx5x0.dtsi
rename to arch/arm/boot/dts/st/ste-dbx5x0.dtsi
diff --git a/arch/arm/boot/dts/ste-href-ab8500.dtsi b/arch/arm/boot/dts/st/ste-href-ab8500.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-href-ab8500.dtsi
rename to arch/arm/boot/dts/st/ste-href-ab8500.dtsi
diff --git a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi b/arch/arm/boot/dts/st/ste-href-family-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
rename to arch/arm/boot/dts/st/ste-href-family-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/ste-href-stuib.dtsi b/arch/arm/boot/dts/st/ste-href-stuib.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-href-stuib.dtsi
rename to arch/arm/boot/dts/st/ste-href-stuib.dtsi
diff --git a/arch/arm/boot/dts/ste-href-tvk1281618-r2.dtsi b/arch/arm/boot/dts/st/ste-href-tvk1281618-r2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-href-tvk1281618-r2.dtsi
rename to arch/arm/boot/dts/st/ste-href-tvk1281618-r2.dtsi
diff --git a/arch/arm/boot/dts/ste-href-tvk1281618-r3.dtsi b/arch/arm/boot/dts/st/ste-href-tvk1281618-r3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-href-tvk1281618-r3.dtsi
rename to arch/arm/boot/dts/st/ste-href-tvk1281618-r3.dtsi
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/st/ste-href.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-href.dtsi
rename to arch/arm/boot/dts/st/ste-href.dtsi
diff --git a/arch/arm/boot/dts/ste-href520-tvk.dts b/arch/arm/boot/dts/st/ste-href520-tvk.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-href520-tvk.dts
rename to arch/arm/boot/dts/st/ste-href520-tvk.dts
diff --git a/arch/arm/boot/dts/ste-hrefprev60-stuib.dts b/arch/arm/boot/dts/st/ste-hrefprev60-stuib.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-hrefprev60-stuib.dts
rename to arch/arm/boot/dts/st/ste-hrefprev60-stuib.dts
diff --git a/arch/arm/boot/dts/ste-hrefprev60-tvk.dts b/arch/arm/boot/dts/st/ste-hrefprev60-tvk.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-hrefprev60-tvk.dts
rename to arch/arm/boot/dts/st/ste-hrefprev60-tvk.dts
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/st/ste-hrefprev60.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-hrefprev60.dtsi
rename to arch/arm/boot/dts/st/ste-hrefprev60.dtsi
diff --git a/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts b/arch/arm/boot/dts/st/ste-hrefv60plus-stuib.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
rename to arch/arm/boot/dts/st/ste-hrefv60plus-stuib.dts
diff --git a/arch/arm/boot/dts/ste-hrefv60plus-tvk.dts b/arch/arm/boot/dts/st/ste-hrefv60plus-tvk.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-hrefv60plus-tvk.dts
rename to arch/arm/boot/dts/st/ste-hrefv60plus-tvk.dts
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/st/ste-hrefv60plus.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-hrefv60plus.dtsi
rename to arch/arm/boot/dts/st/ste-hrefv60plus.dtsi
diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/st/ste-nomadik-nhk15.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-nomadik-nhk15.dts
rename to arch/arm/boot/dts/st/ste-nomadik-nhk15.dts
diff --git a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi b/arch/arm/boot/dts/st/ste-nomadik-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
rename to arch/arm/boot/dts/st/ste-nomadik-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/st/ste-nomadik-s8815.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-nomadik-s8815.dts
rename to arch/arm/boot/dts/st/ste-nomadik-s8815.dts
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/st/ste-nomadik-stn8815.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
rename to arch/arm/boot/dts/st/ste-nomadik-stn8815.dtsi
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/st/ste-snowball.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-snowball.dts
rename to arch/arm/boot/dts/st/ste-snowball.dts
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-codina-tmo.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts
rename to arch/arm/boot/dts/st/ste-ux500-samsung-codina-tmo.dts
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-codina.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-codina.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-ux500-samsung-codina.dts
rename to arch/arm/boot/dts/st/ste-ux500-samsung-codina.dts
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-gavini.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-ux500-samsung-gavini.dts
rename to arch/arm/boot/dts/st/ste-ux500-samsung-gavini.dts
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-golden.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-ux500-samsung-golden.dts
rename to arch/arm/boot/dts/st/ste-ux500-samsung-golden.dts
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-janice.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-janice.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-ux500-samsung-janice.dts
rename to arch/arm/boot/dts/st/ste-ux500-samsung-janice.dts
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-kyle.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-ux500-samsung-kyle.dts
rename to arch/arm/boot/dts/st/ste-ux500-samsung-kyle.dts
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-skomer.dts
similarity index 100%
rename from arch/arm/boot/dts/ste-ux500-samsung-skomer.dts
rename to arch/arm/boot/dts/st/ste-ux500-samsung-skomer.dts
diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/st/stih407-b2120.dts
similarity index 100%
rename from arch/arm/boot/dts/stih407-b2120.dts
rename to arch/arm/boot/dts/st/stih407-b2120.dts
diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/st/stih407-clock.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stih407-clock.dtsi
rename to arch/arm/boot/dts/st/stih407-clock.dtsi
diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/st/stih407-family.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stih407-family.dtsi
rename to arch/arm/boot/dts/st/stih407-family.dtsi
diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/st/stih407-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stih407-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stih407-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/st/stih407.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stih407.dtsi
rename to arch/arm/boot/dts/st/stih407.dtsi
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/st/stih410-b2120.dts
similarity index 100%
rename from arch/arm/boot/dts/stih410-b2120.dts
rename to arch/arm/boot/dts/st/stih410-b2120.dts
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/st/stih410-b2260.dts
similarity index 100%
rename from arch/arm/boot/dts/stih410-b2260.dts
rename to arch/arm/boot/dts/st/stih410-b2260.dts
diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/st/stih410-clock.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stih410-clock.dtsi
rename to arch/arm/boot/dts/st/stih410-clock.dtsi
diff --git a/arch/arm/boot/dts/stih410-pinctrl.dtsi b/arch/arm/boot/dts/st/stih410-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stih410-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stih410-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/st/stih410.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stih410.dtsi
rename to arch/arm/boot/dts/st/stih410.dtsi
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/st/stih418-b2199.dts
similarity index 100%
rename from arch/arm/boot/dts/stih418-b2199.dts
rename to arch/arm/boot/dts/st/stih418-b2199.dts
diff --git a/arch/arm/boot/dts/stih418-b2264.dts b/arch/arm/boot/dts/st/stih418-b2264.dts
similarity index 100%
rename from arch/arm/boot/dts/stih418-b2264.dts
rename to arch/arm/boot/dts/st/stih418-b2264.dts
diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/st/stih418-clock.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stih418-clock.dtsi
rename to arch/arm/boot/dts/st/stih418-clock.dtsi
diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/st/stih418.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stih418.dtsi
rename to arch/arm/boot/dts/st/stih418.dtsi
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/st/stihxxx-b2120.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stihxxx-b2120.dtsi
rename to arch/arm/boot/dts/st/stihxxx-b2120.dtsi
diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/st/stm32429i-eval.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32429i-eval.dts
rename to arch/arm/boot/dts/st/stm32429i-eval.dts
diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/st/stm32746g-eval.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32746g-eval.dts
rename to arch/arm/boot/dts/st/stm32746g-eval.dts
diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f4-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32f4-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stm32f4-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/st/stm32f429-disco.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32f429-disco.dts
rename to arch/arm/boot/dts/st/stm32f429-disco.dts
diff --git a/arch/arm/boot/dts/stm32f429-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f429-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32f429-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stm32f429-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/st/stm32f429.dtsi
similarity index 99%
rename from arch/arm/boot/dts/stm32f429.dtsi
rename to arch/arm/boot/dts/st/stm32f429.dtsi
index c31ceb821231..daba2a5e073a 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/st/stm32f429.dtsi
@@ -45,7 +45,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "armv7-m.dtsi"
+#include "../armv7-m.dtsi"
 #include <dt-bindings/clock/stm32fx-clock.h>
 #include <dt-bindings/mfd/stm32f4-rcc.h>
 
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/st/stm32f469-disco.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32f469-disco.dts
rename to arch/arm/boot/dts/st/stm32f469-disco.dts
diff --git a/arch/arm/boot/dts/stm32f469-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f469-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32f469-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stm32f469-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stm32f469.dtsi b/arch/arm/boot/dts/st/stm32f469.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32f469.dtsi
rename to arch/arm/boot/dts/st/stm32f469.dtsi
diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32f7-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/st/stm32f746-disco.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32f746-disco.dts
rename to arch/arm/boot/dts/st/stm32f746-disco.dts
diff --git a/arch/arm/boot/dts/stm32f746-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32f746-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/st/stm32f746.dtsi
similarity index 99%
rename from arch/arm/boot/dts/stm32f746.dtsi
rename to arch/arm/boot/dts/st/stm32f746.dtsi
index dc868e6da40e..021089b90e84 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/st/stm32f746.dtsi
@@ -40,7 +40,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "armv7-m.dtsi"
+#include "../armv7-m.dtsi"
 #include <dt-bindings/clock/stm32fx-clock.h>
 #include <dt-bindings/mfd/stm32f7-rcc.h>
 
diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32f769-disco.dts
rename to arch/arm/boot/dts/st/stm32f769-disco.dts
diff --git a/arch/arm/boot/dts/stm32f769-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f769-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32f769-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stm32f769-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stm32h7-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32h7-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32h7-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stm32h7-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/st/stm32h743.dtsi
similarity index 99%
rename from arch/arm/boot/dts/stm32h743.dtsi
rename to arch/arm/boot/dts/st/stm32h743.dtsi
index f30796f7adf3..b8d4c44c8a82 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/st/stm32h743.dtsi
@@ -40,7 +40,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "armv7-m.dtsi"
+#include "../armv7-m.dtsi"
 #include <dt-bindings/clock/stm32h7-clks.h>
 #include <dt-bindings/mfd/stm32h7-rcc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/arch/arm/boot/dts/stm32h743i-disco.dts b/arch/arm/boot/dts/st/stm32h743i-disco.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32h743i-disco.dts
rename to arch/arm/boot/dts/st/stm32h743i-disco.dts
diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/st/stm32h743i-eval.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32h743i-eval.dts
rename to arch/arm/boot/dts/st/stm32h743i-eval.dts
diff --git a/arch/arm/boot/dts/stm32h750.dtsi b/arch/arm/boot/dts/st/stm32h750.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32h750.dtsi
rename to arch/arm/boot/dts/st/stm32h750.dtsi
diff --git a/arch/arm/boot/dts/stm32h750i-art-pi.dts b/arch/arm/boot/dts/st/stm32h750i-art-pi.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32h750i-art-pi.dts
rename to arch/arm/boot/dts/st/stm32h750i-art-pi.dts
diff --git a/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp13-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp131.dtsi
rename to arch/arm/boot/dts/st/stm32mp131.dtsi
diff --git a/arch/arm/boot/dts/stm32mp133.dtsi b/arch/arm/boot/dts/st/stm32mp133.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp133.dtsi
rename to arch/arm/boot/dts/st/stm32mp133.dtsi
diff --git a/arch/arm/boot/dts/stm32mp135.dtsi b/arch/arm/boot/dts/st/stm32mp135.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp135.dtsi
rename to arch/arm/boot/dts/st/stm32mp135.dtsi
diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp135f-dk.dts
rename to arch/arm/boot/dts/st/stm32mp135f-dk.dts
diff --git a/arch/arm/boot/dts/stm32mp13xc.dtsi b/arch/arm/boot/dts/st/stm32mp13xc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp13xc.dtsi
rename to arch/arm/boot/dts/st/stm32mp13xc.dtsi
diff --git a/arch/arm/boot/dts/stm32mp13xf.dtsi b/arch/arm/boot/dts/st/stm32mp13xf.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp13xf.dtsi
rename to arch/arm/boot/dts/st/stm32mp13xf.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15-scmi.dtsi b/arch/arm/boot/dts/st/stm32mp15-scmi.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15-scmi.dtsi
rename to arch/arm/boot/dts/st/stm32mp15-scmi.dtsi
diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp151.dtsi
rename to arch/arm/boot/dts/st/stm32mp151.dtsi
diff --git a/arch/arm/boot/dts/stm32mp151a-dhcor-testbench.dts b/arch/arm/boot/dts/st/stm32mp151a-dhcor-testbench.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp151a-dhcor-testbench.dts
rename to arch/arm/boot/dts/st/stm32mp151a-dhcor-testbench.dts
diff --git a/arch/arm/boot/dts/stm32mp151a-prtt1a.dts b/arch/arm/boot/dts/st/stm32mp151a-prtt1a.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp151a-prtt1a.dts
rename to arch/arm/boot/dts/st/stm32mp151a-prtt1a.dts
diff --git a/arch/arm/boot/dts/stm32mp151a-prtt1c.dts b/arch/arm/boot/dts/st/stm32mp151a-prtt1c.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp151a-prtt1c.dts
rename to arch/arm/boot/dts/st/stm32mp151a-prtt1c.dts
diff --git a/arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi b/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi
rename to arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
diff --git a/arch/arm/boot/dts/stm32mp151a-prtt1s.dts b/arch/arm/boot/dts/st/stm32mp151a-prtt1s.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp151a-prtt1s.dts
rename to arch/arm/boot/dts/st/stm32mp151a-prtt1s.dts
diff --git a/arch/arm/boot/dts/stm32mp153.dtsi b/arch/arm/boot/dts/st/stm32mp153.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp153.dtsi
rename to arch/arm/boot/dts/st/stm32mp153.dtsi
diff --git a/arch/arm/boot/dts/stm32mp153c-dhcom-drc02.dts b/arch/arm/boot/dts/st/stm32mp153c-dhcom-drc02.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp153c-dhcom-drc02.dts
rename to arch/arm/boot/dts/st/stm32mp153c-dhcom-drc02.dts
diff --git a/arch/arm/boot/dts/stm32mp153c-dhcor-drc-compact.dts b/arch/arm/boot/dts/st/stm32mp153c-dhcor-drc-compact.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp153c-dhcor-drc-compact.dts
rename to arch/arm/boot/dts/st/stm32mp153c-dhcor-drc-compact.dts
diff --git a/arch/arm/boot/dts/stm32mp157.dtsi b/arch/arm/boot/dts/st/stm32mp157.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157.dtsi
rename to arch/arm/boot/dts/st/stm32mp157.dtsi
diff --git a/arch/arm/boot/dts/stm32mp157a-avenger96.dts b/arch/arm/boot/dts/st/stm32mp157a-avenger96.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-avenger96.dts
rename to arch/arm/boot/dts/st/stm32mp157a-avenger96.dts
diff --git a/arch/arm/boot/dts/stm32mp157a-dhcor-avenger96.dts b/arch/arm/boot/dts/st/stm32mp157a-dhcor-avenger96.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-dhcor-avenger96.dts
rename to arch/arm/boot/dts/st/stm32mp157a-dhcor-avenger96.dts
diff --git a/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
rename to arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/st/stm32mp157a-dk1.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-dk1.dts
rename to arch/arm/boot/dts/st/stm32mp157a-dk1.dts
diff --git a/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2-of10.dts b/arch/arm/boot/dts/st/stm32mp157a-icore-stm32mp1-ctouch2-of10.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2-of10.dts
rename to arch/arm/boot/dts/st/stm32mp157a-icore-stm32mp1-ctouch2-of10.dts
diff --git a/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2.dts b/arch/arm/boot/dts/st/stm32mp157a-icore-stm32mp1-ctouch2.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2.dts
rename to arch/arm/boot/dts/st/stm32mp157a-icore-stm32mp1-ctouch2.dts
diff --git a/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts b/arch/arm/boot/dts/st/stm32mp157a-icore-stm32mp1-edimm2.2.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts
rename to arch/arm/boot/dts/st/stm32mp157a-icore-stm32mp1-edimm2.2.dts
diff --git a/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1.dtsi b/arch/arm/boot/dts/st/stm32mp157a-icore-stm32mp1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-icore-stm32mp1.dtsi
rename to arch/arm/boot/dts/st/stm32mp157a-icore-stm32mp1.dtsi
diff --git a/arch/arm/boot/dts/stm32mp157a-iot-box.dts b/arch/arm/boot/dts/st/stm32mp157a-iot-box.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-iot-box.dts
rename to arch/arm/boot/dts/st/stm32mp157a-iot-box.dts
diff --git a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts b/arch/arm/boot/dts/st/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
rename to arch/arm/boot/dts/st/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
diff --git a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dts b/arch/arm/boot/dts/st/stm32mp157a-microgea-stm32mp1-microdev2.0.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dts
rename to arch/arm/boot/dts/st/stm32mp157a-microgea-stm32mp1-microdev2.0.dts
diff --git a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi b/arch/arm/boot/dts/st/stm32mp157a-microgea-stm32mp1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi
rename to arch/arm/boot/dts/st/stm32mp157a-microgea-stm32mp1.dtsi
diff --git a/arch/arm/boot/dts/stm32mp157a-stinger96.dts b/arch/arm/boot/dts/st/stm32mp157a-stinger96.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-stinger96.dts
rename to arch/arm/boot/dts/st/stm32mp157a-stinger96.dts
diff --git a/arch/arm/boot/dts/stm32mp157a-stinger96.dtsi b/arch/arm/boot/dts/st/stm32mp157a-stinger96.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157a-stinger96.dtsi
rename to arch/arm/boot/dts/st/stm32mp157a-stinger96.dtsi
diff --git a/arch/arm/boot/dts/stm32mp157c-dhcom-pdk2.dts b/arch/arm/boot/dts/st/stm32mp157c-dhcom-pdk2.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157c-dhcom-pdk2.dts
rename to arch/arm/boot/dts/st/stm32mp157c-dhcom-pdk2.dts
diff --git a/arch/arm/boot/dts/stm32mp157c-dhcom-picoitx.dts b/arch/arm/boot/dts/st/stm32mp157c-dhcom-picoitx.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157c-dhcom-picoitx.dts
rename to arch/arm/boot/dts/st/stm32mp157c-dhcom-picoitx.dts
diff --git a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
rename to arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157c-dk2.dts
rename to arch/arm/boot/dts/st/stm32mp157c-dk2.dts
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
rename to arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157c-ed1.dts
rename to arch/arm/boot/dts/st/stm32mp157c-ed1.dts
diff --git a/arch/arm/boot/dts/stm32mp157c-emsbc-argon.dts b/arch/arm/boot/dts/st/stm32mp157c-emsbc-argon.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157c-emsbc-argon.dts
rename to arch/arm/boot/dts/st/stm32mp157c-emsbc-argon.dts
diff --git a/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi b/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
rename to arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
rename to arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157c-ev1.dts
rename to arch/arm/boot/dts/st/stm32mp157c-ev1.dts
diff --git a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts b/arch/arm/boot/dts/st/stm32mp157c-lxa-mc1.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
rename to arch/arm/boot/dts/st/stm32mp157c-lxa-mc1.dts
diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi b/arch/arm/boot/dts/st/stm32mp157c-odyssey-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
rename to arch/arm/boot/dts/st/stm32mp157c-odyssey-som.dtsi
diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey.dts b/arch/arm/boot/dts/st/stm32mp157c-odyssey.dts
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157c-odyssey.dts
rename to arch/arm/boot/dts/st/stm32mp157c-odyssey.dts
diff --git a/arch/arm/boot/dts/stm32mp15xc.dtsi b/arch/arm/boot/dts/st/stm32mp15xc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xc.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xc.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-picoitx.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-picoitx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xx-dhcom-picoitx.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xx-dhcom-picoitx.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcor-avenger96.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xx-dhcor-avenger96.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcor-drc-compact.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xx-dhcor-drc-compact.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-io1v8.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcor-io1v8.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xx-dhcor-io1v8.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xx-dhcor-io1v8.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcor-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xx-dhcor-som.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-testbench.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcor-testbench.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xx-dhcor-testbench.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xx-dhcor-testbench.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xxaa-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15xxaa-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xxaa-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xxaa-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xxab-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15xxab-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xxab-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xxab-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xxac-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15xxac-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xxac-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xxac-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stm32mp15xxad-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15xxad-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp15xxad-pinctrl.dtsi
rename to arch/arm/boot/dts/st/stm32mp15xxad-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/sunplus/Makefile b/arch/arm/boot/dts/sunplus/Makefile
new file mode 100644
index 000000000000..95b0556fc365
--- /dev/null
+++ b/arch/arm/boot/dts/sunplus/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_SOC_SP7021) += \
+	sunplus-sp7021-demo-v3.dtb
diff --git a/arch/arm/boot/dts/sunplus-sp7021-achip.dtsi b/arch/arm/boot/dts/sunplus/sunplus-sp7021-achip.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sunplus-sp7021-achip.dtsi
rename to arch/arm/boot/dts/sunplus/sunplus-sp7021-achip.dtsi
diff --git a/arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts b/arch/arm/boot/dts/sunplus/sunplus-sp7021-demo-v3.dts
similarity index 100%
rename from arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts
rename to arch/arm/boot/dts/sunplus/sunplus-sp7021-demo-v3.dts
diff --git a/arch/arm/boot/dts/sunplus-sp7021.dtsi b/arch/arm/boot/dts/sunplus/sunplus-sp7021.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sunplus-sp7021.dtsi
rename to arch/arm/boot/dts/sunplus/sunplus-sp7021.dtsi
diff --git a/arch/arm/boot/dts/synaptics/Makefile b/arch/arm/boot/dts/synaptics/Makefile
new file mode 100644
index 000000000000..0ecccd156d18
--- /dev/null
+++ b/arch/arm/boot/dts/synaptics/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_BERLIN) += \
+	berlin2-sony-nsz-gs7.dtb \
+	berlin2cd-google-chromecast.dtb \
+	berlin2cd-valve-steamlink.dtb \
+	berlin2q-marvell-dmp.dtb
diff --git a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts b/arch/arm/boot/dts/synaptics/berlin2-sony-nsz-gs7.dts
similarity index 100%
rename from arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
rename to arch/arm/boot/dts/synaptics/berlin2-sony-nsz-gs7.dts
diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/synaptics/berlin2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/berlin2.dtsi
rename to arch/arm/boot/dts/synaptics/berlin2.dtsi
diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/synaptics/berlin2cd-google-chromecast.dts
similarity index 100%
rename from arch/arm/boot/dts/berlin2cd-google-chromecast.dts
rename to arch/arm/boot/dts/synaptics/berlin2cd-google-chromecast.dts
diff --git a/arch/arm/boot/dts/berlin2cd-valve-steamlink.dts b/arch/arm/boot/dts/synaptics/berlin2cd-valve-steamlink.dts
similarity index 100%
rename from arch/arm/boot/dts/berlin2cd-valve-steamlink.dts
rename to arch/arm/boot/dts/synaptics/berlin2cd-valve-steamlink.dts
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/synaptics/berlin2cd.dtsi
similarity index 100%
rename from arch/arm/boot/dts/berlin2cd.dtsi
rename to arch/arm/boot/dts/synaptics/berlin2cd.dtsi
diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/synaptics/berlin2q-marvell-dmp.dts
similarity index 100%
rename from arch/arm/boot/dts/berlin2q-marvell-dmp.dts
rename to arch/arm/boot/dts/synaptics/berlin2q-marvell-dmp.dts
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/synaptics/berlin2q.dtsi
similarity index 100%
rename from arch/arm/boot/dts/berlin2q.dtsi
rename to arch/arm/boot/dts/synaptics/berlin2q.dtsi
diff --git a/arch/arm/boot/dts/ti/Makefile b/arch/arm/boot/dts/ti/Makefile
new file mode 100644
index 000000000000..cff9b2764657
--- /dev/null
+++ b/arch/arm/boot/dts/ti/Makefile
@@ -0,0 +1,174 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtb-$(CONFIG_ARCH_DAVINCI) += \
+	da850-lcdk.dtb \
+	da850-enbw-cmc.dtb \
+	da850-evm.dtb \
+	da850-lego-ev3.dtb
+dtb-$(CONFIG_ARCH_KEYSTONE) += \
+	keystone-k2hk-evm.dtb \
+	keystone-k2l-evm.dtb \
+	keystone-k2e-evm.dtb \
+	keystone-k2g-evm.dtb \
+	keystone-k2g-ice.dtb
+dtb-$(CONFIG_ARCH_OMAP2) += \
+	omap2420-h4.dtb \
+	omap2420-n800.dtb \
+	omap2420-n810.dtb \
+	omap2420-n810-wimax.dtb \
+	omap2430-sdp.dtb
+dtb-$(CONFIG_ARCH_OMAP3) += \
+	am3517-craneboard.dtb \
+	am3517-evm.dtb \
+	am3517_mt_ventoux.dtb \
+	logicpd-torpedo-35xx-devkit.dtb \
+	logicpd-torpedo-37xx-devkit.dtb \
+	logicpd-torpedo-37xx-devkit-28.dtb \
+	logicpd-som-lv-35xx-devkit.dtb \
+	logicpd-som-lv-37xx-devkit.dtb \
+	omap3430-sdp.dtb \
+	omap3-beagle.dtb \
+	omap3-beagle-ab4.dtb \
+	omap3-beagle-xm.dtb \
+	omap3-beagle-xm-ab.dtb \
+	omap3-cm-t3517.dtb \
+	omap3-cm-t3530.dtb \
+	omap3-cm-t3730.dtb \
+	omap3-devkit8000.dtb \
+	omap3-devkit8000-lcd43.dtb \
+	omap3-devkit8000-lcd70.dtb \
+	omap3-echo.dtb \
+	omap3-evm.dtb \
+	omap3-evm-37xx.dtb \
+	omap3-gta04a3.dtb \
+	omap3-gta04a4.dtb \
+	omap3-gta04a5.dtb \
+	omap3-gta04a5one.dtb \
+	omap3-ha.dtb \
+	omap3-ha-lcd.dtb \
+	omap3-igep0020.dtb \
+	omap3-igep0020-rev-f.dtb \
+	omap3-igep0030.dtb \
+	omap3-igep0030-rev-g.dtb \
+	omap3-ldp.dtb \
+	omap3-lilly-dbb056.dtb \
+	omap3-n900.dtb \
+	omap3-n9.dtb \
+	omap3-n950.dtb \
+	omap3-overo-alto35.dtb \
+	omap3-overo-chestnut43.dtb \
+	omap3-overo-gallop43.dtb \
+	omap3-overo-palo35.dtb \
+	omap3-overo-palo43.dtb \
+	omap3-overo-storm-alto35.dtb \
+	omap3-overo-storm-chestnut43.dtb \
+	omap3-overo-storm-gallop43.dtb \
+	omap3-overo-storm-palo35.dtb \
+	omap3-overo-storm-palo43.dtb \
+	omap3-overo-storm-summit.dtb \
+	omap3-overo-storm-tobi.dtb \
+	omap3-overo-storm-tobiduo.dtb \
+	omap3-overo-summit.dtb \
+	omap3-overo-tobi.dtb \
+	omap3-overo-tobiduo.dtb \
+	omap3-pandora-600mhz.dtb \
+	omap3-pandora-1ghz.dtb \
+	omap3-sbc-t3517.dtb \
+	omap3-sbc-t3530.dtb \
+	omap3-sbc-t3730.dtb \
+	omap3-sniper.dtb \
+	omap3-thunder.dtb \
+	omap3-zoom3.dtb
+dtb-$(CONFIG_ARCH_OMAP4) += \
+	omap4-droid-bionic-xt875.dtb \
+	omap4-droid4-xt894.dtb \
+	omap4-duovero-parlor.dtb \
+	omap4-kc1.dtb \
+	omap4-panda.dtb \
+	omap4-panda-a4.dtb \
+	omap4-panda-es.dtb \
+	omap4-sdp.dtb \
+	omap4-sdp-es23plus.dtb \
+	omap4-var-dvk-om44.dtb \
+	omap4-var-stk-om44.dtb
+dtb-$(CONFIG_SOC_AM33XX) += \
+	am335x-baltos-ir2110.dtb \
+	am335x-baltos-ir3220.dtb \
+	am335x-baltos-ir5221.dtb \
+	am335x-base0033.dtb \
+	am335x-bone.dtb \
+	am335x-boneblack.dtb \
+	am335x-boneblack-wireless.dtb \
+	am335x-boneblue.dtb \
+	am335x-bonegreen.dtb \
+	am335x-bonegreen-wireless.dtb \
+	am335x-chiliboard.dtb \
+	am335x-cm-t335.dtb \
+	am335x-evm.dtb \
+	am335x-evmsk.dtb \
+	am335x-guardian.dtb \
+	am335x-icev2.dtb \
+	am335x-lxm.dtb \
+	am335x-moxa-uc-2101.dtb \
+	am335x-moxa-uc-8100-me-t.dtb \
+	am335x-myirtech-myd.dtb \
+	am335x-nano.dtb \
+	am335x-netcan-plus-1xx.dtb \
+	am335x-netcom-plus-2xx.dtb \
+	am335x-netcom-plus-8xx.dtb \
+	am335x-pdu001.dtb \
+	am335x-pepper.dtb \
+	am335x-phycore-rdk.dtb \
+	am335x-pocketbeagle.dtb \
+	am335x-regor-rdk.dtb \
+	am335x-sancloud-bbe.dtb \
+	am335x-sancloud-bbe-lite.dtb \
+	am335x-sancloud-bbe-extended-wifi.dtb \
+	am335x-shc.dtb \
+	am335x-sbc-t335.dtb \
+	am335x-sl50.dtb \
+	am335x-wega-rdk.dtb \
+	am335x-osd3358-sm-red.dtb
+dtb-$(CONFIG_SOC_AM43XX) += \
+	am43x-epos-evm.dtb \
+	am437x-cm-t43.dtb \
+	am437x-gp-evm.dtb \
+	am437x-idk-evm.dtb \
+	am437x-sbc-t43.dtb \
+	am437x-sk-evm.dtb
+
+am57xx-evm-dtbs := am57xx-beagle-x15.dtb am57xx-evm.dtbo
+am57xx-evm-reva3-dtbs := am57xx-beagle-x15-revc.dtb am57xx-evm.dtbo
+
+dtb-$(CONFIG_SOC_DRA7XX) += \
+	am57xx-beagle-x15.dtb \
+	am57xx-beagle-x15-revb1.dtb \
+	am57xx-beagle-x15-revc.dtb \
+	am57xx-evm.dtb \
+	am57xx-evm-reva3.dtb \
+	am5729-beagleboneai.dtb \
+	am57xx-cl-som-am57x.dtb \
+	am57xx-sbc-am57x.dtb \
+	am572x-idk.dtb \
+	am572x-idk-touchscreen.dtbo \
+	am571x-idk.dtb \
+	am571x-idk-touchscreen.dtbo \
+	am574x-idk.dtb \
+	am57xx-idk-lcd-osd101t2045.dtbo \
+	am57xx-idk-lcd-osd101t2587.dtbo \
+	dra7-evm.dtb \
+	dra72-evm.dtb \
+	dra72-evm-revc.dtb \
+	dra71-evm.dtb \
+	dra76-evm.dtb
+dtb-$(CONFIG_SOC_OMAP5) += \
+	omap5-cm-t54.dtb \
+	omap5-igep0050.dtb \
+	omap5-sbc-t54.dtb \
+	omap5-uevm.dtb
+dtb-$(CONFIG_SOC_TI81XX) += \
+	am3874-iceboard.dtb \
+	dm8148-evm.dtb \
+	dm8148-t410.dtb \
+	dm8168-evm.dtb \
+	dra62x-j5eco-evm.dtb
diff --git a/arch/arm/boot/dts/am335x-baltos-ir2110.dts b/arch/arm/boot/dts/ti/am335x-baltos-ir2110.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-baltos-ir2110.dts
rename to arch/arm/boot/dts/ti/am335x-baltos-ir2110.dts
diff --git a/arch/arm/boot/dts/am335x-baltos-ir3220.dts b/arch/arm/boot/dts/ti/am335x-baltos-ir3220.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-baltos-ir3220.dts
rename to arch/arm/boot/dts/ti/am335x-baltos-ir3220.dts
diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/ti/am335x-baltos-ir5221.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-baltos-ir5221.dts
rename to arch/arm/boot/dts/ti/am335x-baltos-ir5221.dts
diff --git a/arch/arm/boot/dts/am335x-baltos-leds.dtsi b/arch/arm/boot/dts/ti/am335x-baltos-leds.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am335x-baltos-leds.dtsi
rename to arch/arm/boot/dts/ti/am335x-baltos-leds.dtsi
diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/ti/am335x-baltos.dtsi
similarity index 99%
rename from arch/arm/boot/dts/am335x-baltos.dtsi
rename to arch/arm/boot/dts/ti/am335x-baltos.dtsi
index 6161c8929a78..b01e6624e71e 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/ti/am335x-baltos.dtsi
@@ -258,7 +258,7 @@ at24@50 {
 	};
 };
 
-#include "tps65910.dtsi"
+#include "../tps65910.dtsi"
 
 &tps {
 	vcc1-supply = <&vbat>;
diff --git a/arch/arm/boot/dts/am335x-base0033.dts b/arch/arm/boot/dts/ti/am335x-base0033.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-base0033.dts
rename to arch/arm/boot/dts/ti/am335x-base0033.dts
diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/ti/am335x-bone-common.dtsi
similarity index 99%
rename from arch/arm/boot/dts/am335x-bone-common.dtsi
rename to arch/arm/boot/dts/ti/am335x-bone-common.dtsi
index 02e04a12a270..53cd11616954 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/ti/am335x-bone-common.dtsi
@@ -273,7 +273,7 @@ cape3_data: cape_data@0 {
 };
 
 
-/include/ "tps65217.dtsi"
+/include/ "../tps65217.dtsi"
 
 &tps {
 	/*
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/ti/am335x-bone.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-bone.dts
rename to arch/arm/boot/dts/ti/am335x-bone.dts
diff --git a/arch/arm/boot/dts/am335x-boneblack-common.dtsi b/arch/arm/boot/dts/ti/am335x-boneblack-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am335x-boneblack-common.dtsi
rename to arch/arm/boot/dts/ti/am335x-boneblack-common.dtsi
diff --git a/arch/arm/boot/dts/am335x-boneblack-hdmi.dtsi b/arch/arm/boot/dts/ti/am335x-boneblack-hdmi.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am335x-boneblack-hdmi.dtsi
rename to arch/arm/boot/dts/ti/am335x-boneblack-hdmi.dtsi
diff --git a/arch/arm/boot/dts/am335x-boneblack-wireless.dts b/arch/arm/boot/dts/ti/am335x-boneblack-wireless.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-boneblack-wireless.dts
rename to arch/arm/boot/dts/ti/am335x-boneblack-wireless.dts
diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/ti/am335x-boneblack.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-boneblack.dts
rename to arch/arm/boot/dts/ti/am335x-boneblack.dts
diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/ti/am335x-boneblue.dts
similarity index 99%
rename from arch/arm/boot/dts/am335x-boneblue.dts
rename to arch/arm/boot/dts/ti/am335x-boneblue.dts
index 34579e98636e..88cd2acb138a 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/ti/am335x-boneblue.dts
@@ -353,7 +353,7 @@ pressure@76 {
 	};
 };
 
-/include/ "tps65217.dtsi"
+/include/ "../tps65217.dtsi"
 
 &tps {
 	/delete-property/ ti,pmic-shutdown-controller;
diff --git a/arch/arm/boot/dts/am335x-bonegreen-common.dtsi b/arch/arm/boot/dts/ti/am335x-bonegreen-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am335x-bonegreen-common.dtsi
rename to arch/arm/boot/dts/ti/am335x-bonegreen-common.dtsi
diff --git a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts b/arch/arm/boot/dts/ti/am335x-bonegreen-wireless.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-bonegreen-wireless.dts
rename to arch/arm/boot/dts/ti/am335x-bonegreen-wireless.dts
diff --git a/arch/arm/boot/dts/am335x-bonegreen.dts b/arch/arm/boot/dts/ti/am335x-bonegreen.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-bonegreen.dts
rename to arch/arm/boot/dts/ti/am335x-bonegreen.dts
diff --git a/arch/arm/boot/dts/am335x-chiliboard.dts b/arch/arm/boot/dts/ti/am335x-chiliboard.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-chiliboard.dts
rename to arch/arm/boot/dts/ti/am335x-chiliboard.dts
diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts/ti/am335x-chilisom.dtsi
similarity index 99%
rename from arch/arm/boot/dts/am335x-chilisom.dtsi
rename to arch/arm/boot/dts/ti/am335x-chilisom.dtsi
index 43b61e43ed1e..8fe1753e86e0 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/ti/am335x-chilisom.dtsi
@@ -66,7 +66,7 @@ tps: tps@24 {
 
 };
 
-/include/ "tps65217.dtsi"
+/include/ "../tps65217.dtsi"
 
 &tps {
 	regulators {
diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/ti/am335x-cm-t335.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-cm-t335.dts
rename to arch/arm/boot/dts/ti/am335x-cm-t335.dts
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/ti/am335x-evm.dts
similarity index 99%
rename from arch/arm/boot/dts/am335x-evm.dts
rename to arch/arm/boot/dts/ti/am335x-evm.dts
index 5beabaa5ff6a..e33be1a5f264 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/ti/am335x-evm.dts
@@ -585,7 +585,7 @@ partition@9 {
 	};
 };
 
-#include "tps65910.dtsi"
+#include "../tps65910.dtsi"
 
 &mcasp1 {
 	#sound-dai-cells = <0>;
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/ti/am335x-evmsk.dts
similarity index 99%
rename from arch/arm/boot/dts/am335x-evmsk.dts
rename to arch/arm/boot/dts/ti/am335x-evmsk.dts
index 5b3278c0c46a..c81825a83660 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/ti/am335x-evmsk.dts
@@ -517,7 +517,7 @@ ecap2: pwm@100 {
 	};
 };
 
-#include "tps65910.dtsi"
+#include "../tps65910.dtsi"
 
 &tps {
 	vcc1-supply = <&vbat>;
diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/ti/am335x-guardian.dts
similarity index 99%
rename from arch/arm/boot/dts/am335x-guardian.dts
rename to arch/arm/boot/dts/ti/am335x-guardian.dts
index b357364e93f9..76a401c4dc52 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/ti/am335x-guardian.dts
@@ -292,7 +292,7 @@ &spi0 {
 	status = "okay";
 };
 
-#include "tps65217.dtsi"
+#include "../tps65217.dtsi"
 
 &tps {
   /*
diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/ti/am335x-icev2.dts
similarity index 99%
rename from arch/arm/boot/dts/am335x-icev2.dts
rename to arch/arm/boot/dts/ti/am335x-icev2.dts
index 5835c0cdda50..66a74505cd33 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/ti/am335x-icev2.dts
@@ -360,7 +360,7 @@ adc {
 	};
 };
 
-#include "tps65910.dtsi"
+#include "../tps65910.dtsi"
 
 &tps {
 	vcc1-supply = <&vbat>;
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/ti/am335x-igep0033.dtsi
similarity index 99%
rename from arch/arm/boot/dts/am335x-igep0033.dtsi
rename to arch/arm/boot/dts/ti/am335x-igep0033.dtsi
index 3fddf80dcf71..5a7fa9cd8590 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/ti/am335x-igep0033.dtsi
@@ -221,7 +221,7 @@ &usb1 {
 	dr_mode = "host";
 };
 
-#include "tps65910.dtsi"
+#include "../tps65910.dtsi"
 
 &tps {
 	vcc1-supply = <&vbat>;
diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/ti/am335x-lxm.dts
similarity index 99%
rename from arch/arm/boot/dts/am335x-lxm.dts
rename to arch/arm/boot/dts/ti/am335x-lxm.dts
index 1282dae144dd..3db560490992 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/ti/am335x-lxm.dts
@@ -177,7 +177,7 @@ tps: tps@2d {
 	};
 };
 
-/include/ "tps65910.dtsi"
+/include/ "../tps65910.dtsi"
 
 &tps {
 	vcc1-supply = <&vbat>;
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi b/arch/arm/boot/dts/ti/am335x-moxa-uc-2100-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
rename to arch/arm/boot/dts/ti/am335x-moxa-uc-2100-common.dtsi
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2101.dts b/arch/arm/boot/dts/ti/am335x-moxa-uc-2101.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-moxa-uc-2101.dts
rename to arch/arm/boot/dts/ti/am335x-moxa-uc-2101.dts
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi b/arch/arm/boot/dts/ti/am335x-moxa-uc-8100-common.dtsi
similarity index 99%
rename from arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
rename to arch/arm/boot/dts/ti/am335x-moxa-uc-8100-common.dtsi
index 7d00e8b20f18..037b954240ea 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
+++ b/arch/arm/boot/dts/ti/am335x-moxa-uc-8100-common.dtsi
@@ -233,7 +233,7 @@ &usb1 {
 };
 
 
-#include "tps65910.dtsi"
+#include "../tps65910.dtsi"
 &tps {
 	vcc1-supply = <&vbat>;
 	vcc2-supply = <&vbat>;
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts b/arch/arm/boot/dts/ti/am335x-moxa-uc-8100-me-t.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
rename to arch/arm/boot/dts/ti/am335x-moxa-uc-8100-me-t.dts
diff --git a/arch/arm/boot/dts/am335x-myirtech-myc.dtsi b/arch/arm/boot/dts/ti/am335x-myirtech-myc.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am335x-myirtech-myc.dtsi
rename to arch/arm/boot/dts/ti/am335x-myirtech-myc.dtsi
diff --git a/arch/arm/boot/dts/am335x-myirtech-myd.dts b/arch/arm/boot/dts/ti/am335x-myirtech-myd.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-myirtech-myd.dts
rename to arch/arm/boot/dts/ti/am335x-myirtech-myd.dts
diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/ti/am335x-nano.dts
similarity index 99%
rename from arch/arm/boot/dts/am335x-nano.dts
rename to arch/arm/boot/dts/ti/am335x-nano.dts
index c447aebd8d86..e161547f0409 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/ti/am335x-nano.dts
@@ -427,7 +427,7 @@ &usb0 {
 	dr_mode = "host";
 };
 
-#include "tps65217.dtsi"
+#include "../tps65217.dtsi"
 
 &tps {
 	regulators {
diff --git a/arch/arm/boot/dts/am335x-netcan-plus-1xx.dts b/arch/arm/boot/dts/ti/am335x-netcan-plus-1xx.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-netcan-plus-1xx.dts
rename to arch/arm/boot/dts/ti/am335x-netcan-plus-1xx.dts
diff --git a/arch/arm/boot/dts/am335x-netcom-plus-2xx.dts b/arch/arm/boot/dts/ti/am335x-netcom-plus-2xx.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-netcom-plus-2xx.dts
rename to arch/arm/boot/dts/ti/am335x-netcom-plus-2xx.dts
diff --git a/arch/arm/boot/dts/am335x-netcom-plus-8xx.dts b/arch/arm/boot/dts/ti/am335x-netcom-plus-8xx.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-netcom-plus-8xx.dts
rename to arch/arm/boot/dts/ti/am335x-netcom-plus-8xx.dts
diff --git a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts b/arch/arm/boot/dts/ti/am335x-osd3358-sm-red.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-osd3358-sm-red.dts
rename to arch/arm/boot/dts/ti/am335x-osd3358-sm-red.dts
diff --git a/arch/arm/boot/dts/am335x-osd335x-common.dtsi b/arch/arm/boot/dts/ti/am335x-osd335x-common.dtsi
similarity index 98%
rename from arch/arm/boot/dts/am335x-osd335x-common.dtsi
rename to arch/arm/boot/dts/ti/am335x-osd335x-common.dtsi
index 2888b15999ee..4238dc4beae1 100644
--- a/arch/arm/boot/dts/am335x-osd335x-common.dtsi
+++ b/arch/arm/boot/dts/ti/am335x-osd335x-common.dtsi
@@ -54,7 +54,7 @@ tps: tps@24 {
 	};
 };
 
-/include/ "tps65217.dtsi"
+/include/ "../tps65217.dtsi"
 
 &tps {
 	interrupts = <7>; /* NMI */
diff --git a/arch/arm/boot/dts/am335x-pcm-953.dtsi b/arch/arm/boot/dts/ti/am335x-pcm-953.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am335x-pcm-953.dtsi
rename to arch/arm/boot/dts/ti/am335x-pcm-953.dtsi
diff --git a/arch/arm/boot/dts/am335x-pdu001.dts b/arch/arm/boot/dts/ti/am335x-pdu001.dts
similarity index 99%
rename from arch/arm/boot/dts/am335x-pdu001.dts
rename to arch/arm/boot/dts/ti/am335x-pdu001.dts
index ce6cc2b96654..afead7f756fa 100644
--- a/arch/arm/boot/dts/am335x-pdu001.dts
+++ b/arch/arm/boot/dts/ti/am335x-pdu001.dts
@@ -400,7 +400,7 @@ &elm {
 	status = "okay";
 };
 
-#include "tps65910.dtsi"
+#include "../tps65910.dtsi"
 
 &tps {
 	vcc1-supply = <&vbat>;
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/ti/am335x-pepper.dts
similarity index 99%
rename from arch/arm/boot/dts/am335x-pepper.dts
rename to arch/arm/boot/dts/ti/am335x-pepper.dts
index a4509e9e1056..09bc527ca5e1 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/ti/am335x-pepper.dts
@@ -423,7 +423,7 @@ &vdd5_reg {
 	vin-supply = <&vbat>;
 };
 
-/include/ "tps65217.dtsi"
+/include/ "../tps65217.dtsi"
 
 &tps {
 	backlight {
diff --git a/arch/arm/boot/dts/am335x-phycore-rdk.dts b/arch/arm/boot/dts/ti/am335x-phycore-rdk.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-phycore-rdk.dts
rename to arch/arm/boot/dts/ti/am335x-phycore-rdk.dts
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/ti/am335x-phycore-som.dtsi
similarity index 99%
rename from arch/arm/boot/dts/am335x-phycore-som.dtsi
rename to arch/arm/boot/dts/ti/am335x-phycore-som.dtsi
index 034dc5181679..c6ed52aa1c19 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/ti/am335x-phycore-som.dtsi
@@ -233,7 +233,7 @@ nandflash: nand@0,0 {
 };
 
 /* Power */
-#include "tps65910.dtsi"
+#include "../tps65910.dtsi"
 
 &tps {
 	vcc1-supply = <&vcc5v>;
diff --git a/arch/arm/boot/dts/am335x-pocketbeagle.dts b/arch/arm/boot/dts/ti/am335x-pocketbeagle.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-pocketbeagle.dts
rename to arch/arm/boot/dts/ti/am335x-pocketbeagle.dts
diff --git a/arch/arm/boot/dts/am335x-regor-rdk.dts b/arch/arm/boot/dts/ti/am335x-regor-rdk.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-regor-rdk.dts
rename to arch/arm/boot/dts/ti/am335x-regor-rdk.dts
diff --git a/arch/arm/boot/dts/am335x-regor.dtsi b/arch/arm/boot/dts/ti/am335x-regor.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am335x-regor.dtsi
rename to arch/arm/boot/dts/ti/am335x-regor.dtsi
diff --git a/arch/arm/boot/dts/am335x-sancloud-bbe-common.dtsi b/arch/arm/boot/dts/ti/am335x-sancloud-bbe-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am335x-sancloud-bbe-common.dtsi
rename to arch/arm/boot/dts/ti/am335x-sancloud-bbe-common.dtsi
diff --git a/arch/arm/boot/dts/am335x-sancloud-bbe-extended-wifi.dts b/arch/arm/boot/dts/ti/am335x-sancloud-bbe-extended-wifi.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-sancloud-bbe-extended-wifi.dts
rename to arch/arm/boot/dts/ti/am335x-sancloud-bbe-extended-wifi.dts
diff --git a/arch/arm/boot/dts/am335x-sancloud-bbe-lite.dts b/arch/arm/boot/dts/ti/am335x-sancloud-bbe-lite.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-sancloud-bbe-lite.dts
rename to arch/arm/boot/dts/ti/am335x-sancloud-bbe-lite.dts
diff --git a/arch/arm/boot/dts/am335x-sancloud-bbe.dts b/arch/arm/boot/dts/ti/am335x-sancloud-bbe.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-sancloud-bbe.dts
rename to arch/arm/boot/dts/ti/am335x-sancloud-bbe.dts
diff --git a/arch/arm/boot/dts/am335x-sbc-t335.dts b/arch/arm/boot/dts/ti/am335x-sbc-t335.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-sbc-t335.dts
rename to arch/arm/boot/dts/ti/am335x-sbc-t335.dts
diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/ti/am335x-shc.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-shc.dts
rename to arch/arm/boot/dts/ti/am335x-shc.dts
diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/ti/am335x-sl50.dts
similarity index 99%
rename from arch/arm/boot/dts/am335x-sl50.dts
rename to arch/arm/boot/dts/ti/am335x-sl50.dts
index 73b5d1a024bd..07930f9b81e4 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/ti/am335x-sl50.dts
@@ -597,7 +597,7 @@ flash: flash@1 {
 	};
 };
 
-#include "tps65217.dtsi"
+#include "../tps65217.dtsi"
 
 &tps {
 	ti,pmic-shutdown-controller;
diff --git a/arch/arm/boot/dts/am335x-wega-rdk.dts b/arch/arm/boot/dts/ti/am335x-wega-rdk.dts
similarity index 100%
rename from arch/arm/boot/dts/am335x-wega-rdk.dts
rename to arch/arm/boot/dts/ti/am335x-wega-rdk.dts
diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/ti/am335x-wega.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am335x-wega.dtsi
rename to arch/arm/boot/dts/ti/am335x-wega.dtsi
diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/ti/am33xx-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am33xx-clocks.dtsi
rename to arch/arm/boot/dts/ti/am33xx-clocks.dtsi
diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/ti/am33xx-l4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am33xx-l4.dtsi
rename to arch/arm/boot/dts/ti/am33xx-l4.dtsi
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/ti/am33xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am33xx.dtsi
rename to arch/arm/boot/dts/ti/am33xx.dtsi
diff --git a/arch/arm/boot/dts/am3517-craneboard.dts b/arch/arm/boot/dts/ti/am3517-craneboard.dts
similarity index 99%
rename from arch/arm/boot/dts/am3517-craneboard.dts
rename to arch/arm/boot/dts/ti/am3517-craneboard.dts
index 3642cfc80194..c0087a0ba2a5 100644
--- a/arch/arm/boot/dts/am3517-craneboard.dts
+++ b/arch/arm/boot/dts/ti/am3517-craneboard.dts
@@ -69,7 +69,7 @@ &mmc3 {
 	status = "disabled";
 };
 
-#include "tps65910.dtsi"
+#include "../tps65910.dtsi"
 
 &omap3_pmx_core {
 	tps_pins: pinmux_tps_pins {
diff --git a/arch/arm/boot/dts/am3517-evm-ui.dtsi b/arch/arm/boot/dts/ti/am3517-evm-ui.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am3517-evm-ui.dtsi
rename to arch/arm/boot/dts/ti/am3517-evm-ui.dtsi
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/ti/am3517-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/am3517-evm.dts
rename to arch/arm/boot/dts/ti/am3517-evm.dts
diff --git a/arch/arm/boot/dts/am3517-som.dtsi b/arch/arm/boot/dts/ti/am3517-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am3517-som.dtsi
rename to arch/arm/boot/dts/ti/am3517-som.dtsi
diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/ti/am3517.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am3517.dtsi
rename to arch/arm/boot/dts/ti/am3517.dtsi
diff --git a/arch/arm/boot/dts/am3517_mt_ventoux.dts b/arch/arm/boot/dts/ti/am3517_mt_ventoux.dts
similarity index 100%
rename from arch/arm/boot/dts/am3517_mt_ventoux.dts
rename to arch/arm/boot/dts/ti/am3517_mt_ventoux.dts
diff --git a/arch/arm/boot/dts/am35xx-clocks.dtsi b/arch/arm/boot/dts/ti/am35xx-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am35xx-clocks.dtsi
rename to arch/arm/boot/dts/ti/am35xx-clocks.dtsi
diff --git a/arch/arm/boot/dts/am3703.dtsi b/arch/arm/boot/dts/ti/am3703.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am3703.dtsi
rename to arch/arm/boot/dts/ti/am3703.dtsi
diff --git a/arch/arm/boot/dts/am3715.dtsi b/arch/arm/boot/dts/ti/am3715.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am3715.dtsi
rename to arch/arm/boot/dts/ti/am3715.dtsi
diff --git a/arch/arm/boot/dts/am3874-iceboard.dts b/arch/arm/boot/dts/ti/am3874-iceboard.dts
similarity index 100%
rename from arch/arm/boot/dts/am3874-iceboard.dts
rename to arch/arm/boot/dts/ti/am3874-iceboard.dts
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/ti/am4372.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am4372.dtsi
rename to arch/arm/boot/dts/ti/am4372.dtsi
diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/ti/am437x-cm-t43.dts
similarity index 100%
rename from arch/arm/boot/dts/am437x-cm-t43.dts
rename to arch/arm/boot/dts/ti/am437x-cm-t43.dts
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/ti/am437x-gp-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/am437x-gp-evm.dts
rename to arch/arm/boot/dts/ti/am437x-gp-evm.dts
diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/ti/am437x-idk-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/am437x-idk-evm.dts
rename to arch/arm/boot/dts/ti/am437x-idk-evm.dts
diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/ti/am437x-l4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am437x-l4.dtsi
rename to arch/arm/boot/dts/ti/am437x-l4.dtsi
diff --git a/arch/arm/boot/dts/am437x-sbc-t43.dts b/arch/arm/boot/dts/ti/am437x-sbc-t43.dts
similarity index 100%
rename from arch/arm/boot/dts/am437x-sbc-t43.dts
rename to arch/arm/boot/dts/ti/am437x-sbc-t43.dts
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/ti/am437x-sk-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/am437x-sk-evm.dts
rename to arch/arm/boot/dts/ti/am437x-sk-evm.dts
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/ti/am43x-epos-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/am43x-epos-evm.dts
rename to arch/arm/boot/dts/ti/am43x-epos-evm.dts
diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/ti/am43xx-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am43xx-clocks.dtsi
rename to arch/arm/boot/dts/ti/am43xx-clocks.dtsi
diff --git a/arch/arm/boot/dts/am57-pruss.dtsi b/arch/arm/boot/dts/ti/am57-pruss.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am57-pruss.dtsi
rename to arch/arm/boot/dts/ti/am57-pruss.dtsi
diff --git a/arch/arm/boot/dts/am5718.dtsi b/arch/arm/boot/dts/ti/am5718.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am5718.dtsi
rename to arch/arm/boot/dts/ti/am5718.dtsi
diff --git a/arch/arm/boot/dts/am571x-idk-touchscreen.dtso b/arch/arm/boot/dts/ti/am571x-idk-touchscreen.dtso
similarity index 100%
rename from arch/arm/boot/dts/am571x-idk-touchscreen.dtso
rename to arch/arm/boot/dts/ti/am571x-idk-touchscreen.dtso
diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/ti/am571x-idk.dts
similarity index 100%
rename from arch/arm/boot/dts/am571x-idk.dts
rename to arch/arm/boot/dts/ti/am571x-idk.dts
diff --git a/arch/arm/boot/dts/am5728.dtsi b/arch/arm/boot/dts/ti/am5728.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am5728.dtsi
rename to arch/arm/boot/dts/ti/am5728.dtsi
diff --git a/arch/arm/boot/dts/am5729-beagleboneai.dts b/arch/arm/boot/dts/ti/am5729-beagleboneai.dts
similarity index 100%
rename from arch/arm/boot/dts/am5729-beagleboneai.dts
rename to arch/arm/boot/dts/ti/am5729-beagleboneai.dts
diff --git a/arch/arm/boot/dts/am572x-idk-common.dtsi b/arch/arm/boot/dts/ti/am572x-idk-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am572x-idk-common.dtsi
rename to arch/arm/boot/dts/ti/am572x-idk-common.dtsi
diff --git a/arch/arm/boot/dts/am572x-idk-touchscreen.dtso b/arch/arm/boot/dts/ti/am572x-idk-touchscreen.dtso
similarity index 100%
rename from arch/arm/boot/dts/am572x-idk-touchscreen.dtso
rename to arch/arm/boot/dts/ti/am572x-idk-touchscreen.dtso
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/ti/am572x-idk.dts
similarity index 100%
rename from arch/arm/boot/dts/am572x-idk.dts
rename to arch/arm/boot/dts/ti/am572x-idk.dts
diff --git a/arch/arm/boot/dts/am5748.dtsi b/arch/arm/boot/dts/ti/am5748.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am5748.dtsi
rename to arch/arm/boot/dts/ti/am5748.dtsi
diff --git a/arch/arm/boot/dts/am574x-idk.dts b/arch/arm/boot/dts/ti/am574x-idk.dts
similarity index 100%
rename from arch/arm/boot/dts/am574x-idk.dts
rename to arch/arm/boot/dts/ti/am574x-idk.dts
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/ti/am57xx-beagle-x15-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
rename to arch/arm/boot/dts/ti/am57xx-beagle-x15-common.dtsi
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts b/arch/arm/boot/dts/ti/am57xx-beagle-x15-revb1.dts
similarity index 100%
rename from arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
rename to arch/arm/boot/dts/ti/am57xx-beagle-x15-revb1.dts
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts b/arch/arm/boot/dts/ti/am57xx-beagle-x15-revc.dts
similarity index 100%
rename from arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
rename to arch/arm/boot/dts/ti/am57xx-beagle-x15-revc.dts
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/ti/am57xx-beagle-x15.dts
similarity index 100%
rename from arch/arm/boot/dts/am57xx-beagle-x15.dts
rename to arch/arm/boot/dts/ti/am57xx-beagle-x15.dts
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/ti/am57xx-cl-som-am57x.dts
similarity index 100%
rename from arch/arm/boot/dts/am57xx-cl-som-am57x.dts
rename to arch/arm/boot/dts/ti/am57xx-cl-som-am57x.dts
diff --git a/arch/arm/boot/dts/am57xx-commercial-grade.dtsi b/arch/arm/boot/dts/ti/am57xx-commercial-grade.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am57xx-commercial-grade.dtsi
rename to arch/arm/boot/dts/ti/am57xx-commercial-grade.dtsi
diff --git a/arch/arm/boot/dts/am57xx-evm.dtso b/arch/arm/boot/dts/ti/am57xx-evm.dtso
similarity index 100%
rename from arch/arm/boot/dts/am57xx-evm.dtso
rename to arch/arm/boot/dts/ti/am57xx-evm.dtso
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/ti/am57xx-idk-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am57xx-idk-common.dtsi
rename to arch/arm/boot/dts/ti/am57xx-idk-common.dtsi
diff --git a/arch/arm/boot/dts/am57xx-idk-lcd-osd101t2045.dtso b/arch/arm/boot/dts/ti/am57xx-idk-lcd-osd101t2045.dtso
similarity index 100%
rename from arch/arm/boot/dts/am57xx-idk-lcd-osd101t2045.dtso
rename to arch/arm/boot/dts/ti/am57xx-idk-lcd-osd101t2045.dtso
diff --git a/arch/arm/boot/dts/am57xx-idk-lcd-osd101t2587.dtso b/arch/arm/boot/dts/ti/am57xx-idk-lcd-osd101t2587.dtso
similarity index 100%
rename from arch/arm/boot/dts/am57xx-idk-lcd-osd101t2587.dtso
rename to arch/arm/boot/dts/ti/am57xx-idk-lcd-osd101t2587.dtso
diff --git a/arch/arm/boot/dts/am57xx-industrial-grade.dtsi b/arch/arm/boot/dts/ti/am57xx-industrial-grade.dtsi
similarity index 100%
rename from arch/arm/boot/dts/am57xx-industrial-grade.dtsi
rename to arch/arm/boot/dts/ti/am57xx-industrial-grade.dtsi
diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/ti/am57xx-sbc-am57x.dts
similarity index 100%
rename from arch/arm/boot/dts/am57xx-sbc-am57x.dts
rename to arch/arm/boot/dts/ti/am57xx-sbc-am57x.dts
diff --git a/arch/arm/boot/dts/compulab-sb-som.dtsi b/arch/arm/boot/dts/ti/compulab-sb-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/compulab-sb-som.dtsi
rename to arch/arm/boot/dts/ti/compulab-sb-som.dtsi
diff --git a/arch/arm/boot/dts/da850-enbw-cmc.dts b/arch/arm/boot/dts/ti/da850-enbw-cmc.dts
similarity index 100%
rename from arch/arm/boot/dts/da850-enbw-cmc.dts
rename to arch/arm/boot/dts/ti/da850-enbw-cmc.dts
diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/ti/da850-evm.dts
similarity index 99%
rename from arch/arm/boot/dts/da850-evm.dts
rename to arch/arm/boot/dts/ti/da850-evm.dts
index 0ca849885d1f..192f9fc90357 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/ti/da850-evm.dts
@@ -333,7 +333,7 @@ &gpio {
 	status = "okay";
 };
 
-/include/ "tps6507x.dtsi"
+/include/ "../tps6507x.dtsi"
 
 &tps {
 	vdcdc1_2-supply = <&vbat>;
diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/ti/da850-lcdk.dts
similarity index 100%
rename from arch/arm/boot/dts/da850-lcdk.dts
rename to arch/arm/boot/dts/ti/da850-lcdk.dts
diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/ti/da850-lego-ev3.dts
similarity index 100%
rename from arch/arm/boot/dts/da850-lego-ev3.dts
rename to arch/arm/boot/dts/ti/da850-lego-ev3.dts
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/ti/da850.dtsi
similarity index 100%
rename from arch/arm/boot/dts/da850.dtsi
rename to arch/arm/boot/dts/ti/da850.dtsi
diff --git a/arch/arm/boot/dts/dm3725.dtsi b/arch/arm/boot/dts/ti/dm3725.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dm3725.dtsi
rename to arch/arm/boot/dts/ti/dm3725.dtsi
diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/ti/dm8148-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/dm8148-evm.dts
rename to arch/arm/boot/dts/ti/dm8148-evm.dts
diff --git a/arch/arm/boot/dts/dm8148-t410.dts b/arch/arm/boot/dts/ti/dm8148-t410.dts
similarity index 100%
rename from arch/arm/boot/dts/dm8148-t410.dts
rename to arch/arm/boot/dts/ti/dm8148-t410.dts
diff --git a/arch/arm/boot/dts/dm814x-clocks.dtsi b/arch/arm/boot/dts/ti/dm814x-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dm814x-clocks.dtsi
rename to arch/arm/boot/dts/ti/dm814x-clocks.dtsi
diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/ti/dm814x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dm814x.dtsi
rename to arch/arm/boot/dts/ti/dm814x.dtsi
diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/ti/dm8168-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/dm8168-evm.dts
rename to arch/arm/boot/dts/ti/dm8168-evm.dts
diff --git a/arch/arm/boot/dts/dm816x-clocks.dtsi b/arch/arm/boot/dts/ti/dm816x-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dm816x-clocks.dtsi
rename to arch/arm/boot/dts/ti/dm816x-clocks.dtsi
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/ti/dm816x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dm816x.dtsi
rename to arch/arm/boot/dts/ti/dm816x.dtsi
diff --git a/arch/arm/boot/dts/dra62x-clocks.dtsi b/arch/arm/boot/dts/ti/dra62x-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra62x-clocks.dtsi
rename to arch/arm/boot/dts/ti/dra62x-clocks.dtsi
diff --git a/arch/arm/boot/dts/dra62x-j5eco-evm.dts b/arch/arm/boot/dts/ti/dra62x-j5eco-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/dra62x-j5eco-evm.dts
rename to arch/arm/boot/dts/ti/dra62x-j5eco-evm.dts
diff --git a/arch/arm/boot/dts/dra62x.dtsi b/arch/arm/boot/dts/ti/dra62x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra62x.dtsi
rename to arch/arm/boot/dts/ti/dra62x.dtsi
diff --git a/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi b/arch/arm/boot/dts/ti/dra7-dspeve-thermal.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
rename to arch/arm/boot/dts/ti/dra7-dspeve-thermal.dtsi
diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/ti/dra7-evm-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra7-evm-common.dtsi
rename to arch/arm/boot/dts/ti/dra7-evm-common.dtsi
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/ti/dra7-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/dra7-evm.dts
rename to arch/arm/boot/dts/ti/dra7-evm.dts
diff --git a/arch/arm/boot/dts/dra7-ipu-dsp-common.dtsi b/arch/arm/boot/dts/ti/dra7-ipu-dsp-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra7-ipu-dsp-common.dtsi
rename to arch/arm/boot/dts/ti/dra7-ipu-dsp-common.dtsi
diff --git a/arch/arm/boot/dts/dra7-iva-thermal.dtsi b/arch/arm/boot/dts/ti/dra7-iva-thermal.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra7-iva-thermal.dtsi
rename to arch/arm/boot/dts/ti/dra7-iva-thermal.dtsi
diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/ti/dra7-l4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra7-l4.dtsi
rename to arch/arm/boot/dts/ti/dra7-l4.dtsi
diff --git a/arch/arm/boot/dts/dra7-mmc-iodelay.dtsi b/arch/arm/boot/dts/ti/dra7-mmc-iodelay.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra7-mmc-iodelay.dtsi
rename to arch/arm/boot/dts/ti/dra7-mmc-iodelay.dtsi
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/ti/dra7.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra7.dtsi
rename to arch/arm/boot/dts/ti/dra7.dtsi
diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/ti/dra71-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/dra71-evm.dts
rename to arch/arm/boot/dts/ti/dra71-evm.dts
diff --git a/arch/arm/boot/dts/dra71x.dtsi b/arch/arm/boot/dts/ti/dra71x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra71x.dtsi
rename to arch/arm/boot/dts/ti/dra71x.dtsi
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/ti/dra72-evm-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra72-evm-common.dtsi
rename to arch/arm/boot/dts/ti/dra72-evm-common.dtsi
diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/ti/dra72-evm-revc.dts
similarity index 100%
rename from arch/arm/boot/dts/dra72-evm-revc.dts
rename to arch/arm/boot/dts/ti/dra72-evm-revc.dts
diff --git a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi b/arch/arm/boot/dts/ti/dra72-evm-tps65917.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra72-evm-tps65917.dtsi
rename to arch/arm/boot/dts/ti/dra72-evm-tps65917.dtsi
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/ti/dra72-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/dra72-evm.dts
rename to arch/arm/boot/dts/ti/dra72-evm.dts
diff --git a/arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi b/arch/arm/boot/dts/ti/dra72x-mmc-iodelay.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi
rename to arch/arm/boot/dts/ti/dra72x-mmc-iodelay.dtsi
diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/ti/dra72x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra72x.dtsi
rename to arch/arm/boot/dts/ti/dra72x.dtsi
diff --git a/arch/arm/boot/dts/dra74-ipu-dsp-common.dtsi b/arch/arm/boot/dts/ti/dra74-ipu-dsp-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra74-ipu-dsp-common.dtsi
rename to arch/arm/boot/dts/ti/dra74-ipu-dsp-common.dtsi
diff --git a/arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi b/arch/arm/boot/dts/ti/dra74x-mmc-iodelay.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi
rename to arch/arm/boot/dts/ti/dra74x-mmc-iodelay.dtsi
diff --git a/arch/arm/boot/dts/dra74x-p.dtsi b/arch/arm/boot/dts/ti/dra74x-p.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra74x-p.dtsi
rename to arch/arm/boot/dts/ti/dra74x-p.dtsi
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/ti/dra74x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra74x.dtsi
rename to arch/arm/boot/dts/ti/dra74x.dtsi
diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/ti/dra76-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/dra76-evm.dts
rename to arch/arm/boot/dts/ti/dra76-evm.dts
diff --git a/arch/arm/boot/dts/dra76x-mmc-iodelay.dtsi b/arch/arm/boot/dts/ti/dra76x-mmc-iodelay.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra76x-mmc-iodelay.dtsi
rename to arch/arm/boot/dts/ti/dra76x-mmc-iodelay.dtsi
diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/ti/dra76x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra76x.dtsi
rename to arch/arm/boot/dts/ti/dra76x.dtsi
diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/ti/dra7xx-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/dra7xx-clocks.dtsi
rename to arch/arm/boot/dts/ti/dra7xx-clocks.dtsi
diff --git a/arch/arm/boot/dts/elpida_ecb240abacn.dtsi b/arch/arm/boot/dts/ti/elpida_ecb240abacn.dtsi
similarity index 100%
rename from arch/arm/boot/dts/elpida_ecb240abacn.dtsi
rename to arch/arm/boot/dts/ti/elpida_ecb240abacn.dtsi
diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/ti/keystone-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/keystone-clocks.dtsi
rename to arch/arm/boot/dts/ti/keystone-clocks.dtsi
diff --git a/arch/arm/boot/dts/keystone-k2e-clocks.dtsi b/arch/arm/boot/dts/ti/keystone-k2e-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2e-clocks.dtsi
rename to arch/arm/boot/dts/ti/keystone-k2e-clocks.dtsi
diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/ti/keystone-k2e-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2e-evm.dts
rename to arch/arm/boot/dts/ti/keystone-k2e-evm.dts
diff --git a/arch/arm/boot/dts/keystone-k2e-netcp.dtsi b/arch/arm/boot/dts/ti/keystone-k2e-netcp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2e-netcp.dtsi
rename to arch/arm/boot/dts/ti/keystone-k2e-netcp.dtsi
diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/ti/keystone-k2e.dtsi
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2e.dtsi
rename to arch/arm/boot/dts/ti/keystone-k2e.dtsi
diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/ti/keystone-k2g-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2g-evm.dts
rename to arch/arm/boot/dts/ti/keystone-k2g-evm.dts
diff --git a/arch/arm/boot/dts/keystone-k2g-ice.dts b/arch/arm/boot/dts/ti/keystone-k2g-ice.dts
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2g-ice.dts
rename to arch/arm/boot/dts/ti/keystone-k2g-ice.dts
diff --git a/arch/arm/boot/dts/keystone-k2g-netcp.dtsi b/arch/arm/boot/dts/ti/keystone-k2g-netcp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2g-netcp.dtsi
rename to arch/arm/boot/dts/ti/keystone-k2g-netcp.dtsi
diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/ti/keystone-k2g.dtsi
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2g.dtsi
rename to arch/arm/boot/dts/ti/keystone-k2g.dtsi
diff --git a/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi b/arch/arm/boot/dts/ti/keystone-k2hk-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
rename to arch/arm/boot/dts/ti/keystone-k2hk-clocks.dtsi
diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/ti/keystone-k2hk-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2hk-evm.dts
rename to arch/arm/boot/dts/ti/keystone-k2hk-evm.dts
diff --git a/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi b/arch/arm/boot/dts/ti/keystone-k2hk-netcp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
rename to arch/arm/boot/dts/ti/keystone-k2hk-netcp.dtsi
diff --git a/arch/arm/boot/dts/keystone-k2hk.dtsi b/arch/arm/boot/dts/ti/keystone-k2hk.dtsi
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2hk.dtsi
rename to arch/arm/boot/dts/ti/keystone-k2hk.dtsi
diff --git a/arch/arm/boot/dts/keystone-k2l-clocks.dtsi b/arch/arm/boot/dts/ti/keystone-k2l-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2l-clocks.dtsi
rename to arch/arm/boot/dts/ti/keystone-k2l-clocks.dtsi
diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/ti/keystone-k2l-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2l-evm.dts
rename to arch/arm/boot/dts/ti/keystone-k2l-evm.dts
diff --git a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi b/arch/arm/boot/dts/ti/keystone-k2l-netcp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2l-netcp.dtsi
rename to arch/arm/boot/dts/ti/keystone-k2l-netcp.dtsi
diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/ti/keystone-k2l.dtsi
similarity index 100%
rename from arch/arm/boot/dts/keystone-k2l.dtsi
rename to arch/arm/boot/dts/ti/keystone-k2l.dtsi
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/ti/keystone.dtsi
similarity index 100%
rename from arch/arm/boot/dts/keystone.dtsi
rename to arch/arm/boot/dts/ti/keystone.dtsi
diff --git a/arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts b/arch/arm/boot/dts/ti/logicpd-som-lv-35xx-devkit.dts
similarity index 100%
rename from arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts
rename to arch/arm/boot/dts/ti/logicpd-som-lv-35xx-devkit.dts
diff --git a/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts b/arch/arm/boot/dts/ti/logicpd-som-lv-37xx-devkit.dts
similarity index 100%
rename from arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
rename to arch/arm/boot/dts/ti/logicpd-som-lv-37xx-devkit.dts
diff --git a/arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi b/arch/arm/boot/dts/ti/logicpd-som-lv-baseboard.dtsi
similarity index 100%
rename from arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi
rename to arch/arm/boot/dts/ti/logicpd-som-lv-baseboard.dtsi
diff --git a/arch/arm/boot/dts/logicpd-som-lv.dtsi b/arch/arm/boot/dts/ti/logicpd-som-lv.dtsi
similarity index 100%
rename from arch/arm/boot/dts/logicpd-som-lv.dtsi
rename to arch/arm/boot/dts/ti/logicpd-som-lv.dtsi
diff --git a/arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts b/arch/arm/boot/dts/ti/logicpd-torpedo-35xx-devkit.dts
similarity index 100%
rename from arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts
rename to arch/arm/boot/dts/ti/logicpd-torpedo-35xx-devkit.dts
diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts b/arch/arm/boot/dts/ti/logicpd-torpedo-37xx-devkit-28.dts
similarity index 100%
rename from arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts
rename to arch/arm/boot/dts/ti/logicpd-torpedo-37xx-devkit-28.dts
diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/ti/logicpd-torpedo-37xx-devkit.dts
similarity index 100%
rename from arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
rename to arch/arm/boot/dts/ti/logicpd-torpedo-37xx-devkit.dts
diff --git a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi b/arch/arm/boot/dts/ti/logicpd-torpedo-baseboard.dtsi
similarity index 100%
rename from arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
rename to arch/arm/boot/dts/ti/logicpd-torpedo-baseboard.dtsi
diff --git a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi b/arch/arm/boot/dts/ti/logicpd-torpedo-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/logicpd-torpedo-som.dtsi
rename to arch/arm/boot/dts/ti/logicpd-torpedo-som.dtsi
diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/ti/motorola-cpcap-mapphone.dtsi
similarity index 100%
rename from arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
rename to arch/arm/boot/dts/ti/motorola-cpcap-mapphone.dtsi
diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/ti/motorola-mapphone-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/motorola-mapphone-common.dtsi
rename to arch/arm/boot/dts/ti/motorola-mapphone-common.dtsi
diff --git a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi b/arch/arm/boot/dts/ti/omap-gpmc-smsc911x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
rename to arch/arm/boot/dts/ti/omap-gpmc-smsc911x.dtsi
diff --git a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi b/arch/arm/boot/dts/ti/omap-gpmc-smsc9221.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
rename to arch/arm/boot/dts/ti/omap-gpmc-smsc9221.dtsi
diff --git a/arch/arm/boot/dts/omap-zoom-common.dtsi b/arch/arm/boot/dts/ti/omap-zoom-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap-zoom-common.dtsi
rename to arch/arm/boot/dts/ti/omap-zoom-common.dtsi
diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/ti/omap2.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap2.dtsi
rename to arch/arm/boot/dts/ti/omap2.dtsi
diff --git a/arch/arm/boot/dts/omap2420-clocks.dtsi b/arch/arm/boot/dts/ti/omap2420-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap2420-clocks.dtsi
rename to arch/arm/boot/dts/ti/omap2420-clocks.dtsi
diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/ti/omap2420-h4.dts
similarity index 100%
rename from arch/arm/boot/dts/omap2420-h4.dts
rename to arch/arm/boot/dts/ti/omap2420-h4.dts
diff --git a/arch/arm/boot/dts/omap2420-n800.dts b/arch/arm/boot/dts/ti/omap2420-n800.dts
similarity index 100%
rename from arch/arm/boot/dts/omap2420-n800.dts
rename to arch/arm/boot/dts/ti/omap2420-n800.dts
diff --git a/arch/arm/boot/dts/omap2420-n810-wimax.dts b/arch/arm/boot/dts/ti/omap2420-n810-wimax.dts
similarity index 100%
rename from arch/arm/boot/dts/omap2420-n810-wimax.dts
rename to arch/arm/boot/dts/ti/omap2420-n810-wimax.dts
diff --git a/arch/arm/boot/dts/omap2420-n810.dts b/arch/arm/boot/dts/ti/omap2420-n810.dts
similarity index 100%
rename from arch/arm/boot/dts/omap2420-n810.dts
rename to arch/arm/boot/dts/ti/omap2420-n810.dts
diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/ti/omap2420-n8x0-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap2420-n8x0-common.dtsi
rename to arch/arm/boot/dts/ti/omap2420-n8x0-common.dtsi
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/ti/omap2420.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap2420.dtsi
rename to arch/arm/boot/dts/ti/omap2420.dtsi
diff --git a/arch/arm/boot/dts/omap2430-clocks.dtsi b/arch/arm/boot/dts/ti/omap2430-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap2430-clocks.dtsi
rename to arch/arm/boot/dts/ti/omap2430-clocks.dtsi
diff --git a/arch/arm/boot/dts/omap2430-sdp.dts b/arch/arm/boot/dts/ti/omap2430-sdp.dts
similarity index 100%
rename from arch/arm/boot/dts/omap2430-sdp.dts
rename to arch/arm/boot/dts/ti/omap2430-sdp.dts
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/ti/omap2430.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap2430.dtsi
rename to arch/arm/boot/dts/ti/omap2430.dtsi
diff --git a/arch/arm/boot/dts/omap24xx-clocks.dtsi b/arch/arm/boot/dts/ti/omap24xx-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap24xx-clocks.dtsi
rename to arch/arm/boot/dts/ti/omap24xx-clocks.dtsi
diff --git a/arch/arm/boot/dts/omap3-beagle-ab4.dts b/arch/arm/boot/dts/ti/omap3-beagle-ab4.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-beagle-ab4.dts
rename to arch/arm/boot/dts/ti/omap3-beagle-ab4.dts
diff --git a/arch/arm/boot/dts/omap3-beagle-xm-ab.dts b/arch/arm/boot/dts/ti/omap3-beagle-xm-ab.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-beagle-xm-ab.dts
rename to arch/arm/boot/dts/ti/omap3-beagle-xm-ab.dts
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/ti/omap3-beagle-xm.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-beagle-xm.dts
rename to arch/arm/boot/dts/ti/omap3-beagle-xm.dts
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/ti/omap3-beagle.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-beagle.dts
rename to arch/arm/boot/dts/ti/omap3-beagle.dts
diff --git a/arch/arm/boot/dts/omap3-cm-t3517.dts b/arch/arm/boot/dts/ti/omap3-cm-t3517.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-cm-t3517.dts
rename to arch/arm/boot/dts/ti/omap3-cm-t3517.dts
diff --git a/arch/arm/boot/dts/omap3-cm-t3530.dts b/arch/arm/boot/dts/ti/omap3-cm-t3530.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-cm-t3530.dts
rename to arch/arm/boot/dts/ti/omap3-cm-t3530.dts
diff --git a/arch/arm/boot/dts/omap3-cm-t3730.dts b/arch/arm/boot/dts/ti/omap3-cm-t3730.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-cm-t3730.dts
rename to arch/arm/boot/dts/ti/omap3-cm-t3730.dts
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/ti/omap3-cm-t3x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-cm-t3x.dtsi
rename to arch/arm/boot/dts/ti/omap3-cm-t3x.dtsi
diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/ti/omap3-cm-t3x30.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-cm-t3x30.dtsi
rename to arch/arm/boot/dts/ti/omap3-cm-t3x30.dtsi
diff --git a/arch/arm/boot/dts/omap3-cpu-thermal.dtsi b/arch/arm/boot/dts/ti/omap3-cpu-thermal.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-cpu-thermal.dtsi
rename to arch/arm/boot/dts/ti/omap3-cpu-thermal.dtsi
diff --git a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi b/arch/arm/boot/dts/ti/omap3-devkit8000-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-devkit8000-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-devkit8000-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi b/arch/arm/boot/dts/ti/omap3-devkit8000-lcd-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-devkit8000-lcd-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd43.dts b/arch/arm/boot/dts/ti/omap3-devkit8000-lcd43.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-devkit8000-lcd43.dts
rename to arch/arm/boot/dts/ti/omap3-devkit8000-lcd43.dts
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd70.dts b/arch/arm/boot/dts/ti/omap3-devkit8000-lcd70.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-devkit8000-lcd70.dts
rename to arch/arm/boot/dts/ti/omap3-devkit8000-lcd70.dts
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/ti/omap3-devkit8000.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-devkit8000.dts
rename to arch/arm/boot/dts/ti/omap3-devkit8000.dts
diff --git a/arch/arm/boot/dts/omap3-echo.dts b/arch/arm/boot/dts/ti/omap3-echo.dts
similarity index 99%
rename from arch/arm/boot/dts/omap3-echo.dts
rename to arch/arm/boot/dts/ti/omap3-echo.dts
index 06d2377d28ad..207282d4c626 100644
--- a/arch/arm/boot/dts/omap3-echo.dts
+++ b/arch/arm/boot/dts/ti/omap3-echo.dts
@@ -521,7 +521,7 @@ codec0: codec@18 {
 };
 
 
-#include "tps65910.dtsi"
+#include "../tps65910.dtsi"
 
 &omap3_pmx_core {
 	tps_pins: pinmux_tps_pins {
diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/ti/omap3-evm-37xx.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-evm-37xx.dts
rename to arch/arm/boot/dts/ti/omap3-evm-37xx.dts
diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/ti/omap3-evm-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-evm-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-evm-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-evm-processor-common.dtsi b/arch/arm/boot/dts/ti/omap3-evm-processor-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-evm-processor-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-evm-processor-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/ti/omap3-evm.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-evm.dts
rename to arch/arm/boot/dts/ti/omap3-evm.dts
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/ti/omap3-gta04.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-gta04.dtsi
rename to arch/arm/boot/dts/ti/omap3-gta04.dtsi
diff --git a/arch/arm/boot/dts/omap3-gta04a3.dts b/arch/arm/boot/dts/ti/omap3-gta04a3.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-gta04a3.dts
rename to arch/arm/boot/dts/ti/omap3-gta04a3.dts
diff --git a/arch/arm/boot/dts/omap3-gta04a4.dts b/arch/arm/boot/dts/ti/omap3-gta04a4.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-gta04a4.dts
rename to arch/arm/boot/dts/ti/omap3-gta04a4.dts
diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/ti/omap3-gta04a5.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-gta04a5.dts
rename to arch/arm/boot/dts/ti/omap3-gta04a5.dts
diff --git a/arch/arm/boot/dts/omap3-gta04a5one.dts b/arch/arm/boot/dts/ti/omap3-gta04a5one.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-gta04a5one.dts
rename to arch/arm/boot/dts/ti/omap3-gta04a5one.dts
diff --git a/arch/arm/boot/dts/omap3-ha-common.dtsi b/arch/arm/boot/dts/ti/omap3-ha-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-ha-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-ha-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-ha-lcd.dts b/arch/arm/boot/dts/ti/omap3-ha-lcd.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-ha-lcd.dts
rename to arch/arm/boot/dts/ti/omap3-ha-lcd.dts
diff --git a/arch/arm/boot/dts/omap3-ha.dts b/arch/arm/boot/dts/ti/omap3-ha.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-ha.dts
rename to arch/arm/boot/dts/ti/omap3-ha.dts
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/ti/omap3-igep.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-igep.dtsi
rename to arch/arm/boot/dts/ti/omap3-igep.dtsi
diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/ti/omap3-igep0020-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-igep0020-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-igep0020-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/dts/ti/omap3-igep0020-rev-f.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-igep0020-rev-f.dts
rename to arch/arm/boot/dts/ti/omap3-igep0020-rev-f.dts
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/ti/omap3-igep0020.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-igep0020.dts
rename to arch/arm/boot/dts/ti/omap3-igep0020.dts
diff --git a/arch/arm/boot/dts/omap3-igep0030-common.dtsi b/arch/arm/boot/dts/ti/omap3-igep0030-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-igep0030-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-igep0030-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts b/arch/arm/boot/dts/ti/omap3-igep0030-rev-g.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-igep0030-rev-g.dts
rename to arch/arm/boot/dts/ti/omap3-igep0030-rev-g.dts
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/ti/omap3-igep0030.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-igep0030.dts
rename to arch/arm/boot/dts/ti/omap3-igep0030.dts
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/ti/omap3-ldp.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-ldp.dts
rename to arch/arm/boot/dts/ti/omap3-ldp.dts
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/ti/omap3-lilly-a83x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-lilly-a83x.dtsi
rename to arch/arm/boot/dts/ti/omap3-lilly-a83x.dtsi
diff --git a/arch/arm/boot/dts/omap3-lilly-dbb056.dts b/arch/arm/boot/dts/ti/omap3-lilly-dbb056.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-lilly-dbb056.dts
rename to arch/arm/boot/dts/ti/omap3-lilly-dbb056.dts
diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/ti/omap3-n9.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-n9.dts
rename to arch/arm/boot/dts/ti/omap3-n9.dts
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/ti/omap3-n900.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-n900.dts
rename to arch/arm/boot/dts/ti/omap3-n900.dts
diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/ti/omap3-n950-n9.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-n950-n9.dtsi
rename to arch/arm/boot/dts/ti/omap3-n950-n9.dtsi
diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/ti/omap3-n950.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-n950.dts
rename to arch/arm/boot/dts/ti/omap3-n950.dts
diff --git a/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi b/arch/arm/boot/dts/ti/omap3-overo-alto35-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-alto35-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-alto35.dts b/arch/arm/boot/dts/ti/omap3-overo-alto35.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-alto35.dts
rename to arch/arm/boot/dts/ti/omap3-overo-alto35.dts
diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/ti/omap3-overo-base.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-base.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-base.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi b/arch/arm/boot/dts/ti/omap3-overo-chestnut43-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-chestnut43-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-chestnut43.dts b/arch/arm/boot/dts/ti/omap3-overo-chestnut43.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-chestnut43.dts
rename to arch/arm/boot/dts/ti/omap3-overo-chestnut43.dts
diff --git a/arch/arm/boot/dts/omap3-overo-common-dvi.dtsi b/arch/arm/boot/dts/ti/omap3-overo-common-dvi.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-common-dvi.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-common-dvi.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi b/arch/arm/boot/dts/ti/omap3-overo-common-lcd35.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-common-lcd35.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi b/arch/arm/boot/dts/ti/omap3-overo-common-lcd43.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-common-lcd43.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-common-peripherals.dtsi b/arch/arm/boot/dts/ti/omap3-overo-common-peripherals.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-common-peripherals.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-common-peripherals.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi b/arch/arm/boot/dts/ti/omap3-overo-gallop43-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-gallop43-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-gallop43.dts b/arch/arm/boot/dts/ti/omap3-overo-gallop43.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-gallop43.dts
rename to arch/arm/boot/dts/ti/omap3-overo-gallop43.dts
diff --git a/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi b/arch/arm/boot/dts/ti/omap3-overo-palo35-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-palo35-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-palo35.dts b/arch/arm/boot/dts/ti/omap3-overo-palo35.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-palo35.dts
rename to arch/arm/boot/dts/ti/omap3-overo-palo35.dts
diff --git a/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi b/arch/arm/boot/dts/ti/omap3-overo-palo43-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-palo43-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-palo43.dts b/arch/arm/boot/dts/ti/omap3-overo-palo43.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-palo43.dts
rename to arch/arm/boot/dts/ti/omap3-overo-palo43.dts
diff --git a/arch/arm/boot/dts/omap3-overo-storm-alto35.dts b/arch/arm/boot/dts/ti/omap3-overo-storm-alto35.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-storm-alto35.dts
rename to arch/arm/boot/dts/ti/omap3-overo-storm-alto35.dts
diff --git a/arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts b/arch/arm/boot/dts/ti/omap3-overo-storm-chestnut43.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts
rename to arch/arm/boot/dts/ti/omap3-overo-storm-chestnut43.dts
diff --git a/arch/arm/boot/dts/omap3-overo-storm-gallop43.dts b/arch/arm/boot/dts/ti/omap3-overo-storm-gallop43.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-storm-gallop43.dts
rename to arch/arm/boot/dts/ti/omap3-overo-storm-gallop43.dts
diff --git a/arch/arm/boot/dts/omap3-overo-storm-palo35.dts b/arch/arm/boot/dts/ti/omap3-overo-storm-palo35.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-storm-palo35.dts
rename to arch/arm/boot/dts/ti/omap3-overo-storm-palo35.dts
diff --git a/arch/arm/boot/dts/omap3-overo-storm-palo43.dts b/arch/arm/boot/dts/ti/omap3-overo-storm-palo43.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-storm-palo43.dts
rename to arch/arm/boot/dts/ti/omap3-overo-storm-palo43.dts
diff --git a/arch/arm/boot/dts/omap3-overo-storm-summit.dts b/arch/arm/boot/dts/ti/omap3-overo-storm-summit.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-storm-summit.dts
rename to arch/arm/boot/dts/ti/omap3-overo-storm-summit.dts
diff --git a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts b/arch/arm/boot/dts/ti/omap3-overo-storm-tobi.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-storm-tobi.dts
rename to arch/arm/boot/dts/ti/omap3-overo-storm-tobi.dts
diff --git a/arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts b/arch/arm/boot/dts/ti/omap3-overo-storm-tobiduo.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts
rename to arch/arm/boot/dts/ti/omap3-overo-storm-tobiduo.dts
diff --git a/arch/arm/boot/dts/omap3-overo-storm.dtsi b/arch/arm/boot/dts/ti/omap3-overo-storm.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-storm.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-storm.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-summit-common.dtsi b/arch/arm/boot/dts/ti/omap3-overo-summit-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-summit-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-summit-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-summit.dts b/arch/arm/boot/dts/ti/omap3-overo-summit.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-summit.dts
rename to arch/arm/boot/dts/ti/omap3-overo-summit.dts
diff --git a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi b/arch/arm/boot/dts/ti/omap3-overo-tobi-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-tobi-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-tobi.dts b/arch/arm/boot/dts/ti/omap3-overo-tobi.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-tobi.dts
rename to arch/arm/boot/dts/ti/omap3-overo-tobi.dts
diff --git a/arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi b/arch/arm/boot/dts/ti/omap3-overo-tobiduo-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo-tobiduo-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-overo-tobiduo.dts b/arch/arm/boot/dts/ti/omap3-overo-tobiduo.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo-tobiduo.dts
rename to arch/arm/boot/dts/ti/omap3-overo-tobiduo.dts
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/ti/omap3-overo.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-overo.dtsi
rename to arch/arm/boot/dts/ti/omap3-overo.dtsi
diff --git a/arch/arm/boot/dts/omap3-pandora-1ghz.dts b/arch/arm/boot/dts/ti/omap3-pandora-1ghz.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-pandora-1ghz.dts
rename to arch/arm/boot/dts/ti/omap3-pandora-1ghz.dts
diff --git a/arch/arm/boot/dts/omap3-pandora-600mhz.dts b/arch/arm/boot/dts/ti/omap3-pandora-600mhz.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-pandora-600mhz.dts
rename to arch/arm/boot/dts/ti/omap3-pandora-600mhz.dts
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/ti/omap3-pandora-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-pandora-common.dtsi
rename to arch/arm/boot/dts/ti/omap3-pandora-common.dtsi
diff --git a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi b/arch/arm/boot/dts/ti/omap3-panel-sharp-ls037v7dw01.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
rename to arch/arm/boot/dts/ti/omap3-panel-sharp-ls037v7dw01.dtsi
diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/ti/omap3-sb-t35.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-sb-t35.dtsi
rename to arch/arm/boot/dts/ti/omap3-sb-t35.dtsi
diff --git a/arch/arm/boot/dts/omap3-sbc-t3517.dts b/arch/arm/boot/dts/ti/omap3-sbc-t3517.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-sbc-t3517.dts
rename to arch/arm/boot/dts/ti/omap3-sbc-t3517.dts
diff --git a/arch/arm/boot/dts/omap3-sbc-t3530.dts b/arch/arm/boot/dts/ti/omap3-sbc-t3530.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-sbc-t3530.dts
rename to arch/arm/boot/dts/ti/omap3-sbc-t3530.dts
diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/ti/omap3-sbc-t3730.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-sbc-t3730.dts
rename to arch/arm/boot/dts/ti/omap3-sbc-t3730.dts
diff --git a/arch/arm/boot/dts/omap3-sniper.dts b/arch/arm/boot/dts/ti/omap3-sniper.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-sniper.dts
rename to arch/arm/boot/dts/ti/omap3-sniper.dts
diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/ti/omap3-tao3530.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-tao3530.dtsi
rename to arch/arm/boot/dts/ti/omap3-tao3530.dtsi
diff --git a/arch/arm/boot/dts/omap3-thunder.dts b/arch/arm/boot/dts/ti/omap3-thunder.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-thunder.dts
rename to arch/arm/boot/dts/ti/omap3-thunder.dts
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/ti/omap3-zoom3.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3-zoom3.dts
rename to arch/arm/boot/dts/ti/omap3-zoom3.dts
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/ti/omap3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3.dtsi
rename to arch/arm/boot/dts/ti/omap3.dtsi
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/ti/omap3430-sdp.dts
similarity index 100%
rename from arch/arm/boot/dts/omap3430-sdp.dts
rename to arch/arm/boot/dts/ti/omap3430-sdp.dts
diff --git a/arch/arm/boot/dts/omap3430es1-clocks.dtsi b/arch/arm/boot/dts/ti/omap3430es1-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3430es1-clocks.dtsi
rename to arch/arm/boot/dts/ti/omap3430es1-clocks.dtsi
diff --git a/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi b/arch/arm/boot/dts/ti/omap34xx-omap36xx-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
rename to arch/arm/boot/dts/ti/omap34xx-omap36xx-clocks.dtsi
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/ti/omap34xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap34xx.dtsi
rename to arch/arm/boot/dts/ti/omap34xx.dtsi
diff --git a/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi b/arch/arm/boot/dts/ti/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
rename to arch/arm/boot/dts/ti/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
diff --git a/arch/arm/boot/dts/omap36xx-clocks.dtsi b/arch/arm/boot/dts/ti/omap36xx-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap36xx-clocks.dtsi
rename to arch/arm/boot/dts/ti/omap36xx-clocks.dtsi
diff --git a/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi b/arch/arm/boot/dts/ti/omap36xx-omap3430es2plus-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
rename to arch/arm/boot/dts/ti/omap36xx-omap3430es2plus-clocks.dtsi
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/ti/omap36xx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap36xx.dtsi
rename to arch/arm/boot/dts/ti/omap36xx.dtsi
diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi b/arch/arm/boot/dts/ti/omap3xxx-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3xxx-clocks.dtsi
rename to arch/arm/boot/dts/ti/omap3xxx-clocks.dtsi
diff --git a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi b/arch/arm/boot/dts/ti/omap4-cpu-thermal.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap4-cpu-thermal.dtsi
rename to arch/arm/boot/dts/ti/omap4-cpu-thermal.dtsi
diff --git a/arch/arm/boot/dts/omap4-droid-bionic-xt875.dts b/arch/arm/boot/dts/ti/omap4-droid-bionic-xt875.dts
similarity index 100%
rename from arch/arm/boot/dts/omap4-droid-bionic-xt875.dts
rename to arch/arm/boot/dts/ti/omap4-droid-bionic-xt875.dts
diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/ti/omap4-droid4-xt894.dts
similarity index 100%
rename from arch/arm/boot/dts/omap4-droid4-xt894.dts
rename to arch/arm/boot/dts/ti/omap4-droid4-xt894.dts
diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/ti/omap4-duovero-parlor.dts
similarity index 100%
rename from arch/arm/boot/dts/omap4-duovero-parlor.dts
rename to arch/arm/boot/dts/ti/omap4-duovero-parlor.dts
diff --git a/arch/arm/boot/dts/omap4-duovero.dtsi b/arch/arm/boot/dts/ti/omap4-duovero.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap4-duovero.dtsi
rename to arch/arm/boot/dts/ti/omap4-duovero.dtsi
diff --git a/arch/arm/boot/dts/omap4-kc1.dts b/arch/arm/boot/dts/ti/omap4-kc1.dts
similarity index 100%
rename from arch/arm/boot/dts/omap4-kc1.dts
rename to arch/arm/boot/dts/ti/omap4-kc1.dts
diff --git a/arch/arm/boot/dts/omap4-l4-abe.dtsi b/arch/arm/boot/dts/ti/omap4-l4-abe.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap4-l4-abe.dtsi
rename to arch/arm/boot/dts/ti/omap4-l4-abe.dtsi
diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap4-l4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap4-l4.dtsi
rename to arch/arm/boot/dts/ti/omap4-l4.dtsi
diff --git a/arch/arm/boot/dts/omap4-mcpdm.dtsi b/arch/arm/boot/dts/ti/omap4-mcpdm.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap4-mcpdm.dtsi
rename to arch/arm/boot/dts/ti/omap4-mcpdm.dtsi
diff --git a/arch/arm/boot/dts/omap4-panda-a4.dts b/arch/arm/boot/dts/ti/omap4-panda-a4.dts
similarity index 100%
rename from arch/arm/boot/dts/omap4-panda-a4.dts
rename to arch/arm/boot/dts/ti/omap4-panda-a4.dts
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/ti/omap4-panda-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap4-panda-common.dtsi
rename to arch/arm/boot/dts/ti/omap4-panda-common.dtsi
diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/ti/omap4-panda-es.dts
similarity index 100%
rename from arch/arm/boot/dts/omap4-panda-es.dts
rename to arch/arm/boot/dts/ti/omap4-panda-es.dts
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/ti/omap4-panda.dts
similarity index 100%
rename from arch/arm/boot/dts/omap4-panda.dts
rename to arch/arm/boot/dts/ti/omap4-panda.dts
diff --git a/arch/arm/boot/dts/omap4-sdp-es23plus.dts b/arch/arm/boot/dts/ti/omap4-sdp-es23plus.dts
similarity index 100%
rename from arch/arm/boot/dts/omap4-sdp-es23plus.dts
rename to arch/arm/boot/dts/ti/omap4-sdp-es23plus.dts
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/ti/omap4-sdp.dts
similarity index 100%
rename from arch/arm/boot/dts/omap4-sdp.dts
rename to arch/arm/boot/dts/ti/omap4-sdp.dts
diff --git a/arch/arm/boot/dts/omap4-var-dvk-om44.dts b/arch/arm/boot/dts/ti/omap4-var-dvk-om44.dts
similarity index 100%
rename from arch/arm/boot/dts/omap4-var-dvk-om44.dts
rename to arch/arm/boot/dts/ti/omap4-var-dvk-om44.dts
diff --git a/arch/arm/boot/dts/omap4-var-om44customboard.dtsi b/arch/arm/boot/dts/ti/omap4-var-om44customboard.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap4-var-om44customboard.dtsi
rename to arch/arm/boot/dts/ti/omap4-var-om44customboard.dtsi
diff --git a/arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi b/arch/arm/boot/dts/ti/omap4-var-som-om44-wlan.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi
rename to arch/arm/boot/dts/ti/omap4-var-som-om44-wlan.dtsi
diff --git a/arch/arm/boot/dts/omap4-var-som-om44.dtsi b/arch/arm/boot/dts/ti/omap4-var-som-om44.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap4-var-som-om44.dtsi
rename to arch/arm/boot/dts/ti/omap4-var-som-om44.dtsi
diff --git a/arch/arm/boot/dts/omap4-var-stk-om44.dts b/arch/arm/boot/dts/ti/omap4-var-stk-om44.dts
similarity index 100%
rename from arch/arm/boot/dts/omap4-var-stk-om44.dts
rename to arch/arm/boot/dts/ti/omap4-var-stk-om44.dts
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/ti/omap4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap4.dtsi
rename to arch/arm/boot/dts/ti/omap4.dtsi
diff --git a/arch/arm/boot/dts/omap443x-clocks.dtsi b/arch/arm/boot/dts/ti/omap443x-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap443x-clocks.dtsi
rename to arch/arm/boot/dts/ti/omap443x-clocks.dtsi
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/ti/omap443x.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap443x.dtsi
rename to arch/arm/boot/dts/ti/omap443x.dtsi
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/ti/omap4460.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap4460.dtsi
rename to arch/arm/boot/dts/ti/omap4460.dtsi
diff --git a/arch/arm/boot/dts/omap446x-clocks.dtsi b/arch/arm/boot/dts/ti/omap446x-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap446x-clocks.dtsi
rename to arch/arm/boot/dts/ti/omap446x-clocks.dtsi
diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/ti/omap44xx-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap44xx-clocks.dtsi
rename to arch/arm/boot/dts/ti/omap44xx-clocks.dtsi
diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/ti/omap5-board-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap5-board-common.dtsi
rename to arch/arm/boot/dts/ti/omap5-board-common.dtsi
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/ti/omap5-cm-t54.dts
similarity index 100%
rename from arch/arm/boot/dts/omap5-cm-t54.dts
rename to arch/arm/boot/dts/ti/omap5-cm-t54.dts
diff --git a/arch/arm/boot/dts/omap5-core-thermal.dtsi b/arch/arm/boot/dts/ti/omap5-core-thermal.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap5-core-thermal.dtsi
rename to arch/arm/boot/dts/ti/omap5-core-thermal.dtsi
diff --git a/arch/arm/boot/dts/omap5-gpu-thermal.dtsi b/arch/arm/boot/dts/ti/omap5-gpu-thermal.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap5-gpu-thermal.dtsi
rename to arch/arm/boot/dts/ti/omap5-gpu-thermal.dtsi
diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/ti/omap5-igep0050.dts
similarity index 100%
rename from arch/arm/boot/dts/omap5-igep0050.dts
rename to arch/arm/boot/dts/ti/omap5-igep0050.dts
diff --git a/arch/arm/boot/dts/omap5-l4-abe.dtsi b/arch/arm/boot/dts/ti/omap5-l4-abe.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap5-l4-abe.dtsi
rename to arch/arm/boot/dts/ti/omap5-l4-abe.dtsi
diff --git a/arch/arm/boot/dts/omap5-l4.dtsi b/arch/arm/boot/dts/ti/omap5-l4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap5-l4.dtsi
rename to arch/arm/boot/dts/ti/omap5-l4.dtsi
diff --git a/arch/arm/boot/dts/omap5-sbc-t54.dts b/arch/arm/boot/dts/ti/omap5-sbc-t54.dts
similarity index 100%
rename from arch/arm/boot/dts/omap5-sbc-t54.dts
rename to arch/arm/boot/dts/ti/omap5-sbc-t54.dts
diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/ti/omap5-uevm.dts
similarity index 100%
rename from arch/arm/boot/dts/omap5-uevm.dts
rename to arch/arm/boot/dts/ti/omap5-uevm.dts
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/ti/omap5.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap5.dtsi
rename to arch/arm/boot/dts/ti/omap5.dtsi
diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/ti/omap54xx-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap54xx-clocks.dtsi
rename to arch/arm/boot/dts/ti/omap54xx-clocks.dtsi
diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/ti/twl4030.dtsi
similarity index 100%
rename from arch/arm/boot/dts/twl4030.dtsi
rename to arch/arm/boot/dts/ti/twl4030.dtsi
diff --git a/arch/arm/boot/dts/twl4030_omap3.dtsi b/arch/arm/boot/dts/ti/twl4030_omap3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/twl4030_omap3.dtsi
rename to arch/arm/boot/dts/ti/twl4030_omap3.dtsi
diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/ti/twl6030.dtsi
similarity index 100%
rename from arch/arm/boot/dts/twl6030.dtsi
rename to arch/arm/boot/dts/ti/twl6030.dtsi
diff --git a/arch/arm/boot/dts/twl6030_omap4.dtsi b/arch/arm/boot/dts/ti/twl6030_omap4.dtsi
similarity index 100%
rename from arch/arm/boot/dts/twl6030_omap4.dtsi
rename to arch/arm/boot/dts/ti/twl6030_omap4.dtsi
diff --git a/arch/arm/boot/dts/unisoc/Makefile b/arch/arm/boot/dts/unisoc/Makefile
new file mode 100644
index 000000000000..dba5cd874ee7
--- /dev/null
+++ b/arch/arm/boot/dts/unisoc/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_RDA) += \
+	rda8810pl-orangepi-2g-iot.dtb \
+	rda8810pl-orangepi-i96.dtb
diff --git a/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts b/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts
similarity index 100%
rename from arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
rename to arch/arm/boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts
diff --git a/arch/arm/boot/dts/rda8810pl-orangepi-i96.dts b/arch/arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts
similarity index 100%
rename from arch/arm/boot/dts/rda8810pl-orangepi-i96.dts
rename to arch/arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts
diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/rda8810pl.dtsi
rename to arch/arm/boot/dts/unisoc/rda8810pl.dtsi
diff --git a/arch/arm/boot/dts/vt8500/Makefile b/arch/arm/boot/dts/vt8500/Makefile
new file mode 100644
index 000000000000..255f4403af91
--- /dev/null
+++ b/arch/arm/boot/dts/vt8500/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_VT8500) += \
+	vt8500-bv07.dtb \
+	wm8505-ref.dtb \
+	wm8650-mid.dtb \
+	wm8750-apc8750.dtb \
+	wm8850-w70v2.dtb
diff --git a/arch/arm/boot/dts/vt8500-bv07.dts b/arch/arm/boot/dts/vt8500/vt8500-bv07.dts
similarity index 100%
rename from arch/arm/boot/dts/vt8500-bv07.dts
rename to arch/arm/boot/dts/vt8500/vt8500-bv07.dts
diff --git a/arch/arm/boot/dts/vt8500.dtsi b/arch/arm/boot/dts/vt8500/vt8500.dtsi
similarity index 100%
rename from arch/arm/boot/dts/vt8500.dtsi
rename to arch/arm/boot/dts/vt8500/vt8500.dtsi
diff --git a/arch/arm/boot/dts/wm8505-ref.dts b/arch/arm/boot/dts/vt8500/wm8505-ref.dts
similarity index 100%
rename from arch/arm/boot/dts/wm8505-ref.dts
rename to arch/arm/boot/dts/vt8500/wm8505-ref.dts
diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/vt8500/wm8505.dtsi
similarity index 100%
rename from arch/arm/boot/dts/wm8505.dtsi
rename to arch/arm/boot/dts/vt8500/wm8505.dtsi
diff --git a/arch/arm/boot/dts/wm8650-mid.dts b/arch/arm/boot/dts/vt8500/wm8650-mid.dts
similarity index 100%
rename from arch/arm/boot/dts/wm8650-mid.dts
rename to arch/arm/boot/dts/vt8500/wm8650-mid.dts
diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/vt8500/wm8650.dtsi
similarity index 100%
rename from arch/arm/boot/dts/wm8650.dtsi
rename to arch/arm/boot/dts/vt8500/wm8650.dtsi
diff --git a/arch/arm/boot/dts/wm8750-apc8750.dts b/arch/arm/boot/dts/vt8500/wm8750-apc8750.dts
similarity index 100%
rename from arch/arm/boot/dts/wm8750-apc8750.dts
rename to arch/arm/boot/dts/vt8500/wm8750-apc8750.dts
diff --git a/arch/arm/boot/dts/wm8750.dtsi b/arch/arm/boot/dts/vt8500/wm8750.dtsi
similarity index 100%
rename from arch/arm/boot/dts/wm8750.dtsi
rename to arch/arm/boot/dts/vt8500/wm8750.dtsi
diff --git a/arch/arm/boot/dts/wm8850-w70v2.dts b/arch/arm/boot/dts/vt8500/wm8850-w70v2.dts
similarity index 100%
rename from arch/arm/boot/dts/wm8850-w70v2.dts
rename to arch/arm/boot/dts/vt8500/wm8850-w70v2.dts
diff --git a/arch/arm/boot/dts/wm8850.dtsi b/arch/arm/boot/dts/vt8500/wm8850.dtsi
similarity index 100%
rename from arch/arm/boot/dts/wm8850.dtsi
rename to arch/arm/boot/dts/vt8500/wm8850.dtsi
diff --git a/arch/arm/boot/dts/xen/Makefile b/arch/arm/boot/dts/xen/Makefile
new file mode 100644
index 000000000000..26c50f138952
--- /dev/null
+++ b/arch/arm/boot/dts/xen/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_VIRT) += \
+	xenvm-4.2.dtb
diff --git a/arch/arm/boot/dts/xenvm-4.2.dts b/arch/arm/boot/dts/xen/xenvm-4.2.dts
similarity index 100%
rename from arch/arm/boot/dts/xenvm-4.2.dts
rename to arch/arm/boot/dts/xen/xenvm-4.2.dts
diff --git a/arch/arm/boot/dts/xilinx/Makefile b/arch/arm/boot/dts/xilinx/Makefile
new file mode 100644
index 000000000000..9233e539b192
--- /dev/null
+++ b/arch/arm/boot/dts/xilinx/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_ZYNQ) += \
+	zynq-cc108.dtb \
+	zynq-ebaz4205.dtb \
+	zynq-microzed.dtb \
+	zynq-parallella.dtb \
+	zynq-zc702.dtb \
+	zynq-zc706.dtb \
+	zynq-zc770-xm010.dtb \
+	zynq-zc770-xm011.dtb \
+	zynq-zc770-xm012.dtb \
+	zynq-zc770-xm013.dtb \
+	zynq-zed.dtb \
+	zynq-zturn.dtb \
+	zynq-zturn-v5.dtb \
+	zynq-zybo.dtb \
+	zynq-zybo-z7.dtb
diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
similarity index 100%
rename from arch/arm/boot/dts/zynq-7000.dtsi
rename to arch/arm/boot/dts/xilinx/zynq-7000.dtsi
diff --git a/arch/arm/boot/dts/zynq-cc108.dts b/arch/arm/boot/dts/xilinx/zynq-cc108.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-cc108.dts
rename to arch/arm/boot/dts/xilinx/zynq-cc108.dts
diff --git a/arch/arm/boot/dts/zynq-ebaz4205.dts b/arch/arm/boot/dts/xilinx/zynq-ebaz4205.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-ebaz4205.dts
rename to arch/arm/boot/dts/xilinx/zynq-ebaz4205.dts
diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/xilinx/zynq-microzed.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-microzed.dts
rename to arch/arm/boot/dts/xilinx/zynq-microzed.dts
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/xilinx/zynq-parallella.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-parallella.dts
rename to arch/arm/boot/dts/xilinx/zynq-parallella.dts
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-zc702.dts
rename to arch/arm/boot/dts/xilinx/zynq-zc702.dts
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/xilinx/zynq-zc706.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-zc706.dts
rename to arch/arm/boot/dts/xilinx/zynq-zc706.dts
diff --git a/arch/arm/boot/dts/zynq-zc770-xm010.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-zc770-xm010.dts
rename to arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts
diff --git a/arch/arm/boot/dts/zynq-zc770-xm011.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-zc770-xm011.dts
rename to arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts
diff --git a/arch/arm/boot/dts/zynq-zc770-xm012.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-zc770-xm012.dts
rename to arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts
diff --git a/arch/arm/boot/dts/zynq-zc770-xm013.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-zc770-xm013.dts
rename to arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/xilinx/zynq-zed.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-zed.dts
rename to arch/arm/boot/dts/xilinx/zynq-zed.dts
diff --git a/arch/arm/boot/dts/zynq-zturn-common.dtsi b/arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/zynq-zturn-common.dtsi
rename to arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi
diff --git a/arch/arm/boot/dts/zynq-zturn-v5.dts b/arch/arm/boot/dts/xilinx/zynq-zturn-v5.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-zturn-v5.dts
rename to arch/arm/boot/dts/xilinx/zynq-zturn-v5.dts
diff --git a/arch/arm/boot/dts/zynq-zturn.dts b/arch/arm/boot/dts/xilinx/zynq-zturn.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-zturn.dts
rename to arch/arm/boot/dts/xilinx/zynq-zturn.dts
diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-zybo-z7.dts
rename to arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/xilinx/zynq-zybo.dts
similarity index 100%
rename from arch/arm/boot/dts/zynq-zybo.dts
rename to arch/arm/boot/dts/xilinx/zynq-zybo.dts
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
index 8857a3791593..6406a29c85f2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
@@ -4,7 +4,7 @@
 /dts-v1/;
 #include "sun50i-h5.dtsi"
 #include "sun50i-h5-cpu-opp.dtsi"
-#include <arm/sunxi-bananapi-m2-plus-v1.2.dtsi>
+#include <arm/allwinner/sunxi-bananapi-m2-plus-v1.2.dtsi>
 
 / {
 	model = "Banana Pi BPI-M2-Plus v1.2 H5";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dts
index 77661006dfba..cfb943e9ae85 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dts
@@ -3,7 +3,7 @@
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
-#include <arm/sunxi-bananapi-m2-plus.dtsi>
+#include <arm/allwinner/sunxi-bananapi-m2-plus.dtsi>
 
 / {
 	model = "Banana Pi BPI-M2-Plus H5";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi
index fc570011495f..2f4b46746f47 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi
@@ -8,4 +8,4 @@
 /dts-v1/;
 
 #include "sun50i-h5.dtsi"
-#include <arm/sunxi-h3-h5-emlid-neutis.dtsi>
+#include <arm/allwinner/sunxi-h3-h5-emlid-neutis.dtsi>
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
index d811df332824..b79018c65cae 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
@@ -5,7 +5,7 @@
 /dts-v1/;
 #include "sun50i-h5.dtsi"
 #include "sun50i-h5-cpu-opp.dtsi"
-#include <arm/sunxi-libretech-all-h3-cc.dtsi>
+#include <arm/allwinner/sunxi-libretech-all-h3-cc.dtsi>
 
 / {
 	model = "Libre Computer Board ALL-H3-CC H5";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-it.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-it.dts
index e59d68b525fc..dc657de2a1a4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-it.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-it.dts
@@ -3,7 +3,7 @@
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
-#include <arm/sunxi-libretech-all-h3-it.dtsi>
+#include <arm/allwinner/sunxi-libretech-all-h3-it.dtsi>
 
 / {
 	model = "Libre Computer Board ALL-H3-IT H5";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index a56fae761a1f..d3caf27b6a55 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2016 ARM Ltd.
 
-#include <arm/sunxi-h3-h5.dtsi>
+#include <arm/allwinner/sunxi-h3-h5.dtsi>
 
 #include <dt-bindings/thermal/thermal.h>
 
diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
index 796cd7d02eb5..3554201e94d6 100644
--- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
+++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
@@ -13,7 +13,7 @@
 /dts-v1/;
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include "vexpress-v2m-rs1.dtsi"
+#include "arm/arm/vexpress-v2m-rs1.dtsi"
 
 / {
 	model = "V2F-1XV7 Cortex-A53x2 SMM";
diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts
index d24c53682e44..c7280bdefa8d 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts
@@ -1,2 +1,2 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "arm/bcm2711-rpi-4-b.dts"
+#include "arm/broadcom/bcm2711-rpi-4-b.dts"
diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dts b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dts
index b9000f58beb5..d9d2852b794f 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dts
@@ -1,2 +1,2 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "arm/bcm2711-rpi-400.dts"
+#include "arm/broadcom/bcm2711-rpi-400.dts"
diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
index e36d395e3951..8810322aa66a 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
@@ -1,2 +1,2 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "arm/bcm2711-rpi-cm4-io.dts"
+#include "arm/broadcom/bcm2711-rpi-cm4-io.dts"
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
index f0ec56a1c4d7..17d778a7e0c9 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
@@ -1,2 +1,2 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "arm/bcm2837-rpi-3-a-plus.dts"
+#include "arm/broadcom/bcm2837-rpi-3-a-plus.dts"
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts
index 46ad2023cccf..0cf6240b6bf0 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts
@@ -1,2 +1,2 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "arm/bcm2837-rpi-3-b-plus.dts"
+#include "arm/broadcom/bcm2837-rpi-3-b-plus.dts"
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
index 89b78d6c19bf..f429468fd86e 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -1,2 +1,2 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "arm/bcm2837-rpi-3-b.dts"
+#include "arm/broadcom/bcm2837-rpi-3-b.dts"
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
index b1c4ab212c64..3fa21bd16b49 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
@@ -1,2 +1,2 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "arm/bcm2837-rpi-cm3-io3.dts"
+#include "arm/broadcom/bcm2837-rpi-cm3-io3.dts"
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts
index 307ae693e4a0..363381a0cfb5 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts
@@ -1,2 +1,2 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "arm/bcm2837-rpi-zero-2-w.dts"
+#include "arm/broadcom/bcm2837-rpi-zero-2-w.dts"
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index b1fa68835b09..5ea8bda2bfa6 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -734,4 +734,4 @@ timer {
 };
 
 #include "exynos7-pinctrl.dtsi"
-#include "arm/exynos-syscon-restart.dtsi"
+#include "arm/samsung/exynos-syscon-restart.dtsi"
diff --git a/arch/arm64/boot/dts/exynos/exynos7885.dtsi b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
index 23c2e0bb0a2c..d69fc2392bd0 100644
--- a/arch/arm64/boot/dts/exynos/exynos7885.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
@@ -452,4 +452,4 @@ i2c_7: i2c@11cd0000 {
 };
 
 #include "exynos7885-pinctrl.dtsi"
-#include "arm/exynos-syscon-restart.dtsi"
+#include "arm/samsung/exynos-syscon-restart.dtsi"
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts b/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
index 369de5dc0ebd..c58fb7658d7a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
@@ -8,7 +8,7 @@
 /dts-v1/;
 #include "rk3399.dtsi"
 #include "rk3399-opp.dtsi"
-#include <arm/rockchip-radxa-dalang-carrier.dtsi>
+#include <arm/rockchip/rockchip-radxa-dalang-carrier.dtsi>
 #include "rk3399pro-vmarc-som.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi
index 9caabbb8bae3..3e1132204c7d 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi
@@ -1 +1 @@
-#include <arm/uniphier-pinctrl.dtsi>
+#include <arm/socionext/uniphier-pinctrl.dtsi>
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi
index e66d999d9f5d..8afbe5ce45f2 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi
@@ -1 +1 @@
-#include <arm/uniphier-ref-daughter.dtsi>
+#include <arm/socionext/uniphier-ref-daughter.dtsi>
diff --git a/arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi b/arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi
index 28c5b4ed1d95..6d0e3226a966 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi
@@ -1 +1 @@
-#include <arm/uniphier-support-card.dtsi>
+#include <arm/socionext/uniphier-support-card.dtsi>

-- 
2.39.2

