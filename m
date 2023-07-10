Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A425F74D487
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjGJLYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjGJLYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:24:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D748CE6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:24:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f766777605so6647369e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688988270; x=1691580270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EsmRez3KeHQWdsJ3zq2e6f0SK1pc07OA73nm0/B2seM=;
        b=v0Cr0QFWQsHZmlclQH2S9Qiaqz4FCviB34atyeGMOYHIL453hnO1P9ILhLa7R+LZ2i
         udryNYN2F2C89rhT8HZWQDieO0lTSZzNQlkgf+Sc4j8oo8QgZExJ3OwzDq15y9RDkJch
         phy83dvtqbWKScZoWelz1h0za6LV6KmcQECdtzZ/r+otPTrXe4Kdldt9t5N6Hr0qgmjM
         okWJYXfFqMB3J+34Za4lF/hfH/VPHCH81vQnQuagrV3lVPqDxJJIBnkQNG/ppOSGZ0wl
         tNxoHueAFq0+VPy16aWWHw6jfLF1IYbCGw3AfslNtdyy5+l3EatW0vdnY71fRas5JtRF
         15/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688988270; x=1691580270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsmRez3KeHQWdsJ3zq2e6f0SK1pc07OA73nm0/B2seM=;
        b=Fh6COnEWGrX/RJuYFgLdT/JpqdZbDGTWwVJk37d+7XLHVqQfR0Dx8q43q6C1Xr65UK
         Lifi5UfpVOCvdJEeOOti/8Ma5/ADs3HycfodF2Pc5UrKEnx+3qjCBYNqd6WsxDf01Ub8
         4UHpu3jBOlWcKI4AQIt5fDadWM1HCgSpaXWP2D1tRjSGTWq/0+dKzFwrbbLg1/CWOEq6
         auMLfYC0PNeksQPjMzdz0+3oUoI1Gw1uYrQ1kPQIQsC6B1jEZAembuaO3rFo18bkfXj4
         o7x+T1ooP8jUcmV8S9i3+EmXANqJCGQFlPqXZ/PUfDKnnP74LVq44Q9unEO81tO6M8zs
         imug==
X-Gm-Message-State: ABy/qLb58macTd5mUYPUItkbyERyCMh7huJ6nsiUFZKC7PSpjdj+IAW4
        PHXf/SDw+X0+ON2A21uvH/v7/Q==
X-Google-Smtp-Source: APBJJlGGbY2Z3JDTdaSK2Ajis/zFp40GglOPvR+BEW0tOC1+kQ83lZAaGRYqDnmhNR3TkSv/y/DUUQ==
X-Received: by 2002:ac2:4e81:0:b0:4fb:9168:1fc7 with SMTP id o1-20020ac24e81000000b004fb91681fc7mr8851360lfr.51.1688988270147;
        Mon, 10 Jul 2023 04:24:30 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id g17-20020ac25391000000b004fb5bbc47cdsm1668763lfh.307.2023.07.10.04.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 04:24:29 -0700 (PDT)
Message-ID: <96e52c65-6216-91ba-8d2b-197f86433d98@linaro.org>
Date:   Mon, 10 Jul 2023 14:24:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/6] thermal/drivers/tsens: Add IPQ5332 support
Content-Language: en-GB
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-7-quic_ipkumar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230710103735.1375847-7-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 13:37, Praveenkumar I wrote:
> IPQ5332 uses tsens v2.3.3 IP and it is having combined interrupt as
> like IPQ8074. But as the SoCs does not have RPM, kernel needs to
> take care of sensor enablement and calibration. Hence introduced
> new ops and data for IPQ5332 and reused the feature_config from
> IPQ8074.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
>   drivers/thermal/qcom/tsens-v2.c | 13 +++++++++++++
>   drivers/thermal/qcom/tsens.c    |  3 +++
>   drivers/thermal/qcom/tsens.h    |  2 +-
>   3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index db48b1d95348..8b6e3876fd2c 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -237,6 +237,19 @@ struct tsens_plat_data data_ipq8074 = {
>   	.fields	= tsens_v2_regfields,
>   };
>   
> +static const struct tsens_ops ops_ipq5332_v2 = {

Please drop v2. It is unclear if it refers to tsens being v2 or being 
specific to ipq5332 v2.

> +	.init		= init_common,
> +	.get_temp	= get_temp_tsens_valid,
> +	.calibrate	= tsens_v2_calibration,
> +};
> +
> +struct tsens_plat_data data_ipq5332 = {
> +	.sensors_to_en	= 0xF800,

This doesn't seem to match the offsets that you have enabled in the DTSI.

> +	.ops		= &ops_ipq5332_v2,
> +	.feat		= &ipq8074_feat,
> +	.fields		= tsens_v2_regfields,
> +};
> +
>   /* Kept around for backward compatibility with old msm8996.dtsi */
>   struct tsens_plat_data data_8996 = {
>   	.num_sensors	= 13,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 169690355dad..e8ba2901cda8 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1140,6 +1140,9 @@ static const struct of_device_id tsens_table[] = {
>   	}, {
>   		.compatible = "qcom,ipq8074-tsens",
>   		.data = &data_ipq8074,
> +	}, {
> +		.compatible = "qcom,ipq5332-tsens",
> +		.data = &data_ipq5332,
>   	}, {
>   		.compatible = "qcom,mdm9607-tsens",
>   		.data = &data_9607,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index f8897bc8944e..36040f9beebc 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -701,6 +701,6 @@ extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8
>   extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
>   
>   /* TSENS v2 targets */
> -extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
> +extern struct tsens_plat_data data_8996, data_ipq8074, data_ipq5332, data_tsens_v2;
>   
>   #endif /* __QCOM_TSENS_H__ */

-- 
With best wishes
Dmitry

