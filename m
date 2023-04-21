Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E8D6EA3A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjDUGRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDUGQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:16:42 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7D483C9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 23:16:39 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b8f51500a82so1567563276.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 23:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1682057799; x=1684649799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5ffUiM3M7NTUSgdHiwJ5XZXqrjEjLlNt36O7ostYWk=;
        b=JB6iEZoqs5uLEzGwULGqVV4cERqxyNBtzx7gNRZ1bSE1KMivgF0Fn7pTjSfSLh/v5x
         ted6xSS2RGuVwdR0XrqxiNV0nDm6TMXe3iJ0XOJLlbPJ2NXmlZS27pE4/gGcUkjGHDGR
         yCclIpmnbAqom8URegkT3f/ZPV21ZZ1UnnWNkiWN9wauicAbh/xE4DI9Nye5YfNfRoif
         c7VUtVEq1235OLz58UjZCGOlLrm6ftcAdTh6ilMsacMV9Z57NY9IgE9vWzpvmr0oQvMW
         4/SWqvQKDnZmENVsZhwQ619HlrLODLmsOOGbxOWlV9gYmvuLvG/HhqSOOSmMWyKQhsHV
         J2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682057799; x=1684649799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5ffUiM3M7NTUSgdHiwJ5XZXqrjEjLlNt36O7ostYWk=;
        b=j4Y7mlJcQMQLxX7ja9qxxD0e9AB2swqxieR1t68E+BLd88XZaQym2aakosnXodSXld
         Kh0uuZEjnLB6KkUxkdtibmz5hEzQMJjlDqtZ8ZV45sl6to6iqTdUGrj7ZhTX2A3fOPu7
         2G/EWQXeOW69EY3JubgjbcbssReOJshwcMp2OGhNwQA88N7iPENdBcqQgW9B91rx4OwI
         eEpN7eL0q+0pB02ndGygtW0CaMWCyFErcWxAmKxYItdwrRPJ3dVnTgyi3PpCXNLbtXC9
         Ls8T0gV2xmtJWoa1gZJjcOqqF/WygSO1LDGlLcvfoC61sIR+V8q25DP10ahrGQcEhk6J
         6PzA==
X-Gm-Message-State: AAQBX9cFcMZ9lTc5J20DKry3S6lAQGcEosCIWKq7hPNRwuNIuv3YnwvG
        ssEkPers4jvlOiT5Cuk6m/KXKQwtaDt3SURlwlYvbQ==
X-Google-Smtp-Source: AKy350ZexKT0FdkSUu7TV2c7ttWACVFUUKWEIojp3MuZ+qD5tK1QUFURvuyY/kflECcD05OtJMczaJGwujJYMNpQTZ0=
X-Received: by 2002:a25:245:0:b0:b92:2a33:c00 with SMTP id 66-20020a250245000000b00b922a330c00mr1663080ybc.24.1682057798787;
 Thu, 20 Apr 2023 23:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230420093457.18936-1-nylon.chen@sifive.com> <20230420093457.18936-3-nylon.chen@sifive.com>
 <CAJM55Z-smXpgL+QyTSeAWt=B-RS_qtbrFZtJpP-cQS0gsQnDSw@mail.gmail.com>
 <CAHh=Yk86AV542Y7wG6rkHTc4va1Gof3uXtj84zzK5m+khL_Aiw@mail.gmail.com> <CAJM55Z9TPVyJyWwWAS2FznSc8FvnR7qMxQ412eMzBkD=5abp6g@mail.gmail.com>
In-Reply-To: <CAJM55Z9TPVyJyWwWAS2FznSc8FvnR7qMxQ412eMzBkD=5abp6g@mail.gmail.com>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Fri, 21 Apr 2023 14:16:20 +0800
Message-ID: <CAHh=Yk9mBDtFM4TRKEknNgrMN9qK4XtmPWLAT2E2P3RHwVh6ww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: sifive: change the PWM controlled LED algorithm
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     aou@eecs.berkeley.edu, conor@kernel.org, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

Emil Renner Berthing <emil.renner.berthing@canonical.com> =E6=96=BC 2023=E5=
=B9=B44=E6=9C=8820=E6=97=A5
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:46=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, 20 Apr 2023 at 12:41, Nylon Chen <nylon.chen@sifive.com> wrote:
> >
> > Hi, Emil
> >
> > Emil Renner Berthing <emil.renner.berthing@canonical.com> =E6=96=BC 202=
3=E5=B9=B44=E6=9C=8820=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:04=
=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Thu, 20 Apr 2023 at 11:35, Nylon Chen <nylon.chen@sifive.com> wrot=
e:
> > > >
> > > > The `frac` variable represents the pulse inactive time, and the res=
ult of
> > > > this algorithm is the pulse active time. Therefore, we must reverse=
 the
> > > > result.
> > > >
> > > > The reference is SiFive FU740-C000 Manual[0]
> > > >
> > > > Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-=
86ed8b16acba_fu740-c000-manual-v1p6.pdf [0]
> > > >
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > > > ---
> > > >  drivers/pwm/pwm-sifive.c | 9 ++++++---
> > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > > index 393a4b97fc19..d5d5f36da297 100644
> > > > --- a/drivers/pwm/pwm-sifive.c
> > > > +++ b/drivers/pwm/pwm-sifive.c
> > > > @@ -132,13 +132,13 @@ static int pwm_sifive_apply(struct pwm_chip *=
chip, struct pwm_device *pwm,
> > > >  {
> > > >         struct pwm_sifive_ddata *ddata =3D pwm_sifive_chip_to_ddata=
(chip);
> > > >         struct pwm_state cur_state;
> > > > -       unsigned int duty_cycle;
> > > > +       unsigned int duty_cycle, period;
> > > >         unsigned long long num;
> > > >         bool enabled;
> > > >         int ret =3D 0;
> > > >         u32 frac;
> > > >
> > > > -       if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > > > +       if (state->polarity !=3D PWM_POLARITY_NORMAL && state->pola=
rity !=3D PWM_POLARITY_INVERSED)
> > > >                 return -EINVAL;
> > > >
> > > >         cur_state =3D pwm->state;
> > > > @@ -154,10 +154,13 @@ static int pwm_sifive_apply(struct pwm_chip *=
chip, struct pwm_device *pwm,
> > > >          * calculating the register values first and then writing t=
hem
> > > >          * consecutively
> > > >          */
> > > > +       period =3D max(state->period, ddata->approx_period);
> > >
> > > Hi Nylon,
> > >
> > > I don't understand this patch. You introduce this new variable,
> > > period, and set it here but you never seem to use it. If you planned
> > > to use it instead of state->period below, why should it be the max of
> > > the old period and what is requested? What happens if the consumer
> > > wants to lower the period?
> > Sorry this was an oversight on my part, there was a line correction tha=
t didn't change to
> > - frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> > + frac =3D DIV64_U64_ROUND_CLOSEST(num, period);
>
> I see, so then my second question was why period needs to be the
> larger of the previous period and the requested period.
>
> What happens if the requested period, state->period, is lower than the
> old period, ddata->approx_period? Then the period will be changed to
> state->period below, but the calculations will be made using period =3D
> ddata->approx_period, right?

Your understanding is correct. According to the new algorithm proposed
by Uwe, the goal is to:
Pick the biggest period length possible that is not bigger than the
requested period.
>
> > >
> > > Also above you now allow both PWM_POLARITY_NORMAL and
> > > PWM_POLARITY_INVERSED but you treat both cases the same.
> > I may have misunderstood what Uwe means here, I will confirm again here
> > >
> > > /Emil
> > >
> > > >         num =3D (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
> > > >         frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> > > > -       /* The hardware cannot generate a 100% duty cycle */
> > > >         frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > > > +       /* The hardware cannot generate a 100% duty cycle */
> > > > +       frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
> > > > +
> > > >
> > > >         mutex_lock(&ddata->lock);
> > > >         if (state->period !=3D ddata->approx_period) {
> > > > --
> > > > 2.40.0
> > > >
