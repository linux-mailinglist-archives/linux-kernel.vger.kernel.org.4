Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3412071F6EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjFAX5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFAX5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:57:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BCA136;
        Thu,  1 Jun 2023 16:57:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0A6864B02;
        Thu,  1 Jun 2023 23:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE49FC433EF;
        Thu,  1 Jun 2023 23:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685663859;
        bh=NkkzfKpwW/saf1KcEfWJB55yAVfjvnM8hrbEMy081KY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DoNOCSDA9/nA+8zVLQZuV0+47vz27fi9pY+F4kR5iYfADTdGEl5ipeEYx7pxLU54v
         bJ+FFLhZH9Poc7QKyXDTWYJV/Xh4+TpYCoy+tHKk3+KCS6F9SF/uOAeLEsd1gZ9Elw
         fJWCwrRlJ3r7MIUuMygyfB4m7vw00zD/eLAAYtmWhNg80AbZsqCMASlNV2m6jQOIfO
         E/sS+XQZAjSVHonoE8iLiPo7MUwqCt26NUshMCScUncqSyzXsVKAO3YZ62J/SwW3su
         qIOSch2vXeez84KAZjChYTQPGeRZQm/lz8/PeIWyY0vquc4SWYM+me53YyxRe1C8sX
         h3uRH9O32bqvw==
Message-ID: <fe8bfbfc-0ce5-d4ea-a2a8-8608fe4e2f97@kernel.org>
Date:   Fri, 2 Jun 2023 08:57:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 25/43] dt-bindings: ata: Add Cirrus EP93xx
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-7-nikita.shubin@maquefel.me>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230601054549.10843-7-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 14:45, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC PATA.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     v0 -> v1:
>     
>     - renamed file to ep9312-pata

Looks OK to me but given that this is both for the cirrus,ep9315-pata and
cirrus,ep9312-pata, wouldn't it be better to name the file
cirrus,ep931x-pata.yaml ?


>     - changed email to dlemoal@kernel.org
>     - dropped label
>     - fixed ident
> 
>  .../bindings/ata/cirrus,ep9312-pata.yaml      | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml b/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
> new file mode 100644
> index 000000000000..3489be55a6fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/cirrus,ep9312-pata.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP9312 PATA controller
> +
> +maintainers:
> +  - Damien Le Moal <dlemoal@kernel.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9312-pata

I am not a DT specialist, but isn't this line superfluous since it is listed in
the items ?

> +      - items:
> +          - const: cirrus,ep9315-pata
> +          - const: cirrus,ep9312-pata
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ide@800a0000 {
> +      compatible = "cirrus,ep9312-pata";
> +      reg = <0x800a0000 0x38>;
> +      interrupt-parent = <&vic1>;
> +      interrupts = <8>;
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&ide_default_pins>;
> +    };
> +
> +...

-- 
Damien Le Moal
Western Digital Research

