Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915B762D693
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbiKQJWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbiKQJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:22:16 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355B96D4B9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:22:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id z14so2722302wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L6m78l9IaVxaTvBMu17pNeI8t9aYUg1HUks8PTQkt/w=;
        b=cU1u5TeUd7pXtv5hfYqYwWEm56Vzet0MEwXKsY4rM0tRmCgiWW9gOxeJkaKg+zgBvj
         2gO7twkpElxkZeKN6JEkwdlkOXwPCkn84qYMWfArb1klRtgB7p5CCmHUdgUn6d19NCWf
         y/XLzgbIA/Ehqoa0Pd9qJepq23hfJWoVbWfzuYwWp/uiJNwYJrv2xC6xRh5/kEdZKpiO
         TWb7v8XDQ1F7VFH44AOueCD3BR5pOKcQx7sPp43EnYrBuoVQXQEj0TmtfJSPmfsuKVGL
         jmLLJIS/SPaJb3BlYisUKN0E7ugYTW3l1mGd8cwTiT5bEculvCduqpTyaMN+R0BXrZ4C
         NwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6m78l9IaVxaTvBMu17pNeI8t9aYUg1HUks8PTQkt/w=;
        b=orYih7wsLne/Cr4uyQaHwDVHNL3fvL58wOg7++NHfJv/kc/AN5XoFLdggzV+/J81py
         Fqu1puoFEupd9+w+iVi1S1cTDFjqk/2DioJtSGG+K06JHerez2a+9+XjZOYhMqMSwwnH
         x0kwB/6nd8aunw5lWINhxrmPnVpyy4DPA+p1Phy9pRjKwurqyeIZBCcwyNIH3/seHvHa
         L2Re7ePKsTAUQKi/H7pasFzL2CR+ZrcbpXdJox/dvQN3uKE3D2l76ub7XoLJVoumf3BO
         XmvKA9svPoaPbNtqyjrfiltftRv8gqB08h3WduP8bJoxo2ddf+KBSCRayoZDDnAF/1z5
         Zw3g==
X-Gm-Message-State: ANoB5plPS2ig0dmsMWv+kjNpZE2X9GnYn6M2QpfVERjTl+MzP4N1APCP
        YPLW4lBkkvHep2OdZeLu1Jq5GA==
X-Google-Smtp-Source: AA0mqf4kcCGxig0Fs7BJ8ojQf85ICkT2DwH/9eVOjQKcfvTKcu8DcroaUciX2+T3bCRMzxNZzUZAJg==
X-Received: by 2002:a5d:4241:0:b0:236:57cf:1b6f with SMTP id s1-20020a5d4241000000b0023657cf1b6fmr917387wrr.153.1668676932728;
        Thu, 17 Nov 2022 01:22:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:aad5:8d14:a22f:2e8b? ([2a01:e0a:982:cbb0:aad5:8d14:a22f:2e8b])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c3b8e00b003b4c979e6bcsm5529516wms.10.2022.11.17.01.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 01:22:12 -0800 (PST)
Message-ID: <daa4b852-5452-9363-3bc8-16a7637cc8bb@linaro.org>
Date:   Thu, 17 Nov 2022 10:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/4] dt-bindings: remoteproc: qcom: adsp: document sm8550
 adsp, cdsp & mpss compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v1-0-104c34cb3b91@linaro.org>
 <20221114-narmstrong-sm8550-upstream-remoteproc-v1-1-104c34cb3b91@linaro.org>
 <b6eac577-f3a7-d1a4-f492-74782c2e5ff1@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <b6eac577-f3a7-d1a4-f492-74782c2e5ff1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 13:28, Krzysztof Kozlowski wrote:
> On 16/11/2022 11:20, Neil Armstrong wrote:
>> This documents the compatible for the component used to boot the
>> aDSP, cDSP and MPSS on the SM8550 SoC.
>>
>> The SM8550 boot process on SM8550 now requires a secondary "Devicetree"
>> firmware to be passed along the main Firmware, and the cDSP a new power
>> domain named "NSP".
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../devicetree/bindings/remoteproc/qcom,adsp.yaml  | 60 +++++++++++++++++++++-
>>   1 file changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
>> index db9e0f0c2bea..678cb73f10de 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
>> @@ -55,6 +55,9 @@ properties:
>>         - qcom,sm8450-cdsp-pas
>>         - qcom,sm8450-mpss-pas
>>         - qcom,sm8450-slpi-pas
>> +      - qcom,sm8550-adsp-pas
>> +      - qcom,sm8550-cdsp-pas
>> +      - qcom,sm8550-mpss-pas
>>   
>>     reg:
>>       maxItems: 1
>> @@ -116,8 +119,13 @@ properties:
>>       $ref: /schemas/types.yaml#/definitions/string
>>       description: Firmware name for the Hexagon core
>>   
>> +  qcom,dtb-firmware-name:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: Devicetree Firmware name for the Hexagon core
> 
> Not sure about this one.
> 
> Rob,
> Don't we want rather to have multiple items in firmware-name?
> 
> 
>> +
>>     memory-region:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
>>       description: Reference to the reserved-memory for the Hexagon core
>>   
>>     qcom,qmp:
>> @@ -212,6 +220,9 @@ allOf:
>>                 - qcom,sm8450-cdsp-pas
>>                 - qcom,sm8450-slpi-pas
>>                 - qcom,sm8450-mpss-pas
>> +              - qcom,sm8550-adsp-pas
>> +              - qcom,sm8550-cdsp-pas
>> +              - qcom,sm8550-mpss-pas
>>       then:
>>         properties:
>>           clocks:
>> @@ -327,6 +338,8 @@ allOf:
>>                 - qcom,sm8450-adsp-pas
>>                 - qcom,sm8450-cdsp-pas
>>                 - qcom,sm8450-slpi-pas
>> +              - qcom,sm8550-adsp-pas
>> +              - qcom,sm8550-cdsp-pas
>>       then:
>>         properties:
>>           interrupts:
>> @@ -347,6 +360,7 @@ allOf:
>>                 - qcom,sm8150-mpss-pas
>>                 - qcom,sm8350-mpss-pas
>>                 - qcom,sm8450-mpss-pas
>> +              - qcom,sm8550-mpss-pas
>>       then:
>>         properties:
>>           interrupts:
>> @@ -448,6 +462,7 @@ allOf:
>>                 - qcom,sm8150-mpss-pas
>>                 - qcom,sm8350-mpss-pas
>>                 - qcom,sm8450-mpss-pas
>> +              - qcom,sm8550-mpss-pas
>>       then:
>>         properties:
>>           power-domains:
>> @@ -475,6 +490,7 @@ allOf:
>>                 - qcom,sm8350-slpi-pas
>>                 - qcom,sm8450-adsp-pas
>>                 - qcom,sm8450-slpi-pas
>> +              - qcom,sm8550-adsp-pas
>>       then:
>>         properties:
>>           power-domains:
>> @@ -504,6 +520,25 @@ allOf:
>>               - const: cx
>>               - const: mxc
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sm8550-cdsp-pas
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          items:
>> +            - description: CX power domain
>> +            - description: MXC power domain
>> +            - description: NSP power domain
>> +        power-domain-names:
>> +          items:
>> +            - const: cx
>> +            - const: mxc
>> +            - const: nsp
>> +
> 
> You also need to update entry for resets. I think it is missing.

Hmm no, no resets needed for sm8550.

> 
>>     - if:
>>         properties:
>>           compatible:
>> @@ -573,6 +608,29 @@ allOf:
>>         properties:
>>           qcom,qmp: false
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sm8550-adsp-pas
>> +              - qcom,sm8550-cdsp-pas
>> +              - qcom,sm8550-mpss-pas
>> +    then:
>> +      properties:
>> +        memory-region:
>> +          minItems: 2
>> +          description:
>> +            First entry is a phandle for a reserved memory area that holds
>> +            the main Firmware for authentication, and second entry a phandle for a
>> +            reserved memory area that holds the Devicetree Firmware for authentication.
> 
> Instead of minItems and description:
>    items:
>      - description: Main Firmware for auth....
>      - description: Devicetree Firmware....

Ack

> 
>> +    else:
>> +      properties:
>> +        qcom,dtb-firmware-name: false
>> +
>> +        memory-region:
>> +          maxItems: 1
>> +

I'll rebase on top of 20221116155416.164239-1-krzysztof.kozlowski@linaro.org.

Seems I should perhaps add a separate qcom,sm8550-pas.yaml right, or adding the qcom,sm6350-pas.yam would be ok ?

> 
> Best regards,
> Krzysztof
> 

Thanks,
Neil

