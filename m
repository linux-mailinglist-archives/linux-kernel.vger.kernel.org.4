Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD77A71A0C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjFAOqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjFAOql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:46:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FBDE4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:46:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f60bc818d7so407083e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685630797; x=1688222797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xixYGYlwUyF0I+OFHzEUwOqoaLpveoc9s/Ml2gFPUxo=;
        b=E9eRYXWB3xis66zsjFFV8dJyHpyMHuT0sxbGkRwMFvzjD9c8msT/a+WkKW+Ya0BgPD
         2Bv5lOYiVRK8Ne0IBhg9KbbucirVYVdAghuBR5q2F0sTipJ8fxf2WwBrXnSLjc1qSkgq
         sOhzFiD7+FHM0WleSn50OazfrffFixdFkd+dxdo9tihJviTdWZw2Xr4p2PsJIUntz1fQ
         f7b3U4vENTQLeMyTl4RuS3pszKrCmbbQyugs5CsfvGW0Mu6yTuNFVrps6QMK891rEOES
         MFetSjGP2tYMEDZFCldn5pUL6qyy2IiCDsXhYRnQ8vxXMC4TM86klTLfIqdUwg5I+t8c
         Xzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685630797; x=1688222797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xixYGYlwUyF0I+OFHzEUwOqoaLpveoc9s/Ml2gFPUxo=;
        b=V6BY/v9WVcqvDLjlaKG6dV1l04HRsMAL2f+X/yylx3sWPOSpM7ug2ISBwWdwe9KbAD
         P72MtB29Ucjy2cEAxsV7Yo4O54qFMUeDlLzFao8MDFsGKfiF10dKdqhYYMTGXsA1ZBOt
         lTgLllzZfH6bLDXXakBo5vKp40ErIsGVoxJyqoRvhAlYIDNuGxYUBocDl+GNszHD7ywu
         RkJxg2gF8oCug/0TEV9fuWTttwBRsG6Vp9jmblYxFCmW+72/wx3MpETL49w93V5CJQ1n
         MqZ7uqOUpLpQ28zk0aWoNExyo0loDdWTE/TXg43T9yKJWmHEsKq7ZTnonwjt/YyOLudC
         A1MA==
X-Gm-Message-State: AC+VfDwIxV+0cMLsDsyzcF74P73T2TnFSw4KFUjnMeqR/MkoCjTQN6hK
        l8rBmVugFXrzaGWZA9O3hIqrGQ==
X-Google-Smtp-Source: ACHHUZ5nrobEjk3ms0pLbmU8FAAt0umdcwyVqfIoCrmIZ2iwdxX1OX5DuXFgxBiXnyeE7pRfeLidiQ==
X-Received: by 2002:ac2:44a2:0:b0:4f3:a08b:275e with SMTP id c2-20020ac244a2000000b004f3a08b275emr73653lfm.53.1685630797287;
        Thu, 01 Jun 2023 07:46:37 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x17-20020a19f611000000b004f1430ee142sm1107794lfe.17.2023.06.01.07.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 07:46:36 -0700 (PDT)
Message-ID: <1d29bc3f-12db-a676-56f8-b8c1a09063dc@linaro.org>
Date:   Thu, 1 Jun 2023 17:46:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 2/5] clk: qcom: Remove support to set CAL_L field in
 lucid evo pll configure
Content-Language: en-GB
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
References: <20230601143430.5595-1-quic_jkona@quicinc.com>
 <20230601143430.5595-3-quic_jkona@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230601143430.5595-3-quic_jkona@quicinc.com>
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

On 01/06/2023 17:34, Jagadeesh Kona wrote:
> For lucid evo and ole pll's the CAL_L, RINGOSC_CAL_L and L_VAL are
> part of the same register, hence update the l configuration value
> to include these fields across all the chipsets.
> 
> Since the l configuration value now includes both L and CAL_L fields,
> there is no need to explicitly set CAL_L field again in lucid evo pll
> configure, Hence remove support to explicity set CAL_L field for evo pll.
> 
> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
> Changes since V2:
>   - Squashed update L val and remove explicit cal_l configuration to single patch
>   - Updated L configuration for gpucc-sm8450 as well which was merged recently
> Changes since V1:
>   - Newly added.
> 
>   drivers/clk/qcom/camcc-sm8450.c  | 24 ++++++++++++++++--------
>   drivers/clk/qcom/clk-alpha-pll.c |  6 +-----
>   drivers/clk/qcom/dispcc-sm8450.c |  6 ++++--
>   drivers/clk/qcom/dispcc-sm8550.c |  6 ++++--
>   drivers/clk/qcom/gpucc-sa8775p.c |  6 ++++--
>   drivers/clk/qcom/gpucc-sm8450.c  |  6 ++++--
>   6 files changed, 33 insertions(+), 21 deletions(-)

I'd say, this is still not a correct solution from my point of view. A 
correct solution would be to follow the existing code and use constants 
for the constant values (of CAL_L, and RINGOSC_CAL_L).

> 
> diff --git a/drivers/clk/qcom/camcc-sm8450.c b/drivers/clk/qcom/camcc-sm8450.c
> index 51338a2884d2..6a5a08f88598 100644
> --- a/drivers/clk/qcom/camcc-sm8450.c
> +++ b/drivers/clk/qcom/camcc-sm8450.c
> @@ -57,7 +57,8 @@ static const struct pll_vco rivian_evo_vco[] = {
>   static const struct clk_parent_data pll_parent_data_tcxo = { .index = DT_BI_TCXO };
>   
>   static const struct alpha_pll_config cam_cc_pll0_config = {
> -	.l = 0x3e,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x0044003e,
>   	.alpha = 0x8000,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> @@ -128,7 +129,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll0_out_odd = {
>   };
>   
>   static const struct alpha_pll_config cam_cc_pll1_config = {
> -	.l = 0x25,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x00440025,
>   	.alpha = 0xeaaa,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> @@ -199,7 +201,8 @@ static struct clk_alpha_pll cam_cc_pll2 = {
>   };
>   
>   static const struct alpha_pll_config cam_cc_pll3_config = {
> -	.l = 0x2d,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x0044002d,
>   	.alpha = 0x0,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> @@ -247,7 +250,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll3_out_even = {
>   };
>   
>   static const struct alpha_pll_config cam_cc_pll4_config = {
> -	.l = 0x2d,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x0044002d,
>   	.alpha = 0x0,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> @@ -295,7 +299,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll4_out_even = {
>   };
>   
>   static const struct alpha_pll_config cam_cc_pll5_config = {
> -	.l = 0x2d,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x0044002d,
>   	.alpha = 0x0,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> @@ -343,7 +348,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll5_out_even = {
>   };
>   
>   static const struct alpha_pll_config cam_cc_pll6_config = {
> -	.l = 0x2d,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x0044002d,
>   	.alpha = 0x0,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> @@ -391,7 +397,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll6_out_even = {
>   };
>   
>   static const struct alpha_pll_config cam_cc_pll7_config = {
> -	.l = 0x2d,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x0044002d,
>   	.alpha = 0x0,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> @@ -439,7 +446,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll7_out_even = {
>   };
>   
>   static const struct alpha_pll_config cam_cc_pll8_config = {
> -	.l = 0x32,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x00440032,
>   	.alpha = 0x0,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index f81c7c561352..68a80395997b 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -270,7 +270,6 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>   #define LUCID_EVO_PCAL_NOT_DONE		BIT(8)
>   #define LUCID_EVO_ENABLE_VOTE_RUN       BIT(25)
>   #define LUCID_EVO_PLL_L_VAL_MASK        GENMASK(15, 0)
> -#define LUCID_EVO_PLL_CAL_L_VAL_SHIFT	16
>   
>   /* ZONDA PLL specific */
>   #define ZONDA_PLL_OUT_MASK	0xf
> @@ -2084,10 +2083,7 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_zonda_ops);
>   void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>   				 const struct alpha_pll_config *config)
>   {
> -	u32 lval = config->l;
> -
> -	lval |= TRION_PLL_CAL_VAL << LUCID_EVO_PLL_CAL_L_VAL_SHIFT;
> -	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), lval);
> +	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
>   	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
>   	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
>   	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll), config->config_ctl_hi_val);
> diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
> index adbfd30bfc96..293eae670a23 100644
> --- a/drivers/clk/qcom/dispcc-sm8450.c
> +++ b/drivers/clk/qcom/dispcc-sm8450.c
> @@ -76,7 +76,8 @@ static struct pll_vco lucid_evo_vco[] = {
>   };
>   
>   static const struct alpha_pll_config disp_cc_pll0_config = {
> -	.l = 0xD,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x0044000d,
>   	.alpha = 0x6492,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> @@ -103,7 +104,8 @@ static struct clk_alpha_pll disp_cc_pll0 = {
>   };
>   
>   static const struct alpha_pll_config disp_cc_pll1_config = {
> -	.l = 0x1F,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x0044001f,
>   	.alpha = 0x4000,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
> index 1e5a11081860..b0d4c623731d 100644
> --- a/drivers/clk/qcom/dispcc-sm8550.c
> +++ b/drivers/clk/qcom/dispcc-sm8550.c
> @@ -76,7 +76,8 @@ static struct pll_vco lucid_ole_vco[] = {
>   };
>   
>   static const struct alpha_pll_config disp_cc_pll0_config = {
> -	.l = 0xd,
> +	/* .l includes RINGOSC_CAL_L_VAL, CAL_L_VAL, L_VAL fields */
> +	.l = 0x4444000d,
>   	.alpha = 0x6492,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> @@ -103,7 +104,8 @@ static struct clk_alpha_pll disp_cc_pll0 = {
>   };
>   
>   static const struct alpha_pll_config disp_cc_pll1_config = {
> -	.l = 0x1f,
> +	/* .l includes RINGOSC_CAL_L_VAL, CAL_L_VAL, L_VAL fields */
> +	.l = 0x4444001f,
>   	.alpha = 0x4000,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> diff --git a/drivers/clk/qcom/gpucc-sa8775p.c b/drivers/clk/qcom/gpucc-sa8775p.c
> index 18d23be8d435..153bf6ecb795 100644
> --- a/drivers/clk/qcom/gpucc-sa8775p.c
> +++ b/drivers/clk/qcom/gpucc-sa8775p.c
> @@ -46,7 +46,8 @@ static const struct pll_vco lucid_evo_vco[] = {
>   
>   /* 810MHz configuration */
>   static struct alpha_pll_config gpu_cc_pll0_config = {
> -	.l = 0x2a,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x0044002a,
>   	.alpha = 0x3000,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> @@ -72,7 +73,8 @@ static struct clk_alpha_pll gpu_cc_pll0 = {
>   
>   /* 1000MHz configuration */
>   static struct alpha_pll_config gpu_cc_pll1_config = {
> -	.l = 0x34,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x00440034,
>   	.alpha = 0x1555,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> diff --git a/drivers/clk/qcom/gpucc-sm8450.c b/drivers/clk/qcom/gpucc-sm8450.c
> index 16c0381b3087..dddfda880202 100644
> --- a/drivers/clk/qcom/gpucc-sm8450.c
> +++ b/drivers/clk/qcom/gpucc-sm8450.c
> @@ -40,7 +40,8 @@ static struct pll_vco lucid_evo_vco[] = {
>   };
>   
>   static struct alpha_pll_config gpu_cc_pll0_config = {
> -	.l = 0x1d,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x0044001d,
>   	.alpha = 0xb000,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,
> @@ -67,7 +68,8 @@ static struct clk_alpha_pll gpu_cc_pll0 = {
>   };
>   
>   static struct alpha_pll_config gpu_cc_pll1_config = {
> -	.l = 0x34,
> +	/* .l includes CAL_L_VAL, L_VAL fields */
> +	.l = 0x00440034,
>   	.alpha = 0x1555,
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00182261,

-- 
With best wishes
Dmitry

