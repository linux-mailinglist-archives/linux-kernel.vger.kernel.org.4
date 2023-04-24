Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88BA6ECCF7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjDXNRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjDXNRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:17:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48E13C35;
        Mon, 24 Apr 2023 06:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30CF1621E2;
        Mon, 24 Apr 2023 13:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3559AC433D2;
        Mon, 24 Apr 2023 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682342199;
        bh=2rlK0Tu+4HejUDU3oS4OqP3yYSq0vZKT4numa2QvaxA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ObL1F7vaNumRrEBxsCfFxqEacUERCfRXpAwD0bOztpy2ZRaZUvAcFkGNrjO9i8wFB
         UCpc79o8xeswM6DgwsiuP8/HpdJLcSzhxZK0u1hndebKUQkd+eU9JkojfZzG6vCFU9
         TTrohRze/oiA/spG3tqj/n6dGrel1VLGIfRK41ewozVEu9f+5s2sLrRS8TUppxqQ9l
         P9YmrgwtM8mXSxmyRi92HSU2Y0QFNKjkIyfzviLwjc2u6kK6z4qdUolTUmpI0x/T5r
         Z0SH2Vl410VGMwLzhVK+xASsXPwUlsF6E1gFeHUhkiu5tqhwtu1GzLRGA7Kenuuo+Q
         HMPAAaY7j8m+A==
Message-ID: <b6fde790-e43e-693c-19bd-101da9f93632@kernel.org>
Date:   Mon, 24 Apr 2023 22:16:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 24/43] dt-bindings: ata: Add DT bindings ep93xx pata
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-25-nikita.shubin@maquefel.me>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230424123522.18302-25-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 21:34, Nikita Shubin wrote:
> Add YAML bindings ep93xx SoC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/ata/cirrus,ep93xx-pata.yaml      | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/cirrus,ep93xx-pata.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/cirrus,ep93xx-pata.yaml b/Documentation/devicetree/bindings/ata/cirrus,ep93xx-pata.yaml
> new file mode 100644
> index 000000000000..24ed64cfa6d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/cirrus,ep93xx-pata.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/cirrus,ep93xx-pata.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: EP9312 PATA controller driver
> +
> +maintainers:
> +  - Damien Le Moal <damien.lemoal@opensource.wdc.com>

Wrong email address. Please use dlemoal@kernel.org as mentioned in the
MAINTAINERS file.

(other schema files need to be changed as well. Will send a patch for that)

> +
> +properties:
> +  compatible:
> +    const: cirrus,ep9312-pata
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
> +    ide: ide@800a0000 {
> +        compatible = "cirrus,ep9312-pata";
> +        reg = <0x800a0000 0x38>;
> +        interrupt-parent = <&vic1>;
> +        interrupts = <8>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&ide_default_pins>;
> +    };
> +
> +...

