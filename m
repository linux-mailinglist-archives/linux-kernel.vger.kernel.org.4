Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4F666B19B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 15:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjAOOpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 09:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjAOOph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 09:45:37 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD51F125A3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:45:35 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id kt14so3726172ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S55lAkPrieupNXbmTqJ9NAdvdKrDGYCnFkX8IezHQmw=;
        b=KA7jQAnCYmjjPGLaUQVLVyomKV7Np8CI5rJGLh/MK0bDhdPf/jDVL9mnJJK7s5JGtS
         6faCeUwB7CwjEWG+YtQeT3LR4Hhq066lp5e7R/qb60o+VKCyq9quXRLaBZKBE0MTtnZG
         AZgzKspb4pilcfmQweSmjdX4vB9NS/yJ5+tlDyMlKbSvFc2tryk2Uiwb7xcpbdA5+8IU
         RL9DrUykGN2I0A2AORc7L41vPwl5Q9wC90uXRHbs8rJxc5xMKuTz8lGE+F0pi7JsR7z/
         vIbuDa4KGO76GwQP23EhgeywY9IxFmjM3IfGJwNOljpqQACWNQdfJCm/I3keclzXYvEE
         SZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S55lAkPrieupNXbmTqJ9NAdvdKrDGYCnFkX8IezHQmw=;
        b=a+RYBiA6j4/h0sxiFKOsABJ/xdJp1EZicPE1rHNncEDVEyRMyQtbW8jc0+A65bOnJv
         6+vMesWvrTOCea94wZXrzLvhdzf+PnXyMYr8Cfl4Mz/is3fGN/2m2SVTH1bRVjugHKi1
         ZJjEuwgofj1HkhggzPHYL6t7htQx+OmJyqysr/5ct31Ayw1RQnV8ev1Lv9hEzlQC98rf
         5HqJ62WQpQYPfrXQxaYk/Yv5/EzePDZY0Y9rwBt7qgOqZHuOOi63IWtG3NEUEYVOk8ta
         ARBVluhpANfwpvzmTwfYnVfEYptWH2MEOTkoxfmZQgGsYZDjBStfJU1jPmEBs0rL7BDM
         2PNQ==
X-Gm-Message-State: AFqh2kqsw2MDvEkMQyk8cPGtmlmYBBda+lEjAzlq9KLWCohkATQ0NhEi
        9sEc4cUWALq7xxzvbsb9E09LPg==
X-Google-Smtp-Source: AMrXdXud9y9b4B0NHtITLguIpkGpqXiF2iBZ33zFZXjMk4SKfkTFwzird2OI3zsXpg+go60faLE6Tg==
X-Received: by 2002:a17:907:1387:b0:7c8:9f04:ae7e with SMTP id vs7-20020a170907138700b007c89f04ae7emr8149297ejb.22.1673793934363;
        Sun, 15 Jan 2023 06:45:34 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id vu6-20020a170907a64600b0086eb30fb618sm1140165ejc.183.2023.01.15.06.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 06:45:33 -0800 (PST)
Message-ID: <39b55b55-b0fd-95fc-5f68-e00cd20f076d@linaro.org>
Date:   Sun, 15 Jan 2023 15:45:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: sram: Tightly Coupled Memory (TCM) bindings
Content-Language: en-US
To:     Tanmay Shah <tanmays@amd.com>, Tanmay Shah <tanmay.shah@amd.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20230113073045.4008853-1-tanmay.shah@amd.com>
 <df4fdecb-6ca7-d96b-bcad-02cefb52ce4e@linaro.org>
 <e675a037-3c07-a8bb-19d4-781ab881c920@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e675a037-3c07-a8bb-19d4-781ab881c920@amd.com>
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

On 13/01/2023 19:04, Tanmay Shah wrote:
> Hi Krzysztof Thanks for your reviews.
> 
> Please find my comments below.
> 
> On 1/12/23 11:52 PM, Krzysztof Kozlowski wrote:
>> On 13/01/2023 08:30, Tanmay Shah wrote:
>>> This patch introduces bindings for TCM memory address space on AMD-xilinx
>>> platforms. As of now TCM addresses are hardcoded in xilinx remoteproc
>>> driver. This bindings will help in defining TCM in device-tree and
>>> make it's access platform agnostic and data-driven from the driver.
>>>
>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>> ---
>>>   .../devicetree/bindings/sram/xlnx,tcm.yaml    | 137 ++++++++++++++++++
>>>   1 file changed, 137 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml b/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
>>> new file mode 100644
>>> index 000000000000..02d17026fb1f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
>>> @@ -0,0 +1,137 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sram/xlnx,tcm.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Tightly Coupled Memory (TCM)
>>> +
>>> +maintainers:
>>> +  - Tanmay Shah <tanmay.shah@amd.com>
>>> +
>>> +description: |
>>> +  Tightly Coupled Memory(TCM) is available on AMD-Xilinx paltforms for ARM
>>> +  cortex remote processors to use. It is low-latency memory that provide
>>> +  predictable instruction execution and predictable data load/store timing.
>>> +  TCM can be configured in lockstep mode or split mode. In split mode
>>> +  configuration each RPU core has its own set of ATCM and BTCM memories and in
>>> +  lockstep mode redundant processor's TCM become available to lockstep
>>> +  processor. So In lockstep mode ATCM and BTCM size is increased.
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "sram-[0-9a-f]+$"
>> Drop node name requirement.
>> Why do you need sram node at all?
> 
> 
> I will remove sram- node. However, it device-tree I was planning to put
> 
> all TCM nodes under single node for example:
> 
> tcm {
> 
>      tcm-lockstep {
> 
>      };
> 
>      tcm-core@0 {

Mix of nodes with and without unit address is pointing to some design
issues.

> 
>      };
> 
> };
> 
> The top-most tcm node I assumed sram node. So I kept sram@xxxx
> 
>>> +
>>> +patternProperties:
>>> +  "^tcm-[a-z]+@[0-9a-f]+$":
>>> +    type: object
>>> +    description: |
>>> +      During the split mode, each RPU core has its own set of ATCM and BTCM memory
>>> +
>>> +      During the lock-step operation, the TCMs that are associated with the
>>> +      redundant processor become available to the lock-step processor.
>>> +      For example if each individual processor has 64KB ATCM, then in lockstep mode
>>> +      The size of ATCM become 128KB. Same for BTCM. tcm-lockstep node represents
>>> +      TCM address space in lockstep mode. tcm-core@x node specfies each core's
>>> +      TCM address space in split mode.
>>> +
>>> +    properties:
>>> +      compatible:
>>> +        oneOf:
>> This is not oneOf.
>>
>>> +          - items:
>> and you do not have more than one item.
>>
>>> +              - enum:
>>> +                  - xlnx,tcm-lockstep
>>> +                  - xlnx,tcm-split
>> compatible describes hardware, not configuration. What you encode here
>> does not fit compatible.
> 
> 
> I see. So, only xlnx,tcm is enough.

No, it must be specific to SoC.

> 
> 
>>
>>> +
>>> +      "#address-cells":
>> Use consistent quotes, either " or '
> 
> 
> Ack.
> 
> 
>>
>>> +        const: 1
>>> +
>>> +      "#size-cells":
>>> +        const: 1
>>> +
>>> +      reg:
>>> +        items:
>>> +          - description: |
>>> +              ATCM Memory address space. An ATCM typically holds interrupt or
>>> +              exception code that must be accessed at high speed, without any
>>> +              potential delay resulting from a cache miss.
>>> +              RPU on AMD-Xilinx platform can also fetch data from ATCM
>>> +          - description: |
>>> +              BTCM Memory address space. A BTCM typically holds a block of data
>>> +              for intensive processing, such as audio or video processing. RPU on
>>> +              AMD-Xilinx Platforms can also fetch Code (Instructions) from BTCM
>>> +
>>> +      reg-names:
>>> +        items:
>>> +          - const: atcm
>>> +          - const: btcm
>>> +
>>> +      ranges: true
>>> +
>>> +      power-domains:
>>> +        maxItems: 8
>>> +        items:
>>> +          - description: list of ATCM Power domains
>>> +          - description: list of BTCM Power domains
>>> +        additionalItems: true
>> And what are the rest?
> As both items are list, we should be able to include more than one 
> power-domain I believe.
> 
> 
> So first item I am trying to create list of ATCM power domains.
> 
> In split mode, first item is ATCM power-domain and second item is BTCM 
> power domain.
> 
> However, In lockstep mode, second core's TCM physically relocates and 
> two ATCM combines and

Why power domains of a device depend on the mode? This does not look
like binding describing hardware.

> 
> makes single region of ATCM. However, their power-domains remains same.
> 
> So, In lockstep mode, first two banks are ATCM and so, first two items 
> are ATCM power-domains.
> 
> I am not sure best way to represent this. But, first itmes is list.
> 
> So, I am assuming list of all ATCM power-domains possible.

List all items. Order is fixed, you cannot say BTCM is second item and
then put here something else.

Best regards,
Krzysztof

