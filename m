Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E68688D94
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 03:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBCC6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 21:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjBCC6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 21:58:03 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB81E8AC34
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 18:57:39 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id n6so3938591edo.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 18:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKQmygBEZeRuMWlXEwKwIU+7fft7wguti267JsfX7ks=;
        b=pdGroF1ZfQZvyVUZhL+/+VNj6+FaGPWlAKE0M38vEiILELEPIWtChPgPv23p+HKltr
         a6p1N/E5L3msAOptVOq42/Tz6tGTyET+J/6rzW5EHALrSfksBCaMWgyzWZAztloWbEVU
         0u7B6ejkb+1plJquBzUgK+7U+iEsOshoDPe9HpQF4f449d5/TZBWfat7a8AcBcfCx2XP
         Ewd9zIkCyUIBjzHhCA5DMrWw6NNGO8FMwqRxq9r07o7shKMhglJCn4qAG1e5Hvh/zRRt
         0zDZUcLeMsF7PwqrXiH0IMs6RCYMlgbCdLGcH1HNi8J/fu+lse3Lr7gxLMtuOn3srHQX
         XtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKQmygBEZeRuMWlXEwKwIU+7fft7wguti267JsfX7ks=;
        b=RMKEFB7jb0Ont4kMwodg/wz81vTsewtIRll4Z7qv49ZLpX2+f0VYx+W+AkwyXktidk
         5iuHyp6dvAFEvLSiaxuEiKvVe4zLSi/72Z/ypGOFOoEEpvYzj8JmBrG+PBfRGHLHX8b6
         jE5H7+n5O/y5U3Nmz0btZqV8A8+Qxkt0GI3+CWw50l8G+hPfyfmsc2fd8wCFNT5cox15
         LO2m6PofVUt+gfGJjztpqtGaKKzpjAg6XUzSjatZncpxn0/jDTMLLY4dEk/wqBLZLHxh
         hcnCssGB/BRo24wlFCWFUKYeld+vKxpRKD+XbWepU0VSWswe9S5sjCVIKssAlwGAMgZo
         RERg==
X-Gm-Message-State: AO0yUKVRO6mk3YR/ydoYWmF7uXaUGo6c3n3W/qB/vM3J6tS2lw/m6cmN
        hVwoyM9pYdloVVNp5H+m56xdMg==
X-Google-Smtp-Source: AK7set+d9yOcvNKsYTYBPkS9RL4yLRG5jvK5E0pBXawOp2p5FFeqCH5W3HQFV4iwfuvJ54JWiqdVbA==
X-Received: by 2002:a05:6402:3589:b0:4a4:d49b:34a6 with SMTP id y9-20020a056402358900b004a4d49b34a6mr8854268edc.9.1675393058450;
        Thu, 02 Feb 2023 18:57:38 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id et6-20020a056402378600b004a21263bbaasm480519edb.49.2023.02.02.18.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 18:57:38 -0800 (PST)
Message-ID: <5b089f60-6dec-50f6-dea3-54170bf7fef7@linaro.org>
Date:   Fri, 3 Feb 2023 03:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 13/23] interconnect: qcom: sm8550: fix registration race
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
References: <20230201101559.15529-1-johan+linaro@kernel.org>
 <20230201101559.15529-14-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230201101559.15529-14-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.02.2023 11:15, Johan Hovold wrote:
> The current interconnect provider registration interface is inherently
> racy as nodes are not added until the after adding the provider. This
> can specifically cause racing DT lookups to fail.
> 
> Switch to using the new API where the provider is not registered until
> after it has been fully initialised.
> 
> Fixes: e6f0d6a30f73 ("interconnect: qcom: Add SM8550 interconnect provider driver")
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/interconnect/qcom/sm8550.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
> index 54fa027ab961..7ab492ca8fe0 100644
> --- a/drivers/interconnect/qcom/sm8550.c
> +++ b/drivers/interconnect/qcom/sm8550.c
> @@ -2197,9 +2197,10 @@ static int qnoc_probe(struct platform_device *pdev)
>  	provider->pre_aggregate = qcom_icc_pre_aggregate;
>  	provider->aggregate = qcom_icc_aggregate;
>  	provider->xlate_extended = qcom_icc_xlate_extended;
> -	INIT_LIST_HEAD(&provider->nodes);
>  	provider->data = data;
>  
> +	icc_provider_init(provider);
> +
>  	qp->dev = &pdev->dev;
>  	qp->bcms = desc->bcms;
>  	qp->num_bcms = desc->num_bcms;
> @@ -2208,12 +2209,6 @@ static int qnoc_probe(struct platform_device *pdev)
>  	if (IS_ERR(qp->voter))
>  		return PTR_ERR(qp->voter);
>  
> -	ret = icc_provider_add(provider);
> -	if (ret) {
> -		dev_err_probe(&pdev->dev, ret,
> -			      "error adding interconnect provider\n");
> -		return ret;
> -	}
>  
>  	for (i = 0; i < qp->num_bcms; i++)
>  		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
> @@ -2227,7 +2222,7 @@ static int qnoc_probe(struct platform_device *pdev)
>  		node = icc_node_create(qnodes[i]->id);
>  		if (IS_ERR(node)) {
>  			ret = PTR_ERR(node);
> -			goto err;
> +			goto err_remove_nodes;
>  		}
>  
>  		node->name = qnodes[i]->name;
> @@ -2241,12 +2236,17 @@ static int qnoc_probe(struct platform_device *pdev)
>  	}
>  	data->num_nodes = num_nodes;
>  
> +	ret = icc_provider_register(provider);
> +	if (ret)
> +		goto err_remove_nodes;
> +
>  	platform_set_drvdata(pdev, qp);
>  
>  	return 0;
> -err:
> +
> +err_remove_nodes:
>  	icc_nodes_remove(provider);
> -	icc_provider_del(provider);
> +
>  	return ret;
>  }
>  
> @@ -2254,8 +2254,8 @@ static int qnoc_remove(struct platform_device *pdev)
>  {
>  	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
>  
> +	icc_provider_deregister(&qp->provider);
>  	icc_nodes_remove(&qp->provider);
> -	icc_provider_del(&qp->provider);
>  
>  	return 0;
>  }
