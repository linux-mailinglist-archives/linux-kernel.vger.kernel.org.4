Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1AF642956
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiLEN1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiLEN1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:27:04 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A293E1C91E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:27:02 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d6so18513598lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 05:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEi78HiNqFu1GIW9u8amVgxX/62kZk14mkEDDfKjOlw=;
        b=wULoWNjWdPEj015yU7ZjIaleb6j0cazdL0S5zb2z9XwLgDDk+pvyBEDf7xnBNQOhmU
         SqWC09iRraTtFbthsqu2Htgivb5dL/P+aFyy/5IhfgIz3njpam02ClcjyOF76OUvpzAZ
         z58JwiW+aKvjEeDeeRcJt7N3sQxVUInqP6gq8R7lgRERdR4QEEXJFxuCsiR0D84BfMCM
         XKc/SoTlbuVY8LGMO++uA2Vv9Tbw7etSTLjgUHt5A+yX9O3AsDiy85ucwDVerCaV8Po6
         iQYJdIJ9U8o/K6McA3PxGO9E+odbTxdfp4aW3/sc73mK3HkFkZyH/5MTF+5E0Ucff2TB
         S8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEi78HiNqFu1GIW9u8amVgxX/62kZk14mkEDDfKjOlw=;
        b=Y6n+rnvBirL/7eYtdrT7PRS2RlFrpA84Yd/qT/pysQ8DmHzTWCLbh8JfXAnH0QYGsG
         scykTlvV7TVH01y80Ndtl3B1hmE3GAEcxjX41PHQS7DZ6PZHCctwDbdA+LSfKBqyl9SL
         yLUpDr38mTUP/6SRVdcJRVSvoHpGWgTACxP9PYqzK1DBnyOTk1PevANubTzAeUky9eX+
         zM+LlQIzvicp2zyRgftQkj0ME/iZI2foKuquWv+WQluDsz79DpZcELpt1O/Snyitwf8R
         u/91e9eVbbVcheAC1bY+/N83TbIny52D/KJQTHqgqydFejGHfSHMyV7Dn7qaZF3GIjNc
         kJGw==
X-Gm-Message-State: ANoB5plieWX8IrE31+nBupf54fhbfSKqe0i/nSnSHA0LZ30Kvc3znG3i
        DUhlpnXnNgcZMYHzapd0+1K5pw==
X-Google-Smtp-Source: AA0mqf66sPDMG05cHXegksgvrRpbkt97pW9nIcGQHTSWPQQ8qIruQpc5+4gvNdjbwE4Ix5RJxC9sQg==
X-Received: by 2002:a19:ee07:0:b0:4b5:2830:8998 with SMTP id g7-20020a19ee07000000b004b528308998mr8514983lfb.267.1670246820897;
        Mon, 05 Dec 2022 05:27:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d23-20020ac244d7000000b004b5748fa3afsm441063lfm.107.2022.12.05.05.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 05:27:00 -0800 (PST)
Message-ID: <e6ee1ec2-1649-3e7e-9dbe-e94d636d8476@linaro.org>
Date:   Mon, 5 Dec 2022 14:26:59 +0100
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
 <e839274d-6696-63aa-14e6-f52a534c9ed2@linaro.org>
 <Y43Qdco0y61C4l1I@linux-8mug>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y43Qdco0y61C4l1I@linux-8mug>
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

On 05/12/2022 12:05, Chester Lin wrote:
> On Mon, Dec 05, 2022 at 10:02:14AM +0100, Krzysztof Kozlowski wrote:
>> On 05/12/2022 07:16, Chester Lin wrote:
>>> Hi Krzysztof,
>>>
>>> On Wed, Nov 30, 2022 at 03:58:52PM +0100, Krzysztof Kozlowski wrote:
>>>> On 28/11/2022 06:48, Chester Lin wrote:
>>>>> Add DT schema for the pinctrl driver of NXP S32 SoC family.
>>>>>
>>>>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>>>>> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
>>>>> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
>>>>> Signed-off-by: Chester Lin <clin@suse.com>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> - Remove the "nxp,pins" property since it has been moved into the driver.
>>>>> - Add descriptions for reg entries.
>>>>> - Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".
>>>>> - Fix schema issues and revise the example.
>>>>> - Fix the copyright format suggested by NXP.
>>>>>
>>>>>  .../pinctrl/nxp,s32cc-siul2-pinctrl.yaml      | 125 ++++++++++++++++++
>>>>>  1 file changed, 125 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..2fc25a9362af
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
>>>>
>>>> Usually filename matches the compatible (or family name), so any reason
>>>> why compatible is "nxp,s32g2" but filename is "nxp,s32cc"?
>>>>
>>>
>>> According to NXP, the S32CC is a microarch which is adapted by different S32 SoCs,
>>> such as S32G2/G3 and S32R45. Some common IPs are implemented in S32CC, such as
>>> serial, pinctrl, mmc, gmac and some other peripheral interfaces. S32R45 has
>>> different pinouts compared to S32G2, which means that there would not be just
>>> "s32g2-siul2-pinctrl" but also "s32r45-siul2-pinctrl" in the compatible enum if
>>> S32R45 has to be upstreamed in the future. For this case, it seems to be
>>> inappropriate that adding a compatible name without any "s32g" keyword in the
>>> filename "nxp,s32g2-.." unless creating a new yaml for each platform, such as
>>> nxp,s32r45-siul2-pinctl.yaml.
>>
>> First, you can always rename a file if such need arises. Maybe new SoCs
>> will come, maybe not.
>>
>> Second, when you actually upstream new SoC it might anyway require new
>> bindings file, because pinctrls are quite specific and it is usually
>> difficult to support multiple devices in a nice, readable way in one
>> file. Therefore anyway another file is quite likely.
>>
> 
> Thanks for your guidance. Will fix it.
> 
>> (...)
>>
>>>>> +
>>>>> +patternProperties:
>>>>> +  '-pins$':
>>>>> +    type: object
>>>>> +    additionalProperties: false
>>>>> +
>>>>> +    patternProperties:
>>>>> +      '-grp[0-9]$':
>>>>> +        type: object
>>>>> +        allOf:
>>>>> +          - $ref: pinmux-node.yaml#
>>>>> +          - $ref: pincfg-node.yaml#
>>>>> +        unevaluatedProperties: false
>>>>> +        description:
>>>>> +          Pinctrl node's client devices specify pin muxes using subnodes,
>>>>> +          which in turn use the standard properties.
>>>>
>>>> All properties are accepted? What about values, e.g. for drive strength?
>>>
>>> For those unsupported properties such as drive-strength, the s32g2 pinctrl driver
>>> returns -EOPNOTSUPP.
>>
>> I don't care what the driver is doing, we do not discuss the driver. You
>> need to describe properly the hardware and I doubt that hardware accepts
>> all drive-strengths, all forms of pull resistors (so any Ohm value).
>>
>> Add constrains.
>>
> 
> Thanks for the suggestion. IIUC, I should specifically described the supported
> pinmux and pincfg properties in this schema and then add an "additionalProperties: false"

Yes.

> in the end in order to constrain unsupported properties listed in the pattern
> pin groups.

You mean functions? or node names? The node names can be anything, can't
they?

If your drive strengths or slew rates have some limits, then I expect
them here.

Best regards,
Krzysztof

