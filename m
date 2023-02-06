Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D662D68C4F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjBFRhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBFRhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:37:52 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033FCA5F2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:37:50 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id y7so4710122iob.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 09:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Grgo8rMwViYT3RrCBZ593Xg/hDtSbZnW99S05uz5/ho=;
        b=d8wR+knWpktG5wY0GJLfROtb9opnsVI8ZoWuKQEGo7CQnHI/wumwDARysXEqZ8VfnZ
         4V0ICAmbiA+DmfucKPm+GrWcoaiKib9MD9+rpgEbC6cQ9vrUcRHB22uB0c65Zz2IHmkB
         cUw6M+eBSSQ890lVWjSG2IyLRaYzGipzQZt3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Grgo8rMwViYT3RrCBZ593Xg/hDtSbZnW99S05uz5/ho=;
        b=FKTcH6Tm/CckxSI5yoirRtTF+BKvqLJKvmQWbE7P6MlSQ7TTvluwoqGKFIheyBX6mt
         w0p083oIt0S78BSXHVTqlbQIaOcfpE6OGlgboOKI2bd5W2v3lXke9GaW2IpZxxcaVx2/
         vAwGzs2/ESY1hsXD7Od88h25Mc4eLrw3ZyKLa2n6uuZdOLloC6lwqBTmaqfmfUCi3YNX
         2JnixjICYXUXO82wWyUf1jTInW3Djlb5P59r1/R5UNq0R2XNOv2Pokzs2fJLwKAXN2lv
         eTF2lSJLsyA8WzHxWzt0eydRADdauV7QOlSb+kYsHcMT7M91kxpjZxe1a3FDgVL40N0t
         pECg==
X-Gm-Message-State: AO0yUKXJts9zYWt2Mw55Kw5+vjddtFuGzYV5tV7TsAzZUzldsTblYn2Y
        S2BxBRSJI0QhCs3ewdipCJFdAg==
X-Google-Smtp-Source: AK7set+RnSMkExsHt0o5DIe3rZ6mVpe9ZEXDwGM27XU8ljSeadEVZ55gWSeOabz1wroLvyJsyUHqkw==
X-Received: by 2002:a05:6602:2149:b0:718:932:945a with SMTP id y9-20020a056602214900b007180932945amr13104305ioy.13.1675705070324;
        Mon, 06 Feb 2023 09:37:50 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id j1-20020a02cb01000000b0039e98b2fe5dsm3685475jap.179.2023.02.06.09.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 09:37:49 -0800 (PST)
Date:   Mon, 6 Feb 2023 17:37:49 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
Message-ID: <Y+E67QLhCB60mHel@google.com>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <Y9v/z8CYik3faHh7@google.com>
 <3826e0e6-bb2b-409d-d1c3-ed361305bce3@linaro.org>
 <CAD=FV=Ue71nnCEBWSw7A9U0Tzi9pFSqZaQk_5CygakS2j+_tfw@mail.gmail.com>
 <Y+EpvhIWYNp/C0V8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+EpvhIWYNp/C0V8@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 06:24:30PM +0200, Abel Vesa wrote:
> On 23-02-02 14:20:56, Doug Anderson wrote:
> > Hi,
> > 
> > On Thu, Feb 2, 2023 at 11:53 AM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On 02/02/2023 20:24, Matthias Kaehlcke wrote:
> > > > Hi Abel,
> > > >
> > > > On Fri, Jan 27, 2023 at 12:40:53PM +0200, Abel Vesa wrote:
> > > >> Currently, there are cases when a domain needs to remain enabled until
> > > >> the consumer driver probes. Sometimes such consumer drivers may be built
> > > >> as modules. Since the genpd_power_off_unused is called too early for
> > > >> such consumer driver modules to get a chance to probe, the domain, since
> > > >> it is unused, will get disabled. On the other hand, the best time for
> > > >> an unused domain to be disabled is on the provider's sync_state
> > > >> callback. So, if the provider has registered a sync_state callback,
> > > >> assume the unused domains for that provider will be disabled on its
> > > >> sync_state callback. Also provide a generic sync_state callback which
> > > >> disables all the domains unused for the provider that registers it.
> > > >>
> > > >> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > >> ---
> > > >>
> > > >> This approach has been applied for unused clocks as well.
> > > >> With this patch merged in, all the providers that have sync_state
> > > >> callback registered will leave the domains enabled unless the provider's
> > > >> sync_state callback explicitly disables them. So those providers will
> > > >> need to add the disabling part to their sync_state callback. On the
> > > >> other hand, the platforms that have cases where domains need to remain
> > > >> enabled (even if unused) until the consumer driver probes, will be able,
> > > >> with this patch in, to run without the pd_ignore_unused kernel argument,
> > > >> which seems to be the case for most Qualcomm platforms, at this moment.
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
> > > I think the overall goal is to move away from ad-hoc implementations
> > > like clk_disable_unused/genpd_power_off_unused/regulator_init_complete
> > > towards the sync_state.
> > >
> > > So inherently one either has to provide drivers for all devices in
> > > question or disable unused devices in DT.
> > 
> > Hmm. I guess I haven't been involved too much in those discussions,
> > but overall I thought:
> > 
> > 1. The device tree should ideally be describing the hardware. Thus if
> > the hardware is there / available to use on a given board then the
> > device should be marked enabled.
> 
> That is correct.
> 
> > 
> > 2. Users are not actually required to enable drivers for all hardware
> > on their board. Things should still function OK even if a driver is
> > disabled. For instance, if the SoC had a crypto accelerator you'd
> > describe it in the device tree but it would be OK for someone to build
> > a kernel that didn't enable the crypto accelerator driver.
> 
> Right, but sync state is relying on fw_devlinks to decide if there are
> any consumers left that still need to probe. So if one of the consumer
> devicetree nodes needs some provider, the consumer will simply not work
> without the provider. In theory at least.

It is correct that a device which actually depends on a provider won't
work without that provider, however that isn't the case here. In the
scenario above the consumer is the crypto accelerator. It doesn't probe
because it's driver is not enabled, not because it's waiting for a
provider (clk, interconnect, ...).

