Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1143F62C68A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiKPRlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiKPRla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:41:30 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE5ED137
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:41:28 -0800 (PST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C9BD93F0C8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668620484;
        bh=xz4EiCr6ZuWL/U16EFiHXOXw+kW3GS1JYc7thj3Y4eY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=KiflCoESWWPSb8CVCL5927nohGvNoBsYXI+fmmVmlYmQ2rwwriIKt28WpF+/NPh9H
         iLs5YkwBgMZ/VlEOudSbrZeUdV5UqY+ghva7GEVNRVyjO8m1ASLeCwo6Sam36B3DKG
         r8CDkUURvDF649Hx23KXceeq0PL4GbcF3rK08NAnZsJE7+5Zx5cYlOJFWmAAluQdoq
         7TuYfV6j3qHxAvRf01V6RYnbAHkqSCwpRfuJGXCZwJEn0drLXm3F8upOnJNE7s1My0
         3cPXHyK4bVtNCSvCs9Zv05CLEDPMxlSYUFyFEW+wODVvWnkUvfvFAo4kS8/AsYgl4x
         NXmVrSpuPvSxg==
Received: by mail-yb1-f198.google.com with SMTP id s77-20020a257750000000b006e5e383ec68so1807997ybc.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xz4EiCr6ZuWL/U16EFiHXOXw+kW3GS1JYc7thj3Y4eY=;
        b=acZGTSoyKJU3XIwKOZJij8dETVfAiFOerzbriJmUjpvCioucBpscPxIwCCf4fzL5FG
         Hrrsb2tQZiXPdzYoYerYzxcKx1KtJ1g/QOEIwyHE0mDP1TmaeEExaXHwFgWmNw5Bl5L1
         zBUejVezJWDNGjs9BESFquX0dvnrU0mfvNakMEe0N436rOKormT5P7fhHPFdzTtAL1pe
         wBhuzYkrPCQnvqgRuEY4nmhSwk796NAcfxnoUHevliUzoDYw5orNsP/LDFXeDNxpiC9B
         hVrLclWwndt2xEcA3f59y18WflPV5GS88ThfLqwKpUm/G2C6FVIa0qMAA6qBDiEVk3sN
         pa5g==
X-Gm-Message-State: ANoB5pmIhLwLcbzgW1DHVobtTkGdSpgrl6nRf5iJNPGnl5SoHbNLUj2G
        IYZSOtCiYgZM2TXSSP9uAJLVGsITqKJtjKH4l3euQLI6vDyiBagjYvqMaW+EbIXvIilvX80V25I
        LvX7nXMVOt3OQE1yLdCW5T6DKK6oNCnEKebbvIyBfPEHbv7psBgK55o5O5Q==
X-Received: by 2002:a0d:d78c:0:b0:357:94cb:7a8 with SMTP id z134-20020a0dd78c000000b0035794cb07a8mr22043896ywd.326.1668620482724;
        Wed, 16 Nov 2022 09:41:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4WVbP7g9iQI9RHRyPHivBQ4DhEh1eC80B9tJcCzYio/ZUwo5VpBylCewZZWyJBrgUqUhtOBDp0n5rmefHi9+M=
X-Received: by 2002:a0d:d78c:0:b0:357:94cb:7a8 with SMTP id
 z134-20020a0dd78c000000b0035794cb07a8mr22043875ywd.326.1668620482437; Wed, 16
 Nov 2022 09:41:22 -0800 (PST)
MIME-Version: 1.0
References: <20221109113724.519021-1-emil.renner.berthing@canonical.com>
 <20221109120102.ylnseq2w33rvt7fz@pengutronix.de> <CAJM55Z-EVXB6FTWwh_vY_B3LoVv+b7TCQCE7asB8G8wkEwui_g@mail.gmail.com>
 <20221109153311.cszr7fgfmyelwra3@pengutronix.de>
In-Reply-To: <20221109153311.cszr7fgfmyelwra3@pengutronix.de>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 16 Nov 2022 18:41:06 +0100
Message-ID: <CAJM55Z8vpJ0XtQqnsFMLE4rkyV11ePbNjtYx0u4pgM9-MT=Kvg@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: sifive: Always let the first pwm_apply_state succeed
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022 at 16:33, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Wed, Nov 09, 2022 at 01:45:43PM +0100, Emil Renner Berthing wrote:
> > On Wed, 9 Nov 2022 at 13:01, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > Hello Emil,
> > >
> > > On Wed, Nov 09, 2022 at 12:37:24PM +0100, Emil Renner Berthing wrote:
> > > > Commit 2cfe9bbec56ea579135cdd92409fff371841904f added support for t=
he
> > > > RGB and green PWM controlled LEDs on the HiFive Unmatched board
> > > > managed by the leds-pwm-multicolor and leds-pwm drivers respectivel=
y.
> > > > All three colours of the RGB LED and the green LED run from differe=
nt
> > > > lines of the same PWM, but with the same period so this works fine =
when
> > > > the LED drivers are loaded one after the other.
> > > >
> > > > Unfortunately it does expose a race in the PWM driver when both LED
> > > > drivers are loaded at roughly the same time. Here is an example:
> > > >
> > > >   |          Thread A           |          Thread B           |
> > > >   |  led_pwm_mc_probe           |  led_pwm_probe              |
> > > >   |    devm_fwnode_pwm_get      |                             |
> > > >   |      pwm_sifive_request     |                             |
> > > >   |        ddata->user_count++  |                             |
> > > >   |                             |    devm_fwnode_pwm_get      |
> > > >   |                             |      pwm_sifive_request     |
> > > >   |                             |        ddata->user_count++  |
> > > >   |         ...                 |          ...                |
> > > >   |    pwm_state_apply          |    pwm_state_apply          |
> > > >   |      pwm_sifive_apply       |      pwm_sifive_apply       |
> > > >
> > > > Now both calls to pwm_sifive_apply will see that ddata->approx_peri=
od,
> > > > initially 0, is different from the requested period and the clock n=
eeds
> > > > to be updated. But since ddata->user_count >=3D 2 both calls will f=
ail
> > > > with -EBUSY, which will then cause both LED drivers to fail to prob=
e.
> > > >
> > > > Fix it by letting the first call to pwm_sifive_apply update the clo=
ck
> > > > even when ddata->user_count !=3D 1.
> > > >
> > > > Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM"=
)
> > > > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical=
.com>
> > > > ---
> > > >  drivers/pwm/pwm-sifive.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > > index 2d4fa5e5fdd4..b3c60ec72a6e 100644
> > > > --- a/drivers/pwm/pwm-sifive.c
> > > > +++ b/drivers/pwm/pwm-sifive.c
> > > > @@ -159,7 +159,13 @@ static int pwm_sifive_apply(struct pwm_chip *c=
hip, struct pwm_device *pwm,
> > > >
> > > >       mutex_lock(&ddata->lock);
> > > >       if (state->period !=3D ddata->approx_period) {
> > > > -             if (ddata->user_count !=3D 1) {
> > > > +             /*
> > > > +              * Don't let a 2nd user change the period underneath =
the 1st user.
> > > > +              * However if ddate->approx_period =3D=3D 0 this is t=
he first time we set
> > > > +              * any period, so let whoever gets here first set the=
 period so other
> > > > +              * users who agree on the period won't fail.
> > > > +              */
> > > > +             if (ddata->user_count !=3D 1 && ddata->approx_period)=
 {
> > >
> > > While I'm convinced this works, we'd get some more uniform behaviour
> > > compared to other hardwares with similar restrictions if you lock the
> > > period on enabling the PWM instead of at request time. See for exampl=
e
> > > drivers/pwm/pwm-pca9685.c.
> >
> > Hmm.. that driver uses a pwms_enabled bitmap rather than a user count,
> > but it still sets the bit in the request method and refuses to change
> > period in the apply method if more than 1 bit is set.
>
> Note there are two different bitmaps. The one modified in .request is
> for gpio stuff and the other in .apply() for locking the common period
> length.

Yeah, there is the pwms_enabled and pwms_inuse bitmaps, but
pwms_enabled is used both in .request and .apply.

> > So as far as I
> > can tell it still suffers from the same race. However using a bitmap
> > instead of a user count would let us handle everything in the apply
> > method if we don't set the bit in the request method, but then the
> > behaviour would still be different. In any case it would still be a
> > large change to this driver.
> >
> > How about we merge this bug fix that can easily be backported first
> > and then look at how it should be handled properly?
>
> I thought it wouldn't be that hard to do it right from the start,
> but I admit it's harder than I expected to get right. My prototype looks
> as follows:

This works for me (modulo the two extra {'s). I'd still prefer merging
the simpler version and then this on top for ease of backporting, but
as long as the race is fixed I'm fine. Will you send a cleaned up
version of this?

/Emil

> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index 2d4fa5e5fdd4..89846d95bfc0 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -41,13 +41,13 @@
>
>  struct pwm_sifive_ddata {
>         struct pwm_chip chip;
> -       struct mutex lock; /* lock to protect user_count and approx_perio=
d */
> +       struct mutex lock; /* lock to protect approx_period */
>         struct notifier_block notifier;
>         struct clk *clk;
>         void __iomem *regs;
>         unsigned int real_period;
>         unsigned int approx_period;
> -       int user_count;
> +       DECLARE_BITMAP(pwms_enabled, 4);
>  };
>
>  static inline
> @@ -59,10 +59,16 @@ struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(str=
uct pwm_chip *c)
>  static int pwm_sifive_request(struct pwm_chip *chip, struct pwm_device *=
pwm)
>  {
>         struct pwm_sifive_ddata *ddata =3D pwm_sifive_chip_to_ddata(chip)=
;
> +       u32 val =3D readl(ddata->regs + PWM_SIFIVE_PWMCFG);
>
> -       mutex_lock(&ddata->lock);
> -       ddata->user_count++;
> -       mutex_unlock(&ddata->lock);
> +       if (val & PWM_SIFIVE_PWMCFG_EN_ALWAYS) {
> +               val =3D readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm)=
);
> +               if (val > 0) {
> +                       mutex_lock(&ddata->lock);
> +                       __set_bit(pwm->hwpwm, ddata->pwms_enabled);
> +                       mutex_unlock(&ddata->lock);
> +               }
> +       }
>
>         return 0;
>  }
> @@ -72,7 +78,7 @@ static void pwm_sifive_free(struct pwm_chip *chip, stru=
ct pwm_device *pwm)
>         struct pwm_sifive_ddata *ddata =3D pwm_sifive_chip_to_ddata(chip)=
;
>
>         mutex_lock(&ddata->lock);
> -       ddata->user_count--;
> +       __clear_bit(pwm->hwpwm, ddata->pwms_enabled);
>         mutex_unlock(&ddata->lock);
>  }
>
> @@ -158,11 +164,18 @@ static int pwm_sifive_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
>         frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
>
>         mutex_lock(&ddata->lock);
> +
> +       if (state->enabled) {
> +               __set_bit(pwm->hwpwm, ddata->pwms_enabled);
> +
>         if (state->period !=3D ddata->approx_period) {
> -               if (ddata->user_count !=3D 1) {
> +               if (bitmap_weight(ddata->pwms_enabled, 4) > 1) {
> +                       if (!enabled) {
> +                               __clear_bit(pwm->hwpwm, ddata->pwms_enabl=
ed);
>                         mutex_unlock(&ddata->lock);
>                         return -EBUSY;
>                 }
> +
>                 ddata->approx_period =3D state->period;
>                 pwm_sifive_update_clock(ddata, clk_get_rate(ddata->clk));
>         }
> @@ -177,14 +190,23 @@ static int pwm_sifive_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
>                 ret =3D clk_enable(ddata->clk);
>                 if (ret) {
>                         dev_err(ddata->chip.dev, "Enable clk failed\n");
> +                       if (state->enabled) {
> +                               mutex_lock(&ddata->lock);
> +                               __clear_bit(pwm->hwpwm, ddata->pwms_enabl=
ed);
> +                               mutex_unlock(&ddata->lock);
> +                       }
>                         return ret;
>                 }
>         }
>
>         writel(frac, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
>
> -       if (!state->enabled)
> +       if (!state->enabled) {
> +               mutex_lock(&ddata->lock);
> +               __clear_bit(pwm->hwpwm, ddata->pwms_enabled);
> +               mutex_unlock(&ddata->lock);
>                 clk_disable(ddata->clk);
> +       }
>
>         return 0;
>  }
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
