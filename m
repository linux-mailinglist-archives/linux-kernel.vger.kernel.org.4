Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1CA6FA12C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjEHHiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjEHHiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:38:01 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19904EF4
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:37:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ac770a99e2so46157041fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 00:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683531477; x=1686123477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igOidM55jTLRiFTsSNNJdbhAlQx6xHp4xjUBma9E7bc=;
        b=RxJ0Mr/7ZCEaj/z1YJAAkQJlLJKnLkibtNK/TP6P4+vDgz6bsC0JB3+ALVM9/NQD19
         PtLQX+BAxaXadicFoOx//IHBK5WAHhMQ7xDCP+wsGNWb+dlNVvt46rRyRSCWFYUp9Qu2
         oQbYN232aa+GokrPYPjiKgNCDLtX23AQaturns9s7pIgHDuW8K2yDNwTrixAjrr+k+qE
         gwXQwoHkT/GtRsGDGp1BBoz5EarvQN10gXkZ9ed3O9mcSELIBAxr+Z6gmeoq22ss3uQm
         0SbfrDTiHEQO0apj00Yn2YFxhuuv0BKfi1jXwRtLHtMtWTvq6P+gGegFJnf35s5fwy3k
         XROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683531477; x=1686123477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igOidM55jTLRiFTsSNNJdbhAlQx6xHp4xjUBma9E7bc=;
        b=Ftnht3AXAFP/mSEKC4sQogB1z6HqtBZQDfXe9PK5ZP0PHVgPsPqUQ1EQ86KW0LsupZ
         newmR2i8OZ1cRzZXBeWRhkdwhqlisoMU4BOYBWJSSE4p/9vOHSx/sAZhCgU+W1mfAWeb
         Hr0FMTWWsWVIpq1YkAT1LA7Hrfx++lVN8PunWppMsfODq766OGPDlmAnF9Le4VtKvk7k
         5fFBYbbVJaE9LaReJ/3BzPjdmfrY4H0V9CTX4iL0l5koXj+7WpCYFG1eMvr84DAHySrs
         Ts0l3K0g9vYfhmlNrHqg6jm+Pf3ktRdZLL76lemyLioML3xEgfGeUMIuswZrcqh4LfhD
         HKMQ==
X-Gm-Message-State: AC+VfDy7Dw4yAY2Q3RjnH3TKzwoXPwZu8wJ7xIN62L3+lleJ1thy0ejC
        Zhctkr56E/8wzdDmQMCo8TIDUQ==
X-Google-Smtp-Source: ACHHUZ6XMHCTOPTRkqco61kyNi4aDDhkl+zXb5UKpmV5EdMdwy09a+NPnCeGTi4N8zBc6qbuQtpumQ==
X-Received: by 2002:a2e:8eca:0:b0:2ac:85d7:342b with SMTP id e10-20020a2e8eca000000b002ac85d7342bmr2582044ljl.29.1683531477081;
        Mon, 08 May 2023 00:37:57 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id l17-20020a05651c10d100b002ab0c9fab23sm1089550ljn.79.2023.05.08.00.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 00:37:56 -0700 (PDT)
Message-ID: <4e9275be-c584-8656-2edb-447ab5546e5c@linaro.org>
Date:   Mon, 8 May 2023 09:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/6] soc: qcom: ocmem: make iface clock optional
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
 <20230506-msm8226-ocmem-v1-3-3e24e2724f01@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230506-msm8226-ocmem-v1-3-3e24e2724f01@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.05.2023 11:12, Luca Weiss wrote:
> Some platforms such as msm8226 do not have an iface clk. Since clk_bulk
> APIs don't offer to a way to treat some clocks as optional simply add
> core_clk and iface_clk members to our drvdata.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
I think I don't see anything wrong in here!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/ocmem.c | 42 ++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
> index a11a955a1327..6235065d3bc9 100644
> --- a/drivers/soc/qcom/ocmem.c
> +++ b/drivers/soc/qcom/ocmem.c
> @@ -54,6 +54,8 @@ struct ocmem {
>  	const struct ocmem_config *config;
>  	struct resource *memory;
>  	void __iomem *mmio;
> +	struct clk *core_clk;
> +	struct clk *iface_clk;
>  	unsigned int num_ports;
>  	unsigned int num_macros;
>  	bool interleaved;
> @@ -91,16 +93,6 @@ struct ocmem {
>  #define OCMEM_PSGSC_CTL_MACRO2_MODE(val)	FIELD_PREP(0x00000700, (val))
>  #define OCMEM_PSGSC_CTL_MACRO3_MODE(val)	FIELD_PREP(0x00007000, (val))
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
>  static inline void ocmem_write(struct ocmem *ocmem, u32 reg, u32 data)
>  {
>  	writel(data, ocmem->mmio + reg);
> @@ -316,9 +308,15 @@ static int ocmem_dev_probe(struct platform_device *pdev)
>  	ocmem->dev = dev;
>  	ocmem->config = device_get_match_data(dev);
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
>  	ocmem->mmio = devm_platform_ioremap_resource_byname(pdev, "ctrl");
>  	if (IS_ERR(ocmem->mmio))
> @@ -333,11 +331,15 @@ static int ocmem_dev_probe(struct platform_device *pdev)
>  	}
>  
>  	/* The core clock is synchronous with graphics */
> -	WARN_ON(clk_set_rate(ocmem_clks[OCMEM_CLK_CORE_IDX].clk, 1000) < 0);
> +	WARN_ON(clk_set_rate(ocmem->core_clk, 1000) < 0);
> +
> +	ret = clk_prepare_enable(ocmem->core_clk);
> +	if (ret)
> +		return dev_err_probe(ocmem->dev, ret, "Failed to enable core clock\n");
>  
> -	ret = clk_bulk_prepare_enable(ARRAY_SIZE(ocmem_clks), ocmem_clks);
> +	ret = clk_prepare_enable(ocmem->iface_clk);
>  	if (ret)
> -		return dev_err_probe(ocmem->dev, ret, "Failed to enable clocks\n");
> +		return dev_err_probe(ocmem->dev, ret, "Failed to enable iface clock\n");
>  
>  	if (qcom_scm_restore_sec_cfg_available()) {
>  		dev_dbg(dev, "configuring scm\n");
> @@ -396,13 +398,17 @@ static int ocmem_dev_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_clk_disable:
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(ocmem_clks), ocmem_clks);
> +	clk_disable_unprepare(ocmem->core_clk);
> +	clk_disable_unprepare(ocmem->iface_clk);
>  	return ret;
>  }
>  
>  static int ocmem_dev_remove(struct platform_device *pdev)
>  {
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(ocmem_clks), ocmem_clks);
> +	struct ocmem *ocmem = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(ocmem->core_clk);
> +	clk_disable_unprepare(ocmem->iface_clk);
>  
>  	return 0;
>  }
> 
