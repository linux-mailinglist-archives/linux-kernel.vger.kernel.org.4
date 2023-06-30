Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A594B74452C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjF3XWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjF3XWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:22:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3484F49F5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 16:21:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so39797931fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 16:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688167270; x=1690759270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JP9h1rS2E5zsXkgZB46K1q99NJea9LBJTLy1ke4IjZc=;
        b=wpI1xR5ZSnTdrYLlCcyiJlkZAKkFt/ubC3aVLLfsmfIuZciKT2vmnnHAk3lzHyns0J
         F34c1QCD1dz6LSf88nO2fz4MJC5xxe9XmjSAPMZ1ZC0EH6NhJAOVIZuDxyD2BuSi1bKS
         ub4YMufjNhvaJsWAfrB80VgX0mQhaGyA6jr7IVc0sJvj5Hy51/jpuB3W2bFaL1u6j2Zt
         MtiJvniHwWUtr7u/wPGl+qS9rnj+c14E8AX2YIgj/KCBpifSptpFU5Sgy8et+HdLV9wB
         EH68AMG8DBlhDCU/qtIBMbV5drasRU8ILU9Xjo7BmNQwDcxraFklg6h6sNtfRDiPxMSv
         Ihrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688167270; x=1690759270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JP9h1rS2E5zsXkgZB46K1q99NJea9LBJTLy1ke4IjZc=;
        b=JT/EDDDMANGMEaHT87EBge0fNKc7PZh7aDS2edf5j1y2j04e10T05CisH4LykckFcZ
         8SVayB+QIxSFFaTeJQApgkTwEBmc3SXryxP8LWW6Qd5kzA/C9eKogTRs8Xpkw7AYH6LT
         EX0No+Gu9iRFxGBor0gbNAY2EPrPKZa1ljfGHBUqGnH9S44VGzfs8L0nIng/NJInosLn
         Z8EUJkpmzqzST6Fh16/bgwMdzwuYvcrOpfJHrEMB/IDiu8r96mD9jdJ5YvfoqBqR59Nu
         UO6EL8su3akHQIZzMpCdvDFRf7aITwQb7WEom1J3Dx0JRbRGSZDdGjw2KNMSFnDCk7jf
         Vf4g==
X-Gm-Message-State: ABy/qLa3ZFG6DQIUNGaNY2wW3hN8C9hK9e8SY0sD2tXhJNzUOM1D+DvM
        BZUCiVWYbjNn6r/+5tgt/6OWYA==
X-Google-Smtp-Source: APBJJlF1yY21wcdEDtPDbJt3hFKGXm/xt/2uqknhN64+s2wv1sz+diPMOV9CZs8CQfXbD4Ly/BKUjA==
X-Received: by 2002:a05:651c:155:b0:2b6:9cec:8bfb with SMTP id c21-20020a05651c015500b002b69cec8bfbmr2545994ljd.16.1688167270172;
        Fri, 30 Jun 2023 16:21:10 -0700 (PDT)
Received: from [192.168.1.101] (abxi253.neoplus.adsl.tpnet.pl. [83.9.2.253])
        by smtp.gmail.com with ESMTPSA id k16-20020a2e8890000000b002b6bd43793dsm1538052lji.124.2023.06.30.16.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 16:21:09 -0700 (PDT)
Message-ID: <35b32667-fa29-3e00-1cad-e12a3eb7f362@linaro.org>
Date:   Sat, 1 Jul 2023 01:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V5 4/5] clk: qcom: camcc-sm8550: Add support for qdss,
 sleep and xo clocks
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <a10cdae8-3f18-7ffc-8db7-ab21b47b91ca@linaro.org>
 <a04dd502-bd0f-e5c2-c935-16d221fb86cc@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a04dd502-bd0f-e5c2-c935-16d221fb86cc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.06.2023 09:14, Jagadeesh Kona wrote:
> 
> 
> On 6/26/2023 7:10 PM, Dmitry Baryshkov wrote:
>> On 26/06/2023 14:59, Jagadeesh Kona wrote:
>>>
>>>
>>> On 6/24/2023 5:49 PM, Konrad Dybcio wrote:
>>>> On 23.06.2023 18:46, Jagadeesh Kona wrote:
>>>>> Add support for camera qdss, sleep and xo clocks.
>>>>>
>>>>> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
>>>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>> ---
>>>>> Changes since v4:
>>>>>   - No changes.
>>>>> Changes since v3:
>>>>>   - No changes.
>>>>> Changes since v2:
>>>>>   - No changes.
>>>>> Changes since v1:
>>>>>   - Newly added.
>>>>>
>>>>>   drivers/clk/qcom/camcc-sm8550.c | 180 ++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 180 insertions(+)
>>>>>
>>>>> diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
>>>>> index 075bea32087c..7b4882444d58 100644
>>>>> --- a/drivers/clk/qcom/camcc-sm8550.c
>>>>> +++ b/drivers/clk/qcom/camcc-sm8550.c
>>>>> @@ -22,6 +22,8 @@
>>>>>   enum {
>>>>>       DT_IFACE,
>>>>>       DT_BI_TCXO,
>>>>> +    DT_BI_TCXO_AO,
>>>>> +    DT_SLEEP_CLK,
>>>>>   };
>>>>>   enum {
>>>>> @@ -43,6 +45,7 @@ enum {
>>>>>       P_CAM_CC_PLL10_OUT_EVEN,
>>>>>       P_CAM_CC_PLL11_OUT_EVEN,
>>>>>       P_CAM_CC_PLL12_OUT_EVEN,
>>>>> +    P_SLEEP_CLK,
>>>>>   };
>>>>>   static const struct pll_vco lucid_ole_vco[] = {
>>>>> @@ -881,6 +884,22 @@ static const struct clk_parent_data cam_cc_parent_data_11[] = {
>>>>>       { .hw = &cam_cc_pll7_out_even.clkr.hw },
>>>>>   };
>>>>> +static const struct parent_map cam_cc_parent_map_12[] = {
>>>>> +    { P_SLEEP_CLK, 0 },
>>>>> +};
>>>>> +
>>>>> +static const struct clk_parent_data cam_cc_parent_data_12[] = {
>>>>> +    { .index = DT_SLEEP_CLK },
>>>>> +};
>>>>> +
>>>>> +static const struct parent_map cam_cc_parent_map_13[] = {
>>>>> +    { P_BI_TCXO, 0 },
>>>>> +};
>>>>> +
>>>>> +static const struct clk_parent_data cam_cc_parent_data_13_ao[] = {
>>>>> +    { .index = DT_BI_TCXO_AO },
>>>>> +};
>>>>> +
>>>>>   static const struct freq_tbl ftbl_cam_cc_bps_clk_src[] = {
>>>>>       F(19200000, P_BI_TCXO, 1, 0, 0),
>>>>>       F(200000000, P_CAM_CC_PLL8_OUT_EVEN, 1, 0, 0),
>>>>> @@ -1565,6 +1584,29 @@ static struct clk_rcg2 cam_cc_mclk7_clk_src = {
>>>>>       },
>>>>>   };
>>>>> +static const struct freq_tbl ftbl_cam_cc_qdss_debug_clk_src[] = {
>>>>> +    F(19200000, P_BI_TCXO, 1, 0, 0),
>>>>> +    F(75000000, P_CAM_CC_PLL0_OUT_EVEN, 8, 0, 0),
>>>>> +    F(150000000, P_CAM_CC_PLL0_OUT_EVEN, 4, 0, 0),
>>>>> +    F(300000000, P_CAM_CC_PLL0_OUT_MAIN, 4, 0, 0),
>>>>> +    { }
>>>>> +};
>>>>> +
>>>>> +static struct clk_rcg2 cam_cc_qdss_debug_clk_src = {
>>>>> +    .cmd_rcgr = 0x13f24,
>>>>> +    .mnd_width = 0,
>>>>> +    .hid_width = 5,
>>>>> +    .parent_map = cam_cc_parent_map_0,
>>>>> +    .freq_tbl = ftbl_cam_cc_qdss_debug_clk_src,
>>>>> +    .clkr.hw.init = &(const struct clk_init_data) {
>>>>> +        .name = "cam_cc_qdss_debug_clk_src",
>>>>> +        .parent_data = cam_cc_parent_data_0,
>>>>> +        .num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
>>>>> +        .flags = CLK_SET_RATE_PARENT,
>>>>> +        .ops = &clk_rcg2_shared_ops,
>>>>> +    },
>>>>> +};
>>>>> +
>>>>>   static const struct freq_tbl ftbl_cam_cc_sfe_0_clk_src[] = {
>>>>>       F(466000000, P_CAM_CC_PLL6_OUT_EVEN, 1, 0, 0),
>>>>>       F(594000000, P_CAM_CC_PLL6_OUT_EVEN, 1, 0, 0),
>>>>> @@ -1611,6 +1653,26 @@ static struct clk_rcg2 cam_cc_sfe_1_clk_src = {
>>>>>       },
>>>>>   };
>>>>> +static const struct freq_tbl ftbl_cam_cc_sleep_clk_src[] = {
>>>>> +    F(32000, P_SLEEP_CLK, 1, 0, 0),
>>>>> +    { }
>>>>> +};
>>>>> +
>>>>> +static struct clk_rcg2 cam_cc_sleep_clk_src = {
>>>>> +    .cmd_rcgr = 0x141a0,
>>>>> +    .mnd_width = 0,
>>>>> +    .hid_width = 5,
>>>>> +    .parent_map = cam_cc_parent_map_12,
>>>>> +    .freq_tbl = ftbl_cam_cc_sleep_clk_src,
>>>>> +    .clkr.hw.init = &(const struct clk_init_data) {
>>>>> +        .name = "cam_cc_sleep_clk_src",
>>>>> +        .parent_data = cam_cc_parent_data_12,
>>>>> +        .num_parents = ARRAY_SIZE(cam_cc_parent_data_12),
>>>>> +        .flags = CLK_SET_RATE_PARENT,
>>>>> +        .ops = &clk_rcg2_shared_ops,
>>>>> +    },
>>>>> +};
>>>>> +
>>>>>   static const struct freq_tbl ftbl_cam_cc_slow_ahb_clk_src[] = {
>>>>>       F(19200000, P_BI_TCXO, 1, 0, 0),
>>>>>       F(80000000, P_CAM_CC_PLL0_OUT_EVEN, 7.5, 0, 0),
>>>>> @@ -1632,6 +1694,26 @@ static struct clk_rcg2 cam_cc_slow_ahb_clk_src = {
>>>>>       },
>>>>>   };
>>>>> +static const struct freq_tbl ftbl_cam_cc_xo_clk_src[] = {
>>>>> +    F(19200000, P_BI_TCXO, 1, 0, 0),
>>>> You're overloading P_BI_TCXO with a different parent clock (XO_A).
>>>>
>>>
>>> This RCG just requires active only voting, hence using XO_A as its parent.
>>>
>>> Both XO and XO_A are same clock in HW (BI_TCXO), hence we can reuse P_BI_TCXO in frequency table for XO_A parent as well.
>>
>> Please don't do such things, it complicates understanding the driver. The reviewer could have thought that here the driver was really referencing to the BI_TCXO rather than BI_TCXO_AO.
>>
> 
> The enum in parent list indicates the actual HW clock, and since XO and XO_A are the same HW clock, parent enum needs to be a single one. Only parent_data needs to be updated with AO as we have been doing for all targets.
I see your point, however to Linux, XO and XO_A are two separate clocks
within the CCF.

Konrad
> 
> Thanks,
> Jagadeesh
> 
>>>
>>> Thanks,
>>> Jagadeesh
>>>
>>>> The rest lgtm
>>>>
>>>> Konrad
>>
>> [skipped the rest]
>>
