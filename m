Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3722F68C31E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBFQYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBFQYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:24:34 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BBA6EAF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:24:33 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so10892004wrz.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 08:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8odKn7DP4QYY/wmzRMehcWk+ZwRVlAO+1ainCW92xA=;
        b=l97RjWW91LuuiRfeiBJJoxQSh7JojBXrHcz0F9oZIalGZs8J89M35u+1okVkbgNExZ
         K5qtaEcriHyDTezgopbKKvvkebo1ZvCOSAyZTcb7/kUG4mMUvHy7m0ROE+6oYzttxx/B
         QyRwRPrallHW3jLXCaE6QESFXe1MH0JCgv9hE4Wze3U2L3dAePJX7r+hbGg/KmARE161
         HmpoJJJT/bN96qwmkMwX3OOtKB+pD89zCd8T5CYF1T0GVfLpF3be4bqYVkOo4oKZHpar
         yFtxkZ4HJt5ErAPnfhDoaaU4N+o5NMhaO2ofxmczbTJIjZHIn9adLMP/o1croHMrh3Rt
         tBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8odKn7DP4QYY/wmzRMehcWk+ZwRVlAO+1ainCW92xA=;
        b=RG/pP29SNXAjh3Y6t23GqdHL9q8qgh3IiQ8ozIKINJrT4AKg+wp7hrBerM0gvuvent
         PqNNSt2T5WA8Q41erj/8S01LaEyGBlSultQ179HsdX75Azt2IGS5sao9kirMLeOxe49B
         2JvkpKb3Tl7IN3iOpzVLuNyaU+9Qimx5PFYFke/iyTqH+nthAV+VNz/6aizCBpZDoKTM
         0pHohGDQIY9qHAUQIpxkb/u9lYVGOYCPjpWj1OKhm0UrtGAUzD16nvSO0W7q4FSv9W6d
         Mcemtq9EiFqherg54HStSVGcLhVlnbvEAEvrPRMqQYCfvaFAg19hxy+tbOqcBAO9HYrn
         +PhA==
X-Gm-Message-State: AO0yUKUwLuSg+oD6WD6yGyC1tKpFOyIfVe8poTuVmW+nKFv0614GN+rg
        z1g56Hk/tRvJXYqsHq2s5JxGNQ==
X-Google-Smtp-Source: AK7set8WEZAF02OcXH23YKddTtBLmAlwFIAub8wr1S/IIIwZKDgLm2uKOfrLjcDmF71n8h4+gQshBQ==
X-Received: by 2002:adf:fc88:0:b0:2bf:d137:9945 with SMTP id g8-20020adffc88000000b002bfd1379945mr17285609wrr.51.1675700672093;
        Mon, 06 Feb 2023 08:24:32 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id i6-20020a0560001ac600b00241fde8fe04sm9736909wry.7.2023.02.06.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:24:31 -0800 (PST)
Date:   Mon, 6 Feb 2023 18:24:30 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
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
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
Message-ID: <Y+EpvhIWYNp/C0V8@linaro.org>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <Y9v/z8CYik3faHh7@google.com>
 <3826e0e6-bb2b-409d-d1c3-ed361305bce3@linaro.org>
 <CAD=FV=Ue71nnCEBWSw7A9U0Tzi9pFSqZaQk_5CygakS2j+_tfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Ue71nnCEBWSw7A9U0Tzi9pFSqZaQk_5CygakS2j+_tfw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-02 14:20:56, Doug Anderson wrote:
> Hi,
> 
> On Thu, Feb 2, 2023 at 11:53 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On 02/02/2023 20:24, Matthias Kaehlcke wrote:
> > > Hi Abel,
> > >
> > > On Fri, Jan 27, 2023 at 12:40:53PM +0200, Abel Vesa wrote:
> > >> Currently, there are cases when a domain needs to remain enabled until
> > >> the consumer driver probes. Sometimes such consumer drivers may be built
> > >> as modules. Since the genpd_power_off_unused is called too early for
> > >> such consumer driver modules to get a chance to probe, the domain, since
> > >> it is unused, will get disabled. On the other hand, the best time for
> > >> an unused domain to be disabled is on the provider's sync_state
> > >> callback. So, if the provider has registered a sync_state callback,
> > >> assume the unused domains for that provider will be disabled on its
> > >> sync_state callback. Also provide a generic sync_state callback which
> > >> disables all the domains unused for the provider that registers it.
> > >>
> > >> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > >> ---
> > >>
> > >> This approach has been applied for unused clocks as well.
> > >> With this patch merged in, all the providers that have sync_state
> > >> callback registered will leave the domains enabled unless the provider's
> > >> sync_state callback explicitly disables them. So those providers will
> > >> need to add the disabling part to their sync_state callback. On the
> > >> other hand, the platforms that have cases where domains need to remain
> > >> enabled (even if unused) until the consumer driver probes, will be able,
> > >> with this patch in, to run without the pd_ignore_unused kernel argument,
> > >> which seems to be the case for most Qualcomm platforms, at this moment.
> > >
> > > I recently encountered a related issue on a Qualcomm platform with a
> > > v6.2-rc kernel, which includes 3a39049f88e4 ("soc: qcom: rpmhpd: Use
> > > highest corner until sync_state"). The issue involves a DT node with a
> > > rpmhpd, the DT node is enabled, however the corresponding device driver
> > > is not enabled in the kernel. In such a scenario the sync_state callback
> > > is never called, because the genpd consumer never probes. As a result
> > > the Always-on subsystem (AOSS) of the SoC doesn't enter sleep mode during
> > > system suspend, which results in a substantially higher power consumption
> > > in S3.
> > >
> > > I wonder if genpd (and some other frameworks) needs something like
> > > regulator_init_complete(), which turns off unused regulators 30s after
> > > system boot. That's conceptually similar to the current
> > > genpd_power_off_unused(), but would provide time for modules being loaded.
> >
> > I think the overall goal is to move away from ad-hoc implementations
> > like clk_disable_unused/genpd_power_off_unused/regulator_init_complete
> > towards the sync_state.
> >
> > So inherently one either has to provide drivers for all devices in
> > question or disable unused devices in DT.
> 
> Hmm. I guess I haven't been involved too much in those discussions,
> but overall I thought:
> 
> 1. The device tree should ideally be describing the hardware. Thus if
> the hardware is there / available to use on a given board then the
> device should be marked enabled.

That is correct.

> 
> 2. Users are not actually required to enable drivers for all hardware
> on their board. Things should still function OK even if a driver is
> disabled. For instance, if the SoC had a crypto accelerator you'd
> describe it in the device tree but it would be OK for someone to build
> a kernel that didn't enable the crypto accelerator driver.

Right, but sync state is relying on fw_devlinks to decide if there are
any consumers left that still need to probe. So if one of the consumer
devicetree nodes needs some provider, the consumer will simply not work
without the provider. In theory at least.

> 
> Am I mistaken? Which point did I get wrong, #1, or #2?
> 
> -Doug
