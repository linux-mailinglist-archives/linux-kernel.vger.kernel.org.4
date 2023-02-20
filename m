Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175FE69C8D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjBTKl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjBTKl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:41:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14796A69
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:40:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id h32so3019244eda.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrOjogspuAD2gXByu3IdIwg2IqZjONgkefscY5F+1PE=;
        b=eB869Fo7T34c1P7zS8nbEoGvgyccNsUXB8frOxzpfgHfU/+cdFLMp6xgBY8XsKIXC7
         hwjHMtp0Dl7bP+t1Hf/Rlot9qyXg6KN1UoDdBXB7NbIA9Wo8SZSbK5KsHNsAlqbuo/fg
         R3wPZ7z19WpEsWDAtZqXxr/RRIOMl3pd8LEQ2R9wN+u8AjyUw9R8LZlALX8vnKovjrcE
         T5R1kTP9fdP6y1BjSwtKnNcgM9itxv8CDKSVaLqSjImNj0jlwkbuT9c3MO17Uu5t4uMD
         aW+eNz+cC4NeSzn28zeoL1OMpaX7CVdajYBligFXEYv42oqz2pzVehohVwhRjyaCoPdq
         yQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrOjogspuAD2gXByu3IdIwg2IqZjONgkefscY5F+1PE=;
        b=7KWxBuh/WXJNFaeUqMMSMQSnt2nZzQb8BjRJTbvBC8T9YsoMLdMe7PbDTxp+W6GDPQ
         Isa3/nCV7PSoiTbKpMcU3cNROLwUSBFd0pMzfWEV6PFnbDLaqRcG9xKo8QLSmBq1yoMU
         XDqomURlpx+BTYelIdaxe9ILmQdfdomlRCnEtJAHIhueqQ9kIFZYYuTBO9PbUoVE6gXt
         dl7QmUwmntnZfYVzub24bshAAlq61mdRfleLxO32NtkCabNIC02gBaOqjbASFTa0xZY+
         HK4BIgg5+38/enmAVmRe5P1K5kv8VhfnYxLLVtUeLCzPSEQXiUkF2PIqRUUjqAs6Po6I
         f53Q==
X-Gm-Message-State: AO0yUKX+AiFCFyXM5HQGeBC+rzKUDeSiTMolYUzD3UElc2FhWz+JGtRz
        8UVggc0ImKilKqVp6bmwuIABSA==
X-Google-Smtp-Source: AK7set/4xUWGYcJOHYGbCM3P92+1vi2SLesgkDxRx1OPBaPBCEGNHpCzqQCYKjkf7suQsSt7a3H6jw==
X-Received: by 2002:a05:6402:445:b0:4ae:821:871f with SMTP id p5-20020a056402044500b004ae0821871fmr2706745edw.3.1676889657371;
        Mon, 20 Feb 2023 02:40:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g16-20020a50d0d0000000b004ad1d3cf195sm412430edf.95.2023.02.20.02.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 02:40:56 -0800 (PST)
Message-ID: <ca6ebb35-ac8e-b49f-c2ab-b65492c1b4b4@linaro.org>
Date:   Mon, 20 Feb 2023 11:40:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: interrupt-controller: convert
 loongson,ls1x-intc.txt to json-schema
Content-Language: en-US
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
 <4cd266d0-0555-e1a3-f9d1-35d4179ccfd1@linaro.org>
 <CAJhJPsVhCKW6qgTm30wS_NhxF5cgrGg=vvj+v--FH+pg=JAKbg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJhJPsVhCKW6qgTm30wS_NhxF5cgrGg=vvj+v--FH+pg=JAKbg@mail.gmail.com>
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

On 20/02/2023 11:36, Kelvin Cheung wrote:
> On Mon, Feb 20, 2023 at 6:28 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 20/02/2023 11:25, Kelvin Cheung wrote:
>>> On Mon, Feb 20, 2023 at 4:04 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 18/02/2023 13:22, Keguang Zhang wrote:
>>>>> Convert the Loongson1 interrupt controller dt-bindings to json-schema.
>>>>>
>>>>> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
>>>>> ---
>>>>>  .../loongson,ls1x-intc.txt                    | 24 ---------
>>>>>  .../loongson,ls1x-intc.yaml                   | 51 +++++++++++++++++++
>>>>>  2 files changed, 51 insertions(+), 24 deletions(-)
>>>>>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
>>>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
>>>>> deleted file mode 100644
>>>>> index a63ed9fcb535..000000000000
>>>>> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
>>>>> +++ /dev/null
>>>>> @@ -1,24 +0,0 @@
>>>>> -Loongson ls1x Interrupt Controller
>>>>> -
>>>>> -Required properties:
>>>>> -
>>>>> -- compatible : should be "loongson,ls1x-intc". Valid strings are:
>>>>> -
>>>>> -- reg : Specifies base physical address and size of the registers.
>>>>> -- interrupt-controller : Identifies the node as an interrupt controller
>>>>> -- #interrupt-cells : Specifies the number of cells needed to encode an
>>>>> -  interrupt source. The value shall be 2.
>>>>> -- interrupts : Specifies the CPU interrupt the controller is connected to.
>>>>> -
>>>>> -Example:
>>>>> -
>>>>> -intc: interrupt-controller@1fd01040 {
>>>>> -     compatible = "loongson,ls1x-intc";
>>>>> -     reg = <0x1fd01040 0x18>;
>>>>> -
>>>>> -     interrupt-controller;
>>>>> -     #interrupt-cells = <2>;
>>>>> -
>>>>> -     interrupt-parent = <&cpu_intc>;
>>>>> -     interrupts = <2>;
>>>>> -};
>>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..4cea3ee9fbb1
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
>>>>> @@ -0,0 +1,51 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/interrupt-controller/loongson,ls1x-intc.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Loongson-1 Interrupt Controller
>>>>
>>>> You changed the title, so this binding now will cover all Loonson-1
>>>> interrupt controllers?
>>>>
>>> Yes.
>>
>> OK, then with the dropped |
>>
> Sorry.
> Should I send the patch V2 to drop the description part?

Yes, please, with my tag.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540


Best regards,
Krzysztof

