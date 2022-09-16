Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D2D5BAEBC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiIPOAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIPOAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:00:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD4A696E8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:00:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so49557665ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GaUFnwsF+GNkHx8TdRwDpLzcGfUTwgcJZXalpSa+ZSw=;
        b=RtpJpR+CWL67LDuc+ZpXme7YMb5aARFSGK/NVk14KCkFvz0yFQUYhS7zjELPxvqL32
         5u9pSenjEVl2C2kznpdvqvgMl7Mkp755ljPB8A4WlUdpYvK8CrU127svaJSBR4mu1OIG
         5nxv6gbz18x44KWZHvCuPe9GNugxj9tK1DrrkD6JxA7xRil/xwd6MTAxsIXpYuYT20w4
         //TvmVUn0VmpbWqHZvnXOz+zNjeBNeI4o+v96949tKuYaBojzCQqW0GdfGfJ8JxtDTuD
         g5RYSnHa3zJ+n03Kp20uJs6Fn4XJLzbC9Nax/Ttqo7DYl44R9i+/nLc+lFArzHLjOSp9
         THyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GaUFnwsF+GNkHx8TdRwDpLzcGfUTwgcJZXalpSa+ZSw=;
        b=Zkp2Jgp+7FRa4GQbce7pBcpRVZUcsBKv/mcLEBTxuw4/x8PR0WvRAwNbUd4OiaGit/
         l4mwqMqbQ5W1X+wW80zZYKdg6FM3I23MMj5sC626raBzDYZg68yDbI21Cmp6Mk4dZMvR
         PYx6bDkOlE9UF1P8KER6LEswKntFavD3LZTbxt68j2dmkpEfEUU1GilOA4NjyJkLvQm8
         DDPQlmo4vlxAuy4qUvmcUnIsQ8jKdg3GIy0o0ROutyj1+wmLlLrGHYhUY9c0eZ3g4mG5
         SW0bS87JnUJq+OVa683sF8Ktdl83DSg1wCibuWZn7EpunGa/xrF8IHnh8mJQU6grkwfW
         Hmmw==
X-Gm-Message-State: ACrzQf1kbvCFLA+wIo/Ukp95Apos43nQj/66MMZW6oQUVECq1K4b3dCX
        L5DXJdnXBpA2os0RbCH0Y/mrDbYao8XE04zQQdDAYg==
X-Google-Smtp-Source: AMsMyM6iG5//9kvIfX7d0yoThHgkwgZnNEh9txI8/sDR0hFJTZvo/Ir/WZIfLixivLBwo7CMLfmkD2QoMyMXiDxp6Sw=
X-Received: by 2002:a17:906:8a55:b0:780:9b5d:aa06 with SMTP id
 gx21-20020a1709068a5500b007809b5daa06mr2756098ejc.500.1663336845070; Fri, 16
 Sep 2022 07:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220914151145.73253-1-brgl@bgdev.pl> <CACRpkdZaSL_pkmrVGOT-y7+3i4y6f6Cjgehycq2FKLwPxrbFvw@mail.gmail.com>
 <CAMRc=Me+srb_rwwaUxx1a=8+Wqm5sc2APzfCoFG3+QxRK5kEKA@mail.gmail.com>
 <CACRpkdZwsLM64m7xHgNg=FPqTYaou9=KpN2rckyp6sKiJokU7A@mail.gmail.com> <CAL_JsqKxdX_Pya-N9n+w8a9ZqCa3AdFaRUXu0E31Joyb0psk_w@mail.gmail.com>
In-Reply-To: <CAL_JsqKxdX_Pya-N9n+w8a9ZqCa3AdFaRUXu0E31Joyb0psk_w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Sep 2022 16:00:33 +0200
Message-ID: <CACRpkdZSi4DiqNShPB8YkhbDdYG7=yRRXXaiZFptHT2fdEOwqw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: TODO: add an item about GPIO safe-state
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 3:47 PM Rob Herring <robh+dt@kernel.org> wrote:

> > Inability to drive through a DT binding that was acceptable for the
> > DT binding maintainers.
>
> AFAICT, this came up briefly in 2015, then 2017, then 2019. (You're a
> year late this time.) A nice regular pattern to not get something
> upstream...

:D

> > A good idea to get it passed I think would be to ask Rob (with some
> > examples) how he thinks it should look and finalize the bindings
> > before coding.
>
> My issue was more that by the time the kernel or even bootloader runs,
> quite a bit of time has passed given all the firmware that runs
> nowadays. Doesn't a safe state need to be set as early as possible?
> Like probably before anything using DT?

So that is less related to the bindings and more related to the
implementation, right?

I think this has always been seen as "default state at the point
when the operating system boots" but possibly we should just add
a flag or something to the bindings to say how early-ish the
particular default safe state config applies?

> A node per GPIO could end up being a lot of nodes and I can certainly
> see folks just initializing every GPIO. That would be a lot of bloat.
> As I see it we need 4 bits per line: direction, state(high/low), pull
> up/down/none.

I don't know exactly which use cases people have here, but yeah
definitely biasing for example, so a certain line can go out of reset
thanks to getting pulled up.

I imagined something like a ngpios long array:

/* Initial states */
gpio-init-states = <GPIO_OUT_LOW, GPIO_OUT_HIGH,
  GPIO_NO_CHANGE, GPIO_NO_CHANGE, GPIO_OUT_HIGH ...>;

these defines does not exist in include/dt-bindings/gpio/gpio.h,
it's just my idea of it.

> Finally, don't non-GPIO pins need the same thing? You don't want a
> default output driving what needs to be an input.

The pin control subsystem has something like this, in the "default"
and "init" states the pins are set to a default mux/pin config.
So for SoC GPIOs in many cases this problem is already solved
by using pin control states and hogs, as pin control is often used
as a back-end for GPIO. e.g. all Qualcomm platforms TLMM.

GPIO lines however can also be on a I2C or USB expander or
something where pin control is not applicable at all, so this would be
for initializing lines on those controllers.

Yours,
Linus Walleij
