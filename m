Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205825FAEC5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJKIwi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Oct 2022 04:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJKIwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:52:36 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446275F116;
        Tue, 11 Oct 2022 01:52:35 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id r11-20020a4aa2cb000000b004806f49e27eso3501386ool.7;
        Tue, 11 Oct 2022 01:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RG7je/SPkrUeGbyJflxBun3+ZBOYqWehWXWhY9Ywba0=;
        b=iD1ZS6OfBtk8sON3hsIjwM5uucYcNqhbUYzlsYWMSN052gwEQU+g6IX2cu1rCA4rki
         LdnfXQvS4Yuh1Dwm8d5fJEHs7cg0LSIH2DWCskY+Al4sUQ23r+Lgx0Qjv+kOIuNkOzj+
         0Xeie9z6ihm46L/7IbyjfD+zA+7Ggr3UaZ2HzPrz1Z6T4QJ6Ok2oLbMLF56vQUphH2Z3
         d8fjvst2WC2aluZOCwPT2pau2VT2e74QTP7iJGRAzAkUg5Ixkzsbq9V/0tSEHI1ldlol
         zLm6izgcvgSyQ36sBjutweV8fpbPZr7KIQeKK616rJ+/Sh7MVS32wYWuqI6rMqa8bdsd
         zlUg==
X-Gm-Message-State: ACrzQf2vS9fHJMJukozh8wJPvRG0sGt89aBIKH0qW5Ko1fmMeFkB6ERy
        L8qNGH5DQQJw5sCTYjvqmiFBA8ZrksGds8eJ
X-Google-Smtp-Source: AMsMyM7J2caHP7QYUnJnqsFi15536ODGqoMlJSTPiNnqPM9M5dbTNI6xrKViv6uj1K5PJJ/YxCzhGw==
X-Received: by 2002:a4a:dbcd:0:b0:47f:9f26:3569 with SMTP id t13-20020a4adbcd000000b0047f9f263569mr8747611oou.19.1665478354431;
        Tue, 11 Oct 2022 01:52:34 -0700 (PDT)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id r21-20020a056870439500b0012796e8033dsm6199722oah.57.2022.10.11.01.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 01:52:34 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id s125-20020a4a5183000000b0047fbaf2fcbcso7454574ooa.11;
        Tue, 11 Oct 2022 01:52:34 -0700 (PDT)
X-Received: by 2002:a0d:de43:0:b0:349:31bd:e8d5 with SMTP id
 h64-20020a0dde43000000b0034931bde8d5mr20151543ywe.283.1665478004869; Tue, 11
 Oct 2022 01:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-37-andriy.shevchenko@linux.intel.com> <d63088d7-202b-a550-01e5-345a22de5f7d@amd.com>
In-Reply-To: <d63088d7-202b-a550-01e5-345a22de5f7d@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Oct 2022 10:46:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUfdQnisexfs4yLjeKs-LUPY1HjChrgeNjNL1qSErir9Q@mail.gmail.com>
Message-ID: <CAMuHMdUfdQnisexfs4yLjeKs-LUPY1HjChrgeNjNL1qSErir9Q@mail.gmail.com>
Subject: Re: [PATCH v2 36/36] pinctrl: Clean up headers
To:     Basavaraj Natikar <bnatikar@amd.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 9:31 AM Basavaraj Natikar <bnatikar@amd.com> wrote:
> On 10/11/2022 1:44 AM, Andy Shevchenko wrote:
> > There is a few things done:
> > - include only the headers we are direct user of
> > - when pointer is in use, provide a forward declaration
> > - add missed headers
> > - group generic headers and subsystem headers
> > - sort each group alphabetically
> >
> > While at it, fix some awkward indentations.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/pinctrl/core.c                  | 19 ++++++++-------
> >  drivers/pinctrl/core.h                  | 12 +++++++++-
> >  drivers/pinctrl/devicetree.h            |  6 +++++
> >  drivers/pinctrl/pinconf.h               | 10 ++++++++
> >  drivers/pinctrl/pinctrl-utils.h         |  5 ++++
> >  drivers/pinctrl/pinmux.c                | 17 ++++++++------
> >  drivers/pinctrl/pinmux.h                | 11 +++++++++
> >  include/linux/pinctrl/consumer.h        | 31 +++++++++++--------------
> >  include/linux/pinctrl/devinfo.h         |  6 +++--
> >  include/linux/pinctrl/machine.h         |  8 ++++---
> >  include/linux/pinctrl/pinconf-generic.h | 23 ++++++++++--------
> >  include/linux/pinctrl/pinctrl.h         | 18 +++++++-------
> >  include/linux/pinctrl/pinmux.h          |  5 ++--
> >  13 files changed, 110 insertions(+), 61 deletions(-)
> >
> > diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
> > index 9e57f4c62e60..655f9502e73f 100644
> > --- a/drivers/pinctrl/core.c
> > +++ b/drivers/pinctrl/core.c
> > @@ -12,19 +12,21 @@
> >   */
> >  #define pr_fmt(fmt) "pinctrl core: " fmt
> >
> > -#include <linux/kernel.h>
> > -#include <linux/kref.h>
> > -#include <linux/export.h>
> > -#include <linux/init.h>
> > +#include <linux/debugfs.h>
> >  #include <linux/device.h>
> > -#include <linux/slab.h>
> >  #include <linux/err.h>
> > +#include <linux/export.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kref.h>
> >  #include <linux/list.h>
> > -#include <linux/debugfs.h>
> >  #include <linux/seq_file.h>
> > +#include <linux/slab.h>
> > +
> >  #include <linux/pinctrl/consumer.h>
> > -#include <linux/pinctrl/pinctrl.h>
> > +#include <linux/pinctrl/devinfo.h>
> >  #include <linux/pinctrl/machine.h>
> > +#include <linux/pinctrl/pinctrl.h>
> >
> >  #ifdef CONFIG_GPIOLIB
> >  #include "../gpio/gpiolib.h"
> > @@ -33,9 +35,8 @@
> >
> >  #include "core.h"
> >  #include "devicetree.h"
> > -#include "pinmux.h"
> >  #include "pinconf.h"
> > -
> > +#include "pinmux.h"
> >
> >  static bool pinctrl_dummy_state;
> >
> > diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
> > index 840103c40c14..4d0bdb9fb99b 100644
> > --- a/drivers/pinctrl/core.h
> > +++ b/drivers/pinctrl/core.h
> > @@ -9,12 +9,22 @@
> >   */
> >
> >  #include <linux/kref.h>
> > +#include <linux/list.h>
> >  #include <linux/mutex.h>
> >  #include <linux/radix-tree.h>
> > -#include <linux/pinctrl/pinconf.h>
>
> Removing pinconf.h from the core.h may cause build failure in other files
> because where-ever core.h is included to use “struct pinconf_ops”, there
> is a need to include pinconf.h.

I can confirm adding

    #include <linux/pinctrl/pinconf.h>

to drivers/pinctrl/renesas/pinctrl-rzn1.c and drivers/pinctrl/pinctrl-single.c
fixes the issues I was seeing with shmobile_defconfig and (out-of-tree)
renesas_defconfig.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
