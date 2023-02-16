Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0806D698FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBPJeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPJeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:34:19 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CFA2DE5D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:34:17 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id dr8so3600346ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xlE78N7SwGUFP9az71FkKXaJ04noS1VC//kRi/UVdqM=;
        b=qk2ho0Dn+kiBw+yOLu9QE+mJzyhgW5YHK7yfLKrCDk+7P6TY2nUpDYs4QuUT9FNQ0U
         SBQL9P8vhjDkHUz66C2I+MxGGXFiO1vzGi26LNgF87ZuacxT2PO6WNrqGosIi/w6/Kpo
         Bt+IL1ruRfny21fybHwrw1TRWSXi4dGF2wIuJvRLdf15g8Dg5rr+PiR5UuQMKyuRbvmC
         VHLCP6y3krEFfnMq7QdoyZ5Nx1/ChUiYWqaYsJ6m1kMotTeQ7f8/r88ETnMKkT0PNCuG
         N/xcsFyTWgvdc+dY8quFVuXM3F49oNAjBTXczae77BTR0q5NyE1mC+ctqviU/XC4C9KN
         IKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlE78N7SwGUFP9az71FkKXaJ04noS1VC//kRi/UVdqM=;
        b=FnIPAR+/tz0U1K4NBTgQrUSprbpDrkFjKFBCMIdqf8i60jDBo2Zl5pSHQSoOhGKo1v
         S61zqYmGztTIG9cEuB77XJrm9j2Xs1FvqgMYXj4wQ+mea4P6tvrt8UdhEq2siyvVb/KI
         xxjfkY4r3DVk0B0KqMv/b2GiFFdcb3gRB4MHQ3GH9G11H3seL5z0bb+99mppfxI4uep3
         1SVljPQHKRtWTs88mq+kMi3symz6WGLsKlETHBZGjbvFcqQadcKntQ1AeAEa5v7Lxki/
         q97PUnINTjqtjO5/zfnx1kiUbay0Ucwnr7roGiV6PK27UNGKYRax8Yl/+pVat0nLF8ZW
         qBfQ==
X-Gm-Message-State: AO0yUKUgm42hdUQkgBdDxqSzrSw1BYcd59DwqUCTzvL66ObNr1shlo4E
        hOX0sCqIyVHOHCYUOI/va7rvxQ==
X-Google-Smtp-Source: AK7set9DgurDP4wEVrFOs7M52beuPRqtI24FolaG8A6C0viAI6f+7xUUlXY8RCpQPV9oU7R/0Dg27A==
X-Received: by 2002:a17:906:dfd2:b0:877:7113:71f3 with SMTP id jt18-20020a170906dfd200b00877711371f3mr5305331ejc.25.1676540056008;
        Thu, 16 Feb 2023 01:34:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id dk14-20020a170906f0ce00b0087bd2924e74sm553002ejb.205.2023.02.16.01.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:34:14 -0800 (PST)
Message-ID: <0f5f367e-5531-e209-9be3-94a94c4ad65c@linaro.org>
Date:   Thu, 16 Feb 2023 10:34:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2 1/2] dt-bindings: interrupt-controller: Add Loongson
 EIOINTC
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <cover.1676289084.git.zhoubinbin@loongson.cn>
 <a9f697906df6599e6b001981e668479da71aa7a0.1676289084.git.zhoubinbin@loongson.cn>
 <df464409-9a93-c057-5f66-923a9e24696a@linaro.org>
 <CAMpQs4JX0Vgf5tvv5Yw5eLGANFfn1p=iQ_kMS0yQPV6kE2tN1g@mail.gmail.com>
 <23068d0c-d37c-0563-e1c1-e4d112059f5b@linaro.org>
 <CAMpQs4K+aYGrOoWy04vrbEy53kba9zUzGkOwD34pwAH0c=D8iA@mail.gmail.com>
 <49c8255e-66f3-fa1f-2949-1f03f77a0fa4@linaro.org>
 <CAAhV-H6+aDYZ4JAPpdkefPR0P3QFqKCmt=RsZiw+FZRRax5TgA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAAhV-H6+aDYZ4JAPpdkefPR0P3QFqKCmt=RsZiw+FZRRax5TgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 10:30, Huacai Chen wrote:
> Hi, Krzysztof,
> 
> On Thu, Feb 16, 2023 at 4:10 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 16/02/2023 02:46, Binbin Zhou wrote:
>>> On Tue, Feb 14, 2023 at 8:43 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 14/02/2023 13:40, Binbin Zhou wrote:
>>>>> On Tue, Feb 14, 2023 at 5:53 PM Krzysztof Kozlowski
>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>
>>>>>> On 13/02/2023 13:15, Binbin Zhou wrote:
>>>>>>> Add Loongson Extended I/O Interrupt controller binding with DT schema
>>>>>>> format using json-schema.
>>>>>>>
>>>>>>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>>>>>>> ---
>>>>>>>  .../loongson,eiointc.yaml                     | 80 +++++++++++++++++++
>>>>>>>  1 file changed, 80 insertions(+)
>>>>>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..88580297f955
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
>>>>>>> @@ -0,0 +1,80 @@
>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>> +%YAML 1.2
>>>>>>> +---
>>>>>>> +$id: "http://devicetree.org/schemas/interrupt-controller/loongson,eiointc.yaml#"
>>>>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>>>>
>>>>>> Drop quotes from bopth.
>>>>>>
>>>>>>> +
>>>>>>> +title: Loongson Extended I/O Interrupt Controller
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - Binbin Zhou <zhoubinbin@loongson.cn>
>>>>>>> +
>>>>>>> +description: |
>>>>>>> +  This interrupt controller is found on the Loongson-3 family chips and
>>>>>>> +  Loongson-2K0500 chip and is used to distribute interrupts directly to
>>>>>>> +  individual cores without forwarding them through the HT's interrupt line.
>>>>>>> +
>>>>>>> +allOf:
>>>>>>> +  - $ref: /schemas/interrupt-controller.yaml#
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    enum:
>>>>>>> +      - loongson,eiointc-1.0
>>>>>>
>>>>>> Why not using SoC based compatible? It is preferred.
>>>>>
>>>>> Hi Krzysztof:
>>>>>
>>>>> So far, from the datasheet, I know that only the EXIOINTC of the
>>>>> Loongson-2K0500 is different from the other chips, and that is the
>>>>> "loongson,eio-num-vecs" below, which is 128, while all the others are
>>>>> 256.
>>>>> My original idea was to add this property to make compatible
>>>>> consistent, and also to make it easier to add new chips if they have
>>>>> different eio-num-vecs.
>>>>
>>>> We talk about different things. SoC based compatibles are preferred over
>>>> version ones. This was on the lists expressed many times. Please provide
>>>> a reason why you deviate from general recommendation. Flexibility and
>>>> genericness of bindings is not a reason - it's the opposite of the
>>>> argument, thus this will be a: NAK. :(
>>>>
>>>>
>>> Hi Krzysztof:
>>>
>>> Allow me to give a brief overview of the current status of eiointc (DT-based):
>>>      Loongson-3A series supports eiointc;
>>>      Loongson-2K1000 does not support eiointc now;
>>>      Loongson-2K0500 supports eiointc, with differences from
>>> Loongson-3, e.g. only up to 128 devices are supported;
>>>      Loongson-2K2000 supports eiointc, similar to Loongson-3.
>>>      ....
>>>
>>> As can be seen, there is now a bit of confusion in the chip's design of eiointc.
>>>
>>> The design of eiointc is probably refined step by step with the chip.
>>> The same version of eiointc can be used for multiple chips, and the
>>> same chip series may also use different versions of eiointc. Low-end
>>> chips may use eiointc-2.0, and high-end chips may use eiointc-1.0,
>>> depending on the time it's produced.
>>>
>>> So in the Loongson-2K series I have defined the current state as
>>> eiointc-1.0, using the dts property to indicate the maximum number of
>>> devices supported by eiointc that can be used directly in the driver.
>>>
>>> If there are new changes to the design later on, such as the
>>> definition of registers, we can call it eiointc-2.0, which can also
>>> cover more than one chip.
>>
>> Just go with SoC-based compatibles. If your version is not specific
>> enough, then it is not a good way to represent the hardware.
> EIOINTC is a bit like the existing LIOINTC which is already use
> version to represent hardware.

Heh, so why did you go with version in compatible for liointc if it also
does not match it correctly?

Best regards,
Krzysztof

