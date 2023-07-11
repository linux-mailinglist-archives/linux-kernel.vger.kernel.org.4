Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E3F74EB28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjGKJwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjGKJwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:52:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D580BA8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:52:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so7545415a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689069157; x=1691661157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBsilH/Wv3zx61Y3YrX4aQgolpw0cneKejaXzy4ijj8=;
        b=M1/Bdaz18qU7zhpTw3JrWIef953afBThaEeBSQLenn8lypb4Busu05MRQ131YVTFrc
         vSymi9Xzu2lNP6QcJeKXI2PUyWWBgTd0az4L8gguXUb1okX+aWunPfeV8CNJHz3+wXvE
         N3+CnAA148l2wzBXeEQc1m9L7Lb9r0KAHoUUAq6Nv2TQ6sVRj19CB1Kc2TNvX0bVzUNh
         ivIp11tU/7ULtKdgj5fHWwrdKYhY4Q9ZOrUBnjlbuZfDA8zyTza+Ivt/r3MyZfuO+uRK
         LQw1PjNHOSRR87elFjhfmlKw9CIOKvQD6MN6KWGzvGW67k1hWMUXv9TWg/Fd/g1vBGmA
         U2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689069157; x=1691661157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBsilH/Wv3zx61Y3YrX4aQgolpw0cneKejaXzy4ijj8=;
        b=QNHYQoN24x2Zu48C99KEX2soiELbJ7cYDIfma0b1FrKpwxNfeVv1b3oqMfkqtmmHBn
         hHVpz2miw6ehXzvKLFNOsmMnhKqcykvL35L0fsQjeym565OzNpVsRISBwScmQdROeXmd
         YkdbX6uDRt0bJZbstVDU0+njF6VZ9V5zSXiZCYqXBrFXL3J4e7ynbIYP9chBCHUVZVFt
         Gp+qYNdqEXquu906bs8hfUHj7oBqz0i5ioh+VoNwO5Y/URWdDyp9obdqfPzQSz0E80AL
         DuCGBtgb5Z74/T0JEi2oXNbqjy8t9X5BeqtFQftsgDZrLTQGMLyFglZ0R1yQeFORK9p1
         LUMg==
X-Gm-Message-State: ABy/qLbheOcETb1OS+JP/AkmdqMjfPZ1ExMAbml7ZsONXE9RNQiU/UPo
        2P6U3OZlcpxf6bVEogn9bWJJgA==
X-Google-Smtp-Source: APBJJlFBJKAac6woquP4clYjY/LaBb0bcQDlEU9gjKJqKd2vFIvqN9xMWLAmsWBMrN2nm2FyhgBsCA==
X-Received: by 2002:aa7:cb0c:0:b0:51d:a724:48d1 with SMTP id s12-20020aa7cb0c000000b0051da72448d1mr13930604edt.23.1689069157328;
        Tue, 11 Jul 2023 02:52:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l7-20020aa7c3c7000000b0051e229d04fcsm987488edr.70.2023.07.11.02.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:52:36 -0700 (PDT)
Message-ID: <37aa7ae8-206e-3a48-b90d-22d49e86c675@linaro.org>
Date:   Tue, 11 Jul 2023 11:52:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] dt-bindings: thermal: tsens: Add nvmem cells for
 calibration data
Content-Language: en-US
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-2-quic_ipkumar@quicinc.com>
 <09e33a89-c060-69b1-b94f-b21c45d1d249@linaro.org>
 <59ea653e-c5da-71cb-eb85-1aa3c72e2089@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <59ea653e-c5da-71cb-eb85-1aa3c72e2089@quicinc.com>
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

On 11/07/2023 11:39, Praveenkumar I wrote:
> 
> On 7/11/2023 1:40 AM, Krzysztof Kozlowski wrote:
>> On 10/07/2023 12:37, Praveenkumar I wrote:
>>> Add TSENS V2 calibration nvmem cells for IPQ5332
>>>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> ---
>>>   .../bindings/thermal/qcom-tsens.yaml          | 26 +++++++++++++++++--
>>>   1 file changed, 24 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> index 27e9e16e6455..8b7863c3989e 100644
>>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> @@ -91,7 +91,7 @@ properties:
>>>       maxItems: 2
>>>   
>>>     nvmem-cells:
>>> -    oneOf:
>>> +    anyOf:
>>>         - minItems: 1
>>>           maxItems: 2
>>>           description:
>>> @@ -106,9 +106,13 @@ properties:
>>>           description: |
>>>             Reference to nvmem cells for the calibration mode, two calibration
>>>             bases and two cells per each sensor, main and backup copies, plus use_backup cell
>>> +      - maxItems: 17
>>> +        description: |
>>> +          V2 of TSENS, reference to nvmem cells for the calibration mode, two calibration
>>> +          bases and one cell per each sensor
>> I think this is already included in one of the previous entries.
>> Otherwise, are you sure that all new devices will have exactly 17 entries?
> Previous entries does not support TSENS version 2.X.X QFPROM. TSENS V2 
> QFPROM has mode, base0, base1 and s[0-15]+_offset.
> Ideally it should be like,
> - minItems: 4
> - maxItems: 19

I see it covered:
minItems: 5
maxItems: 35

I think 17 is between 5 and 35.

> But dt binding check fails in oneOf / anyOf condition. So added the 
> IPQ5332 properties which is exactly 17.
>>
>>>   
>>>     nvmem-cell-names:
>>> -    oneOf:
>>> +    anyOf:
>>>         - minItems: 1
>>>           items:
>>>             - const: calib
>>> @@ -205,6 +209,24 @@ properties:
>>>             - const: s9_p2_backup
>>>             - const: s10_p1_backup
>>>             - const: s10_p2_backup
>>> +      - items:
>>> +          - const: mode
>>> +          - const: base0
>>> +          - const: base1
>>> +          - const: s0_offset
>>> +          - const: s3_offset
>>> +          - const: s4_offset
>>> +          - const: s5_offset
>>> +          - const: s6_offset
>>> +          - const: s7_offset
>>> +          - const: s8_offset
>>> +          - const: s9_offset
>>> +          - const: s10_offset
>>> +          - const: s11_offset
>>> +          - const: s12_offset
>>> +          - const: s13_offset
>>> +          - const: s14_offset
>>> +          - const: s15_offset
>> Don't introduce new naming style. Existing uses s[0-9]+, without offset
>> suffix. Why this should be different?
> As I mentioned above, s[0-9]+_p1 / s[0-9]+p2 is for TSENS V1. TSENS V2 
> QFPROM layout is different from the existing one.

I know, I did not write about p1/p2.

> I would like to add mode, base0, base1 and 16 patterns 
> '^s[0-15]+_offset$'. But DT binding check is failing in oneOf/ anyOf 
> condintion.

This does not explain why you need different style - this "offset" suffix.

Best regards,
Krzysztof

