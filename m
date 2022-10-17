Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EF760159B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJQRoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiJQRoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7BC73913;
        Mon, 17 Oct 2022 10:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCD42611EC;
        Mon, 17 Oct 2022 17:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E83FC433D7;
        Mon, 17 Oct 2022 17:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666028634;
        bh=mlm9IawCUv6HCW+CtDSEE4DUxF4ycNCkp5t/60ov5ks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rH6gqJ7gGnfHcA9f4RJyFi6GUm6w35nBRIbgq6Z59k3kPJWB/wacn25YApmKmSAtM
         8i1NMsjU2TifnnkwPZ00/lt4UVfn4mDfFt+mlSKZN5iiXKlIx5OhkCuXBP0H/uB75s
         W/q83Cet8180jYfhiH1dDdmNfwE/LIKOb+du7H/Eq/4iXl3STcK75Xk2b0H1qVGGqv
         fW6tgFvKZeegeEbQcHwGxIyTFVKn2B3pQt7eVAT4Mh0qgdLtJErV5+d9CKvqU3oBLc
         oxxfS2VreNkzuzAH9/78EuYXOO040WwQ+YkHULYILrt3mDbCF8d5y6e9hDCCAFMDtk
         aYOfiOnxnCwoQ==
Date:   Mon, 17 Oct 2022 18:44:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, lee.jones@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        michael@walle.cc, samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/13] Add support for AXP192 PMIC
Message-ID: <20221017184419.62d365c1@jic23-huawei>
In-Reply-To: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 00:43:22 +0100
Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:

> This series adds support for the AXP192 PMIC to the AXP20x MFD driver
> framework, including support for regulators, ADCs, and AC/USB/battery
> power supplies.
> 
> v6 is a resend of v5 from July -- the patches haven't changed at all
> but I've rebased them on the latest git master branch.

Hi Aidan,

Lee has recently expressed that he keen to take as much of these sorts
of series as possible via the various subsystem trees.

As such, it is useful to call out in the cover letter of such a series
if this can be done.  For example, patch 9 (last IIO one) can't be
applied without defines in patch 6 (I think).  Thus I'm assuming Lee
will do an immutable branch with at least those patches on it.

Perhaps worth expressing if that is also the case for the power
and regulator subsystem patches?

Thanks,

Jonathan


> 
> Aidan MacDonald (13):
>   dt-bindings: mfd: add bindings for AXP192 MFD device
>   dt-bindings: iio: adc: axp209: Add AXP192 compatible
>   dt-bindings: power: supply: axp20x: Add AXP192 compatible
>   dt-bindings: power: axp20x-battery: Add AXP192 compatible
>   mfd: axp20x: Add support for AXP192
>   regulator: axp20x: Add support for AXP192
>   iio: adc: axp20x_adc: Minor code cleanups
>   iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field
>   iio: adc: axp20x_adc: Add support for AXP192
>   power: supply: axp20x_usb_power: Add support for AXP192
>   power: axp20x_battery: Add constant charge current table
>   power: axp20x_battery: Support battery status without fuel gauge
>   power: axp20x_battery: Add support for AXP192
> 
>  .../bindings/iio/adc/x-powers,axp209-adc.yaml |  18 +
>  .../bindings/mfd/x-powers,axp152.yaml         |   1 +
>  .../x-powers,axp20x-battery-power-supply.yaml |   1 +
>  .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
>  drivers/iio/adc/axp20x_adc.c                  | 356 ++++++++++++++++--
>  drivers/mfd/axp20x-i2c.c                      |   2 +
>  drivers/mfd/axp20x.c                          | 141 +++++++
>  drivers/power/supply/axp20x_battery.c         | 142 ++++++-
>  drivers/power/supply/axp20x_usb_power.c       |  84 ++++-
>  drivers/regulator/axp20x-regulator.c          | 100 ++++-
>  include/linux/mfd/axp20x.h                    |  84 +++++
>  11 files changed, 856 insertions(+), 74 deletions(-)
> 

