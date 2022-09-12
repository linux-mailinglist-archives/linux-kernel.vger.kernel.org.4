Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49A75B5EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiILRNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiILRNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:13:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5AB2CC96
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:13:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id i19so5602016pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=K3SFvwuZhRXAUmXX0eEHznvbncqQ04UQY6UICCI5u4c=;
        b=gE3UsfG4ll+bqVJrq7lvgGZWHJ2G8kxgraF/3yFnbAFv1A4uCW2Krqjxrzh0EkWPg1
         zzwKW3p50+ConsKX/1ftQP6U80T3nU40Ox/6tNTM8NoN6QTb/o1Sp203x3fwHR5++t3n
         NXS4oqz7H/8jaE2GinQ4xuHPGZZDrnZPAf/ax4xr68RKdYeZ/rFGx2IIXqWGir1rpjVF
         93b3Ct4yRwMIjlo786VV02EpGSOYWlk8D+jAep0rBtyFQ2u3VCfOPOluUB9OvMCBfsJN
         m/BzjsqACDJ+6f12+fOAt49qphCncVE9XM7qpgMpFKT7alRpw8Fl3dI7M5vA5jEct7YV
         6JuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=K3SFvwuZhRXAUmXX0eEHznvbncqQ04UQY6UICCI5u4c=;
        b=GH9F84d7K1YJWNEz8nptVep+3JhXRrTLS4O+NWXR6kK3/bn4jQevHM3S2DJTGI9iCn
         H8mhqg+8d/EYGm1lz3MnLOzAPXC1I1wocNYGzh/kdJ2sVgTayWRn8R8f9lP+R6fedct0
         maPytjjOcFGtjdPYE4y/Cwm6DwpiGi7Ovq8uet/p0nxT3FoLJF3C8sJLR/mmWlCynDfp
         oBSU/nGlChP13rlhht9oiqAGclIOd8fylfggFMu+tbbg3N6cfwtn8dbRLbfQiOSuqbuw
         ISFuPW/mnx8bwNvJSez2yojApBG3AztPVOnFOnZJWaX5o6IMaQLQ0dv/kDS92WX60f/B
         U2LA==
X-Gm-Message-State: ACgBeo34dsWixuphlPLCirA6df+oCiDneSnuBGlYXN8umGg+oDXTxS22
        CHf/+1SRaFk84hJUjpyGVL3MhA==
X-Google-Smtp-Source: AA6agR6g4r7l39YGa4rkP++m24fwHukkSZ7FKqzoPtc9Ocwp5jEGOGLVBHKKh5t5oVfX8DAWnKcc6Q==
X-Received: by 2002:a63:6c88:0:b0:430:662:e24c with SMTP id h130-20020a636c88000000b004300662e24cmr24656585pgc.318.1663002781496;
        Mon, 12 Sep 2022 10:13:01 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:5362:9d7f:2354:1d0a:78e3? ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id 4-20020a630304000000b00428c216467csm5925486pgd.32.2022.09.12.10.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 10:13:01 -0700 (PDT)
Message-ID: <ef214c7c-b68d-c3f3-5f75-2ab4d28ab59f@linaro.org>
Date:   Mon, 12 Sep 2022 22:42:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] coresight: etm4x: Fix crash observed on Qcom ETM parts
 with 'Low power override'
Content-Language: en-US
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220825052232.11013-1-bhupesh.sharma@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20220825052232.11013-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/22 10:52 AM, Bhupesh Sharma wrote:
> Some Qualcomm ETM implementations require skipping powering up
> the trace unit, as the ETMs are in the same power domain as
> their CPU cores.
> 
> Via commit 5214b563588e ("coresight: etm4x: Add support for
> sysreg only devices"), the setting of 'skip_power_up' flag was
> moved after the 'etm4_init_arch_data' function is called, whereas
> the flag value is itself used inside the function. This causes
> a crash when ETM mode 'Low-power state behavior override' is set
> on some Qualcomm parts.
> 
> Fix the same.
> 
> Fixes: 5214b563588e ("coresight: etm4x: Add support for sysreg only devices")
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   - v1 can be seen here: https://lore.kernel.org/lkml/20220803191236.3037591-1-bhupesh.sharma@linaro.org/
>   - Addressed the review comments from Suzuki.
>   - Rebased on linux-next.
> 
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index d39660a3e50c..14c1c7869795 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -977,6 +977,16 @@ static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
>   	if (!cpu_supports_sysreg_trace())
>   		return false;
>   
> +	/*
> +	 * Some Qualcomm implementations require skipping powering up the trace unit,
> +	 * as the ETMs are in the same power domain as their CPU cores.
> +	 *
> +	 * Since the 'skip_power_up' flag is used inside 'etm4_init_arch_data' function,
> +	 * initialize it before the function is called.
> +	 */
> +	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
> +		drvdata->skip_power_up = true;
> +
>   	/*
>   	 * ETMs implementing sysreg access must implement TRCDEVARCH.
>   	 */
> @@ -1951,8 +1961,7 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>   		return -EINVAL;
>   
>   	/* TRCPDCR is not accessible with system instructions. */
> -	if (!desc.access.io_mem ||
> -	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
> +	if (!desc.access.io_mem)
>   		drvdata->skip_power_up = true;
>   
>   	major = ETM_ARCH_MAJOR_VERSION(drvdata->arch);

Gentle ping. Any review comments on the v2?

Thanks,
Bhupesh
