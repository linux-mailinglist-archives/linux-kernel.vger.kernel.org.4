Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B3A5B6B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiIMKSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiIMKSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:18:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9E54F6A0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:18:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id e18so2945068wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=I+M97uZ2SUDMcnWsz9PVdd3054YjNSAnZPQzh7ZVcLQ=;
        b=VoU+CDMZZY+l/aTqKKx07K/f861xCWQoQ6q11qvl+xPxRATbLnw0cLZwf33woDJo83
         rowFTquWsHzEYJRXb+hf+Kr49wzRhw9ggf+/SsoEbqwT+Bf5SfUxJk71XpUO0jzL0/g1
         0j4B4gyOCCxxr+bTRvExdwGYjQwNcqWPQeg/ZNCjy1dNDqUHl2aNx1AdJgloUmL1r4fc
         9av1lVetEQ5FVmj5WeILs7cJ9qLY9jCcPW1636zdeLLSdVpGKOn+M+MHgHuEJs2UTNxE
         gPuEA51s5QePuMPpphseW8KUlN5XicoezBki7I8U60zybmp99deLwnxljQuP5T4ugw7Y
         QqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=I+M97uZ2SUDMcnWsz9PVdd3054YjNSAnZPQzh7ZVcLQ=;
        b=yvkgPBIVU3gt3VpEwa0OYFZ+806X6er2E39+fly9Xkk1svGHMGdn6H04aHpd2cLpkB
         UGrU/yxS0fr2G6p1Q0+2g4lyxzpQ4zGpY0DAaDtDE5gLOHIIHWjSXTynaT/PzPiJdtU3
         laX+Vh27B38SNBeW9e13LAhvy3p7VxTuFgNx5TBm2Nknl5VnwTDMBa/2k7QYW91W1Jz+
         YT3+AchL1saf9DxEFI2U1qTwfrF91SpP4lfjHqfgapTBR1GsiYkWhhO7L+bZHWgZ2gSl
         WjG/culAdmQjwXLKsEvBIKsvryko1x5/O9TRcLSkWbiCs4mLK4MLB+EygVFKPNy3uoCK
         neuQ==
X-Gm-Message-State: ACgBeo2qWxH74vdMBTHGG0L77P8TD/hLRe3XwHUb5LwPsyfnp7SvG4r6
        gzPVjEY8ykQpBZa5EHfniv9EXw==
X-Google-Smtp-Source: AA6agR5U5hqBAganLTVfF0XB1Ywpe6R1L1pyDTc3Cz6O372x5IG/3zq9SFN2eqwY0YZ6W5AfdbuJQA==
X-Received: by 2002:a05:600c:1c03:b0:3b4:618b:5d14 with SMTP id j3-20020a05600c1c0300b003b4618b5d14mr1727662wms.59.1663064280289;
        Tue, 13 Sep 2022 03:18:00 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.70])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b00228dcf471e8sm9883512wrq.56.2022.09.13.03.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 03:17:59 -0700 (PDT)
Message-ID: <48080f45-ea9d-e8dc-7720-ef82fc84e3b3@linaro.org>
Date:   Tue, 13 Sep 2022 12:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 2/3] dt-bindings: phy: ti: phy-gmii-sel: Add bindings
 for J7200
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     robh+dt@kernel.org, lee.jones@linaro.org, kishon@ti.com,
        vkoul@kernel.org, dan.carpenter@oracle.com,
        grygorii.strashko@ti.com, rogerq@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20220912085650.83263-1-s-vadapalli@ti.com>
 <20220912085650.83263-3-s-vadapalli@ti.com>
 <7a673b7c-9e04-2a23-98b9-243696597bba@linaro.org>
 <d802f419-f2d6-faca-e0a9-591f4d705b28@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d802f419-f2d6-faca-e0a9-591f4d705b28@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 11:45, Siddharth Vadapalli wrote:
> Hello Krzysztof,
> 
> On 13/09/22 14:57, Krzysztof Kozlowski wrote:
>> On 12/09/2022 10:56, Siddharth Vadapalli wrote:
>>
>>>  required:
>>>    - compatible
>>>    - reg
>>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>> index 016a37db1ea1..da7cac537e15 100644
>>> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>> @@ -53,12 +53,25 @@ properties:
>>>        - ti,am43xx-phy-gmii-sel
>>>        - ti,dm814-phy-gmii-sel
>>>        - ti,am654-phy-gmii-sel
>>> +      - ti,j7200-cpsw5g-phy-gmii-sel
>>>  
>>>    reg:
>>>      maxItems: 1
>>>  
>>>    '#phy-cells': true
>>>  
>>> +  ti,qsgmii-main-ports:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    description: |
>>> +      Required only for QSGMII mode. Array to select the port for
>>
>> Not really an array...
>>
>>> +      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
>>> +      ports automatically. Any one of the 4 CPSW5G ports can act as the
>>> +      main port with the rest of them being the QSGMII_SUB ports.
>>> +    maxItems: 1
>>
>>
>> You say it is an array, but you have here just one item, so it is just
>> uint32. Do you expect it to grow? If so, when? Why it cannot grow now?
> 
> Thank you for reviewing the patch.
> 
> I have defined it as an array because I plan to reuse this property for
> other TI devices like J721e which supports up to two QSGMII main ports.
> J7200 on the other hand can have at most one QSGMII main port, which is
> why I have restricted the array size to one element as of this series.
> In the upcoming patches that I will be posting for J721e, I will be
> changing the maxItems to 2 for J721e's compatible while it will continue
> to remain 1 for J7200's compatible. This is the reason for defining the
> property as an array.

I have an impression that I asked this and you already replied... so
apologies for asking again. :)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
