Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3746A7F5C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCBKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCBJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:59:18 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE308497EF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:58:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id a25so2782681edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 01:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677751089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quQsZmkiKaETnYTMJly9CAnrwXfTyfISOr41GqRBHEQ=;
        b=EquMUUnvVYKbhMQ8FO3/GqZAqUdsqFcAHF2Od/g2fwxJrzGIcnUXUguaQjkE210wYQ
         JTRHE/CL4DRh63ooBFLsL4VF3wxWvUT2m2/AbAOlbgWRaBbUau0Gfwfta6TaVjWcQckD
         +acdhoOnX9sSQoVs3a2vipKxW2kFD4EEEmM0TG3FW8Wnx1pffFUMV5DzL4SubvC5cI1R
         LmxzySDELNeUx0jsrq+zGmqaCezKsWOSuitbBU784p6DqpfC7vjLGOqtms8+3eQjFhkX
         6bs+8ygvoNXRPdnxBiJVyENjZ/1RoiwlFPvpMxy3kHLRiXdpjjZdjk6APmc7MBY51oir
         eImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677751089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quQsZmkiKaETnYTMJly9CAnrwXfTyfISOr41GqRBHEQ=;
        b=iQ0V/kqo5/HB8+MJBmHBGVzs20pUFowIF8J25xfbWf51yc5tOIkD+6eW5aqL0qq3cr
         6XUDTGKvSgdaO9ITswoF0m8jABYVQaq7qAKIpmdSbCBGwfIRGnuMdqQvEkgQe1EigUWT
         4dn5bTOiKv1rbq7vaR1hAu/Dbk4y+tSdrDVM7Fg/qFn4mg+41mJVGGTEpY90tbJ6xVll
         CeEMxIVRVs3t4FS2NwzT3/8T77YDb8AVyUxg8qH1eLirTRUEFn16EqSKnq7ENNBIha6c
         rlE5v+jXF3aCvrbcIEAqal4wgnQYYXP+MqjmC0Ep7VDZD/57eued2225r8ls3gXdhxX2
         XbnA==
X-Gm-Message-State: AO0yUKWWKVG5UldeIbwhrYdjOxyIAQ4GLLM8YRHAqF68PpHt32NQsacO
        FkB9ARoD5Cbu0WuWq64ygvH6Pg==
X-Google-Smtp-Source: AK7set9OnArQH/PxHu599zgwQafDCjw20cNu6UwnMirkt5rBsGrvK3lhjvbsD0K6SyI6ANwQJ1e26g==
X-Received: by 2002:a17:906:1907:b0:8b1:304e:58a3 with SMTP id a7-20020a170906190700b008b1304e58a3mr9990669eje.52.1677751089159;
        Thu, 02 Mar 2023 01:58:09 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h12-20020a170906530c00b008d71e08c78dsm6852623ejo.81.2023.03.02.01.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 01:58:08 -0800 (PST)
Message-ID: <1aae7ac9-c83d-71b4-4fce-325f02fcd722@linaro.org>
Date:   Thu, 2 Mar 2023 10:58:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 07/16] dt-bindings: pinctrl: ralink: add new
 compatible strings
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Rob Herring <robh@kernel.org>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
 <20230222183932.33267-8-arinc.unal@arinc9.com>
 <20230227173333.GA496999-robh@kernel.org>
 <d7aea90f-d077-3a41-996c-804c95d72e24@arinc9.com>
 <20230301024431.GA251215-robh@kernel.org>
 <ae3346de-140f-f181-b6a3-ccaa694e1548@arinc9.com>
 <11d3c806-04b6-da54-65f1-c0bd154affbc@linaro.org>
 <a9acd3b4-2b03-86c0-711c-a3840aeab574@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a9acd3b4-2b03-86c0-711c-a3840aeab574@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 10:17, Arınç ÜNAL wrote:
> On 2.03.2023 11:28, Krzysztof Kozlowski wrote:
>> On 01/03/2023 09:15, Arınç ÜNAL wrote:
>>> On 1.03.2023 05:44, Rob Herring wrote:
>>>> On Tue, Feb 28, 2023 at 07:46:36PM +0300, Arınç ÜNAL wrote:
>>>>> On 27/02/2023 20:33, Rob Herring wrote:
>>>>>> On Wed, Feb 22, 2023 at 09:39:23PM +0300, arinc9.unal@gmail.com wrote:
>>>>>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>>>>>
>>>>>>> Add the ralink,rt2880-pinmux compatible string. It had been removed from
>>>>>>> the driver which broke the ABI.
>>>>>>>
>>>>>>> Add the mediatek compatible strings. Change the compatible string on the
>>>>>>> examples with the mediatek compatible strings.
>>>>>>>
>>>>>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>>>>> ---
>>>>>>>     .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 7 +++++--
>>>>>>>     .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 7 +++++--
>>>>>>>     .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml | 7 +++++--
>>>>>>>     .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 7 +++++--
>>>>>>>     .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml | 7 +++++--
>>>>>>>     5 files changed, 25 insertions(+), 10 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>>>>>>> index 1e63ea34146a..531b5f616c3d 100644
>>>>>>> --- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>>>>>>> @@ -17,7 +17,10 @@ description:
>>>>>>>     properties:
>>>>>>>       compatible:
>>>>>>> -    const: ralink,mt7620-pinctrl
>>>>>>> +    enum:
>>>>>>> +      - mediatek,mt7620-pinctrl
>>>>>>> +      - ralink,mt7620-pinctrl
>>>>>>
>>>>>> We don't update compatible strings based on acquistions nor marketing
>>>>>> whims. If you want to use 'mediatek' for new things, then fine.
>>>>>
>>>>> Understood. Only the SoCs with rtXXXX were rebranded, the mtXXXX SoCs share
>>>>> the same architecture from Ralink, so they were incorrectly called Ralink
>>>>> SoCs.
>>>>>
>>>>> I can remove the new strings from Ralink SoCs and add them only for MediaTek
>>>>> SoCs. Or you could make an exception for this one, regarding the situation.
>>>>> Whatever you think is best.
>>>>
>>>> I'm not in a position to make an exception as I know little about this
>>>> platform. Carrying both strings is a NAK. Either you (and everyone using
>>>> these platforms) care about the ABI and are stuck with the "wrong"
>>>> string. In the end, they are just unique identifiers. Or you don't care
>>>> and break the ABI and rename everything. If you do that, do just that in
>>>> your patches and make it crystal clear in the commit msg that is your
>>>> intention and why that is okay.
>>>
>>> Ralink had their MIPS SoCs pre-acquisition, RT2880, etc. MediaTek
>>> introduced new SoCs post-acquisition, MT7620, MT7621, MT7628, and
>>> MT7688, utilising the same platform from Ralink, sharing the same
>>> architecture code, pinctrl core driver, etc.
>>>
>>> I don't intend to break the ABI at all. On the contrary, I fix it where
>>> possible.
>>>
>>> If I understand correctly, from this conversation and what Krzysztof
>>> said, all strings must be kept on the schemas so I can do what I said on
>>> the composed mail. Only match the pin muxing information on the strings
>>> that won't match multiple pin muxing information from other schemas.
>>>
>>> This way we don't break the ABI, introduce new compatible strings while
>>> keeping the remaining ones, and make schemas match correctly.
>>>
>>> Let me know if this is acceptable to you.
>>
>> If by "introduce new compatible strings" you mean duplicate compatibles
>> to fix the ralink->mediatek, then you ignored entire email from Rob -
>> this and previous. We don't do this. Leave them as is.
>>
>> If you meant something else, explain more...
> 
> Let me put them in a group to better explain.
> 
> ## Fix ABI
> 
> ralink,rt2880-pinmux was there before, it was removed which broke the 
> ABI. I'm reintroducing it to fix it.
> 
> ## New strings to be able to split bindings
> 
> New strings are needed for MT7628/MT7688 and some RT SoCs to be able to 
> properly document the pin muxing information.

Then ok.

> 
> ## Incorrect naming
> 
> MT7620, MT7621, MT7628, and MT7688 SoCs are incorrectly called Ralink, 
> introduce new ralink->mediatek compatible strings to address it.

So this part was addressed by Rob - we don't do it, because it does not
matter. Ralink is now Mediatek, thus there is no conflict and no issues
with different vendor used.

> 
> ## Exception for RT SoCs to be called MediaTek
> 
> This is where I was asking an exception to be made. Rob told us here 
> they know little about the platform so I explained it.
> 
> MediaTek acquired Ralink and then introduced new MediaTek SoCs utilising 
> the same platform from Ralink.
> 
> Anyway, now that I look at this again, it makes sense to me as well not 
> to rename the Ralink SoCs. I'll call the RT SoCs Ralink on the kconfig, 
> pinctrl driver,

These are separate. We did not comment on how you call Linux drivers.
The mail thread was only about:

> and dt-binding schemas on my next version.

Best regards,
Krzysztof

