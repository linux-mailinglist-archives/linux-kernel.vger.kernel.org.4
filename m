Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02662C6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbiKPRqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbiKPRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:46:36 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E005F85C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:46:34 -0800 (PST)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D86F63F118
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668620791;
        bh=4AikLGaaRUfhbk2bEF5rHdnylOb482nhbBui5gJ2EGE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mze/8mffPvPuN2d7+p39s7PA5PfZprhnkv8CE4U7v4vvgEPDUpnZrEPX1wZq5rH+a
         Bstxs33PMNUGeYEj8I+fpUr7Jou94dhj6+6nrfAInN1cWiKEVSt80ZOkBqkZeuNhAR
         oJzBtbXikKphUXXvOnCVqsc+yJVWu2htvURp9s/UxvmzzUaou6MEOdp9yIocufHo3R
         iNHVeYBaEIl/PFNg0ocCga8btzm+lRKLAf/2+cZ+/MA6UkxLPeZusFqoyd42gQBdTb
         yL9Q4leD22RCIc14lv4vevdxC5WRp5IkBbbAB1z/GalwDK+dM4VPhBE2w6VV2/oN3Q
         qTNIMoV7YufSQ==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-37f0f3e59b2so100587337b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AikLGaaRUfhbk2bEF5rHdnylOb482nhbBui5gJ2EGE=;
        b=bgLWUFPltSuxbMLKP5z1beryXwD45vi+IIcyeFK9SWicihkDovQvJ/bcHoYmKUjJhT
         XX6b3Zpmnqb2IyGqw6g+27Iry+HZKmLdIc7CzockcHiFhdpbXWuNOgYMm3GN+RCMJey9
         2pL84JZGeljoy5qO33DPWSHYqPC5U2MeRWd0Nz1svh+ET1Vp6Mmco95TW2ByzNXA0ann
         PmxgIpKwfQjwipmgEpDIE8krFbgzMU41jsKKA7XJNC6Ki7cQWT6/kCDxivrrdOvTUFJE
         KlPJ4WjrrkIkw7aVEUlU1aiTSBx+1V5RXh2GcrAHLWY2rbaifa/y0OoGp7f7W8AfPocV
         Y7cA==
X-Gm-Message-State: ANoB5pnXXOIVmpqYo1hBwNglY8m13GBOpDtYs7SUo6h+jNQz7RgR3irr
        IvbJGkt8Xo1T75XEDzyNk9j7WyQnk+0pj655B8dOpNq83TCfZ5lMI2nha4IF/lI3SA5v+4i8G5f
        4d1E+Hne9jFA3+MB/sxwYyuxed2P8o9293UBImm6gnQwnQ7PH/3FE5g4Vaw==
X-Received: by 2002:a25:3497:0:b0:6de:39c1:9cb3 with SMTP id b145-20020a253497000000b006de39c19cb3mr22057423yba.469.1668620787621;
        Wed, 16 Nov 2022 09:46:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7RNs66NDb3yC0x90rriGZ5DsnRW6Xa2raxaqyUNgcN4zYhnONnWEP/fltQqyK9JobEXZnAXqTmdFhVCFKan3o=
X-Received: by 2002:a25:3497:0:b0:6de:39c1:9cb3 with SMTP id
 b145-20020a253497000000b006de39c19cb3mr22057403yba.469.1668620787354; Wed, 16
 Nov 2022 09:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20221109113724.519021-1-emil.renner.berthing@canonical.com>
 <20221109120102.ylnseq2w33rvt7fz@pengutronix.de> <CAJM55Z-EVXB6FTWwh_vY_B3LoVv+b7TCQCE7asB8G8wkEwui_g@mail.gmail.com>
 <20221109153311.cszr7fgfmyelwra3@pengutronix.de> <CAJM55Z8vpJ0XtQqnsFMLE4rkyV11ePbNjtYx0u4pgM9-MT=Kvg@mail.gmail.com>
In-Reply-To: <CAJM55Z8vpJ0XtQqnsFMLE4rkyV11ePbNjtYx0u4pgM9-MT=Kvg@mail.gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 16 Nov 2022 18:46:10 +0100
Message-ID: <CAJM55Z_g=fnDQbtupXs7W6Sb7BCMdn9cks9JFhQ_Enu8g8X91g@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 at 18:41, Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> On Wed, 9 Nov 2022 at 16:33, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Wed, Nov 09, 2022 at 01:45:43PM +0100, Emil Renner Berthing wrote:
> > > On Wed, 9 Nov 2022 at 13:01, Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > Hello Emil,
> > > >
> > > > On Wed, Nov 09, 2022 at 12:37:24PM +0100, Emil Renner Berthing wrot=
e:
> > > > > Commit 2cfe9bbec56ea579135cdd92409fff371841904f added support for=
 the
> > > > > RGB and green PWM controlled LEDs on the HiFive Unmatched board
> > > > > managed by the leds-pwm-multicolor and leds-pwm drivers respectiv=
ely.
> > > > > All three colours of the RGB LED and the green LED run from diffe=
rent
> > > > > lines of the same PWM, but with the same period so this works fin=
e when
> > > > > the LED drivers are loaded one after the other.
> > > > >
> > > > > Unfortunately it does expose a race in the PWM driver when both L=
ED
> > > > > drivers are loaded at roughly the same time. Here is an example:
> > > > >
> > > > >   |          Thread A           |          Thread B           |
> > > > >   |  led_pwm_mc_probe           |  led_pwm_probe              |
> > > > >   |    devm_fwnode_pwm_get      |                             |
> > > > >   |      pwm_sifive_request     |                             |
> > > > >   |        ddata->user_count++  |                             |
> > > > >   |                             |    devm_fwnode_pwm_get      |
> > > > >   |                             |      pwm_sifive_request     |
> > > > >   |                             |        ddata->user_count++  |
> > > > >   |         ...                 |          ...                |
> > > > >   |    pwm_state_apply          |    pwm_state_apply          |
> > > > >   |      pwm_sifive_apply       |      pwm_sifive_apply       |
> > > > >
> > > > > Now both calls to pwm_sifive_apply will see that ddata->approx_pe=
riod,
> > > > > initially 0, is different from the requested period and the clock=
 needs
> > > > > to be updated. But since ddata->user_count >=3D 2 both calls will=
 fail
> > > > > with -EBUSY, which will then cause both LED drivers to fail to pr=
obe.
> > > > >
> > > > > Fix it by letting the first call to pwm_sifive_apply update the c=
lock
> > > > > even when ddata->user_count !=3D 1.
> > > > >
> > > > > Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PW=
M")
> > > > > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonic=
al.com>
> > > > > ---
> > > > >  drivers/pwm/pwm-sifive.c | 8 +++++++-
> > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > > > index 2d4fa5e5fdd4..b3c60ec72a6e 100644
> > > > > --- a/drivers/pwm/pwm-sifive.c
> > > > > +++ b/drivers/pwm/pwm-sifive.c
> > > > > @@ -159,7 +159,13 @@ static int pwm_sifive_apply(struct pwm_chip =
*chip, struct pwm_device *pwm,
> > > > >
> > > > >       mutex_lock(&ddata->lock);
> > > > >       if (state->period !=3D ddata->approx_period) {
> > > > > -             if (ddata->user_count !=3D 1) {
> > > > > +             /*
> > > > > +              * Don't let a 2nd user change the period underneat=
h the 1st user.
> > > > > +              * However if ddate->approx_period =3D=3D 0 this is=
 the first time we set
> > > > > +              * any period, so let whoever gets here first set t=
he period so other
> > > > > +              * users who agree on the period won't fail.
> > > > > +              */
> > > > > +             if (ddata->user_count !=3D 1 && ddata->approx_perio=
d) {
> > > >
> > > > While I'm convinced this works, we'd get some more uniform behaviou=
r
> > > > compared to other hardwares with similar restrictions if you lock t=
he
> > > > period on enabling the PWM instead of at request time. See for exam=
ple
> > > > drivers/pwm/pwm-pca9685.c.
> > >
> > > Hmm.. that driver uses a pwms_enabled bitmap rather than a user count=
,
> > > but it still sets the bit in the request method and refuses to change
> > > period in the apply method if more than 1 bit is set.
> >
> > Note there are two different bitmaps. The one modified in .request is
> > for gpio stuff and the other in .apply() for locking the common period
> > length.
>
> Yeah, there is the pwms_enabled and pwms_inuse bitmaps, but
> pwms_enabled is used both in .request and .apply.

Oh, I think you might have looked at the pca9685_pwm_gpio_request
function and not pca9685_pwm_request.

> > > So as far as I
> > > can tell it still suffers from the same race. However using a bitmap
> > > instead of a user count would let us handle everything in the apply
> > > method if we don't set the bit in the request method, but then the
> > > behaviour would still be different. In any case it would still be a
> > > large change to this driver.
> > >
> > > How about we merge this bug fix that can easily be backported first
> > > and then look at how it should be handled properly?
> >
> > I thought it wouldn't be that hard to do it right from the start,
> > but I admit it's harder than I expected to get right. My prototype look=
s
> > as follows:
>
> This works for me (modulo the two extra {'s). I'd still prefer merging
> the simpler version and then this on top for ease of backporting, but
> as long as the race is fixed I'm fine. Will you send a cleaned up
> version of this?
>
> /Emil
>
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > index 2d4fa5e5fdd4..89846d95bfc0 100644
> > --- a/drivers/pwm/pwm-sifive.c
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -41,13 +41,13 @@
> >
> >  struct pwm_sifive_ddata {
> >         struct pwm_chip chip;
> > -       struct mutex lock; /* lock to protect user_count and approx_per=
iod */
> > +       struct mutex lock; /* lock to protect approx_period */
> >         struct notifier_block notifier;
> >         struct clk *clk;
> >         void __iomem *regs;
> >         unsigned int real_period;
> >         unsigned int approx_period;
> > -       int user_count;
> > +       DECLARE_BITMAP(pwms_enabled, 4);
> >  };
> >
> >  static inline
> > @@ -59,10 +59,16 @@ struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(s=
truct pwm_chip *c)
> >  static int pwm_sifive_request(struct pwm_chip *chip, struct pwm_device=
 *pwm)
> >  {
> >         struct pwm_sifive_ddata *ddata =3D pwm_sifive_chip_to_ddata(chi=
p);
> > +       u32 val =3D readl(ddata->regs + PWM_SIFIVE_PWMCFG);
> >
> > -       mutex_lock(&ddata->lock);
> > -       ddata->user_count++;
> > -       mutex_unlock(&ddata->lock);
> > +       if (val & PWM_SIFIVE_PWMCFG_EN_ALWAYS) {
> > +               val =3D readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpw=
m));
> > +               if (val > 0) {
> > +                       mutex_lock(&ddata->lock);
> > +                       __set_bit(pwm->hwpwm, ddata->pwms_enabled);
> > +                       mutex_unlock(&ddata->lock);
> > +               }
> > +       }
> >
> >         return 0;
> >  }
> > @@ -72,7 +78,7 @@ static void pwm_sifive_free(struct pwm_chip *chip, st=
ruct pwm_device *pwm)
> >         struct pwm_sifive_ddata *ddata =3D pwm_sifive_chip_to_ddata(chi=
p);
> >
> >         mutex_lock(&ddata->lock);
> > -       ddata->user_count--;
> > +       __clear_bit(pwm->hwpwm, ddata->pwms_enabled);
> >         mutex_unlock(&ddata->lock);
> >  }
> >
> > @@ -158,11 +164,18 @@ static int pwm_sifive_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >         frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> >
> >         mutex_lock(&ddata->lock);
> > +
> > +       if (state->enabled) {
> > +               __set_bit(pwm->hwpwm, ddata->pwms_enabled);
> > +
> >         if (state->period !=3D ddata->approx_period) {
> > -               if (ddata->user_count !=3D 1) {
> > +               if (bitmap_weight(ddata->pwms_enabled, 4) > 1) {
> > +                       if (!enabled) {
> > +                               __clear_bit(pwm->hwpwm, ddata->pwms_ena=
bled);
> >                         mutex_unlock(&ddata->lock);
> >                         return -EBUSY;
> >                 }
> > +
> >                 ddata->approx_period =3D state->period;
> >                 pwm_sifive_update_clock(ddata, clk_get_rate(ddata->clk)=
);
> >         }
> > @@ -177,14 +190,23 @@ static int pwm_sifive_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >                 ret =3D clk_enable(ddata->clk);
> >                 if (ret) {
> >                         dev_err(ddata->chip.dev, "Enable clk failed\n")=
;
> > +                       if (state->enabled) {
> > +                               mutex_lock(&ddata->lock);
> > +                               __clear_bit(pwm->hwpwm, ddata->pwms_ena=
bled);
> > +                               mutex_unlock(&ddata->lock);
> > +                       }
> >                         return ret;
> >                 }
> >         }
> >
> >         writel(frac, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
> >
> > -       if (!state->enabled)
> > +       if (!state->enabled) {
> > +               mutex_lock(&ddata->lock);
> > +               __clear_bit(pwm->hwpwm, ddata->pwms_enabled);
> > +               mutex_unlock(&ddata->lock);
> >                 clk_disable(ddata->clk);
> > +       }
> >
> >         return 0;
> >  }
> >
> > Best regards
> > Uwe
> >
> > --
> > Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
> > Industrial Linux Solutions                 | https://www.pengutronix.de=
/ |
