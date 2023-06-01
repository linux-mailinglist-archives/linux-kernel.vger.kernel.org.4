Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331BF71983D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjFAKDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjFAKDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:03:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E091992
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:01:47 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f3bb395e69so722031e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613705; x=1688205705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYSTat9Igsa95RCKlTUiroB8hJd17J+Bw18i+iPvHFY=;
        b=A/sGPEEExO0Vm/OJw6dieYGRULj+4unU9zlEiXWAYHxWmDYU6cUglutS6TT+XkLDAy
         kSeoliJvi39AMjyLyvynhYQ41oU1j4NWmjsHv0PT6Zw6DdUYH3FLNYfPczC3nkDEtqnH
         AO0HYZ7lolvCeMVHAl89FKBroPzogtiIPcMa2tJ8TFZFHK3CztdeJzhNRAg/vt4y7KBd
         XaTTn/l/h4ztfcs9nm+D4bzj5VJYLOkli5QjqiFVsDnljkChVgyokebfd1G16KLMaZrj
         i2qukKH6WFCaz5LBWtKzDIZw9t6a6n5OKzUnzgTjac12XkZkF/pEg0j8k5deNggwA5LT
         CPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613705; x=1688205705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYSTat9Igsa95RCKlTUiroB8hJd17J+Bw18i+iPvHFY=;
        b=JZRo4KocRgmN9RdQBUM0uey9+PXqxYJU3lWjoAURl2TBeLowdUvto04ULtnOa2OiKr
         LNZaDdUj5tB0wfwQjZiRdL+90Ifo4Uj18lEDqGGbXqLHIapV6x9CUSDTRuqeAFy7fcEt
         n5fjYuSbNvd2v+nUtQq+61CSgggkKBdN33lJruXO0Oyr7TFg/TnifCfztK1fKa567qLl
         eFPtTcGIMRVYLwX3dmqw9/FS+yTfxItRrIt13V55ce+t4qFqR+5aLooG9cmA09Qa89sk
         4xgClnFifEswGxMqco4Ep+inL10RcYW41q7P7RGnqz78UVe4uAp7nfMEg5Q6onIx3h9r
         FWDg==
X-Gm-Message-State: AC+VfDzxr5m05sgveH8OnDWLgHPJRlHJwl/Pnoup90Zxy8McRimMqoAL
        kfIPYyxm8q2ME1CTdjpvIiXI2Q==
X-Google-Smtp-Source: ACHHUZ6p9OkQgqiPie+RN1p5HzshCRQbd/wqJ0aRjs3eLtlwUJN6gJUFqVnodVSuWr5SYm3RMUcOkg==
X-Received: by 2002:a05:6512:247:b0:4f2:74d3:8996 with SMTP id b7-20020a056512024700b004f274d38996mr997846lfo.8.1685613705482;
        Thu, 01 Jun 2023 03:01:45 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v11-20020a056512096b00b004db1a7e6decsm1029228lft.205.2023.06.01.03.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:01:45 -0700 (PDT)
Message-ID: <8c077643-d162-d95f-e2cc-1dfbf7f6d714@linaro.org>
Date:   Thu, 1 Jun 2023 13:01:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/20] interconnect: qcom: icc-rpm: Allow negative QoS
 offset
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-6-1bf8e6663c4e@linaro.org>
 <8983fc5f-b75e-3f38-577f-3c588acbe3f7@linaro.org>
 <567975c4-ac55-1561-5caa-cd2db9d60d97@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <567975c4-ac55-1561-5caa-cd2db9d60d97@linaro.org>
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

On 01/06/2023 12:59, Konrad Dybcio wrote:
> 
> 
> On 1.06.2023 11:56, Dmitry Baryshkov wrote:
>> On 30/05/2023 13:20, Konrad Dybcio wrote:
>>> In some very very very very unfortunate cases, the correct offset of
>>> the QoS registers will be.. negative. One such case is MSM8998, where
>>> The DDR BWMON occupies what-would-be-the-BIMC-base which we usually
>>> take into account with the register calculation, making the actual
>>> BIMC node start at what-would-be-the-BIMC-base+0x300.
>>
>> Can we turn one of devices into a child of another device? This way we won't have to cope with negative offsets.
> Let's try to get more insight how they're correlated, but that sounds
> like an option.. 8996 will need this as well..

Anyway, I think this commit should be moved closer to the actual use.

> 
> Konrad
>>
>>>
>>> In order to keep the calculation code sane, the simplest - however
>>> ugly it may be - solution is to allow the offset to be negative.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>    drivers/interconnect/qcom/icc-rpm.h | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>>> index d2c04c400cad..ba840a436cc0 100644
>>> --- a/drivers/interconnect/qcom/icc-rpm.h
>>> +++ b/drivers/interconnect/qcom/icc-rpm.h
>>> @@ -29,10 +29,10 @@ enum qcom_icc_type {
>>>     * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
>>>     * @type: the ICC provider type
>>>     * @regmap: regmap for QoS registers read/write access
>>> - * @qos_offset: offset to QoS registers
>>>     * @bus_clk_rate: bus clock rate in Hz
>>>     * @bus_clks: the clk_bulk_data table of bus clocks
>>>     * @intf_clks: a clk_bulk_data array of interface clocks
>>> + * @qos_offset: offset to QoS registers
>>
>> This can be kept in place.
>>
>>>     * @keep_alive: whether to always keep a minimum vote on the bus clocks
>>>     * @is_on: whether the bus is powered on
>>>     */
>>> @@ -42,7 +42,7 @@ struct qcom_icc_provider {
>>>        int num_intf_clks;
>>>        enum qcom_icc_type type;
>>>        struct regmap *regmap;
>>> -    unsigned int qos_offset;
>>> +    int qos_offset;
>>>        u64 bus_clk_rate[NUM_BUS_CLKS];
>>>        struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
>>>        struct clk_bulk_data *intf_clks;
>>> @@ -108,7 +108,7 @@ struct qcom_icc_desc {
>>>        bool no_clk_scaling;
>>>        enum qcom_icc_type type;
>>>        const struct regmap_config *regmap_cfg;
>>> -    unsigned int qos_offset;
>>> +    int qos_offset;
>>>    };
>>>      /* Valid for all bus types */
>>>
>>

-- 
With best wishes
Dmitry

