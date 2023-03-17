Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869546BF2CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjCQUjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCQUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:38:58 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C9F2D6D;
        Fri, 17 Mar 2023 13:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679085506; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Xw/JmgIpXeWcbao/wk4KwQ4Jquj/5Ho6qfNyIdO4Ur9aMayyP5TrN4EJzDccCEWYKoi4giSEwrW8C7YmlUOx5lLKRARF5SvcfAOUPlUqOtzkuvyJxE0ICjHeIj6/XOEN0YueD64oXSDgmxlcsfdP12Ve3Tut9SiH7UwHypfT2tI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679085506; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=WjIwrwxKeq5Ld9Ij9H2Gbwf8PRvgEpDh113K4y969wE=; 
        b=LMni3nsGFnG2FVnh6j6xH22hvSZ6yIBCrpnLHfsA/dr1HxdNGBW3iVIQHTXhOVPzKYUuycLznExUjo8h5UKKTL/SF/44yWFqQpXVvYb5NDnuILezptc2szB91vBW92Xc0Q/ToflYp23Z/AovR6QALoXUAsa/VJTtN1VCOY34Cnc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679085506;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=WjIwrwxKeq5Ld9Ij9H2Gbwf8PRvgEpDh113K4y969wE=;
        b=h2jZZs7IRiH7FdUfBugzOWe/DM0kpKGcr02Mcdb8/PX8HJ9rm3kNyMUqKb9N9t/b
        oYooBgEjewh5KXrq5ufHqBSB8F1msv9f8aEqaMtg8Eu518AB6iU0gnkQrohkv1nRhQp
        8vPyCEZaBehcCPGd5eKq36itLWJWYLFZ757aLLkI=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679085504453905.0224911165027; Fri, 17 Mar 2023 13:38:24 -0700 (PDT)
Message-ID: <022c66f3-75d4-5ab4-4a4d-e8260fd70904@arinc9.com>
Date:   Fri, 17 Mar 2023 23:38:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 20/21] dt-bindings: pinctrl: mediatek: mt7620: split
 binding
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
 <20230313205921.35342-21-arinc.unal@arinc9.com>
 <20230317190331.GA2628708-robh@kernel.org>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230317190331.GA2628708-robh@kernel.org>
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

On 17.03.2023 22:03, Rob Herring wrote:
> On Mon, Mar 13, 2023 at 11:59:20PM +0300, arinc9.unal@gmail.com wrote:
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
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   .../pinctrl/mediatek,mt7620-pinctrl.yaml      | 379 +--------------
>>   .../pinctrl/mediatek,mt76x8-pinctrl.yaml      | 450 ++++++++++++++++++
>>   2 files changed, 459 insertions(+), 370 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
>> index 808dd8bd276f..591bc0664ec6 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
>> @@ -11,15 +11,13 @@ maintainers:
>>     - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>   
>>   description: |
>> -  MediaTek MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
>> +  MediaTek MT7620 pin controller for MT7620 SoC.
> 
> Saying MT7620 twice is redundant. Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

It's not always a one to one relation so I'd rather explicitly point the 
SoC out like on other schemas like MT7621. Thanks for reviewing!

Arınç
