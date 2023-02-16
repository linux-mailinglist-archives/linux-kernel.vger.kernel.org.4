Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA3C6991FD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjBPKoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjBPKoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:44:15 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8144740F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:43:40 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id k24so1478109ljn.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZWqD5+WE0vrCCkyQYAi5Itl0WLBYNnpAUebfznpchw=;
        b=XsGW7R9d/2Q+oKYkodE2NHc+oan5E0D8orpefxvOcQuDLVq/UVhnOvA10Y6sB62atk
         bWNtLmKUR0ZWDcHF7/+TgEUFx1jQMMUO3UfJ6f07/Arahjc0RtVEevgQo1RXp4RCHRKy
         3x/MnjOX2HfLzdyaUU9FXp+Fjvr2+M1hkaxGT8FdzkSvAtEfeAPiqDBR7JX+zEtcHVqm
         ZxJiSHXQmO8LVRHmjpEp4fSIEhcOaXZxsT214O3ALIovamNypCyUO+FnaCQxRxgmM7fl
         3RoafX5eTNnWN7gPy2ashe+2uqJ8g1yqlv3QHQDYbCi4Cu+QdATWMtVXrKDwgBlYobMv
         Gg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZWqD5+WE0vrCCkyQYAi5Itl0WLBYNnpAUebfznpchw=;
        b=X6GcwS/0APKwV5xRmMqjAflU6gGFiJAHGS5zIsuqsAhtoG/H+uagKdsacbmQOI2ueD
         FvsTCGlPVA9ZEoLMaPndH+dllZXE/9l91+iUHKkiso12QI//MWGjrgIh6zSpgZYKsMDA
         KSD4vEkBWjXHaoDO3cRzN2taQFXwg2V/W/dZGUy/+rlPTvsSdp7Waxw3rnPfM945K0IZ
         XjW1rj1vhuUCJRpliKdGbnHDJQW6rxBiWBCXIWvidzbOGxVW+TjDT/XsL/RTCfYHXDGt
         Lq9XpBLT0WYRJWb6BqO/YFkNdXDg6EKF5rskH8thNn5d2n+xhEYvfiAqPtQubmTYj8Tw
         rBZA==
X-Gm-Message-State: AO0yUKX/XRoKGWCGKBvayYiamRYT72MUdm9A75XYmIErz1wgA2DYAAxV
        VKlUfzk6vUetdOG5xuPovQG04w==
X-Google-Smtp-Source: AK7set9DL004w9AngVNOTXPCqSXVlgWn30BcgRZQHUXpy+fzRHg2cK5ClDsZ/9Y3mjUrLQoo8dGujg==
X-Received: by 2002:a05:651c:4c9:b0:293:4ba1:c014 with SMTP id e9-20020a05651c04c900b002934ba1c014mr2425002lji.25.1676544194404;
        Thu, 16 Feb 2023 02:43:14 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id x20-20020a2e9dd4000000b00292b759af81sm140835ljj.92.2023.02.16.02.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:43:14 -0800 (PST)
Message-ID: <77c66b89-ff06-3440-380f-4ef8046b945c@linaro.org>
Date:   Thu, 16 Feb 2023 11:43:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/7] clk: qcom: gcc-ipq4019: convert XO and sleep clk to
 parent_data
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Robert Marko <robert.marko@sartura.hr>, andersson@kernel.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr
References: <20230214162325.312057-1-robert.marko@sartura.hr>
 <20230214162325.312057-2-robert.marko@sartura.hr>
 <bf7fc793-d12d-5a01-e3ab-d81e9059d792@linaro.org>
In-Reply-To: <bf7fc793-d12d-5a01-e3ab-d81e9059d792@linaro.org>
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



On 16.02.2023 11:42, Konrad Dybcio wrote:
> 
> 
> On 14.02.2023 17:23, Robert Marko wrote:
>> Start off IPQ4019 GCC conversion by converting XO and sleep clks to
>> parent data in order to directly pass them.
>>
>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>> ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
Actually, any reason not to use .index?

Konrad
>>  drivers/clk/qcom/gcc-ipq4019.c | 75 ++++++++++++++++++++--------------
>>  1 file changed, 45 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-ipq4019.c b/drivers/clk/qcom/gcc-ipq4019.c
>> index 362c732536cd3..a50887d3626f7 100644
>> --- a/drivers/clk/qcom/gcc-ipq4019.c
>> +++ b/drivers/clk/qcom/gcc-ipq4019.c
>> @@ -657,8 +657,9 @@ static struct clk_branch gcc_dcd_xo_clk = {
>>  		.enable_mask = BIT(0),
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "gcc_dcd_xo_clk",
>> -			.parent_names = (const char *[]){
>> -				"xo",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "xo",
>> +				.name = "xo",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_branch2_ops,
>> @@ -954,8 +955,9 @@ static struct clk_branch gcc_usb2_sleep_clk = {
>>  		.enable_mask = BIT(0),
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "gcc_usb2_sleep_clk",
>> -			.parent_names = (const char *[]){
>> -				"gcc_sleep_clk_src",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "sleep_clk",
>> +				.name = "gcc_sleep_clk_src",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_branch2_ops,
>> @@ -1021,8 +1023,9 @@ static struct clk_branch gcc_usb3_sleep_clk = {
>>  		.enable_mask = BIT(0),
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "gcc_usb3_sleep_clk",
>> -			.parent_names = (const char *[]){
>> -				"gcc_sleep_clk_src",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "sleep_clk",
>> +				.name = "gcc_sleep_clk_src",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_branch2_ops,
>> @@ -1110,8 +1113,9 @@ static struct clk_branch gcc_wcss2g_ref_clk = {
>>  		.enable_mask = BIT(0),
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "gcc_wcss2g_ref_clk",
>> -			.parent_names = (const char *[]){
>> -				"xo",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "xo",
>> +				.name = "xo",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_branch2_ops,
>> @@ -1127,8 +1131,9 @@ static struct clk_branch gcc_wcss2g_rtc_clk = {
>>  		.enable_mask = BIT(0),
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "gcc_wcss2g_rtc_clk",
>> -			.parent_names = (const char *[]){
>> -				"gcc_sleep_clk_src",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "sleep_clk",
>> +				.name = "gcc_sleep_clk_src",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_branch2_ops,
>> @@ -1179,8 +1184,9 @@ static struct clk_branch gcc_wcss5g_ref_clk = {
>>  		.enable_mask = BIT(0),
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "gcc_wcss5g_ref_clk",
>> -			.parent_names = (const char *[]){
>> -				"xo",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "xo",
>> +				.name = "xo",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_branch2_ops,
>> @@ -1196,8 +1202,9 @@ static struct clk_branch gcc_wcss5g_rtc_clk = {
>>  		.enable_mask = BIT(0),
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "gcc_wcss5g_rtc_clk",
>> -			.parent_names = (const char *[]){
>> -				"gcc_sleep_clk_src",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "sleep_clk",
>> +				.name = "gcc_sleep_clk_src",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_branch2_ops,
>> @@ -1360,8 +1367,9 @@ static struct clk_fepll gcc_apss_cpu_plldiv_clk = {
>>  		.enable_mask = BIT(0),
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "ddrpllapss",
>> -			.parent_names = (const char *[]){
>> -				"xo",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "xo",
>> +				.name = "xo",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_regmap_cpu_div_ops,
>> @@ -1412,8 +1420,9 @@ static struct clk_fepll gcc_apss_sdcc_clk = {
>>  	.cdiv.clkr = {
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "ddrpllsdcc",
>> -			.parent_names = (const char *[]){
>> -				"xo",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "xo",
>> +				.name = "xo",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_fepll_div_ops,
>> @@ -1427,8 +1436,9 @@ static struct clk_fepll gcc_fepll125_clk = {
>>  	.cdiv.clkr = {
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "fepll125",
>> -			.parent_names = (const char *[]){
>> -				"xo",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "xo",
>> +				.name = "xo",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_fepll_div_ops,
>> @@ -1442,8 +1452,9 @@ static struct clk_fepll gcc_fepll125dly_clk = {
>>  	.cdiv.clkr = {
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "fepll125dly",
>> -			.parent_names = (const char *[]){
>> -				"xo",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "xo",
>> +				.name = "xo",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_fepll_div_ops,
>> @@ -1457,8 +1468,9 @@ static struct clk_fepll gcc_fepll200_clk = {
>>  	.cdiv.clkr = {
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "fepll200",
>> -			.parent_names = (const char *[]){
>> -				"xo",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "xo",
>> +				.name = "xo",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_fepll_div_ops,
>> @@ -1472,8 +1484,9 @@ static struct clk_fepll gcc_fepll500_clk = {
>>  	.cdiv.clkr = {
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "fepll500",
>> -			.parent_names = (const char *[]){
>> -				"xo",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "xo",
>> +				.name = "xo",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_fepll_div_ops,
>> @@ -1497,8 +1510,9 @@ static struct clk_fepll gcc_fepllwcss2g_clk = {
>>  	.cdiv.clkr = {
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "fepllwcss2g",
>> -			.parent_names = (const char *[]){
>> -				"xo",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "xo",
>> +				.name = "xo",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_fepll_div_ops,
>> @@ -1515,8 +1529,9 @@ static struct clk_fepll gcc_fepllwcss5g_clk = {
>>  	.cdiv.clkr = {
>>  		.hw.init = &(struct clk_init_data){
>>  			.name = "fepllwcss5g",
>> -			.parent_names = (const char *[]){
>> -				"xo",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "xo",
>> +				.name = "xo",
>>  			},
>>  			.num_parents = 1,
>>  			.ops = &clk_fepll_div_ops,
