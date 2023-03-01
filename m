Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285BC6A68A6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCAIPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCAIPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:15:34 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE4B9004;
        Wed,  1 Mar 2023 00:15:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677658508; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=K5rqZm5I60Bmtew0uSXmf2QdNGCVWX1lhlyhU8380uu1m8/CKfubPcGBbvh+osbNYNcC8tVs+Gu/OEFciXuZ/aHuCMPN+sErbg5KHGqP3hZRlRxjVxlsNwtv05WtyOEguVdlpg6HDQ71mLqPNZCVkPKxc1FAmozR0Dr3HFCNlCE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1677658508; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=loHyMMxyuLpIik8Ed+HNPAQgCqKfx0atv75vwMAnXyg=; 
        b=OXSalVxFM3c/JcYzZ8n5+DZDYdhPgKo5DQwJCUwV68BmQCtPp2qW3Jjlb/CLBKuzowWC5ENWp2S6F/ak/lK2AIe4GKhoMrr5tmZa1fcKlIvyQMaIuK4/rf7kXK346372ns5r13TmnH0L57WyuxJOXb8jKh3rO87z3wUlOtiC6ZU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1677658508;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=loHyMMxyuLpIik8Ed+HNPAQgCqKfx0atv75vwMAnXyg=;
        b=LIMMHzZ2dE9bY9Yig8KeA77aDkINNP4M/XYzhvWOkj633Ejy+RkLTNNwykzdX8QC
        RDgVO0t6wr/HuR12ifAUHKOgCydy3pU5pxQdfHa2gyTtRKKsgLtqHVpHbwg3Bd/UftA
        SgurdupqykIt/825g7WuaO2XwA9ICT+eSCEjA3i0=
Received: from [10.10.10.3] (212.68.60.226 [212.68.60.226]) by mx.zohomail.com
        with SMTPS id 1677658506523162.75111868803015; Wed, 1 Mar 2023 00:15:06 -0800 (PST)
Message-ID: <ae3346de-140f-f181-b6a3-ccaa694e1548@arinc9.com>
Date:   Wed, 1 Mar 2023 11:15:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 07/16] dt-bindings: pinctrl: ralink: add new
 compatible strings
To:     Rob Herring <robh@kernel.org>
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
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230301024431.GA251215-robh@kernel.org>
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

On 1.03.2023 05:44, Rob Herring wrote:
> On Tue, Feb 28, 2023 at 07:46:36PM +0300, Arınç ÜNAL wrote:
>> On 27/02/2023 20:33, Rob Herring wrote:
>>> On Wed, Feb 22, 2023 at 09:39:23PM +0300, arinc9.unal@gmail.com wrote:
>>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>>
>>>> Add the ralink,rt2880-pinmux compatible string. It had been removed from
>>>> the driver which broke the ABI.
>>>>
>>>> Add the mediatek compatible strings. Change the compatible string on the
>>>> examples with the mediatek compatible strings.
>>>>
>>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>> ---
>>>>    .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 7 +++++--
>>>>    .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 7 +++++--
>>>>    .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml | 7 +++++--
>>>>    .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 7 +++++--
>>>>    .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml | 7 +++++--
>>>>    5 files changed, 25 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>>>> index 1e63ea34146a..531b5f616c3d 100644
>>>> --- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>>>> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>>>> @@ -17,7 +17,10 @@ description:
>>>>    properties:
>>>>      compatible:
>>>> -    const: ralink,mt7620-pinctrl
>>>> +    enum:
>>>> +      - mediatek,mt7620-pinctrl
>>>> +      - ralink,mt7620-pinctrl
>>>
>>> We don't update compatible strings based on acquistions nor marketing
>>> whims. If you want to use 'mediatek' for new things, then fine.
>>
>> Understood. Only the SoCs with rtXXXX were rebranded, the mtXXXX SoCs share
>> the same architecture from Ralink, so they were incorrectly called Ralink
>> SoCs.
>>
>> I can remove the new strings from Ralink SoCs and add them only for MediaTek
>> SoCs. Or you could make an exception for this one, regarding the situation.
>> Whatever you think is best.
> 
> I'm not in a position to make an exception as I know little about this
> platform. Carrying both strings is a NAK. Either you (and everyone using
> these platforms) care about the ABI and are stuck with the "wrong"
> string. In the end, they are just unique identifiers. Or you don't care
> and break the ABI and rename everything. If you do that, do just that in
> your patches and make it crystal clear in the commit msg that is your
> intention and why that is okay.

Ralink had their MIPS SoCs pre-acquisition, RT2880, etc. MediaTek 
introduced new SoCs post-acquisition, MT7620, MT7621, MT7628, and 
MT7688, utilising the same platform from Ralink, sharing the same 
architecture code, pinctrl core driver, etc.

I don't intend to break the ABI at all. On the contrary, I fix it where 
possible.

If I understand correctly, from this conversation and what Krzysztof 
said, all strings must be kept on the schemas so I can do what I said on 
the composed mail. Only match the pin muxing information on the strings 
that won't match multiple pin muxing information from other schemas.

This way we don't break the ABI, introduce new compatible strings while 
keeping the remaining ones, and make schemas match correctly.

Let me know if this is acceptable to you.

Arınç
