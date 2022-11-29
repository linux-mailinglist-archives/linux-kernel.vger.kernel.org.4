Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D465663C717
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiK2SUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiK2SUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:20:31 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522902A41E;
        Tue, 29 Nov 2022 10:20:29 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id a19so2492045ljk.0;
        Tue, 29 Nov 2022 10:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/YZ7W5csugr2Bn2cmkIdVJsBOw6MIoUlHR9lQ0xQ/SY=;
        b=OvSUf9YBmoDRrSHmB124lWfahqmaY1njCYYb2eihFX0En5UGFQYn64HZ4sBdTcYbXu
         sOOaaaUawNNIFXiFXLfq6I9eIxI1InitPZwdgGmPZpWgH571V37LRemZXGRTZTqGu0eA
         rF0HcQunBKA+G8FI6oYxducRBJW9IjLWEQKcjE0mCbEYUaZTA5LRK/bekpcKXGA88R0W
         XhfrUsjZimBvT1STMYhEQBmuPwY5DgisuR0GfDWhx9OWGiAXxXlMAxXkjhODkjyWVpWq
         yLzkDLLadNYCULj1VBREpx85SVz+/i7a4Vu8SYKl1H+FucmqkZyb/N/S4LPE1O7lm/yi
         SaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YZ7W5csugr2Bn2cmkIdVJsBOw6MIoUlHR9lQ0xQ/SY=;
        b=UxwMPseFv0JFLHrV00v/C3x6C2Np7Ys2vNrcsgEZuIIqm6bQcvhl/cMhx5TuBwbd38
         HmTtY5FaUy8zxEmTLv9ujTFAUN0/iUSjRG1dfQt0NPSGaYRL7eUJM/9CsV2JWUeO0aAW
         yY76v1Kvw7ZQdH70CbvErqKxxKqPTeSl35/zmE5Mp77pHAUHrUbfKfH3TvzgHUrEOetS
         EIOsZxk1JFJSdMD9SxCrHYhXcYCW++fvrzNkEMcfS7R8gYryQWipet+NX0uTIMA+xlCc
         9IXkMqe8xSM030M4dhAjQp6ZC6ID78IMvnl798+QgdGqZADEwJLXH1k6fA/Z9PH1ijpz
         Lnog==
X-Gm-Message-State: ANoB5pm83xLuUvxvesawfnTJ+q1gDE3Z3dzJWAaALF/yDABASPcTbK63
        /amXfofugo5MeKj1YuLYCFtwPcSRb9Tsj1gdm1Y=
X-Google-Smtp-Source: AA0mqf7DCIO3YwlRaYKyAdZ9oWnkSwxHGeEMLFcAVt39H1gVH2FayKwGs6BnZJ+V9JZ2ihDpV58R/GtQNbpglv0rhSE=
X-Received: by 2002:a2e:a364:0:b0:279:6aeb:7f63 with SMTP id
 i4-20020a2ea364000000b002796aeb7f63mr12207408ljn.50.1669746027474; Tue, 29
 Nov 2022 10:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20221122201232.107065-1-tmaimon77@gmail.com> <20221122201232.107065-3-tmaimon77@gmail.com>
 <577e273d-ff9b-4d8d-b797-d7275ab8374f@app.fastmail.com> <CAP6Zq1ikqtKOGUZX-VAdyhs+nsvy7ah4gqRrbXVA8Gp9L46hXQ@mail.gmail.com>
 <7f43febb-0a89-4313-9c85-a7a44c231b45@app.fastmail.com>
In-Reply-To: <7f43febb-0a89-4313-9c85-a7a44c231b45@app.fastmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 29 Nov 2022 20:20:16 +0200
Message-ID: <CAP6Zq1jR1ouDgRQ0=6RR7iCnkrY_X87SeiNAxt_y0+QsVXS=ZA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] soc: nuvoton: add NPCM LPC BPC driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com,
        Joel Stanley <joel@jms.id.au>, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Hector Martin <marcan@marcan.st>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Sven Peter <sven@svenpeter.dev>,
        Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for your comments

On Fri, 25 Nov 2022 at 12:25, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Nov 23, 2022, at 19:01, Tomer Maimon wrote:
> > On Wed, 23 Nov 2022 at 12:58, Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> On Tue, Nov 22, 2022, at 21:12, Tomer Maimon wrote:
> >> > Add Nuvoton BMC NPCM LPC BIOS post code (BPC) driver.
> >> >
> >> > The NPCM BPC monitoring two configurable I/O address written by the host
> >> > on the Low Pin Count (LPC) bus.
> >> >
> >> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> >> > ---
> >> >  drivers/soc/Kconfig                |   1 +
> >> >  drivers/soc/Makefile               |   1 +
> >> >  drivers/soc/nuvoton/Kconfig        |  24 ++
> >> >  drivers/soc/nuvoton/Makefile       |   3 +
> >> >  drivers/soc/nuvoton/npcm-lpc-bpc.c | 396 +++++++++++++++++++++++++++++
> >>
> >> In general, I try to keep drivers/soc/ for drivers that are
> >> used purely inside of the kernel and don't provide their
> >> own user space ABI, those should normally be part of
> >> some subsystem grouped by functionality.
> >>
> >> It appears that we have similar drivers for aspeed already,
> >> so there is some precedent, but I would still like to ask
> >> you and Joel to try to make sure the two are compatible,
> >> or ideally share the code for the user-facing part of the
> >> LPC driver.
> > Nuvoton and Aspeed use the same user-facing code to manage the host snooping.
> > https://github.com/openbmc/phosphor-host-postd
>
> Ok, great!
>
> >> The implementation of npcm-lpc-bpc looks fine otherwise, I only
> >> noticed one minor detail that I would change:
> >>
> >> > +     np = pdev->dev.parent->of_node;
> >> > +     if (!of_device_is_compatible(np, "nuvoton,npcm750-lpc") &&
> >> > +         !of_device_is_compatible(np, "nuvoton,npcm845-lpc")) {
> >> > +             dev_err(dev, "unsupported LPC device binding\n");
> >> > +             return -ENODEV;
> >> > +     }
> >>
> >> This check doesn't seem to make sense here, since those are
> >> the only two types you support.
> > About the LPC, I like to double check with our architectures on it
> > because the BPC should working on eSPI as well.
> > Maybe I should remove the LPC part.
>
> The version you posted only has LPC support, not eSPI, so that
> wouldn't work. I'm not sure how eSPI is normally represented
> in device drivers, does that show up the same way as an LPC
> device, or do you need to register a separate spi_driver?
The eSPI is a successor to its Low Pin Count (LPC) and it will show up
in the same way as the LPC.
NPCM BPC can be connected to the CPU (host) through LPC or eSPI bus
and the NPCM BPC driver not is handling the LPC or the eSPI bus
therefore I should remove the LPC naming from the and only use BPC.
>
> If it's part of the same platform driver with different
> OF compatible strings, the normal way to handle this would
> be to use the .data field in the of_device_id to pass
> model specific information to other parts of the driver.
>
>      Arnd

Best regards,

Tomer
