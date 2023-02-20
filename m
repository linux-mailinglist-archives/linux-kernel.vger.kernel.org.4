Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B2069C88A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjBTK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBTK2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:28:43 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C7214238
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:28:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b12so2669614edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfY7/8I4P2MwaaJXUPpevQRbmU9an+jW1yCW/WYgFig=;
        b=PDugBAeSZxduE3C2R/iVjtxDIHN6V5+ELBVV8Yn2i+Zlj/cIWGGvqIArE6FBGC0+fz
         wzvr1PZlquV3Aug2AA95Y6wchkqUGa6dlwxc6r/ux3IcXUZMWs3w6TqQLfLdOC2+Gz3r
         KDZGb3UOayWhEfMh9poef+77Jtp8PmBzkOyAlstreNrna77tnZ/L9Nw0CHmWh54gLSPb
         jTal23WD76UVgOUfbjgawRFEH3RAarsA7hnseYp06oAz8KsF7CSvBzq47bXs/6iILEsu
         hfzTyV/PoHRX/BgMylzlLAoElCCw0rlvsVdMY1T0yfK9MHYXW8NQcrwYKkE5w3/umlsa
         KDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfY7/8I4P2MwaaJXUPpevQRbmU9an+jW1yCW/WYgFig=;
        b=1HiGSFmEoNh7rgneY/LAwkpLsmslHmT7ferG9psYw74HpDG1mMjGeLSZZb3SJvbjYB
         jXeFZl/Emy2imz4uTI3kM3s3NAK0RkdxElW2+fIvRcyUaTVveFmxkuebW9Bbiov/BoPs
         bqWR1pzTv/hc78sCPW3R2pIh8IqdiOyzy++DH0xnfUmylvZxnXCEHGVCMiv+McHdoW1x
         /j/5TNAfLZnIhTtCk5yLfJ59noUk54SH22EqFo0KYqv/C8J26mwdJWwyQgCsswnKJyYA
         C5+45AifaFH3edl18TR5zMXrk1yr8J1jO85d4IQW/8gI4aWHNm15l+LR8lWQjGyFekx6
         AjAg==
X-Gm-Message-State: AO0yUKUi55H1WGCVCO21WtLolxbdJOA2FEn6yUdgcd+MraNBuGajJg/a
        5bVckrnUpJ4N/eYomOkAavfcLw==
X-Google-Smtp-Source: AK7set/8PA/DoQfESqAORw/k7KpV4K4QDCBvF2OWiA+NCzQWQaXQeZVOL5wdWBuCZYvr3DhXIEPMHg==
X-Received: by 2002:a17:907:849:b0:8b1:d5c:986e with SMTP id ww9-20020a170907084900b008b10d5c986emr10605265ejb.15.1676888921155;
        Mon, 20 Feb 2023 02:28:41 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id gf4-20020a170906e20400b008b14060f58asm5586572ejb.50.2023.02.20.02.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 02:28:40 -0800 (PST)
Message-ID: <4cd266d0-0555-e1a3-f9d1-35d4179ccfd1@linaro.org>
Date:   Mon, 20 Feb 2023 11:28:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: interrupt-controller: convert
 loongson,ls1x-intc.txt to json-schema
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20230218122236.1919465-1-keguang.zhang@gmail.com>
 <646cc26f-ed98-10fc-217b-5dc4416670a6@linaro.org>
 <CAJhJPsU7KmR1Z1uGsKUDW_=wUwr_Bg_7DwqsMD7tKWrZYQMPhw@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJhJPsU7KmR1Z1uGsKUDW_=wUwr_Bg_7DwqsMD7tKWrZYQMPhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2023 11:25, Kelvin Cheung wrote:
> On Mon, Feb 20, 2023 at 4:04 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 18/02/2023 13:22, Keguang Zhang wrote:
>>> Convert the Loongson1 interrupt controller dt-bindings to json-schema.
>>>
>>> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
>>> ---
>>>  .../loongson,ls1x-intc.txt                    | 24 ---------
>>>  .../loongson,ls1x-intc.yaml                   | 51 +++++++++++++++++++
>>>  2 files changed, 51 insertions(+), 24 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
>>> deleted file mode 100644
>>> index a63ed9fcb535..000000000000
>>> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
>>> +++ /dev/null
>>> @@ -1,24 +0,0 @@
>>> -Loongson ls1x Interrupt Controller
>>> -
>>> -Required properties:
>>> -
>>> -- compatible : should be "loongson,ls1x-intc". Valid strings are:
>>> -
>>> -- reg : Specifies base physical address and size of the registers.
>>> -- interrupt-controller : Identifies the node as an interrupt controller
>>> -- #interrupt-cells : Specifies the number of cells needed to encode an
>>> -  interrupt source. The value shall be 2.
>>> -- interrupts : Specifies the CPU interrupt the controller is connected to.
>>> -
>>> -Example:
>>> -
>>> -intc: interrupt-controller@1fd01040 {
>>> -     compatible = "loongson,ls1x-intc";
>>> -     reg = <0x1fd01040 0x18>;
>>> -
>>> -     interrupt-controller;
>>> -     #interrupt-cells = <2>;
>>> -
>>> -     interrupt-parent = <&cpu_intc>;
>>> -     interrupts = <2>;
>>> -};
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
>>> new file mode 100644
>>> index 000000000000..4cea3ee9fbb1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
>>> @@ -0,0 +1,51 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/interrupt-controller/loongson,ls1x-intc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Loongson-1 Interrupt Controller
>>
>> You changed the title, so this binding now will cover all Loonson-1
>> interrupt controllers?
>>
> Yes.

OK, then with the dropped |


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



Best regards,
Krzysztof

