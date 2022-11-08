Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65137620DD7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiKHKyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiKHKyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:54:04 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175F745A08
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:54:03 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k2so37576580ejr.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u8F2u7XnHXSi02ZUPPzRhyN9LzC+uyXpgjAwUMrqCak=;
        b=gD3OYiXGpaEE83Zt07u3m3HEcjDa0jisiiEZhbfrrX1/Kc5NTf4xodx4W7Z9IbRN9N
         YjrviVX5NrAc+NH3m0ChzppmMKfsi72Kgvms+j08FWYT75M/DZ7+Y9i5VJXLjK9Z/cQH
         6Bxd3vwj+yn9tPyeg01cB6mSD72Jat9Ig1/96Uy8iFXjsdvZUKZqOZ6GY2B6CnVirLL2
         YIO+/CM3j4o4na7Zurq0hnV64f3E3O61UwnRaA2hXVAB/5cpmlPxWI5F/YxYcbAQv75G
         madN9Z+sLRnNCwhLbpPKES4kvN15zXxnue3LZKkswKUXPYYdQmUGUz0Syv0H2/nxFvUI
         GW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8F2u7XnHXSi02ZUPPzRhyN9LzC+uyXpgjAwUMrqCak=;
        b=aIQGhrXUWFgLtNhkq9LCI4gOIDpvgNSpY4GHsCeDnQg94ylh4Nmd+yJV7GtU74pYzN
         ErRxitCcXwuCMYu2BxkDtP1j7CO3u9C1hEuDAGkUwqaZ0zpEXoXpYq4JXFSMT3lziJTD
         jl812yu25wHCdCKgxYupi1oBdUBtN1o9JIqeJTs4SSJwab28EHvVT6NRDeoS4LiT41tl
         2Qv0MBQPG+gMYl2M9xiYLVqjNTEEOJYYp454jtqxk1kqbYaPW1PfCdz+hyGIf1xpQsXf
         u8bvIW3Qb11r70NRemXEOh3ZZyWg2kdJHsKxmxgndKonP9kHybx9Bpz/dF+5V5EFKkiA
         dGRg==
X-Gm-Message-State: ACrzQf320OetUwnpi2rIqv8j+YgzXQxcig8yNuBA5krWSfN8AIIgdv3i
        hqYXEk3kdjTgEC5o9qyt7gZErQ/vUw2Aku/Xm4xwvw==
X-Google-Smtp-Source: AMsMyM6nL/sRXxi8Er3YBIrohBZBjtg7i8lTHUQTzLz+CTq7An/c8884aPIg9B8VfXWHYn1xJt/hK/lhb337tElLW/8=
X-Received: by 2002:a17:907:c1e:b0:7ae:31a0:571e with SMTP id
 ga30-20020a1709070c1e00b007ae31a0571emr20575365ejc.690.1667904841694; Tue, 08
 Nov 2022 02:54:01 -0800 (PST)
MIME-Version: 1.0
References: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
 <YyzYKmsjKflqT1xZ@google.com> <Y1aCgJihNIqExUR2@google.com> <CAMRc=McvJ7AvhKdP7cv8K1+rzMf8-ptg2SnU+XOAwERhRx1Eyw@mail.gmail.com>
In-Reply-To: <CAMRc=McvJ7AvhKdP7cv8K1+rzMf8-ptg2SnU+XOAwERhRx1Eyw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 11:53:50 +0100
Message-ID: <CACRpkdaPDXBWKQgNnmBLBmaXDo6roEDSpe1wrvMi_aG5F52K4g@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Get rid of devm_fwnode_get_[index_]gpiod_from_child()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 5:48 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Mon, Oct 24, 2022 at 2:18 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Thu, Sep 22, 2022 at 02:48:26PM -0700, Dmitry Torokhov wrote:
> > > Hi Pavel, Marek,
> > >
> > > On Fri, Sep 02, 2022 at 05:55:24PM -0700, Dmitry Torokhov wrote:
> > > > This drops the last uses of devm_fwnode_get_[index_]gpiod_from_child()
> > > > from the tree and drops the stubs implementing this API on top of
> > > > devm_fwnode_gpiod_get_index().
> > > >
> > > > Note that the bulk of users were converted in 2019, the couple of LED
> > > > drivers are all that have remained.
> > > >
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > >
> > > > ---
> > > > Dmitry Torokhov (3):
> > > >       leds: gpio: switch to using devm_fwnode_gpiod_get()
> > > >       leds: lgm-sso: switch to using devm_fwnode_gpiod_get()
> > > >       gpiolib: remove devm_fwnode_get_[index_]gpiod_from_child()
> > > >
> > > >  drivers/leds/blink/leds-lgm-sso.c |  5 ++---
> > > >  drivers/leds/leds-gpio.c          |  5 ++---
> > > >  include/linux/gpio/consumer.h     | 21 ---------------------
> > > >  3 files changed, 4 insertions(+), 27 deletions(-)
> > > > ---
> > > > base-commit: 7fd22855300e693668c3397771b3a2b3948f827a
> > > > change-id: 20220902-get_gpiod_from_child-remove-a62638849e91
> > > >
> > >
> > > Could you please consider picking this up for 6.1? Or would you be OK
> > > with this going through other tree (GPIO maybe)?
> >
> > *ping* Could this go through GPIO tree? Dropping this API helps with
> > some outstanding work that I have...
> >
>
> Sure! I'll let it wait for another week - it would be great to get an
> ack from Pavel - but in case of no response I'll take it through my
> tree.

I'd say just apply it at this point.

Yours,
Linus Walleij
