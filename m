Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583576F406A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjEBJvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 05:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEBJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:51:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A947F4EC1
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 02:51:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4efef769000so4189288e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683021070; x=1685613070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ISfxy3TIk1ORc/cv1sFnzJ4olGTsOo6jcJ+Sq1T2W0g=;
        b=B1EF0E1ua1dAuH6Q/YN6bj0ttqgWp/zYgqD/CisAs/GxAZIbTAIU5CNI1rcOTooU1V
         ttb0l+WbnCHrYLSGJGFEU8nfjDA52kSukytyW+5XBbzYrd7rLgUBnRxzVWjuTI8Y5yfU
         KnM1FyN12P5wY55Jp+yWNE/waOaIVuE/utTxKnEdbYhQ+jLAueb61nznk9pC0fudPBME
         Wp1ZRBFiEKACMdq6AERons54Gw06Cx2k3k/nJz261qfFijEI75E5C/+2t5/lk6DthUXw
         0TNN7DALEqbopt73Cew3O/NzM/4GuVSSvjMpaKRmF2hNkm+EMYkxY+XQ1l9EoEbz+uaS
         6+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683021070; x=1685613070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISfxy3TIk1ORc/cv1sFnzJ4olGTsOo6jcJ+Sq1T2W0g=;
        b=J4T+7sBIxa67zJMCUEW/kYIfNFNy7Joaj0OpMl/lTweI5tcmEfyyKsAnr+9HABgGBo
         8wCu1DlzrYt6pMVnSDtijlIw/Q0+iJZ+Y9MLJdIfZue59bImxm0puE6i6dR0QfAjv8lG
         00mLw3k43+gUyTFAnDnuigmDB88fK9ekrSpa/+yqm02+1XQBi1m/p+JWhHHVQTldkZc5
         JANROuHpH3PQP+qzXrCElGwaBRtOeLa44gmLZv3JgDbZ5filmKAYz08jz/faTRoKvfG/
         pYjq33EroeOtqJQMLjBgdteHdm3E7y7Gl2FJW3Cw2BSJPiIHf7k5lEiOrbfBQRtvUXwR
         qniw==
X-Gm-Message-State: AC+VfDyTXRMD9677txnRwQcfx0UIx6kSuXdNjQADCzlsJMzofEf+YyaH
        6vPeJti6Oy+LznANCmXyeHGsng==
X-Google-Smtp-Source: ACHHUZ5s47ihrtSackfLwNUadOH90gQ7rvImJYEuCX8JGHVae4nGKhXsxgmLhKA/sREFyv4Xbypqag==
X-Received: by 2002:ac2:5284:0:b0:4ed:b842:3a99 with SMTP id q4-20020ac25284000000b004edb8423a99mr5240322lfm.59.1683021069928;
        Tue, 02 May 2023 02:51:09 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id a6-20020ac25206000000b004eff6dd9072sm3620888lfl.111.2023.05.02.02.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 02:51:09 -0700 (PDT)
Message-ID: <4bfcbde3-c9e1-65a9-4494-3d9bb222a89f@linaro.org>
Date:   Tue, 2 May 2023 11:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ5018
 family
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230429193336.600629-1-robimarko@gmail.com>
 <8feae59c-b762-8cc8-7aa9-237ce4af5b1e@linaro.org>
 <CAOX2RU6wwvMLgScAgtqpOuSLeaULUAet4TtjQZkWK_uwwkr2Zw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAOX2RU6wwvMLgScAgtqpOuSLeaULUAet4TtjQZkWK_uwwkr2Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.05.2023 23:22, Robert Marko wrote:
> On Mon, 1 May 2023 at 14:51, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 29.04.2023 21:33, Robert Marko wrote:
>>> Add SOC IDs for the IPQ5018 family.
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>>  include/dt-bindings/arm/qcom,ids.h | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
>>> index 802495b20276..c1283bad81e1 100644
>>> --- a/include/dt-bindings/arm/qcom,ids.h
>>> +++ b/include/dt-bindings/arm/qcom,ids.h
>>> @@ -216,6 +216,9 @@
>>>  #define QCOM_ID_SM8350                       439
>>>  #define QCOM_ID_QCM2290                      441
>>>  #define QCOM_ID_SM6115                       444
>>> +#define QCOM_ID_IPQ5010                      446
>>> +#define QCOM_ID_IPQ5018                      447
>>> +#define QCOM_ID_IPQ5028                      448
>>>  #define QCOM_ID_SC8280XP             449
>>>  #define QCOM_ID_IPQ6005                      453
>>>  #define QCOM_ID_QRB5165                      455
>>> @@ -229,6 +232,9 @@
>>>  #define QCOM_ID_SM8450_3             482
>>>  #define QCOM_ID_SC7280                       487
>>>  #define QCOM_ID_SC7180P                      495
>>> +#define QCOM_ID_IPQ5000                      503
>>
>>> +#define QCOM_ID_IPQ0509                      504
>>> +#define QCOM_ID_IPQ0518                      505
>> Are you sure these names are in tact?
> 
> Hi,
> They should be correct, I am seeing them being used downstream
> and in end products as well, IPQ0509 being one of those weird ones
> that integrate 256MB of RAM on the die as well.
Hmmm.. it's sketchy and weird-sounding, but also appealing in a way

I got caught off-guard with the leading zeroes, but probably qcom
just didn't want to mess with the IPQabcd scheme!

Konrad
> 
> Regards,
> Robert
> 
>>
>> Konrad
>>>  #define QCOM_ID_SM6375                       507
>>>  #define QCOM_ID_IPQ9514                      510
>>>  #define QCOM_ID_IPQ9550                      511
>>> @@ -236,6 +242,7 @@
>>>  #define QCOM_ID_IPQ9570                      513
>>>  #define QCOM_ID_IPQ9574                      514
>>>  #define QCOM_ID_SM8550                       519
>>> +#define QCOM_ID_IPQ5016                      520
>>>  #define QCOM_ID_IPQ9510                      521
>>>  #define QCOM_ID_QRB4210                      523
>>>  #define QCOM_ID_QRB2210                      524
>>> @@ -243,6 +250,7 @@
>>>  #define QCOM_ID_QRU1000                      539
>>>  #define QCOM_ID_QDU1000                      545
>>>  #define QCOM_ID_QDU1010                      587
>>> +#define QCOM_ID_IPQ5019                      569
>>>  #define QCOM_ID_QRU1032                      588
>>>  #define QCOM_ID_QRU1052                      589
>>>  #define QCOM_ID_QRU1062                      590
