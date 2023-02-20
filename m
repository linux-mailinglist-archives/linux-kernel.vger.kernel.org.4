Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856A869D0DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjBTPqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjBTPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:46:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A421B571
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:46:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id da10so7567776edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MgpWFr42yyB70QXJviPiRhFMPmBtcy7arHMU218wFoA=;
        b=YG3EAlqSZvciLAdyppJGhSknjHtILO1vHLGwhzDP1HcWLEbcio5KSVrJGsChged1Fx
         dTCsYV8e4XuQkU9lFJasl+AnMjfG5jd9rewIXQywaQu0PMBgb5brGNlq0qMmVtNi5j8c
         a0EEKOlinSTxyp4elYG9hVBTPbxQM2HBx4N3szj6WP8c7IH+5zK2sstl2mmLtmX6fp8O
         sVVW4rxiowjq4qt4HcPHEKBpk9ZHJv6E3gHvGn4r4e2CNz/73VA7PB7jnZxRXanXMzQF
         6cFww8VVWGX+iCLT4anVObWSTO+1xjkbeZWFD2UK6WA3fD0nQP+h+sWu4uh7LyoshNEo
         Y2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgpWFr42yyB70QXJviPiRhFMPmBtcy7arHMU218wFoA=;
        b=pZPYm21yPlAG2QTIiqLGdbLMrI+ggzT9cA5hhRAYgVBR6CkxkLkPepx41e/dxiC7dd
         pxBD4On3VjfyAJXKLGpat29GgPMMH2U1+FKcxkJchouRyP9lYEHk4Q4uiVEu4C5495Qf
         0NCnX5xIl53MQ/mz74dPMpkBLoLZKS7hS/0SslbOR/Zk+oI7x9/UDBwi1wMk9SZgVF42
         pFD3V8+jziE+uob/w1xiJxtl8RRT9/VV7l3cJCQl74AZv/aG03igmE8JxkjKWx7LJJ06
         so+8Uxod6vb/AvziMyTqiNmIAZnSS7a3CmTdUsTsJZAP/+sN0HpprGwc4TNIPgaL0wDm
         OPpQ==
X-Gm-Message-State: AO0yUKU1k50dfDMrfFmcxr30M2ZEmS81JJq8EvWYVWk2p1YXkS4qMXLU
        bZOldSLCQnppctHWTn9KwSMQ1Q==
X-Google-Smtp-Source: AK7set8UdxThUko8BY/93y4ZBzuOyJz3wtqFjQJk+1EmT98vdZiKltWaWOtk7xojW3JetFYGdOTyew==
X-Received: by 2002:a17:907:2cc7:b0:8b0:23a6:c491 with SMTP id hg7-20020a1709072cc700b008b023a6c491mr15844987ejc.31.1676907999030;
        Mon, 20 Feb 2023 07:46:39 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709060d8800b0084d381d0528sm5973544eji.180.2023.02.20.07.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 07:46:38 -0800 (PST)
Date:   Mon, 20 Feb 2023 17:46:36 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mka@chromium.org
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for
 disabling unused clocks
Message-ID: <Y/OV3CF0ootyooDJ@linaro.org>
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
 <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-17 21:38:22, Stephen Boyd wrote:
> Quoting Abel Vesa (2022-12-27 12:45:27)
> > There are unused clocks that need to remain untouched by clk_disable_unused,
> > and most likely could be disabled later on sync_state. So provide a generic
> > sync_state callback for the clock providers that register such clocks.
> > Then, use the same mechanism as clk_disable_unused from that generic
> > callback, but pass the device to make sure only the clocks belonging to
> > the current clock provider get disabled, if unused. Also, during the
> > default clk_disable_unused, if the driver that registered the clock has
> > the generic clk_sync_state_disable_unused callback set for sync_state,
> > skip disabling its clocks.
> 
> How does that avoid disabling clks randomly in the clk tree? I'm
> concerned about disabling an unused clk in the middle of the tree
> because it doesn't have a driver using sync state, while the clk is the
> parent of an unused clk that is backed by sync state.
> 
>    clk A -->  clk B 
> 
> clk A: No sync state
> clk B: sync state
> 
> clk B is left on by the bootloader. __clk_disable_unused(NULL) is called
> from late init. Imagine clk A is the root of the tree.
> 
> 	clk_disable_unused_subtree(clk_core A)
> 	  clk_disable_unused_subtree(clk_core B)
> 	    if (from_sync_state && core->dev != dev)
> 	      return;
> 	  ...
> 	  clk core A->ops->disable()
> 
> clk core B is off now?

Yes, that is correct. But the same thing is happening currently if the
clk_ignore_unused in not specified. At least with this new approach, we
get to leave unused clocks enabled either until sync_state is called or forever.
All the provider has to do is to implement a sync_state callback (or use
the generic one provided). So the provider of clk A would obviously need
a sync state callback registered.

> 
> Also sync_state seems broken right now. I saw mka mentioned that if you
> have a device node enabled in your DT but never enable a driver for it
> in the kernel we'll never get sync_state called. This is another
> problem, but it concerns me that sync_state would make the unused clk
> disabling happen at some random time or not at all.

Well, the fact that the sync state not being called because a driver for
a consumer device doesn't probe does not really mean it is broken. Just
because the consumer driver hasn't probed yet, doesn't mean it will
not probe later on.

That aside, rather than going with clk_ignore_unused all the time on
qcom platforms, at least in a perfect scenario (where sync state is
reached for all providers) the clocks get disabled.

> 
> Can the problem be approached more directly? If this is about fixing
> continuous splash screen, then I wonder why we can't list out the clks
> that we know are enabled by the bootloader in some new DT binding, e.g.:
> 
> 	clock-controller {
> 		#clock-cells = <1>;
> 		boot-handoff-clocks = <&consumer_device "clock cells for this clk provider">;
> 	};
> 
> Then mark those as "critical/don't turn off" all the way up the clk tree
> when the clk driver probes by essentially incrementing the
> prepare/enable count but not actually touching the hardware, and when
> the clks are acquired by clk_get() for that device that's using them
> from boot we make the first clk_prepare_enable() do nothing and not
> increment the count at all. We can probably stick some flag into the
> 'struct clk' for this when we create the handle in clk_get() so that the
> prepare and enable functions can special case and skip over.

Well, that means we need to play whack-a-mole by alsways adding such clocks to
devicetree.

> 
> The sync_state hook operates on a driver level, which is too large when
> you consider that a single clk driver may register hundreds of clks that
> are not related. We want to target a solution at the clk level so that
> any damage from keeping on all the clks provided by the controller is
> limited to just the drivers that aren't probed and ready to handle their
> clks. If sync_state could be called whenever a clk consumer consumes a
> clk it may work? Technically we already have that by the clk_hw_provider
> function but there isn't enough information being passed there, like the
> getting device.

Actually, from the multitude of clocks registered by one provider, the
ones already explicitely enabled (and obvisously their parents) by thier
consumer are safe. The only ones we need to worry about are the ones that
might be enabled by bootloader and need to remain on. With the sync state
approach, the latter mentioned clocks will either remain on indefinitely
or will be disabled on sync state. The provider driver is the only level
that has a registered sync state callback.

> 
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 842e72a5348f..cf1adfeaf257 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -720,6 +720,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
> >                 void __iomem *reg, u8 shift, u8 width,
> >                 u8 clk_divider_flags, const struct clk_div_table *table,
> >                 spinlock_t *lock);
> > +void clk_sync_state_disable_unused(struct device *dev);
> 
> This is a weird place to put this. Why not in the helper functions
> section?

Sure this can be moved.

> 
> >  /**
> >   * clk_register_divider - register a divider clock with the clock framework
> >   * @dev: device registering this clock
