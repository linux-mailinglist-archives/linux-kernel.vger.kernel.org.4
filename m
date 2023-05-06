Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8236F8F35
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 08:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjEFGel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 02:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjEFGej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 02:34:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA1786B1
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 23:34:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94f1d0d2e03so414107366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 23:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683354875; x=1685946875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RxlqWXbCB9qr1p9Srs8bmWLYx1r4gaKppnNXXKsVBOw=;
        b=vMl4RM/Y5I7xBLeUDS6EUKD2BuXH6c7JFV5VvXmOY9Pw9ZaCtf5O6zBiawSVJQSTL1
         GiEtKsoUDcMk7QX1xwK64nXePrsxP5kT9Nrao9Wlpz2DkAUlXPmCom04jmdZe/ySaOVs
         eIrFlvJgA+I/xR7nMEtSxTprKjsFGnFq+zXYMujhMdk2PpDD+b7QZJj+pkVomhol5uxS
         TXFhWWUNqfUIS29nh9ikSFYbYz00gcfTfdEjdia0c9QWNIvRU42ZIRC+vGh8GBulBm8w
         pYERT5gAsxR3fNkL0QlMesZgDsrUBNkkFhKH6a3A3BiXf//WXWMxDhRl1bMzNZtU8WoE
         SHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683354875; x=1685946875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxlqWXbCB9qr1p9Srs8bmWLYx1r4gaKppnNXXKsVBOw=;
        b=HzFUr7C1v2QsmdN4NPisWv2WPy81KDTN4nZG1rnw919IT0dEfHggMq34OqXbBaf5Mr
         J3KPq6ZPLqfHLRkS1O+vYdA0W0gC+COW4oTiEE4F6MOsoBot1fummwBwGf/MNXHOP86X
         b6DufamZfFEvnM0Sr1CrV2JAIPRnOGpfxrvStp5+sSNNHnhO43ARhNP/VTaYFZgWkMMr
         JsSdH+sCzuFKUHnXARCi68yyhO01n25/S7R5HSUHvEIoR8xpbk72iSzB3UUDv3yzDIxS
         MmrCqdxW5woFAsnhtGmzoU3KyY45ZzvMGNrtBuZyoAB462g4uO1QxfIZnwNDy8sbL3MQ
         K8hQ==
X-Gm-Message-State: AC+VfDyqwzpBObBwwnj4z3dljdPLg+KZkK1dAJTXlmthflNbrOM1x1ne
        vmv0OwdX/ZF7R3v3V0YTjxXXpA==
X-Google-Smtp-Source: ACHHUZ65luJLR1eolPcDXVXLAvHlNGfoRtWRoGn/G/UYxJTx9D5P1y3kZJxUkigUvNLdNb9VTnyGxg==
X-Received: by 2002:a17:907:1c05:b0:930:f953:9608 with SMTP id nc5-20020a1709071c0500b00930f9539608mr4107389ejc.0.1683354875384;
        Fri, 05 May 2023 23:34:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:efe5:7c03:a10a:7a40? ([2a02:810d:15c0:828:efe5:7c03:a10a:7a40])
        by smtp.gmail.com with ESMTPSA id kj26-20020a170907765a00b009584c5bcbc7sm1861776ejc.49.2023.05.05.23.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 23:34:34 -0700 (PDT)
Message-ID: <a544409a-7b65-820c-2b48-48207c55aa7e@linaro.org>
Date:   Sat, 6 May 2023 08:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: add binding doc for i.MX
 OCOTP/ELE
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230505091733.1819521-1-peng.fan@oss.nxp.com>
 <bb3d374d-0dc1-cf15-2458-f294c5ef23fd@linaro.org>
 <c7f11b40-e4d7-3c4e-53d7-6549f840b702@linaro.org>
 <DU0PR04MB9417AE9BA8F91B2E06DB09BF88739@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417AE9BA8F91B2E06DB09BF88739@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2023 04:58, Peng Fan wrote:
>> Subject: Re: [PATCH 1/2] dt-bindings: nvmem: add binding doc for i.MX
>> OCOTP/ELE
>>
>> On 05/05/2023 14:01, Krzysztof Kozlowski wrote:
>>> On 05/05/2023 11:17, Peng Fan (OSS) wrote:
>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>
>>>> There are two parts of i.MX93 OCOTP, with 1st part Fuse shadow
>>>> block(fsb), 2nd part managed by ELE firmware. This binding doc supports
>> both.
>>>
>>> Subject: drop second/last, redundant "binding doc for". The
>>> "dt-bindings" prefix is already stating that these are bindings and
>>> documentation.
>>>
>>>>
>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>> ---
>>>>  .../bindings/nvmem/imx-ocotp-ele.yaml         | 65 +++++++++++++++++++
>>>>  1 file changed, 65 insertions(+)
>>>>  create mode 100644
>>>> Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
>>>> b/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
>>>> new file mode 100644
>>>> index 000000000000..024594a2bcb4
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
>>>
>>> Filename matching compatible style. fsl,imx93-ocotp.yaml
>>>
>>>
>>>> @@ -0,0 +1,65 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>>>> +---
>>>> +$id:
>>>>
>> +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdev
>>>> +icetree.org%2Fschemas%2Fnvmem%2Fimx-ocotp-
>> ele.yaml%23&data=05%7C01%7
>>>>
>> +Cpeng.fan%40nxp.com%7Cd779f2b1abe94a0d493208db4d618fd9%7C686e
>> a1d3bc2
>>>>
>> +b4c6fa92cd99c5c301635%7C0%7C0%7C638188853636582816%7CUnknown
>> %7CTWFpb
>>>>
>> +GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
>> CI6M
>>>>
>> +n0%3D%7C3000%7C%7C%7C&sdata=2uIFOmUqlbgPIRasl%2FyO0CdZAFPhV
>> 2qpHnhwKB
>>>> +OZ008%3D&reserved=0
>>>> +$schema:
>>>>
>> +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdev
>>>> +icetree.org%2Fmeta-
>> schemas%2Fcore.yaml%23&data=05%7C01%7Cpeng.fan%40
>>>>
>> +nxp.com%7Cd779f2b1abe94a0d493208db4d618fd9%7C686ea1d3bc2b4c6f
>> a92cd99
>>>>
>> +c5c301635%7C0%7C0%7C638188853636582816%7CUnknown%7CTWFpbG
>> Zsb3d8eyJWI
>>>>
>> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
>> C3000
>>>>
>> +%7C%7C%7C&sdata=iKJpzjsi7TuqxDim7sUjHmwFR1eK9hFNp2ygMap9bq8%
>> 3D&reser
>>>> +ved=0
>>>> +
>>>> +title: NXP i.MX9 On-Chip OTP Controller (OCOTP)
>>>> +
>>>> +maintainers:
>>>> +  - Peng Fan <peng.fan@nxp.com>
>>>> +
>>>> +allOf:
>>>> +  - $ref: nvmem.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    oneOf:
>>>> +      - items:
>>>> +          - const: fsl,imx93-ocotp-fsb
>>>> +          - const: syscon
>>>> +      - items:
>>>> +          - const: fsl,imx93-ocotp-ele
>>>> +
>>
>> Actually this is the same as existing bindings. Just squash it.
> 
> You mean add the compatible to imx-ocotp.yaml?

I missed this file, I was thinking about mxs, but sure, can go to imx.
All of them are the same...

> 
>>
>> However I wonder - why this is syscon?
> 
> Someone may wanna to use syscon_to_regmap?
> I just follow imx-ocotp.yaml.

That's not a good reason to add syscon. Drop it.

Best regards,
Krzysztof

