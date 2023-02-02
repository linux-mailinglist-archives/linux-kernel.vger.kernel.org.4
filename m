Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D752F68864D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjBBSYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjBBSYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:24:18 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFD45EFBD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:24:17 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i17so1105454ils.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEsmcJxef9VraaSjmZ5P/yOda1aam7+tcb0WcmIGD+U=;
        b=PU5h0yer48rjaHfee+8288jQgBceANhYgi8H1PXRAs83jtgY72r/RgtBmqmLHJOWp6
         5s8hDpF3xWy0X7NWca3kqIM54lN3NBM20vDPWqJ5T5qcyGl4FWRyzFEHksC7ST+GoDNi
         RXl0HGI3sn9K6iSjlq2rdhJsGshEQB6KmfmEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEsmcJxef9VraaSjmZ5P/yOda1aam7+tcb0WcmIGD+U=;
        b=aaXTxiRqHok6HTaRk174SxhZW2AkAkRB5EAlHzMfQNymkL8/uKN7ZMmNFwKY+noYxd
         kdC+YwskbVFPxQHzhzwEyFP5Ju/nlqNbH0CdKv2VOc3nrL40e10G3h+6mgNP9B3oudek
         qkFrG6g+zO9O7n5Y2JtFRauFPfKQ53suTvUbO97m1N3eiMaHNduTA7RdVuN9lJbOT74n
         HGmZTR00Z5+AZQAfCOx7W1Ebj4cTwh5SnAC0gUwL/YTqxoM3yvHLYf6HFAkhKh0miMxz
         0orxb9cJueWwbQGsRG7A90CU62FC2PnT7suOp6rS+E+UIP1/WJ7vEMmGq7z0hSOJQ85P
         0SQw==
X-Gm-Message-State: AO0yUKXe7yJVj/4BZRfX/nsxQOM2igxIdgNk5pnQ4W2dyw9p+E7iTe6F
        Awr2WOBjmPF1yO9cSRdrIzcEFtdsqYnUZOQN
X-Google-Smtp-Source: AK7set/Bt5lPVoYdpAgFbksnowpbSms8I5kGIMJaY607UlltxZIsWVhxOEXhGk1wL1oWEF9mcRK0lQ==
X-Received: by 2002:a05:6e02:198e:b0:30d:c671:48c5 with SMTP id g14-20020a056e02198e00b0030dc67148c5mr5812112ilf.16.1675362256461;
        Thu, 02 Feb 2023 10:24:16 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id f15-20020a056e0212af00b0030c2c6f5aa1sm94040ilr.70.2023.02.02.10.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 10:24:16 -0800 (PST)
Date:   Thu, 2 Feb 2023 18:24:15 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
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
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
Message-ID: <Y9v/z8CYik3faHh7@google.com>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230127104054.895129-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Fri, Jan 27, 2023 at 12:40:53PM +0200, Abel Vesa wrote:
> Currently, there are cases when a domain needs to remain enabled until
> the consumer driver probes. Sometimes such consumer drivers may be built
> as modules. Since the genpd_power_off_unused is called too early for
> such consumer driver modules to get a chance to probe, the domain, since
> it is unused, will get disabled. On the other hand, the best time for
> an unused domain to be disabled is on the provider's sync_state
> callback. So, if the provider has registered a sync_state callback,
> assume the unused domains for that provider will be disabled on its
> sync_state callback. Also provide a generic sync_state callback which
> disables all the domains unused for the provider that registers it.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> This approach has been applied for unused clocks as well.
> With this patch merged in, all the providers that have sync_state
> callback registered will leave the domains enabled unless the provider's
> sync_state callback explicitly disables them. So those providers will
> need to add the disabling part to their sync_state callback. On the
> other hand, the platforms that have cases where domains need to remain
> enabled (even if unused) until the consumer driver probes, will be able,
> with this patch in, to run without the pd_ignore_unused kernel argument,
> which seems to be the case for most Qualcomm platforms, at this moment.

I recently encountered a related issue on a Qualcomm platform with a
v6.2-rc kernel, which includes 3a39049f88e4 ("soc: qcom: rpmhpd: Use
highest corner until sync_state"). The issue involves a DT node with a
rpmhpd, the DT node is enabled, however the corresponding device driver
is not enabled in the kernel. In such a scenario the sync_state callback
is never called, because the genpd consumer never probes. As a result
the Always-on subsystem (AOSS) of the SoC doesn't enter sleep mode during
system suspend, which results in a substantially higher power consumption
in S3.

I wonder if genpd (and some other frameworks) needs something like
regulator_init_complete(), which turns off unused regulators 30s after
system boot. That's conceptually similar to the current
genpd_power_off_unused(), but would provide time for modules being loaded.

> The v1 is here:
> https://lore.kernel.org/all/20230126234013.3638425-1-abel.vesa@linaro.org/
> 
> Changes since v1:
>  * added a generic sync state callback to be registered by providers in
>    order to disable the unused domains on their sync state. Also
>    mentioned this in the commit message.
> 
>  drivers/base/power/domain.c | 17 ++++++++++++++++-
>  include/linux/pm_domain.h   |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 84662d338188..c2a5f77c01f3 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1099,7 +1099,8 @@ static int __init genpd_power_off_unused(void)
>  	mutex_lock(&gpd_list_lock);
>  
>  	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> -		genpd_queue_power_off_work(genpd);
> +		if (!dev_has_sync_state(genpd->provider->dev))
> +			genpd_queue_power_off_work(genpd);
>  
>  	mutex_unlock(&gpd_list_lock);
>  
> @@ -1107,6 +1108,20 @@ static int __init genpd_power_off_unused(void)
>  }
>  late_initcall(genpd_power_off_unused);
>  
> +void genpd_power_off_unused_sync_state(struct device *dev)
> +{
> +	struct generic_pm_domain *genpd;
> +
> +	mutex_lock(&gpd_list_lock);
> +
> +	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> +		if (genpd->provider->dev == dev)
> +			genpd_queue_power_off_work(genpd);
> +
> +	mutex_unlock(&gpd_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(genpd_power_off_unused_sync_state);
> +
>  #ifdef CONFIG_PM_SLEEP
>  
>  /**
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f776fb93eaa0..1fd5aa500c81 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -351,6 +351,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  					 unsigned int index);
>  struct device *genpd_dev_pm_attach_by_name(struct device *dev,
>  					   const char *name);
> +void genpd_power_off_unused_sync_state(struct device *dev);
>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>  static inline int of_genpd_add_provider_simple(struct device_node *np,
>  					struct generic_pm_domain *genpd)
> @@ -419,6 +420,8 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>  {
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
> +
> +static inline genpd_power_off_unused_sync_state(struct device *dev) {}
>  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>  
>  #ifdef CONFIG_PM
> -- 
> 2.34.1
> 
