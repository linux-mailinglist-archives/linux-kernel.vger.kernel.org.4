Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D00B6A5FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjB1TjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjB1TjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:39:08 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52816E07E;
        Tue, 28 Feb 2023 11:39:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677613120; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=DpT+gRuwrLFDk00RqUfjVwCAMB/11Ketj+JESr/nV1NFh4LfEkFBbEmGYsPKY/xlGto2yut0lrgtsl7kmyBQ9XyoUDEBt1PYIWU9gQ3DnMntVyKUFZqkm8iUJy6DzaQDA//HUoFm8hMnBds/PmASI/kT/HzDSIl1q5OTjZlOwjQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1677613120; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=3hZ6CjNhNIOj/IjOMe96xCA1ghRTECewvq7BT6s3O4g=; 
        b=SY0qtzVVmxDUO9KevhVUI0QCbnJvTxZUSGSgmmer/O2ZnPhexYroVCnub9eU046kvA17PTCPDfmJNIYaXQRvV84jAcT1V/dJz9AmXcqSQJeUEoSJOKA+EHHBL2Us4aqoHdnhbdHaA1ssc3O7CKCgLYQtkVkuNR3jVeVWqnOh40U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1677613120;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=3hZ6CjNhNIOj/IjOMe96xCA1ghRTECewvq7BT6s3O4g=;
        b=jdcI3frdQiUJVdFMnKQkI8SdPruzNY+hH+tIKmnzbmrcZMYGLaR5lrU1vZgkV0C/
        XflsHemtoceDNSesmalveqzhRz9QkRga+hncsyw21Z5rNGjFP0QHBqbG1tG1gY8rf2k
        NLBmbiSjrkQqjruaPcjRcMSbH9RAR9vqjRY/Tlkc=
Received: from [10.10.10.3] (212.68.60.226 [212.68.60.226]) by mx.zohomail.com
        with SMTPS id 1677613117772825.1759194711672; Tue, 28 Feb 2023 11:38:37 -0800 (PST)
Message-ID: <d91e8959-3a94-2d66-f228-2eb401a75187@arinc9.com>
Date:   Tue, 28 Feb 2023 22:38:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 10/16] dt-bindings: pinctrl: mediatek: mt7620: split
 binding
Content-Language: en-US
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
 <20230222183932.33267-11-arinc.unal@arinc9.com>
 <20230227182155.GA550689-robh@kernel.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230227182155.GA550689-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 21:21, Rob Herring wrote:
> On Wed, Feb 22, 2023 at 09:39:26PM +0300, arinc9.unal@gmail.com wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> The MT7628 and MT7688 SoCs contain different pin muxing information,
>> therefore, should be split. This can be done now that there are compatible
>> strings to distinguish them from other SoCs.
>>
>> Split the schema out to mediatek,mt76x8-pinctrl.yaml.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   .../pinctrl/mediatek,mt7620-pinctrl.yaml      | 375 +--------------
>>   .../pinctrl/mediatek,mt76x8-pinctrl.yaml      | 454 ++++++++++++++++++
>>   2 files changed, 462 insertions(+), 367 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
>> index 3bf58da8a394..ea4a1194fbc4 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
>> @@ -11,7 +11,7 @@ maintainers:
>>     - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>   
>>   description:
>> -  MediaTek MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
>> +  MediaTek MT7620 pin controller for MT7620 SoC.
>>     The pin controller can only set the muxing of pin groups. Muxing individual
>>     pins is not supported. There is no pinconf support.
>>   
>> @@ -35,19 +35,10 @@ patternProperties:
>>             function:
>>               description:
>>                 A string containing the name of the function to mux to the group.
>> -            anyOf:
>> -              - description: For MT7620 SoC
>> -                enum: [ephy, gpio, gpio i2s, gpio uartf, i2c, i2s uartf, mdio, nand, pa,
>> -                       pcie refclk, pcie rst, pcm gpio, pcm i2s, pcm uartf, refclk,
>> -                       rgmii1, rgmii2, sd, spi, spi refclk, uartf, uartlite, wdt refclk,
>> -                       wdt rst, wled]
>> -
>> -              - description: For MT7628 and MT7688 SoCs
>> -                enum: [antenna, debug, gpio, i2c, i2s, jtag, p0led_an, p0led_kn,
>> -                       p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an, p3led_kn,
>> -                       p4led_an, p4led_kn, pcie, pcm, perst, pwm, pwm0, pwm1, pwm_uart2,
>> -                       refclk, rsvd, sdxc, sdxc d5 d4, sdxc d6, sdxc d7, spi, spi cs1,
>> -                       spis, sw_r, uart0, uart1, uart2, utif, wdt, wled_an, wled_kn, -]
>> +            enum: [ephy, gpio, gpio i2s, gpio uartf, i2c, i2s uartf, mdio, nand,
>> +                   pa, pcie refclk, pcie rst, pcm gpio, pcm i2s, pcm uartf,
>> +                   refclk, rgmii1, rgmii2, sd, spi, spi refclk, uartf, uartlite,
>> +                   wdt refclk, wdt rst, wled]
>>   
>>             groups:
>>               description:
>> @@ -59,24 +50,6 @@ patternProperties:
>>             - function
>>   
>>           allOf:
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: antenna
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [i2s]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: debug
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [i2c]
>> -
>>             - if:
>>                 properties:
>>                   function:
>> @@ -93,17 +66,8 @@ patternProperties:
>>               then:
>>                 properties:
>>                   groups:
>> -                  anyOf:
>> -                    - description: For MT7620 SoC
>> -                      enum: [ephy, i2c, mdio, nd_sd, pa, pcie, rgmii1, rgmii2,
>> -                             spi, spi refclk, uartf, uartlite, wdt, wled]
>> -
>> -                    - description: For MT7628 and MT7688 SoCs
>> -                      enum: [gpio, i2c, i2s, p0led_an, p0led_kn, p1led_an,
>> -                             p1led_kn, p2led_an, p2led_kn, p3led_an, p3led_kn,
>> -                             p4led_an, p4led_kn, perst, pwm0, pwm1, refclk,
>> -                             sdmode, spi, spi cs1, spis, uart0, uart1, uart2,
>> -                             wdt, wled_an, wled_kn]
>> +                  enum: [ephy, i2c, mdio, nd_sd, pa, pcie, rgmii1, rgmii2, spi,
>> +                         spi refclk, uartf, uartlite, wdt, wled]
>>   
>>             - if:
>>                 properties:
>> @@ -132,15 +96,6 @@ patternProperties:
>>                   groups:
>>                     enum: [i2c]
>>   
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: i2s
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [i2s]
>> -
>>             - if:
>>                 properties:
>>                   function:
>> @@ -150,17 +105,6 @@ patternProperties:
>>                   groups:
>>                     enum: [uartf]
>>   
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: jtag
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an,
>> -                         p2led_kn, p3led_an, p3led_kn, p4led_an, p4led_kn,
>> -                         sdmode]
>> -
>>             - if:
>>                 properties:
>>                   function:
>> @@ -179,96 +123,6 @@ patternProperties:
>>                   groups:
>>                     enum: [nd_sd]
>>   
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: p0led_an
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [p0led_an]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: p0led_kn
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [p0led_kn]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: p1led_an
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [p1led_an]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: p1led_kn
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [p1led_kn]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: p2led_an
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [p2led_an]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: p2led_kn
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [p2led_kn]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: p3led_an
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [p3led_an]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: p3led_kn
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [p3led_kn]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: p4led_an
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [p4led_an]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: p4led_kn
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [p4led_kn]
>> -
>>             - if:
>>                 properties:
>>                   function:
>> @@ -278,15 +132,6 @@ patternProperties:
>>                   groups:
>>                     enum: [pa]
>>   
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: pcie
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [gpio]
>> -
>>             - if:
>>                 properties:
>>                   function:
>> @@ -305,15 +150,6 @@ patternProperties:
>>                   groups:
>>                     enum: [pcie]
>>   
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: pcm
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [i2s]
>> -
>>             - if:
>>                 properties:
>>                   function:
>> @@ -341,51 +177,6 @@ patternProperties:
>>                   groups:
>>                     enum: [uartf]
>>   
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: perst
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [perst]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: pwm
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [uart1, uart2]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: pwm0
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [pwm0]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: pwm1
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [pwm1]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: pwm_uart2
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [spis]
>> -
>>             - if:
>>                 properties:
>>                   function:
>> @@ -393,12 +184,7 @@ patternProperties:
>>               then:
>>                 properties:
>>                   groups:
>> -                  anyOf:
>> -                    - description: For MT7620 SoC
>> -                      enum: [mdio]
>> -
>> -                    - description: For MT7628 and MT7688 SoCs
>> -                      enum: [gpio, refclk, spi cs1]
>> +                  enum: [mdio]
>>   
>>             - if:
>>                 properties:
>> @@ -418,15 +204,6 @@ patternProperties:
>>                   groups:
>>                     enum: [rgmii2]
>>   
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: rsvd
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [p0led_an, p0led_kn, wled_an, wled_kn]
>> -
>>             - if:
>>                 properties:
>>                   function:
>> @@ -436,42 +213,6 @@ patternProperties:
>>                   groups:
>>                     enum: [nd_sd]
>>   
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: sdxc
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [sdmode]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: sdxc d5 d4
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [uart2]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: sdxc d6
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [pwm1]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: sdxc d7
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [pwm0]
>> -
>>             - if:
>>                 properties:
>>                   function:
>> @@ -481,15 +222,6 @@ patternProperties:
>>                   groups:
>>                     enum: [spi]
>>   
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: spi cs1
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [spi cs1]
>> -
>>             - if:
>>                 properties:
>>                   function:
>> @@ -499,51 +231,6 @@ patternProperties:
>>                   groups:
>>                     enum: [spi refclk]
>>   
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: spis
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [spis]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: sw_r
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [uart1]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: uart0
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [uart0]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: uart1
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [uart1]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: uart2
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [uart2]
>> -
>>             - if:
>>                 properties:
>>                   function:
>> @@ -562,25 +249,6 @@ patternProperties:
>>                   groups:
>>                     enum: [uartlite]
>>   
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: utif
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an,
>> -                         p3led_kn, p4led_an, p4led_kn, pwm0, pwm1, sdmode, spis]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: wdt
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [wdt]
>> -
>>             - if:
>>                 properties:
>>                   function:
>> @@ -608,33 +276,6 @@ patternProperties:
>>                   groups:
>>                     enum: [wled]
>>   
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: wled_an
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [wled_an]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: wled_kn
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [wled_kn]
>> -
>> -          - if:
>> -              properties:
>> -                function:
>> -                  const: "-"
>> -            then:
>> -              properties:
>> -                groups:
>> -                  enum: [i2c, spi cs1, uart0]
>> -
>>           additionalProperties: false
>>   
>>       additionalProperties: false
>> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
>> new file mode 100644
>> index 000000000000..c818c8947866
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
>> @@ -0,0 +1,454 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/mediatek,mt76x8-pinctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek MT76X8 Pin Controller
>> +
>> +maintainers:
>> +  - Arınç ÜNAL <arinc.unal@arinc9.com>
>> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>> +
>> +description:
>> +  MediaTek MT76X8 pin controller for MT7628 and MT7688 SoCs.
>> +  The pin controller can only set the muxing of pin groups. Muxing individual
>> +  pins is not supported. There is no pinconf support.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mediatek,mt76x8-pinctrl
> 
> We generally don't do wildcards in compatible strings. Are these 2 SoCs
> really 'the same'?

They are very similar SoCs which have got the same pin configuration. 
Just like the RT305X SoCs.

> 
>> +      - ralink,mt7620-pinctrl
> 
> Huh? Doesn't this conflict with the mt7620 schema?

It does, this is what I asked to you and Krzysztof on the composed mail 
for the patch series.

> 
>> +      - ralink,rt2880-pinmux
>> +
>> +patternProperties:
>> +  '-pins$':
>> +    type: object
>> +    patternProperties:
>> +      '^(.*-)?pinmux$':
>> +        type: object
>> +        description: node for pinctrl.
>> +        $ref: pinmux-node.yaml#
>> +
>> +        properties:
>> +          function:
>> +            description:
>> +              A string containing the name of the function to mux to the group.
>> +            enum: [antenna, debug, gpio, i2c, i2s, jtag, p0led_an, p0led_kn,
>> +                   p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an, p3led_kn,
>> +                   p4led_an, p4led_kn, pcie, pcm, perst, pwm, pwm0, pwm1,
>> +                   pwm_uart2, refclk, rsvd, sdxc, sdxc d5 d4, sdxc d6, sdxc d7,
>> +                   spi, spi cs1, spis, sw_r, uart0, uart1, uart2, utif, wdt,
>> +                   wled_an, wled_kn, -]
>> +
>> +          groups:
>> +            description:
>> +              An array of strings. Each string contains the name of a group.
>> +            maxItems: 1
>> +
>> +        required:
>> +          - groups
>> +          - function
>> +
>> +        allOf:
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: antenna
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [i2s]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: debug
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [i2c]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: gpio
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [gpio, i2c, i2s, p0led_an, p0led_kn, p1led_an, p1led_kn,
>> +                         p2led_an, p2led_kn, p3led_an, p3led_kn, p4led_an,
>> +                         p4led_kn, perst, pwm0, pwm1, refclk, sdmode, spi,
>> +                         spi cs1, spis, uart0, uart1, uart2, wdt, wled_an,
>> +                         wled_kn]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: i2c
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [i2c]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: i2s
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [i2s]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: jtag
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an,
>> +                         p2led_kn, p3led_an, p3led_kn, p4led_an, p4led_kn,
>> +                         sdmode]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: p0led_an
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [p0led_an]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: p0led_kn
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [p0led_kn]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: p1led_an
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [p1led_an]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: p1led_kn
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [p1led_kn]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: p2led_an
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [p2led_an]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: p2led_kn
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [p2led_kn]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: p3led_an
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [p3led_an]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: p3led_kn
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [p3led_kn]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: p4led_an
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [p4led_an]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: p4led_kn
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [p4led_kn]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: pcie
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [gpio]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: pcm
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [i2s]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: perst
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [perst]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: pwm
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [uart1, uart2]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: pwm0
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [pwm0]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: pwm1
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [pwm1]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: pwm_uart2
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [spis]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: refclk
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [gpio, refclk, spi cs1]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: rsvd
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [p0led_an, p0led_kn, wled_an, wled_kn]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: sdxc
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [sdmode]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: sdxc d5 d4
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [uart2]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: sdxc d6
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [pwm1]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: sdxc d7
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [pwm0]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: spi
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [spi]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: spi cs1
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [spi cs1]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: spis
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [spis]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: sw_r
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [uart1]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: uart0
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [uart0]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: uart1
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [uart1]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: uart2
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [uart2]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: utif
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an,
>> +                         p3led_kn, p4led_an, p4led_kn, pwm0, pwm1, sdmode, spis]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: wdt
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [wdt]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: wled_an
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [wled_an]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: wled_kn
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [wled_kn]
>> +
>> +          - if:
>> +              properties:
>> +                function:
>> +                  const: "-"
>> +            then:
>> +              properties:
>> +                groups:
>> +                  enum: [i2c, spi cs1, uart0]
>> +
> 
>> +        additionalProperties: false
>> +
>> +    additionalProperties: false
> 
> Move these above 'properties'. It's easier to read than after a long
> indented section.
> 
>> +
>> +allOf:
>> +  - $ref: "pinctrl.yaml#"
> 
> Drop quotes.

Will do.

Arınç
