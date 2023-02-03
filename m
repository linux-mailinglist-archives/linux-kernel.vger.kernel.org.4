Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7427F688C69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjBCBU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBCBUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:20:54 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A0F84196
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 17:20:48 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id l7so1573181ilf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 17:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ5Pmmj2Rt9EqE9bH2n9yjY0zYzZEBj6I5wlxCLCikQ=;
        b=a1+CLEPHDcSqOk1gT+tPzCPCR984gXXSi1wbq1XcRyXI2CBVoqmeenvZNihOFwSKfl
         faI8EDXYK5BQ+P5QOpnC1QhK3wnoQ5eoWrxOsuyytmr2DI2TiDsHNK/XWykCjcjoEhfr
         pTKxqYgbW6CG6VYJVrCJVFr5JbACGc/2yBMsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZ5Pmmj2Rt9EqE9bH2n9yjY0zYzZEBj6I5wlxCLCikQ=;
        b=CS2ck4A2lUk2pBUaaolKSQYnq7mlq+zDUwQwjYVy0vckWbpJGBYmHi6cIzRvW28gBP
         3v8DJL5hfL8EGkxq2VHJD3qZRdazPYk8RJQdehGE9wGg09aWMlGOAWdK+6PhsWoWDwIe
         /9vJS+tZwx/XYw66rGcZAu7/+pG9ipQ2ccQjd3mla+oCUJfBrZFicYP092qOV0Pg7ovY
         CLTy4jwvFL3bz0VrEvWBVY/ZsK8s5ixHnQZXh7S65FB0pJb7WB4xhBAp3zveAWWy0Ike
         7l/EF+lyO7Nv0MmdCtfMhuw9rTGJ3ooGPoXicg0pU9q/W1dbpGiDEIKSY77oOtvFJiTN
         WgFA==
X-Gm-Message-State: AO0yUKXV4SRnI4svSJQ3CVUgLSGt+ZqbGsIgy7rMx87iYeJv6oNHuHNA
        83QqvT7QQEJiToNUT2llUNwslw==
X-Google-Smtp-Source: AK7set+VQTfLvTi8eurBqtl/XO/hYqsGrhuWRacBe1+EnyMKQdzxz/SGcK/qf1tEbIvusOMBmemOSQ==
X-Received: by 2002:a05:6e02:1b87:b0:310:dd48:f2 with SMTP id h7-20020a056e021b8700b00310dd4800f2mr6653611ili.16.1675387247564;
        Thu, 02 Feb 2023 17:20:47 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id x13-20020a056638160d00b003b974c563c6sm399081jas.162.2023.02.02.17.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 17:20:47 -0800 (PST)
Date:   Fri, 3 Feb 2023 01:20:46 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
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
Message-ID: <Y9xhbq/MIOgssslh@google.com>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <Y9v/z8CYik3faHh7@google.com>
 <3826e0e6-bb2b-409d-d1c3-ed361305bce3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3826e0e6-bb2b-409d-d1c3-ed361305bce3@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Thu, Feb 02, 2023 at 09:53:41PM +0200, Dmitry Baryshkov wrote:
> On 02/02/2023 20:24, Matthias Kaehlcke wrote:
> > Hi Abel,
> > 
> > On Fri, Jan 27, 2023 at 12:40:53PM +0200, Abel Vesa wrote:
> > > Currently, there are cases when a domain needs to remain enabled until
> > > the consumer driver probes. Sometimes such consumer drivers may be built
> > > as modules. Since the genpd_power_off_unused is called too early for
> > > such consumer driver modules to get a chance to probe, the domain, since
> > > it is unused, will get disabled. On the other hand, the best time for
> > > an unused domain to be disabled is on the provider's sync_state
> > > callback. So, if the provider has registered a sync_state callback,
> > > assume the unused domains for that provider will be disabled on its
> > > sync_state callback. Also provide a generic sync_state callback which
> > > disables all the domains unused for the provider that registers it.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > > 
> > > This approach has been applied for unused clocks as well.
> > > With this patch merged in, all the providers that have sync_state
> > > callback registered will leave the domains enabled unless the provider's
> > > sync_state callback explicitly disables them. So those providers will
> > > need to add the disabling part to their sync_state callback. On the
> > > other hand, the platforms that have cases where domains need to remain
> > > enabled (even if unused) until the consumer driver probes, will be able,
> > > with this patch in, to run without the pd_ignore_unused kernel argument,
> > > which seems to be the case for most Qualcomm platforms, at this moment.
> > 
> > I recently encountered a related issue on a Qualcomm platform with a
> > v6.2-rc kernel, which includes 3a39049f88e4 ("soc: qcom: rpmhpd: Use
> > highest corner until sync_state"). The issue involves a DT node with a
> > rpmhpd, the DT node is enabled, however the corresponding device driver
> > is not enabled in the kernel. In such a scenario the sync_state callback
> > is never called, because the genpd consumer never probes. As a result
> > the Always-on subsystem (AOSS) of the SoC doesn't enter sleep mode during
> > system suspend, which results in a substantially higher power consumption
> > in S3.
> > 
> > I wonder if genpd (and some other frameworks) needs something like
> > regulator_init_complete(), which turns off unused regulators 30s after
> > system boot. That's conceptually similar to the current
> > genpd_power_off_unused(), but would provide time for modules being loaded.
> 
> I think the overall goal is to move away from ad-hoc implementations like
> clk_disable_unused/genpd_power_off_unused/regulator_init_complete towards
> the sync_state.

I generally agree with the goal of using common mechanisms whenever possible.

> So inherently one either has to provide drivers for all devices in question
> or disable unused devices in DT.

I don't think that's a great solution, it essentially hands the issue down to
the users or downstream maintainers of the kernel, who might not be aware that
there is an issue, nor know about the specifics of genpd (or interconnects and
clocks which have similar problems).

In general symptoms are probably subtle, like a (potentially substantially)
increased power consumption during system suspend. The issue might have been
introduced by an update to a newer kernel, which now includes a DT node for a
new SoC feature which wasn't supported by the 'old' kernel. It's common
practice to use the 'old' .config, at least as a starting point, which
obviously doesn't enable the new driver. That happend to me with [1] when
testing v6.1. It took me quite some time to track the 'culprit' commit down
and then some debugging to understand what's going on. Shortly after that I
ran into a related issue involving genpds when testing v6.2-rc, which again
took a non-trivial amount of time to track down (and I'm familiar with the SoC
platform and the general nature of the issue). I don't think it's reasonable
to expect every user/downstream maintainer of an impacted system to go through
this, one person at a time.

Maybe there could be a generic solution for drivers with a 'sync_state'
callback, e.g. a the driver (or framework) could have a 'sync_state_timeout'
callback (or similar), which is called by the driver framework if 'sync_state'
wasn't called (for example) 30s after the device was probed. Then the provider
can power off or throttle unclaimed resources.

m.

[1] https://lore.kernel.org/lkml/20220902043511.17130-5-quic_rjendra@quicinc.com/


> > > The v1 is here:
> > > https://lore.kernel.org/all/20230126234013.3638425-1-abel.vesa@linaro.org/
> > > 
> > > Changes since v1:
> > >   * added a generic sync state callback to be registered by providers in
> > >     order to disable the unused domains on their sync state. Also
> > >     mentioned this in the commit message.
> > > 
> > >   drivers/base/power/domain.c | 17 ++++++++++++++++-
> > >   include/linux/pm_domain.h   |  3 +++
> > >   2 files changed, 19 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index 84662d338188..c2a5f77c01f3 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -1099,7 +1099,8 @@ static int __init genpd_power_off_unused(void)
> > >   	mutex_lock(&gpd_list_lock);
> > >   	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> > > -		genpd_queue_power_off_work(genpd);
> > > +		if (!dev_has_sync_state(genpd->provider->dev))
> > > +			genpd_queue_power_off_work(genpd);
> > >   	mutex_unlock(&gpd_list_lock);
> > > @@ -1107,6 +1108,20 @@ static int __init genpd_power_off_unused(void)
> > >   }
> > >   late_initcall(genpd_power_off_unused);
> > > +void genpd_power_off_unused_sync_state(struct device *dev)
> > > +{
> > > +	struct generic_pm_domain *genpd;
> > > +
> > > +	mutex_lock(&gpd_list_lock);
> > > +
> > > +	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> > > +		if (genpd->provider->dev == dev)
> > > +			genpd_queue_power_off_work(genpd);
> > > +
> > > +	mutex_unlock(&gpd_list_lock);
> > > +}
> > > +EXPORT_SYMBOL_GPL(genpd_power_off_unused_sync_state);
> > > +
> > >   #ifdef CONFIG_PM_SLEEP
> > >   /**
> > > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > > index f776fb93eaa0..1fd5aa500c81 100644
> > > --- a/include/linux/pm_domain.h
> > > +++ b/include/linux/pm_domain.h
> > > @@ -351,6 +351,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> > >   					 unsigned int index);
> > >   struct device *genpd_dev_pm_attach_by_name(struct device *dev,
> > >   					   const char *name);
> > > +void genpd_power_off_unused_sync_state(struct device *dev);
> > >   #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
> > >   static inline int of_genpd_add_provider_simple(struct device_node *np,
> > >   					struct generic_pm_domain *genpd)
> > > @@ -419,6 +420,8 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
> > >   {
> > >   	return ERR_PTR(-EOPNOTSUPP);
> > >   }
> > > +
> > > +static inline genpd_power_off_unused_sync_state(struct device *dev) {}
> > >   #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
> > >   #ifdef CONFIG_PM
> > > -- 
> > > 2.34.1
> > > 
> 
> -- 
> With best wishes
> Dmitry
> 
