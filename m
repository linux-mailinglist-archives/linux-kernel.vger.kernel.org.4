Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842F1640BBF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiLBRHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiLBRHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:07:05 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8313D6782
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:06:57 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id x11so1479512ilo.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z13o93FN7D1j2NkYRyzv9m7Pw23zMPbciB0POjT5L7A=;
        b=bP+UQd/6n708vkEXktjaqMOGhcISnVo7L1NghuYqEUABmfP7jUxc7cMm/aIRqYZUnH
         i3g8dM6PGFZXxAZ0re3tM8O7sjjgwmnc/kMZvPZEHbg25u9ueBSqjnFmTMugoe8SYo2Z
         0zvAexNicdokiPwRVC3fjlbAIx/P6FB2BihFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z13o93FN7D1j2NkYRyzv9m7Pw23zMPbciB0POjT5L7A=;
        b=rR2B4tPW0fcouo5phGwEJ0M+mGshLkv6DB8cOKjGcPnjWAezHDvnYnvSKEjKUjWr8C
         5G578igjKcvjGu8ExRr52Gv7MxFjrFQwNbYmir8xoJB8+lGgPFG3uYx7wpA17AYGuZvu
         X70w4xLlDxUiuimN491VS4EtaNe3LOirGNK6U+5JITFGVfFJHGunvQEniV+TGtPpLBIp
         utk03HDN5qQVng6Gx5CGr57KOKHPDCD2KpN17cY+ipVlNanASFTDGMoWBOdwpHjhT2HI
         3kDpc2LF5VIw/xqY/Ra+DeAAp6reLKYXgWrx293vNtTkFlkA8vst5jIJe71Px+uw/jyi
         eXhA==
X-Gm-Message-State: ANoB5pmSLykRYrPwXTAyqzuFUUJJl+4jTllmTRu0h3wJ5gCjvs+bYgfP
        OeSWwLcXR8W2ivDpPumKEWEvkA==
X-Google-Smtp-Source: AA0mqf48QzHDoEWHCPSfK02Fd7BSl0j7k3rTKbOMcsXna7b3Nd6um2r6wF8Ji6z3+VaUYkhrrEuW0Q==
X-Received: by 2002:a05:6e02:152c:b0:303:a2:5654 with SMTP id i12-20020a056e02152c00b0030300a25654mr16509329ilu.203.1670000817219;
        Fri, 02 Dec 2022 09:06:57 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id x14-20020a0566022c4e00b006a102cb4900sm2870557iov.39.2022.12.02.09.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 09:06:56 -0800 (PST)
Date:   Fri, 2 Dec 2022 17:06:56 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Di Shen <di.shen@unisoc.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com
Subject: Re: [PATCH V2] thermal/of: Allow users to set governor for a thermal
 zone in DT
Message-ID: <Y4owsFhh7OWGwrbr@google.com>
References: <202212020239.CufwkKiR-lkp@intel.com>
 <20221202091111.1682-1-di.shen@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221202091111.1682-1-di.shen@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 05:11:11PM +0800, Di Shen wrote:
> The governor of all thermal zones can be initialized in
> thermal_zone_device_register_with_trips(), but it is always the
> def_governor, this means the governor of all thermal zones are
> the same.
> 
> Allow users to set governor for a specific thermal zone in DT, in
> this way, users can use different policies for thermal management.

There have been other attempts in the past of adding this to the
device tree (e.g. [1]), which were rejected since the DT should
describe the hardware, not policy. Userspace can configure thermal
zones to use a non-default governor through sysfs.

[1] https://lore.kernel.org/all/3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org/


> 
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>  drivers/thermal/thermal_of.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index d4b6335ace15..4a29ac3be2ac 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -355,6 +355,7 @@ static struct thermal_zone_params *thermal_of_parameters_init(struct device_node
>  	int coef[2];
>  	int ncoef = ARRAY_SIZE(coef);
>  	int prop, ret;
> +	const char *governor_name;
>  
>  	tzp = kzalloc(sizeof(*tzp), GFP_KERNEL);
>  	if (!tzp)
> @@ -365,6 +366,11 @@ static struct thermal_zone_params *thermal_of_parameters_init(struct device_node
>  	if (!of_property_read_u32(np, "sustainable-power", &prop))
>  		tzp->sustainable_power = prop;
>  
> +	if (!of_property_read_string(np, "policy", &governor_name)) {
> +		strncpy(tzp->governor_name, governor_name, THERMAL_NAME_LENGTH - 1);
> +		tzp->governor_name[THERMAL_NAME_LENGTH - 1] = '\0';
> +	}
> +
>  	/*
>  	 * For now, the thermal framework supports only one sensor per
>  	 * thermal zone. Thus, we are considering only the first two
> -- 
> 2.17.1
> 
