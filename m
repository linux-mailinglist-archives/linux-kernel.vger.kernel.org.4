Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9387774E733
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjGKGXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjGKGXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:23:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428E010E3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:23:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so12609119a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689056607; x=1691648607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ds4YDY9bzqXKtiOPGD6t4IhnN/cwNEFXlrWZqOw7IxM=;
        b=iXs38U+gNmaUFaRgwet8MxWdG3goixhRBHKp46WScCOAfu4JgXfCOEBAYlRJF/7hjw
         LteYkx8oDl8+cwnoM9bRtZU8H4bpsrC2g9exXubo6pfQ+NjdwIsL2efhM5a1hOnUdDRd
         ahkM6oUuXWAcXlJFesBUMD771v9imOrFxNnL1zEYc/ui/oLoAYDZoy028QSd/IfONI7f
         bbH7t4VvxLqyM9Acxcl1NSRVIo39wJ+r1UYzGVF2uGMXUQeId6d32/dY7qGFClwFOc4P
         BsGC6NjKq+TwG9EJ+9YE4Ms9gRt2IvpGa9vt5Q4SVyvFDhP5ioQu0ssAXRyb9rKZgG8H
         WtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689056607; x=1691648607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ds4YDY9bzqXKtiOPGD6t4IhnN/cwNEFXlrWZqOw7IxM=;
        b=YkZnlbgwL6aoqQjP0D/CVb2/SFDGmgLJ76GIyX2ZpJetIiSN+rMprPqhiyK1LEFHOT
         +leA9X67h2vJ3goEZHHeQzfmIOKj3NGHoRFzqX6Bt9GG1I0QZuplkcJWv2IvINoekJDd
         /w8vj89xkQ5ehbWRBmLXit9pu65XEMo5HyRi/m3l/m+lGmwqU1YQUzvfUID3QTxA1LDH
         sV/Osh9chZ/VcSoppxmAjh2LF8DKxWDj0tkC6SjnFKl2V6TCKYYr+/zwGNX+7K36tfYE
         jb58uuij+WpaHMzhVJFioLgiqRiEyufR4oiayPYbjJaAsk8qOfTaczrRDN3LgYA0IHqx
         BATg==
X-Gm-Message-State: ABy/qLYf+91IhUYUkcononrUdEZ+2Hil5uuqt3057UO8DsU9BueXo1+i
        aTR2lL+946l7phpIbnWYi70HUQ==
X-Google-Smtp-Source: APBJJlGKSwD7Yf1spLBNs3o3iJw2BaYaSdqFnawQzbvU0JTFJRHjhfoPqFLGoDqboNr2MwAToLlnyg==
X-Received: by 2002:a17:906:1041:b0:992:8d96:4de3 with SMTP id j1-20020a170906104100b009928d964de3mr21166193ejj.24.1689056606678;
        Mon, 10 Jul 2023 23:23:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id hb7-20020a170906b88700b009925cbafeaasm687544ejb.100.2023.07.10.23.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 23:23:26 -0700 (PDT)
Message-ID: <f27a692e-460c-9a9b-0afc-ad9a71ab4262@linaro.org>
Date:   Tue, 11 Jul 2023 08:23:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: Add PMX75 compatible
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1689054415-11281-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689054415-11281-2-git-send-email-quic_rohiagar@quicinc.com>
 <8eb986f2-3268-65cd-9210-ef1fca4f8259@linaro.org>
 <fc054877-52c6-9e61-8572-3068c53a86de@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fc054877-52c6-9e61-8572-3068c53a86de@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 08:22, Rohit Agarwal wrote:
> 
> On 7/11/2023 11:35 AM, Krzysztof Kozlowski wrote:
>> On 11/07/2023 07:46, Rohit Agarwal wrote:
>>> Add PMX75 compatibles for PMIC found in SDX75 platform.
>>> While at it, update the entry for SDX65 as well.
>> Everything is an update...
>>
>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>> ---
>>>   .../bindings/regulator/qcom,rpmh-regulator.yaml    | 22 +++++++++++++++++++++-
>>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
>>> index b949850..72b533c 100644
>>> --- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
>>> +++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
>>> @@ -53,6 +53,7 @@ description: |
>>>         For PMR735A, smps1 - smps3, ldo1 - ldo7
>>>         For PMX55, smps1 - smps7, ldo1 - ldo16
>>>         For PMX65, smps1 - smps8, ldo1 - ldo21
>>> +      For PMX75, smps1 - smps10, ldo1 - ldo21
>>>   
>>>   properties:
>>>     compatible:
>>> @@ -84,6 +85,7 @@ properties:
>>>         - qcom,pmr735a-rpmh-regulators
>>>         - qcom,pmx55-rpmh-regulators
>>>         - qcom,pmx65-rpmh-regulators
>>> +      - qcom,pmx75-rpmh-regulators
>>>   
>>>     qcom,pmic-id:
>>>       description: |
>>> @@ -424,10 +426,28 @@ allOf:
>>>           vdd-l11-l13-supply: true
>>>         patternProperties:
>>>           "^vdd-l[1347]-supply$": true
>>> -        "^vdd-l1[0245789]-supply$": true
>>> +        "^vdd-l1[024579]-supply$": true
>> Why? Does not look related at all.
> This update is because sdx65 does not have vdd-l18-supply separately and 
> its
> already part of vdd-l2-l18-supply property mentioned in the properties 
> field.

Which was not explained in commit msg and is anyway not related. It's a
separate commit.

Best regards,
Krzysztof

