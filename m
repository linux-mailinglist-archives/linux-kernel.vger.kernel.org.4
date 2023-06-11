Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3AA72B094
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 09:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjFKHNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 03:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFKHN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 03:13:28 -0400
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4199D1FDE;
        Sun, 11 Jun 2023 00:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686467572; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=eQ5G7E7rZFdJv7z1y0YnNSCD0XXNSR3tt2n44g7L5IvgCzVuwQhRm3BC9MalRzvFg2GpMKoPlXmgMQZ5GY/LZ0cx4F2UqR96HYp6NxEyNkhmGMXswv1GP5Z2dYniKdWEmrIqHVZoABETlQz1SCRRDu01yinliC4h+e4IuMy8q0I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1686467572; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=iLY204uKrvZ3qum7/jEEKmL/Du4g5HxeLNUjW1ufbi0=; 
        b=C7ekqaRH4HzdV9xqca05I2nEXVXk1+Xn0k8BWB1vVV6L60Mmjh5n/abYMt6e0DG9KzbMDh9Ok18s4aaSeYj2q7wCXtHercn59NSwOs0HBb8f4ReWxrmAYzwK3pN7XJxqchiDQgAUwiJuFRHiwOVNGgMjpYSF2x4UbzsluTIIEYU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686467572;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=iLY204uKrvZ3qum7/jEEKmL/Du4g5HxeLNUjW1ufbi0=;
        b=EZaTCxnyQpo3vwWW5QZg2j9+k86P03qUbrGJZ3n+nPcrW/BC8nkNruKLwJ/EjylY
        JykbdXMi3yoKVgFr5YnyneIQYX505UCy5rvuPBufpDPCs9cMm5WrQ/6tznq/3CPQ3xh
        6ZPmS+STIp197DxqLvs+INHWNlaf98WJNjjdqOqI=
Received: from [192.168.99.249] (178-147-169-233.haap.dm.cosmote.net [178.147.169.233]) by mx.zohomail.com
        with SMTPS id 1686467569583987.4480341802586; Sun, 11 Jun 2023 00:12:49 -0700 (PDT)
Message-ID: <b6c7462d-99fc-a8e1-1cc2-d0a1efc7c34d@arinc9.com>
Date:   Sun, 11 Jun 2023 10:12:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: net: mediatek,net: add missing
 mediatek,mt7621-eth
To:     Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Greg Ungerer <gerg@kernel.org>,
        =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
References: <ZIUSZR6I3Ki6mZRO@makrotopia.org>
Content-Language: en-US
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZIUSZR6I3Ki6mZRO@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for working on this.

On 11.06.2023 03:16, Daniel Golle wrote:
> Document the Ethernet controller found in the MediaTek MT7621 MIPS SoC
> family which is supported by the mtk_eth_soc driver.
> 
> Fixes: 889bcbdeee57 ("net: ethernet: mediatek: support MT7621 SoC ethernet hardware")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   .../devicetree/bindings/net/mediatek,net.yaml | 27 ++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> index acb2b2ac4fe1e..38aa3d97ee234 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -19,6 +19,7 @@ properties:
>       enum:
>         - mediatek,mt2701-eth
>         - mediatek,mt7623-eth
> +      - mediatek,mt7621-eth
>         - mediatek,mt7622-eth
>         - mediatek,mt7629-eth
>         - mediatek,mt7981-eth
> @@ -32,7 +33,7 @@ properties:
>     clock-names: true
>   
>     interrupts:
> -    minItems: 3
> +    minItems: 1

I suppose this is to allow a single item for mediatek,mt7621-eth?

>       maxItems: 4
>   
>     power-domains:
> @@ -131,6 +132,30 @@ allOf:
>   
>           mediatek,wed-pcie: false
>   
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt7621-eth
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +
> +        clock-names:
> +          items:
> +            - const: ethif
> +            - const: fe
> +
> +        mediatek,wed: false
> +
> +        mediatek,wed-pcie: false
> +
>     - if:
>         properties:
>           compatible:

I'm getting warnings with this patch applied:

arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dtb: ethernet@1e100000: 
resets: [[2, 6], [2, 23]] is too short
arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dtb: ethernet@1e100000: 
reset-names:1: 'gmac' was expected
arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dtb: ethernet@1e100000: 
reset-names: ['fe', 'eth'] is too short
arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dtb: ethernet@1e100000: 
clock-names:0: 'ethif' was expected
arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dtb: ethernet@1e100000: 
clock-names:1: 'fe' was expected
arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dtb: ethernet@1e100000: 
mac@0: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dtb: ethernet@1e100000: 
mac@0: 'phy-handle' is a required property
arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dtb: ethernet@1e100000: 
mac@1: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dtb: ethernet@1e100000: 
mac@1: 'phy-handle' is a required property
arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dtb: ethernet@1e100000: 
Unevaluated properties are not allowed ('reset-names', 'resets' were 
unexpected)

I see the bindings for the MT7621 SoC are a bit different than the 
bindings for the current SoCs on this schema, interrupts, phy-handle non 
requirement, resets, reset-names, etc. Maybe we should overwrite things 
under the check for mediatek,mt7621-eth.

I'm not very confident all the bindings for mediatek,mt7621-eth on 
mt7621.dtsi are correct either.

Arınç
