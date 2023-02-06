Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F6368BA87
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBFKkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjBFKjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:39:51 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABE02703
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:39:30 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r2so9896926wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3e6ZhkWKbsw+k0ABcuxnIH0r442jAtdVbAUUl9gAFyM=;
        b=P4CZJlVaIHIOmaNlKg4aAFDRaJvOJf2SD0hD0KKF6PUrtxer7N/CSQWF/XN9uEFLX0
         Y4QjNko0fGBxM+WVPLEBrtzpCGLRJc7UJPHm7RY4j9J05oF+gFSNyTDbrOAyruifBp1F
         GEJc7ZppJimvgbiew8Eq1Nkjvtu+RJZPEmaDDznWLzcX1QljvhlIDr2F6vGsSb1aBYqJ
         sCKm2cAIOfIJuJP1J69ZdYLRGM2ihRJQ1EWSeQZ+uP3nGqxRg/kvTkgIRyV1JO9sWB3A
         BP67K7+9ttSU97Y8kz1vxZBud6wLjILOxQ8Wjf6uVO4KKqTDCl6C9/MIhehUX6MGemiP
         8hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3e6ZhkWKbsw+k0ABcuxnIH0r442jAtdVbAUUl9gAFyM=;
        b=hGp9TXctwUtDYC4U/RcNigc/vX5H8C2Fgb8FbkkaZOLv+eWKdlK1/fbydd/f/QEXHK
         K3/eMCZ9nkvLbCMvacSMOaAXX7HC5VzSw8D1F8zQL9Cwhis2JpLS32Kyz361/nalsjaZ
         0pwfhWvCZY8oCP0JS1JTLqVuC279GkvUK2XPpJUxYaiEDDO+KmLV8luOYwhfLJM4LQ+s
         85WJN/sx8V/qqxU95IRLSbDzvdcRmtzjkBvhVVld8uvsTHoxuBJivRVngPXEgCy6D3HV
         uBBYe9gr2hODgLvdn9yky2hB+tFPDM9jks/QBJuvcL6tVC5PagUIkmzAsplvnOPFlhze
         jREw==
X-Gm-Message-State: AO0yUKXUAjwM1tdluOARHxZQmbvLSC0S7tk0msRxGEtepsvkuMh2iyJU
        zboqmDSHQJ4YYSDpeNvXW/68EQ==
X-Google-Smtp-Source: AK7set/68vFuljNaj+rAWM0OoZVKkxkKNuxOhrf38UKNUbmKPm2f8lvRg056lHCIh8DKh7ayiV/4CQ==
X-Received: by 2002:a05:6000:2c6:b0:2c2:6541:7afc with SMTP id o6-20020a05600002c600b002c265417afcmr23229093wry.64.1675679956458;
        Mon, 06 Feb 2023 02:39:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d4601000000b002bdfe3aca17sm8488119wrq.51.2023.02.06.02.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 02:39:16 -0800 (PST)
Message-ID: <7c34474f-11d9-89ff-d0cb-2744c0d859ab@linaro.org>
Date:   Mon, 6 Feb 2023 11:39:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/6] dt-bindings: mailbox: qcom: add compatible for the
 IPQ5332 SoC
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
 <20230202145208.2328032-5-quic_kathirav@quicinc.com>
 <3a346606-576b-ab89-78f5-5bbaca729090@linaro.org>
 <eea6beee-7867-137c-2124-08d81b2ec989@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <eea6beee-7867-137c-2124-08d81b2ec989@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 10:12, Kathiravan T wrote:
> 
> On 2/2/2023 9:05 PM, Krzysztof Kozlowski wrote:
>> On 02/02/2023 15:52, Kathiravan T wrote:
>>> Add the mailbox compatible for the IPQ5332 SoC.
>>>
>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml     | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>>> index 943f9472ae10..8d8cd1bbe67e 100644
>>> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>>> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>>> @@ -18,6 +18,7 @@ properties:
>>>       oneOf:
>> - items:
>>      - enum:
>>          - qcom,ipq5332-apcs-apps-global
>>      - const: qcom,ipq6018-apcs-apps-global
>>
>> and drop the next patch
> 
> 
> Hi Krzysztof,
> 
> I'm planning to post the V2 of this series. How do you want me to 
> proceed? I see you posted separate series[1]. May be I can follow the 
> suggestion which you shared above, starting with IPQ?

My series need rebasing on top of Dmitry's fixes, so I propose you just
send patch working only for ipq6018, like I wrote above.


Best regards,
Krzysztof

