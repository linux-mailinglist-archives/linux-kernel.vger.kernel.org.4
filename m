Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD172DF1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbjFMKT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbjFMKTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:19:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE9C19D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:19:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso6571628e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686651554; x=1689243554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdr35NVvZt5grZEtwTcOPCBT+aQqpwrBlFz/EyaAZAY=;
        b=MT0jfmQ3GaGeOaRdULj4v+tzEv/qyqc7kkboNHxFk95UTYxahYr1Wu/ReM1jUPq7Y7
         5PnBXZMc96XvR2x5cF5Mo4g9VQzuxuve1smXA/x1s28HNaT0qoVmHkCdJF7zlce98Yah
         Vaz6sEnoempjBHWeWrMDdGTGYwd16RzI8vGSIoX30PXPM8N1PCsjDICvwfsV33xxQ+bM
         3PnDWmo4w56mPiOZQCh1PHZLXr662z+H0LyPnJ7YST9C+8Z8gHzx5BPW6C5bxnqP8edq
         V+sYD+GUUs+oixU+TF6PE9SL7pob/GuO+3XieGjKuBrvD4M3luTpfPbY6LVciutjW5jy
         DfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651554; x=1689243554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdr35NVvZt5grZEtwTcOPCBT+aQqpwrBlFz/EyaAZAY=;
        b=NjUAcvP0OwCaxWbKJ+giSM9ycDG9DjaprNVOzc6gXTxTFvLvqJ+tu1CdXX52E7OMLG
         cihFiWm4WS3of5SEXweRWDoTaufSdABFz/CIfY0Wq4xGQpdqfRQVPOYCY3EEPNc8zX1l
         rO+0k6/owptxZY6JggPi1F/Pf76C3z3JdkY+zrEB6Dql6ZycPXDgOVaTaq3VeyftbPjq
         97Wme1jpIr2TaGmMD4hlWZlJZ5VUTFL6C5tvtZ9RrdKPvoKTcG145sY+BDCpXqLh+PeQ
         B/ZRISQGKh3fgDlK5D/4284UcSJuZ8IWcB/L4h4Q+WSI/6ZhnLa71345w9AfWmfAC+B9
         dB+w==
X-Gm-Message-State: AC+VfDynYxXDJcQuxxUpngI1jZvN9kTuTyfBBqscvtGlPREzMMIg8rco
        Uj34PKky1Ezm4B0kJioIoEURIw==
X-Google-Smtp-Source: ACHHUZ6PKN8jwmaGHls2F2gl2akc40go/8ljLq7Qwlu5jF0CTKmMviLXMRWLeIbs9+JRw390KY37Rg==
X-Received: by 2002:ac2:5b9a:0:b0:4f3:9136:9cd0 with SMTP id o26-20020ac25b9a000000b004f391369cd0mr5734769lfn.44.1686651553968;
        Tue, 13 Jun 2023 03:19:13 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d6bf:b78b:2fff:653a? ([2a05:6e02:1041:c10:d6bf:b78b:2fff:653a])
        by smtp.googlemail.com with ESMTPSA id n6-20020a7bcbc6000000b003f6f6a6e769sm13838413wmi.17.2023.06.13.03.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 03:19:13 -0700 (PDT)
Message-ID: <16e72927-b3b0-7191-e05c-74acb5a77859@linaro.org>
Date:   Tue, 13 Jun 2023 12:19:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND 1/9] thermal/hwmon: Add error information printing for
 devm_thermal_add_hwmon_sysfs()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, glaroque@baylibre.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thara.gopinath@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        edubezval@gmail.com, j-keerthy@ti.com, f.fainelli@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
References: <20230613095624.78789-1-frank.li@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230613095624.78789-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 11:56, Yangtao Li wrote:
> Ensure that all error handling branches print error information. In this
> way, when this function fails, the upper-layer functions can directly
> return an error code without missing debugging information. Otherwise,
> the error message will be printed redundantly or missing.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> Resend patchset so that the changes to thermal/hwmon.c are copied to everyone.
>   drivers/thermal/thermal_hwmon.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index fbe55509e307..a580add5a2f6 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -271,11 +271,14 @@ int devm_thermal_add_hwmon_sysfs(struct device *dev, struct thermal_zone_device
>   
>   	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
>   			   GFP_KERNEL);
> -	if (!ptr)
> +	if (!ptr) {
> +		dev_err(dev, "Failed to allocate device resource data\n");
>   		return -ENOMEM;
> +	}

When an allocation fails, there is a callstack showed. It is not 
necessary to print an error in this case.

>   
>   	ret = thermal_add_hwmon_sysfs(tz);
>   	if (ret) {
> +		dev_err(dev, "Failed to add hwmon sysfs attributes\n");
>   		devres_free(ptr);
>   		return ret;
>   	}

That should not display an error. The call site will take care of that.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

