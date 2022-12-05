Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2DD642552
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiLEJDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiLEJCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:02:49 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DBFD68
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:02:17 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s8so17487398lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMxaUycmxl+S2uvPgIxMwOG2DftPOi9wfPWh+AneDcw=;
        b=p3j+D/Wc9M3g6mr5ZEjzMfyRifRhIHwMJypgDKfta9PMuwgoTVGNReurNgJgM40RID
         i6nOixIcHO+ZSqF1YUnjcQZ7B2WQGbiEIbL/v7r2pLEPDa17J/q1dU9j5VC4jItH073l
         n/JBYUwbmGRZ275nF9CH3drL4fbAlmRELBdtigLgppWgKB8IbOf/TtiXeA3ksgRoSOk/
         AhKb8FNLb7TJtIYXrHmYMPI9iIvVkWaYnAHUltNlqsXWPJCEVQ4SDYBPplDA4tMFtoKk
         cubhx/a9UDW8SGhFdPwe9OSMu8mNFXhv+TfxvfBMLYlwmqrpMrn9TRJ7zLFFwsHGXugs
         +Sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMxaUycmxl+S2uvPgIxMwOG2DftPOi9wfPWh+AneDcw=;
        b=jutuRs3Alx35FwIbtZrJn9jJBV2tNEwWlvNCNS0GUG3Zl0v55NpCTU8Z7wOnmqUPra
         lEYWRzT2CdhxvO0ZIU4UDIjdVY7zGF6qGXChw7kNf8vpVhN4hc8BIMgTDH34X2Fq4+nZ
         RcX+emgHK5eEIGVf9X+ow7aUnioFoD2f0AKvunEGJRjFN76XpephMkZJ6lXQkp/Y8aBe
         Ec0NB5Yrb/CW4/38LHggeQgWeUHDEdGSPTnRC0SMxMwzw+qkpwPyAs3+V2i0P69UZJ6u
         LI5Av3wmqFfq5ZCKibvMOypvqnD67DDxS24khH0Zam+GfuVPG3HD0TWE3sUzrf6ApeL9
         YWKg==
X-Gm-Message-State: ANoB5plw3FqyvR8Bap5CqVhJ/VozOKN+keiq27cuUSaxrc6U8uyXSFed
        cVdnpIBPBbX6z3AyT7xT+/OplQ==
X-Google-Smtp-Source: AA0mqf40OKDV1s//nLvesSXyQnTAgCIILP/C93w3TBXdq9B6xV9CZ5i6fZyJP1TzIyYZqpsla/JVew==
X-Received: by 2002:ac2:5e2a:0:b0:4b5:6b51:c5ef with SMTP id o10-20020ac25e2a000000b004b56b51c5efmr1864900lfg.336.1670230935845;
        Mon, 05 Dec 2022 01:02:15 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h24-20020a2e9018000000b0027a00aab48fsm227356ljg.66.2022.12.05.01.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 01:02:15 -0800 (PST)
Message-ID: <e839274d-6696-63aa-14e6-f52a534c9ed2@linaro.org>
Date:   Mon, 5 Dec 2022 10:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Content-Language: en-US
To:     Chester Lin <clin@suse.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        ghennadi.procopciuc@oss.nxp.com
References: <20221128054820.1771-1-clin@suse.com>
 <20221128054820.1771-2-clin@suse.com>
 <6ad95ce3-887d-48fd-3c08-f50d4e666ded@linaro.org>
 <Y42MyyLumVa8phpd@linux-8mug>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y42MyyLumVa8phpd@linux-8mug>
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

On 05/12/2022 07:16, Chester Lin wrote:
> Hi Krzysztof,
> 
> On Wed, Nov 30, 2022 at 03:58:52PM +0100, Krzysztof Kozlowski wrote:
>> On 28/11/2022 06:48, Chester Lin wrote:
>>> Add DT schema for the pinctrl driver of NXP S32 SoC family.
>>>
>>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>>> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
>>> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
>>> Signed-off-by: Chester Lin <clin@suse.com>
>>> ---
>>>
>>> Changes in v2:
>>> - Remove the "nxp,pins" property since it has been moved into the driver.
>>> - Add descriptions for reg entries.
>>> - Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".
>>> - Fix schema issues and revise the example.
>>> - Fix the copyright format suggested by NXP.
>>>
>>>  .../pinctrl/nxp,s32cc-siul2-pinctrl.yaml      | 125 ++++++++++++++++++
>>>  1 file changed, 125 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
>>> new file mode 100644
>>> index 000000000000..2fc25a9362af
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
>>
>> Usually filename matches the compatible (or family name), so any reason
>> why compatible is "nxp,s32g2" but filename is "nxp,s32cc"?
>>
> 
> According to NXP, the S32CC is a microarch which is adapted by different S32 SoCs,
> such as S32G2/G3 and S32R45. Some common IPs are implemented in S32CC, such as
> serial, pinctrl, mmc, gmac and some other peripheral interfaces. S32R45 has
> different pinouts compared to S32G2, which means that there would not be just
> "s32g2-siul2-pinctrl" but also "s32r45-siul2-pinctrl" in the compatible enum if
> S32R45 has to be upstreamed in the future. For this case, it seems to be
> inappropriate that adding a compatible name without any "s32g" keyword in the
> filename "nxp,s32g2-.." unless creating a new yaml for each platform, such as
> nxp,s32r45-siul2-pinctl.yaml.

First, you can always rename a file if such need arises. Maybe new SoCs
will come, maybe not.

Second, when you actually upstream new SoC it might anyway require new
bindings file, because pinctrls are quite specific and it is usually
difficult to support multiple devices in a nice, readable way in one
file. Therefore anyway another file is quite likely.

(...)

>>> +
>>> +patternProperties:
>>> +  '-pins$':
>>> +    type: object
>>> +    additionalProperties: false
>>> +
>>> +    patternProperties:
>>> +      '-grp[0-9]$':
>>> +        type: object
>>> +        allOf:
>>> +          - $ref: pinmux-node.yaml#
>>> +          - $ref: pincfg-node.yaml#
>>> +        unevaluatedProperties: false
>>> +        description:
>>> +          Pinctrl node's client devices specify pin muxes using subnodes,
>>> +          which in turn use the standard properties.
>>
>> All properties are accepted? What about values, e.g. for drive strength?
> 
> For those unsupported properties such as drive-strength, the s32g2 pinctrl driver
> returns -EOPNOTSUPP.

I don't care what the driver is doing, we do not discuss the driver. You
need to describe properly the hardware and I doubt that hardware accepts
all drive-strengths, all forms of pull resistors (so any Ohm value).

Add constrains.

>>
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +
>>> +    /* Pins functions (SSS field) */
>>> +    #define FUNC0  0
>>> +    #define FUNC1  1
>>> +    #define FUNC2  2
>>> +    #define FUNC3  3
>>> +    #define FUNC4  4
>>> +    #define FUNC5  5
>>> +    #define FUNC6  6
>>> +    #define FUNC7  7

This is another surprise - functions are texts, not numbers.

>>> +
>>> +    #define S32CC_PINMUX(PIN, FUNC) (((PIN) << 4) | (FUNC))
>>> +
>>> +    #define S32CC_SLEW_208MHZ  0
>>> +    #define S32CC_SLEW_166MHZ  4
>>> +    #define S32CC_SLEW_150MHZ  5
>>> +    #define S32CC_SLEW_133MHZ  6
>>> +    #define S32CC_SLEW_83MHZ   7

Don't store register values in the bindings examples. Instead you need
to be explain the slew-rate property.

>>> +
>>> +    pinctrl@4009c240 {
>>> +        compatible = "nxp,s32g2-siul2-pinctrl";
>>> +
>>> +        /*
>>> +         * There are two SIUL2 controllers in S32G2:
>>> +         *
>>> +         *   siul2_0 @ 0x4009c000
>>> +         *   siul2_1 @ 0x44010000
>>> +         *
>>> +         * Every SIUL2 controller has multiple register types, and here
>>> +         * only MSCR and IMCR registers need to be revealed for kernel
>>> +         * to configure pinmux. Please note that some indexes are reserved,
>>> +         * such as MSCR102-MSCR111 in the following reg property.
>>> +         */
>>> +
>>
>> Either this should be part of description or should be dropped. It blows
>> example and probably duplicates DTS.
>>
>>
>> Best regards,
>> Krzysztof
>>

Best regards,
Krzysztof

