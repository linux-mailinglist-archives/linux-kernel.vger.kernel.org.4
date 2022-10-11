Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F3E5FAE05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJKIG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJKIGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:06:22 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8DF7B1C2;
        Tue, 11 Oct 2022 01:06:21 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id l19so8500789qvu.4;
        Tue, 11 Oct 2022 01:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jGyomjq7ozY4Q7akXL/Pfyv8X5Aj6pujM8b1a5l18ro=;
        b=KOtVn1MyCyveoDiOyhPS4b+kccEhBn5uycP8wq1nxcQaoVO7ujP/OY5Ywr26ZnhCam
         JtV49vXZAkHxc9fQhnFZ0yR5qa3H1k6BdicVcmNeApeNekWkjySS1eI7a345vma1iB5u
         m0hpdgw4rj+ZcUPoYHTwGBEZDDkn60NhzkSfKSFxnPmncP0SZs0DSM0BTPcBCa0Y7kT+
         OJDRY26vA+5llcDmHVjT/wbShwFCBj2+8IX1jMumA781Wi5bVtrpUwScLhBWATEJPXxO
         rA3UjsbwHJCPXoxP8zsPzOmD/iX/cV77mwqa0OtltmMedasLu6ChGyGJ30OpeSGXY/hO
         eF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGyomjq7ozY4Q7akXL/Pfyv8X5Aj6pujM8b1a5l18ro=;
        b=nPSuSXRPqu5GYxEaW5cFqX9dhA1QTkluyDMAJ+ydHs8EY4zaGuI6S/FLUQAzOF5PW4
         zceSPTvenAPY21/FAOpcleWjj1zAC68zk0pQW8fWf9xlFE8vVY9nH3bpYlCSEg+QtR0K
         lvB9L+xQJu6xZS/mM+coQQ6DrQmB8z8RUx4toAcVApjpLeFZbt3kvaRZKYKbMdwVB5gI
         4BxYCV43p6ze2WTOVdcr4Xa6+7EMkFDDtLqpS/MFfqPzQzS9C/Dv0U917pbU1qTLbeRp
         eaHEfy3i9tgyNOOnKEGmnpZq2ilZOu67pH2SbyS4n/bLqZTRd2doobKxEuJXyTmJaO+E
         PUAg==
X-Gm-Message-State: ACrzQf0ykC4WTQBViC+c/Bds/87EObaELNmxUVXZdQY/u65BDLB9rVLj
        FFacF9A5N0aPTCQPmUDYu0d8OBYp9+QKIGYHG4E=
X-Google-Smtp-Source: AMsMyM6bBfvn1Kn2m3jyePvTWTQZr99mPqgEF96ov5+b6DzzOQAB1TTkjSwFdYjW5mK99JzXiScvlDmHriUb73Md/f4=
X-Received: by 2002:a05:6214:29ee:b0:4b1:c1d2:6635 with SMTP id
 jv14-20020a05621429ee00b004b1c1d26635mr18081815qvb.82.1665475580262; Tue, 11
 Oct 2022 01:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-3-andriy.shevchenko@linux.intel.com> <Y0SyVwjDl7NGfTPn@sol>
In-Reply-To: <Y0SyVwjDl7NGfTPn@sol>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Oct 2022 11:05:42 +0300
Message-ID: <CAHp75Vf4oS8g0zxgismtLrzsJ7AE-bdMEq+GAzx2=Mwnhuk3UA@mail.gmail.com>
Subject: Re: [PATCH v2 02/36] gpiolib: cdev: Add missed header(s)
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 3:02 AM Kent Gibson <warthog618@gmail.com> wrote:
> On Mon, Oct 10, 2022 at 11:14:18PM +0300, Andy Shevchenko wrote:

...

> > -#include <linux/gpio.h>
> >  #include <linux/gpio/driver.h>
> > +#include <linux/gpio.h>
> > +#include <linux/hte.h>
>
> Ok with the hte re-order.
>
> But moving the gpio subsystem header after the gpio/driver is not
> alphabetical ('.' precedes '/') and it read better and made more sense
> to me the way it was.

I see, I guess this is vim sort vs shell sort. Strange, they should
follow the locale settings...

...

> > +#include <linux/seq_file.h>
>
> I wasn't aware that we use anything from seq_file.
> What am I missing?

I will recheck, because in v6.0 I don't see anything, but LKP was not
okay with something IIRC.




--
With Best Regards,
Andy Shevchenko
