Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07BD61E31C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiKFPqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKFPqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:46:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADF6D2EE;
        Sun,  6 Nov 2022 07:46:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80BC260BFF;
        Sun,  6 Nov 2022 15:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3C0C433C1;
        Sun,  6 Nov 2022 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667749604;
        bh=uD5uha/gAGU0ejpz7W/EQnX5lrbypbUC7aV5rXsGakk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BHUoGGLXtsS59WT1qYEdWFIJ/U6vupy6vaxYYOruTa0Yq8SC75JoWpeHih077sdBh
         LGGXY+J9Rvuc2SoLW7S/PM0nNWoxj6u9dRpr56sTbCX9Y7VjUZ0uTlQ7vpT8GyN9Ch
         adGRSBUWI6d3uRg2hUKwqGQ2eCty0wMr7PDW+5MqVS/uGM5S6l2i7O5g+OgaBTiyRT
         /NE8Y18TuHNcz0eNOIzqxVCfx0PYCrgB1xtw43EXQEWuk8ANfAdIxg4g2UdFqJmXOD
         FaoMpLjXYl1JDIwu4vkxw70+VE9a5PMVaGvF87fHZI92mxBhrQ31Jm9cxnwJSJ8S8t
         1VgZFEoRMsdLw==
Date:   Sun, 6 Nov 2022 15:46:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: addac: add AD74115
Message-ID: <20221106154634.2286faf3@jic23-huawei>
In-Reply-To: <20221103094436.2136698-2-demonsingur@gmail.com>
References: <20221103094436.2136698-1-demonsingur@gmail.com>
        <20221103094436.2136698-2-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu,  3 Nov 2022 11:44:35 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> The AD74115H is a single-channel, software-configurable, input and
> output device for industrial control applications. The AD74115H
> provides a wide range of use cases, integrated on a single chip.
> 
> These use cases include analog output, analog input, digital output,
> digital input, resistance temperature detector (RTD), and thermocouple
> measurement capability. The AD74115H also has an integrated HART modem.
> 
> A serial peripheral interface (SPI) is used to handle all communications
> to the device, including communications with the HART modem. The digital
> input and digital outputs can be accessed via the SPI or the
> general-purpose input and output (GPIO) pins to support higher
> speed data rates.
> 
> The device features a 16-bit, sigma-delta analog-to-digital converter
> (ADC) and a 14-bit digital-to-analog converter (DAC).
> The AD74115H contains a high accuracy 2.5 V on-chip reference that can
> be used as the DAC and ADC reference.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Hi Cosmin,

A few questions inline.  Complex device so I'll doubt we'll ever get this
binding to be as tidy as for simpler devices.  Hence most of the below are
suggestions rather than requirements from me.

Jonathan

> ---
>  .../bindings/iio/addac/adi,ad74115.yaml       | 370 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 377 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> new file mode 100644
> index 000000000000..621f11d5c1f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> @@ -0,0 +1,370 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/addac/adi,ad74115.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD74115H device
> +
> +maintainers:
> +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> +
> +description: |
> +  The AD74115H is a single-channel software configurable input/output
> +  device for industrial control applications. It contains functionality for
> +  analog output, analog input, digital output, digital input, resistance
> +  temperature detector, and thermocouple measurements integrated into a single
> +  chip solution with an SPI interface. The device features a 16-bit ADC and a
> +  14-bit DAC.
> +
> +    https://www.analog.com/en/products/ad74115h.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad74115h
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

I'm not seeing any child nodes, so why do we need these two?

> +
> +  avdd-supply: true
> +  avcc-supply: true
> +  dvcc-supply: true
> +  aldo1v8-supply: true

aldo1v8 is an output pin. "1.8 V Analog LDO Output. Do not use ALDO1V8 externally."
The associated input is avcc.  Given we shouldn't connect anything to the pin,
we don't want it in the binding docs

> +  dovdd-supply: true
> +  refin-supply: true
> +

...

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Conversion range for ADC conversion 2.
> +      0 - 0V to 12V
> +      1 - -12V to +12V
> +      2 - -2.5V to +2.5V
> +      3 - -2.5V to 0V
> +      4 - 0V to 2.5V
> +      5 - 0V to 0.625V
> +      6 - -104mV to +104mV
> +      7 - 0V to 12V

For a lot of similar cases we handle these numerically to give
a human readable dts.  Is there a strong reason not to do so here (in mv)


> +    minimum: 0
> +    maximum: 7
> +    default: 0
> +
> +  adi,sense-agnd-buffer-lp:
lp is a little ambiguous, given we have a habit of using it for low pass
in filters etc. Perhaps worth spelling these out?
     adi,sens-agnd-buffer-low-power etc?

> +    type: boolean
> +    description: |
> +      Whether to enable low-power buffered mode for the AGND sense pin.
> +
> +  adi,lf-buffer-lp:
> +    type: boolean
> +    description: |
> +      Whether to enable low-power buffered mode for the low-side filtered
> +      sense pin.
> +
> +  adi,hf-buffer-lp:
> +    type: boolean
> +    description: |
> +      Whether to enable low-power buffered mode for the high-side filtered
> +      sense pin.
> +
> +  adi,ext2-buffer-lp:
> +    type: boolean
> +    description: Whether to enable low-power buffered mode for the EXT2 pin.
> +
> +  adi,ext1-buffer-lp:
> +    type: boolean
> +    description: Whether to enable low-power buffered mode for the EXT1 pin.

> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpol
> +  - avdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        adi,digital-input-sink-range-high: true
> +    then:
> +      properties:
> +        adi,digital-input-sink-microamp:
> +          maximum: 7400
> +
> +additionalProperties: false

Does this need to be unevalutatedProperties to allow
for the extra ones in spi-periphera-props.yaml?

> +
