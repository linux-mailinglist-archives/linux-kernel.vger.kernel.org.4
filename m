Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784886A921D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCCIEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCIEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:04:04 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285701514B;
        Fri,  3 Mar 2023 00:04:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677830624; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=V7+QiGUeBZfUla4HgROFhe4Iq0FdEBuGP3vF6Zo4zC9lUH9lKc8WTmWxFkNdHBNBJf/gj4WNDv3KAw3zvbZ9cjYOHyhXejrrZGhPC6YtIiqrLRp13oDIrFdp7Wog257rvXwSi6UvRdmVbkWPm17ygRdZ+L6ap8YHKXVGRspI+e0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1677830624; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=U1OiG7H/Mndwf7FgNU+g9XbP976CtK7OQMg286VnDUM=; 
        b=juWgbbUiduOCDOa1YzX9yUxZDvclyubitBq6Rwwgcfh6Ux2AObY6GiIY9o+l6yLfhUwqi5iIRFv5KyQGpjmOE8FvfUe75UqNYK3p2YtPJ6n8bi1LbGp5ictiKjkzsKVfcKFqPuSGTwGLvXAW4OHaFlEEACqZ0IEenU9A/2JtyTM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1677830624;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=U1OiG7H/Mndwf7FgNU+g9XbP976CtK7OQMg286VnDUM=;
        b=DSiUittAGzcp8AMYtPvjUSI6NVhAhOgvuSldbQgK/WSP3UmfapRIS2zsxPkdXkUr
        vVBhkT3WT6E3RWxxdYfpeH9cCybPeGwFVOgs3S158EAgzTc3ZIuu9P3BinvmhuvDJDG
        98WVt9mkfMmFOS/lGTqiSgfCS3c6VROaMtiwsGsg=
Received: from [10.10.10.3] (212.68.60.226 [212.68.60.226]) by mx.zohomail.com
        with SMTPS id 1677830622645510.55169972795534; Fri, 3 Mar 2023 00:03:42 -0800 (PST)
Message-ID: <fa01003f-b189-d84f-d934-9c7c712fce37@arinc9.com>
Date:   Fri, 3 Mar 2023 11:03:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 07/16] dt-bindings: pinctrl: ralink: add new
 compatible strings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <fd2018b2-757f-bd7a-5efd-8a1f28b178cd@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <fd2018b2-757f-bd7a-5efd-8a1f28b178cd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.03.2023 10:53, Krzysztof Kozlowski wrote:
> On 03/03/2023 08:44, Arınç ÜNAL wrote:
>> On 3.03.2023 10:05, Krzysztof Kozlowski wrote:
>>> On 02/03/2023 12:50, Arınç ÜNAL wrote:
>>>> On 2.03.2023 14:36, Krzysztof Kozlowski wrote:
>>>>> On 02/03/2023 11:47, Arınç ÜNAL wrote:
>>>>>> On 2.03.2023 13:29, Krzysztof Kozlowski wrote:
>>>>>>> On 02/03/2023 11:22, Arınç ÜNAL wrote:
>>>>>>>>>>
>>>>>>>>>> ## Incorrect naming
>>>>>>>>>>
>>>>>>>>>> MT7620, MT7621, MT7628, and MT7688 SoCs are incorrectly called Ralink,
>>>>>>>>>> introduce new ralink->mediatek compatible strings to address it.
>>>>>>>>>
>>>>>>>>> So this part was addressed by Rob - we don't do it, because it does not
>>>>>>>>> matter. Ralink is now Mediatek, thus there is no conflict and no issues
>>>>>>>>> with different vendor used.
>>>>>>>>
>>>>>>>> I think Rob was rather addressing that updating compatible strings based
>>>>>>>> on acquisition or marketing whims is not permitted. This condition does
>>>>>>>> not apply here as these SoCs were never Ralink.
>>>>>>>>
>>>>>>>> I understand your point that Ralink is now MediaTek but still, calling
>>>>>>>> these SoCs Ralink would be a bit misleading, don't you think?
>>>>>>>
>>>>>>> Misleading yes, but also does not matter. At least matter not enough to
>>>>>>> justify ABI break, so you would need to deprecate old ones and keep
>>>>>>> everything backwards compatible. You still would affect 3rd party users
>>>>>>> of DTS, though...
>>>>>>
>>>>>> I intend to do just that. Introduce new mediatek strings, keep the old
>>>>>> ones so it's backwards compatible, therefore don't break the ABI.
>>>>>>
>>>>>> Instead of deprecating old strings, I intend to introduce the checks I
>>>>>> mentioned, on the schema, so the pin muxing bindings only apply if the
>>>>>> DT has got a string that won't match multiple schemas. This way it
>>>>>> shouldn't affect 3rd party DTs.
>>>>>
>>>>> I meant, 3rd party users of DTS. You will replace the compatible in the
>>>>> DTS, right? So the DTS exported and used in all other projects, OS,
>>>>> firmwares, bootloaders, out of tree kernel forks will stop working.
>>>>
>>>> I plan to change it on the DTs for MediaTek SoCs, yes. Is this a
>>>> problem? From what I can tell, what must be ensured is that old DTs must
>>>> work with newer kernels, not new DTs on older kernels.
>>>
>>> Can I be clearer than this?
>>>
>>> " So the DTS exported and used in all other projects, OS,
>>> firmwares, bootloaders, out of tree kernel forks will stop working."
>>>
>>> Yes, this is a problem - they will stop working.
>>
>> I've never seen any project just exporting DTs from the latest kernel
>> version and slap it onto old versions, as a new devicetree that was
> 
> Really? U-Boot does it all the time, other projects (like BSD) do it
> periodically to some extend as well.

They must do heavy reviewing before shipping it. Drivers like MediaTek 
ethernet on U-Boot is different than in Linux, the dt-bindings are all 
different. Under a review, these changes will pop out for them to 
address so there're no problems.

> 
>> introduced with a newer kernel version is not guaranteed to work with
>> older kernel versions.
> 
> Not guaranteed but it is expected, though, to some level and under some
> conditions. Therefore it might be or might not be a problem. For some
> platforms no one cares. For some people care.

I'm going to assume there's not much care for this platform, at least 
for mt7621, as I've heard no complaints when I did this before.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/mips/boot/dts/ralink/mt7621.dtsi?id=b4f209e32ba5c283e7b1dd00d867b0536d3e215e

> 
>>
>> If someone is actually doing this on a project, I think it's the
>> responsibility of the maintainers of these said projects to account for
>> this and modify the DT for the kernel version they're running it on.
>>
>> What's more usual is one'd run the kernel version where the new DT was
>> introduced, which will work fine.
> 
> "kernel" as Linux is only one part of it. I mentioned several other
> projects.
> 
>>
>> On to real life implications, popular projects like U-Boot and OpenWrt
>> maintain their own DTs for this platform so I think the impact is very
>> minimal.
> 
> And they sync with Linux kernel DTS.

Again, the DTs must be reviewed so they will be modified and the 
potential issue will be addressed.

Arınç
