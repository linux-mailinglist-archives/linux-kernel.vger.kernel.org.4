Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD03602EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJRO5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiJRO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:57:07 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03692D8ED6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:57:05 -0700 (PDT)
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 13B183F473
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666105024;
        bh=BafWgVTs1Qs33lQ5vYE0lEluRGQS0XS1I2Mm/0y61yc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=OZUEAoVQEBNpasj8uBxRqaPTgMjpgC+BL8NLcndDFANai2tsbRSQnZu882Y82xw6X
         p6Nm79SR+FqYpAGyWjeC3zqDygFIGvgs6vxMvKchU3aYnPkzIgvD/OSYQW9vyjmha5
         RZ/6Ol21et/sRFfw9cDmBDAZoOnRT1amdKE6hAcTe8f0GIShMmwrxfkDEfsdto8keC
         KUkrx/lHwRap7W3h/xJ3lWTEuUiOB76aFUqkLHuF/XgWpjIMJkWHziATvlD53D/TFq
         gYL4xqbCJGFszZWJupGlCE0K4B0iFKJZddBzFWepjlGFN47y1Nfkkde+3D/wFxeJam
         cdWuBQ5TKZuuw==
Received: by mail-qv1-f71.google.com with SMTP id i7-20020a0cab47000000b004b4376895bfso8910527qvb.20
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BafWgVTs1Qs33lQ5vYE0lEluRGQS0XS1I2Mm/0y61yc=;
        b=rDj9yGQKeENvCq3ocWOW3lrsbbzXre9Rbt0mniWQpRMLYh7WDvzEsgCdPYyX3ISuw/
         v6H2yMwsbqSmN/MsC53WjXsI6She0mDJtp1WAuSp5bRJ2uYPMye+JnGyohhR3BRZ7iBf
         Ewp8sWn8QHarnECJa0VWemKGDprZMG6PFc0fGmm8iRe8TtpALP82DjpQQ6qvkRf27ghi
         fIx0Bc9tswf8iI0MQGK9X8ii+GBbMRyrqe0zmvb2BVC7GlefX7IJqdW++PQMEVUA1fGo
         au5S7MWytktqbk4k5//gMXDmECXtiNztFnE6vLVg9ta4G60Ls1q3abNKqkxmrxMkKtxH
         IVjA==
X-Gm-Message-State: ACrzQf0otxe/rAEy8aafSa1FjVJ4QrkphbdeDxFBNtjD4ZVI+oBzdhV1
        6lyXTctjKeT9JYgb8NIw+/ECKW2NabdyOrO1EHuZUP+YxNzw9aygcVOvv2FLSYdiVlJ5r5ALTQI
        ZnuU5wepVHYRyCCHiZ0Nim9jtox7RJCQ7HUa6U+r6hb1YIpHzM+DAYHx7Qw==
X-Received: by 2002:a05:6214:2301:b0:498:9f6f:28d with SMTP id gc1-20020a056214230100b004989f6f028dmr2400040qvb.5.1666105022666;
        Tue, 18 Oct 2022 07:57:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5VLAiOfs5ypDxb9bi0mpLfwMnKLT/JanF3CcvFCQOgy+yFhQZHARVCsQs1Lrgtks+5teBsR2NSVjwnI8zDS7I=
X-Received: by 2002:a05:6214:2301:b0:498:9f6f:28d with SMTP id
 gc1-20020a056214230100b004989f6f028dmr2400025qvb.5.1666105022393; Tue, 18 Oct
 2022 07:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221018091316.415685-1-emil.renner.berthing@canonical.com> <20221018132921.5fsbiz254npk2fci@pengutronix.de>
In-Reply-To: <20221018132921.5fsbiz254npk2fci@pengutronix.de>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 18 Oct 2022 16:56:46 +0200
Message-ID: <CAJM55Z_v069EJmnr_nLFx9CQV9HfAOc2vCFv95VSip59zLFvjA@mail.gmail.com>
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

On Tue, 18 Oct 2022 at 15:29, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Tue, Oct 18, 2022 at 11:13:16AM +0200, Emil Renner Berthing wrote:
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
> >  drivers/pwm/pwm-sifive.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > index 2d4fa5e5fdd4..ccdf92045f34 100644
> > --- a/drivers/pwm/pwm-sifive.c
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -159,7 +159,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >
> >       mutex_lock(&ddata->lock);
> >       if (state->period !=3D ddata->approx_period) {
> > -             if (ddata->user_count !=3D 1) {
> > +             if (ddata->user_count !=3D 1 && ddata->approx_period) {
>
> IMHO this needs a code comment. It should among others mention that
> approx_period is only zero if .apply() wasn't called before.

Agreed. I'll add in v2.

> Let me note this is inconsistent. I didn't check the details, but let's
> assume the PWM can implement .period =3D 500 and .period =3D 514 and noth=
ing
> in between. So if the the first PWM requests 512 ns it gets (I hope) 500
> ns. Then when the second requests comes in requesting 511 it fails and
> if it requests 512 is succeeds also getting 500 ns. Hmm.

Yes, if two different consumers wants different periods then whoever
gets to take the mutex in pwm_sifive_apply first gets to set the clock
for its requested period and the other consumer will get -EBUSY. I
don't see how this lets one consumer call pwm_state_apply successfully
but still get a different period though.

/Emil

> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
