Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ADE681A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbjA3TMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbjA3TMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:12:31 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCF638B51;
        Mon, 30 Jan 2023 11:12:17 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id s41-20020a05683043a900b0068bd63d34d0so698993otv.6;
        Mon, 30 Jan 2023 11:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ2Q+GiXTf/jZDy+yWnBz+4LrVIM/HYVwYyT24sePUU=;
        b=qLxb19GSqWvSduWeEhLkwYViSMsUUNEGDq0LU5iPl7b1g9G3GEvYllouNlAi9/8zJU
         Rvr/Tkty72c5TMNcvuSOcOeB7rN5J/Rc/VLBbFVjNTPhHrHOOBDljaoecmWiUqIo+3ha
         geJnns5iuUIjFREhPvu55PQFuOA+q12+cfFu8SlI7kIbw04UUd+Ecnl7BeMXWly1/UKa
         wL9GPBR1PBm8vFK1NQO5nR2AfnJanvDtWuM0l9kgNNwSWg+BbFjdT4uL6JnLf/K2d70z
         ClxLQUAtOacwYERFq0xKwJhVoHEMD2UQ9p6I4lai+pQFTZhzoyfQFrb1shxeFcvIjbSG
         V+0w==
X-Gm-Message-State: AO0yUKU63JSEzzSdv/cwYvQkbRrMAr+IDJZC2MrcMqfsIatovCoVvLYs
        pn5plIvTwBuyKwd5un4nfQ==
X-Google-Smtp-Source: AK7set/q/dB5JJ/S45vienphYuLJxho1PabdZkZ68lbop1g9F9Q7uUGEg6YNlXC0i+odnzx6VJM4AQ==
X-Received: by 2002:a05:6830:440b:b0:68b:dd36:ab17 with SMTP id q11-20020a056830440b00b0068bdd36ab17mr1043458otv.3.1675105936532;
        Mon, 30 Jan 2023 11:12:16 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 44-20020a9d02af000000b00684152e9ff2sm5724188otl.0.2023.01.30.11.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:12:16 -0800 (PST)
Received: (nullmailer pid 3186164 invoked by uid 1000);
        Mon, 30 Jan 2023 19:12:15 -0000
Date:   Mon, 30 Jan 2023 13:12:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Vasut <marex@denx.de>, Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: intel,ixp4xx-expansion-bus: split
 out peripheral properties
Message-ID: <20230130191215.GA3125737-robh@kernel.org>
References: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org>
 <20230127093217.60818-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127093217.60818-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:32:15AM +0100, Krzysztof Kozlowski wrote:
> The properties of devices in IXP4xx expansion bus need to be also
> applied to actual devices' bindings.  Prepare for this by splitting them
> to separate intel,ixp4xx-expansion-peripheral-props binding, just like
> other memory-controller peripheral properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  ...intel,ixp4xx-expansion-bus-controller.yaml | 64 +--------------
>  ...tel,ixp4xx-expansion-peripheral-props.yaml | 80 +++++++++++++++++++

Kind of odd to have these in 2 directories. Can we move 
intel,ixp4xx-expansion-bus-controller.yaml to 
bindings/memory-controllers/?

Or maybe all the external/parallel bus interfaces need their own 
directory?

>  .../mc-peripheral-props.yaml                  |  1 +
>  3 files changed, 82 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/intel,ixp4xx-expansion-bus-controller.yaml b/Documentation/devicetree/bindings/bus/intel,ixp4xx-expansion-bus-controller.yaml
> index 5fb4e7bfa4da..a771796ec499 100644
> --- a/Documentation/devicetree/bindings/bus/intel,ixp4xx-expansion-bus-controller.yaml
> +++ b/Documentation/devicetree/bindings/bus/intel,ixp4xx-expansion-bus-controller.yaml
> @@ -56,69 +56,7 @@ patternProperties:
>      description: Devices attached to chip selects are represented as
>        subnodes.
>      type: object
> -
> -    properties:
> -      intel,ixp4xx-eb-t1:
> -        description: Address timing, extend address phase with n cycles.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        maximum: 3
> -
> -      intel,ixp4xx-eb-t2:
> -        description: Setup chip select timing, extend setup phase with n cycles.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        maximum: 3
> -
> -      intel,ixp4xx-eb-t3:
> -        description: Strobe timing, extend strobe phase with n cycles.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        maximum: 15
> -
> -      intel,ixp4xx-eb-t4:
> -        description: Hold timing, extend hold phase with n cycles.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        maximum: 3
> -
> -      intel,ixp4xx-eb-t5:
> -        description: Recovery timing, extend recovery phase with n cycles.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        maximum: 15
> -
> -      intel,ixp4xx-eb-cycle-type:
> -        description: The type of cycles to use on the expansion bus for this
> -          chip select. 0 = Intel cycles, 1 = Motorola cycles, 2 = HPI cycles.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [0, 1, 2]
> -
> -      intel,ixp4xx-eb-byte-access-on-halfword:
> -        description: Allow byte read access on half word devices.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [0, 1]
> -
> -      intel,ixp4xx-eb-hpi-hrdy-pol-high:
> -        description: Set HPI HRDY polarity to active high when using HPI.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [0, 1]
> -
> -      intel,ixp4xx-eb-mux-address-and-data:
> -        description: Multiplex address and data on the data bus.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [0, 1]
> -
> -      intel,ixp4xx-eb-ahb-split-transfers:
> -        description: Enable AHB split transfers.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [0, 1]
> -
> -      intel,ixp4xx-eb-write-enable:
> -        description: Enable write cycles.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [0, 1]
> -
> -      intel,ixp4xx-eb-byte-access:
> -        description: Expansion bus uses only 8 bits. The default is to use
> -          16 bits.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [0, 1]
> +    $ref: /schemas/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml#
>  
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml b/Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml
> new file mode 100644
> index 000000000000..8f782c80e88b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Peripheral properties for Intel IXP4xx Expansion Bus
> +
> +description: |

Don't need '|'.

> +  The IXP4xx expansion bus controller handles access to devices on the
> +  memory-mapped expansion bus on the Intel IXP4xx family of system on chips,
> +  including IXP42x, IXP43x, IXP45x and IXP46x.
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +properties:
> +  intel,ixp4xx-eb-t1:
> +    description: Address timing, extend address phase with n cycles.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 3
> +
> +  intel,ixp4xx-eb-t2:
> +    description: Setup chip select timing, extend setup phase with n cycles.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 3
> +
> +  intel,ixp4xx-eb-t3:
> +    description: Strobe timing, extend strobe phase with n cycles.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 15
> +
> +  intel,ixp4xx-eb-t4:
> +    description: Hold timing, extend hold phase with n cycles.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 3
> +
> +  intel,ixp4xx-eb-t5:
> +    description: Recovery timing, extend recovery phase with n cycles.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 15
> +
> +  intel,ixp4xx-eb-cycle-type:
> +    description: The type of cycles to use on the expansion bus for this
> +      chip select. 0 = Intel cycles, 1 = Motorola cycles, 2 = HPI cycles.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +
> +  intel,ixp4xx-eb-byte-access-on-halfword:
> +    description: Allow byte read access on half word devices.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  intel,ixp4xx-eb-hpi-hrdy-pol-high:
> +    description: Set HPI HRDY polarity to active high when using HPI.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  intel,ixp4xx-eb-mux-address-and-data:
> +    description: Multiplex address and data on the data bus.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  intel,ixp4xx-eb-ahb-split-transfers:
> +    description: Enable AHB split transfers.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  intel,ixp4xx-eb-write-enable:
> +    description: Enable write cycles.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  intel,ixp4xx-eb-byte-access:
> +    description: Expansion bus uses only 8 bits. The default is to use
> +      16 bits.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mc-peripheral-props.yaml b/Documentation/devicetree/bindings/memory-controllers/mc-peripheral-props.yaml
> index 53ae995462db..5acfcad12bb7 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mc-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mc-peripheral-props.yaml
> @@ -34,5 +34,6 @@ required:
>  # The controller specific properties go here.
>  allOf:
>    - $ref: st,stm32-fmc2-ebi-props.yaml#
> +  - $ref: intel,ixp4xx-expansion-peripheral-props.yaml#
>  
>  additionalProperties: true
> -- 
> 2.34.1
> 
