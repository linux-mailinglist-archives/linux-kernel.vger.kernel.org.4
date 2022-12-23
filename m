Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072A2655170
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbiLWOhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiLWOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:37:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BD0389D5;
        Fri, 23 Dec 2022 06:37:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EE0BB80315;
        Fri, 23 Dec 2022 14:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EF8C433D2;
        Fri, 23 Dec 2022 14:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671806224;
        bh=18BHFIFkjjGnxunFDMVYe0OdKkXN4Kc7XdEmOv/CuOU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jt8VtmZCkhEPYXXo0C82YuAGPQD/vOFpOEklHi8MzQ0hfQUgmGCbkp24Y1JBZSJtS
         4Rs+fbqFfrmCIEhzYGx4FcyXlg2nr74s4hvbGDM8G/II+S2MZp3FBLmah5pTlYC5Ak
         +qU4zmXNbTR1sntrXeLMvQYj1LWf1EJvAQ5yB0KQ1YcJt/uiw6oWzXdNzmzyIhryaJ
         zgTUE+AC+Um4TUOO7oR7RTSilckmk0RZXDCI1VhceOySW8SsqEhVkR4UymmZ1gvxHM
         40V0Qiw99e9cNyDrAPVUdARLUnEOglwZfpG7blgTpVpEJxDMUE5uhSv5NXueTpM35E
         NSLfGXnu6bgqg==
Date:   Fri, 23 Dec 2022 14:50:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     hvilleneuve@dimonoff.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] dt-bindings: iio: adc: add ADS7924
Message-ID: <20221223145013.68f7344a@jic23-huawei>
In-Reply-To: <20221222203610.2571287-4-hugo@hugovil.com>
References: <20221222203610.2571287-1-hugo@hugovil.com>
        <20221222203610.2571287-4-hugo@hugovil.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2022 15:36:10 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add device tree bindings document for the Texas Instruments ADS7924
> ADC.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hi Hugo,

Whilst you aren't using it yet, the binding should still attempt to be
a full description of the hardware, so I'd expect the interrupt line to
be part of it.

Otherwise, Krzysztof already covered this in detail.

Jonathan


> ---
>  .../bindings/iio/adc/ti,ads7924.yaml          | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> new file mode 100644
> index 000000000000..5408ec95e417
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads7924.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI ADS7924 4 channels 12 bits I2C analog to digital converter
> +
> +maintainers:
> +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> +
> +description: |
> +  Texas Instruments ADS7924 4 channels 12 bits I2C analog to digital converter
> +
> +  Specifications:
> +    https://www.ti.com/lit/gpn/ads7924
> +
> +properties:
> +  compatible:
> +    const: ti,ads7924
> +
> +  vref-supply:
> +    description:
> +      The regulator supply for the ADC reference voltage (AVDD)
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      GPIO used for controlling the reset pin
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^channel@[0-3]+$":
> +    type: object
> +    description:
> +      Child nodes needed for each channel that the platform uses.
> +
> +    properties:
> +      reg:
> +        description: |
> +          0: Voltage over AIN0 and GND.
> +          1: Voltage over AIN1 and GND.
> +          2: Voltage over AIN2 and GND.
> +          3: Voltage over AIN3 and GND.
> +        items:
> +          - minimum: 0
> +            maximum: 3
> +
> +    required:
> +      - reg
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@48 {
> +            compatible = "ti,ads7924";
> +            reg = <0x48>;
> +            vref-supply = <&ads7924_reg>;
> +            reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@0 {
> +              reg = <0>;
> +              label = "CH0";
> +            };
> +            channel@1 {
> +              reg = <1>;
> +              label = "CH1";
> +            };
> +            channel@2 {
> +              reg = <2>;
> +              label = "CH2";
> +            };
> +            channel@3 {
> +              reg = <3>;
> +              label = "CH3";
> +            };
> +        };
> +    };
> +...

