Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A705E69E8B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjBUT7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjBUT7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:59:05 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C922E80D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:59:02 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id a7so3373726pfx.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677009542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7eq+GLjk+av91BYy8K1H8/nqn9j1Ssh66EQWIUoWV8U=;
        b=f4Rx0zt4bBRl99OfPGExycd3qJ0qO5L7Lz83N1qPPkG/HOjwjbaOgNNJ+L0PJJ1MG8
         vAKh/dEeFSNmSHEzJzAI5nWPSMxbe7lwiV1eQl4UyJwtA0x/oAORYIE9Ny8nbubmlXs6
         30rKoDWsAtTXIDCCWVQ35d61GZdJqCQmjCwL4WR+kX3sLL+yzjHWuRTdU4n8yCoWkhQQ
         3QH4WALc7JnhQxpKiTu9uH76wrxcntaaEhxjU5ODdYAwMqy32CroPUcgnyBhKWJVQUdg
         /KfUuzr1FDGy3zTGGzUapXit+d+3dQG6wFgyDl5QQ6TQai9azs+Hjs9pqV5LxSw3XsTK
         5+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677009542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eq+GLjk+av91BYy8K1H8/nqn9j1Ssh66EQWIUoWV8U=;
        b=fZLjmVt25B29k0vv+CCKJiNUvOn2O9Dsp9BDbeJac/8OzWdQUnzp7OLBtIUqTWEXAf
         o2xEQSs1wbBihaLzDolQkm3Q5JCcAOGTEpLC3YNVBcut7OqqQKYawSy/isZQcgYLwKdP
         8vBSD3MSYm+XiQUjVybuundcD3RcQN0iP+lfAU602tvfoUhd/4p4TB/bkPprsl66+T0M
         TyTf933JH7kIuCltZweVL2sPUcTBgD3XPmp1DaFH6B1KzS7OyePNLF+A2LZFgOxeuhEr
         P7QLgyvIxy88OtAFZUtfkBhFDw+sI7iDlo3wVnf5Iz98mVTfa18iBWi2u05ZaMbwgx5t
         VuEg==
X-Gm-Message-State: AO0yUKUjlvexDRf3lbyS+udiA4t0TSB0tpEWYzPRrFp0SH0p91s9c2mr
        aqV22ACMwPj0/8uK/oZIazJeXbw8GXpacIbpHUrVXQ==
X-Google-Smtp-Source: AK7set/oKDe4l9jN3bUlPuAnUw9TY87yypO5sFUEynIDS3p3A4+Q5qMQivZkCgbUfGJcOBuP4O/WChZ8shBFhbRgMYo=
X-Received: by 2002:a62:3103:0:b0:5a8:4dea:7015 with SMTP id
 x3-20020a623103000000b005a84dea7015mr904607pfx.36.1677009541669; Tue, 21 Feb
 2023 11:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
 <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org> <Y/OV3CF0ootyooDJ@linaro.org>
 <Y/OfjbxI1tHYJHNv@linaro.org> <CAGETcx_mD3pbAmT5FDZaVAsKb_2PAnrHL8B_6gSR=+a0O4kHfQ@mail.gmail.com>
 <Y/PALlrQpwPlum9M@linaro.org>
In-Reply-To: <Y/PALlrQpwPlum9M@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 21 Feb 2023 11:58:24 -0800
Message-ID: <CAGETcx_TZN3=GKrEf5fy_tA=JnOfw7m-N=+hD=qhe_yRRpngPw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for disabling
 unused clocks
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mka@chromium.org
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

On Mon, Feb 20, 2023 at 10:47 AM Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 23-02-20 09:51:55, Saravana Kannan wrote:
> > On Mon, Feb 20, 2023 at 8:28 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > On 23-02-20 17:46:36, Abel Vesa wrote:
> > > > On 23-02-17 21:38:22, Stephen Boyd wrote:
> > > > > Quoting Abel Vesa (2022-12-27 12:45:27)
> > > > > > There are unused clocks that need to remain untouched by clk_disable_unused,
> > > > > > and most likely could be disabled later on sync_state. So provide a generic
> > > > > > sync_state callback for the clock providers that register such clocks.
> > > > > > Then, use the same mechanism as clk_disable_unused from that generic
> > > > > > callback, but pass the device to make sure only the clocks belonging to
> > > > > > the current clock provider get disabled, if unused. Also, during the
> > > > > > default clk_disable_unused, if the driver that registered the clock has
> > > > > > the generic clk_sync_state_disable_unused callback set for sync_state,
> > > > > > skip disabling its clocks.
> >
> > Hi Abel,
> >
> > We have the day off today, so I'll respond more later. Also, please cc
> > me on all sync_state() related patches in the future.
> >
>
> Sure thing.
>
> > I haven't taken a close look at your series yet, but at a glance it
> > seems incomplete.
> >
> > Any reason you didn't just try to revive my series[1] or nudge me?
> > [1]- https://lore.kernel.org/lkml/20210407034456.516204-3-saravanak@google.com/
>
> This patchset is heavily reworked and much more simpler as it relies
> strictly on the sync_state being registered by the clock provider.

It's simpler because it's not complete. It for sure doesn't handle
orphan-reparenting. It also doesn't make a lot of sense for only some
clock providers registering for sync_state(). If CC-A is feeding a
clock signal that's used as a root for clocks in CC-B, then what
happens if only CC-B implements sync_state() but CC-A doesn't. The
clocks from CC-B are still going to turn off when CC-A turns off its
PLL before CC-B registers.

Nack for this patch.

Also, unless there's a strong objection, let's go back to my patch
please. It's way more well tested and used across different SoCs than
this patch. Also, I'm pretty sure the orphan handling is needed for
qcom SoC's too.

-Saravana

>
> I saw your patchset a few months ago but then forgot about its
> existence. That's also why I forgot to nudge you. Sorry about that.
>
> >
> > At the least, I know [1] works on all Android devices (including
> > Qualcomm SoCs) released in the past 2-3 years or more. If [1] works
> > for you, I'd rather land that after addressing Stephen's comments
> > there (I remember them being fairly easy to address comments) instead
> > of whipping up a new series that's not as well used. I just got busy
> > with other things and addressing more fundamental fw_devlink TODOs
> > before getting back to this.
> >
> > Hi Bjorn,
> >
> > I see in another reply you've said:
> >
> > Applied, thanks!
> >
> > [1/2] clk: Add generic sync_state callback for disabling unused clocks
> >       commit: 26b36df7516692292312063ca6fd19e73c06d4e7
> > [2/2] clk: qcom: sdm845: Use generic clk_sync_state_disable_unused callback
> >       commit: 99c0f7d35c4b204dd95ba50e155f32c99695b445
> >
> > Where exactly have you applied them? I hope you haven't applied the
> > clk.c changes to some tree that goes into 6.3.
>
> I think it is already part of Bjorn's Qualcomm clocks pull request.
>
> >
> > -Saravana
> >
> > > > >
> > > > > How does that avoid disabling clks randomly in the clk tree? I'm
> > > > > concerned about disabling an unused clk in the middle of the tree
> > > > > because it doesn't have a driver using sync state, while the clk is the
> > > > > parent of an unused clk that is backed by sync state.
> > > > >
> > > > >    clk A -->  clk B
> > > > >
> > > > > clk A: No sync state
> > > > > clk B: sync state
> > > > >
> > > > > clk B is left on by the bootloader. __clk_disable_unused(NULL) is called
> > > > > from late init. Imagine clk A is the root of the tree.
> > > > >
> > > > >     clk_disable_unused_subtree(clk_core A)
> > > > >       clk_disable_unused_subtree(clk_core B)
> > > > >         if (from_sync_state && core->dev != dev)
> > > > >           return;
> > > > >       ...
> > > > >       clk core A->ops->disable()
> > > > >
> > > > > clk core B is off now?
> > > >
> > > > Yes, that is correct. But the same thing is happening currently if the
> > > > clk_ignore_unused in not specified. At least with this new approach, we
> > > > get to leave unused clocks enabled either until sync_state is called or forever.
> > > > All the provider has to do is to implement a sync_state callback (or use
> > > > the generic one provided). So the provider of clk A would obviously need
> > > > a sync state callback registered.
> > > >
> > > > >
> > > > > Also sync_state seems broken right now. I saw mka mentioned that if you
> > > > > have a device node enabled in your DT but never enable a driver for it
> > > > > in the kernel we'll never get sync_state called. This is another
> > > > > problem, but it concerns me that sync_state would make the unused clk
> > > > > disabling happen at some random time or not at all.
> > > >
> > > > Well, the fact that the sync state not being called because a driver for
> > > > a consumer device doesn't probe does not really mean it is broken. Just
> > > > because the consumer driver hasn't probed yet, doesn't mean it will
> > > > not probe later on.
> > > >
> > >
> > > CC'ed Saravana
> > >
> > > > That aside, rather than going with clk_ignore_unused all the time on
> > > > qcom platforms, at least in a perfect scenario (where sync state is
> > > > reached for all providers) the clocks get disabled.
> > > >
> > > > >
> > > > > Can the problem be approached more directly? If this is about fixing
> > > > > continuous splash screen, then I wonder why we can't list out the clks
> > > > > that we know are enabled by the bootloader in some new DT binding, e.g.:
> > > > >
> > > > >     clock-controller {
> > > > >             #clock-cells = <1>;
> > > > >             boot-handoff-clocks = <&consumer_device "clock cells for this clk provider">;
> > > > >     };
> > > > >
> > > > > Then mark those as "critical/don't turn off" all the way up the clk tree
> > > > > when the clk driver probes by essentially incrementing the
> > > > > prepare/enable count but not actually touching the hardware, and when
> > > > > the clks are acquired by clk_get() for that device that's using them
> > > > > from boot we make the first clk_prepare_enable() do nothing and not
> > > > > increment the count at all. We can probably stick some flag into the
> > > > > 'struct clk' for this when we create the handle in clk_get() so that the
> > > > > prepare and enable functions can special case and skip over.
> > > >
> > > > Well, that means we need to play whack-a-mole by alsways adding such clocks to
> > > > devicetree.
> > > >
> > > > >
> > > > > The sync_state hook operates on a driver level, which is too large when
> > > > > you consider that a single clk driver may register hundreds of clks that
> > > > > are not related. We want to target a solution at the clk level so that
> > > > > any damage from keeping on all the clks provided by the controller is
> > > > > limited to just the drivers that aren't probed and ready to handle their
> > > > > clks. If sync_state could be called whenever a clk consumer consumes a
> > > > > clk it may work? Technically we already have that by the clk_hw_provider
> > > > > function but there isn't enough information being passed there, like the
> > > > > getting device.
> > > >
> > > > Actually, from the multitude of clocks registered by one provider, the
> > > > ones already explicitely enabled (and obvisously their parents) by thier
> > > > consumer are safe. The only ones we need to worry about are the ones that
> > > > might be enabled by bootloader and need to remain on. With the sync state
> > > > approach, the latter mentioned clocks will either remain on indefinitely
> > > > or will be disabled on sync state. The provider driver is the only level
> > > > that has a registered sync state callback.
> > > >
> > > > >
> > > > > > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > > > > > index 842e72a5348f..cf1adfeaf257 100644
> > > > > > --- a/include/linux/clk-provider.h
> > > > > > +++ b/include/linux/clk-provider.h
> > > > > > @@ -720,6 +720,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
> > > > > >                 void __iomem *reg, u8 shift, u8 width,
> > > > > >                 u8 clk_divider_flags, const struct clk_div_table *table,
> > > > > >                 spinlock_t *lock);
> > > > > > +void clk_sync_state_disable_unused(struct device *dev);
> > > > >
> > > > > This is a weird place to put this. Why not in the helper functions
> > > > > section?
> > > >
> > > > Sure this can be moved.
> > > >
> > > > >
> > > > > >  /**
> > > > > >   * clk_register_divider - register a divider clock with the clock framework
> > > > > >   * @dev: device registering this clock
