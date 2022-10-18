Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B9D602F13
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJRPB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJRPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:01:25 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EDC11145
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:01:24 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C993A3F56F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666105279;
        bh=eKS6yWmMyojFT+rt6lz+sSid3ThtmkubFc+40+Tp6k8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=KpX8NArBtzPlrldPvVZeF+Hj3zwwKLZbkh5yeWUhrCofOgkmEtqHgAyDMivttOm6l
         rug0BMEiYsNzWMwWrEgZZtcDzKzcdyEoxClw7v7uCrIMXMBrmgNRfVV+JjYb8wfdHD
         GFaBoxr9SzSVwYGXEAFkxKhQv1nIgfIY7Q4Yq600/J5BjHgyYeavbcUOvGh0kMtfIi
         Ra/9pjEtHS8u9d1hUn1wNRZKrfT/v4pa9Q53dnfGrD/XkOaILoMtyPZH0S7DbENJPk
         fRTzUiLIMeM1YllUJmrAkcqtvv4vJyai3/h/cXlEbeA6UmTVOk5zyiJkmqWH0//rIM
         R3DoXKoWcwpPQ==
Received: by mail-qt1-f198.google.com with SMTP id cr15-20020a05622a428f00b0039cf1f8c94fso2352321qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKS6yWmMyojFT+rt6lz+sSid3ThtmkubFc+40+Tp6k8=;
        b=mTlYNNAye3SgPjBdiXCajODi9BdNd26/LiwdIoeCs9jVY4E8mikKAno54bLQ46wZY5
         zZI/Mdtz0H8vCvGEpm0zZQ81w4bXBqSvBey7YaiWEFq/ISnVePRp6iKkXGwnrUldGLQm
         wtvJWIjYleHKYANex6pp1zIEugTWnobh0vcLQOGnbTHyygS9+NQXltUAz1+E/Md8SQF0
         4UNSF74A7G2tLVga6BgHWAyMXbSGTIwzTkPosL8QpA+UWq0di3P3k2wWmrSiDQrAKJlk
         ++k4Y058CO+RgZg6Ov1OW1rkMu++28M+4oucXehpFaWRJiMNsIT4NrV1/348nTnTGBGQ
         I1Kw==
X-Gm-Message-State: ACrzQf22dHKjmhBtUykMWz7dIY8gcTswLvQZZxhVW/3YzvkZ0X+Dxcbd
        Xc3Y8Qbo2h7eyRh8UZRMg966BBEARgjAJ+IXvfG8fTFNkr06vgMOcEdJV0u75vsknaXJlteKR2t
        qecbdDlHnAOROo2h/AyDg75L2yW9YQIDbq5gOK2NGiVvOgkCxqZzKZn3WKA==
X-Received: by 2002:a05:6214:19c9:b0:4b2:fe6f:90f9 with SMTP id j9-20020a05621419c900b004b2fe6f90f9mr2662145qvc.66.1666105277523;
        Tue, 18 Oct 2022 08:01:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6xytzQByWh7C8hBLdqhpI6w72qMrcqLyc3YNybBSV1Prvl9EkgXA1/A4+HFlbrm8xhLrZSaR9MxAxAM7gJ4vA=
X-Received: by 2002:a05:6214:19c9:b0:4b2:fe6f:90f9 with SMTP id
 j9-20020a05621419c900b004b2fe6f90f9mr2662098qvc.66.1666105277170; Tue, 18 Oct
 2022 08:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221018091316.415685-1-emil.renner.berthing@canonical.com>
 <20221018132921.5fsbiz254npk2fci@pengutronix.de> <CAJM55Z_v069EJmnr_nLFx9CQV9HfAOc2vCFv95VSip59zLFvjA@mail.gmail.com>
In-Reply-To: <CAJM55Z_v069EJmnr_nLFx9CQV9HfAOc2vCFv95VSip59zLFvjA@mail.gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 18 Oct 2022 17:01:01 +0200
Message-ID: <CAJM55Z8i7JiQgccZxxLrPCio=5rT43ruTnn=83x=n0Wz+xhebw@mail.gmail.com>
Subject: Re: [PATCH v1] pwm: sifive: Always let the first pwm_apply_state succeed
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
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 at 16:56, Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> On Tue, 18 Oct 2022 at 15:29, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello,
> >
> > On Tue, Oct 18, 2022 at 11:13:16AM +0200, Emil Renner Berthing wrote:
> > > Commit 2cfe9bbec56ea579135cdd92409fff371841904f added support for the
> > > RGB and green PWM controlled LEDs on the HiFive Unmatched board
> > > managed by the leds-pwm-multicolor and leds-pwm drivers respectively.
> > > All three colours of the RGB LED and the green LED run from different
> > > lines of the same PWM, but with the same period so this works fine wh=
en
> > > the LED drivers are loaded one after the other.
> > >
> > > Unfortunately it does expose a race in the PWM driver when both LED
> > > drivers are loaded at roughly the same time. Here is an example:
> > >
> > >   |          Thread A           |          Thread B           |
> > >   |  led_pwm_mc_probe           |  led_pwm_probe              |
> > >   |    devm_fwnode_pwm_get      |                             |
> > >   |      pwm_sifive_request     |                             |
> > >   |        ddata->user_count++  |                             |
> > >   |                             |    devm_fwnode_pwm_get      |
> > >   |                             |      pwm_sifive_request     |
> > >   |                             |        ddata->user_count++  |
> > >   |         ...                 |          ...                |
> > >   |    pwm_state_apply          |    pwm_state_apply          |
> > >   |      pwm_sifive_apply       |      pwm_sifive_apply       |
> > >
> > > Now both calls to pwm_sifive_apply will see that ddata->approx_period=
,
> > > initially 0, is different from the requested period and the clock nee=
ds
> > > to be updated. But since ddata->user_count >=3D 2 both calls will fai=
l
> > > with -EBUSY, which will then cause both LED drivers to fail to probe.
> > >
> > > Fix it by letting the first call to pwm_sifive_apply update the clock
> > > even when ddata->user_count !=3D 1.
> > >
> > > Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM")
> > > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.c=
om>
> > > ---
> > >  drivers/pwm/pwm-sifive.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > index 2d4fa5e5fdd4..ccdf92045f34 100644
> > > --- a/drivers/pwm/pwm-sifive.c
> > > +++ b/drivers/pwm/pwm-sifive.c
> > > @@ -159,7 +159,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > >
> > >       mutex_lock(&ddata->lock);
> > >       if (state->period !=3D ddata->approx_period) {
> > > -             if (ddata->user_count !=3D 1) {
> > > +             if (ddata->user_count !=3D 1 && ddata->approx_period) {
> >
> > IMHO this needs a code comment. It should among others mention that
> > approx_period is only zero if .apply() wasn't called before.
>
> Agreed. I'll add in v2.
>
> > Let me note this is inconsistent. I didn't check the details, but let's
> > assume the PWM can implement .period =3D 500 and .period =3D 514 and no=
thing
> > in between. So if the the first PWM requests 512 ns it gets (I hope) 50=
0
> > ns. Then when the second requests comes in requesting 511 it fails and
> > if it requests 512 is succeeds also getting 500 ns. Hmm.
>
> Yes, if two different consumers wants different periods then whoever
> gets to take the mutex in pwm_sifive_apply first gets to set the clock
> for its requested period and the other consumer will get -EBUSY. I
> don't see how this lets one consumer call pwm_state_apply successfully
> but still get a different period though.

Sorry now I see what you mean. You're saying that if different
consumers want different periods, but they round to the same, then
that shouldn't fail, but now it does. I think that's a corner case I'd
happily live with.

> > Best regards
> > Uwe
> >
> > --
> > Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
> > Industrial Linux Solutions                 | https://www.pengutronix.de=
/ |
