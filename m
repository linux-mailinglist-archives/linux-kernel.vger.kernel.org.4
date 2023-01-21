Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788296767F4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 19:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjAUSGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 13:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAUSGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 13:06:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACFB8A70;
        Sat, 21 Jan 2023 10:06:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25F0F60B56;
        Sat, 21 Jan 2023 18:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C51C433EF;
        Sat, 21 Jan 2023 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674324398;
        bh=oZHXozGWv+1gqZVIyQioRcrJr2CPFyq+E441uqsbG38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c005qaJtNWB7PhpKNSt4Rm+xnJxPG0utOnAm4mj6r36ekXjkBznklQgCcQWmJF+fF
         zr89Pv2AJGkfjZpQYhCnPt4bcTsrlH9G0RVDYNg/29SCdhCxlAcZkLThCFbaMeRZ2A
         qZRuVrr34N6YYHIlGDnRAqVSDXQAR2HQlSFva+kOJQzDXE6cOWfj4IeY/gKjQ8j32I
         2QytuvBykZjS8/CoDfUnrRsfRYieTPJncH+BMr+9PV5H4asQkB7oN5ldgE6+7XvCY9
         xOUuAHXh+p/yKuuCaNNZxdG9KRbnDeKaQ6b/zJz7oab52GdV28pU7qQnfYkVNGICf3
         dKNDydPGaEMGQ==
Date:   Sat, 21 Jan 2023 18:20:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     hvilleneuve@dimonoff.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: adc: ti-ads7924: add Texas Instruments
 ADS7924 driver
Message-ID: <20230121182023.1f1516d2@jic23-huawei>
In-Reply-To: <20230115170623.3680647-1-hugo@hugovil.com>
References: <20230115170623.3680647-1-hugo@hugovil.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Sun, 15 Jan 2023 12:06:21 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Hello,
> this patch series adds the driver for the Texas Instruments ADS7924.
> 
> The Texas Instruments ADS7924 is a 4 channels, 12-bit analog to
> digital converter (ADC) with an I2C interface.
> 
> Patch 1 contains the driver for the ADS7924.
> 
> Patch 2 add the dt-bindings for the ADS7924.
> 
> I have tested the driver using the Texas Instruments ADS7924EVM board connected
> to a Variscite Symphony EVK with a IMX8MN NANO SOM:
>   - Tested reset pin Ok
>   - Tested regulator setup Ok
>   - Tested reading sysfs in_voltage_scale Ok
>   - Tested reading sysfs in_voltageX_raw (x=0 to 3) Ok
> 
> Thank you.
> 
> Link: [v1] https://lore.kernel.org/linux-iio/20221222203610.2571287-1-hugo@hugovil.com/
> Link: [v2] https://lore.kernel.org/linux-iio/20230110160124.3853593-1-hugo@hugovil.com/
> Link: [v3] https://lore.kernel.org/linux-iio/20230113194959.3276433-1-hugo@hugovil.com/

Series applied to the togreg branch of iio.git and pushed out initially as testing
for 0-day to work it's magic and see if it can find anything we missed!

Thanks,

Jonathan

> 
> Changes for V4:
> - DT bindings: remove label description.
> - Remove blank line between datasheet tag and SOB in commit message.
> - Return value from regulator_get_voltage()
> - Fix num_channels comparison (cannot be < 0)
> - Change severity of message to dev_err in ads7924_set_conv_mode().
> 
> Changes for V3:
> - Rebase on linux-6.2-rc1
> - Refactor to follow usual coding practices as per review comments.
> - Fix missing include (reported by kernel test robot).
> - Fix DT bindings errors.
> - Removed unused define.
> - Remove breaks after return.
> - Remove debug message in ads7924_get_channels_config().
> - Remove braces around swich case IIO_CHAN_INFO_RAW.
> - Remove comments about regulator_get_voltage() failing for dummy regulator.
> 
> Changes for V2:
> - Dropped patch "iio: adc: Kconfig: add SPI interface mention to AD7924
>   description"
> - Fixed comments style
> - Removed unused defines/variables/etc related to buffered support (no buffered
>   support for the moment).
> - Convert of-specific code to use the generic firmware property accessors in
>   include/linux/property.h.
> - Use FIELD_GET / FIELD_PREP for bit operations/defines
> - Simplified conversion result registers definitions/usage.
> - Now using mutex lock/unlock only for INFO_RAW switch branch
> - Use dev_err_probe() in all return paths of ads7924_probe()
> - Removed ads7924_remove() after adding callbacks with
>   devm_add_action_or_reset().
> - Change iio_device_register() to devm_iio_device_register().
> - Add the legacy i2c_device_id table
> - DT bindings: reorder entries, fix indentation,improve comments, add interrupt
>   line
> 
> Hugo Villeneuve (2):
>   iio: adc: ti-ads7924: add Texas Instruments ADS7924 driver
>   dt-bindings: iio: adc: add Texas Instruments ADS7924
> 
>  .../bindings/iio/adc/ti,ads7924.yaml          | 110 ++++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/adc/Kconfig                       |  11 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/ti-ads7924.c                  | 474 ++++++++++++++++++
>  5 files changed, 603 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
>  create mode 100644 drivers/iio/adc/ti-ads7924.c
> 
> 
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2

