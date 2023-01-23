Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1E167826C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjAWQ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjAWQ7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:59:47 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE1510C8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:59:45 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w11so87663edv.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xK/tJD2L46iP/URfZGuVe4KqSktL9jm8XqyOKQlMWUc=;
        b=C3Zdpzssjw/N8nZmtlDkdTlrmRFezDyF04q9f30A2Yn6VdKPIsuxO+5sMUZnQURu8f
         eJHB7BQE+B0N9svPpWUisK7v9fmtZ7WGbfA0oZEklCJNTHiSxqgKGnhdTDJ3Jq/5inEs
         uKqnXx6BOz3Slauoz0uUM2gZaHPSAPB6K+I3uuS9YLEQl45eq5E2oDevuTsDT/ybzka+
         SH1CbGAKqzmcBZjKDPforPR0UDtq8kys12+Oc33k0tnj676wBP9GckT1gutHlEwbrNvr
         vxOn96iHfpZA9BOw/orQL7hINtyg0jOtzGdE/UnubkflV2yxMxGmoZxXpvubHZkf7JRZ
         Ka/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xK/tJD2L46iP/URfZGuVe4KqSktL9jm8XqyOKQlMWUc=;
        b=0JFdqDhBiL3fSRSumro0OYg39KzGXFXeOkHu6JRPY6/uuswkgmSK3/WbZqUUr//M6v
         Kx76Lhw5tEQ2PeFW7ILrxe/2bSGjNptD0e3mP61Hm61VKbjWgHXKvCJ/ZRi8CZKFGWBB
         70iszc1JP4OKXl3XqV+uP8k2xIwRVM4aaiC5zLAA3rxKKiaaf9D3om7rkSyeoBp6fd51
         BSsYBlbuLVRv22ctLl/USiCc1XNMyCdWMLWgjt/DQmXARZ/KDRWGLAITH4bmtUyv5VOf
         6LgqjZTO6DxSdCZHUoeYPAP5xObap0bO9I//yC077175rtP3fE69jUL44ml0SZeQr+FK
         6oZg==
X-Gm-Message-State: AFqh2kpm1VPPDL+MNpvxAzMzGdMemaArzOI+ENlHoFX2vcl4jeOgNNZo
        IhJ2zIMZWcC3A5re55gOCj0Zvw==
X-Google-Smtp-Source: AMrXdXst8AG3jkX/eSdhSIJ7ADBSzh6KhNY/+rEfVHGCYZ4T5aCH5AT4/LAdJ2nV2eVDUy4OIXZN0w==
X-Received: by 2002:a05:6402:448d:b0:498:2f9f:3442 with SMTP id er13-20020a056402448d00b004982f9f3442mr27190337edb.2.1674493184575;
        Mon, 23 Jan 2023 08:59:44 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id d26-20020a056402401a00b0046c7c3755a7sm8271999eda.17.2023.01.23.08.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:59:44 -0800 (PST)
Message-ID: <fd71f1ef-22c7-c0cb-cb68-b7a044c94d03@linaro.org>
Date:   Mon, 23 Jan 2023 17:59:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/4] cpufreq: qcom-nvmem: use SoC ID-s from bindings
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        agross@kernel.org, andersson@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230121112947.53433-1-robimarko@gmail.com>
 <20230121112947.53433-3-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230121112947.53433-3-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.01.2023 12:29, Robert Marko wrote:
> SMEM SoC ID-s are now stored in DT bindings so lets use those instead of
> defining them in the driver again.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index c0a7841a56c1..da55d2e1925a 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -30,12 +30,7 @@
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/soc/qcom/socinfo.h>
>  
> -enum _msm_id {
> -	MSM8996V3 = 0xF6ul,
> -	APQ8096V3 = 0x123ul,
> -	MSM8996SG = 0x131ul,
> -	APQ8096SG = 0x138ul,
> -};
> +#include <dt-bindings/arm/qcom,ids.h>
>  
>  enum _msm8996_version {
>  	MSM8996_V3,
> @@ -150,12 +145,12 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>  		return NUM_OF_MSM8996_VERSIONS;
>  
>  	switch (info->id) {
> -	case MSM8996V3:
> -	case APQ8096V3:
> +	case QCOM_ID_MSM8996:
> +	case QCOM_ID_APQ8096:
>  		version = MSM8996_V3;
>  		break;
> -	case MSM8996SG:
> -	case APQ8096SG:
> +	case QCOM_ID_MSM8996SG:
> +	case QCOM_ID_APQ8096SG:
>  		version = MSM8996_SG;
>  		break;
>  	default:
