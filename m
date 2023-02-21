Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AF169DA86
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 06:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjBUFyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 00:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjBUFyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 00:54:43 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D051F4AE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 21:54:41 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-536b7ffdd34so43880127b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 21:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKGj+xv4pnpjzxheaocCFzGNsSoHlHMPoKqxiA/28oQ=;
        b=Wrcoo/GSnOe5mCzRiZ6/3szvx5wT+s10fqZJCl6ef1q5s58EAtSKXNFdYZVZ5hMdsT
         S55cmjS6se6zJegcFZv6z2w25p9OswIkcQbd14OgUUCycmtT9MPtaIZWRk0We0ca7Vnx
         9h0zVR9Xf7lKY5K61k/A5oiOGsF4bDN0LLm1R+06e8ilN4DTwEKSbYaVAuaS1M25MlRB
         5lccXBWM3XyyFKaT8n3/WwYe24fejhnKy+Q0twGjdpfNQolxo5Strm/k0LPfjP1zifPj
         T34moa9882W6EJ20YpfC3WsoNlQ8Wc/HOI6rn2aYfaT5G2+xAcZALqE+eH6hH10tTLEB
         eoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKGj+xv4pnpjzxheaocCFzGNsSoHlHMPoKqxiA/28oQ=;
        b=YUzeT4GJNbdHjtY5ZWzxaqF7m6Ml2794e0iw/kW3cOxvWQl52pUx1x74gkJa7DA1o6
         q68/cIk/gGKmgmC93PHitIef6d0ve6+RhafHd+/YzQdPDwBkP1kiou44krfkO3PghzW1
         5pPjHeoQYMFSbYDtOVf00VprnOh1zj85UlN6HUl3QB/cB3bOUwddOr6fyYpb8a99QaWM
         Mo6vAfx/7neJ6ElNCEEIkdLD/hiOPJhcpKHs7CquM/GSCLl1HGXUvmVvTrfYuAaAicTI
         WuS5whbl8OFLi0mnzfKu4zuF3s4Rws0wC+6v+dXnk8OpPV7F/L/EGKdZoUghnpHe8Jjr
         DoDw==
X-Gm-Message-State: AO0yUKVWCJC6Qy2r1yPrN8kFd2GK2D9V+hzAO1TXuZ6M3eMo8mplRlaB
        gBixA80uqBF859i+cccxNw49PaStvGkfi2nEfyJlWQ==
X-Google-Smtp-Source: AK7set9MzBIUkg55oEqbfr3musYCTrXO/xQ5+x4ZGdYrY0pF1B2s0V7v0kWCjZ/rivtWol15XxWbTjtUWPZ6irbBh6Q=
X-Received: by 2002:a81:b723:0:b0:536:38b4:f50 with SMTP id
 v35-20020a81b723000000b0053638b40f50mr350484ywh.1.1676958880647; Mon, 20 Feb
 2023 21:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20230130093229.27489-1-nylon.chen@sifive.com> <20230130093229.27489-3-nylon.chen@sifive.com>
 <20230130101707.pdvabl3na2wpwxqu@pengutronix.de> <CAHh=Yk85NHbm9eUKLm75GUP4gSP5eYFjVabTUXseyB6wHD4D=Q@mail.gmail.com>
In-Reply-To: <CAHh=Yk85NHbm9eUKLm75GUP4gSP5eYFjVabTUXseyB6wHD4D=Q@mail.gmail.com>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Tue, 21 Feb 2023 13:54:29 +0800
Message-ID: <CAHh=Yk-ejA5W=G2Z7L3pVZzUt6DCF+6moJSc4rg0OQWO2fLXZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: sifive: change the PWM controlled LED algorithm
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     aou@eecs.berkeley.edu, conor@kernel.org,
        emil.renner.berthing@canonical.com, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, nylon7717@gmail.com,
        zong.li@sifive.com, greentime.hu@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

Nylon Chen <nylon.chen@sifive.com> =E6=96=BC 2023=E5=B9=B42=E6=9C=883=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:06=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Uwe,
>
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2023=E5=
=B9=B41=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:17=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >
> > On Mon, Jan 30, 2023 at 05:32:29PM +0800, Nylon Chen wrote:
> > > The `frac` variable represents the pulse inactive time, and the resul=
t of
> > > this algorithm is the pulse active time. Therefore, we must reverse t=
he
> > > result.
> > >
> > > The reference is SiFive FU740-C000 Manual[0].
> > >
> > > [0]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86e=
d8b16acba_fu740-c000-manual-v1p6.pdf
> > >
> > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > ---
> > >  drivers/pwm/pwm-sifive.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > index 62b6acc6373d..a5eda165d071 100644
> > > --- a/drivers/pwm/pwm-sifive.c
> > > +++ b/drivers/pwm/pwm-sifive.c
> > > @@ -158,6 +158,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > >       frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> > >       /* The hardware cannot generate a 100% duty cycle */
> > >       frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > > +     frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
> >
> > The same problem exists in pwm_sifive_get_state(), doesn't it?
> >
> > As fixing this is an interruptive change anyhow, this is the opportunit=
y
> > to align the driver to the rules tested by PWM_DEBUG.
> >
> > The problems I see in the driver (only checked quickly, so I might be
> > wrong):
> >
>
> >  - state->period !=3D ddata->approx_period isn't necessarily a problem.=
 If
> >    state->period > ddata->real_period that's fine and the driver should
> >    continue
> >
> >  - frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> >    is wrong for two reasons:
> >    it should round down and use the real period.
I have some results from my observations regarding the questions you raised=
.

I don't know if what we are thinking is the same thing.

If my assumptions are different from yours, please let me know. Thanks.
> are you mean state->period is a redundancy variable so we can use
> ddata->real_period directly?
>
> it seems reasonable, but I don't get your point, why do we need to
> change the algorithm to DIV_ROUND_DOWN_ULL() and change the if-else
> condition.
>
> frac =3D DIV_ROUND_DOWN_ULL(num, ddata->real_period);
> if (state->period < ddata->approx_period) {
>     ...
> }
>
> >
> > Best regards
> > Uwe
> >
> > --
> > Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
> > Industrial Linux Solutions                 | https://www.pengutronix.de=
/ |
