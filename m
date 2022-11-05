Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ECC61DA81
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 13:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKEMzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 08:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEMzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 08:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5E427CD2;
        Sat,  5 Nov 2022 05:55:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC8B60B3F;
        Sat,  5 Nov 2022 12:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04260C433C1;
        Sat,  5 Nov 2022 12:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667652916;
        bh=3vT+neZXkQLSyBK55o+F5Gw2VXJGt/NQfSDibrgT40g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jkhHZzXrJxBP20g7sx9Lqo+m9wm6Oted71cz4Mppw7DBk2iRwqrE0+qHmFLiODVHe
         h8x/FK43yqo3gNoZqPM+Vc8P/K5xvtNAl2eyyJf7nDjtFLKTab9bxIQzHBx8DUK/u8
         s63YCHysJBXYjO3pyWm3hmF3TxABJ51mBR/HooJ8rJZxDclbMCjk2gqN/dzBBhO3M6
         LqV/gSMhpoLUJy2ms7xU16grNbL+TcnPkz2DaSHDsYjBL0tYi7FHCPIGuNmMtXEr2N
         sVVNkhDhgbKRS4TWHSI2qqA/RD3Vtr7S18i6b69+GVDV2YGTvP8XncXvElEeIOcvf8
         LmIN+0dzdQYgw==
Date:   Sat, 5 Nov 2022 12:55:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: add adi,ad5754.yaml
Message-ID: <20221105125510.313f2037@jic23-huawei>
In-Reply-To: <20221104172343.617690-2-ciprian.regus@analog.com>
References: <20221104172343.617690-1-ciprian.regus@analog.com>
        <20221104172343.617690-2-ciprian.regus@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 19:23:42 +0200
Ciprian Regus <ciprian.regus@analog.com> wrote:

> Add devicetree bindings documentation for the AD5754 DAC driver.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Hi Ciprian,

To add to Krzysztof's detailed review, a request for a bit more
variation in the example.

> ---
> changes in v2:
>  - dropped "device driver" from the title.
>  - added the vendor prefix to the 'output-range-microvolt' property.
>  - fixed example indentation (4 spaces).
>  .../bindings/iio/dac/adi,ad5754.yaml          | 182 ++++++++++++++++++
>  1 file changed, 182 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
> new file mode 100644
> index 000000000000..4c9c5ba90931
...

> +patternProperties:
> +  "^channel@([0-3])$":
> +    type: object
> +    description: Configurations for the DAC channels
> +
> +    properties:
> +      reg:
> +        description: Channel number
> +        maxItems: 1
> +
> +      adi,output-range-microvolt:
> +        description: |
> +          Voltage range of a channel as <minimum, maximum>.
> +        oneOf:
> +          - items:
> +              - const: 0
> +              - enum: [5000000, 10000000, 10800000]
> +          - items:
> +              - const: -5000000
> +              - const: 5000000
> +          - items:
> +              - const: -10000000
> +              - const: 10000000
> +          - items:
> +              - const: -10800000
> +              - const: 10800000
> +
> +    required:
> +      - reg
> +      - adi,output-range-microvolt
> +
...

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        status = "okay";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@0 {
> +            compatible = "adi,ad5754r";
> +            reg = <0>;
> +            spi-max-frequency = <1000000>;
> +            spi-cpol;
> +
> +            clr-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                adi,output-range-microvolt = <0 5000000>;
> +            };
> +            channel@1 {
> +                reg = <1>;
> +                adi,output-range-microvolt = <0 5000000>;

Nice to have rather than necessary, but maybe the example could
include a few different options from those available for this
property?

> +            };
> +            channel@2 {
> +                reg = <2>;
> +                adi,output-range-microvolt = <0 5000000>;
> +            };
> +            channel@3 {
> +                reg = <3>;
> +                adi,output-range-microvolt = <0 5000000>;
> +            };
> +        };
> +    };

