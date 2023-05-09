Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C9E6FCF0B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjEIUGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjEIUGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:06:41 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E3A26B3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 13:06:39 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ad9f2926adso15879011fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683662798; x=1686254798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJ9jtHBo5TjzGlydvjsWKFn9i61qE/XTmR3LKTATkiM=;
        b=y+/hpJFrUaEohzJzbVB5FdcU9P1W71bN1cj8VPOfmyhYAp5d3/M03P9RK6NviqlqqT
         m/OufIh1Clj9gAKqFJtfMNsMN/vXOXIXVLz9p5QO1BcqQPqL9zVcbxBm/8n7nKKvG3FR
         VoPBoRKW3nXIu/1mH+rf022qAQrzlY4DEz6NNp8/x03XXWMnSb28ILfElb32aA2ENIT6
         2MBnbOEmruS5ZzQ8RdU03PpfhvXGyCiV77QZWchmnKP5dl7mhh4FXFh6OKyJCfXB1Gvc
         IfO7fo4Gv4Sf6Vzc8OKjerd/tX9gS88wVP1SCfNYLdcdV/qUgYMa6MUI6TPDcGLgDtCx
         sPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683662798; x=1686254798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJ9jtHBo5TjzGlydvjsWKFn9i61qE/XTmR3LKTATkiM=;
        b=JrFiOeucDvr5ANgjHWZa4W45jRyKwdRylORLRz9A3KO465PK1PNyZzhzHitQkZCN1U
         pCyu7OufIu4RYzLrOAW1I5Q4lIRqiQnDn238yBPkLRvbs9CnGQL3JPgeQceywTv9OG1f
         HP/6CmzAZtc2e0ylF3dDWJgwbWdaf806Anb03pcmHgMX6UKfSu3q5JY3SC23O5yJocgU
         932zp3qsBue6rnayp+NA7OUNGqmAulqbNO35IKr/qHMaGwmAsOA6XcseVqX5C+EuqPwA
         eb/5Y5qe+U9L6DrwGSOXnAyP3emah0JIzSsCNMZlLN9UvnY7Mmjwu6e+D2vT+sw8vfa8
         AtQg==
X-Gm-Message-State: AC+VfDw1LdRUGW5XYViseerQEeoerc9uHyFOwrI0+cf149/TBfCOT6gi
        b0ntFYicSamwod/5tRabUT+nYg==
X-Google-Smtp-Source: ACHHUZ5W4mKArgYFVe9lrMYtQfrg0Awr3PV3bhXgMJXSzDUzCORFVnZPXJyU5xogGHWZ+TxeWDCZxQ==
X-Received: by 2002:a2e:9101:0:b0:299:ac61:4e78 with SMTP id m1-20020a2e9101000000b00299ac614e78mr1345994ljg.10.1683662797729;
        Tue, 09 May 2023 13:06:37 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id y22-20020a2e9d56000000b002ac71095b61sm1642177ljj.64.2023.05.09.13.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 13:06:37 -0700 (PDT)
Message-ID: <019999fd-3c86-8c85-76c7-8d0206e60f4d@linaro.org>
Date:   Tue, 9 May 2023 22:06:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/4] clk: qcom: clk-alpha-pll: Add support for lucid ole
 pll ops
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230509161218.11979-1-quic_jkona@quicinc.com>
 <20230509161218.11979-2-quic_jkona@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230509161218.11979-2-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.05.2023 18:12, Jagadeesh Kona wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Add support for lucid ole pll ops to configure and control the
> lucid ole pll. The lucid ole pll has an additional test control
> register which is required to be programmed, add support to
> program the same.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
Isn't this commit "write to PLL_TEST_CTL_U2 on LUCID_EVO" instead?

Meaninglessly duplicating ops does not seem useful.

Konrad
>  drivers/clk/qcom/clk-alpha-pll.c | 2 ++
>  drivers/clk/qcom/clk-alpha-pll.h | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index b9f6535a7ba7..f81c7c561352 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -55,6 +55,7 @@
>  #define PLL_TEST_CTL(p)		((p)->offset + (p)->regs[PLL_OFF_TEST_CTL])
>  #define PLL_TEST_CTL_U(p)	((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U])
>  #define PLL_TEST_CTL_U1(p)     ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U1])
> +#define PLL_TEST_CTL_U2(p)     ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U2])
>  #define PLL_STATUS(p)		((p)->offset + (p)->regs[PLL_OFF_STATUS])
>  #define PLL_OPMODE(p)		((p)->offset + (p)->regs[PLL_OFF_OPMODE])
>  #define PLL_FRAC(p)		((p)->offset + (p)->regs[PLL_OFF_FRAC])
> @@ -2096,6 +2097,7 @@ void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regma
>  	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
>  	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
>  	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll), config->test_ctl_hi1_val);
> +	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U2(pll), config->test_ctl_hi2_val);
>  
>  	/* Disable PLL output */
>  	regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
> index d07b17186b90..4d9b6d5b7062 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.h
> +++ b/drivers/clk/qcom/clk-alpha-pll.h
> @@ -125,6 +125,7 @@ struct alpha_pll_config {
>  	u32 test_ctl_val;
>  	u32 test_ctl_hi_val;
>  	u32 test_ctl_hi1_val;
> +	u32 test_ctl_hi2_val;
>  	u32 main_output_mask;
>  	u32 aux_output_mask;
>  	u32 aux2_output_mask;
> @@ -171,6 +172,7 @@ extern const struct clk_ops clk_alpha_pll_zonda_ops;
>  #define clk_alpha_pll_postdiv_zonda_ops clk_alpha_pll_postdiv_fabia_ops
>  
>  extern const struct clk_ops clk_alpha_pll_lucid_evo_ops;
> +#define clk_alpha_pll_lucid_ole_ops clk_alpha_pll_lucid_evo_ops
>  extern const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops;
>  #define clk_alpha_pll_reset_lucid_ole_ops clk_alpha_pll_reset_lucid_evo_ops
>  extern const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops;
> @@ -196,6 +198,8 @@ void clk_zonda_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>  			     const struct alpha_pll_config *config);
>  void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>  				 const struct alpha_pll_config *config);
> +#define clk_lucid_ole_pll_configure(pll, regmap, config) \
> +			clk_lucid_evo_pll_configure(pll, regmap, config)
>  void clk_rivian_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>  				  const struct alpha_pll_config *config);
>  void clk_stromer_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
