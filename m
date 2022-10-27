Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FE260F838
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiJ0M5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbiJ0M5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:57:01 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAF1171CE2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:56:57 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id j6so1129474qvn.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCO64SkNwxVGG1ag/c7O3RrYpoMWZcVRtx+sb3WRBdM=;
        b=Mn4UEB1jx0Qdiy3QuA1RzSM1lDNgVbi4heOCcoPNcJtx+/NG28n1JCY7CVARu6tx8v
         9mFC1fVjFB7DYJ5ux1bABi4xsRpSXcNRgR4QPHLHD2/c/9g3bK0YXoDYhwuNLOvJuKww
         YQaXgP/7Q8DZhov+Blslx+MhFvEqjcI0bkhT2YYqqHtjSVTjK4aHubr7yR/g12OP/arj
         Fz15n+9GllhHQ5ti7rt3+zu9xStLe0iI3aegxh/Y8WW/LSp3ASzLPlM20j0BGYdE4hwa
         vbM4wjrTbtoyui76/uLWtG+idBJB+G5RMjszrlyUUE4WxpX9eBhOUIflv3TiV4cn+ACu
         ApQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCO64SkNwxVGG1ag/c7O3RrYpoMWZcVRtx+sb3WRBdM=;
        b=l48eeaq5kVANq5XOylXlaeertckgKexN3H4SnoooPeHoHk/f33w2rWK2A0Ti6PHqYl
         u4dU6UmqdsIjG5umx6rmE/SOqTxpHgtRLFx1CiErDKHxX53/l4ITXtOhPV+bKMq/dPPu
         hGZSxy/soK29tfOKwu/rHw0AI97noqonfyerxLAI48mOQyVYluyUrt8tgOHCFPQg6fnG
         3WRnWBCDvQviOSeVNBbTa1zNfPt3iBhVdnwMrI7M9U4+0Fels9xTe+WySXItesggsm2w
         rA8vSR/Y3am8SkJkYexLGlsOw+n0rIDHCea07W/X/pVZcVP1rTohErn+Otaq2BP43MSV
         Gt/w==
X-Gm-Message-State: ACrzQf1Ygj+CdufkwdDirTQApfLFttQ5S8cYr3wtw65+BIqW7e3QVdFZ
        akiu/hhI0lPClV12ZYDnbI6CQXNCozQ/Xw==
X-Google-Smtp-Source: AMsMyM5zWzthkb3qrJEd1AJr37EXmT5WBPwcs3gJYiw0SeknjIW5iLzQWI2HIYlaL/cJ/rL1jM2i/g==
X-Received: by 2002:a05:6214:21ce:b0:4bb:7392:c94d with SMTP id d14-20020a05621421ce00b004bb7392c94dmr16781666qvh.71.1666875416776;
        Thu, 27 Oct 2022 05:56:56 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id o8-20020ac841c8000000b0039cd508f1d3sm811749qtm.75.2022.10.27.05.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 05:56:55 -0700 (PDT)
Message-ID: <b804457b-2d69-3eb8-38e2-955542cdd0b8@linaro.org>
Date:   Thu, 27 Oct 2022 08:56:54 -0400
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
 <ae7cf416-f7b9-2316-5bb2-0043651ed0fd@linaro.org>
 <7bd6db22-210b-d8ff-7476-b2e38dc7c683@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7bd6db22-210b-d8ff-7476-b2e38dc7c683@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 23:52, Yinbo Zhu wrote:
> 
> 
> 在 2022/10/26 下午10:10, Krzysztof Kozlowski 写道:
>> On 26/10/2022 03:22, Yinbo Zhu wrote:
>>>
>>>
>>> 在 2022/10/26 上午3:40, Krzysztof Kozlowski 写道:
>>>> On 24/10/2022 23:51, Yinbo Zhu wrote:
>>>>> Add the loongson2 soc guts driver binding with DT schema format
>>>>> using json-schema.
>>>>>
>>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>> ---
>>>>>    .../soc/loongson/loongson,ls2k-guts.yaml      | 37 +++++++++++++++++++
>>>>
>>>> Looks like wrong location, although difficult to judge because you did
>>>> not describe the hardware at all. If this is chipinfo-like device, then
>>>> Documentation/devicetree/bindings/hwinfo/.
> yes it is a chipinfo/socinfo device, I will following your advice.
>>> My guts driver is refer fsl platform. It was was to manage and access
>>> global utilities register block for SoC and it was only used in SoC
>>> platform. when driver need use Soc ops to do some function the this
>>> driver was needed.  the dcfg (device config) was a function in guts
>>> (global utilities) block.
>>
>> I can barely understand it.
> My description is about chipinfo/socinfo definition. and I have a look
> /bindings/hwinfo/, I think move binding file to hwinfo that is okay for me.
> 
> Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> 
>>
>>> For these type of driver, other platforms were initially placed on
>>> Documentation/devicetree/bindings/arm/   if it is arm/arm64
>>> architecture. Later, move it to the soc directory.
>>>
>>> Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
>>
>> How is this related? This is Layerscape, not Loongson2. Describe the
>> hardware you are adding bindings for.
> The driver functions/type are the same, the driver was register a struct 
> soc_device_attribute by soc_device_register then other peripheral driver
> can call SoC ops, such as soc_device_match.
> 
> then layerscape guts module bindings are placed in
> Documentation/devicetree/bindings/soc/, the loongson guts module 
> bindings was follow that layerscape and are placed in
> Documentation/devicetree/bindings/soc/
> 
> In a words,  It is a question about where the binding file should be 
> placed.  I think move binding file to hwinfo that is okay for me.

My review is limited to the scope I understand from what you wrote. You
described so far something being only a soc info registers. For this the
place is hwinfo.

The Layerscape dcfg is more than that - it is a syscon, system register
controller with at least one child device.

If your device is exactly like that, describe it in bindings fully, not
partially. These are then incomplete bindings.

>>
>>>
>>> So, do you still think it is inappropriate to place it in the soc dir?
>>>>
>>>>
>>>>>    MAINTAINERS                                   |  1 +
>>>>>    2 files changed, 38 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..2502f8aeb74d
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
>>>>> @@ -0,0 +1,37 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/soc/loongson/loongson,ls2k-guts.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Loongson2 GUTS driver.
>>>>
>>>> Drop "driver." unless you refer to some hardware (like motor driver?).
>>> this need refer hardware soc datasheet to gain soc register (global
>>> utilities register block ).
>>> so keep "driver" string that whether was more appropriate?
>>
>> What? I cannot parse it.
>>
>> Did you understand my comment? If yes, please point to Wikipedia article
>> explaining this "Driver" you refer to.
> I will remove the "driver" string.
>>
>>
>>>>
>>>>> +
>>>>> +maintainers:
>>>>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>> +
>>>>> +description: |
>>>>> +  GUTS driver was to manage and access global utilities block. Initially
>>>>
>>>> Drop "driver" and describe instead what is GUTS, including its acronym,
>>>>
>>>>> +  only reading SVR and registering soc device are supported.
>>>>
>>>> Entire sentence describe Linux driver - drop it. Instead describe the
>>>> device, the hardware.
>>>>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: loongson,ls2k-guts
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  little-endian: true
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    guts: guts@1fe00000 {
>>>>
>>>> Node names should be generic.
>>> dcfg/scfg (device cfg/ soc cfg)was the key function of guts (global
>>> utilities) block. and guts name I was refer fsl soc driver.
>>> "drivers/soc/fsl/guts.c"
>>> this binding file was follows of fsl guts.
>>> Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
>>> Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
>>>
>>> or, I was use scfg as node name, Do you think it's appropriate?
>>
>> No, these are not generic node names.
> I was refer "ti,k3-socinfo.yaml",  Do you think it's appropriate that 
> socinfo as node name?

The blocks are called usually chipid and you can find examples for that.
There are no examples using socinfo name.

If the main purpose of this register block (and/or device) is to provide
socinfo, then call it chipid.

Best regards,
Krzysztof

