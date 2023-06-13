Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD0372EA4D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbjFMRyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFMRyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:54:35 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C44210F7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:54:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b331a2a4b0so25672991fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686678872; x=1689270872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9zgdhSF1aOcpipOR26/WVzGDCl4KCQi2wBowzIbrew=;
        b=yNc6OtjcskGRjYj6vDxP3axpLWF4qYIATCemgeKrybVmQMRA81UOmV9zFDg3wxbLj8
         lNDx6eMkZHhROScqrZI8u0lbRNlIpJCfBtU/xjmLEScEgaJyK8FB6erXKJ4GrTvIr9+f
         9yKyHj7sJCb7dociQkQp+QtzH67taUH4JsWLnIUmD25dfs80EP3JAXLSV8BG3nnFJ60N
         /efnXLLtodKiVqTVra8Nbc7SScuuvS3YV8qR8EKwv6jsd+J3nS+ocIqfU4AbKOB4U9H8
         sarN/yvQD0yEfAtFhkWIU4/7yqZAP9u3gct7O5r91Wdh/953fMvBulxwSF92ToMY1lAG
         E4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686678872; x=1689270872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9zgdhSF1aOcpipOR26/WVzGDCl4KCQi2wBowzIbrew=;
        b=WWSFAAcPzNsMz4vCQjtKzXHhG6aIiR3SxtwrDvNxRQzqk5kxZ7ZbKBvggrYlWKWEPb
         42gTX7F5BRNSMYnH89s36MGo18PK9KNyeXOcjFufYfTLpBd/WYdLIev2MPqP0Jdm6dRm
         IZmHBPyrhYzu5UclsnPQM2nqzkNfXHnyCc14L31UzWY4SFbI6dHw+lHRHQMRS/gdWoVK
         VoJ89EDgUbLwpOQhQqLiJr7rCyhUIxPTY9wjM6tjZddU0HkOfOEKMwfYX/aJRWky72tn
         jSya/DUE+G45uDI0g3hnGs3ikZLYEvmXpYK5xJBPlnm5iIMP8YQH/Errd5DbCzeT0jsr
         NkFg==
X-Gm-Message-State: AC+VfDxgNlAaleMrm8qdl/R9/vvx30zbKsuB1umbQcWrXdIrLEyDWV6+
        /2Nf7Wo1vwFNwhQ1w/na2C3NcA==
X-Google-Smtp-Source: ACHHUZ6A2BkRkGGsGMEt93Z0iGWqJeq40pRRnIGc4uxnQlgpWPn0FIJMF0NkqE/hSOHNKJ7QLRCU9w==
X-Received: by 2002:a2e:a411:0:b0:2b1:a8e9:d487 with SMTP id p17-20020a2ea411000000b002b1a8e9d487mr5066777ljn.10.1686678872404;
        Tue, 13 Jun 2023 10:54:32 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id d8-20020a2e9288000000b002b247680950sm1820443ljh.131.2023.06.13.10.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 10:54:32 -0700 (PDT)
Message-ID: <e3f69e9d-7c23-d5cd-e203-f1e435ba063a@linaro.org>
Date:   Tue, 13 Jun 2023 19:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] clk: qcom: gcc-msm8996: Use read-only RCG ops for RPM
 bus clocks
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
References: <20230612-topic-rcg2_ro-v1-0-e7d824aeb628@linaro.org>
 <20230612-topic-rcg2_ro-v1-2-e7d824aeb628@linaro.org>
 <20230613175626.aesimqz2alcqjtok@ripper>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230613175626.aesimqz2alcqjtok@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.06.2023 19:56, Bjorn Andersson wrote:
> On Mon, Jun 12, 2023 at 11:22:48AM +0200, Konrad Dybcio wrote:
>> The config/periph/system NoC clocks are wholly controlled by the
>> RPM firmware and Linux should never ever alter their configuration.
>>
> 
> Does Linux need to know about them?
Not really, but it allows us to get rates of their children.

We can get rid of them if one can argue debugcc is enough. Unless
we need clk_get_rate for some reason.

Konrad
> 
> Regards,
> Bjorn
> 
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
>>
>> -- 
>> 2.41.0
>>
