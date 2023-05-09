Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520816FBF4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbjEIGiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbjEIGiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:38:08 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD58693C1;
        Mon,  8 May 2023 23:38:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BC3DC804D;
        Tue,  9 May 2023 06:38:06 +0000 (UTC)
Date:   Tue, 9 May 2023 09:38:05 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Rob Herring <robh@kernel.org>, soc@kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
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
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
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
        Paul Barker <paul.barker@sancloud.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
Subject: Re: [PATCH 0/4] ARM: Move dts files to vendor sub-directories
Message-ID: <20230509063805.GY14287@atomide.com>
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
 <20230505224722.r73sbti6ugf76c66@mardi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505224722.r73sbti6ugf76c66@mardi>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [230505 22:47]:
> Tony,
> 
> On 22:29-20230504, Rob Herring wrote:
> > As discussed and attempted several times before[1][2], the flat arm32 
> > directory of 1553 platforms has grown unwieldy. Past attempts stalled 
> > out due to plans to move .dts files out of the kernel tree. Doing that 
> > is no longer planned (any time soon at least), so let's go ahead and 
> > group .dts files by vendors. This move aligns arm with arm64 .dts file 
> > structure.
> [...]
> 
> Wondering if it makes to have any sense of grouping per TI SoC arch? at
> least will be clear as to what is going on?
> 
> ti/omap2 or ti/omap ?
> 
> >     'am3' : 'ti',
> ^^ group  as ti/omap ?
> >     'am4' : 'ti',
> ^^ group  as ti/omap ?
> >     'am5' : 'ti',
> ^^ group  as ti/omap ?
> >     'dra' : 'ti',
> ^^ group  as ti/omap ?
> >     'keystone' : 'ti',
> ^^ group  as ti/keystone ?
> >     'omap' : 'ti',
> ^^ group  as ti/omap ?
> >     'compulab' : 'ti',
> ^^ group  as ti/omap ?
> >     'logicpd' : 'ti',
> ^^ group  as ti/omap ?
> >     'elpida' : 'ti',
> ^^ group  as ti/omap ?
> >     'motorola' : 'ti',
> ^^ group  as ti/omap ?
> >     'twl' : 'ti',
> ^^ group  as ti/omap ?
> >     'da' : 'ti',
> ^^ group  as ti/davinci ?
> >     'dm' : 'ti',
> ^^ group  as ti/davinci ?
> 
> For me at least, this cleanly seperates things up.

No objections from me to adding TI subdirectories. Rob, any issues with this?

Regards,

Tony
