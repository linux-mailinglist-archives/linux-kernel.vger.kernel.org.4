Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B875E70C4C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjEVSAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjEVSAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:00:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F103CF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:00:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3094910b150so5253591f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684778420; x=1687370420;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vocPlTf+ndsafl6F5PjhtF9Wtlm84gCaZwk1AEvD+Ss=;
        b=H4c1FwkLdAp3OmJc5rPt8/ZqW05C27palNnKEG0y2m2GKxeUVA3qY8m2fNUgjXCDe4
         NpcgfoLkCCD5RFUfDPrQgymfaR51wB663CutVLjI93lND/Mr0tJSYSnWUrG+F4KmcRzr
         lAOZve54WQ88cJZSn1eRC6K5QBNwcxYr6k9jfz2206lEOmivqClzjEisBiQZAHq4gejj
         e2Igtp60U4rLLIeaH2AaJ89DUmy2WirhG5sF4v3NlHq03lUJlwbZakUXZBR8pvOBne7c
         mtddh2KLOdMO347tJhgKIMgUZKGKLQGXxhaPDAa3l2cqW1I4k9Nq4gSPeltQ4fwX5FGc
         ZaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684778420; x=1687370420;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vocPlTf+ndsafl6F5PjhtF9Wtlm84gCaZwk1AEvD+Ss=;
        b=EfXjrIbTyBszY2advqedFUsS4hsjRH7zseb5K5+d2nSV+9QAUTSo7AOkXqdkAiAcsw
         NvPEK1gx/1w94nJOWYThXHVoxUPOIqFrUtsmZFZpuIfqqDmPP0gJ512K6NNlWMHpUAzs
         dxxHgPqQbRMrtgKS2xDCDgpTD5ws3NlO+1hcrPBfzw6xu3rijyFpQnHF467xZQM57NmQ
         qI7nyh+ONqSSDot6Z6u58OEWrH3lvNnU66zDGbCwP1m7lSszfiifHMAGGJ7VD02FPMUQ
         CN8Pamv9Yk8TJrd08FLCbzL7WxxNAyYRM6ZRR1CeH/sjxxpbK6s5gxHB3JROVJDtANEB
         G+3w==
X-Gm-Message-State: AC+VfDyMYm9fPeMgaVGgTNJ8NPRxaxktLS9w/DlwGqtym06ZUbHyY2pn
        PCnaNG1VV0wovhn6B0+Pzgf/VQ==
X-Google-Smtp-Source: ACHHUZ4I1Dq9nv0jiPs69KxQAtlwWmqlxEDOYy4D5O2HgeUQXRiBPn3opMwLJOxY25ymE2D+Lpwq+g==
X-Received: by 2002:a5d:4cd1:0:b0:2f6:bf04:c8cc with SMTP id c17-20020a5d4cd1000000b002f6bf04c8ccmr7525738wrt.55.1684778419889;
        Mon, 22 May 2023 11:00:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a478:d61d:5bb5:7df? ([2a01:e0a:982:cbb0:a478:d61d:5bb5:7df])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c021000b003f50d6ee334sm9035660wmi.47.2023.05.22.11.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 11:00:19 -0700 (PDT)
Message-ID: <e98e39e3-c10d-65d1-3093-2d54888b1829@linaro.org>
Date:   Mon, 22 May 2023 20:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: leds: qcom-lpg: document PM8550 compatible
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230522-topic-sm8550-upstream-pm8550-lpg-v1-1-f016578d9e63@linaro.org>
 <20230522-childhood-eastbound-06a5f02f1f4a@spud>
Organization: Linaro Developer Services
In-Reply-To: <20230522-childhood-eastbound-06a5f02f1f4a@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 19:39, Conor Dooley wrote:
> On Mon, May 22, 2023 at 06:26:01PM +0200, Neil Armstrong wrote:
>> The PM8550 PWM modules are compatible with the PM8350c PWM modules,
>> document the PM8350c PWM compatible as fallback for the PM8550 PWM.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> I suppose you picked "items/enum", rather than "items/const" to reduce
> future churn?

Yes indeed.

Thanks,
Neil

> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.
> 
>> ---
>>   .../devicetree/bindings/leds/leds-qcom-lpg.yaml    | 30 +++++++++++++---------
>>   1 file changed, 18 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
>> index 6295c91f43e8..fa378ee05c16 100644
>> --- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
>> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
>> @@ -16,18 +16,24 @@ description: >
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -      - qcom,pm660l-lpg
>> -      - qcom,pm8150b-lpg
>> -      - qcom,pm8150l-lpg
>> -      - qcom,pm8350c-pwm
>> -      - qcom,pm8916-pwm
>> -      - qcom,pm8941-lpg
>> -      - qcom,pm8994-lpg
>> -      - qcom,pmc8180c-lpg
>> -      - qcom,pmi8994-lpg
>> -      - qcom,pmi8998-lpg
>> -      - qcom,pmk8550-pwm
>> +    oneOf:
>> +      - enum:
>> +          - qcom,pm660l-lpg
>> +          - qcom,pm8150b-lpg
>> +          - qcom,pm8150l-lpg
>> +          - qcom,pm8350c-pwm
>> +          - qcom,pm8916-pwm
>> +          - qcom,pm8941-lpg
>> +          - qcom,pm8994-lpg
>> +          - qcom,pmc8180c-lpg
>> +          - qcom,pmi8994-lpg
>> +          - qcom,pmi8998-lpg
>> +          - qcom,pmk8550-pwm
>> +      - items:
>> +          - enum:
>> +              - qcom,pm8550-pwm
>> +          - const: qcom,pm8350c-pwm
>> +
>>   
>>     "#pwm-cells":
>>       const: 2
>>
>> ---
>> base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
>> change-id: 20230522-topic-sm8550-upstream-pm8550-lpg-5bf409842c3d
>>
>> Best regards,
>> -- 
>> Neil Armstrong <neil.armstrong@linaro.org>
>>

