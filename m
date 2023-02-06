Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCEB68C312
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjBFQVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBFQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:21:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B2244B4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:21:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso11156234wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 08:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1SvRQXFgKJW9MWWeXUNyZOsgozAf3at2hO0cPftBZs=;
        b=hzQHYiiToN5GxCQ01547LGxjBpryGWlIUMBs0Oyl81LRC47MHuGKf0VCWf5C5KKj1K
         2fY8MFuewnGkuubB2AVv5KcrZwN+v7Nq9NdCAxe6CXpV/FYVnHor/JIe5A/HvJS2tprZ
         BNfJvSofIts0MoP7m9ajRG6Zh2qizfIhH8o7Jp+3GZKpiRbGOEiVK9weyDIR2a8oBsZu
         c224R5u2RnAxSixSNtxqKe5r8OOehBZEU45PeuccV0W2tEH4O1SAWOUyMLwRG3U2DTTI
         /HSM6X7oDEQ/QIqjpUPbhV7rS7TkBu3vuaQZ9DAYu8B0/LqloMiFMOqqMpjhXgDvf9t6
         dMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1SvRQXFgKJW9MWWeXUNyZOsgozAf3at2hO0cPftBZs=;
        b=R/fCl3gSPyKwBx4vkJczIK8+mFdUQ8CudLy4OQFYTnhMvj39zJNe3BDkKjKUcDb0Nl
         a+GYHa0JgP6+VI5JQJIXJ7qC6vo5Cmd69UxzbhJYysW4U2B9gSVYBI/XYajhJxoH616F
         VttUWOq2ll1iry9QiE4HzDCEat8L4hJ+kirLGmB8Wb/TmhdpY9vwWiLSwgU8D02qFxKI
         5WR7pm8iTHITiR8gb7e2TxTXA+KHWUCpaf+eIN3HlvIQabrHVHtKQ4eSfnTGGX8upXKo
         aEpcZKaEs14/384fatWToRhFhVJVRjYMhAcD+Wgu8Q4R7Y2WMbxM/Y8+qM28A3OdegwF
         afZg==
X-Gm-Message-State: AO0yUKWPWawNel/7uXo4UcVNEdIZnOaHLntrtxAyoi0IbOaIsaBdhP0r
        rXEwfA8A0NGHueNUkSGp09CJXg==
X-Google-Smtp-Source: AK7set/C5SjtKdAAX85xHQABD3OMh3zWLxVGvREyu/EPJPrKdwKtNzmqb9QsTuttSJ7C26iGWYgbgw==
X-Received: by 2002:a05:600c:13ca:b0:3dc:5937:35a2 with SMTP id e10-20020a05600c13ca00b003dc593735a2mr307220wmg.9.1675700482275;
        Mon, 06 Feb 2023 08:21:22 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c16c400b003df245cd853sm11089860wmn.44.2023.02.06.08.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:21:21 -0800 (PST)
Date:   Mon, 6 Feb 2023 18:21:20 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
Message-ID: <Y+EpAK2P+lN9GTPJ@linaro.org>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <Y9v/z8CYik3faHh7@google.com>
 <3826e0e6-bb2b-409d-d1c3-ed361305bce3@linaro.org>
 <Y9xhbq/MIOgssslh@google.com>
 <9b8af6b3-9ab5-12f8-5576-1a93c58a26c1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b8af6b3-9ab5-12f8-5576-1a93c58a26c1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-03 22:00:27, Dmitry Baryshkov wrote:
> On 03/02/2023 03:20, Matthias Kaehlcke wrote:
> > Hi Dmitry,
> > 
> > On Thu, Feb 02, 2023 at 09:53:41PM +0200, Dmitry Baryshkov wrote:
> > > On 02/02/2023 20:24, Matthias Kaehlcke wrote:
> > > > Hi Abel,
> > > > 
> > > > On Fri, Jan 27, 2023 at 12:40:53PM +0200, Abel Vesa wrote:
> > > > > Currently, there are cases when a domain needs to remain enabled until
> > > > > the consumer driver probes. Sometimes such consumer drivers may be built
> > > > > as modules. Since the genpd_power_off_unused is called too early for
> > > > > such consumer driver modules to get a chance to probe, the domain, since
> > > > > it is unused, will get disabled. On the other hand, the best time for
> > > > > an unused domain to be disabled is on the provider's sync_state
> > > > > callback. So, if the provider has registered a sync_state callback,
> > > > > assume the unused domains for that provider will be disabled on its
> > > > > sync_state callback. Also provide a generic sync_state callback which
> > > > > disables all the domains unused for the provider that registers it.
> > > > > 
> > > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > > ---
> > > > > 
> > > > > This approach has been applied for unused clocks as well.
> > > > > With this patch merged in, all the providers that have sync_state
> > > > > callback registered will leave the domains enabled unless the provider's
> > > > > sync_state callback explicitly disables them. So those providers will
> > > > > need to add the disabling part to their sync_state callback. On the
> > > > > other hand, the platforms that have cases where domains need to remain
> > > > > enabled (even if unused) until the consumer driver probes, will be able,
> > > > > with this patch in, to run without the pd_ignore_unused kernel argument,
> > > > > which seems to be the case for most Qualcomm platforms, at this moment.
> > > > 
> > > > I recently encountered a related issue on a Qualcomm platform with a
> > > > v6.2-rc kernel, which includes 3a39049f88e4 ("soc: qcom: rpmhpd: Use
> > > > highest corner until sync_state"). The issue involves a DT node with a
> > > > rpmhpd, the DT node is enabled, however the corresponding device driver
> > > > is not enabled in the kernel. In such a scenario the sync_state callback
> > > > is never called, because the genpd consumer never probes. As a result
> > > > the Always-on subsystem (AOSS) of the SoC doesn't enter sleep mode during
> > > > system suspend, which results in a substantially higher power consumption
> > > > in S3.
> > > > 
> > > > I wonder if genpd (and some other frameworks) needs something like
> > > > regulator_init_complete(), which turns off unused regulators 30s after
> > > > system boot. That's conceptually similar to the current
> > > > genpd_power_off_unused(), but would provide time for modules being loaded.
> > > 
> > > I think the overall goal is to move away from ad-hoc implementations like
> > > clk_disable_unused/genpd_power_off_unused/regulator_init_complete towards
> > > the sync_state.
> > 
> > I generally agree with the goal of using common mechanisms whenever possible.
> > 
> > > So inherently one either has to provide drivers for all devices in question
> > > or disable unused devices in DT.
> > 
> > I don't think that's a great solution, it essentially hands the issue down to
> > the users or downstream maintainers of the kernel, who might not be aware that
> > there is an issue, nor know about the specifics of genpd (or interconnects and
> > clocks which have similar problems).
> 
> The goal is to move the control down to individual drivers. Previously we
> had issues with clk_disable_unused() disabling mdss/mdp clocks incorrectly,
> which frequently led to broken display output. Other clock/genpd/regulator
> drivers might have other internal dependencies. Thus it is not really
> possible to handle resource shutdown in the common  (framework) code.
> 
> > 
> > In general symptoms are probably subtle, like a (potentially substantially)
> > increased power consumption during system suspend. The issue might have been
> > introduced by an update to a newer kernel, which now includes a DT node for a
> > new SoC feature which wasn't supported by the 'old' kernel. It's common
> > practice to use the 'old' .config, at least as a starting point, which
> > obviously doesn't enable the new driver. That happend to me with [1] when
> > testing v6.1. It took me quite some time to track the 'culprit' commit down
> > and then some debugging to understand what's going on. Shortly after that I
> > ran into a related issue involving genpds when testing v6.2-rc, which again
> > took a non-trivial amount of time to track down (and I'm familiar with the SoC
> > platform and the general nature of the issue). I don't think it's reasonable
> > to expect every user/downstream maintainer of an impacted system to go through
> > this, one person at a time.
> 
> I think it would be nice to have some way of 'sync_pending' debug available
> (compare this to debugfs/devices_deferred).

There is actually a 'state_synced' sysfs interface (per device) that
either shows 0, meaning it hasn't reach sync_state yet, or the file is
not available at all, meaning it has reached sync_state.

> 
> Note, we are trying to make sure that all supported drivers are enabled at
> least as modules (if possible). If we fail, please send a patch fixing the
> defconfig.
> 
> > Maybe there could be a generic solution for drivers with a 'sync_state'
> > callback, e.g. a the driver (or framework) could have a 'sync_state_timeout'
> > callback (or similar), which is called by the driver framework if 'sync_state'
> > wasn't called (for example) 30s after the device was probed. Then the provider
> > can power off or throttle unclaimed resources.
> 
> I might be missing a point somewhere, but for me it looks like a logical
> solution. Please send a proposal.
> 
> -- 
> With best wishes
> Dmitry
> 
