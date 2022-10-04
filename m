Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD615F4022
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiJDJob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiJDJnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:43:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EB8580A6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:41:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w18so11708739wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=jzoc8wW8XTFhrV/IZ7QAB+mjMgHP5TfH+9jpihMeYPE=;
        b=ZOtMwZ6g1s7UM7wXvZ9BlbxpYf9EeU+2yYMvhaIZB3bikVcjCh6eTiusAKZ3XLdkKG
         GR1K9zSCTyNziogb2jhkBkSWgCP09GD9pDr9q2ZcrubyAIyhIwu1lrAsnjRtvm8HuSi7
         mx6rsa/3cxPggjFGWPN4z6e3psD0jMFH4DWKxlPa4c9KmbNrN1vZlhvV1uPcSY7d4boS
         YkiZh4PqN576hTsrHik9gYe1ZZRXPGT4a6PMg0D7hsMFXdaBdAgmjrdC+8lv+9Bt3JZe
         VMsUbfTzP5kfP18E+lMxaEUR5fWqtj++0usV9+2bV/6EzRWoAsZ056/Pa5rEJNmMW0vh
         JdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=jzoc8wW8XTFhrV/IZ7QAB+mjMgHP5TfH+9jpihMeYPE=;
        b=TvMEAY1wIkd8bgfPmIgIdvWGNZJMPs/8qkPUzx9ool9dklibC7Wvv4EOmxmEQeTWr+
         22UjcjzF1U5YeC+E/gtuG3mNj5yuJ5tTQyPFg0wCyJAfR0wF2PrQxG9W6Ix692YGLJ7n
         PwH8JPQKXMxM3Uj4ZwZD+TuvYpismD28z7rF15CB+afWc9tGSwWe55SjEthKGE3jGjUn
         /QHvTaXFl2U9gWuELlIpetjPo7extatWZDmkwpKKxVRGwjKfJksOlx/mLn5CnOrxqr9/
         XEDDkAojeoqTvS1vYwXS/G7GQz9DfHURKzfXHnw214yIlnX1dR4xx7sLPxxAgSQP7kvw
         pHBg==
X-Gm-Message-State: ACrzQf0j/+8R/1LWaonRTPIuzJv7TXXXEq/+uIsMxkijNKQ7SbnrLRWa
        6kZ4xcZOtmycIVNtafmrsBJW4A==
X-Google-Smtp-Source: AMsMyM7vylXcYmjvJdGkRJXBVofcAC43DX1ZM9R/bfcZybTrm4yczJX3SZmTEgclfoplWAgrtsmwSA==
X-Received: by 2002:a5d:64cf:0:b0:22a:b61d:875e with SMTP id f15-20020a5d64cf000000b0022ab61d875emr14907337wri.100.1664876462728;
        Tue, 04 Oct 2022 02:41:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:58f1:548b:1390:4070? ([2a01:e0a:982:cbb0:58f1:548b:1390:4070])
        by smtp.gmail.com with ESMTPSA id x16-20020adfec10000000b0022a2dbc80fdsm12064363wrn.10.2022.10.04.02.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:41:02 -0700 (PDT)
Message-ID: <e21f49b7-4a44-c016-0e52-3ab018978f31@linaro.org>
Date:   Tue, 4 Oct 2022 11:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 06/11] dt-bindings: input: qcom,pm8921-pwrkey: convert
 to dt-schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v2-6-87fbeb4ae053@linaro.org>
 <91630a1c-c4bf-357f-20f3-8176bd91bdf6@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <91630a1c-c4bf-357f-20f3-8176bd91bdf6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/10/2022 10:59, Krzysztof Kozlowski wrote:
> On 04/10/2022 10:08, Neil Armstrong wrote:
>> Convert input/qcom,pm8xxx-pwrkey.txt to YAML, and take in account that
>> the PM8921 pwrkey compatible is used as fallback for the PM8018 pwrkey.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
> 
> You miss diffstat... but I guess it's result of b4?

Yep, I'll update with last release to get it back.

> 
>> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8921-pwrkey.yaml b/Documentation/devicetree/bindings/input/qcom,pm8921-pwrkey.yaml
>> new file mode 100644
>> index 000000000000..ae38c4ef4932
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/qcom,pm8921-pwrkey.yaml
>> @@ -0,0 +1,77 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/input/qcom,pm8921-pwrkey.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm PM8921 PMIC Power Key
>> +
>> +maintainers:
>> +  - Andy Gross <agross@kernel.org>
>> +  - Bjorn Andersson <andersson@kernel.org>
> 
> Keep only Bjorn. Andy did not review much for some time.

Ack

> 
>> +
>> +allOf:
>> +  - $ref: input.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +          - qcom,pm8921-pwrkey
>> +          - qcom,pm8058-pwrkey
>> +      - items:
>> +          - enum:
>> +              - qcom,pm8018-pwrkey
>> +          - const: qcom,pm8921-pwrkey
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 2
>> +    description: |
>> +          The first interrupt specifies the key release interrupt
>> +          and the second interrupt specifies the key press interrupt.
> 
> In such case better to drop maxItems and description and write it:
> 
> items:
>    - description: key release interrupt
>    - description: key press interrupt
> 
> (maybe even the "interrupt" word could be skipped...)

Ack, will do that without the interrupt word

> 
>> +
>> +  debounce:
>> +    description: |
>> +          Time in microseconds that key must be pressed or
>> +          released for state change interrupt to trigger.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  pull-up:
>> +    description: |
>> +           Presence of this property indicates that the KPDPWR_N
>> +           pin should be configured for pull up.
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +   #include <dt-bindings/interrupt-controller/irq.h>
>> +   ssbi {
>> +   #address-cells = <1>;
>> +   #size-cells = <0>;
> 
> Messed indentation.
>> +
>> +     pmic@0 {
>> +       reg = <0x0>;
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +
>> +       pwrkey@1c {
>> +          compatible = "qcom,pm8921-pwrkey";
> 
> Messed up indentation. For entire DTS example keep 2 or 4 spaces.
> 
>> +          reg = <0x1c>;
>> +          interrupt-parent = <&pmicint>;
>> +          interrupts = <50 1>, <51 1>;
> 
> Use defines for interrupt flags.
> 
>> +          debounce = <15625>;
>> +          pull-up;
>> +       };
>> +     };
>> +   };

Will fix the example,

> 
> Best regards,
> Krzysztof
> 

Thanks,
Neil
