Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17426B2F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCIVJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCIVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:09:16 -0500
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D0EBCBA2;
        Thu,  9 Mar 2023 13:09:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678396135; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Bbti79w/Br4b4vVEyS6oPSxIWYbgXyQwNKVx6ilIbe3TMlTvoREu+PHSdHGck/5QlYCwX1mWPbp967sV7fFOTX/tqR82EBd+1AaREPmARZWzbuBQ6qJtKPv72MBClbXC0c81NSuMBe18wwczwvKc1jIhxuV+f+PzqOhnYqzvohw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1678396135; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=FbvYjGKh6vNtScU621YiU8MM8si+Iyxhu8lu7ItBEOE=; 
        b=nez0VANeRDRfgiv/TdgPkBStFX9wPXpeRqlp1vhAF29StdkcBzCLrxXaCA1K89cZT65qpx39V7Hfl5TQN4QNFW5sDkhj92r9lxn+7COHdMXDKZ4FRORz/DVcRsvSEpwwUQYJ3+QJHeIsKPKGjTsfoBk4CSmUfRF29qad0gOgu6s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1678396135;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=FbvYjGKh6vNtScU621YiU8MM8si+Iyxhu8lu7ItBEOE=;
        b=PZGUeZ7cnzFK0HJrPcpRcuW1pm6SKDZXKK4PxCbFyr5Nj0eOBiF+CeiWNcVoHYwg
        30lbNbc+AdoAn1/SWShSD9GqcTUu/PEMdxOe2nGtSTYw+2P55QWir3MJmIHU6IJW3Xn
        aB2sXGj4cA0oaNC9ifd7frS8gtmq6CAbm4LV3gbI=
Received: from [10.10.10.3] (212.68.60.226 [212.68.60.226]) by mx.zohomail.com
        with SMTPS id 1678396133550757.0977262947952; Thu, 9 Mar 2023 13:08:53 -0800 (PST)
Message-ID: <81cf9e50-d626-cbb3-ebb1-56d080eca66d@arinc9.com>
Date:   Fri, 10 Mar 2023 00:08:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 09/20] dt-bindings: pinctrl: ralink: {mt7620,mt7621}:
 rename to mediatek
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
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
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
 <20230303002850.51858-10-arinc.unal@arinc9.com>
 <20230308210514.GA3767521-robh@kernel.org>
 <12be053e-b70a-faca-71c8-d8eef69a3b73@arinc9.com>
 <ccdfd262-eaf3-dbbe-7a3c-a911a5ec0fc4@arinc9.com>
 <9663817e-7f6f-c3b1-8bf9-321f9b067e96@linaro.org>
 <deca532a-bdf5-c49e-1422-ce6124b61882@arinc9.com>
 <CAMhs-H8M3ir+DshHF60W=QMn9WG3Jgbo8GgXZnDKCLhs=+WBoQ@mail.gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CAMhs-H8M3ir+DshHF60W=QMn9WG3Jgbo8GgXZnDKCLhs=+WBoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.03.2023 14:33, Sergio Paracuellos wrote:
> On Thu, Mar 9, 2023 at 11:34 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>
>> On 9.03.2023 12:52, Krzysztof Kozlowski wrote:
>>> On 09/03/2023 08:53, Arınç ÜNAL wrote:
>>>> On 9.03.2023 00:19, Arınç ÜNAL wrote:
>>>>> On 9.03.2023 00:05, Rob Herring wrote:
>>>>>> On Fri, Mar 03, 2023 at 03:28:38AM +0300, arinc9.unal@gmail.com wrote:
>>>>>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>>>>>
>>>>>>> This platform from Ralink was acquired by MediaTek in 2011. Then,
>>>>>>> MediaTek
>>>>>>> introduced these SoCs which utilise this platform. Rename the schemas to
>>>>>>> mediatek to address the incorrect naming.
>>>>>>
>>>>>> I said we don't do renames due to acquistions, you said that wasn't the
>>>>>> reason, but then that's your reasoning here.
>>>>>
>>>>> It's not a marketing/acquistion rename as the name of these SoCs were
>>>>> wrong from the get go. The information on the first sentence is to give
>>>>> the idea of why these SoCs were wrongfully named as the base platform
>>>>> that these new MediaTek SoCs share code with was called Ralink.
>>>>>
>>>>>>
>>>>>> To give you another example, *new* i.MX things are still called
>>>>>> 'fsl,imx...' and it has been how many years since merging with NXP?
>>>>>
>>>>> Ok this is a point I see now. Though, I fail to see how this is called
>>>>> renaming when there's only new SoCs (from NXP in this case) to be added.
>>>>
>>>> If I understand correctly, i.MX is a family from Freescale so the name
>>>
>>> It's the same "family" as your platform, because as you said:
>>> "introduced these SoCs which utilise this platform"
>>>
>>>> was kept the same on new SoC releases from NXP. I believe it's different
>>>> in this case here. There's no family name. The closest thing on the name
>>>> of the SoC model is, it's RT for Ralink, MT for MediaTek.
>>>
>>> It's not about the name. NXP took Freescale platform and since many
>>> years makes entirely new products, currently far, far away from original
>>> platform.
>>>
>>> That's the same case you have here - Mediatek took existing platform and
>>> started making new products with it.
>>>
>>>>
>>>> On top of that, mediatek strings already exist for MT SoCs already, at
>>>> least for MT7621.
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/Documentation/devicetree/bindings/mips/ralink.yaml?id=dd3cb467ebb5659d6552999d6f16a616653f9933#n83
>>>
>>> NXP also has compatibles with nxp, thus still not that good reason.
>>
>> Ok, makes sense. Am I free to call the SoCs MediaTek, change the schema
>> name from ralink,mtXXXX-pinctrl.yaml to mediatek,mtXXXX-pinctrl.yaml
>> whilst keeping the compatible string ralink?
>>
>> I plan to do some cleanup on ralink.yaml as well. From what I
>> understand, I should change the mediatek,mt7621-soc compatible string to
>> ralink,mt7621-soc?
> 
> You have to take care of these SoC strings since they are used in the
> very beginning of the ralink startup platforms for any single ralink
> SoC. See for example [0] and [1] (but they are in all soc init code).
> I think it is better to maintain the ralink.yaml file as it is.

I'd really rather address this inconsistency everywhere possible. The 
code you pointed out looks different than what I did on the pinctrl 
driver but, surely it's possible on the code to introduce ralink and 
keep the mediatek string for the sake of old DTs, no?

Arınç
