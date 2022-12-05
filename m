Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68DF642F95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiLESHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiLESHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:07:09 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E8C201B3;
        Mon,  5 Dec 2022 10:07:08 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so2209804otp.9;
        Mon, 05 Dec 2022 10:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mE+3XB5IEKDhRnqHM4DOUC+WCo7qc9F0k/SKBMW/+jk=;
        b=bfaVpBpN9MBkcpIZFH/kxvgc4Wsqa95Lg9fp1NhpSJZC5HdBghVcNnL5V8/8dSZg35
         j8racjBtzZj5IE1uba8EbLt77Z/auMgE7JSJNkBpS0aoQXrmuqAIhrByxuzk1pVYXCYT
         Eb2tKBKg7qNXz8zU9+lmRHde4kLy4Ett9mu5y3E9fkSHjSUwF1soLNrpvORMdTYMTEwQ
         iUAjz1aZw+Yq9BUJw/SBQk/dEzZZzAHm13cGlCqnyx5854b7uAGpZyPSAKgHfrOd8LF6
         hihCwcGapX2yTCPzti8FSPneGRZoM0GjFBZepT2DobrDL2H2A03e9rfCtKqDH4oOI17y
         CAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mE+3XB5IEKDhRnqHM4DOUC+WCo7qc9F0k/SKBMW/+jk=;
        b=KfEcWlhO/bekEPKx/uZCr2N+tCrxvBjkbSiP5yBkhXg/eYVCWOn0+6+9FFgSQryHIK
         vCOd+UOQ+0mRydpG2y5hPTXfEBnDik89qCREaGWu4/q3siXJKhxr92PkeTAfCxXQSSrD
         78NsApGzJVi8aeTmuvcUUhz8x0qGRdhT5+0Lb8X5X5W/iMOjQc02fFUjzyk1vPX3j/e8
         iujwv4tG0KPRW9asFu9z8sbijxyJmk9ub+J+KM0UYFb/rBgRfhn/FFRSLgbYNMT56GYt
         QuyfRU2yXAXDfv+r+ytsnqFHLpz4FeGbCwIt38mxkTpeNBbofebVpdsDTPPnWqAD8sUO
         cooQ==
X-Gm-Message-State: ANoB5pk/VgbbD4PqoIikTYXtVoaf9AXDaUjar/WMQcbvN8aXAwiEauNL
        fdx2itzeQxd0QDOjrf2IhBoFYqpDECiLsg==
X-Google-Smtp-Source: AA0mqf43Dp4ipEthqgd0Gqbcm+40iCwbaQOE1KdAvIWut8YsZz20Xj+X0027VGyqdLFqD2k8xgWLmg==
X-Received: by 2002:a9d:6247:0:b0:66c:cfb8:a32e with SMTP id i7-20020a9d6247000000b0066ccfb8a32emr31409503otk.184.1670263627396;
        Mon, 05 Dec 2022 10:07:07 -0800 (PST)
Received: from ?IPV6:2603:8081:2802:9dfb:b9b:12f2:9a60:2073? (2603-8081-2802-9dfb-0b9b-12f2-9a60-2073.res6.spectrum.com. [2603:8081:2802:9dfb:b9b:12f2:9a60:2073])
        by smtp.gmail.com with ESMTPSA id r41-20020a05687017a900b0014378df87cfsm9481866oae.33.2022.12.05.10.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 10:07:07 -0800 (PST)
Message-ID: <e5e024a2-a530-9f4f-76f4-5f239b3608a3@gmail.com>
Date:   Mon, 5 Dec 2022 12:07:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] cpufreq: acpi: Only set boost MSRs on supported CPUs
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kyle Meyer <kyle.meyer@hpe.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221205175744.9746-1-stuart.w.hayes@gmail.com>
Content-Language: en-US
From:   stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20221205175744.9746-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/2022 11:57 AM, Stuart Hayes wrote:
> Stop trying to set boost MSRs on CPUs that don't support boost.
> 
> This corrects a bug in the recent patch "Defer setting boost MSRs".
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
>   drivers/cpufreq/acpi-cpufreq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index bb58175a8d40..a7c5e312340e 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -888,7 +888,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
>   		pr_warn(FW_WARN "P-state 0 is not max freq\n");
>   
> -	set_boost(policy, acpi_cpufreq_driver.boost_enabled);
> +	if (acpi_cpufreq_driver.set_boost)
> +		set_boost(policy, acpi_cpufreq_driver.boost_enabled);
>   
>   	return result;
>   

My apologies--adding Boris, I forgot to put him on the "to" list.
