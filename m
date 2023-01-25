Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7528D67BF8C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjAYWFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjAYWFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:05:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC1A46160
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:05:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v10so221542edi.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKFA19R6xv2eymSUsNElEgL5ULZ+IvWXQQkJeAKXWVk=;
        b=Mv922n4G+JBjWDAthtVTqODJI6w1dOPq/YvqZMHNFTXZyw/hFSs42eLyj+18CT3xoz
         IxSSgNi1jq6/WWvMdECZPSqI5nFfQwSGHXyvi5VLgp4b9m8oINijX6hrUbIee1VuEl+B
         R2gN1m3eOBw7XlBS4KGcEOucAbqrR59FWB6toRnHP/dDWdwTYotvXJE+AO3mpeE4WcmK
         OkThC3RzV6NnwiV09T+bcfkZr5PthUVwgXSj1B9U7z245xtFojcJ4oHc2qLkWtJv5Z+U
         bTALDK+gAM2Z/XzFrSIZRVJM0Ck/4s4UuJDPmWSPMQy7CRB3WwNEF5H+QPcTNNSWxGFY
         KKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKFA19R6xv2eymSUsNElEgL5ULZ+IvWXQQkJeAKXWVk=;
        b=foN2uCM+tOB1DUZyRgqjIyxoSrbvGkbnSOCi5Ujb7PK9VXqwCA4reSmd30n9Pq1mQu
         LkYfbLW3BMFycaIOxL74+Go1T+KGA72xXS0T1GQ43DmDjys1/wS/yR5cZi10jyKgkXF3
         jJ0CIew6hCeW/+ga5Y8s/Pmc4UC0ufscRwmyPtrqoRyewjwA30DXO1Z/AmrH89PHOqwU
         ESYE7a+ivn8j9g/h2ez2ZuwJNCE2MrJz9QjnPK1r6+az4Nw/FuT1QCvatIy9AvN3xqSx
         rJBdg4DaLxH+5wJB1+sZXldFf3kX9TYTBcKV2AbaYEQPBlzq/UmLCUb4hTRSBFeqW3eB
         4M4Q==
X-Gm-Message-State: AFqh2kpbUgWKvk3b54Df3LZxPgjTyI4w3BsfF3vHrqlsklZ17FZOBezX
        AtCyS/gs72K8FRE5QzaKV+9SpA==
X-Google-Smtp-Source: AMrXdXte6HidAfuRLRPGrzkYFjXGReU+SQgPe2DkHhMIRxDK8wTCY04tVP73Wx4a4BoX1D03IP2SWw==
X-Received: by 2002:aa7:c619:0:b0:49e:6e34:c363 with SMTP id h25-20020aa7c619000000b0049e6e34c363mr26774712edq.35.1674684329832;
        Wed, 25 Jan 2023 14:05:29 -0800 (PST)
Received: from [192.168.1.101] (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id cy5-20020a0564021c8500b0049ef56c01d0sm2871624edb.79.2023.01.25.14.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 14:05:29 -0800 (PST)
Message-ID: <df133e5a-8030-0774-091c-6f8e0692e945@linaro.org>
Date:   Wed, 25 Jan 2023 23:05:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 7/7] clk: qcom: add the driver for the MSM8996 APCS
 clocks
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org>
 <20230118132254.2356209-8-dmitry.baryshkov@linaro.org>
 <7055af43f4a8894ac34e53c5847fb3de.sboyd@kernel.org>
 <63f017c7-d320-a996-7bda-33d263a847bc@linaro.org>
 <525ef5cdefe987c3412249760324eb09.sboyd@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <525ef5cdefe987c3412249760324eb09.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.01.2023 22:56, Stephen Boyd wrote:
> Quoting Konrad Dybcio (2023-01-25 13:48:54)
>>
>>
>> On 25.01.2023 22:38, Stephen Boyd wrote:
>>> Quoting Dmitry Baryshkov (2023-01-18 05:22:54)
>>>> diff --git a/drivers/clk/qcom/apcs-msm8996.c b/drivers/clk/qcom/apcs-msm8996.c
>>>> new file mode 100644
>>>> index 000000000000..7e46ea8ed444
>>>> --- /dev/null
>>>> +++ b/drivers/clk/qcom/apcs-msm8996.c
>>>> @@ -0,0 +1,76 @@
>>> [...]
>>>> +
>>>> +static int qcom_apcs_msm8996_clk_probe(struct platform_device *pdev)
>>>> +{
>>>> +       struct device *dev = &pdev->dev;
>>>> +       struct device *parent = dev->parent;
>>>> +       struct regmap *regmap;
>>>> +       struct clk_hw *hw;
>>>> +       unsigned int val;
>>>> +       int ret = -ENODEV;
>>>> +
>>>> +       regmap = dev_get_regmap(parent, NULL);
>>>> +       if (!regmap) {
>>>> +               dev_err(dev, "failed to get regmap: %d\n", ret);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       regmap_read(regmap, APCS_AUX_OFFSET, &val);
>>>> +       regmap_update_bits(regmap, APCS_AUX_OFFSET, APCS_AUX_DIV_MASK,
>>>> +                          FIELD_PREP(APCS_AUX_DIV_MASK, APCS_AUX_DIV_2));
>>>> +
>>>> +       /* Hardware mandated delay */
>>>
>>> Delay for what? Setting the divider? What if the register value didn't
>>> change at all? Can you skip the delay in that case?
>> Waiting 5 us unconditionally in exchange for ensured CPU clock
>> source stability sounds like a rather fair deal.. Checking if
>> the register value changed would not save us much time..
> 
> So it is waiting for the CPU clk to be stable? The comment is not clear.
Okay, so perhaps this is just a misunderstanding because of a lackluster
comment.. This SYS_APCS_AUX (provided by this driver) is one of the CPU
clock sources (and probably the "safest" of them all, as it's fed by
GPLL0 and not the CPU PLLs) the delay is there to ensure it can
stabilize after setting the divider to DIV2. In a theoretical case, the
big 8996 cpucc driver could select this clock as a target for one (or
both) of the per-cluster muxes and it could put the CPUs in a weird state.

As unlikely as that would be, especially considering 8996 (AFAIK) doesn't
use this clock source coming out of reset / bootloader, this lets us
ensure one less thing can break.

Konrad

