Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803B0660F10
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 14:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjAGNZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 08:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjAGNZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 08:25:10 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F165831B
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 05:25:08 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w13so2361769wrk.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 05:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUIOJzfR4gjCubzJSweWARYQ7jO/K6ZEKw9R7MAtXPo=;
        b=onkbVc1rbEvGZygqbjpv2XpS5zkxuHUDgg44EIw1OuUNmXjWAcTAmvpHRZRll8WJQp
         G0jg7xCmF+cTL38qYRcUHPoQt1bhC3SfRvp85mk1zCw+RPZiXbb77M6v3a2Wjm+Phe3r
         /Gh9/tAp8hnGMaWMywn1kZVl7sBXbyon3U1ThTX2GoNqSE6KepUQCmsOXy6wMkjckXQq
         EqSJ/fiwiuypfW17kSxD8ZW9Hpu+YfFbuRkpe1Qjlz0p3/7RjoqrfvLJmfjxsAg0X0Aj
         v93NJ9nbfYV6WP2nBzBOsuw5SEegbQS4LZwJxBc2RITKHZLMMXc9Cqn7vhMyT5iX8Kbp
         hPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUIOJzfR4gjCubzJSweWARYQ7jO/K6ZEKw9R7MAtXPo=;
        b=dQTBI3CH4hok/y7nFuu6Ch42OszwLaveIK/U8HIuOHS4qHxd/TbE0gqPr3dDcIQWuq
         p+qkzsddy5mt0MWphmUdFXXeI6uZjFAr5/cwFOWIrYPB9A+emS+T8iE8s55u7Je/+u30
         a55KEBqdZ7r5JXQrM9jndP5piFfQm7Y5DO4UjfAb7/ONVfrT9SwCjqx1yZQdBEOOJeHC
         mIyZ/HqaCUz/HgmFWpf8q6chzgwEycar/TERlim+8ke8SLx4Anlx3R2WjYHp2AEi3wY9
         iDDAPGpVRTKEjOX9sYnW88+jG/LFzqAn0j2BvdN6eqUzDN7j5jYpg/1pRAA+y/G7ivd3
         nQ4w==
X-Gm-Message-State: AFqh2kq4gVyTDH1yC42sxNG0yBkTWaeMSDukLaB6Y5v0Mj9uc/zJutT6
        vBsK1/MUYbiH+x4WKzhmMsa4fA==
X-Google-Smtp-Source: AMrXdXsd4OlFrcapKoOIiiaSo59QJSOXueVuWMfL/ztMFbpKKDNEQLKruccFGDwsD/RBiTen9q8fqA==
X-Received: by 2002:adf:ef49:0:b0:28b:a241:9870 with SMTP id c9-20020adfef49000000b0028ba2419870mr19927855wrp.47.1673097907042;
        Sat, 07 Jan 2023 05:25:07 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s2-20020adff802000000b00241bd7a7165sm3818637wrp.82.2023.01.07.05.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 05:25:06 -0800 (PST)
Message-ID: <f9d4c883-4b76-c95e-c6dc-a659b4410bf2@linaro.org>
Date:   Sat, 7 Jan 2023 14:25:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/5] dt-bindings: mmc: sdhci-cadence: SD6 support
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org,
        jannadurai@marvell.com, cchavva@marvell.com
References: <20221219142418.27949-1-pmalgujar@marvell.com>
 <20221219142418.27949-4-pmalgujar@marvell.com>
 <5fc29d3c-e3da-3dc4-bce5-2158b81daa43@linaro.org>
 <20230106164812.GA14720@Dell2s-9>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106164812.GA14720@Dell2s-9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 17:48, Piyush Malgujar wrote:
> Hi Krzysztof,
> 
> Thank you the review comments.
> 
> On Mon, Dec 19, 2022 at 04:40:35PM +0100, Krzysztof Kozlowski wrote:
>> On 19/12/2022 15:24, Piyush Malgujar wrote:
>>> From: Jayanthi Annadurai <jannadurai@marvell.com>
>>>
>>
>> Subject: use final prefix matching the file, so "cdns,sdhci:"
>>
>>> Add support for SD6 controller support
>>
>> Full stop.
>>
>>>
>>> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
>>> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
>>> ---
>>>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 33 +++++++++++++++++--
>>>  1 file changed, 31 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>>> index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..2043e78ccd5f708a01e87fd96ec410418fcd539f 100644
>>> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>>> @@ -4,7 +4,7 @@
>>>  $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
>>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>  
>>> -title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
>>> +title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
>>>  
>>>  maintainers:
>>>    - Masahiro Yamada <yamada.masahiro@socionext.com>
>>> @@ -19,6 +19,7 @@ properties:
>>>            - microchip,mpfs-sd4hc
>>>            - socionext,uniphier-sd4hc
>>>        - const: cdns,sd4hc
>>> +      - const: cdns,sd6hc
>>
>> Does not look like you tested the DTS against bindings. Please run `make
>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>> for instructions).
>>
>> ... because it does not really make sense. Why do you require SD6HC as
>> fallback? I think you meant enum.
>>
> 
> Yes, that's correct. I will change it to enum.
> 
>>>  
>>>    reg:
>>>      maxItems: 1
>>> @@ -111,6 +112,34 @@ properties:
>>>      minimum: 0
>>>      maximum: 0x7f
>>>  
>>> +  cdns,iocell_input_delay:
>>
>> No underscores. Use proper units in name suffix:
>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
>>
>>
>>> +    description: Delay in ps across the input IO cells
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>
>> Ditto... and so on - all of the fields.
>>
>>> +
>>> +  cdns,iocell_output_delay:
>>> +    description: Delay in ps across the output IO cells
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>> +
>>> +  cdns,delay_element:
>>> +    description: Delay element in ps used for calculating phy timings
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>> +
>>> +  cdns,read_dqs_cmd_delay:
>>> +    description: Command delay used in HS200 tuning
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>> +
>>> +  cdns,tune_val_start:
>>> +    description: Staring value of data delay used in HS200 tuning
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>> +
>>> +  cdns,tune_val_step:
>>> +    description: Incremental value of data delay used in HS200 tuning
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>> +
>>> +  cdns,max_tune_iter:
>>> +    description: Maximum number of iterations to complete the HS200 tuning process
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>
>> Why these three are properties of DT?
>>
> 
> These tuning parameters are added here so to make them custom configurable for different
> boards.

I understand why do you wanted to add them, but I am asking why these
are suitable for DT? DT  describes hardware, so what is here specific to
hardware which requires DT property?


Best regards,
Krzysztof

