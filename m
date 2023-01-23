Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF5A67808E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjAWPw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjAWPww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:52:52 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF411BD0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:52:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l8so9376352wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/tZ8f/hKuTnmPmwm/3gfR1U9pPYCEdQziOfOTsHWD8=;
        b=TCXyArpwkAYCRDfZdgOD2gG5tf1XscU6cRLcpKr8YcqSwXGE1Hbdh6WcdLTcNM1A+v
         +yiZgwW3u/17k5TuCdfHv5Y7P8vYYeJ71i1Q8xBGLpgr+mo25UedeqZCPViGsKO1p74E
         Yx3oi0jPjP1m9IaYG3yhyICLWUKaWyPAkxCMqNSvyt6ozOKnlbQHWd9jIrkXbQ3H265S
         gUZz3KZrXaMntBZkIjne9xs1kbUuY8vYMHXAIAPowBhTznp7akNPSIUTfFKFR9P+0rCE
         t4qsPaaOFTtr9erNSp21NGWkrwnkxJtgNFOx1fZo8s56ai8iWom8/hn3rETqxhqmCSZM
         ExsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/tZ8f/hKuTnmPmwm/3gfR1U9pPYCEdQziOfOTsHWD8=;
        b=eBpM7qftF76jQ3vfeZ8r+kVw7bLS7XQ9ha5dV1ldbvJMC3Wqq0sWOZY2vRQO2VSyJl
         8l8W/3npQfkypXwY2iKHuVQPmooqJUYw9JXJA7kJwweTgFoNaIoPEL1j+7D1GAEvWrj8
         3ZsTyHMosnxwa4q2XkewS1jw1QagICX3+dPQpbZntWVgfW/+aouLYfLalFrh6G8c9O0r
         zmoi1xDhPyJ9cp1d6Fkti2IcsZIVv7IJdFTbuZiRCKM/96wGlUloH6R1hXM5CHWBhgVK
         UjG7ZVpmI8Wq1uGvikIV/VhyucefqtttJSnb7jwZAvQd7i5WGK1h/GR8MLPLor+fopD1
         xCKw==
X-Gm-Message-State: AFqh2kqIoK6puKl8VA+OKzTD/D9oSM4hyKVX9yBW+XP9IYomsUyPhDV2
        4+c1AS12/p+b8V5sKzdgGOKuFJSgSqq9El6c
X-Google-Smtp-Source: AMrXdXsvW74isMnE439bftM+OiixytOe6bWOxjDuWosmwOrIoj8bddguUkHujZ5s9OEGL+NVoCbNAA==
X-Received: by 2002:a05:600c:1d12:b0:3db:53f:baea with SMTP id l18-20020a05600c1d1200b003db053fbaeamr24195728wms.6.1674489168770;
        Mon, 23 Jan 2023 07:52:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f23-20020a7bc8d7000000b003d358beab9dsm10811991wml.47.2023.01.23.07.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:52:48 -0800 (PST)
Message-ID: <2b210dc5-fe63-d295-a488-2988601424f3@linaro.org>
Date:   Mon, 23 Jan 2023 16:52:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 04/15] dt-bindings: arm: add support for Ambarella SoC
Content-Language: en-US
To:     Li Chen <me@linux.beauty>
Cc:     Li Chen <lchen@ambarella.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-5-lchen@ambarella.com>
 <7d191871-1025-43a3-20bf-8fc6b3f92c89@linaro.org>
 <875ycxi8xm.wl-me@linux.beauty>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <875ycxi8xm.wl-me@linux.beauty>
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

On 23/01/2023 16:09, Li Chen wrote:
> On Mon, 23 Jan 2023 16:07:32 +0800,
> Krzysztof Kozlowski wrote:
>>
>> On 23/01/2023 08:32, Li Chen wrote:
>>> Create a vendor directory for Ambarella, and add
>>> cpuid, rct, scratchpad documents.
>>>
>>> Signed-off-by: Li Chen <lchen@ambarella.com>
>>> Change-Id: I2c29e45c08666489b0d9b588ac37d713f5b723d1
>>
>> Please run scripts/checkpatch.pl and fix reported warnings.
>>
>> Applies to all your patches. Also test them... I have doubts that you
>> tested if you actually ignored checkpatch :/
> 
> Yeah, I checkpatch all patches, and have planned to fix Change-Id finally(manually),
> but forget it before sending mails, my bad, sorry. I will remove it in v2.
> 
>>> ---
>>>  .../arm/ambarella/ambarella,cpuid.yaml        | 24 +++++++++++++++++++
>>>  .../bindings/arm/ambarella/ambarella,rct.yaml | 24 +++++++++++++++++++
>>>  .../arm/ambarella/ambarella,scratchpad.yaml   | 24 +++++++++++++++++++
>>>  .../bindings/arm/ambarella/ambarella.yaml     | 22 +++++++++++++++++
>>>  MAINTAINERS                                   |  4 ++++
>>>  5 files changed, 98 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/arm/ambarella/ambarella,cpuid.yaml
>>>  create mode 100644 Documentation/devicetree/bindings/arm/ambarella/ambarella,rct.yaml
>>>  create mode 100644 Documentation/devicetree/bindings/arm/ambarella/ambarella,scratchpad.yaml
>>>  create mode 100644 Documentation/devicetree/bindings/arm/ambarella/ambarella.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/ambarella/ambarella,cpuid.yaml b/Documentation/devicetree/bindings/arm/ambarella/ambarella,cpuid.yaml
>>> new file mode 100644
>>> index 000000000000..1f4d9cec8f92
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/ambarella/ambarella,cpuid.yaml
>>
>> This goes to soc
> 
> Thanks, I wasn't aware that there is a document dir named soc. I will move cpuid yaml
> to bindings/soc/ambarella/, and leave other yaml still here.

However if device has chip identification features (chipid), then the
location is "hwinfo".

> 
>>> @@ -0,0 +1,24 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/ambarella,cpuid.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Ambarella SoC ID
>>> +
>>> +maintainers:
>>> +  - Li Chen <lchen@ambarella.com>
>>
>> Missing description.
> 
> Sorry, description will be added in v2. BTW, does other YAMLs in this patch
> also need descriptions?

In general yes - we want descriptions which will bring additional
information. Description should not repeat title, but add more data. For
trivial cases - maybe actually this one SoC ID - you can skip it.



> 
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: "ambarella,cpuid", "syscon"
>>
>> Drop quotes (applies to all your patches)
> 
> OK, thanks!
> 
>> Missing SoC specific compatible.
>>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>
>> Missing additionalProperties. sorry, start from scratch from some
>> existing recent bindings or better example-schema.
> 
> Good to know that there is example-schema, thanks!
>  
>>> +
>>> +examples:
>>> +  - |
>>> +    cpuid_syscon: cpuid@e0000000 {
>>> +        compatible = "ambarella,cpuid", "syscon";
>>> +        reg = <0xe0000000 0x1000>;
>>> +    };
>>> diff --git a/Documentation/devicetree/bindings/arm/ambarella/ambarella,rct.yaml b/Documentation/devicetree/bindings/arm/ambarella/ambarella,rct.yaml
>>> new file mode 100644
>>> index 000000000000..7279bab17d9e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/ambarella/ambarella,rct.yaml
>>> @@ -0,0 +1,24 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/ambarella,rct.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Ambarella RCT module
>>> +
>>> +maintainers:
>>> +  - Li Chen <lchen@ambarella.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: "ambarella,rct", "syscon"
>>
>> All the same problems.
> 
> Well noted.
> 
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +examples:
>>> +  - |
>>> +		rct_syscon: rct_syscon@ed080000 {
>>
>> Really? Just take a look and you will see wrong indentation. Also drop
>> underscores in node names and "rct". Node names should be generic.
> 
> Sorry for the wrong indentation, will fix it in v2.
> 
> Is it ok to contain underscores in lable? if so, I will change it into
> 
> rct_syscon: syscon@ed080000 {

Yes, label can have it.

Best regards,
Krzysztof

