Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929655B8CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiINQZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiINQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:25:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253797D1DE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:25:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m1so23016955edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FodkllfW5mSVFcv5dyl2Dr5bB4IrI1aqYiKSRIoDQaw=;
        b=R2eRbrqH1nc3Vp0QRlYBSW1CCbZ3AGGY+6y1IPAvAJCyznZe3OwPiBdtbV3LkNaEja
         JCBYsEv8jJ7tSHkJou2v1wFSzj8RHp93ei5EcQM+t7qWTNta8RW43zykJhxiu8H+DDtr
         7ce9IRwFxP18P/yanJo2JK7hTR2X2pTnpkr9Xa/6aCGyakxjvCN+7Sa2WCcJk0Zr9+eE
         XOaQ5CVBeacnPtvw0/C6I37SBIGL7tE0Jh2O5KBuWhPCTtuguZdjINBYXKTimpVjisVU
         rzI1h8tln71tPTfufHef7NLw6t7eXmc4ZszYFitRdGhqryil5k9aAeLgW374t+iMmtB0
         zpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FodkllfW5mSVFcv5dyl2Dr5bB4IrI1aqYiKSRIoDQaw=;
        b=H7fZ+PIVxDYrEcUjpsorxPQnLHZapvv0b/A4GHfQ8D23WFWBKtXZNiz+GENjTtKs1E
         S/tLKIOgxnfyajQ6tlu2lnjCTEs8vd/floZnyYuhqFty1ipuMKf+xFG4t4NRmSLBZLoB
         hSkQpho0ox5Ugkn8Pczr690zuRnd4OPt+gnrZoAS6VVpYADqWErvu57LXChzvt01vTkm
         d149Aq5l5+dkemPzcQ0A0nAfCpCnn7R52coBkg866BKKrGSbiX+dwA+QoSGnTKQVkoNm
         iDYNh3/lEG5NlLqkSm7xm2DQuLYhSrkdxRBMI4oa6LIATu9hf4HkLAP6PobxtnqUa1Ud
         jHiA==
X-Gm-Message-State: ACgBeo3Y4tQl2HD0OP8LAdbDoUv6XIYwd6zOuScJHaeY+gKpqrvIyfFF
        aAbKIr74H4SqrqWK3QmkB3fU0hJsM3AI7icBff1Wjg==
X-Google-Smtp-Source: AA6agR6/5sgTxAc62jLsnscMZnpHygzSfirD8uXrKdMgu/w+pO5mj6PzSFIsuL/wv0EJbA5x6VoePTJ6K2YulkpOm2w=
X-Received: by 2002:aa7:dd02:0:b0:44e:f7af:b996 with SMTP id
 i2-20020aa7dd02000000b0044ef7afb996mr31587967edv.422.1663172732652; Wed, 14
 Sep 2022 09:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220914151145.73253-1-brgl@bgdev.pl> <YyH/hJMyPZSqyvQj@sol>
In-Reply-To: <YyH/hJMyPZSqyvQj@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 14 Sep 2022 18:25:21 +0200
Message-ID: <CAMRc=McERgSkmpWv4k1eB1mtRU=jGhWiXYMdq72h9H9SYuF6Ng@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 6:21 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Wed, Sep 14, 2022 at 05:11:45PM +0200, Bartosz Golaszewski wrote:
> > This adds a new TODO item for gpiolib and can also be used to start
> > a discussion about the need for it and implementation details.
> >
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > ---
> >  drivers/gpio/TODO | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
> > index f87ff3fa8a53..6ab39c5cec9d 100644
> > --- a/drivers/gpio/TODO
> > +++ b/drivers/gpio/TODO
> > @@ -197,3 +197,25 @@ A small number of drivers have been converted (pl061, tegra186, msm,
> >  amd, apple), and can be used as examples of how to proceed with this
> >  conversion. Note that drivers using the generic irqchip framework
> >  cannot be converted yet, but watch this space!
> > +
> > +Safe-state of GPIOs
> > +
> > +During 2022 Linux Plumbers Conference's GPIO & pinctrl BOF it's been discussed
> > +that we don't have any middle ground between hogging GPIO lines and letting the
> > +user (either in-kernel or user-space) control them. Either the lines are forever
> > +reserved as hogs or their state is undefined unless requested.
> > +
> > +Currently the behavior of GPIOs that were not requested or were released is
> > +largely driver dependent (the provider driver decides whether the line's state
> > +is reverted to some predefined value or left as-is). This can be problematic
> > +as the output state of a line can damage physical hardware.
> > +
> > +This item is about proposing a solution, most likely in the form of a new device
> > +property called "safe-state" that would define the safe states of specific lines
> > +(e.g. output-high) but not block the line from being requested by users who
> > +could then modify that default state. Once released the GPIO core would then
> > +put the line back into the "safe-state".
> > +
>
> Geert suggests idle-state, rather than safe-state, but you call it
> the "default state" here as well - pick one.
>

idle-state it is then.

> So this idle-state would be another attribute on a line that the user
> could configure via the GPIO uAPI, and so replicate the "set and forget"
> sysfs behavior that we are currently missing, and which seems to be the
> biggest sticking point for a transition away from sysfs?
>

No, this should only be defined on the device tree or in ACPI. As the
HW policy of a device. I don't think we should allow user-space to
override this behavior.

> For backward compatibility the default idle-state, i.e. the value the
> idle-state would take if not explicitly set, would map to existing
> behaviour, so let the driver decide?
>
> What happens when gpiolib frees the line?  Isn't the driver still able
> to do what it likes to the line at that point, no matter what GPIO core
> has set it to previously? e.g. gpio_sim_free() restores the line to its
> own internal pull value.
>

This "idle-state" property wouldn't be mandatory and normally would
only be defined for a limited set of lines. I'd say we just override
whatever the driver does in free() (most drivers don't implement it
BTW) and do what the property says we should.

Bart
