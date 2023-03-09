Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573256B2F35
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCIVEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCIVEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:04:01 -0500
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99955F6C68;
        Thu,  9 Mar 2023 13:03:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678395811; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=iUtNpgy7wTPxrPi44CtDxe9pL384jteIpM1fm+A98ORXPdq+UaPSKDykCx3EQXEGSz+L4bKr8DXtXfEKsHJdqX0+hajKIQiSd0GheN/cMnR5Khx/lFV8Br5ijZUQ+7nVWL3yY+H0h1CX6slim3gKSUBejO+tGW/qy0YshEA8Oxc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1678395811; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=pKW6CVfdiVcKOlVrCdWthABuRy5PpI7KcCv16cmfRas=; 
        b=icpvHqeFQc83D9F+ipYP+chSTw4pPC2vXawJQ2lH/mKR7UwprFpwG6h9KVY+KZXrwAKGuXvt9Rn+Mw2p4JuhOsRRem0cMRuDudhwpUubipLQS1SsCBh32fSmeMBzEIrC4/aQvtrrQuH4kxYCWxQQH0rd4qfMtYnjdS64aU7yews=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1678395811;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=pKW6CVfdiVcKOlVrCdWthABuRy5PpI7KcCv16cmfRas=;
        b=fngNA3Q/fEZCSjXlSDhe+7kagjEII/8DPv7AJTBWY1Vqx1TmEp5/rYJEHb+xgKYx
        2nRPYvJlRro7O4D2Ep1m5ICFA5LmXRZac9NN+GeTQ0r7YFxzyDZFvOSsrYWnfVvko/p
        Am/dfZq20vEyLyy3LH5G5R7lYO0vh2E6Gcv1WowE=
Received: from [10.10.10.3] (212.68.60.226 [212.68.60.226]) by mx.zohomail.com
        with SMTPS id 1678395808981366.07781513789814; Thu, 9 Mar 2023 13:03:28 -0800 (PST)
Message-ID: <a53a4792-c9e5-fce9-ac37-cc0a64447813@arinc9.com>
Date:   Fri, 10 Mar 2023 00:03:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 19/20] dt-bindings: pinctrl: mediatek: mt7620: split
 binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
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
 <20230303002850.51858-20-arinc.unal@arinc9.com>
 <61539204-afbf-f504-dfe7-237824dc0d6c@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <61539204-afbf-f504-dfe7-237824dc0d6c@linaro.org>
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

On 9.03.2023 12:54, Krzysztof Kozlowski wrote:
> On 03/03/2023 01:28, arinc9.unal@gmail.com wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> The MT7628 and MT7688 SoCs contain different pin muxing information,
>> therefore, should be split. This can be done now that there are compatible
>> strings to distinguish them from other SoCs.
>>
>> Split the schema out to mediatek,mt76x8-pinctrl.yaml.
>>
>> Remove mediatek,mt76x8-pinctrl from mt7620.
>>
>> Deprecate ralink,mt7620-pinctrl. The reason is, the DTs for mt76x8 which
>> use this string will incorrectly match the pin muxing information for
>> mt7620. There's a new string, mediatek,mt7620-pinctrl, which makes the
>> deprecation possible.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   .../pinctrl/mediatek,mt7620-pinctrl.yaml      | 380 +--------------
>>   .../pinctrl/mediatek,mt76x8-pinctrl.yaml      | 450 ++++++++++++++++++
>>   2 files changed, 459 insertions(+), 371 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
>> index 11530b29d52b..38b71c74b9a0 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
>> @@ -11,16 +11,13 @@ maintainers:
>>     - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>   
>>   description: |
>> -  MediaTek MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
>> +  MediaTek MT7620 pin controller for MT7620 SoC.
>>     The pin controller can only set the muxing of pin groups. Muxing individual
>>     pins is not supported. There is no pinconf support.
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -      - mediatek,mt7620-pinctrl
>> -      - mediatek,mt76x8-pinctrl
>> -      - ralink,mt7620-pinctrl
> 
> I see removal, not deprecation.

I thought deprecation meant removing a string with explanation on the 
patch log, as I remember from my conversation with you and Rob on this 
patch series.

https://lore.kernel.org/linux-devicetree/87c9bf7e-f290-7d38-0844-7a7243688f5a@arinc9.com/

I won't have to deprecate this now that we straightened things out but 
I'd like to know the proper way to deprecate compatible strings regardless.

Arınç
