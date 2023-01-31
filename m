Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D8C682915
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjAaJkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjAaJkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:40:42 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27F12FCDD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:40:35 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mc11so17353789ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FobEID21vrhz/x7tIIWEc7olkgtXkakThsSq+isdsU=;
        b=Fk3UFZnlTDJE8IVYGJtWGPh7tv9fdGnLugEN8pbkcaWK1YjsxjniyN+1v1n2VTiTpp
         9ExYUWg815eWW2VDRNjwSAUJSMljuiFhrdRuL8jWYs1BSha2nIkAKdE0LwiaHmmJeZrW
         gfkpz7qPS0+MHSPwWHCoFnAk6Ze2TeMVl9AxURoNHsbCqI3J9bVt6Swn4bxpsyRVoLPI
         R/4/7cPpHxr+6gCjp11TqXy+KVlzsEnT/sVZhou9Z8c8apUF3PQJc42lV2p3IfGhyj7R
         xKBKLe+3lshnvAolE4xdHJBaoZLDSHocnX7GMDJqtvGrJeXcv9PPhuB8lT8p91t9YaW7
         uH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FobEID21vrhz/x7tIIWEc7olkgtXkakThsSq+isdsU=;
        b=JIVdl0FkW7Ko5OGVPuQiUz7Nu8FQmDWtdJ0CvGV/l+rH4+qR/5p/aW69JaOjFPmkl5
         Gq/LzUn4+0ZAgx9VJw8B0DjxOfdhFBmz5Bf5crRo3wDcisXdUsO4yObFRXfTpYjbFp1V
         pRjRMuAnoGEzfpSf1cz3oT9QyJas1R+yoMRCPTslMdynIyfBTUOQITf2yYkHU25hoQTx
         /jSUd7Dxegdn1+h958ObLxEQhY2xkfx+BDrCqVUwAYFmsoH7HuE8t33LQxpnj0TOwCzL
         mgTlLCh62r/Kw4O2ZlLrf5FnxgN8dO63d32g4oDTBUxSIrsOa1COJmwl9op5HwuoQ8Lw
         pSGA==
X-Gm-Message-State: AO0yUKXExdpZ3rtB+973Im4c0h3BDGCJ78/9up+4h9muOg5CU+K936fx
        VTkj1OtwTXcF73fcQBz6P+95+g==
X-Google-Smtp-Source: AK7set/LGLUMnDyv+2FKks7oabkDIrzZkTP34i0BVUx415eZV4xEiaCORYIlekBOjPZb9yNfkSGB+w==
X-Received: by 2002:a17:906:2b09:b0:889:dc6c:c4fb with SMTP id a9-20020a1709062b0900b00889dc6cc4fbmr6309699ejg.40.1675158034323;
        Tue, 31 Jan 2023 01:40:34 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d18-20020a170906c21200b0084ce5d5d21bsm8063382ejz.22.2023.01.31.01.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 01:40:33 -0800 (PST)
Message-ID: <b8eee15f-e3e4-4a2d-853e-31e966c19cf5@linaro.org>
Date:   Tue, 31 Jan 2023 11:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 6/6] clk: qcom: Fix APSS PLL and RCG Configuration
Content-Language: en-GB
To:     Devi Priya <quic_devipriy@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, jassisinghbrar@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, marcel.ziswiler@toradex.com,
        nfraprado@collabora.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
 <20230113143647.14961-7-quic_devipriy@quicinc.com>
 <b87ab80d-0936-5a5a-25da-35c0dbdede33@linaro.org>
 <ea0dbbf0-958c-145b-abaa-3bbcb620df5c@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <ea0dbbf0-958c-145b-abaa-3bbcb620df5c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 11:17, Devi Priya wrote:
> Thanks for taking time to review the patch
> 
> On 1/13/2023 8:50 PM, Konrad Dybcio wrote:
>>
>>
>> On 13.01.2023 15:36, devi priya wrote:
>>> Included CLK_IS_CRITICAL flag which helps to properly enable
>>> the APSS PLL during bootup.
>> Please describe the issue and not only the user-visible impact it
>> makes. Does the PLL get shut down by clk_ignore_unused? Maybe you
>> would be interested in the sync_state changes that landed in recent
>> -next that may solve it for you?
>>
>> I don't think it should be always-on, as you have an alternate source
>> for low power modes, adding CLK_IS_CRITICAL will keep the PLL enabled
>> even if you're not using it.
> Yeah, got it. Will drop the critical flag
>>
>>> clk_rcg2_ops should be used for APSS clock RCG, as other ops
>>> will not configure the RCG register
>> RCG register meaning RCG register*s*, meaning in this case M/N/D
>> which would be required for proper rate setting and not only input
>> switching (which arguably doesn't seem to be of much concern on a
>> single-parent clock)? This all is not obvious..
>>
>> Konrad
> The source selection is done by configuring the RCGR config register 
> with the source entry (P_APSS_PLL_EARLY) added to the frequency table. 
> Proper rate is achieved by configuring the PLL and hence M/N/D values 
> are not configured

But the clk_rcg2_mux_closest_ops also programs the parent for the clock. 
So from your description it isn't obvious what is wrong with the current 
_ops used for the clock.

>>>
>>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>>> ---
>>>   drivers/clk/qcom/apss-ipq-pll.c | 1 +
>>>   drivers/clk/qcom/apss-ipq6018.c | 8 +++++++-
>>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/qcom/apss-ipq-pll.c 
>>> b/drivers/clk/qcom/apss-ipq-pll.c
>>> index dd0c01bf5a98..75486a124fcd 100644
>>> --- a/drivers/clk/qcom/apss-ipq-pll.c
>>> +++ b/drivers/clk/qcom/apss-ipq-pll.c
>>> @@ -33,6 +33,7 @@ static struct clk_alpha_pll ipq_pll = {
>>>               },
>>>               .num_parents = 1,
>>>               .ops = &clk_alpha_pll_huayra_ops,
>>> +            .flags = CLK_IS_CRITICAL,
>>>           },
>>>       },
>>>   };
>>> diff --git a/drivers/clk/qcom/apss-ipq6018.c 
>>> b/drivers/clk/qcom/apss-ipq6018.c
>>> index f2f502e2d5a4..0d0e7196a4dc 100644
>>> --- a/drivers/clk/qcom/apss-ipq6018.c
>>> +++ b/drivers/clk/qcom/apss-ipq6018.c
>>> @@ -33,15 +33,21 @@ static const struct parent_map 
>>> parents_apcs_alias0_clk_src_map[] = {
>>>       { P_APSS_PLL_EARLY, 5 },
>>>   };
>>> +static const struct freq_tbl ftbl_apcs_alias0_clk_src[] = {
>>> +    { .src = P_APSS_PLL_EARLY, .pre_div = 1 },
>>> +    { }
>>> +};
>>> +
>>>   static struct clk_rcg2 apcs_alias0_clk_src = {
>>>       .cmd_rcgr = 0x0050,
>>> +    .freq_tbl = ftbl_apcs_alias0_clk_src,
>>>       .hid_width = 5,
>>>       .parent_map = parents_apcs_alias0_clk_src_map,
>>>       .clkr.hw.init = &(struct clk_init_data){
>>>           .name = "apcs_alias0_clk_src",
>>>           .parent_data = parents_apcs_alias0_clk_src,
>>>           .num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
>>> -        .ops = &clk_rcg2_mux_closest_ops,
>>> +        .ops = &clk_rcg2_ops,
>>>           .flags = CLK_SET_RATE_PARENT,
>>>       },
>>>   };
> Best Regards,
> Devi Priya

-- 
With best wishes
Dmitry

