Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB167D308
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjAZR0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjAZR0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:26:05 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5386C116
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:25:56 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id fi26so2520090edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWKRlGogYap3CPDI8diqF4ISvAYgz/9ImImC4379uNg=;
        b=dXWQrb5nhjTHjzjUTHHaj0fP7mIG1swSzaVkGHXGGMUaI+4UAXL3ywsws3BtjRn1Gp
         aSmxfWLFONn9D274NDwiPm7kF74tLwfLCKOsRjyPNXCwJtqKlgTdx9+NdbjeoeEDA0ef
         Stldk5VJhWXQ2etNEflTLkQfNBG8duvICregbO8838mj9c8edgB+8N8OoPJfbqRDZ8BZ
         okLmVP2dX2bBNNr1eHwQ1om0/6Q/VmPK+O4JKAY04EM72p7Lf62qLTb0rlq7S7wF/fB3
         h6vEZN9I4HYY9A99Y+NYIU0Lnc/wslvZtVH0AjN/bHbOOhVMLftfBN+MBfybOjTy9Uof
         biRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWKRlGogYap3CPDI8diqF4ISvAYgz/9ImImC4379uNg=;
        b=3CfmYHjou4CXVt80Df7LkcZ3pXFaHbsLO2W5qE+T/u1xqS9AfNmGy1VcwP0lJ6l31D
         u2Pw4eUeunOiRPeTy69BmdKrvsNFODAApWTS5UGUv+q0vBthe1vcKxCCLL/ocn+QzDdy
         t4cvkyXtPj46bMLBzRe4Ohnvxam/RHaEAuYmImwXhlVGpMGiLDww7KLJUqQKEVa3i+pG
         HDQDLytM2BvIk6fxc+ch9aQ+5WFyIYMOWBov4Kojd6v/QUusbizeEi7OEbY3jH/tPIET
         thma/ooctiw5D0SwivBaTdKAJRCEum51BhK8FYSVwWpZUgN79pjimnyEOO4K2Cgt7xGG
         pzcQ==
X-Gm-Message-State: AFqh2krAN+vsubyzwbirqdeKD/A5qyVnEyw4oZn8ScElwIPRJKhmU2O9
        iwlJd0T5Z8zI4o/0+YSFxhafK8qh2TWSyA4B
X-Google-Smtp-Source: AMrXdXsM2R/sb8iXS1jpA8aP4DxzntghQIgGKnSPt9RmXpzADjyYGWh0nE7O07jmsWks7Oy57Cek1g==
X-Received: by 2002:a05:6402:5407:b0:483:21d8:87af with SMTP id ev7-20020a056402540700b0048321d887afmr41965472edb.24.1674753954637;
        Thu, 26 Jan 2023 09:25:54 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id w12-20020a05640234cc00b0049fc459ef1fsm998410edc.90.2023.01.26.09.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 09:25:54 -0800 (PST)
Message-ID: <09bf9907-27b9-146f-4a94-dcab51350d5a@linaro.org>
Date:   Thu, 26 Jan 2023 18:25:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] soc: qcom: llcc: Fix slice configuration values for
 SC8280XP
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230126171636.2319496-1-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230126171636.2319496-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.01.2023 18:16, Abel Vesa wrote:
> The new values have been taken from downstream kernel.
> 
> Fixes: ec69dfbdc426 ("soc: qcom: llcc: Add sc8180x and sc8280xp configurations")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/soc/qcom/llcc-qcom.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 23ce2f78c4ed..5702354fb946 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -183,17 +183,17 @@ static const struct llcc_slice_config sc8280xp_data[] = {
>  	{ LLCC_AUDIO,    6,  1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0, 0 },
>  	{ LLCC_CMPT,     10, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0, 0 },
>  	{ LLCC_GPUHTW,   11, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> -	{ LLCC_GPU,      12, 4096, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 1 },
> +	{ LLCC_GPU,      12, 4608, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 1 },
priority (the arg right after 4608) should be 0 per downstream


>  	{ LLCC_MMUHWT,   13, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
>  	{ LLCC_DISP,     16, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>  	{ LLCC_AUDHW,    22, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>  	{ LLCC_DRE,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>  	{ LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>  	{ LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0, 0 },
> -	{ LLCC_WRCACHE,  31, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> -	{ LLCC_CVPFW,    32, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> -	{ LLCC_CPUSS1,   33, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> -	{ LLCC_CPUHWT,   36, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> +	{ LLCC_WRCACHE,  31, 512, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> +	{ LLCC_CVPFW,    17, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_CPUSS1,   3, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_CPUHWT,   5, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
CMPT1 (id 34) is still missing.

With that:
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  };
>  
>  static const struct llcc_slice_config sdm845_data[] =  {
