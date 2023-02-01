Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505E9686419
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjBAKVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjBAKVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:21:37 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA0F5EF9F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:21:21 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a3so10107533wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=miY8Nl9pasl3CNdADib5ACTcN+W/hw5ia5NnpxR1DOs=;
        b=uLgSYR59FG0YvqcaWR3edxkJi/+BwDtZfmZg22UEfWNcGd1MdmeJhJAkVV4YnNlPcU
         dZrytTLPSl2JkwEoxnsKx0G1I6uHo+ihZ7/NxVZWNTPw73q6oidpJv6B3pGpwDIbnt6T
         NDe49O7o04eqNDOJu1gFgSK2bR0/QOlfty5Nb1sLnvE6siz4fs364oke8/+aN0jUdEDc
         OPIKwf6JiIHm6caFfnbu3ec7JwJZ6d7HGs1a4hZWkWs/9PzzD18quoRPbTI7dNZyhozC
         JoCFilT7p/NBPjY6ichMj7h4TYSnOSADXvfiROZxAaHDGWqLBw451H3ffWWHET+Wq9ao
         /ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miY8Nl9pasl3CNdADib5ACTcN+W/hw5ia5NnpxR1DOs=;
        b=0SChDiqiYfH9Etbmq4OZCokv+nb9nXvOxRZJX9g6FEwAeKLmod5KQrfww7ZQoSVb3t
         O+HGjvX0OCYRADKxCUmC3NzoEgywNTwX8H8ba4ec690Cs4lKDOqtpeKNJ6d/WTQqVbQ8
         g2vWpxJDK53CxhDOhll8j7QxK4Er9oB8/+FhRWhecbfIT3aBHfNBHW5gQgQqGVw3jaeR
         LrbRFM//5CHx7N/UmWvWm4N0knBqSz7Ey9uXb2/dnJq1bynsGAy/ikSywsY135JZJT8U
         Akcwe21VQuhYgZhofZHcE/UapYzMuhw5/SPCgihgbSkHUUSLieDUbXgUXkWobrEufB+6
         e+CQ==
X-Gm-Message-State: AO0yUKXqqjSXoKuHAp5bBLZDziiu+1Jh7PbLHEoKiTgUUpm0X1BLdWSG
        8SdEXn2qghdr+/wLV1Xp5LEeKQ==
X-Google-Smtp-Source: AK7set/IC4WGJsen1OnuWzNLHYicjdoUj049JRvIbLxwbusnIcgd9UWJMJPf4DuYsVOVsCI4Hx7xzw==
X-Received: by 2002:a05:6000:143:b0:2bf:e7c4:898a with SMTP id r3-20020a056000014300b002bfe7c4898amr5305107wrx.51.1675246859017;
        Wed, 01 Feb 2023 02:20:59 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6b47000000b002bbed1388a5sm17076852wrw.15.2023.02.01.02.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 02:20:58 -0800 (PST)
Date:   Wed, 1 Feb 2023 12:20:56 +0200
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
Subject: Re: [PATCH 13/23] interconnect: qcom: sm8550: fix registration race
Message-ID: <Y9o9CGeJ4W2Pm5fG@linaro.org>
References: <20230201101559.15529-1-johan+linaro@kernel.org>
 <20230201101559.15529-14-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201101559.15529-14-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-01 11:15:49, Johan Hovold wrote:
> The current interconnect provider registration interface is inherently
> racy as nodes are not added until the after adding the provider. This
> can specifically cause racing DT lookups to fail.
> 
> Switch to using the new API where the provider is not registered until
> after it has been fully initialised.

Sounds good to me.

> 
> Fixes: e6f0d6a30f73 ("interconnect: qcom: Add SM8550 interconnect provider driver")
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
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
> 2.39.1
> 
