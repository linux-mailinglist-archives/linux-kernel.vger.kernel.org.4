Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B8461EFB9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiKGJ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiKGJz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:55:58 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4729110D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:55:56 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id d3so15386580ljl.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLtEeCFiCxXJ7VuUQxzHQNxi1R/lqsAPobiPIap7VVA=;
        b=dL7S+hw+wOWhAN4nphHdzh4DQicj7fMvPh3u8c8zuOP66Wn4StLnil1Caxp1iMpvYx
         us4mV7FtXnrgsxyDIV6dl532vc0kGUtNlo2F/JNCsDOz7vUktP0m431Z88ZL3N03KNWo
         lziwpMT/0S9NXR2wINoQGyuy35qscW1YojLlBdSTLptDUw9KWQfQbQ7bR5fDYYAOFC+x
         5DcA6yIz07aLmGf4jwOM2JWN4x8KnkdeJuymFiX04c7IL7YyquimT6UjtezgDUwCkT7Y
         iMZmwP3usreIgjQmZ3v5ej/xJkLsfCMXvVNZtOCBedKjMNFsB0N1bFR9rqP9hsFgAiPj
         rD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLtEeCFiCxXJ7VuUQxzHQNxi1R/lqsAPobiPIap7VVA=;
        b=4PUqhvfBXeUv2OQDX5LnCFnc90w8UKusXXe9zIuM0QolfzCx6PB/STdYmx6o5czXHP
         J15P1L53xPUqoqYlax8nFn/pELFiOwsIR2K1nMlnIQGALRYOxFwjKAmsPA6DmfpGkKQF
         gC1xllVWpBch7tzG5Yivv5pwaCx21F5Ky3jLLanjqDkSSrVxsVstwRnlx2EWssCsIifa
         sbtqcpo0fZMaJqyskn+Eonbufq+yZlbUetJA3fVfXfqiu7rBKVWsvF4yhxDwBNxTZAAW
         sJHjC4GcKz0xeG/bYL+tJ7/Kr8zhiJXBqVVL19/4XY4JS1cWTYOcoZYLt5FWEBI8AgnO
         Vcpw==
X-Gm-Message-State: ACrzQf1+T5E3yJlgkhkeyI72dCxJ0DkvSjRh0AXFfbKqtRu8rGT1vL8n
        SO8jjlSqaHv1YqKW5VtsJl55GA==
X-Google-Smtp-Source: AMsMyM69ATpe2QDRjleiuM/qB2AaNZ1K/eRBa4DKma6gQUdzgFkQoWcazLLmirIElWvKVk/7P8epyw==
X-Received: by 2002:a2e:a553:0:b0:277:8b20:46bb with SMTP id e19-20020a2ea553000000b002778b2046bbmr5498982ljn.320.1667814955211;
        Mon, 07 Nov 2022 01:55:55 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id 13-20020a05651c128d00b0027712379ec8sm1144495ljc.28.2022.11.07.01.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 01:55:54 -0800 (PST)
Message-ID: <e92beaac-aa88-0336-cb30-7de438de67c9@linaro.org>
Date:   Mon, 7 Nov 2022 10:55:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] dt-bindings: interrupt-controller: add yaml for
 LoongArch CPU interrupt controller
Content-Language: en-US
To:     Liu Peibao <liupeibao@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107023404.26730-1-liupeibao@loongson.cn>
 <20221107023404.26730-2-liupeibao@loongson.cn>
 <b45b8cf8-de9d-7132-1a35-48deeb4b79d5@linaro.org>
 <196e80d8-f4fb-7393-81a5-bca757c805f5@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <196e80d8-f4fb-7393-81a5-bca757c805f5@loongson.cn>
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

On 07/11/2022 10:21, Liu Peibao wrote:
> On 11/7/22 4:28 PM, Krzysztof Kozlowski wrote:
>> On 07/11/2022 03:34, Liu Peibao wrote:
>>
>> Add commit msg explaining what you are doing here (e.g. the hardware).
>>
> 
> I just add this yaml for what I did in patch 1/2 and the header seems enough
> to describe what I want to, so I did not add the commit log.

This should instead describe briefly the hardware here.

> 
>>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>>> ---
>>>  .../loongarch,cpu-interrupt-controller.yaml   | 42 +++++++++++++++++++
>>>  1 file changed, 42 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
>>> new file mode 100644
>>> index 000000000000..30b742661a3f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
>>> @@ -0,0 +1,42 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/interrupt-controller/loongarch,cpu-interrupt-controller.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: LoongArch CPU Interrupt Controller
>>> +
>>> +description: >
>>> +   On LoongArch the loongarch_cpu_irq_of_init() helper can be used to initialize
>>> +   the 14 CPU IRQs from a devicetree file and create a irq_domain for this IRQ
>>> +   controller.
>>> +
>>> +   With the irq_domain in place we can describe how the 14 IRQs are wired to the
>>> +   platforms internal interrupt controller cascade.
>>
>> This should be the description of hardware, not Linux drivers.
>>
> 
> OK, I will remove this in the next version of this patch.
> 
>>> +
>>> +maintainers:
>>> +  - Liu Peibao <liupeibao@loongson.cn>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: loongarch,cpu-interrupt-controller
>>
>> You have exactly one and only one type of CPU interrupt controller for
>> all your Loongarch designs? All current and all future? All?
>>
> 
> It is sure of that "all current and recent designs". It is really hard to limit the
> design in the distant future.
> 
> And if there is updating, maybe I will add additional things like this:
> "loongarch,cpu-interrupt-controller-2.0".

Unless you have a clear versioning of your hardware, adding 2.0 won't be
correct. Don't you have this for specific SoC?

Best regards,
Krzysztof

