Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1646B13B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCHVUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCHVUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:20:10 -0500
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B526911E5;
        Wed,  8 Mar 2023 13:20:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678310382; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=gA+tGT++N3Im9cwUp1oLMLklYhP64B4CvyN+Ho36QWnmJwux0JwHPkXMW3gPGuo3WbZn5QwE/oskEtSmCZNZzKwXjN0f7re10kXJQCjo9sfyUAnM/xjLhxqGmI4lIBd+MS2NMBK0LdbtEUXBAZ88EEAZeJVhx2v38mDRg08naio=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1678310382; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=oG/xR11RXYcadeo3pBvUPl91gDhrpsPP8G0zdddstRE=; 
        b=bhYZie34pW2RsNiv1EivBl2jBBTfYP2RdAslIDo6O0UTh9zJNMm9o3QuvJlyAUDeXyr2tVTc1QZ1bHKzdan9TUy2SI35FDeEyIApAoKDHi8zON5mRTTmvULUVLNRHzTXrLVJc4N3IiEcKKt+OHMkD6RYkP8+dHMdDarBk/T029U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1678310382;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=oG/xR11RXYcadeo3pBvUPl91gDhrpsPP8G0zdddstRE=;
        b=PQmhFAipPOfOIgKXj/1dppIC0wu7tKa9jYuhbdJKnG0WArbdFqT9ScjdfoRaQ5p0
        +hNJ/JcyccviGoKPZoqA72IBWQjV9O4QurmxoSZPmKg7VzFQMyT3bQExCzYD4u/iHLg
        Btrtwzil+kR8/+0ufvSkafoL07SJUDcq50mYK3ew=
Received: from [10.10.10.3] (212.68.60.226 [212.68.60.226]) by mx.zohomail.com
        with SMTPS id 1678310378501868.040720355281; Wed, 8 Mar 2023 13:19:38 -0800 (PST)
Message-ID: <1c704ea4-2241-ef21-dc6c-d2d243d3bbad@arinc9.com>
Date:   Thu, 9 Mar 2023 00:19:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 08/20] dt-bindings: pinctrl: ralink: add new compatible
 strings
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
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
 <20230303002850.51858-9-arinc.unal@arinc9.com>
 <20230308210017.GA3744272-robh@kernel.org>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230308210017.GA3744272-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.03.2023 00:00, Rob Herring wrote:
> On Fri, Mar 03, 2023 at 03:28:37AM +0300, arinc9.unal@gmail.com wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Add the new mediatek compatible strings. Change the compatible string on
>> the examples with the mediatek compatible strings.
>>
>> Add the new compatible strings for mt7620, mt76x8, and rt305x to be able to
>> properly document the pin muxing information of each SoC, or SoCs that use
>> the same pinmux data.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 7 +++++--
>>   .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 6 ++++--
>>   .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 5 ++++-
>>   3 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>> index cde6de77e228..a94d2e7a5f37 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>> @@ -17,7 +17,10 @@ description:
>>   
>>   properties:
>>     compatible:
>> -    const: ralink,mt7620-pinctrl
>> +    enum:
>> +      - mediatek,mt7620-pinctrl
>> +      - mediatek,mt76x8-pinctrl
>> +      - ralink,mt7620-pinctrl
> 
> To repeat the options from last time:
> 
>> Carrying both strings is a NAK. Either you (and everyone using
>> these platforms) care about the ABI and are stuck with the "wrong"
>> string. In the end, they are just unique identifiers. Or you don't care
>> and break the ABI and rename everything. If you do that, do just that
>> in your patches and make it crystal clear in the commit msg that is
>> your intention and why that is okay.
> 
> Marketing/acquistion renames was just an example and common reason. That
> doesn't make other reasons okay. I don't see any reason given here.

I did give the reason on patch 2 and 9 but I should've put it on this 
patch as well.

> This platform from Ralink was acquired by MediaTek in 2011. Then, MediaTek
> introduced these SoCs which utilise this platform. Add new compatible
> strings to address the incorrect naming.

I'm continuing the conversation regarding this under patch 9.

> 
> If you want to break the ABI (do you??, because the commit message
> still doesn't say), then you don't need "ralink,mt7620-pinctrl".

I don't want to break the ABI. But I deprecate ralink,mt7620-pinctrl on 
later patches. The driver still has it though, so old DTs will keep 
working. That keeps the ABI intact regardless of deprecating strings on 
the dt-binding schema, right?

Arınç
