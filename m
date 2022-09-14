Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD445B8D46
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiINQme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiINQm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:42:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976AE5F9B9;
        Wed, 14 Sep 2022 09:42:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u132so15485218pfc.6;
        Wed, 14 Sep 2022 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=zaqHCJKFVIpXVcI6cqDz4v+LUXftpz1B7/9FlIqBoqQ=;
        b=gGnz58MRox4YNeFWFry4YIPObSkyMKov2C1JVGu/mmohwlx4P6pzorSZJR+A7/7AYN
         LvzgRpq3+Aj8VwjgVyslCqxxtPU2tQRB1JYEaMAtg7+QWDZx5CxI6saq7xHmXbOcZTyd
         QGPQz244+TXcFqn2CRf7pXiwgvIj5NXGBfW5BWSkR8Odw3cUHTRGKPGWrolzxOne+02e
         Kl4M72Z1A1kVdpbApgkwKN0FcrHF79tp3dp0T8FnUyhxQN5t7+1Nc7DJe1qlkUMHjyDi
         sKIkd8mSgaX2wcX9hohyokjY0flF6sLhQcySS8/PI19Pv87+dxydenfe+6izat3goV/w
         J3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zaqHCJKFVIpXVcI6cqDz4v+LUXftpz1B7/9FlIqBoqQ=;
        b=zpDywWERWBZKm+TrbM0JkzprRc8br+ZeUc6siCVxWi07suV7ndqAk+pbfVwuFyaozA
         u6O4fF5w2dmoMsgKuy/lVC7fVp0p2nj8JtJwvmaTwykhNiidPPBSFG0EWIx1F+QPEkjV
         EbgJEjaq12vmdW5pkMxsx6Hi9MtCqN+MynKh37LBuYYHJEF8Vz3I6aUmibga/D4+wvDz
         JfJT5s6XfOJZ96+RXZukZYvCXDvRDl+dEnLRvG0YM+qqfbiGNIs6JXVKjYM8gOM9Ciez
         8I+AzYC+caFZnFgtlknJO+GKaw5jt0qa0twwNLc7vcIxy8t1NW5hUr3NRi29qZY4hV7b
         hVLA==
X-Gm-Message-State: ACgBeo29GGHotMVloEMicaDsvMIv1+LGiXeOx2iTMhCfPkK4PsTcEJlX
        Y4nNiJLlcQWAVJebe2UYV7Q=
X-Google-Smtp-Source: AA6agR4/uBvMoZ1Z4yV8jNN81SqW3jeYkItyCZjL1udFx9dZqEUuPnt9Qwqg6dduVO1WeMu5rQC2xQ==
X-Received: by 2002:a63:8bc3:0:b0:439:69c8:9e44 with SMTP id j186-20020a638bc3000000b0043969c89e44mr2574170pge.279.1663173747027;
        Wed, 14 Sep 2022 09:42:27 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b001784a45511asm4158814plh.79.2022.09.14.09.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:42:26 -0700 (PDT)
Date:   Thu, 15 Sep 2022 00:42:21 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: TODO: add an item about GPIO safe-state
Message-ID: <YyIEbW2gx/FX7ele@sol>
References: <20220914151145.73253-1-brgl@bgdev.pl>
 <YyH/hJMyPZSqyvQj@sol>
 <CAMRc=McERgSkmpWv4k1eB1mtRU=jGhWiXYMdq72h9H9SYuF6Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McERgSkmpWv4k1eB1mtRU=jGhWiXYMdq72h9H9SYuF6Ng@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 06:25:21PM +0200, Bartosz Golaszewski wrote:
> On Wed, Sep 14, 2022 at 6:21 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Wed, Sep 14, 2022 at 05:11:45PM +0200, Bartosz Golaszewski wrote:
> > > This adds a new TODO item for gpiolib and can also be used to start
> > > a discussion about the need for it and implementation details.
> > >
> > > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > > ---
> > >  drivers/gpio/TODO | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
> > > index f87ff3fa8a53..6ab39c5cec9d 100644
> > > --- a/drivers/gpio/TODO
> > > +++ b/drivers/gpio/TODO
> > > @@ -197,3 +197,25 @@ A small number of drivers have been converted (pl061, tegra186, msm,
> > >  amd, apple), and can be used as examples of how to proceed with this
> > >  conversion. Note that drivers using the generic irqchip framework
> > >  cannot be converted yet, but watch this space!
> > > +
> > > +Safe-state of GPIOs
> > > +
> > > +During 2022 Linux Plumbers Conference's GPIO & pinctrl BOF it's been discussed
> > > +that we don't have any middle ground between hogging GPIO lines and letting the
> > > +user (either in-kernel or user-space) control them. Either the lines are forever
> > > +reserved as hogs or their state is undefined unless requested.
> > > +
> > > +Currently the behavior of GPIOs that were not requested or were released is
> > > +largely driver dependent (the provider driver decides whether the line's state
> > > +is reverted to some predefined value or left as-is). This can be problematic
> > > +as the output state of a line can damage physical hardware.
> > > +
> > > +This item is about proposing a solution, most likely in the form of a new device
> > > +property called "safe-state" that would define the safe states of specific lines
> > > +(e.g. output-high) but not block the line from being requested by users who
> > > +could then modify that default state. Once released the GPIO core would then
> > > +put the line back into the "safe-state".
> > > +
> >
> > Geert suggests idle-state, rather than safe-state, but you call it
> > the "default state" here as well - pick one.
> >
> 
> idle-state it is then.
> 
> > So this idle-state would be another attribute on a line that the user
> > could configure via the GPIO uAPI, and so replicate the "set and forget"
> > sysfs behavior that we are currently missing, and which seems to be the
> > biggest sticking point for a transition away from sysfs?
> >
> 
> No, this should only be defined on the device tree or in ACPI. As the
> HW policy of a device. I don't think we should allow user-space to
> override this behavior.
> 

Oh, ok - from the item I got the impression you did want to be able to
control it from user-space.

> > For backward compatibility the default idle-state, i.e. the value the
> > idle-state would take if not explicitly set, would map to existing
> > behaviour, so let the driver decide?
> >
> > What happens when gpiolib frees the line?  Isn't the driver still able
> > to do what it likes to the line at that point, no matter what GPIO core
> > has set it to previously? e.g. gpio_sim_free() restores the line to its
> > own internal pull value.
> >
> 
> This "idle-state" property wouldn't be mandatory and normally would
> only be defined for a limited set of lines. I'd say we just override
> whatever the driver does in free() (most drivers don't implement it
> BTW) and do what the property says we should.
> 

Not sure what "override" involves.
You call the driver to set the value after calling the free()?

Cheers,
Kent.
