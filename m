Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D597123BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbjEZJej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbjEZJeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:34:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517241B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:33:38 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f4bd608cf4so552547e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685093603; x=1687685603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/oBlibUgPrZBjTfRBirdiuXhFmBs+58msrliDKw+mY=;
        b=KoGqzYwcPZDy0P7xRldOcnXupUtJ+OB7H0ZpZPKhb1KtMCJj3127Toriic3RgG79sv
         1FN+feWvMCT5HWrA7sgpFvh4jRJX2kk/pkx3cN8Sg4fRKrzrRZMwz5MdAg4nIcOj+5GF
         /VGmQUIIqNjUPtgs8j+9TCUzRo6fA53EtKqzb53WSvI9E2Ut8QNd9IAlhZVZNVVww/cF
         a5Dq5rbMa9f9g+0gVz8cTO2HusCyCJ1+XtHsTty+Ua7uhoGr/Z1tjUUEkJNf50Oj2Zgy
         PEcPe3A3DC5MRNMLGMBqrN8ogvDJxJYHtD1uTF0DsfMARexZ7wsleU88v54cf8wKhJg1
         nc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685093603; x=1687685603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/oBlibUgPrZBjTfRBirdiuXhFmBs+58msrliDKw+mY=;
        b=IFU7eV8n4gBlD6CKWIqA2XzfZ4JsaCejCVQ3G1Is2LxxH7CpYUZCB0U6rBGDIwjYG3
         8gej+zSRSfM2Wo9YLp98GpFOuHKrl6DzwZRfcG23AEjroOTyRU2VlH/CYCiZfWqifciV
         Az8TiVApy+XXmSL/Jft0oNJcUjGtIULOol6s7HIGsIYOteLSmL2V37NZmx/E/8CfFJrW
         DnOJytE2HJFfisvfAKpRQwlDzkqENlWGynAsOuLY29icSwjiGOVW0YFaCoOFd6bwh8BU
         snBlVKdxUjQI5OeAGVUiyVEtU84pYnKz/TCnjMoII4vCQk1YUOGugIqxtCnGT+fCJqpX
         YGmQ==
X-Gm-Message-State: AC+VfDzl6erV/RvRf5N7mwIBupV40LnmTNmYD+tdwwFbMGmTyydA3HKT
        kmCiN3ZwZEau+oHR4UyLmycpPw==
X-Google-Smtp-Source: ACHHUZ5IMHjQOJzbUB1xcWxYldyP1P7V6EO/+PSAu1YT7XY3jrPux0ZQoExBpf+yW22mPCrPp614EA==
X-Received: by 2002:a19:f80c:0:b0:4f4:cda3:8c99 with SMTP id a12-20020a19f80c000000b004f4cda38c99mr441265lff.42.1685093603377;
        Fri, 26 May 2023 02:33:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id i20-20020ac25234000000b004efe73ee01fsm535345lfl.306.2023.05.26.02.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 02:33:22 -0700 (PDT)
Message-ID: <6e1d098d-03b9-aa63-a0bf-6cf748a0db0d@linaro.org>
Date:   Fri, 26 May 2023 11:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 3/6] clk: qcom: clk-alpha-pll: Remove explicit CAL_L
 configuration for EVO PLL
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230525172142.9039-1-quic_jkona@quicinc.com>
 <20230525172142.9039-4-quic_jkona@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230525172142.9039-4-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.05.2023 19:21, Jagadeesh Kona wrote:
> In lucid evo pll, the CAL_L field is part of L value register itself, and
> the l value configuration passed from clock controller driver includes
> CAL_L and L values as well. Hence remove explicit configuration of CAL_L
> for evo pll.
> 
> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
Oh that isn't obvious at first sight, nice find!

I'd suggest a different solution though:

#define LUCID_EVO_PLL_L_LVAL	GENMASK(..
#define LUCID_EVO_PLL_L_CAL_L	GENMASK(..

lval = FIELD_PREP(LUCID_EVO_PLL_L_LVAL, config->l) |
       FIELD_PREP(LUCID_EVO_PLL_L_CAL_L, config->cal_l);

This would make the separation between the two parts more explicit

however

config->l would then represent the L value and not the end value
written to the L register

Up to you, whichever you find saner!

Konrad

> Changes since V1:
>  - Newly added.
> 
>  drivers/clk/qcom/clk-alpha-pll.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index f81c7c561352..68a80395997b 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -270,7 +270,6 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>  #define LUCID_EVO_PCAL_NOT_DONE		BIT(8)
>  #define LUCID_EVO_ENABLE_VOTE_RUN       BIT(25)
>  #define LUCID_EVO_PLL_L_VAL_MASK        GENMASK(15, 0)
> -#define LUCID_EVO_PLL_CAL_L_VAL_SHIFT	16
>  
>  /* ZONDA PLL specific */
>  #define ZONDA_PLL_OUT_MASK	0xf
> @@ -2084,10 +2083,7 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_zonda_ops);
>  void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>  				 const struct alpha_pll_config *config)
>  {
> -	u32 lval = config->l;
> -
> -	lval |= TRION_PLL_CAL_VAL << LUCID_EVO_PLL_CAL_L_VAL_SHIFT;
> -	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), lval);
> +	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
>  	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
>  	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
>  	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll), config->config_ctl_hi_val);
