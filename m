Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE8A7502F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjGLJXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjGLJWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:22:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FC1212E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:22:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso10574826e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689153723; x=1691745723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NjGqRq5zWFdsly/kg1kDssbJCalEae2wRAUaYUdM+g=;
        b=htcZzW1OS/gE5qeL+aoGVb+2cnRqTmLWUBuKnWqAyaELuoRXnlY54d5Gk83+MQxl7z
         dOZuI3IYpxR2VjlVQ18FNEf/0F2Ti57PekZn8/vYah4HtK60xcb5/z5H1qqfyVMsZjR4
         E2sEvVNJoDfjd4WaHC0+G+55hrvSO4AOB+jqCgzok1wDaKTmh7DfIj6HmyoXGJ+nelAr
         f3NZOP0q2/UmM/ex2LQHDpoe8erPK8XZKAJNQQ8CJIJ04xtdqeJf9qqG7b0ib8lTo639
         1sS6yx4//OVp6dpbnWYKfNd9ckc0e3n1yPimpSAPq7OaSqvH4Q5Gy1oUoUngzlam9jTI
         Wffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689153723; x=1691745723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NjGqRq5zWFdsly/kg1kDssbJCalEae2wRAUaYUdM+g=;
        b=F2i+S/UiyYBbozsznjxZcrQhFoTucOwIs33Lgcv/NV4V6Q3F/l14rV+RCoSNdWStfn
         gr8R+nFncf+0kW39awXiZ+GcKoOoQyPowERsV1eOOP2SlhMX6efqgHwze8eayvUFaGv0
         QM7Nf6IOvGaFxiz3dX5P2dzUYXzchll435zDD6pA+QRaZ7s3FG7ceUxSLcCx6pKNCVKz
         goMq6v0+XKn09Xitb4rKT307hX1Nbf+A1iG1guzOHBJtNuYp7EENM9UyzbWlXpFFOLwO
         3cltcT0DnfVQkfrBXMuu2s0k4Me+5MPvfjp1BYwmy7xCJ7brwYHwcDUYIIFEjUS+veFO
         hNrA==
X-Gm-Message-State: ABy/qLaooNGIXgdJ0si1RMrEoobpSYEpVTMANCpY4w5dRALfaVgHCsJI
        RXp60989Rd/aW7xuEcWJOyEhGA==
X-Google-Smtp-Source: APBJJlEaxJehnHDdYGksUXZVL4/FaFAeZB6Ghl/w8pfsxWfXUSB5H2x9pQGJSkSWkSc2kuQ9f9tb+Q==
X-Received: by 2002:a05:6512:2025:b0:4f8:6625:f2ca with SMTP id s5-20020a056512202500b004f86625f2camr13186563lfs.61.1689153723165;
        Wed, 12 Jul 2023 02:22:03 -0700 (PDT)
Received: from [192.168.1.101] (abxh6.neoplus.adsl.tpnet.pl. [83.9.1.6])
        by smtp.gmail.com with ESMTPSA id u22-20020ac243d6000000b004fbbf9e58bbsm621222lfl.126.2023.07.12.02.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 02:22:02 -0700 (PDT)
Message-ID: <af0e1e5f-c284-a33a-7626-f143b1a4b30e@linaro.org>
Date:   Wed, 12 Jul 2023 11:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/3] dt-bindings: power: rpmhpd: Add Generic RPMh PD
 indexes
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1689054169-10800-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689054169-10800-2-git-send-email-quic_rohiagar@quicinc.com>
 <6746ceb6-dac4-ee8e-411f-8de0ff8f12e0@linaro.org>
 <77991119-a200-fbfe-5dba-580a0b0d3228@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <77991119-a200-fbfe-5dba-580a0b0d3228@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.2023 10:24, Rohit Agarwal wrote:
> 
> On 7/11/2023 8:41 PM, Dmitry Baryshkov wrote:
>> On 11/07/2023 08:42, Rohit Agarwal wrote:
>>> Add Generic RPMh Power Domain indexes that can be used
>>> for all the Qualcomm SoC henceforth.
>>>
>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   include/dt-bindings/power/qcom-rpmhpd.h | 30 ++++++++++++++++++++++++++++++
>>>   1 file changed, 30 insertions(+)
>>>   create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h
>>>
>>> diff --git a/include/dt-bindings/power/qcom-rpmhpd.h b/include/dt-bindings/power/qcom-rpmhpd.h
>>> new file mode 100644
>>> index 0000000..4da2e04
>>> --- /dev/null
>>> +++ b/include/dt-bindings/power/qcom-rpmhpd.h
>>> @@ -0,0 +1,30 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>> +/*
>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +#ifndef _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>>> +#define _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>>> +
>>> +/* Generic RPMH Power Domain Indexes */
>>> +#define CX               0
>>> +#define MX               1
>>> +#define CX_AO            2
>>> +#define MX_AO            3
>>> +#define GFX              4
>>> +#define MSS              5
>>> +#define EBI              6
>>> +#define LCX              7
>>> +#define LMX              8
>>> +#define MMCX             9
>>> +#define MMCX_AO          10
>>> +#define MXC              11
>>> +#define MXC_AO           12
>>> +#define NSP              13
>>> +#define NSP0             14
>>> +#define NSP1             15
>>> +#define QPHY             16
>>> +#define DDR              17
>>> +#define XO               18
>>
>> I went through the existing defines. If we adopt the order of defines for sm8550, we can migrate that platform and all of sm8[234]50 without breaking ABI. This would be a minor gain, but still something.
>>
> Actually, I added them in the sequence based on the frequency with which they occur in the driver, so that there are less NULL entries created for any target additions. Shouldnt we keep it this way and ignore for previous targets then?
Don't bother yourself with this, we've already dragged you through
some bindings mess ;)

Dmitry just noticed that a happy coincidence occured and we could
swap out SM8[234]_50 indices with these ones and they would still
match. It'd be a separate patch though.

Konrad
> 
> Thanks,
> Rohit.
>>> +
>>> +#endif
>>
