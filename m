Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386916FAD9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbjEHLgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbjEHLf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:35:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BA93F55C
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:35:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f139de8cefso27202740e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683545665; x=1686137665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZfuzF/2cXKb6ZWaaADwHtTw9vIHYjU3yNqc3zM3W28=;
        b=qmPvtJTGeh2NaBsW3WooleKq6fySQ2LDm61AhnwVyfSafA45grv1VVCmbJlMF30JAd
         UYgEMl9mvnLjZeKGfH/TbDqCin6LPCs3izHM6iRBt00C+nk6wELkNJbbX7DuPu4lmRcG
         r0RGq7r4OeMICQ6HLkUw47AnWK1JgXxywFaIIdw8Q9ZEMVLV8cJaRuxQ9CSVqak57YKh
         +l6I4U526lJaZ7+MfAsxcdpaXYOD1hoI7ca24ajqCTBSefwDyx3GX+g0hBeO00zNL9qk
         t9m3ADFd+gubkRQLqoanl3dPCv4T/sakEMZxfYNOPlauQVkmaRRzlBHWeOiRS7cp1jiW
         XOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545665; x=1686137665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZfuzF/2cXKb6ZWaaADwHtTw9vIHYjU3yNqc3zM3W28=;
        b=D7qHyZmc7QTbrKIr2im7gIMnRVQyw1s9VNFotwgDn6o48wcDiGLGz+aTZ//naqZDNk
         nL/2L2NZhr+f2P1kmJ2mbxiyScpvqwnSs+w/Bx/76T0UC+RANv4zX5Gmv41zQTpNEHJF
         Rp9g04wxrhgNidgPUf+BuX5ZmMEZ4gWh4H5J5JU73tLtaVXBovfi6R/cpiGU80BaNOSh
         uFRzbu2n2stsSXide1GOVCNn1FWUjYzFXi+nPVU2mA33bC801B7fKSZ8oSvZyiJlJ2Ln
         VwfZ4f4YWVtSXmcd4mZMYFeqMtp+vPrw9NUW4ZQMKpwat21SbbZDe5bklRSZGrD+c4w2
         +LGQ==
X-Gm-Message-State: AC+VfDw7CE/xLowZSz2wVhaEUK2cHaR8UrXGRRPo4pFJjGPJQz7Ne25j
        +SXXSkUZ4XYlbjq+9qO7jpJ3Yg==
X-Google-Smtp-Source: ACHHUZ5qowE934plKCZ3QqmD8mz68YPf/aekEpyKCyfLJoZfaWDXz5IGOtCMEIG5Fv2ym4050eaSBA==
X-Received: by 2002:a05:6512:3092:b0:4ef:ee59:d28d with SMTP id z18-20020a056512309200b004efee59d28dmr3157340lfd.7.1683545664698;
        Mon, 08 May 2023 04:34:24 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id e18-20020a056512091200b004ef92c6e645sm1258493lft.263.2023.05.08.04.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 04:34:24 -0700 (PDT)
Message-ID: <c9d319a6-36c6-b58c-70ce-65578fd364c3@linaro.org>
Date:   Mon, 8 May 2023 14:34:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/6] soc: qcom: ocmem: make iface clock optional
Content-Language: en-GB
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
 <20230506-msm8226-ocmem-v1-3-3e24e2724f01@z3ntu.xyz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230506-msm8226-ocmem-v1-3-3e24e2724f01@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2023 12:12, Luca Weiss wrote:
> Some platforms such as msm8226 do not have an iface clk. Since clk_bulk
> APIs don't offer to a way to treat some clocks as optional simply add
> core_clk and iface_clk members to our drvdata.

What about using devm_clk_bulk_get_optional()? I think it would be 
simpler this way.

> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   drivers/soc/qcom/ocmem.c | 42 ++++++++++++++++++++++++------------------
>   1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
> index a11a955a1327..6235065d3bc9 100644
> --- a/drivers/soc/qcom/ocmem.c
> +++ b/drivers/soc/qcom/ocmem.c
> @@ -54,6 +54,8 @@ struct ocmem {
>   	const struct ocmem_config *config;
>   	struct resource *memory;
>   	void __iomem *mmio;
> +	struct clk *core_clk;
> +	struct clk *iface_clk;
>   	unsigned int num_ports;
>   	unsigned int num_macros;
>   	bool interleaved;
> @@ -91,16 +93,6 @@ struct ocmem {
>   #define OCMEM_PSGSC_CTL_MACRO2_MODE(val)	FIELD_PREP(0x00000700, (val))
>   #define OCMEM_PSGSC_CTL_MACRO3_MODE(val)	FIELD_PREP(0x00007000, (val))
>   
> -#define OCMEM_CLK_CORE_IDX			0
> -static struct clk_bulk_data ocmem_clks[] = {
> -	{
> -		.id = "core",
> -	},
> -	{
> -		.id = "iface",
> -	},
> -};
> -
>   static inline void ocmem_write(struct ocmem *ocmem, u32 reg, u32 data)
>   {
>   	writel(data, ocmem->mmio + reg);
> @@ -316,9 +308,15 @@ static int ocmem_dev_probe(struct platform_device *pdev)
>   	ocmem->dev = dev;
>   	ocmem->config = device_get_match_data(dev);
>   
> -	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(ocmem_clks), ocmem_clks);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Unable to get clocks\n");
> +	ocmem->core_clk = devm_clk_get(dev, "core");
> +	if (IS_ERR(ocmem->core_clk))
> +		return dev_err_probe(dev, PTR_ERR(ocmem->core_clk),
> +				     "Unable to get core clock\n");
> +
> +	ocmem->iface_clk = devm_clk_get_optional(dev, "iface");
> +	if (IS_ERR(ocmem->iface_clk))
> +		return dev_err_probe(dev, PTR_ERR(ocmem->iface_clk),
> +				     "Unable to get iface clock\n");
>   
>   	ocmem->mmio = devm_platform_ioremap_resource_byname(pdev, "ctrl");
>   	if (IS_ERR(ocmem->mmio))
> @@ -333,11 +331,15 @@ static int ocmem_dev_probe(struct platform_device *pdev)
>   	}
>   
>   	/* The core clock is synchronous with graphics */
> -	WARN_ON(clk_set_rate(ocmem_clks[OCMEM_CLK_CORE_IDX].clk, 1000) < 0);
> +	WARN_ON(clk_set_rate(ocmem->core_clk, 1000) < 0);
> +
> +	ret = clk_prepare_enable(ocmem->core_clk);
> +	if (ret)
> +		return dev_err_probe(ocmem->dev, ret, "Failed to enable core clock\n");
>   
> -	ret = clk_bulk_prepare_enable(ARRAY_SIZE(ocmem_clks), ocmem_clks);
> +	ret = clk_prepare_enable(ocmem->iface_clk);
>   	if (ret)
> -		return dev_err_probe(ocmem->dev, ret, "Failed to enable clocks\n");
> +		return dev_err_probe(ocmem->dev, ret, "Failed to enable iface clock\n");
>   
>   	if (qcom_scm_restore_sec_cfg_available()) {
>   		dev_dbg(dev, "configuring scm\n");
> @@ -396,13 +398,17 @@ static int ocmem_dev_probe(struct platform_device *pdev)
>   	return 0;
>   
>   err_clk_disable:
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(ocmem_clks), ocmem_clks);
> +	clk_disable_unprepare(ocmem->core_clk);
> +	clk_disable_unprepare(ocmem->iface_clk);
>   	return ret;
>   }
>   
>   static int ocmem_dev_remove(struct platform_device *pdev)
>   {
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(ocmem_clks), ocmem_clks);
> +	struct ocmem *ocmem = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(ocmem->core_clk);
> +	clk_disable_unprepare(ocmem->iface_clk);
>   
>   	return 0;
>   }
> 

-- 
With best wishes
Dmitry

