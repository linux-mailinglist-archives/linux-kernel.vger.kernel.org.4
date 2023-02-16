Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC796991F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBPKnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBPKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:43:30 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2126955E45
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:43:07 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id i18so861653ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDGklwWThdkxRdHsSM+aP24AprIebDW9dUH+Ij+Lwuc=;
        b=WB41cTa0M7NazJKMWh1MMmCFPNS3qBqnNQpB4IiYOboxJhhoPb3XbZkM9Kg3gjlZaU
         fWRgGpXEdy0jL56vkUssfP7B+5RIU7y/4B6zwhnrlhZ647nvsvEnYxF4xtvvFUPcR044
         C9sX4TeweFexFxIgytQ4q2VcmBFF5C6TpZUbh+B/QXb14viN19R6LUxS1HgBn//xoNNY
         7rwCYnSlYDSq1eJ5c3ySsVzM3pSf0sIhlrj42AlZfZaT4yn9UnJE0FeGzWcu7jiUXIgj
         10nblLcAH3gOQN/FZa+Uxbj0+vSG+7kHV7hkis6niDbcIATnpyjP0QsRR9l+CLrzhyY9
         FaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDGklwWThdkxRdHsSM+aP24AprIebDW9dUH+Ij+Lwuc=;
        b=ahLNKdqXdNkfsVgMeZnDCHUr1p9fyMJrofJbR3/howSENNWS/9IDtHTZ+oBqJqzsRc
         JE6CObaymRD6RPKWYjWPp7692+1X3lZJsXdHdm1KqPWctpF8bnEGKkYLagFpaR9LFA/w
         G+/sGDEWIphesdnazhQbbpJ/ydLOODAxhxwMnAE0mWLLf9zT7vNSGuP7ea4igUjFDEkb
         lxsJKtYlMeEWA5WivXaXxEmlGW9XNFzE3HCbrGpKKgLVTYmbwKfR5RsiJvMvz9eG79Hs
         FDCUGwi8dpELQ67rfZL7bwZ9DShLkFz21+TF3wF4ZYb4ORxrMqVJpM47Iv5zvkxWQjKo
         BKPA==
X-Gm-Message-State: AO0yUKW3orEws4qYViWItFmcY8b2UQhpTU+QOG8CBA8q+HFERyGPGltZ
        rRc7nsWDLtAYnhO/0TJekwTZHA==
X-Google-Smtp-Source: AK7set9uf8cnDTejxPYtcyON6fp/JJZyc4bV9hw06VMsA/7dvFZx513jipEvTdt1++UHuQ7BDF4PVw==
X-Received: by 2002:a2e:98c6:0:b0:293:492b:1e6f with SMTP id s6-20020a2e98c6000000b00293492b1e6fmr1475278ljj.38.1676544162540;
        Thu, 16 Feb 2023 02:42:42 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id o1-20020a056512050100b004d856fe5121sm243795lfb.194.2023.02.16.02.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:42:42 -0800 (PST)
Message-ID: <bf7fc793-d12d-5a01-e3ab-d81e9059d792@linaro.org>
Date:   Thu, 16 Feb 2023 11:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/7] clk: qcom: gcc-ipq4019: convert XO and sleep clk to
 parent_data
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, andersson@kernel.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr
References: <20230214162325.312057-1-robert.marko@sartura.hr>
 <20230214162325.312057-2-robert.marko@sartura.hr>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230214162325.312057-2-robert.marko@sartura.hr>
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
> Start off IPQ4019 GCC conversion by converting XO and sleep clks to
> parent data in order to directly pass them.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/clk/qcom/gcc-ipq4019.c | 75 ++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq4019.c b/drivers/clk/qcom/gcc-ipq4019.c
> index 362c732536cd3..a50887d3626f7 100644
> --- a/drivers/clk/qcom/gcc-ipq4019.c
> +++ b/drivers/clk/qcom/gcc-ipq4019.c
> @@ -657,8 +657,9 @@ static struct clk_branch gcc_dcd_xo_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_dcd_xo_clk",
> -			.parent_names = (const char *[]){
> -				"xo",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo",
> +				.name = "xo",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
> @@ -954,8 +955,9 @@ static struct clk_branch gcc_usb2_sleep_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb2_sleep_clk",
> -			.parent_names = (const char *[]){
> -				"gcc_sleep_clk_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "sleep_clk",
> +				.name = "gcc_sleep_clk_src",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
> @@ -1021,8 +1023,9 @@ static struct clk_branch gcc_usb3_sleep_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb3_sleep_clk",
> -			.parent_names = (const char *[]){
> -				"gcc_sleep_clk_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "sleep_clk",
> +				.name = "gcc_sleep_clk_src",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
> @@ -1110,8 +1113,9 @@ static struct clk_branch gcc_wcss2g_ref_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_wcss2g_ref_clk",
> -			.parent_names = (const char *[]){
> -				"xo",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo",
> +				.name = "xo",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
> @@ -1127,8 +1131,9 @@ static struct clk_branch gcc_wcss2g_rtc_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_wcss2g_rtc_clk",
> -			.parent_names = (const char *[]){
> -				"gcc_sleep_clk_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "sleep_clk",
> +				.name = "gcc_sleep_clk_src",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
> @@ -1179,8 +1184,9 @@ static struct clk_branch gcc_wcss5g_ref_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_wcss5g_ref_clk",
> -			.parent_names = (const char *[]){
> -				"xo",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo",
> +				.name = "xo",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
> @@ -1196,8 +1202,9 @@ static struct clk_branch gcc_wcss5g_rtc_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_wcss5g_rtc_clk",
> -			.parent_names = (const char *[]){
> -				"gcc_sleep_clk_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "sleep_clk",
> +				.name = "gcc_sleep_clk_src",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
> @@ -1360,8 +1367,9 @@ static struct clk_fepll gcc_apss_cpu_plldiv_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "ddrpllapss",
> -			.parent_names = (const char *[]){
> -				"xo",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo",
> +				.name = "xo",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_regmap_cpu_div_ops,
> @@ -1412,8 +1420,9 @@ static struct clk_fepll gcc_apss_sdcc_clk = {
>  	.cdiv.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "ddrpllsdcc",
> -			.parent_names = (const char *[]){
> -				"xo",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo",
> +				.name = "xo",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_fepll_div_ops,
> @@ -1427,8 +1436,9 @@ static struct clk_fepll gcc_fepll125_clk = {
>  	.cdiv.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "fepll125",
> -			.parent_names = (const char *[]){
> -				"xo",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo",
> +				.name = "xo",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_fepll_div_ops,
> @@ -1442,8 +1452,9 @@ static struct clk_fepll gcc_fepll125dly_clk = {
>  	.cdiv.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "fepll125dly",
> -			.parent_names = (const char *[]){
> -				"xo",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo",
> +				.name = "xo",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_fepll_div_ops,
> @@ -1457,8 +1468,9 @@ static struct clk_fepll gcc_fepll200_clk = {
>  	.cdiv.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "fepll200",
> -			.parent_names = (const char *[]){
> -				"xo",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo",
> +				.name = "xo",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_fepll_div_ops,
> @@ -1472,8 +1484,9 @@ static struct clk_fepll gcc_fepll500_clk = {
>  	.cdiv.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "fepll500",
> -			.parent_names = (const char *[]){
> -				"xo",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo",
> +				.name = "xo",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_fepll_div_ops,
> @@ -1497,8 +1510,9 @@ static struct clk_fepll gcc_fepllwcss2g_clk = {
>  	.cdiv.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "fepllwcss2g",
> -			.parent_names = (const char *[]){
> -				"xo",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo",
> +				.name = "xo",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_fepll_div_ops,
> @@ -1515,8 +1529,9 @@ static struct clk_fepll gcc_fepllwcss5g_clk = {
>  	.cdiv.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "fepllwcss5g",
> -			.parent_names = (const char *[]){
> -				"xo",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo",
> +				.name = "xo",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_fepll_div_ops,
