Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206F5669DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjAMQYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjAMQXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:23:35 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52D28BA8D;
        Fri, 13 Jan 2023 08:18:03 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id az20so34371232ejc.1;
        Fri, 13 Jan 2023 08:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBg+QFTYjTGLhJ0dWRu15lQFUco6OnMwSAINFR2Ufc8=;
        b=cuK/VFk+DbNtK+OX/wHoutGa2p4Kfe5Q7d3XI9jKvGON2hd2fxHFauh53Nk23UYdy5
         sDyv0e6TdaqU+uu5e1cqqY0+Ay0KRDzjd8KIKYxdgM5Qj9MxpRyuEVsPQf4bHVxm7Fqq
         K607+e+ezHlARhTUhPjSQ1F3204Tz+2yNDbm0pOdMiApqrYhPzOseIXq2tjXVdhHoNBI
         kGNQBaDL8YddNGR81t2OVdWGZgJ/uDwYLWpsiA1pd8Y0iTepefBqzZCawGk0eX9BxNR7
         abXDexkP6HIe3skYOeKSwWTnZ3muL0d1IZlM0SoTjpH0nQwFwmHfT4ED2IGG9GdUDqdW
         O5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBg+QFTYjTGLhJ0dWRu15lQFUco6OnMwSAINFR2Ufc8=;
        b=XXbyuixdYvQwYPSXQKWldwpIsqZUN9ynpkUwFednYitvUYSxUyCZPGLG+RkFJ55w/k
         evPd+ar4c4zUv5JilGt0dgApWQXiLDGUSiWrI8WE6FDJY3C01S9S3VmjxREdd0paeXo2
         B4Jvh7PZWwpntcnOZhlIkbRSn8uAY4KZi0bisdcD2bZ6Lo9KsDVSfb5SVWlVbiPiGGfq
         3Cgh5RjGpR7gcUb3JiDMw7Mxp7W41rsJdf2rk+hzObom2O5p0w4SNs/aN5nexq5EcM6K
         m4cTTtcdV5wmtw7e/f4JUNOiZIfxlQUWzs9aN6dHhh4WdgvtaAzOjjvZ4RGoPbIFYRf7
         Rbqw==
X-Gm-Message-State: AFqh2kpUF/hFVFAD5Bxmc4fojI8yoiydSFpi2znUS6KSE9Iq0VLiHXj7
        EsIEPk3G0PRi3KPWVm5L5uc=
X-Google-Smtp-Source: AMrXdXvcGT14YEQV+qWf4s+TmjhpCr9Dmu7pQheS9QCpPIxtnSymAa70ZRFEZnWqE1SX+bGON8nJ6Q==
X-Received: by 2002:a17:906:7046:b0:7ae:8194:7e06 with SMTP id r6-20020a170906704600b007ae81947e06mr72640122ejj.56.1673626682362;
        Fri, 13 Jan 2023 08:18:02 -0800 (PST)
Received: from [192.168.3.32] (dh207-97-245.xnet.hr. [88.207.97.245])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b007933047f923sm8698684ejn.118.2023.01.13.08.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 08:18:01 -0800 (PST)
Message-ID: <0e5e2d46-3578-678b-5980-ecf68f9a5f18@gmail.com>
Date:   Fri, 13 Jan 2023 17:17:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 6/6] clk: qcom: Fix APSS PLL and RCG Configuration
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, jassisinghbrar@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
 <20230113143647.14961-7-quic_devipriy@quicinc.com>
 <b87ab80d-0936-5a5a-25da-35c0dbdede33@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <b87ab80d-0936-5a5a-25da-35c0dbdede33@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13. 01. 2023. 16:20, Konrad Dybcio wrote:
>
> On 13.01.2023 15:36, devi priya wrote:
>> Included CLK_IS_CRITICAL flag which helps to properly enable
>> the APSS PLL during bootup.
> Please describe the issue and not only the user-visible impact it
> makes. Does the PLL get shut down by clk_ignore_unused? Maybe you
> would be interested in the sync_state changes that landed in recent
> -next that may solve it for you?
>
> I don't think it should be always-on, as you have an alternate source
> for low power modes, adding CLK_IS_CRITICAL will keep the PLL enabled
> even if you're not using it.

I have the same opinion, as this is working fine on IPQ6018 and IPQ8074
and I have not experienced any issues with it.

>
>> clk_rcg2_ops should be used for APSS clock RCG, as other ops
>> will not configure the RCG register
> RCG register meaning RCG register*s*, meaning in this case M/N/D
> which would be required for proper rate setting and not only input
> switching (which arguably doesn't seem to be of much concern on a
> single-parent clock)? This all is not obvious..
Same question from me as well, why do you need clk_rcg2_ops with
a dummy frequency table since this is just a mux using RCG2 control
bits?

Regards,
Robert
>
> Konrad
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   drivers/clk/qcom/apss-ipq-pll.c | 1 +
>>   drivers/clk/qcom/apss-ipq6018.c | 8 +++++++-
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
>> index dd0c01bf5a98..75486a124fcd 100644
>> --- a/drivers/clk/qcom/apss-ipq-pll.c
>> +++ b/drivers/clk/qcom/apss-ipq-pll.c
>> @@ -33,6 +33,7 @@ static struct clk_alpha_pll ipq_pll = {
>>   			},
>>   			.num_parents = 1,
>>   			.ops = &clk_alpha_pll_huayra_ops,
>> +			.flags = CLK_IS_CRITICAL,
>>   		},
>>   	},
>>   };
>> diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
>> index f2f502e2d5a4..0d0e7196a4dc 100644
>> --- a/drivers/clk/qcom/apss-ipq6018.c
>> +++ b/drivers/clk/qcom/apss-ipq6018.c
>> @@ -33,15 +33,21 @@ static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
>>   	{ P_APSS_PLL_EARLY, 5 },
>>   };
>>   
>> +static const struct freq_tbl ftbl_apcs_alias0_clk_src[] = {
>> +	{ .src = P_APSS_PLL_EARLY, .pre_div = 1 },
>> +	{ }
>> +};
>> +
>>   static struct clk_rcg2 apcs_alias0_clk_src = {
>>   	.cmd_rcgr = 0x0050,
>> +	.freq_tbl = ftbl_apcs_alias0_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = parents_apcs_alias0_clk_src_map,
>>   	.clkr.hw.init = &(struct clk_init_data){
>>   		.name = "apcs_alias0_clk_src",
>>   		.parent_data = parents_apcs_alias0_clk_src,
>>   		.num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
>> -		.ops = &clk_rcg2_mux_closest_ops,
>> +		.ops = &clk_rcg2_ops,
>>   		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>
