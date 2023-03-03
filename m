Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4D46A91FD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCCHxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCCHxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:53:20 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB872686C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:53:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x3so6792845edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 23:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677829997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PbStGtTBem/zlIjosDLJ3+4EFL9CTyA5QKL7zAuqqU=;
        b=R16+5AMP9JbBAvAQ0qtcfoPtvc2hQi1t6gWkCxIA5GTfFGcoKWoIrNGyBRjKPWpCBu
         fRiMyUof1aFyO+u5bXCwL+mDByp2MaOYQ7mQTc4ZAx7quxAVRvs7FyWcESsW0ghKMjdv
         orzM6NarkLZ/q2tMDpbM7lCw7AYGrv8qMlH8tVN8mh31P103wpXjCo1oJQ28V5e+HxHL
         I/TnyNsohkvchnp5JlT4x6tgTp+aH2KxKWICJN1e7d0CJCQSsUvlqZ8AiXry6QTWOt2Z
         /eXl2zuVdejfenWWqAeE24YzJpL1vz/XSPORZNHGa2+8qU/aWP5t5mg+EQeGLTHQO0to
         VpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677829997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PbStGtTBem/zlIjosDLJ3+4EFL9CTyA5QKL7zAuqqU=;
        b=MxU8UsRDC7T1S0KAwLNOgx19XuQOeMgPNIkjJGkHU9adPATTp/RvwRO11avAP/zLLS
         1s5mwEAp0AaRisYi90owynCVvfUdmMWTdLUGXgdL9kM7oxEqwMAruV70XlKfaY4CuDmL
         mYFNNZLtJUCA+w8yhOVIS5HqEO0EtYOB7Gl04WmyPS2vy4LzNC/pjuwddrkjp0l5YgzB
         rm9YGRqH+C2ki2CClfqSn7vywC/5y1/as/KSJ6rI/QabDOYl/PUKhLfJOR8W5KSdC0IZ
         sSKtxv0Pdv80IpK80IV8DY7fneNmXujmUwz7eirlOW+obEuCwyB2/Yo6IOBvRTq8MmmD
         misQ==
X-Gm-Message-State: AO0yUKXmqipw5qTWslHMojG7Da5yJuS2giIabvvexbg2ofG2o0uyMF1i
        ZcHgxxDsEot22m5KsE3u1Fn+kQ==
X-Google-Smtp-Source: AK7set9x3dOthKcO2LgSNonWauqXUr6ExI9x8gAo5dIsgQqaxoMqhXT+yzhwKRkXWfzJXa+kwcnCWA==
X-Received: by 2002:a17:907:204c:b0:8b1:7e1a:ef22 with SMTP id pg12-20020a170907204c00b008b17e1aef22mr689933ejb.45.1677829997641;
        Thu, 02 Mar 2023 23:53:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090682c400b008d4b6f086c9sm654201ejy.185.2023.03.02.23.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:53:17 -0800 (PST)
Message-ID: <fd2018b2-757f-bd7a-5efd-8a1f28b178cd@linaro.org>
Date:   Fri, 3 Mar 2023 08:53:13 +0100
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
 <a696bea5-3ba6-3b71-10ad-a04a7412c178@linaro.org>
 <4c522dc3-d6f4-fd3e-e715-4c7795576541@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4c522dc3-d6f4-fd3e-e715-4c7795576541@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 08:44, Arınç ÜNAL wrote:
> On 3.03.2023 10:05, Krzysztof Kozlowski wrote:
>> On 02/03/2023 12:50, Arınç ÜNAL wrote:
>>> On 2.03.2023 14:36, Krzysztof Kozlowski wrote:
>>>> On 02/03/2023 11:47, Arınç ÜNAL wrote:
>>>>> On 2.03.2023 13:29, Krzysztof Kozlowski wrote:
>>>>>> On 02/03/2023 11:22, Arınç ÜNAL wrote:
>>>>>>>>>
>>>>>>>>> ## Incorrect naming
>>>>>>>>>
>>>>>>>>> MT7620, MT7621, MT7628, and MT7688 SoCs are incorrectly called Ralink,
>>>>>>>>> introduce new ralink->mediatek compatible strings to address it.
>>>>>>>>
>>>>>>>> So this part was addressed by Rob - we don't do it, because it does not
>>>>>>>> matter. Ralink is now Mediatek, thus there is no conflict and no issues
>>>>>>>> with different vendor used.
>>>>>>>
>>>>>>> I think Rob was rather addressing that updating compatible strings based
>>>>>>> on acquisition or marketing whims is not permitted. This condition does
>>>>>>> not apply here as these SoCs were never Ralink.
>>>>>>>
>>>>>>> I understand your point that Ralink is now MediaTek but still, calling
>>>>>>> these SoCs Ralink would be a bit misleading, don't you think?
>>>>>>
>>>>>> Misleading yes, but also does not matter. At least matter not enough to
>>>>>> justify ABI break, so you would need to deprecate old ones and keep
>>>>>> everything backwards compatible. You still would affect 3rd party users
>>>>>> of DTS, though...
>>>>>
>>>>> I intend to do just that. Introduce new mediatek strings, keep the old
>>>>> ones so it's backwards compatible, therefore don't break the ABI.
>>>>>
>>>>> Instead of deprecating old strings, I intend to introduce the checks I
>>>>> mentioned, on the schema, so the pin muxing bindings only apply if the
>>>>> DT has got a string that won't match multiple schemas. This way it
>>>>> shouldn't affect 3rd party DTs.
>>>>
>>>> I meant, 3rd party users of DTS. You will replace the compatible in the
>>>> DTS, right? So the DTS exported and used in all other projects, OS,
>>>> firmwares, bootloaders, out of tree kernel forks will stop working.
>>>
>>> I plan to change it on the DTs for MediaTek SoCs, yes. Is this a
>>> problem? From what I can tell, what must be ensured is that old DTs must
>>> work with newer kernels, not new DTs on older kernels.
>>
>> Can I be clearer than this?
>>
>> " So the DTS exported and used in all other projects, OS,
>> firmwares, bootloaders, out of tree kernel forks will stop working."
>>
>> Yes, this is a problem - they will stop working.
> 
> I've never seen any project just exporting DTs from the latest kernel 
> version and slap it onto old versions, as a new devicetree that was 

Really? U-Boot does it all the time, other projects (like BSD) do it
periodically to some extend as well.

> introduced with a newer kernel version is not guaranteed to work with 
> older kernel versions.

Not guaranteed but it is expected, though, to some level and under some
conditions. Therefore it might be or might not be a problem. For some
platforms no one cares. For some people care.

> 
> If someone is actually doing this on a project, I think it's the 
> responsibility of the maintainers of these said projects to account for 
> this and modify the DT for the kernel version they're running it on.
> 
> What's more usual is one'd run the kernel version where the new DT was 
> introduced, which will work fine.

"kernel" as Linux is only one part of it. I mentioned several other
projects.

> 
> On to real life implications, popular projects like U-Boot and OpenWrt 
> maintain their own DTs for this platform so I think the impact is very 
> minimal.

And they sync with Linux kernel DTS.

> 
> Anyway, I'm not doing this change on this patch series so why don't we 
> cross this bridge when we get to it.


Best regards,
Krzysztof

