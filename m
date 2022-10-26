Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1560360E2E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiJZOKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiJZOKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:10:10 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BEE5B9DD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:10:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a24so9913894qto.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BQB9LE7X1mCYhNc9+nFdeObc7ed6tkF8e0uuVutB30=;
        b=sQ7IsU1CiBcoRGEAgKEV6c76L7qJJk7yUxMEatTQMNVGIUQTs7sXGKRpqXxxgPV2Hj
         vOyWsgWHh8VTRxX8+mqXN/hasV2n8vF11lv9Cvh/MybH3EOfc3N5ZrL2cK7IXzRvq3jV
         SR29M/9/IwDm3Q5uAGHq79HNEIquAa2ojF8Tc1kiMlqXmd1RZejaxUbIras8336owz/4
         pL9MIsaF6bvJsv+0EcIQLeh3t2w+auSBylOspvMLkDCztqBfpj3/1AaeUbn+BP4T+sBx
         cnQrKgvwncSipcELJMKa65zwpdw0U7J//odGAC8jV8fd90xnb+ucDEqi7uL3yHTMlYTr
         LgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BQB9LE7X1mCYhNc9+nFdeObc7ed6tkF8e0uuVutB30=;
        b=XvirKqafLnUmEpjhDw07PutRCnVhGkTkGuwKEXUE1nTKAyeAAyYcma6qbFG3frxnXl
         SVU2MgNThy8dd86ZwN2DOhLTiH+0cV/EuqCsc8EtySgUdU5Xssuf66LioL+KV8Dle3SP
         IUCfeDH0Bh7rD2us6luQhR1vOe2ToTgxijuxtL3Br37uBLf0fuZKrzmqBrZgUq7i7V6m
         MD+NLcUcX6jflN+ZbQIbfPr0dNcXOegVT58ZSV6We+YyF8+P1JwY1za/pC/TqLmX29l8
         yNhnM70qhrwZHEG2bWZgdc6JcwJIwcdKrUYnZGRGNytpkUuczQqXGCVvka9Pn6k6E1DQ
         mVqQ==
X-Gm-Message-State: ACrzQf2Nl/OUb7fHE7w8vIyNvnbBzTTZyd8bOu9MbZ0po34nJ0Ary0Zg
        0rrnaOfck/XRyEf0qGrQvhCtEw==
X-Google-Smtp-Source: AMsMyM5BNUCuZuEn7EexVi/fGYD/efXM+jztPifc0NCoJWz5T38JEzAuOICnBPaVYQs7GOackqII1g==
X-Received: by 2002:ac8:7e96:0:b0:39c:d833:e8c3 with SMTP id w22-20020ac87e96000000b0039cd833e8c3mr36807119qtj.303.1666793404622;
        Wed, 26 Oct 2022 07:10:04 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id l16-20020a05622a051000b0039ee562799csm3277991qtx.59.2022.10.26.07.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:10:03 -0700 (PDT)
Message-ID: <ae7cf416-f7b9-2316-5bb2-0043651ed0fd@linaro.org>
Date:   Wed, 26 Oct 2022 10:10:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/2] dt-bindings: soc: add loongson2 guts
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, loongarch@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221025035128.21068-1-zhuyinbo@loongson.cn>
 <20221025035128.21068-2-zhuyinbo@loongson.cn>
 <7c67c721-685a-fa0e-ab4b-41b7de3ea0a0@linaro.org>
 <52de60bd-8aa5-a461-9bca-ce8e6f82ead8@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <52de60bd-8aa5-a461-9bca-ce8e6f82ead8@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 03:22, Yinbo Zhu wrote:
> 
> 
> 在 2022/10/26 上午3:40, Krzysztof Kozlowski 写道:
>> On 24/10/2022 23:51, Yinbo Zhu wrote:
>>> Add the loongson2 soc guts driver binding with DT schema format
>>> using json-schema.
>>>
>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>> ---
>>>   .../soc/loongson/loongson,ls2k-guts.yaml      | 37 +++++++++++++++++++
>>
>> Looks like wrong location, although difficult to judge because you did
>> not describe the hardware at all. If this is chipinfo-like device, then
>> Documentation/devicetree/bindings/hwinfo/.
> My guts driver is refer fsl platform. It was was to manage and access
> global utilities register block for SoC and it was only used in SoC
> platform. when driver need use Soc ops to do some function the this 
> driver was needed.  the dcfg (device config) was a function in guts 
> (global utilities) block.

I can barely understand it.

> For these type of driver, other platforms were initially placed on
> Documentation/devicetree/bindings/arm/   if it is arm/arm64
> architecture. Later, move it to the soc directory.
> 
> Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml

How is this related? This is Layerscape, not Loongson2. Describe the
hardware you are adding bindings for.

> 
> So, do you still think it is inappropriate to place it in the soc dir?
>>
>>
>>>   MAINTAINERS                                   |  1 +
>>>   2 files changed, 38 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
>>> new file mode 100644
>>> index 000000000000..2502f8aeb74d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
>>> @@ -0,0 +1,37 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/soc/loongson/loongson,ls2k-guts.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Loongson2 GUTS driver.
>>
>> Drop "driver." unless you refer to some hardware (like motor driver?).
> this need refer hardware soc datasheet to gain soc register (global 
> utilities register block ).
> so keep "driver" string that whether was more appropriate?

What? I cannot parse it.

Did you understand my comment? If yes, please point to Wikipedia article
explaining this "Driver" you refer to.


>>
>>> +
>>> +maintainers:
>>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>>> +
>>> +description: |
>>> +  GUTS driver was to manage and access global utilities block. Initially
>>
>> Drop "driver" and describe instead what is GUTS, including its acronym,
>>
>>> +  only reading SVR and registering soc device are supported.
>>
>> Entire sentence describe Linux driver - drop it. Instead describe the
>> device, the hardware.
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: loongson,ls2k-guts
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  little-endian: true
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    guts: guts@1fe00000 {
>>
>> Node names should be generic.
> dcfg/scfg (device cfg/ soc cfg)was the key function of guts (global 
> utilities) block. and guts name I was refer fsl soc driver. 
> "drivers/soc/fsl/guts.c"
> this binding file was follows of fsl guts.
> Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
> Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
> 
> or, I was use scfg as node name, Do you think it's appropriate?

No, these are not generic node names.

> 
> 
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Best regards,
Krzysztof

