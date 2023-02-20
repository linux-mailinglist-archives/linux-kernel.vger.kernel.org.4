Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7EB69D14F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjBTQ2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjBTQ2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:28:02 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3661D929
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:28:01 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id h32so7028999eda.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69UoyhynNUYNEwzuSxpqdt3baE4RR//w0yvaBYPVpeY=;
        b=oynaTcYZr3E9sKQ7q+HeAZj6hRXQVN8J0XkwicwQGli0fyYTsLvK8DRx4uDM/NxTda
         s8kM0ZiMqwh/kDBEC1Mn+paYCa3tyKFne089sm3asKlXJ403tKNybdu+ninfnxILYHY2
         gP3kp3om4A6vwIFqtVVk5Fhxg7PCACmPQKRUvhGYdy1gakg+QsKSXwNXCXFS3/0LTI/K
         lW3y48GnaIeeoP7unuth7Bf6f+nXMTg7TnL0cLg5uSnOHLjBLBgkA43FHL0TCQV2Tosb
         DQD8wOuIDDU2Ofn6/CldJLgzjgzUrx5O5rGIP2ZKjB7rLvAlQOS5nmlhFN/H5OYbtWct
         gLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69UoyhynNUYNEwzuSxpqdt3baE4RR//w0yvaBYPVpeY=;
        b=bU37fJJx367sL0iM/pAh0HWYAUTpL6wOPZu3awTpRsTKKuCMY/c6EJUBqoWidhOxr0
         ujQQPUbPbqMA0eKnIfl07GD4I+XXVuwlagt2jDfwMv7HoWAzdE15v/54GXcwVZZLTDCu
         ij/ut8/83kvZWdzDd2O1NwHWFATzYq8dfjERPtQFvzSnoWh8LbAHlgwvEPuAAR374TaX
         U6QZNz9pcdT6Mh2rIxOuBPFamMC8fCyTEN3qtCDFa2/d+6Q6ewMLL3ML37XczclSAHN7
         7t/cYzOfMs+oXwEJuBops4qu42dvpma10iAqPkSTaNCX0722B/RU16aJmg5Mh8D5u6y+
         Lmsw==
X-Gm-Message-State: AO0yUKWYvjyuw+E+H1jkYEouvVcq2bSQ6/jwaxeJve9dSP/fr/eD9NFC
        x/TdGx47amfpo5eOYASEEgiRkA==
X-Google-Smtp-Source: AK7set/fQ13rd8Io1HtU5LyMwdizy/1uHMt9G2Hc7QHBrc71rUgYnqPZbMXetLGSvFpzkSc0IlHT2A==
X-Received: by 2002:aa7:c2c7:0:b0:4ac:b7ba:3d58 with SMTP id m7-20020aa7c2c7000000b004acb7ba3d58mr2202304edp.12.1676910479631;
        Mon, 20 Feb 2023 08:27:59 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170907760e00b008cc920469b5sm2181256ejc.18.2023.02.20.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 08:27:59 -0800 (PST)
Date:   Mon, 20 Feb 2023 18:27:57 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mka@chromium.org,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for
 disabling unused clocks
Message-ID: <Y/OfjbxI1tHYJHNv@linaro.org>
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
 <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org>
 <Y/OV3CF0ootyooDJ@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/OV3CF0ootyooDJ@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-20 17:46:36, Abel Vesa wrote:
> On 23-02-17 21:38:22, Stephen Boyd wrote:
> > Quoting Abel Vesa (2022-12-27 12:45:27)
> > > There are unused clocks that need to remain untouched by clk_disable_unused,
> > > and most likely could be disabled later on sync_state. So provide a generic
> > > sync_state callback for the clock providers that register such clocks.
> > > Then, use the same mechanism as clk_disable_unused from that generic
> > > callback, but pass the device to make sure only the clocks belonging to
> > > the current clock provider get disabled, if unused. Also, during the
> > > default clk_disable_unused, if the driver that registered the clock has
> > > the generic clk_sync_state_disable_unused callback set for sync_state,
> > > skip disabling its clocks.
> > 
> > How does that avoid disabling clks randomly in the clk tree? I'm
> > concerned about disabling an unused clk in the middle of the tree
> > because it doesn't have a driver using sync state, while the clk is the
> > parent of an unused clk that is backed by sync state.
> > 
> >    clk A -->  clk B 
> > 
> > clk A: No sync state
> > clk B: sync state
> > 
> > clk B is left on by the bootloader. __clk_disable_unused(NULL) is called
> > from late init. Imagine clk A is the root of the tree.
> > 
> > 	clk_disable_unused_subtree(clk_core A)
> > 	  clk_disable_unused_subtree(clk_core B)
> > 	    if (from_sync_state && core->dev != dev)
> > 	      return;
> > 	  ...
> > 	  clk core A->ops->disable()
> > 
> > clk core B is off now?
> 
> Yes, that is correct. But the same thing is happening currently if the
> clk_ignore_unused in not specified. At least with this new approach, we
> get to leave unused clocks enabled either until sync_state is called or forever.
> All the provider has to do is to implement a sync_state callback (or use
> the generic one provided). So the provider of clk A would obviously need
> a sync state callback registered.
> 
> > 
> > Also sync_state seems broken right now. I saw mka mentioned that if you
> > have a device node enabled in your DT but never enable a driver for it
> > in the kernel we'll never get sync_state called. This is another
> > problem, but it concerns me that sync_state would make the unused clk
> > disabling happen at some random time or not at all.
> 
> Well, the fact that the sync state not being called because a driver for
> a consumer device doesn't probe does not really mean it is broken. Just
> because the consumer driver hasn't probed yet, doesn't mean it will
> not probe later on.
> 

CC'ed Saravana

> That aside, rather than going with clk_ignore_unused all the time on
> qcom platforms, at least in a perfect scenario (where sync state is
> reached for all providers) the clocks get disabled.
> 
> > 
> > Can the problem be approached more directly? If this is about fixing
> > continuous splash screen, then I wonder why we can't list out the clks
> > that we know are enabled by the bootloader in some new DT binding, e.g.:
> > 
> > 	clock-controller {
> > 		#clock-cells = <1>;
> > 		boot-handoff-clocks = <&consumer_device "clock cells for this clk provider">;
> > 	};
> > 
> > Then mark those as "critical/don't turn off" all the way up the clk tree
> > when the clk driver probes by essentially incrementing the
> > prepare/enable count but not actually touching the hardware, and when
> > the clks are acquired by clk_get() for that device that's using them
> > from boot we make the first clk_prepare_enable() do nothing and not
> > increment the count at all. We can probably stick some flag into the
> > 'struct clk' for this when we create the handle in clk_get() so that the
> > prepare and enable functions can special case and skip over.
> 
> Well, that means we need to play whack-a-mole by alsways adding such clocks to
> devicetree.
> 
> > 
> > The sync_state hook operates on a driver level, which is too large when
> > you consider that a single clk driver may register hundreds of clks that
> > are not related. We want to target a solution at the clk level so that
> > any damage from keeping on all the clks provided by the controller is
> > limited to just the drivers that aren't probed and ready to handle their
> > clks. If sync_state could be called whenever a clk consumer consumes a
> > clk it may work? Technically we already have that by the clk_hw_provider
> > function but there isn't enough information being passed there, like the
> > getting device.
> 
> Actually, from the multitude of clocks registered by one provider, the
> ones already explicitely enabled (and obvisously their parents) by thier
> consumer are safe. The only ones we need to worry about are the ones that
> might be enabled by bootloader and need to remain on. With the sync state
> approach, the latter mentioned clocks will either remain on indefinitely
> or will be disabled on sync state. The provider driver is the only level
> that has a registered sync state callback.
> 
> > 
> > > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > > index 842e72a5348f..cf1adfeaf257 100644
> > > --- a/include/linux/clk-provider.h
> > > +++ b/include/linux/clk-provider.h
> > > @@ -720,6 +720,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
> > >                 void __iomem *reg, u8 shift, u8 width,
> > >                 u8 clk_divider_flags, const struct clk_div_table *table,
> > >                 spinlock_t *lock);
> > > +void clk_sync_state_disable_unused(struct device *dev);
> > 
> > This is a weird place to put this. Why not in the helper functions
> > section?
> 
> Sure this can be moved.
> 
> > 
> > >  /**
> > >   * clk_register_divider - register a divider clock with the clock framework
> > >   * @dev: device registering this clock
