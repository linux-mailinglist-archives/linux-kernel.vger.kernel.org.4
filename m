Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91A072C374
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjFLLvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjFLLvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:51:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC23D10B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:46:31 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b227fdda27so31995151fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686570389; x=1689162389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3mDPxlhnfYT5SmnsxZrGTmX5gRHX8DqjzMmwO37aSY=;
        b=dA4FJQqMBagXhvCjRVBv3OHS4ExpERJL4B63lMj3OkTubHs7e5R716xmmfrg+T2UNJ
         MzlVdc9+67YDysbAWrBipVfbU3IUfxDsbkQvEhbWQE+jqoZtc3CG8W0m2XExHs4J0MqH
         gF6wIJzaPtf37EI/FmVjx8xWNVSkqBZ+tDANGwHRah0GAdtO+1sE5mhqI2bEY+O6+8k8
         lrcH5/Hw/Vs8yXnGdD+C4XH0U52NltNZ/obzA0tiCWYPMQgLsaEtths7y8A6iwOoHdWg
         B43elsmofAZXzTywEGEGsy27JWEOitsNy98V1oXeMWTTwxL69vskbWMzKrH3nlkDY9YF
         PmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686570389; x=1689162389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3mDPxlhnfYT5SmnsxZrGTmX5gRHX8DqjzMmwO37aSY=;
        b=c7soRwQwJT0y7qQk/b/W8F/L2zv/pJ3w3nERd6xKr8ICDe1j3ATD8/BHAJRadkeJVV
         SepEzpZEtCtwuzWA4AMELliiKD84Zcd1IYzfLC3XGDDazMd0cPOoruBHhxyGhrCeQFEe
         t0CYb1eO+BDia5fex+evrUNwh0gtKkHf1TvPNkmG8uiToQJh8FBNGUuouF10qB4SgnCF
         2mxGnqkSqBujMkE+raFfdJjOJaGiP4+FFRbYNLHTU58mapUgAixkXDK8LmfmDHrxfV/e
         jw26By5j/OsRVTaXAgktbK76gKVZKeRL56K+yDTjLOXgkCxcov3khggTsN7pnxEEGKSB
         sSbg==
X-Gm-Message-State: AC+VfDwdFtMUF5k/ltDW7/rT3SHVhhlu9A9M0Sjt59M5YDv/7flB800P
        3L2LGBNXo3+R8H4ayCxy5tmmhQ==
X-Google-Smtp-Source: ACHHUZ54ttn24RxVNSPXdIgYl5KYVQxamOh5/5ncunxmwLyOFjeBmUMAa8fH3r/zM1GGqU1pdKFZFQ==
X-Received: by 2002:a2e:3801:0:b0:2aa:e7cd:69f8 with SMTP id f1-20020a2e3801000000b002aae7cd69f8mr2059793lja.9.1686570388925;
        Mon, 12 Jun 2023 04:46:28 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v10-20020a2e960a000000b002adbe01cd69sm1731403ljh.9.2023.06.12.04.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 04:46:28 -0700 (PDT)
Message-ID: <8196144d-6cf1-897c-2520-3686e6414abb@linaro.org>
Date:   Mon, 12 Jun 2023 13:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] clk: qcom: gcc-msm8996: Use read-only RCG ops for RPM
 bus clocks
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612-topic-rcg2_ro-v1-0-e7d824aeb628@linaro.org>
 <20230612-topic-rcg2_ro-v1-2-e7d824aeb628@linaro.org>
 <ZIbw0dEdFNFcC0Hr@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZIbw0dEdFNFcC0Hr@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.06.2023 12:17, Stephan Gerhold wrote:
> On Mon, Jun 12, 2023 at 11:22:48AM +0200, Konrad Dybcio wrote:
>> The config/periph/system NoC clocks are wholly controlled by the
>> RPM firmware and Linux should never ever alter their configuration.
>>
>> Switch them over to read-only ops to avoid that.
>>
>> Fixes: b1e010c0730a ("clk: qcom: Add MSM8996 Global Clock Control (GCC) driver")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/clk/qcom/gcc-msm8996.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
>> index 5e44d1bcca9e..588e3b67657a 100644
>> --- a/drivers/clk/qcom/gcc-msm8996.c
>> +++ b/drivers/clk/qcom/gcc-msm8996.c
>> @@ -264,7 +264,7 @@ static struct clk_rcg2 system_noc_clk_src = {
>>  		.name = "system_noc_clk_src",
>>  		.parent_data = gcc_xo_gpll0_gpll0_early_div,
>>  		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_early_div),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_ro_ops,
>>  	},
>>  };
>>  
>> @@ -284,7 +284,7 @@ static struct clk_rcg2 config_noc_clk_src = {
>>  		.name = "config_noc_clk_src",
>>  		.parent_data = gcc_xo_gpll0,
>>  		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_ro_ops,
>>  	},
>>  };
>>  
>> @@ -306,7 +306,7 @@ static struct clk_rcg2 periph_noc_clk_src = {
>>  		.name = "periph_noc_clk_src",
>>  		.parent_data = gcc_xo_gpll0,
>>  		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_ro_ops,
>>  	},
>>  };
>>  
> 
> If the rcg is read-only then it shouldn't need a .freq_tbl (the
> .recalc_rate() works without it). These clocks have one for some reason.
.get_parent needs it

> 
> Maybe we should also set .flags = CLK_GET_RATE_NOCACHE to ensure that
> clk_get_rate() doesn't return some stale value? Although I'm not sure if
> it's enough to set it here or if it would need to be set on all child
> clocks as well.
Hm, I'm not sure if it makes sense for the children..

Konrad

> 
> Thanks,
> Stephan
