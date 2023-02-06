Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD5C68C5E7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBFSgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBFSgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:36:47 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3302B0B8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:36:46 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id o13so1229347ilt.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jpLAfxyLsgp5wo9XsIKzSBijHnYVMJFhq6Za6hG4zG4=;
        b=RbPfSpFfy3FZ/cx9eZ++rTBK3EfhpFe4zxgNBg6WKZYaZj8fcUkTcjmTiigUguxIyQ
         Lgh6bnXFdOANZlCUMtKSHIs0FouS26T1b9TrRv00GAy7DkhJ+TG1IW7sqqTcGdbF/NVl
         iri8hr9tmZlwnhjz4+7Pa5sprj7oASw+uBMoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpLAfxyLsgp5wo9XsIKzSBijHnYVMJFhq6Za6hG4zG4=;
        b=2//V8xfcA7c0VmM1gw4ZtBM61PRxsHN5wFyfj6qq38s1BUiZwJqD8hK+HvzIifn4kr
         tK7ZTDSwq0H3FasbzVKRRD93d5iEGb60h0BZ4THazLgrfee41tyL52B5aUYdvcaOrB3a
         er/eHou6791VfgCaQKKS+MBM6MY9CASxSaftxf6nWxN3BkJ2exvMTe/lzburQSUCFwNO
         4vHorO7drv5pQVTsFvu2XS6/4na05E2/zy3b1/miKGVRI2CJSsFf460qAhmUv3aY/5yP
         60ZjYwvPV5D8wplhH7j6IYOo7iIXB5fIYemoP1zUTCZUvaX7lSKdodexoxd2/V0sj0TT
         be6A==
X-Gm-Message-State: AO0yUKWrPomAzJSL8b6JAlVkFL1nH21YeMONG7C/9hndx5VPRta+M6iv
        0RY1EndSNe61QkQPyfIWob8h7g==
X-Google-Smtp-Source: AK7set8U4aY9AZiC/bwoUXyakwXvZVP0rv8L/2FkJDiVbd3C0+QlBJSZPusj74fB7RgknDJnx1/M5A==
X-Received: by 2002:a92:a001:0:b0:310:f912:5a68 with SMTP id e1-20020a92a001000000b00310f9125a68mr371241ili.3.1675708605584;
        Mon, 06 Feb 2023 10:36:45 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id o16-20020a056e02115000b00313b92e839bsm2048605ill.40.2023.02.06.10.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 10:36:45 -0800 (PST)
Date:   Mon, 6 Feb 2023 18:36:44 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
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
        Doug Anderson <dianders@chromium.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
Message-ID: <Y+FIvEqQU+yjzEIl@google.com>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <Y9v/z8CYik3faHh7@google.com>
 <Y+ErWTyV8CnE3Hl+@linaro.org>
 <Y+E3T6bozU1K2sFb@google.com>
 <Y+E9Z+/+eCpPK6DE@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+E9Z+/+eCpPK6DE@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 07:48:23PM +0200, Abel Vesa wrote:
> 
> CC'ed Saravana
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

As Doug pointed out, the device tree is supposed to describe the hardware, but
that shouldn't impose a user/admin/downstream maintainer to use every single
existing piece of hardware with the potential power implications on battery
powererd devices.

I someone uses an off the shelf board like a Raspberry Pi for a project in
which they only use a subset of the functionality, they would be forced to
use a downstream device tree if they can't just disable the drivers they
are not interested in. Supposedly we want people/companies to use upstream
kernels as much as possible, however you suggest to adapt the device tree
in a way that does not describe the hardware, which effectively forces folks
to user downstream kernels (or at least device trees).

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

Nope, the device tree is supposed to describe the hardware and the hardware
doesn't change because a particular use case doesn't require/want the use of
all existing parts.

> Again, timeouts are bad all-around. What happens if rootfs doesn't get
> mounted in time? Will 30 seconds be enough for every scenario? What
> happens if I want to load the driver (module) for a consumer a day after boot?

I am not sure if I have a complete/correct picture here. My understanding is
that sync_state is above all used for handing over critical hardware from the
bootloader to the kernel. For example the CPUs may require clocks and
interconnects to run at a certain speed during boot, before they are 'probed'
and can ask the provider to run the resource (at least) at a certain speed.

I would expect that drivers on the roots aren't critical for the system to
enter the rootfs, all these should be either built-in or as modules on an
initramfs. Let's say we have an audio driver that uses a clock (provider)
and this audio driver lives as a modules on the rootfs. For some reason our
rootfs takes a long time to mount and sync_state() of the clock provider is
called, due to the timeout we introduced. The provider determines that it
hasn't received any requests for the audio clock and disables it. Now
finally the rootfs is mounted and out audio module is loaded. The audio
device probes, gets the clock and asks the provider to run it at certain
speed. The clock provider puts the clock at the requested speed and audio
works as if the sync_state timeout never happened.

Am I missing/misunderstanding anything important?

> IMHO, I think even the regulator_init_complete should be switched to some sync
> state approach.

Maybe, with a timeout :)
