Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E9A68C6DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBFTdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBFTdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:33:15 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C041EBEC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:33:13 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id iy2so3151376plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ozndrp9afhkdbM3aTvMQSUU+gGGmEw8bXKclZh/YFF8=;
        b=pUN3O7Lp1aWdzxGMgt32Wj7585LyJFaDLuELuVw/HI5/kW4j9V+ioU7tUeWRPQOIUw
         vb5/ySpmyFRyY0VBTVKT+98zMphr2JtzVS4fBXJ49LiINlI01C659kUyl2CiGnD27uQz
         k06uddD2pS/3qNQvpm2nJTSW4uHPIGY2gxbDZdYM//BFYbuZD9vqugGr5Mqrmfo3Y9YD
         915KjuvAasZ3HHccRzyqmW4j1jffUIL8rGtAK17ztKFvJmkDSIgXgjVzi2yuit2jANYZ
         XKFmb4Jytr1ySKy1lV8VGppr97tcLtvQ35BASxyXGVkvkEjK3QZHYyTA6ohEHFvbjDyV
         ujcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ozndrp9afhkdbM3aTvMQSUU+gGGmEw8bXKclZh/YFF8=;
        b=zDotVLDo3TdzjkYHk4JGGv/cU0LFzJVpHHYk9xKbdI3EjNRxsiDjFJ1fkeUoIWye9r
         UBtWQ6MDip/c94HUchqhN7CEmlVbjPUWBn8MrZr/AqTwspyGSDAFaHg14UBnLWrO7CaA
         aDP+QtYXDk4+IxJFDHlZ4LJtDsOItqsOt5O7HZReJbO8N/5XfqH5/P7jeHNdLCmUT/y8
         wWulQOTWq15MkfR8tRIbHnRKb1xCQNOiJe12JiNxuqbnXRjkqj39z/1bpQgmOaXm4a63
         sHoPXpwXdqrnzxuC9hEapzLM/WznH73DZfI4HS1/PrV80sedTatjY9W7w9yGB640vu7y
         t95A==
X-Gm-Message-State: AO0yUKWxVSZUzkwJIy2wQggOJoN4pFE6n5Nl3xMMpBp0XfRHM8TeIGaG
        kseKQZbYOlAF4TdkZsoispD2Zq359ai0xQQ1fzDDuvoBtTdTOyamLrA=
X-Google-Smtp-Source: AK7set+KtnKVLwJYDJqYkK8qj3eZxjPmwm8qA9aUuqtozbNylOwcKEu6pFJFWVgPFc4duiSgTJ+lP96Aj9YI/XjHw1I=
X-Received: by 2002:a17:90b:344c:b0:230:9e2a:ebd8 with SMTP id
 lj12-20020a17090b344c00b002309e2aebd8mr1457256pjb.48.1675711992252; Mon, 06
 Feb 2023 11:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20230127104054.895129-1-abel.vesa@linaro.org> <Y9v/z8CYik3faHh7@google.com>
 <Y+ErWTyV8CnE3Hl+@linaro.org> <Y+E3T6bozU1K2sFb@google.com> <Y+E9Z+/+eCpPK6DE@linaro.org>
In-Reply-To: <Y+E9Z+/+eCpPK6DE@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 6 Feb 2023 11:32:35 -0800
Message-ID: <CAGETcx99ev_JdgYoifEdUg6rqNCs5LHc-CfwTc7j3Bd_zeizew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
To:     Abel Vesa <abel.vesa@linaro.org>
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
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 9:48 AM Abel Vesa <abel.vesa@linaro.org> wrote:
>
>
> CC'ed Saravana

Thanks. Please do cc me for stuff like this from the start. I skimmed
the series and I think it's doing one of my TODO items. So, thanks for
the patch!

I'll take a closer look within a few days -- trying to get through
some existing fw_devlink stuff.

But long story short, it is the right thing to keep a supplier on
indefinitely if there's a consumer device (that's not disabled in DT)
that never gets probed. It's a pretty common scenario -- for example,
say a display backlight. The default case should be functional
correctness. And then we can add stuff that allows changing this
behavior with command line args or something else that can be done
from userspace.

+1 to what Doug said elsewhere in this thread too. I'm trying to
consolidate the "when do we give up" decision at the driver core level
independent of what framework is being used.

-Saravana

>
> On 23-02-06 17:22:23, Matthias Kaehlcke wrote:
> > On Mon, Feb 06, 2023 at 06:31:21PM +0200, Abel Vesa wrote:
> > > On 23-02-02 18:24:15, Matthias Kaehlcke wrote:
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
> > >
> > > If I get this correctly, one of the providers is missing (doesn't matter
> > > the reason), in which case, your kernel needs that driver, period. There
> > > is no reason why you would expect the consumer to work without the
> > > provider. Or, you could just remove the property in the devicetree node,
> > > the property that makes the consumer wait for that provider. Anyway, you
> > > should never end up with a consumer provider relationship in devicetree
> > > without providing the provider driver.
> >
> > I would agree if it was actually a provider that's missing, however it's a
> > 'missing' consumer that prevents the sync_state() call.
>
> Oh, my bad.
>
> Still, why would you keep the consumer node enabled in devicetree if you don't
> intend to allow its driver to ever probe?
>
> >
> > > > I wonder if genpd (and some other frameworks) needs something like
> > > > regulator_init_complete(), which turns off unused regulators 30s after
> > > > system boot. That's conceptually similar to the current
> > > > genpd_power_off_unused(), but would provide time for modules being loaded.
> > >
> > > NACK, timeouts are just another hack in this case, specially when we
> > > have a pretty reliable mechanism like sync_state.
> >
> > It does not work properly unless all consumers are probed successfully. It
> > makes sense to wait some time for the consumers to probe, but not eternally,
> > it's perfectly valid that a driver for a (potential) consumer is not enabled.
>
> Usually, if you have a consumer devicetree node that you consider it
> should not probe, you should consider disabling that node in your board
> dts, specially if you don't intend to provide its driver.
>
> Again, timeouts are bad all-around. What happens if rootfs doesn't get
> mounted in time? Will 30 seconds be enough for every scenario? What
> happens if I want to load the driver (module) for a consumer a day after boot?
>
> IMHO, I think even the regulator_init_complete should be switched to some sync
> state approach.
