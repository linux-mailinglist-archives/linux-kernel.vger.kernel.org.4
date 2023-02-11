Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53292693066
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjBKLid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKLic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:38:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F2120D20
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:38:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bu23so7636643wrb.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6aCXlLQEgLd57/LCgjvzg9GpvcqOEVGN1KjGxNvO+g=;
        b=pRHH7zK+b2vGax3pPcRSK/yMqMkYwV43+Few0ZdlpPj8zCVkl+Fe2m+Tvvq9/roVYX
         AIxtHA6Nwc5k4COnRbxSIRFbc3iVmdsrH5bdc/zw5HtJmei/8kiY5sQfUSmK+X2VJCUJ
         m+DKa6NUppuqZNND+Ybjm68IEB3ZO98WJSKbCjigMDgYcIt21DBEDvC21tV+uUuFB023
         TCUCzsWafQfotz8ZqDfoI2o5CIyG6aHMQMn6cBwR2UoMjVoXOF6SU+D7kpDxzS4jvq90
         4IBRIKJSr9UW3QWsFMUviWcLX05es8Gn5QJG30CYKrSKC+LlctTXBMd9Dx1IfZU4e7ms
         oIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6aCXlLQEgLd57/LCgjvzg9GpvcqOEVGN1KjGxNvO+g=;
        b=3F2HPxCpgcjt8ihHMWSfFgSCX5g6V1NFCxi46q3jSrRavjkCH7+ZGC8qjPTSVtjupl
         EI91VLfwaGT1trHBiS0XX3C94s5uaGIWC43ogbvo1ACc0UGrX8rhflZCDncotdOHfiKp
         8PoRK8lAdQcvNI36IthdUnwkLwtOOAPIgMHOATItm0kLedanEuyxi5BZysFGE3EJpSlt
         R9Dfl3UHhYZ6rwAhs2caiFV1qjORTaVFg59IhpM7HVfk6JbbMtGRyE9qD/Hk+YF90rQL
         HxOvDBvufblUonZf4EPty+IE6Y5xVQlt5oHBx3QF8BIfwK2n4GLS/Q2wkmUviL8E6nEi
         TMUA==
X-Gm-Message-State: AO0yUKW+WBnVulWJv0q3dxHt4zYvFghdYbQjDZeVkqZbE8CStlbtXJvj
        o6fuYoBHL3veZuQAcAAVZTzrBQ==
X-Google-Smtp-Source: AK7set81X5ZntMdN43dI9JDAbNYdag7Az4uarlVjuseQcWgkyugHbqvcYGPnldU5ZYbGizkGBHqR5g==
X-Received: by 2002:adf:f44b:0:b0:2bf:e4b2:64a8 with SMTP id f11-20020adff44b000000b002bfe4b264a8mr16389445wrp.42.1676115509479;
        Sat, 11 Feb 2023 03:38:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r3-20020a5d6943000000b002c551ae8cc1sm763165wrw.67.2023.02.11.03.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 03:38:29 -0800 (PST)
Message-ID: <bde0a2fd-b1e4-61bd-2cca-a1d1c60570bd@linaro.org>
Date:   Sat, 11 Feb 2023 12:38:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/5] dt-bindings: display: msm: dp-controller: document
 SM8450 compatible
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v3-0-636ef9e99932@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v3-1-636ef9e99932@linaro.org>
 <226aeac5-d1b1-2a99-5c17-c26a8458c5ea@linaro.org>
 <b16921bb-409e-3591-d5fb-69212ef4e192@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b16921bb-409e-3591-d5fb-69212ef4e192@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 16:27, Neil Armstrong wrote:
> On 10/02/2023 16:16, Dmitry Baryshkov wrote:
>> On 10/02/2023 16:44, Neil Armstrong wrote:
>>> The SM8450 & SM350 shares the same DT TX IP version, use the
>>> SM8350 compatible as fallback for SM8450.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   .../bindings/display/msm/dp-controller.yaml        | 25 +++++++++++++---------
>>>   1 file changed, 15 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> index 0e8d8df686dc..f0c2237d5f82 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> @@ -15,16 +15,21 @@ description: |
>>>   properties:
>>>     compatible:
>>> -    enum:
>>> -      - qcom,sc7180-dp
>>> -      - qcom,sc7280-dp
>>> -      - qcom,sc7280-edp
>>> -      - qcom,sc8180x-dp
>>> -      - qcom,sc8180x-edp
>>> -      - qcom,sc8280xp-dp
>>> -      - qcom,sc8280xp-edp
>>> -      - qcom,sdm845-dp
>>> -      - qcom,sm8350-dp
>>> +    oneOf:
>>> +      - enum:
>>> +          - qcom,sc7180-dp
>>> +          - qcom,sc7280-dp
>>> +          - qcom,sc7280-edp
>>> +          - qcom,sc8180x-dp
>>> +          - qcom,sc8180x-edp
>>> +          - qcom,sc8280xp-dp
>>> +          - qcom,sc8280xp-edp
>>> +          - qcom,sdm845-dp
>>> +          - qcom,sm8350-dp
>>> +      - items:
>>> +          - enum:
>>> +              - qcom,sm8450-dp
>>> +          - const: qcom,sm8350-dp
>>
>> Neil, Krzysztof, I'm not convinced that this is worth all the troubles. I think it would be easier to have a flat list of compatibles and handle all the differences inside the driver. For example, for sdm845 we simply reused sc7180 config internally, while keeping separate compatible strings.
> 
> Sure, but the doc reports the SM8350, SM8450 and SM550 has the exact same IP version, isn't fallback for that cat ?

Exactly.

What's the trouble with the list Neil created?

Best regards,
Krzysztof

