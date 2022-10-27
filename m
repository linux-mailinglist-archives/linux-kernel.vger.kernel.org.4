Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A426260F7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiJ0Mmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiJ0Mmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:42:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BCB3AB10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:42:36 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z24so2294657ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3Nc72b690gEq9FOu83an5jQGVVWDfDu6QhQ6g28Bd4=;
        b=YIevQDdkUH92m6ggfbFjUI64CpKuLAFwlOWzcaYHGh0VVMllHDXXMZyDK1IUS9SPc8
         zzemPdeA1rMSr4hr7aVxpbbh/RbV+nW8jySItcpWrKRK7/MQzhDT6lcuDIjc5SERIpw6
         7ML+exxhMjrPr2vNyfWJKEd4uftJQ0re3zxC3xz5tu2HOx1Gn9MnILv5MGfiFs8sYYle
         gMEwZnkDU61el0zrC5QYWB/9plxm5F+g82/Bej/ABnxi75mLseToZOutZdAgAxY3NnCV
         yI4d4k7UxLu1ou4K0LPmillYJK6KQUm5pkyqcXiHLXZL5g8JEUEy+JMXst7yL5lB8XNx
         RaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3Nc72b690gEq9FOu83an5jQGVVWDfDu6QhQ6g28Bd4=;
        b=amvS2jDYLy5ZMsSV6SIEZZBs1M2KR/qzhYjKWlpS5S0Om5xfEFHXBIWR0XqvHDQjLM
         7+SaNyxobCA5AIcutjviRX+KuS2x2h1ChK+clTOpx28YOo3xfOPIePFUVyXior1ZmIAl
         YMW841FWBlwikljp+xdkYYz88u5x9Nt2O8Vk57xXle2pfjQxMBThLLeAKTSf1SvVCsid
         ZHrivVJbazKe48740k0WAIR16HGn9KMtnVH2+SHBLIit9SlDSPBefLkOThT6JTDj847L
         pKoJvXocEQ3qFbsv0ihjPpkc+E9/9Cid43k1esxjirGPv8xUi2rFKEH+nUfS2nWt5kmI
         12Pg==
X-Gm-Message-State: ACrzQf1/waWn8YuMGwgXEC8C0oriTmBeGqqbQD8v1j8WRpjmNkU0UsTR
        Wu/ZAkUz9sUV6NNeU7hhzzuPmw==
X-Google-Smtp-Source: AMsMyM70UthF0zhGlnOpSzC2royUK9/b1nvq2imdjfg07dDz5E+Jw4jlKPOynqljuxkrJfi/nGcelQ==
X-Received: by 2002:a2e:a44a:0:b0:26e:177:d166 with SMTP id v10-20020a2ea44a000000b0026e0177d166mr18373949ljn.520.1666874554427;
        Thu, 27 Oct 2022 05:42:34 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id r6-20020a2e8e26000000b0026acfbbcb7esm221355ljk.12.2022.10.27.05.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 05:42:34 -0700 (PDT)
Message-ID: <e32be4c0-56ea-6999-92e6-3b51792a5255@linaro.org>
Date:   Thu, 27 Oct 2022 15:42:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v1 4/5] clk: qcom: dispcc-sm8250: Add missing EDP clocks
 for sm8350
Content-Language: en-GB
To:     Robert Foss <robert.foss@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>
References: <20221027123432.1818530-1-robert.foss@linaro.org>
 <20221027123432.1818530-4-robert.foss@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221027123432.1818530-4-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 15:34, Robert Foss wrote:
> SM8350 supports embedded displayport, but the clocks for this
> were previously not enabled.

I'd say 'not accounted for' instead. Bjorn has added eDP clocks, but 
they were following the 8150 (no div_clk_src) and the offsets were not 
updated.

> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>   drivers/clk/qcom/dispcc-sm8250.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
> index a7606580cf22..d2aaa44ed3d4 100644
> --- a/drivers/clk/qcom/dispcc-sm8250.c
> +++ b/drivers/clk/qcom/dispcc-sm8250.c
> @@ -462,6 +462,20 @@ static struct clk_branch disp_cc_mdss_edp_link_clk = {
>   	},
>   };
>   
> +static struct clk_regmap_div disp_cc_mdss_edp_link_div_clk_src = {
> +	.reg = 0x2288,
> +	.shift = 0,
> +	.width = 2,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "disp_cc_mdss_edp_link_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&disp_cc_mdss_edp_link_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
>   static struct clk_branch disp_cc_mdss_edp_link_intf_clk = {
>   	.halt_reg = 0x2074,
>   	.halt_check = BRANCH_HALT,
> @@ -471,7 +485,7 @@ static struct clk_branch disp_cc_mdss_edp_link_intf_clk = {
>   		.hw.init = &(struct clk_init_data){
>   			.name = "disp_cc_mdss_edp_link_intf_clk",
>   			.parent_hws = (const struct clk_hw*[]){
> -				&disp_cc_mdss_edp_link_clk_src.clkr.hw,
> +				&disp_cc_mdss_edp_link_div_clk_src.clkr.hw,
>   			},
>   			.num_parents = 1,
>   			.flags = CLK_GET_RATE_NOCACHE,
> @@ -1175,6 +1189,7 @@ static struct clk_regmap *disp_cc_sm8250_clocks[] = {
>   	[DISP_CC_MDSS_EDP_GTC_CLK_SRC] = &disp_cc_mdss_edp_gtc_clk_src.clkr,
>   	[DISP_CC_MDSS_EDP_LINK_CLK] = &disp_cc_mdss_edp_link_clk.clkr,
>   	[DISP_CC_MDSS_EDP_LINK_CLK_SRC] = &disp_cc_mdss_edp_link_clk_src.clkr,
> +	[DISP_CC_MDSS_EDP_LINK_DIV_CLK_SRC] = &disp_cc_mdss_edp_link_div_clk_src.clkr,
>   	[DISP_CC_MDSS_EDP_LINK_INTF_CLK] = &disp_cc_mdss_edp_link_intf_clk.clkr,
>   	[DISP_CC_MDSS_EDP_PIXEL_CLK] = &disp_cc_mdss_edp_pixel_clk.clkr,
>   	[DISP_CC_MDSS_EDP_PIXEL_CLK_SRC] = &disp_cc_mdss_edp_pixel_clk_src.clkr,
> @@ -1285,7 +1300,11 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
>   			&disp_cc_mdss_dp_pixel1_clk_src,
>   			&disp_cc_mdss_dp_pixel2_clk_src,
>   			&disp_cc_mdss_dp_pixel_clk_src,
> +			&disp_cc_mdss_edp_aux_clk_src,
> +			&disp_cc_mdss_edp_link_clk_src,
> +			&disp_cc_mdss_edp_pixel_clk_src,
>   			&disp_cc_mdss_esc0_clk_src,
> +			&disp_cc_mdss_esc1_clk_src,
>   			&disp_cc_mdss_mdp_clk_src,
>   			&disp_cc_mdss_pclk0_clk_src,
>   			&disp_cc_mdss_pclk1_clk_src,
> @@ -1297,6 +1316,7 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
>   			&disp_cc_mdss_byte1_div_clk_src,
>   			&disp_cc_mdss_dp_link1_div_clk_src,
>   			&disp_cc_mdss_dp_link_div_clk_src,
> +			&disp_cc_mdss_edp_link_div_clk_src,
>   		};
>   		unsigned int i;
>   		static bool offset_applied;

-- 
With best wishes
Dmitry

