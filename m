Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ECB600AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiJQJfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiJQJfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:35:36 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6175BC23
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:35:30 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id v81so5055237vkv.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E/piL+Cl5bNZ+cdgdtRq8tdPhqA168X72rjKGIcj1h4=;
        b=frJwpnQ1m5aYZphVeeBe7Gk3obDQDvbUlm04wfHh9QiSL/PMF9tB/Oqsh+0kEGhfNO
         IO0xDniqeVyzfdD+JQ/zRq4D21vh7ik7Um8ee3cn8CBCOToSaQ1ZGpd/a2Gve9yyVF34
         ITfWo51grHozApCr0PrB6Bwe0SOYlzp6onCsTl/dTI9MCc6vgY4Nu541uAo++YYBs5A4
         a0vKPtblJ4z5wLnNbmGOx+MINPdJQQEqi1diMlwjfz7XnWKZTtJr/JKwgIM6sTm2WKvz
         GFI/MxIIypmMB3ZgmlItW4/UaPbdgeUgb5Ga5LgkDThgRnOzk/BQFLxn/5jf7fmdM9uK
         /Naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/piL+Cl5bNZ+cdgdtRq8tdPhqA168X72rjKGIcj1h4=;
        b=iqD0547dVlhBnTsH27GXfeDflaN3bDp8MZiig2PG3Ho4MacRnMazLIv8qH3s4gvXAo
         27sPxD1qHqlNFIT/tNLu2WHDTlwUKJN80ENQt9EadCljnNZnUcw09w29OVMdjuAFHviv
         ECMpf3w9/1vaeMCrmeRC6nJ8on1vMdTHdRcJY3kB+m1pj/TUBLzHKLgx9hTfZApwao/X
         9KievV+lc3TTVUX/T9yUX3tLap34qDF14k0EAV2N6SkoAfmXW9fsOqfLIoiEIn8QEPj0
         mqqJE8j7c5fCNDO0EsaQNJP593Dr81LBS7wpy0V4b/sq4tttRZtRQ88G4fzWd1NGcEbi
         tcsw==
X-Gm-Message-State: ACrzQf0h4qcAcJjTejJe/+NAbg8U36gZw5AI3cKRrAvn2oWf1kpUiJ14
        U9dNoAp0IQDy2etrKP6OtwnkhnabmjtHsUEODwnZzw==
X-Google-Smtp-Source: AMsMyM6Q6nrL8lOCi83NdWMY6wKW/FytxI2676zCB6+Z2xX8cVC67C12vEdkRnmssQAcscBm4uxHwhyfQkZ6/acn8wI=
X-Received: by 2002:a1f:4843:0:b0:3ae:c4a3:d653 with SMTP id
 v64-20020a1f4843000000b003aec4a3d653mr3536302vka.1.1665999328063; Mon, 17 Oct
 2022 02:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-2-andriy.shevchenko@linux.intel.com> <CACRpkdbdzFR-a_xh8EjLMAshTeesOYhD3-_Bkc=vi7iK72ZKtA@mail.gmail.com>
In-Reply-To: <CACRpkdbdzFR-a_xh8EjLMAshTeesOYhD3-_Bkc=vi7iK72ZKtA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 17 Oct 2022 11:35:16 +0200
Message-ID: <CAMRc=MexjuQw+hUDDfCVxiBEJ573jNb3Ko9SyOU-xJ03wOe8cQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/36] gpiolib: tegra186: Add missed header(s)
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Kent Gibson <warthog618@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-omap@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:52 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Oct 10, 2022 at 10:15 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>
> > Do not imply that some of the generic headers may be always included.
> > Instead, include explicitly what we are direct user of.
> >
> > While at it, sort headers alphabetically.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

Andy: are you going to send it together with the corresponding pinctrl
changes in a separate PR?

Bart
