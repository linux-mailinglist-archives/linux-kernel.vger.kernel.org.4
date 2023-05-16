Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16720704EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjEPNHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjEPNHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:07:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A206CFF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:06:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-966400ee79aso2189446666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684242403; x=1686834403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5v71FLoqMz+RUxDIpAMnXyAxgkejquVbG/xCAcbJdU=;
        b=M3FPgcFsAiM2X5YXNkTxJ2ewxrvUjaCL4p9om+mGfL2xhkjHLJjW/D8eoqyLBd4B1q
         VKQNDqz1BqtmFk33x5ddKE/YkFg/ZmEJ83nEKDwfa8BQ6rQLHd+TZJhqbqHQcb/VonPQ
         mmaRwInfCCyDulO9t3XuXwxQhuZwGV5l0rwuQz0+lpPFIPirRQ2N1iZ2S7dqd29GvcLQ
         nEEziAPrxXY4ZXYjYEdZTxM56Ayh6UBG7+pvxs7UcHBMWzvERXkg9rApldZDCA9MSM4b
         FO4GnMOwpJNV/Wd9IBsUAxQW5Q9OAxU6vZmMYLzzLT/dl0tFATkXvUK4rXU7qSYVH2HZ
         HPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684242403; x=1686834403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5v71FLoqMz+RUxDIpAMnXyAxgkejquVbG/xCAcbJdU=;
        b=KaDdWVIf/unTk+DsjTUTd3yQ2CRMY6xDvMjTL1NNBI6gQMJ+ezv5jy03Zh44BokfMO
         98qxVm5M+0qHt+rClQOBBGufcGWG8h5HLYPEb/fSmVcV2+47QNHZ6cfnMvSWszzQwir0
         +17euY3CWjGGSFBJ847ui4NI2+5k+CBtZBiLpa5VbPI83MRvEVXuyZ7onyZYS6xBLX6n
         vqUpZOMi/8obFdrI5NmsUX+QUCy7Zvm6WtKOkj8CsTRWwQoYb9TypC6vYFQ2YrYwohuc
         vecNcKegcSjiMXAg8GMLIyJA422cYgjdBGJR9jCDWxnedN/vRAPYS3Rj9tjrqROdGVxJ
         K7fw==
X-Gm-Message-State: AC+VfDyJ33nAmvC2TCs9xexHgqhBG9Udg16kWn7dabtAFjxQDU3GlHqT
        ysB5qqvxmVLEwnBfz7RucnLGaA==
X-Google-Smtp-Source: ACHHUZ5go4YGvwMvuHkX/P2nKXUI6kO6rJj/HD94dK8KJ24a7KSOeuUBx0cQE4d1WftX21i+qsvZFg==
X-Received: by 2002:a17:907:9444:b0:969:e304:7a22 with SMTP id dl4-20020a170907944400b00969e3047a22mr24064513ejc.18.1684242402864;
        Tue, 16 May 2023 06:06:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id bu2-20020a170906a14200b0096654fdbe34sm11074552ejb.142.2023.05.16.06.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 06:06:42 -0700 (PDT)
Message-ID: <1999753b-ceee-d66c-9a48-cbcbb8e6236e@linaro.org>
Date:   Tue, 16 May 2023 15:06:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/4] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1684140883.git.quic_varada@quicinc.com>
 <37adcf5d8d545a076e8ed971a4fb6c6c2833ef3c.1684140883.git.quic_varada@quicinc.com>
 <b7e749ff-f4f0-0e61-9aae-876db4278fbc@linaro.org>
 <20230516120426.GA1679@varda-linux.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516120426.GA1679@varda-linux.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 14:04, Varadarajan Narayanan wrote:
> On Mon, May 15, 2023 at 06:10:29PM +0200, Krzysztof Kozlowski wrote:
>> On 15/05/2023 12:13, Varadarajan Narayanan wrote:
>>> From: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>
>>> Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.
>>>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---
>>> [v3]:
>>> 	Fix dt_binding_check & dtbs_check errors (Used
>>> 	Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
>>> 	as reference/example)
>>>
>>> 	Drop 'Acked-by: Rob Herring' as suggested in review
>>>
>>> [v2]:
>>> 	Thanks to Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> 	for the tip to make qcom,ipq8074-tsens as fallback.
>>> ---
>>>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 13 +++++++++++--
>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> index d9aa54c..57e3908 100644
>>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> @@ -19,6 +19,11 @@ description: |
>>>  properties:
>>>    compatible:
>>>      oneOf:
>>> +      - const: qcom,tsens-v0_1
>>> +      - const: qcom,tsens-v1
>>> +      - const: qcom,tsens-v2
>>
>> Nope, these are not correct.
>>
>>> +      - const: qcom,ipq8074-tsens
>>
>> Also nope, this is already there.
>>
>>> +
>>>        - description: msm8960 TSENS based
>>>          items:
>>>            - enum:
>>> @@ -66,8 +71,10 @@ properties:
>>>            - const: qcom,tsens-v2
>>>
>>>        - description: v2 of TSENS with combined interrupt
>>> -        enum:
>>> -          - qcom,ipq8074-tsens
>>
>> Why?
>>
>>> +        items:
>>> +          - enum:
>>> +              - qcom,ipq9574-tsens
>>> +          - const: qcom,ipq8074-tsens
> 
> Without changing it like this either dtbs_check or
> dt_binding_check kept failing.
> 
> 	- description: v2 of TSENS with combined interrupt
> 	  enum:
> 	    - qcom,ipq8074-tsens
> 	    - qcom,ipq9574-tsens

But we do not talk about this... Look, I commented out under specific
hunks which are not correct. Not under the hunk which is correct.

> 
> dtbs_check gave this kind of error
> 	['qcom,ipq9574-tsens', 'qcom,ipq8074-tsens'] is too long
> 
> After changing it like in https://elixir.bootlin.com/linux/v6.3-rc6/source/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml#L31
> 
> 	- description: v2 of TSENS with combined interrupt
> 	  const: qcom,ipq8074-tsens
> 	  - enum:
> 	      - qcom,ipq9574-tsens
> 	  - const: qcom,ipq8074-tsens
> 
> dt_binding_check gives the following error
> 
> 	Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:70:9: did not find expected key

Because it is not even valid syntax.

> 
> and dtbs_check gives
> 
> 	./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:70:9: [error] syntax error: expected <block end>, but found '-' (syntax)
> 	  CHKDT   Documentation/devicetree/bindings/processed-schema.json
> 	./Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml
> 	./Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml
> 	./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:70:9: did not find expected key
> 	  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> 	/local/mnt/workspace/varada/v3/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml: ignoring, error parsing file
> 
> If i change it like below,
> 
> 	- description: v2 of TSENS with combined interrupt
> 	  enum:
> 	    - qcom,ipq9574-tsens
> 	  - const: qcom,ipq8074-tsens
> 
> dt_binding_check and dtbs_check gives same error as above.
> 
> Looked around and found Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
> which seemed to do something similar to what is wanted in this
> case. Hence changed qcom-tsens.yaml similar to the allwinner yaml
> file. After which dt_binding_check and dtbs_check passed. Please
> let me know if there is a better way to solve this. Will go with

Changing one valid syntax to another valid syntax is not related to the
patch. If you think such change as reasonable, please split it, but to
me it does not look justified. As for actual change, so adding new
compatible, it's not really related to the others. Why you cannot add
the proper list (so the only valid hunk) and that's it?

Best regards,
Krzysztof

