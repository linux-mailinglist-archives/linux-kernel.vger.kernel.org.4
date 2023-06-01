Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D712719814
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjFAKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjFAJ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:59:48 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CDEE58
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:59:31 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2af2b74d258so8202341fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613570; x=1688205570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HN21BG58AfImMRbIzQqnR4MJn123ou4OXBSQhZXZJpo=;
        b=vCO9E1uPKpO9yLIAHGAEJ9N48lliL1A2VNE+1C0tOEnQxaMUSLUdePV3prpspS2Oc4
         AyrYI5+XDC+Y3wmPQdt/7s63S/eTYRFRi8ymrVJGiz15+wLrRlsuuk6Vnus04g7oiV8o
         fgTtzsHveoS/ejotKbL0kCsiT7bWtlbLyO6ZM6tMWPku/EHXvvRgqwtx7j4L/fWJPFpR
         bxWhj3M3nS0ZBWWFeVEJW+kN6i9mdFrb7ffkfm0ppICXCT2PVwcE9h8voShzMCrWLOn1
         TElQ3qeZObQutnwPCPAXH251vG5HLdaA3e0D55Naw/EIGHB04rGptBaCsvedF9aTCGQq
         ncCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613570; x=1688205570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HN21BG58AfImMRbIzQqnR4MJn123ou4OXBSQhZXZJpo=;
        b=J1s/vp2SoXUwWtBSpAIHxCfgaWp3nhYsioyWbJjikXDiitLc1718JRYRrne4RR3FXS
         9nACuUZIWuI8qW658bZKJwLCnDP5lEbvvwfz9k7UhybftdDnu3SUZBXczO6vO9tp4CLw
         EjfrwPU75Rz1kr9j6v1Ob5IsHW5T3xnc72W/JjQtIdrtytbi6VdH9QSnrT8wHrBALGoj
         8xS+r9F2kCkkBkh5A9DGzgGUAcLYoY0BVJaghjX+d1K7RZ0v/qasmmMPlFKpthEt1smp
         ZhRjxFd9uTuirmvAH8K9qUYypx+Fp6KOCZprnWi+CJK0wKo/OeGCJEKQB5a4zkWrTqZH
         Ycsg==
X-Gm-Message-State: AC+VfDwWpCDwOfJUHImdsH3/4wK1g9ocWGtrrDTa6YOeVotfjTfsXZVE
        Esgl4SGQs1DjVNNfAFBEyxNwnw==
X-Google-Smtp-Source: ACHHUZ7tY3KX4aPRWQOjH4k27OybtvY5WLyAO5IDzBs3SulbHm2HeF9s5q9bY6mMFXnIt5BjJYHlng==
X-Received: by 2002:a2e:9999:0:b0:2ac:6f6f:ff63 with SMTP id w25-20020a2e9999000000b002ac6f6fff63mr4669144lji.47.1685613570158;
        Thu, 01 Jun 2023 02:59:30 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id w6-20020a05651c102600b002ac833114besm3700062ljm.47.2023.06.01.02.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 02:59:29 -0700 (PDT)
Message-ID: <567975c4-ac55-1561-5caa-cd2db9d60d97@linaro.org>
Date:   Thu, 1 Jun 2023 11:59:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 06/20] interconnect: qcom: icc-rpm: Allow negative QoS
 offset
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <8983fc5f-b75e-3f38-577f-3c588acbe3f7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 11:56, Dmitry Baryshkov wrote:
> On 30/05/2023 13:20, Konrad Dybcio wrote:
>> In some very very very very unfortunate cases, the correct offset of
>> the QoS registers will be.. negative. One such case is MSM8998, where
>> The DDR BWMON occupies what-would-be-the-BIMC-base which we usually
>> take into account with the register calculation, making the actual
>> BIMC node start at what-would-be-the-BIMC-base+0x300.
> 
> Can we turn one of devices into a child of another device? This way we won't have to cope with negative offsets.
Let's try to get more insight how they're correlated, but that sounds
like an option.. 8996 will need this as well..

Konrad
> 
>>
>> In order to keep the calculation code sane, the simplest - however
>> ugly it may be - solution is to allow the offset to be negative.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>> index d2c04c400cad..ba840a436cc0 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.h
>> +++ b/drivers/interconnect/qcom/icc-rpm.h
>> @@ -29,10 +29,10 @@ enum qcom_icc_type {
>>    * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
>>    * @type: the ICC provider type
>>    * @regmap: regmap for QoS registers read/write access
>> - * @qos_offset: offset to QoS registers
>>    * @bus_clk_rate: bus clock rate in Hz
>>    * @bus_clks: the clk_bulk_data table of bus clocks
>>    * @intf_clks: a clk_bulk_data array of interface clocks
>> + * @qos_offset: offset to QoS registers
> 
> This can be kept in place.
> 
>>    * @keep_alive: whether to always keep a minimum vote on the bus clocks
>>    * @is_on: whether the bus is powered on
>>    */
>> @@ -42,7 +42,7 @@ struct qcom_icc_provider {
>>       int num_intf_clks;
>>       enum qcom_icc_type type;
>>       struct regmap *regmap;
>> -    unsigned int qos_offset;
>> +    int qos_offset;
>>       u64 bus_clk_rate[NUM_BUS_CLKS];
>>       struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
>>       struct clk_bulk_data *intf_clks;
>> @@ -108,7 +108,7 @@ struct qcom_icc_desc {
>>       bool no_clk_scaling;
>>       enum qcom_icc_type type;
>>       const struct regmap_config *regmap_cfg;
>> -    unsigned int qos_offset;
>> +    int qos_offset;
>>   };
>>     /* Valid for all bus types */
>>
> 
