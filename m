Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF72D6FCEF1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjEIUAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjEIUAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:00:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867A93C0B
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 13:00:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f13c577e36so6998721e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683662406; x=1686254406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kVOCE83AC4Gr91kmxIdlrW0vfunolQmhkIU/7LEMiDE=;
        b=NSrXThnpwz8+ZOFEPNw+j54wWZw7gB2eE9Van5BJqd/Cz3HrmHy0NXEC90QlkYTeS9
         IcT557kLFTiOkgt/76f+xT/Gg1IZoxLgsK413vjUSU1lioKNML81JYd/yV32t1KS7Dhx
         iBh+uA7Ftb4Po7J7SSqGIkVbdTfuia5fBt3zpdFV59fO/zKlV8gz24KLcjpVUNx7N665
         1WoS0kep/R8TGFrknEmtymbEDZ4HnHy1mrUZsJYEkgavgRiOFJQ7sWsc/Z1YcNhY28cq
         SnImENNqDhvY1gWFH2hmlTCms/bAPLh2qe5pk3PUKJotKFBXVzaJ46GmE1hXeYCTDbM2
         c6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683662406; x=1686254406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVOCE83AC4Gr91kmxIdlrW0vfunolQmhkIU/7LEMiDE=;
        b=GkI3I1Quyq6RHZ4NlJO+t2Pi2T3fhXb6VzVTKOqOd2Ip4OLGH5hBK799jzGqRs11zT
         rkAKNdmtHx59e90F8gIimR6HKeiuAGK7Sf+JnbOxmdqpMtYVO4JLgV6ngMafXHpMoQkE
         rE3UgPm5LVWTz0Sn7aXcDmVlfrZmIVN2AcZJbIXamkoH7It3t3PHHrodINVHExwS9+2q
         mYnXwMNQUpaGG/9EOvZ/pkW+fd4Ui6Yt9o4jWTpgCJSeSSB3Usbe7TwbR3W1IdmMC29F
         SWv9DwnKnSGKoQ9FbSnwo5fgoFLGmGdzRJi3EU14SZz5q3XbYO7/xvo4yCJxRE0+skMs
         fs9A==
X-Gm-Message-State: AC+VfDxFweJHhZC06zd/eaQe7ZwyYL86ElPlsL7YtPjwb8lY18c13Lp/
        9z4G7PgzcfQeDQEGNOKHkv461g==
X-Google-Smtp-Source: ACHHUZ6qzrmG/Y537HA1L9EPntjH1URRCnYapiYRs8xzhJtOeE/NQ7s6NscPh1CMAuIhRORb0KHxNw==
X-Received: by 2002:ac2:5389:0:b0:4e9:afb3:d56a with SMTP id g9-20020ac25389000000b004e9afb3d56amr1216663lfh.7.1683662405724;
        Tue, 09 May 2023 13:00:05 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id c14-20020a19760e000000b004efe6c36135sm444273lff.299.2023.05.09.13.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 13:00:05 -0700 (PDT)
Message-ID: <bac82710-da26-7acf-4375-5c5346c01705@linaro.org>
Date:   Tue, 9 May 2023 22:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/6] dt-bindings: sram: qcom,ocmem: Add msm8226 support
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
 <20230506-msm8226-ocmem-v1-4-3e24e2724f01@z3ntu.xyz>
 <29d1d210-8752-56b4-34be-8b078c639d36@linaro.org>
 <2449951.tdWV9SEqCh@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2449951.tdWV9SEqCh@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.05.2023 18:44, Luca Weiss wrote:
> On Montag, 8. Mai 2023 09:39:22 CEST Konrad Dybcio wrote:
>> On 7.05.2023 11:12, Luca Weiss wrote:
>>> Add the compatible for the OCMEM found on msm8226 which compared to
>>> msm8974 only has a core clock and no iface clock.
>>>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>> ---
>>>
>>>  Documentation/devicetree/bindings/sram/qcom,ocmem.yaml | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
>>> b/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml index
>>> 4bbf6db0b6bd..515f0d8ec641 100644
>>> --- a/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
>>> +++ b/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
>>> @@ -15,7 +15,9 @@ description: |
>>>
>>>  properties:
>>>    compatible:
>>> -    const: qcom,msm8974-ocmem
>>> +    enum:
>>> +      - qcom,msm8226-ocmem
>>> +      - qcom,msm8974-ocmem
>>
>> Any chance you could read the revision field on both and add comments
>> like:
>>
>> - qcom,msm8974-ocmem # vX.Y
> 
> Do you mean the OCMEM_REG_HW_VERSION register?
Yep

It's currently not read in the 
> driver so no idea what the value is - without adding some code.
Would be appreciated!

Konrad
> 
>>
>>>    reg:
>>>      items:
>>> @@ -28,11 +30,13 @@ properties:
>>>        - const: mem
>>>    
>>>    clocks:
>>> +    minItems: 1
>>>
>>>      items:
>>>        - description: Core clock
>>>        - description: Interface clock
>>
>> allOf: if: properties: compatible: 8974 / then: clock(s|-names): minItems: 2
> 
> Sure, can update
> 
>>
>> Konrad
>>
>>>    clock-names:
>>> +    minItems: 1
>>>
>>>      items:
>>>        - const: core
>>>        - const: iface
> 
> 
> 
> 
