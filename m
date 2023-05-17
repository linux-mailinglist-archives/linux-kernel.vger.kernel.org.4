Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B457064BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjEQJ50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjEQJ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:57:24 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910053C3A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:57:22 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-783fb1d02dcso64146241.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684317441; x=1686909441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VynSA3MQFwVAlFJdNBzl7ESPzIRRYdlEm8KKXbrpLiw=;
        b=dxMWiPc/RBQNG0nw7gRRx8RJ1ieg+Q1e0goSUeFafR5dy3j9uXHba1ehIfcXfgpwtt
         lQsoXLyM/5ZCBuoBu62jfg4LL9jfOsl1J/8Dz3Y95JfSnOIU/4GpXHmN7t45PmgNKzD+
         +iiFiBxdYGsN1ftn63I4laptCzzfJUacG+A8de8o/OkfJU87LgJywI3rkBjERaO2PZ+Q
         BTIMQTOafenASM7DTp3gyBumA1Sm/TwSYekq4oXM6/cc7eIuY47MNO0wL2o385gI4Ew+
         OB5VqBtyIrCwZgfpK081tlmrG8pKNCe/UsSrkf/MJVZguF6ryVPHKGFleeXOHBFBVDMy
         moyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684317441; x=1686909441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VynSA3MQFwVAlFJdNBzl7ESPzIRRYdlEm8KKXbrpLiw=;
        b=XvA+kz5d+hWig45Z/IOaibuddM06zIYgdCjEuyk2wRDHGuHcbTScamlkbqP+1T7uXJ
         rw5/yFeiQucgk+Nn8j4MrNldSdjGXnmeJ917O83ZX02gLsLTLIczZSr7ctPIjsv3XXKO
         VEvixANMyqKRV67P9M4nCLLM3H69QcD+loIwmkFuue47qu9hi1lDZ9Sm85SKkJQSl29C
         45B/YinwyWQRdEpLN8qE1lU7IkpGHE35vY9sjFEZrgphD84fjS61WHYbi1/cNRAwODpC
         TW6pLIYMwMlXXAkyXwhUHWGUyFepGuSh0Aolsg6xWjk9Soa9aTS6kNU0Blswmk2Y0FiP
         P/aw==
X-Gm-Message-State: AC+VfDzmIvceSNGXogHbxdAZYv4tzZS13zjmXJLYlNKWTJggVGxlmgx7
        NUNqwsFbhYmnNushiqw2CuWK+kjoV4m/mswj4sJDHw==
X-Google-Smtp-Source: ACHHUZ5h7TQ820u7krPwOeein/T5RuKnCImpgUUK7k9MkkO14WXVMJJhr8wd8FomNgs2ecq9zPQccveEy/DRhwF9UfQ=
X-Received: by 2002:a67:e988:0:b0:436:1e1:685e with SMTP id
 b8-20020a67e988000000b0043601e1685emr13184350vso.28.1684317441643; Wed, 17
 May 2023 02:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230430-omap2-pdata-quirks-v1-0-e015f3a3ea46@linaro.org>
 <20230430-omap2-pdata-quirks-v1-1-e015f3a3ea46@linaro.org>
 <CAMRc=MczGKVFo+iWe_Pnvi3-hCK0fhmmkjp-h92RHONEHFAP_g@mail.gmail.com> <CACRpkdbYR+kobi3-xx7FgQG5aZb37JJageP+JWMss=D+KZUkFw@mail.gmail.com>
In-Reply-To: <CACRpkdbYR+kobi3-xx7FgQG5aZb37JJageP+JWMss=D+KZUkFw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 17 May 2023 11:57:10 +0200
Message-ID: <CAMRc=Me3KdxwjHYE4SQWo=CvDx9ccHp1qmzEBc7PszhOSYgS3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM/gpio: Push OMAP2 quirk down into TWL4030 driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Lee Jones <lee@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 2:19=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Wed, May 3, 2023 at 3:02=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> > On Mon, May 1, 2023 at 11:05=E2=80=AFAM Linus Walleij <linus.walleij@li=
naro.org> wrote:
> > >
> > > The TWL4030 GPIO driver has a custom platform data .set_up()
> > > callback to call back into the platform and do misc stuff such
> > > as hog and export a GPIO for WLAN PWR on a specific OMAP3 board.
> > >
> > > Avoid all the kludgery in the platform data and the boardfile
> > > and just put the quirks right into the driver. Make it
> > > conditional on OMAP3.
> > >
> > > I think the exported GPIO is used by some kind of userspace
> > > so ordinary DTS hogs will probably not work.
> > >
> >
> > While I haven't tested it (nor can I) so don't take my word for it, it
> > looks to me as if regular DTS hogs *should* work. If anything, the way
> > this quirk is implemented in your patch moves the export past the chip
> > registration, while ordinary hogs would be applied when the chip is
> > first added.
> >
> > Am I missing something?
>
> DTS hogs cannot do gpiod_export(), that's the problem. I think the OMAP2
> (Nokia phones?) need those exported GPIOs.
>
> Yours,
> Linus Walleij

Ah, it needs to manipulate the GPIOs then. Get it. I don't have a
better idea either.

Bart
