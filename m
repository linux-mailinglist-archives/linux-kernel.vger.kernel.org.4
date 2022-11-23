Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65219636B57
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiKWUjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbiKWUho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:37:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FA16452;
        Wed, 23 Nov 2022 12:37:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D136C61F00;
        Wed, 23 Nov 2022 20:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C39C433D6;
        Wed, 23 Nov 2022 20:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669235819;
        bh=mKmCackjRxhwKbYhMXGB3HGYXAK9Dag9f+46iYyPlhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t5Ujwg9jPP03HaIjcF0zfSj2aZLiMfDMGiCj9Kvzu6fDP5+d3LMM86eakFay000+X
         xn+HDK1hOmgc+9b8J4iYfKqJrKcmx7A+S3zgxoTb/qXWxw8n3R44RRhlkT9QGuadBl
         np9ONO/YeRu/5W1rOwl+XyXKtA0mlrKAhTzaaCJ8KxSuTKLhfxJmqU2RXTdSFbr+wA
         rRGzVuHWWSNiik3eFFHsk51n1ZJQvMOO+eq2Ok/W7s8fXeus3KiJyE6tBUNINp900d
         tNa2MrosMcNMzUccTzHD/dm4Txw88WWbLQzeP0A1y+Gq1HX7y+gDJqKEvxH9NnikNB
         AhiN6aVEtXZ3w==
Date:   Wed, 23 Nov 2022 20:49:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] AD74115
Message-ID: <20221123204931.18098131@jic23-huawei>
In-Reply-To: <20221117080916.411766-1-cosmin.tanislav@analog.com>
References: <20221117080916.411766-1-cosmin.tanislav@analog.com>
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

On Thu, 17 Nov 2022 10:09:14 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

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
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> V2 -> V3:
>  * dt-bindings: remove address and size cells specifiers
>  * dt-bindings: additionalProperties -> unevaluatedProperties
>  * dt-bindings: remove pipe where not needed
>  * dt-bindings: use required for adi,digital-input-sink-range-high: true
>  * do not uselessly store poll time
>  * fix ad74115_adc_gain capitalization
>  * inline ad74115_channels_map[st->ch_func] access
>  * keep consistent table naming
>  * remove aldo1v8 regulator
>  * spell out low-power
>  * split up resistance offset and scale into separate function
>  * use adc_rdy name for irq
>  * use microvolt for conv2 range
>  * use unsigned int for ad74115_adc_conv_mul
>  * use unsigned int for ad74115_adc_gain
>  * wrap module_driver call less
> 
> V1 -> V2:
>  * dt-bindings: add spi peripheral allOf
>  * dt-bindings: remove cs-gpios
>  * dt-bindings: remove refin supply from example
>  * dt-bindings: remove status
>  * sort includes
>  * ad74115_parse_fw_prop -> ad74115_apply_fw_prop
>  * ad74115_setup_{comp,}_gc -> ad74115_setup_{comp,}_gpio_chip
>  * gpiod_get_optional -> devm_gpiod_get_optional
>  * add support for reset-gpios
>  * add support for running without an interrupt
>  * fix comma after terminating member
>  * fix order of rate and range masks
>  * fix reset pin wait time and out of reset time
>  * fix rtd mode reading
>  * pass chan spec only where needed
>  * remove -en suffix
>  * remove default 0 values
>  * remove diag support
>  * remove unecessary prop storage
>  * reorder switch cases to match enum
>  * set burnout enable bit based on burnout current
>  * set default value for props
>  * simplify dac hart slew usage
>  * simplify prop value validation
>  * use bool for 4 wire rtd mode
>  * use bool for burnout current polarity
>  * use bool for dac sc current limit
>  * use bool for debounce mode
>  * use bool for din sink range
>  * use bool for din threshold mode
>  * use devm_regulator_bulk_get_enable
>  * use IIO_VAL_FRACTIONAL for resistance offset
>  * use struct assignment for gpiochip
>  * warn on empty prop mask
> 
> Cosmin Tanislav (2):
>   dt-bindings: iio: addac: add AD74115
>   iio: addac: add AD74115 driver
> 
>  .../bindings/iio/addac/adi,ad74115.yaml       |  373 ++++
>  MAINTAINERS                                   |    8 +
>  drivers/iio/addac/Kconfig                     |   14 +
>  drivers/iio/addac/Makefile                    |    1 +
>  drivers/iio/addac/ad74115.c                   | 1947 +++++++++++++++++
>  5 files changed, 2343 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
>  create mode 100644 drivers/iio/addac/ad74115.c
> 

