Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8116A818E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCBLvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCBLv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:51:29 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA0735255;
        Thu,  2 Mar 2023 03:51:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677757864; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=SN9puppPB/171h6AH8Mr5hidGWd4fY/hXs7wKplQ+spCW5r49QgeSuVD9YeYdJFNYE+7MzFqVsucDWq/pf4FNFEaENsm4MH2Gt7vWW3eE3v78r/OclWWeLZyS58mMg6AzH59iChPOloh7LXGunsi8+TkRM0KhPqV59rzFKz4UFY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1677757864; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=leLmz9qeZA+jfwuaL6YwWi5P1E3ee6MYIL5R31QpwuA=; 
        b=MPb6uLjaPAJiQ+KFzmDwl8PLJRznHybYD1CTOZ5ZD4EJxQaz/x96lXpAZhCNVpMbyrtiYa6FroMq7WxwgOTXEFxugZiDdiKpwSEL9qDTXXL6MOb13lmNZfBLWX0TV5LJD6uBsHYbuJwpnQVwUvSqD/QCdC/WiOHiwvuF1q4DDis=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1677757864;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=leLmz9qeZA+jfwuaL6YwWi5P1E3ee6MYIL5R31QpwuA=;
        b=FouMHzSLkUwW2vcXEEDRN411mAHMT8cdma9sbLsp0TZfR4S8Uc4rMO4mqCjzLUzj
        oEVNeMI2V0QR74WaknuglXXIclVafbAFcPzb4Q61AWDJ5FtecTfZdlKmWn4gjwnhnIs
        tATFiNSqtPLXxm4fjF2B75eNNP25JhWOebGOyFKk=
Received: from [10.10.10.3] (212.68.60.226 [212.68.60.226]) by mx.zohomail.com
        with SMTPS id 1677757862877899.0721856528986; Thu, 2 Mar 2023 03:51:02 -0800 (PST)
Message-ID: <11d10e4e-65ec-3bec-3e0c-7e57feb03506@arinc9.com>
Date:   Thu, 2 Mar 2023 14:50:49 +0300
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
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <83a03258-9e52-3d09-67fe-12e9e5ed4b76@linaro.org>
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

On 2.03.2023 14:36, Krzysztof Kozlowski wrote:
> On 02/03/2023 11:47, Arınç ÜNAL wrote:
>> On 2.03.2023 13:29, Krzysztof Kozlowski wrote:
>>> On 02/03/2023 11:22, Arınç ÜNAL wrote:
>>>>>>
>>>>>> ## Incorrect naming
>>>>>>
>>>>>> MT7620, MT7621, MT7628, and MT7688 SoCs are incorrectly called Ralink,
>>>>>> introduce new ralink->mediatek compatible strings to address it.
>>>>>
>>>>> So this part was addressed by Rob - we don't do it, because it does not
>>>>> matter. Ralink is now Mediatek, thus there is no conflict and no issues
>>>>> with different vendor used.
>>>>
>>>> I think Rob was rather addressing that updating compatible strings based
>>>> on acquisition or marketing whims is not permitted. This condition does
>>>> not apply here as these SoCs were never Ralink.
>>>>
>>>> I understand your point that Ralink is now MediaTek but still, calling
>>>> these SoCs Ralink would be a bit misleading, don't you think?
>>>
>>> Misleading yes, but also does not matter. At least matter not enough to
>>> justify ABI break, so you would need to deprecate old ones and keep
>>> everything backwards compatible. You still would affect 3rd party users
>>> of DTS, though...
>>
>> I intend to do just that. Introduce new mediatek strings, keep the old
>> ones so it's backwards compatible, therefore don't break the ABI.
>>
>> Instead of deprecating old strings, I intend to introduce the checks I
>> mentioned, on the schema, so the pin muxing bindings only apply if the
>> DT has got a string that won't match multiple schemas. This way it
>> shouldn't affect 3rd party DTs.
> 
> I meant, 3rd party users of DTS. You will replace the compatible in the
> DTS, right? So the DTS exported and used in all other projects, OS,
> firmwares, bootloaders, out of tree kernel forks will stop working.

I plan to change it on the DTs for MediaTek SoCs, yes. Is this a 
problem? From what I can tell, what must be ensured is that old DTs must 
work with newer kernels, not new DTs on older kernels.

Arınç
