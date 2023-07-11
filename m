Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EF774ED24
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjGKLpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjGKLou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:44:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388B8E77
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:44:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so86610671fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689075886; x=1691667886;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfdAnLkJvfu1HT+5cWY2LkYRToJ6KO6RNph1xJ8AC/8=;
        b=bkCk4hpd0e15WS1pDEaAuYezwtfAPVEz7d4dv5pnoLPxZl0S7y3imeSNVAQ24XH/vs
         cVfLFVLtEmjLVyrao9rOPnHBjLm/6/NGYGyn6oMt6d0rfO6Jg42tD7vBFUlZmuI6A1mg
         IAirZKXyiKTfL64LXwk+dyMyhkzpWgygkZ+6kuBxPwbMf9pUGSIc/ZaGVhXds8j+1suO
         2z/KQkpJqZmfZHBl+sSMT0ki6f9a++Q2DQ6oB+pYH2rB84L+P77Kiqu1lR+ZiYcPnkX6
         21TYqJTrZXH4+V5A17Nn8pXjnNxLrfGdrp5NJD7257cw1pNgfIknj2xakTSRK+JwJW7x
         V4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689075886; x=1691667886;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfdAnLkJvfu1HT+5cWY2LkYRToJ6KO6RNph1xJ8AC/8=;
        b=Q7zHZbDdqAy+wkzA7Cy7xHjzqJZb9Pca14yYHumTYCId+Cmb8prdinR7D48wVnIzZZ
         8H1t4VN6v5VGBFk/kC+yhdQurwAnqnGw9evENpJnxunWTmH0Md8fm/m/VkRdUHghMv1F
         BspdtoQ2T+4SkTz8gpwg3IEUrrVXdTUwXP5b3jvLx8ENrU0g0a6HbQjXxMB2wKQUo6K+
         9fLWfRdrtonPyvPC8BBsXKV8gzSW63U416nqY8Lgzv2yhO7yVHhOE1IABlU0HSe+R7oJ
         bgoiLotWV9kkce3Oi2smVm4rZ8bEk1fGPYRU5w2smE+00nhtiGVavvKDzcc2ppbxHI3+
         17aw==
X-Gm-Message-State: ABy/qLY3uOA2iRDqEraebvSHed73kHXUCSH4To8F3ehCuKBtnIYXFaBW
        yLiYAG9P0ccMDfcOjvt4tHq2EA==
X-Google-Smtp-Source: APBJJlFlZ/UYtlT1rTo2drhnBkR+uykhd54Vu1MRTKv+TxTzWEE8y14+HI6aZSJuEovL0Fd9z8lJ0g==
X-Received: by 2002:a05:6512:31cf:b0:4fb:94c6:fd63 with SMTP id j15-20020a05651231cf00b004fb94c6fd63mr13697628lfe.17.1689075886445;
        Tue, 11 Jul 2023 04:44:46 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id a15-20020a056512020f00b004fbc078712asm286489lfo.7.2023.07.11.04.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 04:44:46 -0700 (PDT)
Message-ID: <8c3468f0-3069-95e3-e2f1-279fca78a578@linaro.org>
Date:   Tue, 11 Jul 2023 13:44:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/3] dt-bindings: power: rpmhpd: Add Generic RPMh PD
 indexes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1689054169-10800-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689054169-10800-2-git-send-email-quic_rohiagar@quicinc.com>
 <2040226e-9b45-b409-3edd-a5b86d86daa8@linaro.org>
 <8a3124ce-a11d-2491-eaee-1695cec70b17@quicinc.com>
 <e885383b-a231-75a1-32ce-bf850f0cb022@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <e885383b-a231-75a1-32ce-bf850f0cb022@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.2023 08:22, Krzysztof Kozlowski wrote:
> On 11/07/2023 08:17, Rohit Agarwal wrote:
>>
>> On 7/11/2023 11:22 AM, Krzysztof Kozlowski wrote:
>>> On 11/07/2023 07:42, Rohit Agarwal wrote:
>>>> Add Generic RPMh Power Domain indexes that can be used
>>>> for all the Qualcomm SoC henceforth.
>>>>
>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>   include/dt-bindings/power/qcom-rpmhpd.h | 30 ++++++++++++++++++++++++++++++
>>>>   1 file changed, 30 insertions(+)
>>>>   create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h
>>>>
>>>> diff --git a/include/dt-bindings/power/qcom-rpmhpd.h b/include/dt-bindings/power/qcom-rpmhpd.h
>>>> new file mode 100644
>>>> index 0000000..4da2e04
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/power/qcom-rpmhpd.h
>>> Filename based on compatible.
>> This is not specific for SDX75. These are generic ones that should be 
>> used for all other targets.
>> Konrad suggested in v1 to avoid target specific prefixes everytime and 
>> to create a new generic
>> dt-bindings that can be reused.
>>>> @@ -0,0 +1,30 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>> +/*
>>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#ifndef _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>>>> +#define _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>>>> +
>>>> +/* Generic RPMH Power Domain Indexes */
>>>> +#define CX               0
>>> These are very generic names, usually not used in global headers. Please
>>> use some reasonable prefix.
>> This was based on the suggestion from Konrad in v2 to drop the RPMHPD 
>> prefix and we can go only with names like CX, etc.
> 
> I don't think having so generic name in tree-wide header is good idea.
Conversely, I think that it would be very clear in files including this header.

Konrad
> CX can mean anything.
> 
> Best regards,
> Krzysztof
> 
