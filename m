Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6D36A7C9C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCBI23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCBI21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:28:27 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8461716
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:28:25 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id i34so64360628eda.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 00:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677745703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=binSKFTDATr+VUKohUw2T7hk+6PX9qDP2BHHB8PRuJo=;
        b=mjWQKSxWU0MWNWy+hU0ECvGqOwKXr5a/+XYWNhxzSUdCH0AsfpGHiTfH2W7uX8Y5A6
         g/B8AoDC5b10P420IBVnUI72+9vvZndG9XLWb7hk+reTCagYgIOKlcjW+JVGAxtqjQEF
         AJOL2pVmMlQm5Ow5PrigaLvuegmbMF4lxa+AL9ye1vd37CsnEhfl2xhNja9vuPsi7FTI
         qicGKxLERMp3M9lWlJPFitAqWzXeCKVVUbaQvTE7eRqabUhUrpfGPv+85WueCeb02AzT
         Y2FnJ4NIfnZzersPkJJopWkgKZIIq1rk3DXZVUcVgHVgDjj3P1CVjWCkx4eNSUUHkhS0
         0x9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677745703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=binSKFTDATr+VUKohUw2T7hk+6PX9qDP2BHHB8PRuJo=;
        b=TglxJ1sMX6gxntHfiA1Q/TIULlxKaxfZv0BLSJGht1xq7IBpG/Y577gQo7mkWBkHaw
         fvhlVYmpThRrQX+w2IVj1bQxSAHb83+I2qbJEqyBEFNUJRrY9nXmgI28wZk7uftPK/DD
         M02LN7YppgE9E09RfMf7GJSrvUERFCKyIm2m50dtg/1PLRep5iz9Ap5yO5NU2Wfc4vrs
         AgWClAwNTe6TV65iNp1B71IZg8kMZ/cIE1UfWCA8c9D93936Dr2mbYjVMA4TUBujagf0
         hY15abAllOiLNMbAlYdFkU0deAIRVL1b8qxQP3ci/+tjeIX2uy3u/dfztZ8Tt/DgGqcQ
         uURw==
X-Gm-Message-State: AO0yUKWPAvR7qL6u6NYCNh2hyE7S5LAKf1GuwqCu8Tek9uKarCEeL+kR
        VPk77qR/X821YAhKhlGZUwp+iA==
X-Google-Smtp-Source: AK7set+sya+UufcyMJpds/o5eIN1syxY+wLyLZB9BFt9OhvL1PkZ9IK+iHqBR/gdWrOSJTSc4p7EVQ==
X-Received: by 2002:aa7:d856:0:b0:4af:6e95:861b with SMTP id f22-20020aa7d856000000b004af6e95861bmr1487899eds.2.1677745703475;
        Thu, 02 Mar 2023 00:28:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q21-20020a50cc95000000b004c0c5864cc5sm214800edi.25.2023.03.02.00.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 00:28:23 -0800 (PST)
Message-ID: <11d3c806-04b6-da54-65f1-c0bd154affbc@linaro.org>
Date:   Thu, 2 Mar 2023 09:28:21 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ae3346de-140f-f181-b6a3-ccaa694e1548@arinc9.com>
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

On 01/03/2023 09:15, Arınç ÜNAL wrote:
> On 1.03.2023 05:44, Rob Herring wrote:
>> On Tue, Feb 28, 2023 at 07:46:36PM +0300, Arınç ÜNAL wrote:
>>> On 27/02/2023 20:33, Rob Herring wrote:
>>>> On Wed, Feb 22, 2023 at 09:39:23PM +0300, arinc9.unal@gmail.com wrote:
>>>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>>>
>>>>> Add the ralink,rt2880-pinmux compatible string. It had been removed from
>>>>> the driver which broke the ABI.
>>>>>
>>>>> Add the mediatek compatible strings. Change the compatible string on the
>>>>> examples with the mediatek compatible strings.
>>>>>
>>>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>>> ---
>>>>>    .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 7 +++++--
>>>>>    .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 7 +++++--
>>>>>    .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml | 7 +++++--
>>>>>    .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 7 +++++--
>>>>>    .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml | 7 +++++--
>>>>>    5 files changed, 25 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>>>>> index 1e63ea34146a..531b5f616c3d 100644
>>>>> --- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>>>>> @@ -17,7 +17,10 @@ description:
>>>>>    properties:
>>>>>      compatible:
>>>>> -    const: ralink,mt7620-pinctrl
>>>>> +    enum:
>>>>> +      - mediatek,mt7620-pinctrl
>>>>> +      - ralink,mt7620-pinctrl
>>>>
>>>> We don't update compatible strings based on acquistions nor marketing
>>>> whims. If you want to use 'mediatek' for new things, then fine.
>>>
>>> Understood. Only the SoCs with rtXXXX were rebranded, the mtXXXX SoCs share
>>> the same architecture from Ralink, so they were incorrectly called Ralink
>>> SoCs.
>>>
>>> I can remove the new strings from Ralink SoCs and add them only for MediaTek
>>> SoCs. Or you could make an exception for this one, regarding the situation.
>>> Whatever you think is best.
>>
>> I'm not in a position to make an exception as I know little about this
>> platform. Carrying both strings is a NAK. Either you (and everyone using
>> these platforms) care about the ABI and are stuck with the "wrong"
>> string. In the end, they are just unique identifiers. Or you don't care
>> and break the ABI and rename everything. If you do that, do just that in
>> your patches and make it crystal clear in the commit msg that is your
>> intention and why that is okay.
> 
> Ralink had their MIPS SoCs pre-acquisition, RT2880, etc. MediaTek 
> introduced new SoCs post-acquisition, MT7620, MT7621, MT7628, and 
> MT7688, utilising the same platform from Ralink, sharing the same 
> architecture code, pinctrl core driver, etc.
> 
> I don't intend to break the ABI at all. On the contrary, I fix it where 
> possible.
> 
> If I understand correctly, from this conversation and what Krzysztof 
> said, all strings must be kept on the schemas so I can do what I said on 
> the composed mail. Only match the pin muxing information on the strings 
> that won't match multiple pin muxing information from other schemas.
> 
> This way we don't break the ABI, introduce new compatible strings while 
> keeping the remaining ones, and make schemas match correctly.
> 
> Let me know if this is acceptable to you.

If by "introduce new compatible strings" you mean duplicate compatibles
to fix the ralink->mediatek, then you ignored entire email from Rob -
this and previous. We don't do this. Leave them as is.

If you meant something else, explain more...

Best regards,
Krzysztof

