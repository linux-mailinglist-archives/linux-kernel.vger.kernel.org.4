Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2C56A916E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCCHFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjCCHFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:05:47 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6479119F3B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:05:45 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cw28so6566589edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 23:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677827144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hyO83Agm9J1LkrNZzgMmPOSi1e0C8pD1X+9+f3Pu8E=;
        b=DTsZvcGSh0JqYAWl73FtkLBOgToNuhgRMthIP75ZhbLj4hvKzx8xLSWmq6ZecBm+fc
         WnGaFSR/szAif5FxMioBLi8lXOMjwyl9YYBRW1qvfrNJQ7y6enmqBFXC6knizv5FRC7w
         gLcW7RZF7IeggDaKwtL/qn/wbEyuyR91AVlWq5dAw46hbqc6EYma+NwexHXqBlDdZGaB
         0Kw0lNAnA0Yk98iEdnIWnFQ2Wi5nbeYto+qJucXYry5HG84g0JbO9dCjhmRWcEXGLp9r
         AnMwj+SQ1t8ltYXBcQvr/J9V6aYgCkp+SkBohiYeeoKguZDW2uGNeBFyo3FRxcIff5gD
         KvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677827144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hyO83Agm9J1LkrNZzgMmPOSi1e0C8pD1X+9+f3Pu8E=;
        b=oY+LbfJeRcrpj5baBWT1qCOFhfsgxg3pmrGnUog649oase2vzjCboQifEls+bdWqGi
         rkfl/2k893TlylNHSGN0o2nlHPGs2xpK+8XrCoDDMy9mgK6bka94+rB1trF2x7glMZNC
         cEngHCS79J/NvZlSQSNcrTcYGPtCW+pM/WG6SGv3thQguFDQec8oTcA3Y6sbkGB1Vu62
         n1ARm0eNp7kk1BEKxBPSVDzrze6TxYGHnKgbL6uBmnlaRcV75GMsHER0jndlhFR3dce7
         r+gaY4L8WInfXZYiTJjeswCRhTetfAxqoiGhlV9WAp2SHmrTk/V39+wrxCPquMR2Raa6
         CkyA==
X-Gm-Message-State: AO0yUKWwh+PKHt82LQsGfPjNiar5Uhn7aQ7k/rgYRTu19egLVKgDtgfC
        lgYmKpGP+EX3JNYVBSUoMg575w==
X-Google-Smtp-Source: AK7set872PawA8YLwYxckp8bhyhvu6/0N24CzD55UJ1kPz74D0pEza8jIQRyk/4Shrewd1pziePgRg==
X-Received: by 2002:a05:6402:1347:b0:4ab:1c69:5c4 with SMTP id y7-20020a056402134700b004ab1c6905c4mr884592edw.26.1677827143862;
        Thu, 02 Mar 2023 23:05:43 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k12-20020a50ce4c000000b004c0459c20f9sm772279edj.66.2023.03.02.23.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:05:43 -0800 (PST)
Message-ID: <a696bea5-3ba6-3b71-10ad-a04a7412c178@linaro.org>
Date:   Fri, 3 Mar 2023 08:05:40 +0100
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
 <1aae7ac9-c83d-71b4-4fce-325f02fcd722@linaro.org>
 <89588f69-9cf0-e7a4-b976-5ce87d42e296@arinc9.com>
 <2ccb573d-39f4-cb80-7a3e-63a60c2bc0a8@linaro.org>
 <b48e0a5e-dd45-8b8a-4ee3-357a0985ca9c@arinc9.com>
 <83a03258-9e52-3d09-67fe-12e9e5ed4b76@linaro.org>
 <11d10e4e-65ec-3bec-3e0c-7e57feb03506@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <11d10e4e-65ec-3bec-3e0c-7e57feb03506@arinc9.com>
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

On 02/03/2023 12:50, Arınç ÜNAL wrote:
> On 2.03.2023 14:36, Krzysztof Kozlowski wrote:
>> On 02/03/2023 11:47, Arınç ÜNAL wrote:
>>> On 2.03.2023 13:29, Krzysztof Kozlowski wrote:
>>>> On 02/03/2023 11:22, Arınç ÜNAL wrote:
>>>>>>>
>>>>>>> ## Incorrect naming
>>>>>>>
>>>>>>> MT7620, MT7621, MT7628, and MT7688 SoCs are incorrectly called Ralink,
>>>>>>> introduce new ralink->mediatek compatible strings to address it.
>>>>>>
>>>>>> So this part was addressed by Rob - we don't do it, because it does not
>>>>>> matter. Ralink is now Mediatek, thus there is no conflict and no issues
>>>>>> with different vendor used.
>>>>>
>>>>> I think Rob was rather addressing that updating compatible strings based
>>>>> on acquisition or marketing whims is not permitted. This condition does
>>>>> not apply here as these SoCs were never Ralink.
>>>>>
>>>>> I understand your point that Ralink is now MediaTek but still, calling
>>>>> these SoCs Ralink would be a bit misleading, don't you think?
>>>>
>>>> Misleading yes, but also does not matter. At least matter not enough to
>>>> justify ABI break, so you would need to deprecate old ones and keep
>>>> everything backwards compatible. You still would affect 3rd party users
>>>> of DTS, though...
>>>
>>> I intend to do just that. Introduce new mediatek strings, keep the old
>>> ones so it's backwards compatible, therefore don't break the ABI.
>>>
>>> Instead of deprecating old strings, I intend to introduce the checks I
>>> mentioned, on the schema, so the pin muxing bindings only apply if the
>>> DT has got a string that won't match multiple schemas. This way it
>>> shouldn't affect 3rd party DTs.
>>
>> I meant, 3rd party users of DTS. You will replace the compatible in the
>> DTS, right? So the DTS exported and used in all other projects, OS,
>> firmwares, bootloaders, out of tree kernel forks will stop working.
> 
> I plan to change it on the DTs for MediaTek SoCs, yes. Is this a 
> problem? From what I can tell, what must be ensured is that old DTs must 
> work with newer kernels, not new DTs on older kernels.

Can I be clearer than this?

" So the DTS exported and used in all other projects, OS,
firmwares, bootloaders, out of tree kernel forks will stop working."

Yes, this is a problem - they will stop working.

Best regards,
Krzysztof

