Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFDC5FAE7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJKIcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJKIcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:32:12 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F55F83208
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 01:32:08 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 193243F478
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1665477124;
        bh=suNkJ2gh7pPN1oyqI64kbmW+brydF4+SF1qphpgiy1g=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=aPyhwyUhof08K59k2INiJLYrTZs3FuqI/4r9+rrrELPoibnX95Milw66H/tKVUbLV
         KSqUAryeJ26HtSIGxpGTEetw3nM19iJEUlwASIggSybd9wVWANV1RTtTcYj/iGto1F
         KjsuXWu8xsCfS6pDYM2yIWLSeJ5ufBtjGbQMQNiOO7HCEqNlpV4aEGU1Q2i2koILMG
         C+ZT0W3NmMVt7LAXILGGzRfpRATFvyT3Y/rivdcNwz/umLLrdnGas8prnI1JxpBlpG
         iT+MmEDJXvOBudgxtbJ6q8ZqXl9ZggO3pDSBdnIeDuwUqfwxEdGbDnvE1R26hZlDot
         fdXAgi41kFOyg==
Received: by mail-qt1-f197.google.com with SMTP id ff14-20020a05622a4d8e00b00394aaf0f653so8270919qtb.19
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 01:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suNkJ2gh7pPN1oyqI64kbmW+brydF4+SF1qphpgiy1g=;
        b=q9VEgGV6IrHNvERIkB4ajxfrM/h2f60ANNcL237PQknAiW+9I7qrUHSnltXGORst3l
         TjwHzIYJxlxuDEPkyQcMoKg1JMbtEPNncXXrYvPXm613x4ab9Zf/CNbt4cx+B/o6cTbI
         4h0ylWusaqG3Q4tSuIc83IJa2UbH+erGyfCPZ+zFz23D1p65mPkZUsg2ch7q4AnrlMCQ
         b/GKktQXj54QXebyMweyBs8I6w3T4bz4/1sqDX+/BxOQUd6v9zk9lnGRm/Upe7ttH4pv
         YtwArjNrepN/teeYQRPov0GN0lTf01uk7fGr7L8plEy88bkG5Q3qdRNsInvF3Vwgolfi
         QBNA==
X-Gm-Message-State: ACrzQf1ZYH5j2iSNWKrfnX8ThwmABdoDIq12/zaeaLZKxGXro5BNbkH8
        sYoAdvmdTeZKXUatJGgYJjxOulAbAcm0o7jOxgtkriU4JEk+1HXYup7qSx755DVLX7kYIuGajcF
        WlLyxjcoCzmm5lo5nmna68fYuZY2nK+XYT0frUqE8RsDiX8yCoO+trplLRA==
X-Received: by 2002:a05:620a:410f:b0:6cf:c34b:3c64 with SMTP id j15-20020a05620a410f00b006cfc34b3c64mr15570226qko.52.1665477109280;
        Tue, 11 Oct 2022 01:31:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7DFTDHgNX/wrj8IAoSXEmta8ySJnv0knkcfflaxkZri8xCwukQw9Ji8irmUndHqkaXm0MlF8+pHua64xb11kk=
X-Received: by 2002:a05:620a:410f:b0:6cf:c34b:3c64 with SMTP id
 j15-20020a05620a410f00b006cfc34b3c64mr15570191qko.52.1665477109055; Tue, 11
 Oct 2022 01:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com> <20221010201453.77401-26-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221010201453.77401-26-andriy.shevchenko@linux.intel.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 11 Oct 2022 10:31:33 +0200
Message-ID: <CAJM55Z_ApPowttZrjn_0dUs81H4FfByDfv=fbhvmHquipULANg@mail.gmail.com>
Subject: Re: [PATCH v2 25/36] pinctrl: starfive: Add missed header(s)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 at 22:26, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Do not imply that some of the generic headers may be always included.
> Instead, include explicitly what we are direct user of.
>
> While at it, sort headers alphabetically.

The patch is fine, but I don't see any sorting other than just adding
the headers at the appropriate place.
In any case

Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> index 5b544fb7f3d8..6a8a9cfe8965 100644
> --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> @@ -15,8 +15,10 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
> +#include <linux/seq_file.h>
>  #include <linux/spinlock.h>
>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
>
> --
> 2.35.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
