Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067986E57BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjDRDMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDRDMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:12:35 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D55A19A6;
        Mon, 17 Apr 2023 20:12:31 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-187af4a5453so74374fac.1;
        Mon, 17 Apr 2023 20:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681787550; x=1684379550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyMICzqEPh881keWpGBUJhcP7rNs3w+hjFrTTX9+thg=;
        b=lnExo9C8YOma27x0A9RIBxOCXq0tuc/oLdHkU/XdY8/4Do5WIt+345CVo4cirOTGT3
         wHHRgfk3tiXC+VESiIYTWTXs+Lf1N3OecU0eqBUox6V1OLddsyBgY/PhdhMmGX3ProI2
         49Rx9YZwXoLAVxyTPnRRbL5sCVPzUn4KAKUCzzNiWwdMPR5cmdJVHVaRw5BoNcDYJ1a1
         O54nRMunRFGA1q7BzckT1aKaJgya/tloQrvMH4qgg8iFiUD9OqV0L0NBUke7uyDnujNO
         zL7rduevUYUun+Un1/mCFO0PpOcm8RURm51/hbupbQ/eW+GjssLf+kih3NBDscs+UEdR
         PoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681787550; x=1684379550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyMICzqEPh881keWpGBUJhcP7rNs3w+hjFrTTX9+thg=;
        b=SFHcntPmx3sJbn74BGf9N90KjrGBtVGw1kA4Yl7WZ6O3Wiv6xJZ5KVuTK8s+nX7n6v
         FfqKVAYhXGE1dPndG0ihw9D+vBdeUrrstl6pg8Nkd+dkTeahdduBfgs8y7sSh69dGmdW
         qwoI/H0gY7trwlSGnQ2c0EH8AHo9NaiTvlPPOFMfevyrwoiIWD7LOJffFm/ZDrs/TR2w
         uYyxXbiHj1xsBIXZOfKBayYvFD6s36UqYTLtyCuAWKwFmYrBNFLLLiQU8w9EloEsV30+
         9vxZaAA60BH3TbpF5OVCCVQazw1bJb0NEHRjQF+nmN0++/yV2+iICHgR6O/jthpUFcrI
         MBkg==
X-Gm-Message-State: AAQBX9dru2SZGbS9uA1+W9+HcHXbtMM+vM1nBQAtudILZU52GGflMjb3
        su8RSPwirTDvm1gq8fsB+/mtfXecJqrEoPEh9Kg=
X-Google-Smtp-Source: AKy350YC5E48AhcCIuEaJ6C1+64009rudG8FF13cHI878xSMDBgbZYRub6IbwsCf0FMgQBT1VWmikkxTIe8gAlt358Q=
X-Received: by 2002:a05:6870:c106:b0:17e:8a64:3dab with SMTP id
 f6-20020a056870c10600b0017e8a643dabmr371587oad.0.1681787550577; Mon, 17 Apr
 2023 20:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
 <20230321050034.1431379-3-sergio.paracuellos@gmail.com> <2d848bc03aacb41a708ba2794eb043ff.sboyd@kernel.org>
 <CAMhs-H9+ZthzCvqssypG8a2xKF4KFnvgz4ZfTKn6wE=ZxV29hQ@mail.gmail.com> <0c8891233195166d4a1b3cd858e91445.sboyd@kernel.org>
In-Reply-To: <0c8891233195166d4a1b3cd858e91445.sboyd@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 18 Apr 2023 05:12:19 +0200
Message-ID: <CAMhs-H93559ExKxF4NDk=SJnb-tN2YX7W-=wZnGDvUkb=qpu6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 2:50=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Sergio Paracuellos (2023-04-13 22:49:47)
> > On Thu, Apr 13, 2023 at 8:55=E2=80=AFPM Stephen Boyd <sboyd@kernel.org>=
 wrote:
> > >
> > > Quoting Sergio Paracuellos (2023-03-20 22:00:27)
> > > > diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/c=
lk-mtmips.c
> > > > new file mode 100644
> > > > index 000000000000..6b4b5ae9384d
> > > > --- /dev/null
> > > > +++ b/drivers/clk/ralink/clk-mtmips.c
> > > > @@ -0,0 +1,985 @@
> [...]
> > >
> > > > +               .name =3D _name,                                  \
> > > > +               .ops =3D &(const struct clk_ops) {                \
> > >
> > > Make this into a named variable? Otherwise I suspect the compiler wil=
l
> > > want to duplicate it.
> >
> > I am not sure if I understand this. What do you mean exactly?
>
>         static const struct clk_ops mtmips_periph_clk_ops =3D {
>                 .recalc_rate =3D mtmips_pherip_clk_rate,
>         };
>

Ah, I see. Thanks. It is clear now.

> > > > +static unsigned long rt3352_bus_recalc_rate(struct clk_hw *hw,
> > > > +                                           unsigned long parent_ra=
te)
> > > > +{
> > > > +       return parent_rate / 3;
> > > > +}
> > > > +
> > > > +static unsigned long rt305x_xtal_recalc_rate(struct clk_hw *hw,
> > > > +                                            unsigned long parent_r=
ate)
> > > > +{
> > > > +       return 40000000;
> > > > +}
> > >
> > > Register fixed factor and fixed rate clks in software instead of
> > > duplicating the code here.
> >
> > All the macros used in current code rely on the fact of having recalc
> > functions so we can maintain the code shorter just using them. Is
> > there a real benefit of using a fixed factor and fixed clks here?
> > If possible I can avoid the duplicate here just using the same
> > recalc_rate function returning the fixed stuff for both 305x and 3352
> > SoCs as I am also doing for other functions.
>
> The real benefit is less code, smaller kernel size, less maintenance
> over time.

Understood. Will change to use fixed and factor clocks then.

>
> > >
> > > > +       }
> > > > +}
> > > > +
> > > > +static unsigned long rt2880_cpu_recalc_rate(struct clk_hw *hw,
> > > > +                                           unsigned long xtal_clk)
> > > > +{
> > > > +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> > > > +       struct regmap *sysc =3D clk->priv->sysc;
> > > > +       u32 t;
> > > > +
> > > > +       regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
> > > > +       t =3D (t >> RT2880_CONFIG_CPUCLK_SHIFT) & RT2880_CONFIG_CPU=
CLK_MASK;
> > > > +
> > > > +       switch (t) {
> > > > +       case RT2880_CONFIG_CPUCLK_250:
> > > > +               return 250000000;
> > > > +       case RT2880_CONFIG_CPUCLK_266:
> > > > +               return 266000000;
> > > > +       case RT2880_CONFIG_CPUCLK_280:
> > > > +               return 280000000;
> > > > +       case RT2880_CONFIG_CPUCLK_300:
> > > > +               return 300000000;
> > > > +       default:
> > > > +               BUG();
> > > > +       }
> > > > +}
> > > > +
> > > > +static unsigned long rt2880_bus_recalc_rate(struct clk_hw *hw,
> > > > +                                           unsigned long parent_ra=
te)
> > > > +{
> > > > +       return parent_rate / 2;
> > > > +}
> > >
> > > A fixed factor clk?
> >
> > As I have said, macros rely on having recalc_rate functions. Also,
> > having in this way makes pretty clear the relation between the bus
> > clock and its related parent as it is in the datasheet.
>
> The macros are your own design, right? In which case, maybe you can use
> CLK_HW_INIT() and friends macros instead to show the relationship
> between clks in C code?

I'll take a look at those macros also and will take them into account, than=
ks.

>
> >
> > >
> > > > +
> > > > +static u32 mt7620_calc_rate(u32 ref_rate, u32 mul, u32 div)
> > > > +{
> > > > +       u64 t;
> > > > +
> > > > +       t =3D ref_rate;
> > > > +       t *=3D mul;
> > > > +       do_div(t, div);
> > >
> > > Do we really need to do 64-bit math? At the least use div_u64().
> >
> > This is directly extracted from arch/mips/ralink clock code, so I have
> > maintained it as it is since I don't have an mt7620 SoC based board to
> > test. However using div_u64 here with t being u64 makes sense.
>
> Does anyone have the board to test? Can we simply delete it instead?

I have mt7628 and rt5350 based boards where I am testing these
changes. However I don't have mt7620 which is the one needed for this
particular code.
These SoCs are commonly used in the openWRT community so we cannot
delete this code. I will use div_u64 for the next version which makes
sense. If someone complains about something wrong with the change at
some time we can just change it again in the future.

>
> > > > +
> > > > +static unsigned long mt7620_bus_recalc_rate(struct clk_hw *hw,
> > > > +                                           unsigned long parent_ra=
te)
> > > > +{
> > > > +       static const u32 ocp_dividers[16] =3D {
> > > > +               [CPU_SYS_CLKCFG_OCP_RATIO_2] =3D 2,
> > > > +               [CPU_SYS_CLKCFG_OCP_RATIO_3] =3D 3,
> > > > +               [CPU_SYS_CLKCFG_OCP_RATIO_4] =3D 4,
> > > > +               [CPU_SYS_CLKCFG_OCP_RATIO_5] =3D 5,
> > > > +               [CPU_SYS_CLKCFG_OCP_RATIO_10] =3D 10,
> > > > +       };
> > > > +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> > > > +       struct regmap *sysc =3D clk->priv->sysc;
> > > > +       u32 t;
> > > > +       u32 ocp_ratio;
> > > > +       u32 div;
> > > > +
> > > > +       if (IS_ENABLED(CONFIG_USB)) {
> > > > +               /*
> > > > +               * When the CPU goes into sleep mode, the BUS
> > > > +               * clock will be too low for USB to function properl=
y.
> > > > +               * Adjust the busses fractional divider to fix this
> > > > +               */
> > > > +               regmap_read(sysc, SYSC_REG_CPU_SYS_CLKCFG, &t);
> > > > +               t &=3D ~(CLKCFG_FDIV_MASK | CLKCFG_FFRAC_MASK);
> > > > +               t |=3D CLKCFG_FDIV_USB_VAL | CLKCFG_FFRAC_USB_VAL;
> > > > +               regmap_write(sysc, SYSC_REG_CPU_SYS_CLKCFG, t);
> > >
> > > Why can't we do this unconditionally? And recalc_rate() shouldn't be
> > > writing registers. It should be calculating the frequency of the clk
> > > based on 'parent_rate' and whatever the hardware is configured for.
> >
> > This code is with IS_ENABLED(CONFIG_USB) guard in the original code so
> > I have maintained it as it is. Where should it be moved into instead
> > of doing the register writes in this recalc function?
>
> Can you do it unconditionally in driver probe? Or when the clk is turned
> off or on can you park it at a safe frequency?

Sure, thanks.

I'll address all your comments and send v3, shortly.

Thanks,
    Sergio Paracuellos
