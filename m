Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D619E5B95A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiIOHpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIOHpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:45:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7582CC9A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:45:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u9so40204217ejy.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Bosun96f8TMfDCqWwTtVlpT+bonCDQv+KvF6kBQMBX8=;
        b=4jCzO3HLLCBi5NPL2L+C0+b8SQwdy+Glb5BIwMT2t9SaBQoyD/l0zghvZkXYqUlYfb
         SqPa2DSMk3ZlnF7bqGbWzD73XZCLtD/7mKomRnKLLRu5Hm4ojNzsPm6hu1si0FRdQW5T
         TVTfWQTgoJ1sKRw22jU8Xuja+rRG/AMRMEKEkERH6Hm+KF03UDHLlnfu0yUMc7N8Yooo
         B5bzYbKjitm0kXpFFqehqnvBtjlo6q7SCgg8X4uRArPwRaglzAXfY3By9qqc7FhQtQUa
         HQlpt8nBmiaWHd0huNoqEtxgI+zi6IxOJ+ZX59Ki16I7dCsTqT9MJyK+9Ps4dVXRHF5V
         jLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Bosun96f8TMfDCqWwTtVlpT+bonCDQv+KvF6kBQMBX8=;
        b=ljq8UQaXkr9vfCv9n4ezlxERdZPTcWTI2rOCMDCD1diyuexKeE5nqCRPYVqJp/QWtN
         s7kVd7zYbMkyM/yoIneftC4v3rU5iIT2Qzd4xgV70AlBYCdOBXcWnRnibNck/Vp0vTlG
         EPKgohCQ1k6+13ovumelRiellO9cNrJrbvC7KvTd4zCs1NhWReFdIHDa95dji7s1Vw+K
         IWXIT0euSMAlpjW9DkfRqWuMvDPo5zhrbPfp/RsuYwZAILa4Cbqnf70RD8z4ecqUqgTA
         ava+30yRPxniV+IjvqxVGzbN0OASncNXEQE7hT/HheQjFv3tpm3tX4aCUcC0DDA1JbJK
         di0Q==
X-Gm-Message-State: ACgBeo1AGrfRLBOpO0dau9CR6tKhYrIJWrqIUaBH2LPPCwWSYiRZJ3K5
        AxiVyUIT+7/ZzQJ7ewKCNVD85VHKAzT4Cp2hRGRLmw==
X-Google-Smtp-Source: AA6agR4kuJ81GTOL2NIPCZqGS/eAy9AELyIu2A+RpvsYIDRvcgvm6Cn3ME4fmf5Ih7iL0AY0pIhOtD+MmBnUWyuJVok=
X-Received: by 2002:a17:907:9816:b0:741:89cc:af19 with SMTP id
 ji22-20020a170907981600b0074189ccaf19mr27456998ejc.492.1663227897696; Thu, 15
 Sep 2022 00:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220914151145.73253-1-brgl@bgdev.pl> <YyH/hJMyPZSqyvQj@sol>
 <CAMRc=McERgSkmpWv4k1eB1mtRU=jGhWiXYMdq72h9H9SYuF6Ng@mail.gmail.com> <YyIEbW2gx/FX7ele@sol>
In-Reply-To: <YyIEbW2gx/FX7ele@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 15 Sep 2022 09:44:46 +0200
Message-ID: <CAMRc=MeyPsCzY-mySx7YizpaJ5Dtq4tnjs5ccpT_tm4ckWkuSw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: TODO: add an item about GPIO safe-state
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You call the driver to set the value after calling the free()?
>On Wed, Sep 14, 2022 at 6:42 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Wed, Sep 14, 2022 at 06:25:21PM +0200, Bartosz Golaszewski wrote:
> > On Wed, Sep 14, 2022 at 6:21 PM Kent Gibson <warthog618@gmail.com> wrote:
> > >
> > > On Wed, Sep 14, 2022 at 05:11:45PM +0200, Bartosz Golaszewski wrote:
> > > > This adds a new TODO item for gpiolib and can also be used to start
> > > > a discussion about the need for it and implementation details.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > > > ---
> > > >  drivers/gpio/TODO | 22 ++++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > >
> > > > diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
> > > > index f87ff3fa8a53..6ab39c5cec9d 100644
> > > > --- a/drivers/gpio/TODO
> > > > +++ b/drivers/gpio/TODO
> > > > @@ -197,3 +197,25 @@ A small number of drivers have been converted (pl061, tegra186, msm,
> > > >  amd, apple), and can be used as examples of how to proceed with this
> > > >  conversion. Note that drivers using the generic irqchip framework
> > > >  cannot be converted yet, but watch this space!
> > > > +
> > > > +Safe-state of GPIOs
> > > > +
> > > > +During 2022 Linux Plumbers Conference's GPIO & pinctrl BOF it's been discussed
> > > > +that we don't have any middle ground between hogging GPIO lines and letting the
> > > > +user (either in-kernel or user-space) control them. Either the lines are forever
> > > > +reserved as hogs or their state is undefined unless requested.
> > > > +
> > > > +Currently the behavior of GPIOs that were not requested or were released is
> > > > +largely driver dependent (the provider driver decides whether the line's state
> > > > +is reverted to some predefined value or left as-is). This can be problematic
> > > > +as the output state of a line can damage physical hardware.
> > > > +
> > > > +This item is about proposing a solution, most likely in the form of a new device
> > > > +property called "safe-state" that would define the safe states of specific lines
> > > > +(e.g. output-high) but not block the line from being requested by users who
> > > > +could then modify that default state. Once released the GPIO core would then
> > > > +put the line back into the "safe-state".
> > > > +
> > >
> > > Geert suggests idle-state, rather than safe-state, but you call it
> > > the "default state" here as well - pick one.
> > >
> >
> > idle-state it is then.
> >
> > > So this idle-state would be another attribute on a line that the user
> > > could configure via the GPIO uAPI, and so replicate the "set and forget"
> > > sysfs behavior that we are currently missing, and which seems to be the
> > > biggest sticking point for a transition away from sysfs?
> > >
> >
> > No, this should only be defined on the device tree or in ACPI. As the
> > HW policy of a device. I don't think we should allow user-space to
> > override this behavior.
> >
>
> Oh, ok - from the item I got the impression you did want to be able to
> control it from user-space.
>

Oh god no, then it would be sysfs all over again.

> > > For backward compatibility the default idle-state, i.e. the value the
> > > idle-state would take if not explicitly set, would map to existing
> > > behaviour, so let the driver decide?
> > >
> > > What happens when gpiolib frees the line?  Isn't the driver still able
> > > to do what it likes to the line at that point, no matter what GPIO core
> > > has set it to previously? e.g. gpio_sim_free() restores the line to its
> > > own internal pull value.
> > >
> >
> > This "idle-state" property wouldn't be mandatory and normally would
> > only be defined for a limited set of lines. I'd say we just override
> > whatever the driver does in free() (most drivers don't implement it
> > BTW) and do what the property says we should.
> >
>
> Not sure what "override" involves.
> You call the driver to set the value after calling the free()?
>

Yes. We call the driver's free() callback and it does something in it
(potentially set some predefined state). We see that this line has the
idle-state property defined so we call into the driver and set the
value as defined by idle-state.

Bartosz
