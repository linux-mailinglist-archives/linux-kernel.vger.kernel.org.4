Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EAD6991ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjBPKmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjBPKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:42:05 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFF053556
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:41:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bi36so2213137lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EoQZMz3QMPI/jSh+VCUAYTTTyXW1Jjmg/RCKKdq0Zw=;
        b=ckhweKjSCyBDRkO8ABv489M9HN+MgwONqEUPZDsfQNMjn7iVRg/aqXDarQSaZ00apv
         4ArX7drF/yrrrTm1GfcEFUBVvFlONZrxyWhLicuXUV9q1bznK3AM5iFxunHT5/Bv7dGh
         IUTphjljwl6h4LRtOP7374ispeQjALTXHh5U0mt7It4Ck8Nlpu8TN+5hYKCBbjDCdS/h
         GIxvTwnrFtwdmO7lA94e04rHAvykHx7XlVPW1+EIaG0/F+8k7924r5J6nqcLLMxnzfsD
         mgnknCtwhYfq//dG1Jv0449uRYMEJDwNSZOOOobwLAnwt6H9hjEinDaaXWQjPN9FLdlj
         na7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EoQZMz3QMPI/jSh+VCUAYTTTyXW1Jjmg/RCKKdq0Zw=;
        b=x03BcxIcg8u/JrtzJ0acAs8KlsuNwGMP+x6kJEeVZ2kSv11RxKtPqWQbzVp6F/yIxy
         FtJSa1FtrLcAAckbQE9J7IdMpAMNkS4/D632SjWMk6jOFBqbO+jTa6UkMPMFRTMFyRpq
         FMQFn9iGyfwkimecVWcMlDrehleOHghq1BIzIdFiewjRFJdyuIvYKI7C5aDY5zar8wzy
         IfnYygoBm2z4mArwKZ4lDMU6Lx6j4vnMxE/VrUUy5YaLu4bWJH3fYKOVwRB3kTyttu+W
         Jg6tOwFK026GGHEGZYC3vb64By4yC5ybU1mcTv7AyVlIhA6YIZWDJxgLnTNk/vXCEpix
         /RdQ==
X-Gm-Message-State: AO0yUKXCAVeJgack3VGX3Nzy7LpLzzL8X4RAlPRdIJ2/NjM+cGD6BtR9
        VffDheBsa5dhArRzFK9nPyp3AA==
X-Google-Smtp-Source: AK7set/jydXs7rI+m9sRlTpj0gBdwr7Fv6QbSUO0kGwdEkKAK9mMBvxpjy6R4N1HuLgR9vwoOBfyiw==
X-Received: by 2002:ac2:5328:0:b0:4ca:faa4:af15 with SMTP id f8-20020ac25328000000b004cafaa4af15mr1429094lfh.66.1676544091486;
        Thu, 16 Feb 2023 02:41:31 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id l12-20020ac24a8c000000b004a6f66eed7fsm246305lfp.165.2023.02.16.02.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:41:31 -0800 (PST)
Message-ID: <06fa7de2-7c1c-8dc6-68e4-8902c902b619@linaro.org>
Date:   Thu, 16 Feb 2023 11:41:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 6/7] clk: qcom: gcc-ipq4019: move pcnoc clocks up
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, andersson@kernel.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr
References: <20230214162325.312057-1-robert.marko@sartura.hr>
 <20230214162325.312057-6-robert.marko@sartura.hr>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230214162325.312057-6-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.02.2023 17:23, Robert Marko wrote:
> Move pcnoc clocks up just after PLL-s to be able to use their
> HW fields.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/clk/qcom/gcc-ipq4019.c | 74 +++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq4019.c b/drivers/clk/qcom/gcc-ipq4019.c
> index f4bc587131c20..f2728dc1e5521 100644
> --- a/drivers/clk/qcom/gcc-ipq4019.c
> +++ b/drivers/clk/qcom/gcc-ipq4019.c
> @@ -499,6 +499,43 @@ static struct clk_fepll gcc_fepllwcss5g_clk = {
>  	.pll_vco = &gcc_fepll_vco,
>  };
>  
> +static const struct freq_tbl ftbl_gcc_pcnoc_ahb_clk[] = {
> +	F(48000000,  P_XO,	 1, 0, 0),
> +	F(100000000, P_FEPLL200, 2, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_pcnoc_ahb_clk_src = {
> +	.cmd_rcgr = 0x21024,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_200_500_map,
> +	.freq_tbl = ftbl_gcc_pcnoc_ahb_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gcc_pcnoc_ahb_clk_src",
> +		.parent_names = gcc_xo_200_500,
> +		.num_parents = 3,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_branch pcnoc_clk_src = {
> +	.halt_reg = 0x21030,
> +	.clkr = {
> +		.enable_reg = 0x21030,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "pcnoc_clk_src",
> +			.parent_names = (const char *[]){
> +				"gcc_pcnoc_ahb_clk_src",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_SET_RATE_PARENT |
> +				CLK_IS_CRITICAL,
> +		},
> +	},
> +};
> +
>  static const struct freq_tbl ftbl_gcc_audio_pwm_clk[] = {
>  	F(48000000, P_XO, 1, 0, 0),
>  	F(200000000, P_FEPLL200, 1, 0, 0),
> @@ -1541,43 +1578,6 @@ static struct clk_branch gcc_wcss5g_rtc_clk = {
>  	},
>  };
>  
> -static const struct freq_tbl ftbl_gcc_pcnoc_ahb_clk[] = {
> -	F(48000000,  P_XO,	 1, 0, 0),
> -	F(100000000, P_FEPLL200, 2, 0, 0),
> -	{ }
> -};
> -
> -static struct clk_rcg2 gcc_pcnoc_ahb_clk_src = {
> -	.cmd_rcgr = 0x21024,
> -	.hid_width = 5,
> -	.parent_map = gcc_xo_200_500_map,
> -	.freq_tbl = ftbl_gcc_pcnoc_ahb_clk,
> -	.clkr.hw.init = &(struct clk_init_data){
> -		.name = "gcc_pcnoc_ahb_clk_src",
> -		.parent_names = gcc_xo_200_500,
> -		.num_parents = 3,
> -		.ops = &clk_rcg2_ops,
> -	},
> -};
> -
> -static struct clk_branch pcnoc_clk_src = {
> -	.halt_reg = 0x21030,
> -	.clkr = {
> -		.enable_reg = 0x21030,
> -		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data){
> -			.name = "pcnoc_clk_src",
> -			.parent_names = (const char *[]){
> -				"gcc_pcnoc_ahb_clk_src",
> -			},
> -			.num_parents = 1,
> -			.ops = &clk_branch2_ops,
> -			.flags = CLK_SET_RATE_PARENT |
> -				CLK_IS_CRITICAL,
> -		},
> -	},
> -};
> -
>  static struct clk_regmap *gcc_ipq4019_clocks[] = {
>  	[AUDIO_CLK_SRC] = &audio_clk_src.clkr,
>  	[BLSP1_QUP1_I2C_APPS_CLK_SRC] = &blsp1_qup1_i2c_apps_clk_src.clkr,
