Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9686F64E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjEDGWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjEDGWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:22:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D126A9
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:22:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so13857898a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 23:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683181367; x=1685773367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/ezhV0uzxF2JPR+QsyPD3go+DnG9ZqfpAlPDNo59BU=;
        b=FZr+RqtyNO6t70vl1mH0S3PoDI+Feat2fU49VarExfWXxyhRIwPhWMxXE3sbdO5dUz
         BEXBHD0b6XSZRmz3D0bL+WGP88pl+wtiBr483QPFpjQAmzuPCmFKUEReGd9lLgGgrbfV
         QLSN3hsGWneqjyEUIGhCX6Q8zyD/Y5cg3KoeY0jvyW4KnJhfFGYMfDjNTqocWSLzxWLZ
         iDirhyqaU7dLBaaGFkWYjFPCgV22hCr30/z3RkDVafdfLxP89j7l/RXms6YdDds7HTUh
         OOXh8kus/hLEcXvbGSjFvSAal4hqA4gW1ElEBWzlqnWDYAw8ashqwKlHsAEPkCmgjaq0
         JZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683181367; x=1685773367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/ezhV0uzxF2JPR+QsyPD3go+DnG9ZqfpAlPDNo59BU=;
        b=Zzisa9E3pt0xhGB8TBqgPEarTdelZLwynFhk3du5arxmUOYAqqGSQseyELYxSFcBp6
         CWroUestX0aCDOp0Mi1opNHHEXsnBcXvJmh8Tkkp6QR/oRf7hL+2mPqyMTnbdIjN7zG4
         dfvWK+RG6GJ0PvbqJBPgQs9r23UuL6ucvIrY5KJ/6UuXvgqZYQQSyr8cMZpSTZZ9B6/o
         4MgI/pGdFEhGZstHUSBC3r7gqw8d8dHDBRcJ2lN3e/VtA6pWi8UXSuVWOfiv3LoaforP
         1eNijSs/vYrnE2j5geZ/EbdSg+vnZfqCrNIV2rdWYw+ShG+7TyqT2yLjIQnQ5QTfzBFU
         caFQ==
X-Gm-Message-State: AC+VfDxdPoJj8m/2OE7p3R/GGKNBW8WO/i7aza9uVQ89+Gckz0uZsBK/
        L2HklGo/qfMJVJNsKnIFHBf5nQ==
X-Google-Smtp-Source: ACHHUZ5YCAFEI+pgFzkMJzHr/+9eQUl3KiHxLZwYIw60wPS7QQGj7GHaO9b5Gh6FVgQ+5HXKe9AWvw==
X-Received: by 2002:a17:906:ef06:b0:94e:4285:390c with SMTP id f6-20020a170906ef0600b0094e4285390cmr3543751ejs.10.1683181366679;
        Wed, 03 May 2023 23:22:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id hf27-20020a1709072c5b00b0095fde299e83sm9673960ejc.214.2023.05.03.23.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:22:45 -0700 (PDT)
Message-ID: <1b449a78-b57e-7e1e-0261-d35a5a2582a6@linaro.org>
Date:   Thu, 4 May 2023 08:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/4] dt-bindings: thermal: tsens: Add ipq9574 compatible
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1682682753.git.quic_varada@quicinc.com>
 <3c6f7510d175ba5a3c81730b010f6c421b2fbf2d.1682682753.git.quic_varada@quicinc.com>
 <16443d11-7948-d224-cfef-b6c1b5c3d60d@linaro.org>
 <20230503071055.GB1087@varda-linux.qualcomm.com>
 <915eea5b-6cef-d346-7cbd-b679726113ad@linaro.org>
 <20230504045757.GA13434@varda-linux.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504045757.GA13434@varda-linux.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 06:57, Varadarajan Narayanan wrote:
> On Wed, May 03, 2023 at 09:42:28AM +0200, Krzysztof Kozlowski wrote:
>> On 03/05/2023 09:10, Varadarajan Narayanan wrote:
>>> On Mon, May 01, 2023 at 09:08:49AM +0200, Krzysztof Kozlowski wrote:
>>>> On 28/04/2023 16:52, Varadarajan Narayanan wrote:
>>>>> From: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>>>
>>>>> Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.
>>>>>
>>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>>> index d1ec963..8e2208c 100644
>>>>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>>> @@ -66,6 +66,7 @@ properties:
>>>>>        - description: v2 of TSENS with combined interrupt
>>>>>          enum:
>>>>>            - qcom,ipq8074-tsens
>>>>> +          - qcom,ipq9574-tsens
>>>>
>>>> Your drive change indicates they are compatible, so make them
>>>> compatible. 9574 followed by 8074.
>>>
>>> Not able to understand. You want IPQ9574 to use "qcom,ipq8074-tsens"
>>> instead of adding a "qcom,ipq9574-tsens" and no need to add an extra
>>> entry to the driver like
>>
>> Assuming the devices are really compatible, which your driver change
>> suggests, I want to use two compatibles. 9574 followed by 8074 fallback,
>> just like we do for all Qualcomm IP blocks. Then as you said - no need
>> for driver change.
> 
> With schema like this
> 	items:
> 	  - enum:
> 	      - qcom,ipq8074-tsens
> 	      - qcom,ipq9574-tsens
> and DTS as
> 	compatible = "qcom,ipq9574-tsens", "qcom,ipq8074-tsens";

This file (and many others) shows you how to encode it in the DT schema

https://elixir.bootlin.com/linux/v6.3-rc6/source/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml#L31

> 
> 'make dtbs_check' gives the following error
> 
> arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: thermal-sensor@4a9000: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['qcom,ipq9574-tsens', 'qcom,ipq8074-tsens'] is too long
> 
> To fix the above error, I have to change the schema as
> 
> 	items:
> 	  - enum:
> 	      - qcom,ipq8074-tsens
> 	      - qcom,ipq9574-tsens
> 	  - const: qcom,tsens-v2-combined-int

This is not what we talked about.

Best regards,
Krzysztof

