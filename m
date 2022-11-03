Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2B0617C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiKCMZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiKCMZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:25:22 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBEDAE68
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:25:20 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w4so1095722qts.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 05:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRtDVEtEJgnK5NxWnfZSm9MvUkIMouJgLknprK5+P84=;
        b=ur8/ynw3HXinZs1DmR4SXuNVzVzNs4UKeVq9ononjq5bkbXJ4OXTLOk309F0/luInH
         LMyvSU1TCa8zjcMmSgxl9m5L0tnM/hpOoCHSrTj2kkIkBjSdTQT8pmEf2MCQvV4ECPTL
         yjxKN9S8yOENOtaoc6Pd2Ks+gqQKbpQQ6voipg01qcx4oyJFOGnuHes7wfKXrZZiO9D0
         QhzAFcUvY6CHaSm+rbUAIYO5FAGz92FGl+Mt33+AnueGSELdBoT29BZtFnn8+Aypr/u/
         P3YF2NGdhQXfJmTc/YVXxM6fONTcZkeKmkzq2nx/GDgEL/pOeDkTC4mhESjWjWR/+1sL
         kWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRtDVEtEJgnK5NxWnfZSm9MvUkIMouJgLknprK5+P84=;
        b=vYCf1qJ6d4qJSKz157RV4DCzPqRsSLg0PV8545R0r6fRlnwFN/6fDaliy4SX0xyLBB
         fSqaqGaXs/78/HUOxfzY8ZEwgFAgMumnDfCZHk4PGmsEF9PXGytWUNNsji6jMpRFTSQt
         62kTZtntmm28EkFv73ikVIrsnalD0r1aXArTg5sFhWO4pCu2LdS/CSQF9T+DW75HfOYi
         aBMLmixmqgQLq4dmL4SGAvtqUlILWzKooIlr7hAggoozhI64sBviNPMEXkcYeKUkEZli
         y+VAzrkU93eU1LOtVzfRM4LGqYKSpSmoG0HRWWQkfbYgqYgh0//OStxMCB75/7gAmc32
         ZYzg==
X-Gm-Message-State: ACrzQf2G+ETDIOIsiBl4tFqdKDVbJaLQ7m9LRWmq8jCmznsI9Qrynh9M
        A8rCkllC67PaIdSLfI/Tl83JvHBCegqj5A==
X-Google-Smtp-Source: AMsMyM5XfiiHe+sG73blHKr1ihrcVGnNWHDbJ/l3uhWr6yAr/C7lfioqh38UM9AWFBokZE4Ip4Jhyg==
X-Received: by 2002:a05:622a:99b:b0:3a5:1984:bdc4 with SMTP id bw27-20020a05622a099b00b003a51984bdc4mr22290699qtb.239.1667478319231;
        Thu, 03 Nov 2022 05:25:19 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id b9-20020a05622a020900b003a4c3c4d2d4sm446560qtx.49.2022.11.03.05.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 05:25:18 -0700 (PDT)
Message-ID: <f3882934-9f95-39f1-83e4-6ce9efeb089c@linaro.org>
Date:   Thu, 3 Nov 2022 08:25:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 05/10] dt-bindings: interconnect: Add sm8350, sc8280xp and
 generic OSM L3 compatibles
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221028034155.5580-1-quic_bjorande@quicinc.com>
 <20221028034155.5580-6-quic_bjorande@quicinc.com>
 <a364b343-fa19-348c-bc38-e8b44061890b@linaro.org>
 <20221103034410.GB5525@core-thresher1.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103034410.GB5525@core-thresher1.qualcomm.com>
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

On 02/11/2022 23:44, Bjorn Andersson wrote:
> On Fri, Oct 28, 2022 at 06:12:29PM -0400, Krzysztof Kozlowski wrote:
>> On 27/10/2022 23:41, Bjorn Andersson wrote:
>>> Add EPSS L3 compatibles for sm8350 and sc8280xp, but while at it also
>>> introduce generic compatible for both qcom,osm-l3 and qcom,epss-l3.
>>>
>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> ---
>>>  .../bindings/interconnect/qcom,osm-l3.yaml    | 22 +++++++++++++------
>>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>> index bf538c0c5a81..ae0995341a78 100644
>>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>> @@ -16,13 +16,21 @@ description:
>>>  
>>>  properties:
>>>    compatible:
>>> -    enum:
>>> -      - qcom,sc7180-osm-l3
>>> -      - qcom,sc7280-epss-l3
>>> -      - qcom,sc8180x-osm-l3
>>> -      - qcom,sdm845-osm-l3
>>> -      - qcom,sm8150-osm-l3
>>> -      - qcom,sm8250-epss-l3
>>> +    oneOf:
>>> +      items:
>>
>> oneOf expects a list, so this should be "    - items"
>>
> 
> Ahh, thanks. Must have missed running the dt_binding_check on this one.
> 
>>> +        - enum:
>>> +            - qcom,sc7180-osm-l3
>>> +            - qcom,sc8180x-osm-l3
>>> +            - qcom,sdm845-osm-l3
>>> +            - qcom,sm8150-osm-l3
>>> +        - const: qcom,osm-l3
>>
>> The concept is good, but are you sure all SoCs will be compatible with
>> generic osm-l3?
> 
> Per the current implementation yes, worst case if one or more of them isn't the
> more specific compatible can be used to alter the behavior of that platform.
> 
>> Why not using dedicated compatible of one soc, e.g. the
>> oldest here? We already did like that for BWMON, DMA and few others.
>>
> 
> Because if we say compatible = "qcom,sc8180x-osm-l3", "qcom,sdm845-osm-l3" and
> there is a quirk needed for "qcom,sdm845-osm-l3" we're forced to add a "special
> case" every other *-osm-l3 in the driver.
> 
> This way we can have a generic implementation for the qcom,osm-l3 and if we
> realize that we need to quirk something for the oldest platform, we can do so
> without affecting the others.

True. This also means we do not really know which one is the generic
implementation :)


Best regards,
Krzysztof

