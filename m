Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5D1622BD2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiKIMqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKIMqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:46:12 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25B52CDC2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:46:11 -0800 (PST)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2FA22412C2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667997962;
        bh=RHoZ3MT1CpOkrn1NipWXHp2Mz+AtOoijcEZtSmMvrms=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=XBpW5B46Z3k4iE0Whtoc9akmCO5nEqqTyvTvVUhKS/mW2LgP5kwkJNYN4utnhzb8N
         rw/gZpX/75sSQfLVXUmv7KJmvfA3/S6dLUmhkvQNtSyUS9gRg5Mjqk82TIYRDlSgcy
         y0DHfZU/K5/cq1IYNKoxrJeN4VDUkGcAdjj09auQXaTyDkEX8XR1oEArsUWk5dFuos
         6q7PjLMMIaJypK7IUWpQ+dFQMcd632hcs09llepu18FKxH8csGTAnA9+a3BhabMFXG
         1kYZnQk96AXomXthnsSm9L4VBvNsd0tudOOq8JuhSoFpKYId/Qv9ETn8mPZaDcQrJy
         CC/9sTb6jxDjg==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-36b1a68bfa6so163330007b3.22
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 04:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHoZ3MT1CpOkrn1NipWXHp2Mz+AtOoijcEZtSmMvrms=;
        b=NVL2SlgNqr7LXMuHBeZ9QSv3WNfyTaW8e/8WT2hkwXl1l6XVU/y3kzPrQb02OM115m
         HAaVZjPRzDw+SC+9JzSHT0cFvbsMgioxVZY2jx2Ia03iyIhDlQxk1J3kO1dnZqWB5CCS
         u5COYNrDa/v8dMu7sWhJ3lI3zFNVCmefDReHuf9ZgJikr3GWC/AqE6V7uhfRkodCawto
         rHDdjv9rdsXm8JyqH+CPQqzLxiYQHIL6Jkn5Lp6DXnC77uIPQg9mzWCEc1vYnLAhOTL7
         wVjOwTfZMfD4MyzFVBMWHmyFMvdxAiYlbgBe7czj/CI9UOfyGiXdh43CQTYNU8tm/m9m
         dZSQ==
X-Gm-Message-State: ACrzQf1rL9L+mF2Yz6s1+xodF3FRHfcy/zpr7Dz8u99rVFsLvADGe7AY
        8sSUfVY9CGoAMf/A9RyqcIh1TYj2iqPTbVli1Yy00fMX5KytG3uU/JVopOYCjP/76CY7mIxSdvx
        Tb1UyWHiFNSgOn12CbaB5Z+7PgGiTo51mwaZ9jARDdREvLpmG8eSQ42P0qQ==
X-Received: by 2002:a25:8a0f:0:b0:6c2:4ea4:69e5 with SMTP id g15-20020a258a0f000000b006c24ea469e5mr59162093ybl.153.1667997959466;
        Wed, 09 Nov 2022 04:45:59 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4dO6RzG5dyotHYVC6fTTwkSqXjxngNZIAGPea9dxDM4GU/TS8fzUHaIukBdHxI3UlX2WUNH91ddTE8pHQQ9JE=
X-Received: by 2002:a25:8a0f:0:b0:6c2:4ea4:69e5 with SMTP id
 g15-20020a258a0f000000b006c24ea469e5mr59162077ybl.153.1667997959226; Wed, 09
 Nov 2022 04:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20221109113724.519021-1-emil.renner.berthing@canonical.com> <20221109120102.ylnseq2w33rvt7fz@pengutronix.de>
In-Reply-To: <20221109120102.ylnseq2w33rvt7fz@pengutronix.de>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 9 Nov 2022 13:45:43 +0100
Message-ID: <CAJM55Z-EVXB6FTWwh_vY_B3LoVv+b7TCQCE7asB8G8wkEwui_g@mail.gmail.com>
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

On Wed, 9 Nov 2022 at 13:01, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Emil,
>
> On Wed, Nov 09, 2022 at 12:37:24PM +0100, Emil Renner Berthing wrote:
> > Commit 2cfe9bbec56ea579135cdd92409fff371841904f added support for the
> > RGB and green PWM controlled LEDs on the HiFive Unmatched board
> > managed by the leds-pwm-multicolor and leds-pwm drivers respectively.
> > All three colours of the RGB LED and the green LED run from different
> > lines of the same PWM, but with the same period so this works fine when
> > the LED drivers are loaded one after the other.
> >
> > Unfortunately it does expose a race in the PWM driver when both LED
> > drivers are loaded at roughly the same time. Here is an example:
> >
> >   |          Thread A           |          Thread B           |
> >   |  led_pwm_mc_probe           |  led_pwm_probe              |
> >   |    devm_fwnode_pwm_get      |                             |
> >   |      pwm_sifive_request     |                             |
> >   |        ddata->user_count++  |                             |
> >   |                             |    devm_fwnode_pwm_get      |
> >   |                             |      pwm_sifive_request     |
> >   |                             |        ddata->user_count++  |
> >   |         ...                 |          ...                |
> >   |    pwm_state_apply          |    pwm_state_apply          |
> >   |      pwm_sifive_apply       |      pwm_sifive_apply       |
> >
> > Now both calls to pwm_sifive_apply will see that ddata->approx_period,
> > initially 0, is different from the requested period and the clock needs
> > to be updated. But since ddata->user_count >=3D 2 both calls will fail
> > with -EBUSY, which will then cause both LED drivers to fail to probe.
> >
> > Fix it by letting the first call to pwm_sifive_apply update the clock
> > even when ddata->user_count !=3D 1.
> >
> > Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM")
> > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com=
>
> > ---
> >  drivers/pwm/pwm-sifive.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > index 2d4fa5e5fdd4..b3c60ec72a6e 100644
> > --- a/drivers/pwm/pwm-sifive.c
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -159,7 +159,13 @@ static int pwm_sifive_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> >
> >       mutex_lock(&ddata->lock);
> >       if (state->period !=3D ddata->approx_period) {
> > -             if (ddata->user_count !=3D 1) {
> > +             /*
> > +              * Don't let a 2nd user change the period underneath the =
1st user.
> > +              * However if ddate->approx_period =3D=3D 0 this is the f=
irst time we set
> > +              * any period, so let whoever gets here first set the per=
iod so other
> > +              * users who agree on the period won't fail.
> > +              */
> > +             if (ddata->user_count !=3D 1 && ddata->approx_period) {
>
> While I'm convinced this works, we'd get some more uniform behaviour
> compared to other hardwares with similar restrictions if you lock the
> period on enabling the PWM instead of at request time. See for example
> drivers/pwm/pwm-pca9685.c.

Hmm.. that driver uses a pwms_enabled bitmap rather than a user count,
but it still sets the bit in the request method and refuses to change
period in the apply method if more than 1 bit is set. So as far as I
can tell it still suffers from the same race. However using a bitmap
instead of a user count would let us handle everything in the apply
method if we don't set the bit in the request method, but then the
behaviour would still be different. In any case it would still be a
large change to this driver.

How about we merge this bug fix that can easily be backported first
and then look at how it should be handled properly?

/Emil
