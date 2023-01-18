Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04707672059
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjARO5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjARO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:57:35 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3935638039
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:53:24 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hw16so71990646ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stZtAhmuNpwwNr+Q894m8k3WKh9stUMtdjvWGZCxIHo=;
        b=gMIaZ3BgtMrjudzAxsdaMJEgFE4F9gzWsZ1Yg5Xs9B0YV57CZWNK1/tM+ECj0CcKEd
         xIuekHOqdSaVJlEZnnRWUwaH1iUk1ApyvsCUsQQXCGD2B4NQI9afHBgmp1wCwexCngOt
         zzX/DRCOZlNNUG4j4wQVTNCWbz25KgX8Vytb7DWsJeRsJnmBbyIEOQbsX9towt1QVbRI
         YBI7zXGE9epoTzVPz7ce3Eel4B3wP3NPdaa1RUeWh4axIjSsnEszLvmCuPKmBQ+5xbF1
         Yv+ZBWZMREChJCcVzSRJSmn+Rub06XXL3yUlgpZyKmilLtCpt+TUt1DP6Nh4KcbukFdd
         obZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stZtAhmuNpwwNr+Q894m8k3WKh9stUMtdjvWGZCxIHo=;
        b=N9OvvP+aBEWgqIuRTluPj4Y9Z83YLDoY68QYcoQPQlTOj2i6v/eBpXJ8AgZjFJ+895
         pTuP+FKwDdSXNtLvssWwiV0ore0WevVpY0QpyPpE93cdJBcwGALA9cVg+tWp2b1wQNTA
         H4OrvM7pG1682Edkkd4LdVcdDjbmMmCsmy1VaPrXWXFd9WhdAr9hunTp+5amcU+731RM
         CwW/kGTLpjqVHNv/XwO7FrCDjC0WE8NkSeqQalVU1s2Ti+vKgtEzVb5xbJ2Zmd/SUs7v
         9ua5CSHjMCRHZBi7XRDecThd+nh2qrbrDD7CwaLd0SLrlSg6ISV6E0ATHZ5Hfc+wEfX6
         ufQw==
X-Gm-Message-State: AFqh2koxYf5QCUbzmD2SHuusdTUw6ikC4rZxnBJIdCSO1DJZUkLToqU2
        QxI4/Jz/SE5W3p7HJ4vyXm4BJ5Fyd0Xk28t35kv3UQ==
X-Google-Smtp-Source: AMrXdXsy2xOVzKPF0BPi56xPXa3Dor+FMxBaDAcYFF6uykQ8n333+Ht+vnPUlk+XgfFvmMKAR3q9fU8or89lfSRfdyU=
X-Received: by 2002:a17:906:4a99:b0:86f:3748:a4ef with SMTP id
 x25-20020a1709064a9900b0086f3748a4efmr874161eju.462.1674053602831; Wed, 18
 Jan 2023 06:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20230112152855.216072-1-bchihi@baylibre.com> <20230112152855.216072-5-bchihi@baylibre.com>
 <feab4ff4-b874-aa10-2031-ad6b84cbc004@collabora.com> <CAGuA+ooxTf-j957gQ1zRe2-+u2kphaaLGvTDi1=kit5Q3bKOxA@mail.gmail.com>
 <71e5c68a-dbc7-caac-d6d4-5a8cd5b20d5e@linaro.org>
In-Reply-To: <71e5c68a-dbc7-caac-d6d4-5a8cd5b20d5e@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 18 Jan 2023 15:52:46 +0100
Message-ID: <CAGuA+oqQt_qZpep_77j=wCS_CuXTVz9mHYdT91+NP96JP8UKLQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] thermal/drivers/mediatek: Add the Low Voltage
 Thermal Sensor driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Jan 18, 2023 at 3:30 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Balsam,
>
> On 18/01/2023 14:58, Balsam CHIHI wrote:
>
> [ ... ]
>
> >> You're describing the register with nice words, but there's another wa=
y to do
> >> the same that will be even more effective.
> >>
> >> /*
> >>    * LVTS MONINT: Interrupt Monitoring register
> >>    * Each bit describes the enable status of per-sensor interrupts.
> >>    */
> >> #define LVTS_MONINT_THRES_COLD  BIT(0)  /* Cold threshold */
> >> #define LVTS_MONINT_THRES_HOT   BIT(1)  /* Hot threshold */
> >> #define LVTS_MONINT_OFFST_LOW   BIT(2)  /* Low offset */
> >> #define LVTS_MONINT_OFFST_HIGH  BIT(3)  /* High offset */
> >> #define LVTS_MONINT_OFFST_NTH   BIT(4)  /* Normal To Hot */
> >> #define EVERYTHING_ELSE ........................
> >>
> >> #define LVTS_MONINT_SNS0_MASK   GENMASK( ... )
> >> #define LVTS_MONINT_SNS1_MASK   GENMASK .....
> >>
> >> /* Find a better name for this one */
> >> #define LVTS_MONINT_EN_IRQS     ( LVTS_MONINT_THRES_COLD | LVTS_MONINT=
_THRES_HOT |
> >>                                    LVTS_MONINT_OFFST_LOW ..... etc etc=
)
> >>
> >
> > Given the complexity of the controller and the number of registers,
> > if we create a define per bits, we will end up with a huge list of
> > defines (~300).
>
> Yeah, that is too much for a little gain.
>
> However, a few can be added for the interrupt only.
>
> Instead of LVTS_MONINT_THRES ..., it could be LVTS_INT_THRES_... and
> reused for LVTS_MONINTSTS and LVTS_MONINT setup as the bits position are
> the same?
>

OK, I will add a few for the interrupts.

> [ ... ]
>
>
> >>> +static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl =
*lvts_ctrl)
> >>> +{
> >>> +     u32 period_unit =3D (118 * 1000) / (256 * 38);
> >>
> >> #define SOMETHING       118
> >> #define SOMETHING_ELSE  1000
> >> #define ....
> >>
> >> const u32 period_unit =3D (SOMETHING * SOMETHING_ELSE) / ....
> >>
> >
> > Constifying "u32 period_unit" generates the following compilation warni=
ng :
> > ./include/asm-generic/io.h:273:61: note: expected =E2=80=98volatile voi=
d *=E2=80=99
> > but argument is of type =E2=80=98const void *=E2=80=99
> >    273 | static inline void writel(u32 value, volatile void __iomem *ad=
dr)
> >        |                                      ~~~~~~~~~~~~~~~~~~~~~~~^~=
~~
>
> That is strange. period_unit is the 'value', not the 'addr'. Are you
> sure about the warning?

I double-checked and you are right.
The warning is not related to "const u32 period_unit".
It is related to the previous one, which is "const void __iomem *lvts_edata=
".
And this is the full log :

drivers/thermal/mediatek/lvts_thermal.c: In function =E2=80=98lvts_ctrl_cal=
ibrate=E2=80=99:
drivers/thermal/mediatek/lvts_thermal.c:835:47: warning: passing
argument 2 of =E2=80=98writel=E2=80=99 discards =E2=80=98const=E2=80=99 qua=
lifier from pointer target
type [-Wdiscarded-qualifiers]
  835 |   writel(lvts_ctrl->calibration[i], lvts_edata[i]);
      |                                     ~~~~~~~~~~^~~
In file included from ./arch/arm64/include/asm/io.h:163,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/arm64/include/asm/hardirq.h:17,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from drivers/thermal/mediatek/lvts_thermal.c:12:
./include/asm-generic/io.h:273:61: note: expected =E2=80=98volatile void *=
=E2=80=99
but argument is of type =E2=80=98const void *=E2=80=99
  273 | static inline void writel(u32 value, volatile void __iomem *addr)
      |                                      ~~~~~~~~~~~~~~~~~~~~~~~^~~~

>
>
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

Best regards,
Balsam
