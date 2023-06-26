Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDDF73E0D9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjFZNkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFZNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:40:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A1AB1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:40:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso2518672e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687786811; x=1690378811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+K1LE6a71OUxy1lnMPjS5x63BvYzJvSeQH+FZKCcBY=;
        b=xhlw8S0GONyFFlNeCtkqFbwW0A7VzYNldDOiZA8kYoNHO1DsDJyn7FvUe/HOfpp2kp
         JYNNQdwPyySon1gP9j43h7VIhcLGYVO5XzE+wI5+Xa/45OP3sK4epLE+/PwdygKrpAV/
         1hbeDydQxo8z86578bCPt6W2cfz1rzTxkPeJezYEf6eNhUhL/MCe3WmbFtBUoEPECulB
         +yVSDwUua1ZYUmD8gGo0lON2pJmZAp4rGo6+Ez2DcCiUEjfyF6pEJr8J8Z+22R/1V/2D
         1dhAZ6WJAQ5eVAqQ8p+BFgbtxGXW6qBWrH4mtzxd+N/26DT1xyp55DvO83VP9Hh4n+Z9
         fbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687786811; x=1690378811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+K1LE6a71OUxy1lnMPjS5x63BvYzJvSeQH+FZKCcBY=;
        b=YwWhfMOUd5ne22+o3+i8zqHjSzUpLlU5hz9X2njZRm2N/R74HgcwY7RZ8z8zofCg3F
         DUSgTa0emw0l9ITf5yHxvuY0C3oiw3FJymyZ13e29We01RAXj82IuchvGtzujOJAY79J
         sWjVXTCogfjWj1F7gsZHdaGRxEtiCSfu3aMy/jZWlvXEqH4mVqT5aTXtwCzQXxsGLusR
         g3/y9JPrJpeoSm5tR4GRYevaJq+kvk246w/5tiU+jt+onK2ek8YmZjTBrlaRB/gnmltw
         lHi5p8i6A7ugODEGiAL9RBjfkp7/GRcjKXRSJrQdSTIHyYsyyVBj3ihfgC++SYKeejVq
         hQQQ==
X-Gm-Message-State: AC+VfDyf/eef1inntzTJU/WXKRse5kUh23OpvG/hyiXVyHRMA+vRHSj7
        iQv1ajknT2iVKAhru0ZR74GK+g==
X-Google-Smtp-Source: ACHHUZ4wQ8F2j65lhRkRoyTm43QeDBy6DJVkkjt5tgezsscF8KCcEMIKwqytmpwZZHBhU4ag6BEhKw==
X-Received: by 2002:a19:f243:0:b0:4f5:e688:25c3 with SMTP id d3-20020a19f243000000b004f5e68825c3mr14312575lfk.44.1687786811124;
        Mon, 26 Jun 2023 06:40:11 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d13-20020ac241cd000000b004db1a7e6decsm1109225lfi.205.2023.06.26.06.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:40:10 -0700 (PDT)
Message-ID: <a10cdae8-3f18-7ffc-8db7-ab21b47b91ca@linaro.org>
Date:   Mon, 26 Jun 2023 16:40:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V5 4/5] clk: qcom: camcc-sm8550: Add support for qdss,
 sleep and xo clocks
Content-Language: en-GB
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230623164619.11464-1-quic_jkona@quicinc.com>
 <20230623164619.11464-5-quic_jkona@quicinc.com>
 <11b3058c-2261-95a4-2347-b0a33fdeb1e3@linaro.org>
 <99aebcb3-89d4-993b-5bc1-abc475b94843@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <99aebcb3-89d4-993b-5bc1-abc475b94843@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 14:59, Jagadeesh Kona wrote:
> 
> 
> On 6/24/2023 5:49 PM, Konrad Dybcio wrote:
>> On 23.06.2023 18:46, Jagadeesh Kona wrote:
>>> Add support for camera qdss, sleep and xo clocks.
>>>
>>> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>> ---
>>> Changes since v4:
>>>   - No changes.
>>> Changes since v3:
>>>   - No changes.
>>> Changes since v2:
>>>   - No changes.
>>> Changes since v1:
>>>   - Newly added.
>>>
>>>   drivers/clk/qcom/camcc-sm8550.c | 180 ++++++++++++++++++++++++++++++++
>>>   1 file changed, 180 insertions(+)
>>>
>>> diff --git a/drivers/clk/qcom/camcc-sm8550.c 
>>> b/drivers/clk/qcom/camcc-sm8550.c
>>> index 075bea32087c..7b4882444d58 100644
>>> --- a/drivers/clk/qcom/camcc-sm8550.c
>>> +++ b/drivers/clk/qcom/camcc-sm8550.c
>>> @@ -22,6 +22,8 @@
>>>   enum {
>>>       DT_IFACE,
>>>       DT_BI_TCXO,
>>> +    DT_BI_TCXO_AO,
>>> +    DT_SLEEP_CLK,
>>>   };
>>>   enum {
>>> @@ -43,6 +45,7 @@ enum {
>>>       P_CAM_CC_PLL10_OUT_EVEN,
>>>       P_CAM_CC_PLL11_OUT_EVEN,
>>>       P_CAM_CC_PLL12_OUT_EVEN,
>>> +    P_SLEEP_CLK,
>>>   };
>>>   static const struct pll_vco lucid_ole_vco[] = {
>>> @@ -881,6 +884,22 @@ static const struct clk_parent_data 
>>> cam_cc_parent_data_11[] = {
>>>       { .hw = &cam_cc_pll7_out_even.clkr.hw },
>>>   };
>>> +static const struct parent_map cam_cc_parent_map_12[] = {
>>> +    { P_SLEEP_CLK, 0 },
>>> +};
>>> +
>>> +static const struct clk_parent_data cam_cc_parent_data_12[] = {
>>> +    { .index = DT_SLEEP_CLK },
>>> +};
>>> +
>>> +static const struct parent_map cam_cc_parent_map_13[] = {
>>> +    { P_BI_TCXO, 0 },
>>> +};
>>> +
>>> +static const struct clk_parent_data cam_cc_parent_data_13_ao[] = {
>>> +    { .index = DT_BI_TCXO_AO },
>>> +};
>>> +
>>>   static const struct freq_tbl ftbl_cam_cc_bps_clk_src[] = {
>>>       F(19200000, P_BI_TCXO, 1, 0, 0),
>>>       F(200000000, P_CAM_CC_PLL8_OUT_EVEN, 1, 0, 0),
>>> @@ -1565,6 +1584,29 @@ static struct clk_rcg2 cam_cc_mclk7_clk_src = {
>>>       },
>>>   };
>>> +static const struct freq_tbl ftbl_cam_cc_qdss_debug_clk_src[] = {
>>> +    F(19200000, P_BI_TCXO, 1, 0, 0),
>>> +    F(75000000, P_CAM_CC_PLL0_OUT_EVEN, 8, 0, 0),
>>> +    F(150000000, P_CAM_CC_PLL0_OUT_EVEN, 4, 0, 0),
>>> +    F(300000000, P_CAM_CC_PLL0_OUT_MAIN, 4, 0, 0),
>>> +    { }
>>> +};
>>> +
>>> +static struct clk_rcg2 cam_cc_qdss_debug_clk_src = {
>>> +    .cmd_rcgr = 0x13f24,
>>> +    .mnd_width = 0,
>>> +    .hid_width = 5,
>>> +    .parent_map = cam_cc_parent_map_0,
>>> +    .freq_tbl = ftbl_cam_cc_qdss_debug_clk_src,
>>> +    .clkr.hw.init = &(const struct clk_init_data) {
>>> +        .name = "cam_cc_qdss_debug_clk_src",
>>> +        .parent_data = cam_cc_parent_data_0,
>>> +        .num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
>>> +        .flags = CLK_SET_RATE_PARENT,
>>> +        .ops = &clk_rcg2_shared_ops,
>>> +    },
>>> +};
>>> +
>>>   static const struct freq_tbl ftbl_cam_cc_sfe_0_clk_src[] = {
>>>       F(466000000, P_CAM_CC_PLL6_OUT_EVEN, 1, 0, 0),
>>>       F(594000000, P_CAM_CC_PLL6_OUT_EVEN, 1, 0, 0),
>>> @@ -1611,6 +1653,26 @@ static struct clk_rcg2 cam_cc_sfe_1_clk_src = {
>>>       },
>>>   };
>>> +static const struct freq_tbl ftbl_cam_cc_sleep_clk_src[] = {
>>> +    F(32000, P_SLEEP_CLK, 1, 0, 0),
>>> +    { }
>>> +};
>>> +
>>> +static struct clk_rcg2 cam_cc_sleep_clk_src = {
>>> +    .cmd_rcgr = 0x141a0,
>>> +    .mnd_width = 0,
>>> +    .hid_width = 5,
>>> +    .parent_map = cam_cc_parent_map_12,
>>> +    .freq_tbl = ftbl_cam_cc_sleep_clk_src,
>>> +    .clkr.hw.init = &(const struct clk_init_data) {
>>> +        .name = "cam_cc_sleep_clk_src",
>>> +        .parent_data = cam_cc_parent_data_12,
>>> +        .num_parents = ARRAY_SIZE(cam_cc_parent_data_12),
>>> +        .flags = CLK_SET_RATE_PARENT,
>>> +        .ops = &clk_rcg2_shared_ops,
>>> +    },
>>> +};
>>> +
>>>   static const struct freq_tbl ftbl_cam_cc_slow_ahb_clk_src[] = {
>>>       F(19200000, P_BI_TCXO, 1, 0, 0),
>>>       F(80000000, P_CAM_CC_PLL0_OUT_EVEN, 7.5, 0, 0),
>>> @@ -1632,6 +1694,26 @@ static struct clk_rcg2 cam_cc_slow_ahb_clk_src 
>>> = {
>>>       },
>>>   };
>>> +static const struct freq_tbl ftbl_cam_cc_xo_clk_src[] = {
>>> +    F(19200000, P_BI_TCXO, 1, 0, 0),
>> You're overloading P_BI_TCXO with a different parent clock (XO_A).
>>
> 
> This RCG just requires active only voting, hence using XO_A as its parent.
> 
> Both XO and XO_A are same clock in HW (BI_TCXO), hence we can reuse 
> P_BI_TCXO in frequency table for XO_A parent as well.

Please don't do such things, it complicates understanding the driver. 
The reviewer could have thought that here the driver was really 
referencing to the BI_TCXO rather than BI_TCXO_AO.

> 
> Thanks,
> Jagadeesh
> 
>> The rest lgtm
>>
>> Konrad

[skipped the rest]

-- 
With best wishes
Dmitry

