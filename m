Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122646AB930
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCFJD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCFJDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:03:22 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13D4B44E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:03:19 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id az36so5142510wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678093398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJHpGiNNnS/iHuhCrLJC3kyZETQwy2cp7ry6pPyZxIQ=;
        b=hzrwwOjdSHOzylUPLi1JyT0tk4upCyVExNtQamh0nS/rBJwh4KYQ/1Uvs7SCa7hm7d
         YJ6OzeVIGuCpOxuY0QCGh3tgHIkJ67xL5qp37sVCVoKqQ7K6jLxzWurAmpI4z8jsxT1N
         lKvRHne/mKFVmokyMoXSMBRmDoOIPHw5UqpNTRkpG/dCZ1BLzyptBqAYLVjSnWICedhE
         rr+PzCy2PTxMdpb1ZpKr0Xgm0wC3ShJ4U5hRqV6RzF3zGufARNtQlHJsu4wDhR/DddmK
         KKvo08qYT4lRD69xYqiIzG77MlihQHVIxUPdBa+XJkkX9teUea1H5h3SZZz3B6QFaIz/
         2bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678093398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJHpGiNNnS/iHuhCrLJC3kyZETQwy2cp7ry6pPyZxIQ=;
        b=qH3mNmvduzHugU82rXq+VWk8FABbyuhwBmXaDJgRD631s0nI8DL67fPIsGMK5WIDhO
         w5qzQkwR+PfFdiAgPZ8KUGnPPa5Ju/3cXHOUBvzU/0wSbtBr0pXH52UN1aTp/Ur69OvR
         /CN+0931gK5VJmy4Iacj20yeZmjJ3U3OKYKKVO50/JYBENg6etuA6mFRc9QiTi8r3/k4
         l9tAS1aliuSq6QaMdhIWlzacXOUtj2e2KgcYVNb9ydQnz+bYGloB2BBncZjSeOBRxsgN
         e2wrxIw3dRZiHBx98Ems9Btg3s+FNAhITSDQMcakkZ/BDbeRqsBmbRJsCShDwHBQNWSA
         Bscw==
X-Gm-Message-State: AO0yUKVj9uIIzk9oahV0zEA6xVmQIRtqY2XvSNpA+HR1qedVIme+udcP
        rReijB6Qq7dPCbLhY98/lAaZZA==
X-Google-Smtp-Source: AK7set87B67sTGmugB4xDggZWu9Lud32vEXYunKTICLonbRHmTLO7JqmrVgjWob32QN9cC5Jy5Nulw==
X-Received: by 2002:a05:600c:1d24:b0:3da:1f6a:7b36 with SMTP id l36-20020a05600c1d2400b003da1f6a7b36mr8498979wms.0.1678093397987;
        Mon, 06 Mar 2023 01:03:17 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c205400b003e8dcc67bdesm12966260wmg.30.2023.03.06.01.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:03:17 -0800 (PST)
Date:   Mon, 6 Mar 2023 11:03:14 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/23] interconnect: qcom: sm8550: fix registration
 race
Message-ID: <ZAWsUrlrOfmmNBy3@linaro.org>
References: <20230306075651.2449-1-johan+linaro@kernel.org>
 <20230306075651.2449-14-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306075651.2449-14-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-06 08:56:41, Johan Hovold wrote:
> The current interconnect provider registration interface is inherently
> racy as nodes are not added until the after adding the provider. This
> can specifically cause racing DT lookups to fail.
> 
> Switch to using the new API where the provider is not registered until
> after it has been fully initialised.
> 
> Fixes: e6f0d6a30f73 ("interconnect: qcom: Add SM8550 interconnect provider driver")
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Any changes since v1 or is it just a resend? 

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
> -- 
> 2.39.2
> 
