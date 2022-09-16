Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464E45BAE81
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiIPNrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiIPNro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:47:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0D2AC269;
        Fri, 16 Sep 2022 06:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB9CDB82712;
        Fri, 16 Sep 2022 13:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B818C4347C;
        Fri, 16 Sep 2022 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663336058;
        bh=2dnMhylsNrNsNLItMEnZ43T1oVmtAZreKgxBvaT/9eo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WpegKpyFx502rj7lii0952PB7E29T2o6SKpt5+eOm17Rex6a67317SXQC9dyUngWu
         1iklOJTELRNuojJa0ZYt3v8qDTpUUiPkpgTlemBFdSGsvR7XVU+0VDYahNz5Eg46hX
         SFQ2U/YPRZBwkgPgwXZVc9wp+zX0gbxh1H+jChxIeTscJcBbD9VtB0YFinoMUuB/LE
         ihBOFCRKNX7oxRnPQZud6r3263tFIWrbhadXRL2BN748PfNOwVNZ3JzE0gue4vl/Lj
         GOZIo2gglPQVFWQ6GH0GSKSUGvGtS15DQ3PfH8Wk1yv8n6jhGFhj5MKsZs5/McMa0m
         UUPCRQA0z4P6g==
Received: by mail-vs1-f44.google.com with SMTP id u189so22739525vsb.4;
        Fri, 16 Sep 2022 06:47:38 -0700 (PDT)
X-Gm-Message-State: ACrzQf1YxQpEKFFM4FnjudexdQuBToTsH9UJZjda/yWCjC0O1Vq7miRq
        f0HHePEAG/Qui1TmujhpOcn11LIQZS1+3HUilg==
X-Google-Smtp-Source: AMsMyM4hRHghOd1aNFyffgJ3uIitF8gTgeI/37lE/Dsyss0jvO67ro2e8NwcXGikWyi5VOzeigfxMJSmCdYfvGw2TWw=
X-Received: by 2002:a67:c097:0:b0:390:d097:df91 with SMTP id
 x23-20020a67c097000000b00390d097df91mr1987519vsi.85.1663336057260; Fri, 16
 Sep 2022 06:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220914151145.73253-1-brgl@bgdev.pl> <CACRpkdZaSL_pkmrVGOT-y7+3i4y6f6Cjgehycq2FKLwPxrbFvw@mail.gmail.com>
 <CAMRc=Me+srb_rwwaUxx1a=8+Wqm5sc2APzfCoFG3+QxRK5kEKA@mail.gmail.com> <CACRpkdZwsLM64m7xHgNg=FPqTYaou9=KpN2rckyp6sKiJokU7A@mail.gmail.com>
In-Reply-To: <CACRpkdZwsLM64m7xHgNg=FPqTYaou9=KpN2rckyp6sKiJokU7A@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 16 Sep 2022 08:47:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKxdX_Pya-N9n+w8a9ZqCa3AdFaRUXu0E31Joyb0psk_w@mail.gmail.com>
Message-ID: <CAL_JsqKxdX_Pya-N9n+w8a9ZqCa3AdFaRUXu0E31Joyb0psk_w@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: TODO: add an item about GPIO safe-state
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 8:12 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Sep 16, 2022 at 9:11 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > Of course we were not the first ones to think about it...
>
> :D
>
> > I'll read through it later. Was there any particular reason why this
> > never made its way into the kernel?
>
> Inability to drive through a DT binding that was acceptable for the
> DT binding maintainers.

AFAICT, this came up briefly in 2015, then 2017, then 2019. (You're a
year late this time.) A nice regular pattern to not get something
upstream...

> A good idea to get it passed I think would be to ask Rob (with some
> examples) how he thinks it should look and finalize the bindings
> before coding.

My issue was more that by the time the kernel or even bootloader runs,
quite a bit of time has passed given all the firmware that runs
nowadays. Doesn't a safe state need to be set as early as possible?
Like probably before anything using DT?

A node per GPIO could end up being a lot of nodes and I can certainly
see folks just initializing every GPIO. That would be a lot of bloat.
As I see it we need 4 bits per line: direction, state(high/low), pull
up/down/none.

Finally, don't non-GPIO pins need the same thing? You don't want a
default output driving what needs to be an input. Of course, a good
h/w designer wouldn't design such a thing.

Rob
