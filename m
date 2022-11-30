Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A6063D969
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiK3P1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiK3P1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:27:18 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D1E7B4EA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:27:15 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f13so27478945lfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j/hCMazCxQ4yJMJ0+IeReR/A2RoSVYIA+Cs+VrsQQ0Y=;
        b=hxfOWWvWQVR4K7F8FVinn3S2TqmaONAv7a2VlLGBBWhUDu0pyp6WIc7tiMbrdUPlnI
         WWQjKTMwWxFaQK15L1DK3wgXsCWipFdC5ssd6GGrR1BDAO2x60oHbDgn02DAyLNZNp6y
         pDRoYyWVzgRh4kvYh1sTIwL0bGa9fCwxkfHFHuoCN0c4Jt0lovHN+c+Jqjpf8QZktr+K
         cTfprk4Bp8q1vMLoECDJ8dfzI2NdSRj/1DeTxpWz8kUefgjeHDGcxW4K4vobrdBTYR18
         gYJ5gqO2+IJTU1rWsqRLtahGFJUinNP82rYJdR3prJmEqJIbqmtsvbqzWDp0krqf4rwx
         JjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/hCMazCxQ4yJMJ0+IeReR/A2RoSVYIA+Cs+VrsQQ0Y=;
        b=R7+l2xYI23GaFlVbKUAKyPY9afVFXdB4xx7G/YoC/Gpoxh5covY1yAcHsYgdCKSI7q
         YWx8rybcQpmKq8bSakKax6EcO9Rl1Wwk0mbIfvWX06TqPniZ/q6LGM1q++G7U6HHBbT3
         Bc3xk730IbU7MVAcp8n9uAznJvuxY+b1UEoXx05Y4ZxHCjoNvRC9ZsjXbcrAD6Eqd9MB
         oKtYuGV36Td3NLYEhKgdq9qcpOjzAnq0Ll0f3LOjqvGSSxGLnxdUiKXXcoypomKwVUvk
         VeyBe9iv8ZdxabBWSsWDYUy+9IB9DzkHOIFvQUU1+60mAZL8qEPCDC1NihFJntcgVqH4
         waKg==
X-Gm-Message-State: ANoB5pnnEt9AjaA5hLI3TssOViCPhYlHEAM6uog09q6v262p4eZVk+4/
        43UxNL5hv0fHySt53i+uMZwEmw==
X-Google-Smtp-Source: AA0mqf705U8Ol7Gn+Z93s+DHy/DY+aJVeamPPsVE9PudAhDADfEEmsKkjUPc7JuCFPXM2QaDyFp2mg==
X-Received: by 2002:a05:6512:13a7:b0:4ad:5f5c:2b26 with SMTP id p39-20020a05651213a700b004ad5f5c2b26mr19857325lfa.626.1669822033602;
        Wed, 30 Nov 2022 07:27:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v3-20020a05651203a300b004a4754c5db5sm288974lfp.244.2022.11.30.07.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:27:13 -0800 (PST)
Message-ID: <24add13e-5339-cc79-525a-098c2d61e8c1@linaro.org>
Date:   Wed, 30 Nov 2022 16:27:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/8] dt-bindings: soc: socionext: Add UniPhier SoC-glue
 logic
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-3-hayashi.kunihiko@socionext.com>
 <4e90944a-1200-4619-f977-590fe2919017@linaro.org>
 <efa90f10-db67-bb9f-03fd-e99695a5bdf5@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <efa90f10-db67-bb9f-03fd-e99695a5bdf5@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 09:59, Kunihiko Hayashi wrote:
> Hi Krzysztof,
> 
> On 2022/11/29 23:43, Krzysztof Kozlowski wrote:
>> On 29/11/2022 11:35, Kunihiko Hayashi wrote:
>>> Add devicetree binding schema for the SoC-glue logic implemented on
>>> Socionext Uniphier SoCs.
>>>
>>> This SoC-glue logic is a set of miscellaneous function registers
>>> handling signals for specific devices outside system components,
>>> and also has multiple functions such as I/O pinmux, usb-phy, debug,
>>> clock-mux for a specific SoC, and so on.
>>>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> ---
>>>   .../socionext,uniphier-soc-glue.yaml          | 94 +++++++++++++++++++
>>>   1 file changed, 94 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
>>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
>>> new file mode 100644
>>> index 000000000000..3f571e3e1339
>>> --- /dev/null
>>> +++
>>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
>>> @@ -0,0 +1,94 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id:
>>> http://devicetree.org/schemas/soc/socionext/socionext,uniphier-soc-glue.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Socionext UniPhier SoC-glue logic
>>> +
>>> +maintainers:
>>> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> +
>>> +description: |+
>>> +  SoC-glue logic implemented on Socionext UniPhier SoCs is a collection
>>> of
>>> +  miscellaneous function registers handling signals outside system
>>> components.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - socionext,uniphier-ld4-soc-glue
>>> +          - socionext,uniphier-pro4-soc-glue
>>> +          - socionext,uniphier-pro5-soc-glue
>>> +          - socionext,uniphier-pxs2-soc-glue
>>> +          - socionext,uniphier-ld6b-soc-glue
>>> +          - socionext,uniphier-sld8-soc-glue
>>> +          - socionext,uniphier-ld11-soc-glue
>>> +          - socionext,uniphier-ld20-soc-glue
>>> +          - socionext,uniphier-pxs3-soc-glue
>>> +          - socionext,uniphier-nx1-soc-glue
>>> +          - socionext,uniphier-soc-glue
>>
>> This one looks generic - why having it next to specific ones?
> 
> SoC-glue has the same register set, but different implementations
> for each SoC.

Sure, but you did not model it as a compatible fallback, but like one of
variants. It is not tied to specific SoC, thus too generic.

> I thought of defining the same register set as a common specs,
> but each compatibles are sufficient. I'll remove it.
> 
>> Same question for your previous patch - socionext,uniphier-sysctrl.
>>
>> And similarly to previous patch, do you expect child nodes everywhere?
> 
> In case of this SoC-glue logic, all SoCs has pinctrl, however,
> only SoCs with USB2 host has usb-controller (phy-hub).
> And only legacy SoCs implement clock-controller (clk-mux) here.
> 
> Should child nodes that exist only in a specific "compatible" be defined
> conditionally?

No, rather define them in top level but disallow for specific compatibles:

allOf:
 - if:
  ....
   then:
     patternProperties:
       ...: false

Assuming that this does not over-complicate schema.


Best regards,
Krzysztof

