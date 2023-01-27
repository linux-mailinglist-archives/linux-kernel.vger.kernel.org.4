Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9381567E89E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjA0OuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjA0OuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:50:04 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAB2449D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:50:03 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x10so4916759edd.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZPG9Z5Pk+99+CAtPa4G8jXmIilkOFP59E89fWS9Tno=;
        b=tgjPvxh/pJfAXMdziXyEeEF9U6sLvikVD18AyVQeSqbni1jNMdiVXGmXJwb8BYq7o/
         iS6c2stGPYd5uv00n+c1TtHLW0RvvXj3AHE5B7g0YCL+yF4uaDjorHDH4jc0Q2KLXbXP
         IYpJcBIsM5Y1kW3/j4eagcFg7s9OOAT4FhUtd3+vUJYK7JyBCrSKCkUozzQjwtQqRJXK
         cSwNX5brhxox/d1ORN4PhGD2yfdMlhKpNScw4qabnrJmzaHEKX528G8o4PkVMlr98fXx
         6/u8aaXQ0E0gTiTr3bCFKS9GXf5nt78rJiEz8sgT5haYhBNOK6s7LNH8Jwp/xoI8uInW
         2fUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZPG9Z5Pk+99+CAtPa4G8jXmIilkOFP59E89fWS9Tno=;
        b=HJDq3mIEZVExUvcZagw4/YwtH8Rl5A9/2skL3eB4lfbgo5wdaRO3GLJtnhRyGSsZM2
         0Y0EF9zgpqIy9cI8PFaE11JYCJGfmWIIQLkjl3zT06Oho6g8f4PnYG4bv31B4Gt741DY
         99XpTgWuXLPLeA0FAopuB/htLpSm0YxnwsHmR4eGsNft2CZWU41dc7ZFh8TXIDAd+34v
         VjNATU7VmIAa7/yOiERH9vAohinW/1SIJdztA72STl3FDX4FYFdkvT7jvPLDgNaiTAEE
         RdQYfcboRQ8lbKYfNIBUg6zH4A7NRg/enVuIKpqG0z1kHm4g8l6P183NAaKJt8YxiFSN
         IIcw==
X-Gm-Message-State: AFqh2konQ4sKq6fPVifm9SHxIQpQ1mgnDjxKodTqVDtz4UUCN2x5aI4w
        x9go8/2QwD4yRPF3DqDpSlb+Bw==
X-Google-Smtp-Source: AMrXdXvraQZzNrnRPnzCeg3q9+hqR7m0LyKh+Wfqcowzj33Bm+AtmyN6Ks68Us/hw/fqTlwk090EDQ==
X-Received: by 2002:a05:6402:159:b0:49d:a87f:ba7b with SMTP id s25-20020a056402015900b0049da87fba7bmr40539457edu.39.1674831002335;
        Fri, 27 Jan 2023 06:50:02 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id y8-20020a056402134800b004610899742asm2410252edw.13.2023.01.27.06.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 06:50:01 -0800 (PST)
Message-ID: <27878e7c-b345-06e9-6e69-e9ac397a9ec1@linaro.org>
Date:   Fri, 27 Jan 2023 15:49:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] soc: qcom: llcc: Fix slice configuration values for
 SC8280XP
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230127144724.1292580-1-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230127144724.1292580-1-abel.vesa@linaro.org>
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



On 27.01.2023 15:47, Abel Vesa wrote:
> These new values are now based on the latest LLCC SC table.
> 
> Fixes: ec69dfbdc426 ("soc: qcom: llcc: Add sc8180x and sc8280xp configurations")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
I can't verify this, but it looks sound so:

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> The v1 is here:
> https://lore.kernel.org/all/20230126171636.2319496-1-abel.vesa@linaro.org/
> 
> Changes since v1:
>  * dropped the LLCC_GPU and LLCC_WRCACHE max_cap changes
>  * took the new values from documentatio this time rather than
>    downstream kernel
> 
>  drivers/soc/qcom/llcc-qcom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 23ce2f78c4ed..26efe12012a0 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -191,9 +191,9 @@ static const struct llcc_slice_config sc8280xp_data[] = {
>  	{ LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>  	{ LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0, 0 },
>  	{ LLCC_WRCACHE,  31, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> -	{ LLCC_CVPFW,    32, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> -	{ LLCC_CPUSS1,   33, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> -	{ LLCC_CPUHWT,   36, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> +	{ LLCC_CVPFW,    17, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_CPUSS1,   3, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_CPUHWT,   5, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
>  };
>  
>  static const struct llcc_slice_config sdm845_data[] =  {
