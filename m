Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F0E618355
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiKCP41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiKCP4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:56:24 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8120213E29
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:56:23 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 8so1420054qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tEdlO2eJHCWVqpq9ZVmfFrHoK+b5oUGHwUErbKgRbJo=;
        b=ehxT8BnUuWvvgFR/WyjOn0EeBKCALG1yZXrAqTz8QVo/bXbWOKQimZ7PSY02mWw3eR
         6Gyd99eRGa1Ay7XFHF5zwJ4JKbJtqYcY2es1g8JbRs0H6VceGJqd89HZq8RLTN3a8pRC
         aZAM2E+sh9MkRwyXCuO1zVngZotQEmRnkr6oZclSbcdxB1lG1+dVicvR0lDkjNrteQ1h
         ODlv68plAFnp9sDypLOyy3KbFtrCEqIdLS62H2tdQR4rsb4haernYYt11LUnH7vfimht
         3dGZJUx0NVimXDkQsJWV5xJR0RXfkaQ0QLf1E9ellUyKCsmJRGrKQWstv7TjA8/OuKBy
         58/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEdlO2eJHCWVqpq9ZVmfFrHoK+b5oUGHwUErbKgRbJo=;
        b=i1gJrorCAvlecnVuhhcucxnS3QXUlyot/jvd8krurtFiEZusZgoLGu0DjZyCa43iep
         tDRMu8mhztwt17w6U5aHRLfA5ccYwvB0hM4RII3HGMRZyLFyYiEhbT0ASQewboHv6B6h
         pI+XAveGMIKjxluhybo0uzjMqcNfCPQmoTbxnYtDRpRX3ty3Lz8oh1To6P+nyWDKO5gb
         Ite6Ujf0EepJ8inKt9pUuT4oAcp1/9K6Fvhv0fNZ3XBjQrpxRv55Z/UyVeu9KtK0TiGq
         jbc9gJq6BGfxO2ql3E6mQ2cOo6WpKi4tNcO+6J2si4daHL/ezxbGeNUkFJn5DwFq3b9/
         hc9A==
X-Gm-Message-State: ACrzQf1hG8qvwD/liMqOGtwu3kJ4gCzAqgg8++CBV7ALCapbxgYT4MWF
        0o4xU6ulZIDh22aBpHgpsgMKJGiqtBTTJw==
X-Google-Smtp-Source: AMsMyM49ONOs/YLVOtSG+GQhfYXHOv4K5GNKWD8MYoE8uTvwxAimwbp/ySZ0z8Zm/a1vmY+uuIF0BA==
X-Received: by 2002:a37:6588:0:b0:6fa:3046:7f8b with SMTP id z130-20020a376588000000b006fa30467f8bmr15690041qkb.752.1667490982649;
        Thu, 03 Nov 2022 08:56:22 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id ey21-20020a05622a4c1500b003988b3d5280sm725662qtb.70.2022.11.03.08.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 08:56:22 -0700 (PDT)
Message-ID: <910c152d-5e1a-4667-2f0a-a1524f51958c@linaro.org>
Date:   Thu, 3 Nov 2022 11:56:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 05/10] dt-bindings: interconnect: Add sm8350, sc8280xp and
 generic OSM L3 compatibles
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221028034155.5580-1-quic_bjorande@quicinc.com>
 <20221028034155.5580-6-quic_bjorande@quicinc.com>
 <a364b343-fa19-348c-bc38-e8b44061890b@linaro.org>
 <20221103034410.GB5525@core-thresher1.qualcomm.com>
 <f3882934-9f95-39f1-83e4-6ce9efeb089c@linaro.org>
 <20221103154653.67mgsey57uvdcvx3@builder.lan>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103154653.67mgsey57uvdcvx3@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 11:46, Bjorn Andersson wrote:
> On Thu, Nov 03, 2022 at 08:25:17AM -0400, Krzysztof Kozlowski wrote:
>> On 02/11/2022 23:44, Bjorn Andersson wrote:
>>> On Fri, Oct 28, 2022 at 06:12:29PM -0400, Krzysztof Kozlowski wrote:
>>>> On 27/10/2022 23:41, Bjorn Andersson wrote:
>>>>> Add EPSS L3 compatibles for sm8350 and sc8280xp, but while at it also
>>>>> introduce generic compatible for both qcom,osm-l3 and qcom,epss-l3.
>>>>>
>>>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>>>> ---
>>>>>  .../bindings/interconnect/qcom,osm-l3.yaml    | 22 +++++++++++++------
>>>>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>>> index bf538c0c5a81..ae0995341a78 100644
>>>>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>>> @@ -16,13 +16,21 @@ description:
>>>>>  
>>>>>  properties:
>>>>>    compatible:
>>>>> -    enum:
>>>>> -      - qcom,sc7180-osm-l3
>>>>> -      - qcom,sc7280-epss-l3
>>>>> -      - qcom,sc8180x-osm-l3
>>>>> -      - qcom,sdm845-osm-l3
>>>>> -      - qcom,sm8150-osm-l3
>>>>> -      - qcom,sm8250-epss-l3
>>>>> +    oneOf:
>>>>> +      items:
>>>>
>>>> oneOf expects a list, so this should be "    - items"
>>>>
>>>
>>> Ahh, thanks. Must have missed running the dt_binding_check on this one.
>>>
>>>>> +        - enum:
>>>>> +            - qcom,sc7180-osm-l3
>>>>> +            - qcom,sc8180x-osm-l3
>>>>> +            - qcom,sdm845-osm-l3
>>>>> +            - qcom,sm8150-osm-l3
>>>>> +        - const: qcom,osm-l3
>>>>
>>>> The concept is good, but are you sure all SoCs will be compatible with
>>>> generic osm-l3?
>>>
>>> Per the current implementation yes, worst case if one or more of them isn't the
>>> more specific compatible can be used to alter the behavior of that platform.
>>>
>>>> Why not using dedicated compatible of one soc, e.g. the
>>>> oldest here? We already did like that for BWMON, DMA and few others.
>>>>
>>>
>>> Because if we say compatible = "qcom,sc8180x-osm-l3", "qcom,sdm845-osm-l3" and
>>> there is a quirk needed for "qcom,sdm845-osm-l3" we're forced to add a "special
>>> case" every other *-osm-l3 in the driver.
>>>
>>> This way we can have a generic implementation for the qcom,osm-l3 and if we
>>> realize that we need to quirk something for the oldest platform, we can do so
>>> without affecting the others.
>>
>> True. This also means we do not really know which one is the generic
>> implementation :)
>>
> 
> There currently is an implementation without platform specific quirks, I
> call that the generic implementation and suggest that we refer to that
> using "qcom,osm-l3".>
> If we instead were to use sdm845 as the generic compatible, and there
> turns out to be a need for a quirk for this platform, you:
> 
> 1) no longer have a generic implementation, but 4 platform-specific
>    implementations

It's okay because there is no such thing anymore as "generic
implementation". If this happened, your generic compatible is not
specific enough. It does not represent any specific hardware.

Adding generic compatibles just to make driver binding easier, is a bit
in contrast with DT which should focus on hardware description.

> 
> 2) have 3 platforms claiming to be compatible with the quirked (now
>    specialized) implementation, which they clearly aren't anymore

Yes, that's the problem and this is why I mentioned that we do not know
the generic implementation. If we knew that sdm845 is the generic, we
would not expect specific quirks for it.

If you cannot make sdm845 generic because of unknown quirk, then you
just do not know which one is generic implementation and that compatible
is not specific enough... Or it is specific only to current Linux driver.

> Therefor I favor using generic names for generic compatibles.

They make driver development easier but they hide the real match between
hardware and compatible.

Best regards,
Krzysztof

