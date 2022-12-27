Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201DF656916
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiL0Ju1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiL0JuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:50:25 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CB095B8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:50:23 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m6so8548814lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKQJJaPJjiY7zFMjVxPuPcddpbmlzm3k2LkKijCT08c=;
        b=tWOXWoFfZk/4rjP8wQLBC9jleKV0/yFPIg+qtIHxfC8HFivHuDaUxC/wIoPEGqrV1j
         l2/LZhC8gzvcBFTU+RghqbTs4wcz9FHDb8MF5aHL1V7VzTapJE45ehaq40sE6qMYPsn8
         BST9UBsh2dvIK2gybMlsLPJGp/hVU+ax/SdCZZnCZ7yc3000HjZ60TTT3e7UTfqK1mHd
         /5wK7K6Yk+qJkhxqm73ycnwJh66W6IlZ8u4DPJkHo8F3HdFEmSnWc7sraBCwCmN2CByf
         m/0HAS+tpEtkbg6skGPUejCrqD4rJhZ0YnSp9BOWTismqyVCkEBRuqDm/ibU/7Xlt7Ou
         Dmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKQJJaPJjiY7zFMjVxPuPcddpbmlzm3k2LkKijCT08c=;
        b=5L2shJISQEPKP9udh6R0m7V50uFYNcyq89yg4RLCMd7ZuBAnJIXIQPAMlwmyvflNyn
         3vPkPinqGf5fSSr3A6awQ8SDUHJcABNTKVtK7zP99g7Zn/ZDFG72OU/c+zy5K0QO5mdS
         x0fGC96yWDNmg5mnC1EhRCR/ftKRxk51hQ7FRasFCokZRsWHLyX9sFg9i7wvPhcFVvWI
         TREWCUXMzw1MXRgpazrJovH2NA5VhtELs+4Y+F3/k4uWltFR3kin3y5SUq32XXAb7eMT
         WGwYMb28QMew5qbgCkm17ny8vN17Z4/T0aRIUKmxVYR26MrZcrhjotqm4PE5wTgaBGVp
         5dOQ==
X-Gm-Message-State: AFqh2kq70UCxcUyL3l4zvAxctI3kSm1mPq/FwfE7gIjTTHBgB4d6v5UL
        P53AvFElkmAu0ThIfbuGnMPRog==
X-Google-Smtp-Source: AMrXdXvWxMmtkPPX8AOwdB4TEIUbgYXMldP00evRIdisKnSeCoQpdD2/xAzBvBvRWKPwHyNrJzFg8A==
X-Received: by 2002:a05:6512:304a:b0:4b5:5098:e6f7 with SMTP id b10-20020a056512304a00b004b55098e6f7mr6238534lfb.68.1672134622108;
        Tue, 27 Dec 2022 01:50:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a22-20020ac25e76000000b004b58d457f2dsm2175129lfr.61.2022.12.27.01.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 01:50:21 -0800 (PST)
Message-ID: <d48e15f5-ca85-986a-ea30-94ce2747b962@linaro.org>
Date:   Tue, 27 Dec 2022 10:50:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] dt-bindings: remoteproc: ti: Add new compatible
 for AM62 SoC family
To:     Devarsh Thakkar <devarsht@ti.com>, andersson@kernel.org,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        s-anna@ti.com, Rob Herring <robh+dt@kernel.org>
Cc:     hnagalla@ti.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com,
        a-bhatia1@ti.com, j-luthra@ti.com
References: <20221223115638.20192-1-devarsht@ti.com>
 <20221223115638.20192-2-devarsht@ti.com>
 <374d0b5c-55f4-ee30-c804-4488a3fedb48@linaro.org>
 <01a0ee96-051d-9f0b-88e6-8b6feaffacb8@ti.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <01a0ee96-051d-9f0b-88e6-8b6feaffacb8@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2022 10:38, Devarsh Thakkar wrote:
> 
> 
> On 26/12/22 17:48, Krzysztof Kozlowski wrote:
>> On 23/12/2022 12:56, Devarsh Thakkar wrote:
>>> AM62 family of devices don't have a R5F cluster, instead
>>> they have single core DM R5F.
>>> Add new compatible string ti,am62-r5fss to support this scenario.
>>>
>>> When this new compatible is used don't allow cluster-mode
>>> property usage in device-tree as this implies that there
>>> is no R5F cluster available and only single R5F core
>>> is present.
>>>
>>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>> ---
>>> V2: Avoid acronyms, use "Device Manager" instead of "DM"
>>> V3:
>>> - Use separate if block for each compatible for ti,cluster-mode property
>>> - Rearrange compatibles as per alphabatical order
>>> ---
>>>  .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 68 +++++++++++++------
>>>  1 file changed, 47 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>> index fb9605f0655b..e8a861179bd9 100644
>>> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>> @@ -21,6 +21,9 @@ description: |
>>>    called "Single-CPU" mode, where only Core0 is used, but with ability to use
>>>    Core1's TCMs as well.
>>>  
>>> +  AM62 SoC family support a single R5F core only which runs Device Manager
>>> +  firmware and can also be used as a remote processor with IPC communication.
>>> +
>>>    Each Dual-Core R5F sub-system is represented as a single DTS node
>>>    representing the cluster, with a pair of child DT nodes representing
>>>    the individual R5F cores. Each node has a number of required or optional
>>> @@ -28,16 +31,20 @@ description: |
>>>    the device management of the remote processor and to communicate with the
>>>    remote processor.
>>>  
>>> +  Since AM62 SoC family only support a single core, there is no cluster-mode
>>> +  property setting required for it.
>>> +
>>>  properties:
>>>    $nodename:
>>>      pattern: "^r5fss(@.*)?"
>>>  
>>>    compatible:
>>>      enum:
>>> +      - ti,am62-r5fss
>>> +      - ti,am64-r5fss
>>>        - ti,am654-r5fss
>>> -      - ti,j721e-r5fss
>>>        - ti,j7200-r5fss
>>> -      - ti,am64-r5fss
>>> +      - ti,j721e-r5fss
>>>        - ti,j721s2-r5fss
>>>  
>>>    power-domains:
>>> @@ -80,7 +87,9 @@ patternProperties:
>>>        node representing a TI instantiation of the Arm Cortex R5F core. There
>>>        are some specific integration differences for the IP like the usage of
>>>        a Region Address Translator (RAT) for translating the larger SoC bus
>>> -      addresses into a 32-bit address space for the processor.
>>> +      addresses into a 32-bit address space for the processor. For AM62x,
>>> +      the R5F Sub-System device node should only define one R5F child node
>>> +      as it has only one core available.
>>>  
>>>        Each R5F core has an associated 64 KB of Tightly-Coupled Memory (TCM)
>>>        internal memories split between two banks - TCMA and TCMB (further
>>> @@ -100,11 +109,12 @@ patternProperties:
>>>      properties:
>>>        compatible:
>>>          enum:
>>> -          - ti,am654-r5f
>>> -          - ti,j721e-r5f
>>> -          - ti,j7200-r5f
>>> -          - ti,am64-r5f
>>> -          - ti,j721s2-r5f
>>> +          - ti,am62-r5fss
>>> +          - ti,am64-r5fss
>>> +          - ti,am654-r5fss
>>> +          - ti,j7200-r5fss
>>> +          - ti,j721e-r5fss
>>> +          - ti,j721s2-r5fss
>>>  
> There is a problem here, the compatibles still need to be "-r5f" I will
> correct it in V4.
>>>        reg:
>>>          items:
>>> @@ -208,19 +218,35 @@ patternProperties:
>>>  
>>>      unevaluatedProperties: false
>>>  
>>> -if:
>>> -  properties:
>>> -    compatible:
>>> -      enum:
>>> -        - ti,am64-r5fss
>>> -then:
>>> -  properties:
>>> -    ti,cluster-mode:
>>> -      enum: [0, 2]
>>> -else:
>>> -  properties:
>>> -    ti,cluster-mode:
>>> -      enum: [0, 1]
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          enum:
>>> +            - ti,am64-r5fss
>>> +    then:
>>> +      properties:
>>> +        ti,cluster-mode:
>>> +          enum: [0, 2]
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          enum: ["ti,am654-r5fss", "ti,j7200-r5fss", "ti,j721e-r5fss",  "ti,j721s2-r5fss"]
>>
>> That's not how enums are spelled for such cases. Git grep for examples -
>> this should be a enum with each item in new entry, no quotes.
> Yeah, that was my initial thought but then I looked at section 4.9.3 of
> https://json-schema.org/understanding-json-schema/UnderstandingJSONSchema.pdf
> which had below example and based on that did this change thus avoiding
> separate entries for each enum.
> 
> Example:
> {
> "enum": ["red", "amber", "green", null, 42]
> }
> 
> To confirm whether the change works fine, I deliberately modified cluster-mode
> values for each of the SoC's beyond acceptable ranges as seen in
> https://gist.github.com/devarsht/1956063c8e39f1bdbad3574ea96b95a3
> and then ran "make dtbs_check" and it was able to catch the inappropriate
> values of cluster-mode as seen in below logs :
> 
> https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L392
> https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L500
> https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L712
> https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L741
> https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L750
> https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L766
> https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L773
> 
> Kindly let me know if you see some issues with this approach.

Your syntax is correct just not matching the coding style. Use coding
style matching existing bindings. It's the same in C. Just because you
can write:

void max() {
    ...
}

does not mean we accept such code.

Best regards,
Krzysztof

