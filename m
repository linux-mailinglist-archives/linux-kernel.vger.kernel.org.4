Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686BF6986D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjBOVC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjBOVB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:01:56 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A9B279A5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:00:01 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4a263c4ddbaso301454197b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PU7uQjOcJI1X0s6XD/UlR1JC6w4DuroYdHadnqtLfV8=;
        b=c1BMLkgVY3uKTU5PQmO5ZxkzyjKc1+NU3fHYy4ga4wpUdsQk+fspTUj0Lv5C2dJeYG
         vVTGmdwdmdCjrO95C7rVatz5dt6aqYT8KnA5Mx2MocLBk1hroCs+r/CbJ2m4daCu864E
         LfH9cc1CF88VjAiJJoknIMpCCbbwNQD9FK7Dl7FM8L2SF+MLoheYfX9TgP7Bu0pDJGq/
         sls3jSl0X5/mzO9TXCbvrMYQxbD9VXjl4T4HiAEa7AcgWuwXo4Sv/hVPSN/HvGxhoBT/
         YjtjBO4vOx2z+f3buo9vf4Iy7uiHim5uzr/rPfweCzVmLCsdqLejJ99ru+CIRrTelsj0
         K+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PU7uQjOcJI1X0s6XD/UlR1JC6w4DuroYdHadnqtLfV8=;
        b=I3H2hRGjS+O+fmGEuDEvcuDdDIKgyHXw7RM9JPGI76wz8tULbi/a7ZiP7h0jrna7u2
         v4QaxcrFVVb0WWY4/meW8U2k3h9ypGYG7EVRLHwSZN6J2byrBzBh8ObDvW70nU2QRrKf
         j9RUT6ZTn0teBYrCQkRW5CA/Zeb6XR5YZ5D+YBtHkz+eL62q3XzMRCESjnlQBMYPapEx
         xGYPcoX6b9gze+DvPgA0P0y49pJQhligXRLEgm4a5+oyS8xkAOw5VuYVWHEb74AjEu0t
         A+QbCruT5gxlWUqB+BMnHit9VKvx9fgvHdh0NNPWP5uTPGjeee5c628rHFXDruIsZSfg
         fmgw==
X-Gm-Message-State: AO0yUKUTvqtNgiY5VkuCc1QMtTLrbaAjrdbYxyYdtbtfpC691gjaJUj3
        XXXf7Ll3F5n2fF/CSFz67hWlyqiEJ0DRzE1fFtn6
X-Google-Smtp-Source: AK7set9GgevWTYzK7KxUtPnop6l7D3ePMYWT6Tcj3no/q3eFuol33EfVOuzpuSp95+V08yI21W6HfQtCjFkRF0yLUpU=
X-Received: by 2002:a81:7306:0:b0:52a:92b6:e24b with SMTP id
 o6-20020a817306000000b0052a92b6e24bmr483218ywc.179.1676494801022; Wed, 15 Feb
 2023 13:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20230214105412.5856-1-walter.chang@mediatek.com>
 <20230214105412.5856-5-walter.chang@mediatek.com> <1726f1d2-7411-2b49-79cd-f5aecff2d19e@linaro.org>
 <CANDhNCrYaepM3d-xHybqc9n5j0q0iMfPiTGPZKskEWjqjD6nRA@mail.gmail.com> <12f2d6a8-e16f-5bac-10ee-035c1b4b0356@linaro.org>
In-Reply-To: <12f2d6a8-e16f-5bac-10ee-035c1b4b0356@linaro.org>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 15 Feb 2023 12:59:49 -0800
Message-ID: <CANDhNCrae9=8-w9-Qaq527-j8qMYzHGiAXAmKpxsoxD4=UP5zg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] clocksource/drivers/timer-mediatek: Make
 timer-mediatek become loadable module
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     walter.chang@mediatek.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 10:35 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/02/2023 00:20, John Stultz wrote:
> > On Tue, Feb 14, 2023 at 3:09 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >> On 14/02/2023 11:53, walter.chang@mediatek.com wrote:
> >>> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> >>>
> >>> Make the timer-mediatek driver which can register
> >>> an always-on timer as tick_broadcast_device on
> >>> MediaTek SoCs become loadable module in GKI.
> >>
> >> Other questions are unanswered. Please do not ignore feedback and
> >> respond to it.
> >>
> >
> > Apologies, I know it can be a pain to repeat yourself, but would you
> > clarify which questions were unanswered?
> > My initial skim made it seem like the items you raised were addressed
> > in some form (though maybe not sufficiently?).
>
> Questions were:
>
> 1. IOW, does the system boot fine? What's the impact of this being a module?

I believe this was answered in the cover letter.
" If the system does not load this module at startup, system will also
boot normally by using built-in architecture timer (in this case is
Arm Generic Timer) instead."

> 2. It is not the first time there is a proposal to convert the timers to
> modules. After asking, nobody came with a real study regarding the
> impact of the modularization of these drivers vs the time core framework
> and the benefit.

Maybe it would be helpful to be more specific in the criteria you're
looking for in such a study?

At least with the GKI, there is a need to support a wide array of
hardware, while minimizing the memory overhead of unnecessary code on
each device. As I mentioned in an earlier reply, this is kernel wide,
so while moving a single driver out to being a module isn't going to
be very substantial, the cumulative effect of not having to build in
every driver needed adds up.

So I think asking to see how much the kernel size changes by
modularizing this one initial driver is a reasonable request, though
I'd not expect it to be a huge gain on its own, but a reduction is a
reduction, and I'm not sure there are many clear downsides.

Again, it's not expected that every driver can be moved to a module,
as there are a number of cases where we need the functionality to be
present early in boot, and that's fine.

> 3. We need to tests that involve loading and unloading of such
> modules to see if the transition between this timer as broadcast and one
> CPU itself as broadcast happens correctly and system survives across such
> loading and unloading of the modules.

Modules may be permanent and not unloadable (this patch doesn't
provide a remove hook). While unloadable modules are abstractly nicer,
for supporting a wide array of hardware with minimal memory impact,
permanent modules are equally beneficial (only load them on hardware
that needs them, from that point there is no need to unload them). So
I'm not sure there's much practical value in unloading them.

As for testing the loading side, that sounds fair, though I'd expect
that to be done as part of developing the patch.

So maybe Walter can confirm the device works appropriately across many
boot ups where the module is loaded in their testing? If there is a
specific test criteria you would like to see, please clarify.

And, many thanks for re-outlining your concerns here! I appreciate it!

thanks
-john
