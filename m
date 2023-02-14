Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FDF695DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjBNIyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjBNIye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:54:34 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C0310C6;
        Tue, 14 Feb 2023 00:54:28 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-16cc1e43244so13940035fac.12;
        Tue, 14 Feb 2023 00:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pueULkZNsSYV2BuLPBKbMoOTC9E/T55I4iigXjiEFCc=;
        b=Dq0Ig+QdokN2aqfT/MTds+TZni0bgVptdHol0RV83nyTG3c5ZBNfu1VhE4IDikEtJj
         oqDcjbVRvgOTjpTJKJjbanHMIoSbc0ltcmGgg4aCG7CD2Srgxx5/n7meASvcP94j52Tp
         suU278yJkNjv1g0nZeSWrQMpkVTdb+Lp5EKBIe4pI95LljPLVR9c6idfDz9qJsglzkxg
         sxgbF6XOtggOtVFTHMtmKuBg/yO+8ycRDo31uX3GyTdgUm0IVZlC5W/rLqqo/ayLIRSK
         0ZAJsM65lr0RXoZn2y4mcNLBVt1bqGRfjCTCs3OnM9rvyXUhMU3U53MwH/07IhnxrnGD
         4Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pueULkZNsSYV2BuLPBKbMoOTC9E/T55I4iigXjiEFCc=;
        b=XuUY2CIrAQqbk231J9S0unuG/e297hmCz74crOT03NpVmrt+Sttcxa31Ef9WuNJEAL
         14u6OZmaDTdgycoExdUfjKZO2cQsCB4DHv4Dn6EtaafkKQeiUzX7TvjOyP0Mk+gvJA5C
         f9RXM8R7w8IV8QelHcLbZVCMRw3ekZen0j3uyIEJE82xz9HZ/Nq/qjJSioNVXjjkjlLo
         dc8eckyVeWM3O2CAhTU8mJNWe85KwccXAqaD3f2d6PiWeU7CLbvuYeXRVc+G9YZe8+IE
         Y/CFgwfcNhui37iCcqLvTdMhPwLWmKQ34F3k3TlMcRw7a+AOzMUO2GvJpWzQIF1Hv/+J
         a86g==
X-Gm-Message-State: AO0yUKVUbLolJApBmoy9zulLbhCQUeu8sEsupZywqZ93ZdiR22xG8X5C
        9fVaFjbEodqU1nvSGkZMGi31tpVfurdlnw2cbB0=
X-Google-Smtp-Source: AK7set9mg8lqW/k3T969DcfFf8YbX9+B5yjVtMmLh3QRRopkI1n5Lo2OmuVe6LxlyoH7fI2QEOClB+KFGxH1zS2XrGg=
X-Received: by 2002:a05:6870:73ca:b0:16e:21e0:1f44 with SMTP id
 a10-20020a05687073ca00b0016e21e01f44mr118272oan.144.1676364867692; Tue, 14
 Feb 2023 00:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20230213200519.889503-1-sergio.paracuellos@gmail.com>
 <20230213200519.889503-4-sergio.paracuellos@gmail.com> <f105c7a8-8821-1e7b-af46-13a46971db63@linaro.org>
In-Reply-To: <f105c7a8-8821-1e7b-af46-13a46971db63@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 14 Feb 2023 09:54:16 +0100
Message-ID: <CAMhs-H_Cd9F+UWWe+dAA89r_huX_srtsgjh1qus93nGehQN1AQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] watchdog: mt7621-wdt: avoid ralink architecture
 dependent code
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
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

On Tue, Feb 14, 2023 at 9:31 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/02/2023 21:05, Sergio Paracuellos wrote:
> > MT7621 SoC has a system controller node. Watchdog need to access to reset
> > status register. Ralink architecture and related driver are old and from
> > the beggining they are using some architecture dependent operations for
> > accessing this shared registers through 'asm/mach-ralink/ralink_regs.h'
> > header file. However this is not ideal from a driver perspective which can
> > just access to the system controller registers in an arch independent way
> > using regmap syscon APIs. Update Kconfig accordingly to select new added
> > dependencies and allow driver to be compile tested.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/watchdog/Kconfig      |  4 +++-
> >  drivers/watchdog/mt7621_wdt.c | 18 +++++++++++++-----
> >  2 files changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index b64bc49c7..cf752ad64 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -1865,7 +1865,9 @@ config GXP_WATCHDOG
> >  config MT7621_WDT
> >       tristate "Mediatek SoC watchdog"
> >       select WATCHDOG_CORE
> > -     depends on SOC_MT7620 || SOC_MT7621
> > +     select REGMAP_MMIO
> > +     select MFD_SYSCON
> > +     depends on SOC_MT7620 || SOC_MT7621 || COMPILE_TEST
> >       help
> >         Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
> >
> > diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> > index 40fb2c9ba..22e979bdd 100644
> > --- a/drivers/watchdog/mt7621_wdt.c
> > +++ b/drivers/watchdog/mt7621_wdt.c
> > @@ -15,8 +15,8 @@
> >  #include <linux/moduleparam.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/mod_devicetable.h>
> > -
> > -#include <asm/mach-ralink/ralink_regs.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
> >
> >  #define SYSC_RSTSTAT                 0x38
> >  #define WDT_RST_CAUSE                        BIT(1)
> > @@ -34,6 +34,7 @@
> >  struct mt7621_wdt_data {
> >       void __iomem *base;
> >       struct reset_control *rst;
> > +     struct regmap *sysc;
> >       struct watchdog_device wdt;
> >  };
> >
> > @@ -104,9 +105,12 @@ static int mt7621_wdt_stop(struct watchdog_device *w)
> >       return 0;
> >  }
> >
> > -static int mt7621_wdt_bootcause(void)
> > +static int mt7621_wdt_bootcause(struct mt7621_wdt_data *d)
> >  {
> > -     if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE)
> > +     u32 val;
> > +
> > +     regmap_read(d->sysc, SYSC_RSTSTAT, &val);
> > +     if (val & WDT_RST_CAUSE)
> >               return WDIOF_CARDRESET;
> >
> >       return 0;
> > @@ -143,6 +147,10 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
> >       if (!drvdata)
> >               return -ENOMEM;
> >
> > +     drvdata->sysc = syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
> > +     if (IS_ERR(drvdata->sysc))
> > +             return PTR_ERR(drvdata->sysc);
>
> This should be the backup/error path for original code using syscon
> property. Looking up by compatible is really not portable/re-usable.

I can change the code in the way you are pointing out here but...
Why is it not re-usable? Compatible is not supposed to be changed
since in other cases the DTB ABI will be broken. I am totally lost
about what is an ABI breakage, then.

Thanks in advance for clarification.

Best regards,
    Sergio Paracuellos

>
> Best regards,
> Krzysztof
>
