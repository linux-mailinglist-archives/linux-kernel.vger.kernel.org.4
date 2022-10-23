Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8588609284
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 13:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJWLwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 07:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJWLwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 07:52:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D13C6FA0A;
        Sun, 23 Oct 2022 04:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AA57B80D68;
        Sun, 23 Oct 2022 11:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40771C433D6;
        Sun, 23 Oct 2022 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666525950;
        bh=inn4KraSqCVITkxJCtkuzpjQIsQQ0qiwxRNVvyM4O1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VlV0YzDcM242HMSrV/s6yIfaPlfZnivmd2aQzEw5Kz9EeLkp/rVnhsdZuEuGNVJlX
         cqoLLcfWM84Hw5H6qXEl01j48sFO0HRqvFwMDPHTWTP2cO8GlAi8S6H//dIc9H/NzQ
         Jh1fa2sFJDG5Nr9ZG0nPdNQXLAgR7pMHbWV2w+eSoFZC093ImO2J85ALL6W210qDAc
         A9iz8g7sshvjqBOTlEDROO8qshPaBmTJhuAArOFBYffwsHfZTGziya0DmP7LhCYypP
         iriTftqwSl1pd+xPjG56/6kVD/uKpAxYvcosxJzdUGkOJIZUCnQJx7mZZVwuTknwvx
         2zW/2QfolGNUA==
Date:   Sun, 23 Oct 2022 12:53:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v10 2/2] iio: adc: ad4130: add AD4130 driver
Message-ID: <20221023125303.59726e3a@jic23-huawei>
In-Reply-To: <20221021104115.1812486-3-demonsingur@gmail.com>
References: <20221021104115.1812486-1-demonsingur@gmail.com>
        <20221021104115.1812486-3-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 13:41:15 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
>=20
> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
>=20
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


make W=3D1 on x86_64.

  DESCEND objtool
  CALL    scripts/checksyscalls.sh
  CC [M]  drivers/iio/adc/ad4130.o
drivers/iio/adc/ad4130.c:138:79: warning: initialized field overwritten [-W=
override-init]
  138 |         [AD4130_CONFIG_X_REG(0) ... AD4130_CONFIG_X_REG(AD4130_MAX_=
SETUPS)] =3D 2,
      |                                                                    =
           ^
drivers/iio/adc/ad4130.c:138:79: note: (near initialization for =E2=80=98ad=
4130_reg_size[25]=E2=80=99)
drivers/iio/adc/ad4130.c:139:79: warning: initialized field overwritten [-W=
override-init]
  139 |         [AD4130_FILTER_X_REG(0) ... AD4130_FILTER_X_REG(AD4130_MAX_=
SETUPS)] =3D 3,
      |                                                                    =
           ^
drivers/iio/adc/ad4130.c:139:79: note: (near initialization for =E2=80=98ad=
4130_reg_size[33]=E2=80=99)
drivers/iio/adc/ad4130.c:140:79: warning: initialized field overwritten [-W=
override-init]
  140 |         [AD4130_OFFSET_X_REG(0) ... AD4130_OFFSET_X_REG(AD4130_MAX_=
SETUPS)] =3D 3,
      |                                                                    =
           ^
drivers/iio/adc/ad4130.c:140:79: note: (near initialization for =E2=80=98ad=
4130_reg_size[41]=E2=80=99)
drivers/iio/adc/ad4130.c:141:75: warning: initialized field overwritten [-W=
override-init]
  141 |         [AD4130_GAIN_X_REG(0) ... AD4130_GAIN_X_REG(AD4130_MAX_SETU=
PS)] =3D 3,
      |                                                                    =
       ^
drivers/iio/adc/ad4130.c:141:75: note: (near initialization for =E2=80=98ad=
4130_reg_size[49]=E2=80=99)
drivers/iio/adc/ad4130.c:142:29: warning: initialized field overwritten [-W=
override-init]
  142 |         [AD4130_MISC_REG] =3D 2,
      |                             ^
drivers/iio/adc/ad4130.c:142:29: note: (near initialization for =E2=80=98ad=
4130_reg_size[57]=E2=80=99)
  MODPOST Module.symvers

I think that's an off by one in that you used AD4130_MAX_SETUPS when it sho=
uld be
AD4130_MAX_SETUPS - 1 etc.

I've made that change whilst applying.  Shout if I got the fix wrong!

With that change, series applied to the togreg branch of iio.git and pushed=
 out as testing for
0-day to take a look and see if it can find anything else we've missed!

Thanks,

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-adc-ad4130      |   36 +
>  MAINTAINERS                                   |    2 +
>  drivers/iio/adc/Kconfig                       |   14 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/ad4130.c                      | 2100 +++++++++++++++++
>  5 files changed, 2153 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
>  create mode 100644 drivers/iio/adc/ad4130.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 b/Documen=
tation/ABI/testing/sysfs-bus-iio-adc-ad4130
> new file mode 100644
> index 000000000000..d9555751d21c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> @@ -0,0 +1,36 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_a=
vailable
> +KernelVersion:  6.2
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a list with the possible filter modes.
> +		"sinc4"       - Sinc 4. Excellent noise performance. Long 1st
> +				conversion time. No natural 50/60Hz rejection.
> +		"sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion time.
> +		"sinc3"	      - Sinc3. Moderate 1st conversion time. Good noise
> +				performance.
> +		"sinc3+rej60" - Sinc3 + 60Hz rejection. At a sampling frequency
> +				of 50Hz, achieves simultaneous 50Hz and 60Hz
> +				rejection.
> +		"sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion time.
> +				Best used with a sampling frequency of at least
> +				216.19Hz.
> +		"sinc3+pf1"   - Sinc3 + Post Filter 1.
> +				53dB rejection @ 50Hz, 58dB rejection @ 60Hz.
> +		"sinc3+pf2"   - Sinc3 + Post Filter 2.
> +				70dB rejection @ 50Hz, 70dB rejection @ 60Hz.
> +		"sinc3+pf3"   - Sinc3 + Post Filter 3.
> +				99dB rejection @ 50Hz, 103dB rejection @ 60Hz.
> +		"sinc3+pf4"   - Sinc3 + Post Filter 4.
> +				103dB rejection @ 50Hz, 109dB rejection @ 60Hz.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
> +KernelVersion:  6.2
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Set the filter mode of the differential channel. When the filter
> +		mode changes, the in_voltageY-voltageZ_sampling_frequency and
> +		in_voltageY-voltageZ_sampling_frequency_available attributes
> +		might also change to accommodate the new filter mode.
> +		If the current sampling frequency is out of range for the new
> +		filter mode, the sampling frequency will be changed to the
> +		closest valid one.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ea39e9eea91..97fd88911ca8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1122,7 +1122,9 @@ M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	http://ez.analog.com/community/linux-device-drivers
> +F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> +F:	drivers/iio/adc/ad4130.c
> =20
>  ANALOG DEVICES INC AD7192 DRIVER
>  M:	Alexandru Tachici <alexandru.tachici@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 5386d862def9..8d719fbb6acc 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -21,6 +21,20 @@ config AD_SIGMA_DELTA
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> =20
> +config AD4130
> +	tristate "Analog Device AD4130 ADC Driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_KFIFO_BUF
> +	select REGMAP_SPI
> +	depends on COMMON_CLK
> +	help
> +	  Say yes here to build support for Analog Devices AD4130-8 SPI analog
> +	  to digital converters (ADC).
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad4130.
> +
>  config AD7091R5
>  	tristate "Analog Devices AD7091R5 ADC Driver"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 1571e891828e..4ef41a7dfac6 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -6,6 +6,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> +obj-$(CONFIG_AD4130) +=3D ad4130.o
>  obj-$(CONFIG_AD7091R5) +=3D ad7091r5.o ad7091r-base.o
>  obj-$(CONFIG_AD7124) +=3D ad7124.o
>  obj-$(CONFIG_AD7192) +=3D ad7192.o
> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> new file mode 100644
> index 000000000000..c9e27dc3ba53
> --- /dev/null
> +++ b/drivers/iio/adc/ad4130.c
> @@ -0,0 +1,2100 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2022 Analog Devices, Inc.
> + * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
> +#include <asm/div64.h>
> +#include <asm/unaligned.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define AD4130_NAME				"ad4130"
> +
> +#define AD4130_COMMS_READ_MASK			BIT(6)
> +
> +#define AD4130_STATUS_REG			0x00
> +
> +#define AD4130_ADC_CONTROL_REG			0x01
> +#define AD4130_ADC_CONTROL_BIPOLAR_MASK		BIT(14)
> +#define AD4130_ADC_CONTROL_INT_REF_VAL_MASK	BIT(13)
> +#define AD4130_INT_REF_2_5V			2500000
> +#define AD4130_INT_REF_1_25V			1250000
> +#define AD4130_ADC_CONTROL_CSB_EN_MASK		BIT(9)
> +#define AD4130_ADC_CONTROL_INT_REF_EN_MASK	BIT(8)
> +#define AD4130_ADC_CONTROL_MODE_MASK		GENMASK(5, 2)
> +#define AD4130_ADC_CONTROL_MCLK_SEL_MASK	GENMASK(1, 0)
> +#define AD4130_MCLK_FREQ_76_8KHZ		76800
> +#define AD4130_MCLK_FREQ_153_6KHZ		153600
> +
> +#define AD4130_DATA_REG				0x02
> +
> +#define AD4130_IO_CONTROL_REG			0x03
> +#define AD4130_IO_CONTROL_INT_PIN_SEL_MASK	GENMASK(9, 8)
> +#define AD4130_IO_CONTROL_GPIO_DATA_MASK	GENMASK(7, 4)
> +#define AD4130_IO_CONTROL_GPIO_CTRL_MASK	GENMASK(3, 0)
> +
> +#define AD4130_VBIAS_REG			0x04
> +
> +#define AD4130_ID_REG				0x05
> +
> +#define AD4130_ERROR_REG			0x06
> +
> +#define AD4130_ERROR_EN_REG			0x07
> +
> +#define AD4130_MCLK_COUNT_REG			0x08
> +
> +#define AD4130_CHANNEL_X_REG(x)			(0x09 + (x))
> +#define AD4130_CHANNEL_EN_MASK			BIT(23)
> +#define AD4130_CHANNEL_SETUP_MASK		GENMASK(22, 20)
> +#define AD4130_CHANNEL_AINP_MASK		GENMASK(17, 13)
> +#define AD4130_CHANNEL_AINM_MASK		GENMASK(12, 8)
> +#define AD4130_CHANNEL_IOUT1_MASK		GENMASK(7, 4)
> +#define AD4130_CHANNEL_IOUT2_MASK		GENMASK(3, 0)
> +
> +#define AD4130_CONFIG_X_REG(x)			(0x19 + (x))
> +#define AD4130_CONFIG_IOUT1_VAL_MASK		GENMASK(15, 13)
> +#define AD4130_CONFIG_IOUT2_VAL_MASK		GENMASK(12, 10)
> +#define AD4130_CONFIG_BURNOUT_MASK		GENMASK(9, 8)
> +#define AD4130_CONFIG_REF_BUFP_MASK		BIT(7)
> +#define AD4130_CONFIG_REF_BUFM_MASK		BIT(6)
> +#define AD4130_CONFIG_REF_SEL_MASK		GENMASK(5, 4)
> +#define AD4130_CONFIG_PGA_MASK			GENMASK(3, 1)
> +
> +#define AD4130_FILTER_X_REG(x)			(0x21 + (x))
> +#define AD4130_FILTER_MODE_MASK			GENMASK(15, 12)
> +#define AD4130_FILTER_SELECT_MASK		GENMASK(10, 0)
> +#define AD4130_FILTER_SELECT_MIN		1
> +
> +#define AD4130_OFFSET_X_REG(x)			(0x29 + (x))
> +
> +#define AD4130_GAIN_X_REG(x)			(0x31 + (x))
> +
> +#define AD4130_MISC_REG				0x39
> +
> +#define AD4130_FIFO_CONTROL_REG			0x3a
> +#define AD4130_FIFO_CONTROL_HEADER_MASK		BIT(18)
> +#define AD4130_FIFO_CONTROL_MODE_MASK		GENMASK(17, 16)
> +#define AD4130_FIFO_CONTROL_WM_INT_EN_MASK	BIT(9)
> +#define AD4130_FIFO_CONTROL_WM_MASK		GENMASK(7, 0)
> +#define AD4130_WATERMARK_256			0
> +
> +#define AD4130_FIFO_STATUS_REG			0x3b
> +
> +#define AD4130_FIFO_THRESHOLD_REG		0x3c
> +
> +#define AD4130_FIFO_DATA_REG			0x3d
> +#define AD4130_FIFO_SIZE			256
> +#define AD4130_FIFO_MAX_SAMPLE_SIZE		3
> +
> +#define AD4130_MAX_ANALOG_PINS			16
> +#define AD4130_MAX_CHANNELS			16
> +#define AD4130_MAX_DIFF_INPUTS			30
> +#define AD4130_MAX_GPIOS			4
> +#define AD4130_MAX_ODR				2400
> +#define AD4130_MAX_PGA				8
> +#define AD4130_MAX_SETUPS			8
> +
> +#define AD4130_AIN2_P1				0x2
> +#define AD4130_AIN3_P2				0x3
> +
> +#define AD4130_RESET_BUF_SIZE			8
> +#define AD4130_RESET_SLEEP_US			(160 * MICRO / AD4130_MCLK_FREQ_76_8KHZ)
> +
> +#define AD4130_INVALID_SLOT			-1
> +
> +static const unsigned int ad4130_reg_size[] =3D {
> +	[AD4130_STATUS_REG] =3D 1,
> +	[AD4130_ADC_CONTROL_REG] =3D 2,
> +	[AD4130_DATA_REG] =3D 3,
> +	[AD4130_IO_CONTROL_REG] =3D 2,
> +	[AD4130_VBIAS_REG] =3D 2,
> +	[AD4130_ID_REG] =3D 1,
> +	[AD4130_ERROR_REG] =3D 2,
> +	[AD4130_ERROR_EN_REG] =3D 2,
> +	[AD4130_MCLK_COUNT_REG] =3D 1,
> +	[AD4130_CHANNEL_X_REG(0) ... AD4130_CHANNEL_X_REG(AD4130_MAX_CHANNELS)]=
 =3D 3,
> +	[AD4130_CONFIG_X_REG(0) ... AD4130_CONFIG_X_REG(AD4130_MAX_SETUPS)] =3D=
 2,
> +	[AD4130_FILTER_X_REG(0) ... AD4130_FILTER_X_REG(AD4130_MAX_SETUPS)] =3D=
 3,
> +	[AD4130_OFFSET_X_REG(0) ... AD4130_OFFSET_X_REG(AD4130_MAX_SETUPS)] =3D=
 3,
> +	[AD4130_GAIN_X_REG(0) ... AD4130_GAIN_X_REG(AD4130_MAX_SETUPS)] =3D 3,
> +	[AD4130_MISC_REG] =3D 2,
> +	[AD4130_FIFO_CONTROL_REG] =3D 3,
> +	[AD4130_FIFO_STATUS_REG] =3D 1,
> +	[AD4130_FIFO_THRESHOLD_REG] =3D 3,
> +	[AD4130_FIFO_DATA_REG] =3D 3,
> +};
> +
> +enum ad4130_int_ref_val {
> +	AD4130_INT_REF_VAL_2_5V,
> +	AD4130_INT_REF_VAL_1_25V,
> +};
> +
> +enum ad4130_mclk_sel {
> +	AD4130_MCLK_76_8KHZ,
> +	AD4130_MCLK_76_8KHZ_OUT,
> +	AD4130_MCLK_76_8KHZ_EXT,
> +	AD4130_MCLK_153_6KHZ_EXT,
> +};
> +
> +enum ad4130_int_pin_sel {
> +	AD4130_INT_PIN_INT,
> +	AD4130_INT_PIN_CLK,
> +	AD4130_INT_PIN_P2,
> +	AD4130_INT_PIN_DOUT,
> +};
> +
> +enum ad4130_iout {
> +	AD4130_IOUT_OFF,
> +	AD4130_IOUT_10000NA,
> +	AD4130_IOUT_20000NA,
> +	AD4130_IOUT_50000NA,
> +	AD4130_IOUT_100000NA,
> +	AD4130_IOUT_150000NA,
> +	AD4130_IOUT_200000NA,
> +	AD4130_IOUT_100NA,
> +	AD4130_IOUT_MAX
> +};
> +
> +enum ad4130_burnout {
> +	AD4130_BURNOUT_OFF,
> +	AD4130_BURNOUT_500NA,
> +	AD4130_BURNOUT_2000NA,
> +	AD4130_BURNOUT_4000NA,
> +	AD4130_BURNOUT_MAX
> +};
> +
> +enum ad4130_ref_sel {
> +	AD4130_REF_REFIN1,
> +	AD4130_REF_REFIN2,
> +	AD4130_REF_REFOUT_AVSS,
> +	AD4130_REF_AVDD_AVSS,
> +	AD4130_REF_SEL_MAX
> +};
> +
> +enum ad4130_fifo_mode {
> +	AD4130_FIFO_MODE_DISABLED =3D 0b00,
> +	AD4130_FIFO_MODE_WM =3D 0b01,
> +};
> +
> +enum ad4130_mode {
> +	AD4130_MODE_CONTINUOUS =3D 0b0000,
> +	AD4130_MODE_IDLE =3D 0b0100,
> +};
> +
> +enum ad4130_filter_mode {
> +	AD4130_FILTER_SINC4,
> +	AD4130_FILTER_SINC4_SINC1,
> +	AD4130_FILTER_SINC3,
> +	AD4130_FILTER_SINC3_REJ60,
> +	AD4130_FILTER_SINC3_SINC1,
> +	AD4130_FILTER_SINC3_PF1,
> +	AD4130_FILTER_SINC3_PF2,
> +	AD4130_FILTER_SINC3_PF3,
> +	AD4130_FILTER_SINC3_PF4,
> +};
> +
> +enum ad4130_pin_function {
> +	AD4130_PIN_FN_NONE,
> +	AD4130_PIN_FN_SPECIAL =3D BIT(0),
> +	AD4130_PIN_FN_DIFF =3D BIT(1),
> +	AD4130_PIN_FN_EXCITATION =3D BIT(2),
> +	AD4130_PIN_FN_VBIAS =3D BIT(3),
> +};
> +
> +struct ad4130_setup_info {
> +	unsigned int			iout0_val;
> +	unsigned int			iout1_val;
> +	unsigned int			burnout;
> +	unsigned int			pga;
> +	unsigned int			fs;
> +	u32				ref_sel;
> +	enum ad4130_filter_mode		filter_mode;
> +	bool				ref_bufp;
> +	bool				ref_bufm;
> +};
> +
> +struct ad4130_slot_info {
> +	struct ad4130_setup_info	setup;
> +	unsigned int			enabled_channels;
> +	unsigned int			channels;
> +};
> +
> +struct ad4130_chan_info {
> +	struct ad4130_setup_info	setup;
> +	u32				iout0;
> +	u32				iout1;
> +	int				slot;
> +	bool				enabled;
> +	bool				initialized;
> +};
> +
> +struct ad4130_filter_config {
> +	enum ad4130_filter_mode		filter_mode;
> +	unsigned int			odr_div;
> +	unsigned int			fs_max;
> +	enum iio_available_type		samp_freq_avail_type;
> +	int				samp_freq_avail_len;
> +	int				samp_freq_avail[3][2];
> +};
> +
> +struct ad4130_state {
> +	struct regmap			*regmap;
> +	struct spi_device		*spi;
> +	struct clk			*mclk;
> +	struct regulator_bulk_data	regulators[4];
> +	u32				irq_trigger;
> +	u32				inv_irq_trigger;
> +
> +	/*
> +	 * Synchronize access to members the of driver state, and ensure
> +	 * atomicity of consecutive regmap operations.
> +	 */
> +	struct mutex			lock;
> +	struct completion		completion;
> +
> +	struct iio_chan_spec		chans[AD4130_MAX_CHANNELS];
> +	struct ad4130_chan_info		chans_info[AD4130_MAX_CHANNELS];
> +	struct ad4130_slot_info		slots_info[AD4130_MAX_SETUPS];
> +	enum ad4130_pin_function	pins_fn[AD4130_MAX_ANALOG_PINS];
> +	u32				vbias_pins[AD4130_MAX_ANALOG_PINS];
> +	u32				num_vbias_pins;
> +	int				scale_tbls[AD4130_REF_SEL_MAX][AD4130_MAX_PGA][2];
> +	struct gpio_chip		gc;
> +	struct clk_hw			int_clk_hw;
> +
> +	u32			int_pin_sel;
> +	u32			int_ref_uv;
> +	u32			mclk_sel;
> +	bool			int_ref_en;
> +	bool			bipolar;
> +
> +	unsigned int		num_enabled_channels;
> +	unsigned int		effective_watermark;
> +	unsigned int		watermark;
> +
> +	struct spi_message	fifo_msg;
> +	struct spi_transfer	fifo_xfer[2];
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires any transfer
> +	 * buffers to live in their own cache lines. As the use of these
> +	 * buffers is synchronous, all of the buffers used for DMA in this
> +	 * driver may share a cache line.
> +	 */
> +	u8			reset_buf[AD4130_RESET_BUF_SIZE] __aligned(IIO_DMA_MINALIGN);
> +	u8			reg_write_tx_buf[4];
> +	u8			reg_read_tx_buf[1];
> +	u8			reg_read_rx_buf[3];
> +	u8			fifo_tx_buf[2];
> +	u8			fifo_rx_buf[AD4130_FIFO_SIZE *
> +					    AD4130_FIFO_MAX_SAMPLE_SIZE];
> +};
> +
> +static const char * const ad4130_int_pin_names[] =3D {
> +	[AD4130_INT_PIN_INT] =3D "int",
> +	[AD4130_INT_PIN_CLK] =3D "clk",
> +	[AD4130_INT_PIN_P2] =3D "p2",
> +	[AD4130_INT_PIN_DOUT] =3D "dout",
> +};
> +
> +static const unsigned int ad4130_iout_current_na_tbl[AD4130_IOUT_MAX] =
=3D {
> +	[AD4130_IOUT_OFF] =3D 0,
> +	[AD4130_IOUT_100NA] =3D 100,
> +	[AD4130_IOUT_10000NA] =3D 10000,
> +	[AD4130_IOUT_20000NA] =3D 20000,
> +	[AD4130_IOUT_50000NA] =3D 50000,
> +	[AD4130_IOUT_100000NA] =3D 100000,
> +	[AD4130_IOUT_150000NA] =3D 150000,
> +	[AD4130_IOUT_200000NA] =3D 200000,
> +};
> +
> +static const unsigned int ad4130_burnout_current_na_tbl[AD4130_BURNOUT_M=
AX] =3D {
> +	[AD4130_BURNOUT_OFF] =3D 0,
> +	[AD4130_BURNOUT_500NA] =3D 500,
> +	[AD4130_BURNOUT_2000NA] =3D 2000,
> +	[AD4130_BURNOUT_4000NA] =3D 4000,
> +};
> +
> +#define AD4130_VARIABLE_ODR_CONFIG(_filter_mode, _odr_div, _fs_max)	\
> +{									\
> +		.filter_mode =3D (_filter_mode),				\
> +		.odr_div =3D (_odr_div),					\
> +		.fs_max =3D (_fs_max),					\
> +		.samp_freq_avail_type =3D IIO_AVAIL_RANGE,		\
> +		.samp_freq_avail =3D {					\
> +			{ AD4130_MAX_ODR, (_odr_div) * (_fs_max) },	\
> +			{ AD4130_MAX_ODR, (_odr_div) * (_fs_max) },	\
> +			{ AD4130_MAX_ODR, (_odr_div) },			\
> +		},							\
> +}
> +
> +#define AD4130_FIXED_ODR_CONFIG(_filter_mode, _odr_div)			\
> +{									\
> +		.filter_mode =3D (_filter_mode),				\
> +		.odr_div =3D (_odr_div),					\
> +		.fs_max =3D AD4130_FILTER_SELECT_MIN,			\
> +		.samp_freq_avail_type =3D IIO_AVAIL_LIST,			\
> +		.samp_freq_avail_len =3D 1,				\
> +		.samp_freq_avail =3D {					\
> +			{ AD4130_MAX_ODR, (_odr_div) },			\
> +		},							\
> +}
> +
> +static const struct ad4130_filter_config ad4130_filter_configs[] =3D {
> +	AD4130_VARIABLE_ODR_CONFIG(AD4130_FILTER_SINC4,       1,  10),
> +	AD4130_VARIABLE_ODR_CONFIG(AD4130_FILTER_SINC4_SINC1, 11, 10),
> +	AD4130_VARIABLE_ODR_CONFIG(AD4130_FILTER_SINC3,       1,  2047),
> +	AD4130_VARIABLE_ODR_CONFIG(AD4130_FILTER_SINC3_REJ60, 1,  2047),
> +	AD4130_VARIABLE_ODR_CONFIG(AD4130_FILTER_SINC3_SINC1, 10, 2047),
> +	AD4130_FIXED_ODR_CONFIG(AD4130_FILTER_SINC3_PF1,      92),
> +	AD4130_FIXED_ODR_CONFIG(AD4130_FILTER_SINC3_PF2,      100),
> +	AD4130_FIXED_ODR_CONFIG(AD4130_FILTER_SINC3_PF3,      124),
> +	AD4130_FIXED_ODR_CONFIG(AD4130_FILTER_SINC3_PF4,      148),
> +};
> +
> +static const char * const ad4130_filter_modes_str[] =3D {
> +	[AD4130_FILTER_SINC4] =3D "sinc4",
> +	[AD4130_FILTER_SINC4_SINC1] =3D "sinc4+sinc1",
> +	[AD4130_FILTER_SINC3] =3D "sinc3",
> +	[AD4130_FILTER_SINC3_REJ60] =3D "sinc3+rej60",
> +	[AD4130_FILTER_SINC3_SINC1] =3D "sinc3+sinc1",
> +	[AD4130_FILTER_SINC3_PF1] =3D "sinc3+pf1",
> +	[AD4130_FILTER_SINC3_PF2] =3D "sinc3+pf2",
> +	[AD4130_FILTER_SINC3_PF3] =3D "sinc3+pf3",
> +	[AD4130_FILTER_SINC3_PF4] =3D "sinc3+pf4",
> +};
> +
> +static int ad4130_get_reg_size(struct ad4130_state *st, unsigned int reg,
> +			       unsigned int *size)
> +{
> +	if (reg >=3D ARRAY_SIZE(ad4130_reg_size))
> +		return -EINVAL;
> +
> +	*size =3D ad4130_reg_size[reg];
> +
> +	return 0;
> +}
> +
> +static unsigned int ad4130_data_reg_size(struct ad4130_state *st)
> +{
> +	unsigned int data_reg_size;
> +	int ret;
> +
> +	ret =3D ad4130_get_reg_size(st, AD4130_DATA_REG, &data_reg_size);
> +	if (ret)
> +		return 0;
> +
> +	return data_reg_size;
> +}
> +
> +static unsigned int ad4130_resolution(struct ad4130_state *st)
> +{
> +	return ad4130_data_reg_size(st) * BITS_PER_BYTE;
> +}
> +
> +static int ad4130_reg_write(void *context, unsigned int reg, unsigned in=
t val)
> +{
> +	struct ad4130_state *st =3D context;
> +	unsigned int size;
> +	int ret;
> +
> +	ret =3D ad4130_get_reg_size(st, reg, &size);
> +	if (ret)
> +		return ret;
> +
> +	st->reg_write_tx_buf[0] =3D reg;
> +
> +	switch (size) {
> +	case 3:
> +		put_unaligned_be24(val, &st->reg_write_tx_buf[1]);
> +		break;
> +	case 2:
> +		put_unaligned_be16(val, &st->reg_write_tx_buf[1]);
> +		break;
> +	case 1:
> +		st->reg_write_tx_buf[1] =3D val;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return spi_write(st->spi, st->reg_write_tx_buf, size + 1);
> +}
> +
> +static int ad4130_reg_read(void *context, unsigned int reg, unsigned int=
 *val)
> +{
> +	struct ad4130_state *st =3D context;
> +	struct spi_transfer t[] =3D {
> +		{
> +			.tx_buf =3D st->reg_read_tx_buf,
> +			.len =3D sizeof(st->reg_read_tx_buf),
> +		},
> +		{
> +			.rx_buf =3D st->reg_read_rx_buf,
> +		},
> +	};
> +	unsigned int size;
> +	int ret;
> +
> +	ret =3D ad4130_get_reg_size(st, reg, &size);
> +	if (ret)
> +		return ret;
> +
> +	st->reg_read_tx_buf[0] =3D AD4130_COMMS_READ_MASK | reg;
> +	t[1].len =3D size;
> +
> +	ret =3D spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> +	if (ret)
> +		return ret;
> +
> +	switch (size) {
> +	case 3:
> +		*val =3D get_unaligned_be24(st->reg_read_rx_buf);
> +		break;
> +	case 2:
> +		*val =3D get_unaligned_be16(st->reg_read_rx_buf);
> +		break;
> +	case 1:
> +		*val =3D st->reg_read_rx_buf[0];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config ad4130_regmap_config =3D {
> +	.reg_read =3D ad4130_reg_read,
> +	.reg_write =3D ad4130_reg_write,
> +};
> +
> +static int ad4130_gpio_init_valid_mask(struct gpio_chip *gc,
> +				       unsigned long *valid_mask,
> +				       unsigned int ngpios)
> +{
> +	struct ad4130_state *st =3D gpiochip_get_data(gc);
> +	unsigned int i;
> +
> +	/*
> +	 * Output-only GPIO functionality is available on pins AIN2 through
> +	 * AIN5. If these pins are used for anything else, do not expose them.
> +	 */
> +	for (i =3D 0; i < ngpios; i++) {
> +		unsigned int pin =3D i + AD4130_AIN2_P1;
> +		bool valid =3D st->pins_fn[pin] =3D=3D AD4130_PIN_FN_NONE;
> +
> +		__assign_bit(i, valid_mask, valid);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4130_gpio_get_direction(struct gpio_chip *gc, unsigned int =
offset)
> +{
> +	return GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static void ad4130_gpio_set(struct gpio_chip *gc, unsigned int offset,
> +			    int value)
> +{
> +	struct ad4130_state *st =3D gpiochip_get_data(gc);
> +	unsigned int mask =3D FIELD_PREP(AD4130_IO_CONTROL_GPIO_DATA_MASK,
> +				       BIT(offset));
> +
> +	regmap_update_bits(st->regmap, AD4130_IO_CONTROL_REG, mask,
> +			   value ? mask : 0);
> +}
> +
> +static int ad4130_set_mode(struct ad4130_state *st, enum ad4130_mode mod=
e)
> +{
> +	return regmap_update_bits(st->regmap, AD4130_ADC_CONTROL_REG,
> +				  AD4130_ADC_CONTROL_MODE_MASK,
> +				  FIELD_PREP(AD4130_ADC_CONTROL_MODE_MASK, mode));
> +}
> +
> +static int ad4130_set_watermark_interrupt_en(struct ad4130_state *st, bo=
ol en)
> +{
> +	return regmap_update_bits(st->regmap, AD4130_FIFO_CONTROL_REG,
> +				  AD4130_FIFO_CONTROL_WM_INT_EN_MASK,
> +				  FIELD_PREP(AD4130_FIFO_CONTROL_WM_INT_EN_MASK, en));
> +}
> +
> +static unsigned int ad4130_watermark_reg_val(unsigned int val)
> +{
> +	if (val =3D=3D AD4130_FIFO_SIZE)
> +		val =3D AD4130_WATERMARK_256;
> +
> +	return val;
> +}
> +
> +static int ad4130_set_fifo_mode(struct ad4130_state *st,
> +				enum ad4130_fifo_mode mode)
> +{
> +	return regmap_update_bits(st->regmap, AD4130_FIFO_CONTROL_REG,
> +				  AD4130_FIFO_CONTROL_MODE_MASK,
> +				  FIELD_PREP(AD4130_FIFO_CONTROL_MODE_MASK, mode));
> +}
> +
> +static void ad4130_push_fifo_data(struct iio_dev *indio_dev)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	unsigned int data_reg_size =3D ad4130_data_reg_size(st);
> +	unsigned int transfer_len =3D st->effective_watermark * data_reg_size;
> +	unsigned int set_size =3D st->num_enabled_channels * data_reg_size;
> +	unsigned int i;
> +	int ret;
> +
> +	st->fifo_tx_buf[1] =3D ad4130_watermark_reg_val(st->effective_watermark=
);
> +	st->fifo_xfer[1].len =3D transfer_len;
> +
> +	ret =3D spi_sync(st->spi, &st->fifo_msg);
> +	if (ret)
> +		return;
> +
> +	for (i =3D 0; i < transfer_len; i +=3D set_size)
> +		iio_push_to_buffers(indio_dev, &st->fifo_rx_buf[i]);
> +}
> +
> +static irqreturn_t ad4130_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		ad4130_push_fifo_data(indio_dev);
> +	else
> +		complete(&st->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ad4130_find_slot(struct ad4130_state *st,
> +			    struct ad4130_setup_info *target_setup_info,
> +			    unsigned int *slot, bool *overwrite)
> +{
> +	unsigned int i;
> +
> +	*slot =3D AD4130_INVALID_SLOT;
> +	*overwrite =3D false;
> +
> +	for (i =3D 0; i < AD4130_MAX_SETUPS; i++) {
> +		struct ad4130_slot_info *slot_info =3D &st->slots_info[i];
> +
> +		/* Immediately accept a matching setup info. */
> +		if (!memcmp(target_setup_info, &slot_info->setup,
> +			    sizeof(*target_setup_info))) {
> +			*slot =3D i;
> +			return 0;
> +		}
> +
> +		/* Ignore all setups which are used by enabled channels. */
> +		if (slot_info->enabled_channels)
> +			continue;
> +
> +		/* Find the least used slot. */
> +		if (*slot =3D=3D AD4130_INVALID_SLOT ||
> +		    slot_info->channels < st->slots_info[*slot].channels)
> +			*slot =3D i;
> +	}
> +
> +	if (*slot =3D=3D AD4130_INVALID_SLOT)
> +		return -EINVAL;
> +
> +	*overwrite =3D true;
> +
> +	return 0;
> +}
> +
> +static void ad4130_unlink_channel(struct ad4130_state *st, unsigned int =
channel)
> +{
> +	struct ad4130_chan_info *chan_info =3D &st->chans_info[channel];
> +	struct ad4130_slot_info *slot_info =3D &st->slots_info[chan_info->slot];
> +
> +	chan_info->slot =3D AD4130_INVALID_SLOT;
> +	slot_info->channels--;
> +}
> +
> +static int ad4130_unlink_slot(struct ad4130_state *st, unsigned int slot)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < AD4130_MAX_CHANNELS; i++) {
> +		struct ad4130_chan_info *chan_info =3D &st->chans_info[i];
> +
> +		if (!chan_info->initialized || chan_info->slot !=3D slot)
> +			continue;
> +
> +		ad4130_unlink_channel(st, i);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4130_link_channel_slot(struct ad4130_state *st,
> +				    unsigned int channel, unsigned int slot)
> +{
> +	struct ad4130_slot_info *slot_info =3D &st->slots_info[slot];
> +	struct ad4130_chan_info *chan_info =3D &st->chans_info[channel];
> +	int ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, AD4130_CHANNEL_X_REG(channel),
> +				 AD4130_CHANNEL_SETUP_MASK,
> +				 FIELD_PREP(AD4130_CHANNEL_SETUP_MASK, slot));
> +	if (ret)
> +		return ret;
> +
> +	chan_info->slot =3D slot;
> +	slot_info->channels++;
> +
> +	return 0;
> +}
> +
> +static int ad4130_write_slot_setup(struct ad4130_state *st,
> +				   unsigned int slot,
> +				   struct ad4130_setup_info *setup_info)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	val =3D FIELD_PREP(AD4130_CONFIG_IOUT1_VAL_MASK, setup_info->iout0_val)=
 |
> +	      FIELD_PREP(AD4130_CONFIG_IOUT1_VAL_MASK, setup_info->iout1_val) |
> +	      FIELD_PREP(AD4130_CONFIG_BURNOUT_MASK, setup_info->burnout) |
> +	      FIELD_PREP(AD4130_CONFIG_REF_BUFP_MASK, setup_info->ref_bufp) |
> +	      FIELD_PREP(AD4130_CONFIG_REF_BUFM_MASK, setup_info->ref_bufm) |
> +	      FIELD_PREP(AD4130_CONFIG_REF_SEL_MASK, setup_info->ref_sel) |
> +	      FIELD_PREP(AD4130_CONFIG_PGA_MASK, setup_info->pga);
> +
> +	ret =3D regmap_write(st->regmap, AD4130_CONFIG_X_REG(slot), val);
> +	if (ret)
> +		return ret;
> +
> +	val =3D FIELD_PREP(AD4130_FILTER_MODE_MASK, setup_info->filter_mode) |
> +	      FIELD_PREP(AD4130_FILTER_SELECT_MASK, setup_info->fs);
> +
> +	ret =3D regmap_write(st->regmap, AD4130_FILTER_X_REG(slot), val);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(&st->slots_info[slot].setup, setup_info, sizeof(*setup_info));
> +
> +	return 0;
> +}
> +
> +static int ad4130_write_channel_setup(struct ad4130_state *st,
> +				      unsigned int channel, bool on_enable)
> +{
> +	struct ad4130_chan_info *chan_info =3D &st->chans_info[channel];
> +	struct ad4130_setup_info *setup_info =3D &chan_info->setup;
> +	bool overwrite;
> +	int slot;
> +	int ret;
> +
> +	/*
> +	 * The following cases need to be handled.
> +	 *
> +	 * 1. Enabled and linked channel with setup changes:
> +	 *    - Find a slot. If not possible, return error.
> +	 *    - Unlink channel from current slot.
> +	 *    - If the slot has channels linked to it, unlink all channels, and
> +	 *      write the new setup to it.
> +	 *    - Link channel to new slot.
> +	 *
> +	 * 2. Soon to be enabled and unlinked channel:
> +	 *    - Find a slot. If not possible, return error.
> +	 *    - If the slot has channels linked to it, unlink all channels, and
> +	 *      write the new setup to it.
> +	 *    - Link channel to the slot.
> +	 *
> +	 * 3. Disabled and linked channel with setup changes:
> +	 *    - Unlink channel from current slot.
> +	 *
> +	 * 4. Soon to be enabled and linked channel:
> +	 * 5. Disabled and unlinked channel with setup changes:
> +	 *    - Do nothing.
> +	 */
> +
> +	/* Case 4 */
> +	if (on_enable && chan_info->slot !=3D AD4130_INVALID_SLOT)
> +		return 0;
> +
> +	if (!on_enable && !chan_info->enabled) {
> +		if (chan_info->slot !=3D AD4130_INVALID_SLOT)
> +			/* Case 3 */
> +			ad4130_unlink_channel(st, channel);
> +
> +		/* Cases 3 & 5 */
> +		return 0;
> +	}
> +
> +	/* Cases 1 & 2 */
> +	ret =3D ad4130_find_slot(st, setup_info, &slot, &overwrite);
> +	if (ret)
> +		return ret;
> +
> +	if (chan_info->slot !=3D AD4130_INVALID_SLOT)
> +		/* Case 1 */
> +		ad4130_unlink_channel(st, channel);
> +
> +	if (overwrite) {
> +		ret =3D ad4130_unlink_slot(st, slot);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ad4130_write_slot_setup(st, slot, setup_info);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ad4130_link_channel_slot(st, channel, slot);
> +}
> +
> +static int ad4130_set_channel_enable(struct ad4130_state *st,
> +				     unsigned int channel, bool status)
> +{
> +	struct ad4130_chan_info *chan_info =3D &st->chans_info[channel];
> +	struct ad4130_slot_info *slot_info;
> +	int ret;
> +
> +	if (chan_info->enabled =3D=3D status)
> +		return 0;
> +
> +	if (status) {
> +		ret =3D ad4130_write_channel_setup(st, channel, true);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	slot_info =3D &st->slots_info[chan_info->slot];
> +
> +	ret =3D regmap_update_bits(st->regmap, AD4130_CHANNEL_X_REG(channel),
> +				 AD4130_CHANNEL_EN_MASK,
> +				 FIELD_PREP(AD4130_CHANNEL_EN_MASK, status));
> +	if (ret)
> +		return ret;
> +
> +	slot_info->enabled_channels +=3D status ? 1 : -1;
> +	chan_info->enabled =3D status;
> +
> +	return 0;
> +}
> +
> +/*
> + * Table 58. FILTER_MODE_n bits and Filter Types of the datasheet descri=
bes
> + * the relation between filter mode, ODR and FS.
> + *
> + * Notice that the max ODR of each filter mode is not necessarily the
> + * absolute max ODR supported by the chip.
> + *
> + * The ODR divider is not explicitly specified, but it can be deduced ba=
sed
> + * on the ODR range of each filter mode.
> + *
> + * For example, for Sinc4+Sinc1, max ODR is 218.18. That means that the
> + * absolute max ODR is divided by 11 to achieve the max ODR of this filt=
er
> + * mode.
> + *
> + * The formulas for converting between ODR and FS for a specific filter
> + * mode can be deduced from the same table.
> + *
> + * Notice that FS =3D 1 actually means max ODR, and that ODR decreases by
> + * (maximum ODR / maximum FS) for each increment of FS.
> + *
> + * odr =3D MAX_ODR / odr_div * (1 - (fs - 1) / fs_max) <=3D>
> + * odr =3D MAX_ODR * (1 - (fs - 1) / fs_max) / odr_div <=3D>
> + * odr =3D MAX_ODR * (1 - (fs - 1) / fs_max) / odr_div <=3D>
> + * odr =3D MAX_ODR * (fs_max - fs + 1) / (fs_max * odr_div)
> + * (used in ad4130_fs_to_freq)
> + *
> + * For the opposite formula, FS can be extracted from the last one.
> + *
> + * MAX_ODR * (fs_max - fs + 1) =3D fs_max * odr_div * odr <=3D>
> + * fs_max - fs + 1 =3D fs_max * odr_div * odr / MAX_ODR <=3D>
> + * fs =3D 1 + fs_max - fs_max * odr_div * odr / MAX_ODR
> + * (used in ad4130_fs_to_freq)
> + */
> +
> +static void ad4130_freq_to_fs(enum ad4130_filter_mode filter_mode,
> +			      int val, int val2, unsigned int *fs)
> +{
> +	const struct ad4130_filter_config *filter_config =3D
> +		&ad4130_filter_configs[filter_mode];
> +	u64 dividend, divisor;
> +	int temp;
> +
> +	dividend =3D filter_config->fs_max * filter_config->odr_div *
> +		   ((u64)val * NANO + val2);
> +	divisor =3D (u64)AD4130_MAX_ODR * NANO;
> +
> +	temp =3D AD4130_FILTER_SELECT_MIN + filter_config->fs_max -
> +	       DIV64_U64_ROUND_CLOSEST(dividend, divisor);
> +
> +	if (temp < AD4130_FILTER_SELECT_MIN)
> +		temp =3D AD4130_FILTER_SELECT_MIN;
> +	else if (temp > filter_config->fs_max)
> +		temp =3D filter_config->fs_max;
> +
> +	*fs =3D temp;
> +}
> +
> +static void ad4130_fs_to_freq(enum ad4130_filter_mode filter_mode,
> +			      unsigned int fs, int *val, int *val2)
> +{
> +	const struct ad4130_filter_config *filter_config =3D
> +		&ad4130_filter_configs[filter_mode];
> +	unsigned int dividend, divisor;
> +	u64 temp;
> +
> +	dividend =3D (filter_config->fs_max - fs + AD4130_FILTER_SELECT_MIN) *
> +		   AD4130_MAX_ODR;
> +	divisor =3D filter_config->fs_max * filter_config->odr_div;
> +
> +	temp =3D div_u64((u64)dividend * NANO, divisor);
> +	*val =3D div_u64_rem(temp, NANO, val2);
> +}
> +
> +static int ad4130_set_filter_mode(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  unsigned int val)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	unsigned int channel =3D chan->scan_index;
> +	struct ad4130_chan_info *chan_info =3D &st->chans_info[channel];
> +	struct ad4130_setup_info *setup_info =3D &chan_info->setup;
> +	enum ad4130_filter_mode old_filter_mode;
> +	int freq_val, freq_val2;
> +	unsigned int old_fs;
> +	int ret =3D 0;
> +
> +	mutex_lock(&st->lock);
> +	if (setup_info->filter_mode =3D=3D val)
> +		goto out;
> +
> +	old_fs =3D setup_info->fs;
> +	old_filter_mode =3D setup_info->filter_mode;
> +
> +	/*
> +	 * When switching between filter modes, try to match the ODR as
> +	 * close as possible. To do this, convert the current FS into ODR
> +	 * using the old filter mode, then convert it back into FS using
> +	 * the new filter mode.
> +	 */
> +	ad4130_fs_to_freq(setup_info->filter_mode, setup_info->fs,
> +			  &freq_val, &freq_val2);
> +
> +	ad4130_freq_to_fs(val, freq_val, freq_val2, &setup_info->fs);
> +
> +	setup_info->filter_mode =3D val;
> +
> +	ret =3D ad4130_write_channel_setup(st, channel, false);
> +	if (ret) {
> +		setup_info->fs =3D old_fs;
> +		setup_info->filter_mode =3D old_filter_mode;
> +	}
> +
> + out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int ad4130_get_filter_mode(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	unsigned int channel =3D chan->scan_index;
> +	struct ad4130_setup_info *setup_info =3D &st->chans_info[channel].setup;
> +	enum ad4130_filter_mode filter_mode;
> +
> +	mutex_lock(&st->lock);
> +	filter_mode =3D setup_info->filter_mode;
> +	mutex_unlock(&st->lock);
> +
> +	return filter_mode;
> +}
> +
> +static const struct iio_enum ad4130_filter_mode_enum =3D {
> +	.items =3D ad4130_filter_modes_str,
> +	.num_items =3D ARRAY_SIZE(ad4130_filter_modes_str),
> +	.set =3D ad4130_set_filter_mode,
> +	.get =3D ad4130_get_filter_mode,
> +};
> +
> +static const struct iio_chan_spec_ext_info ad4130_filter_mode_ext_info[]=
 =3D {
> +	IIO_ENUM("filter_mode", IIO_SEPARATE, &ad4130_filter_mode_enum),
> +	IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_TYPE,
> +			   &ad4130_filter_mode_enum),
> +	{ }
> +};
> +
> +static const struct iio_chan_spec ad4130_channel_template =3D {
> +	.type =3D IIO_VOLTAGE,
> +	.indexed =3D 1,
> +	.differential =3D 1,
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +			      BIT(IIO_CHAN_INFO_SCALE) |
> +			      BIT(IIO_CHAN_INFO_OFFSET) |
> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE) |
> +					BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.ext_info =3D ad4130_filter_mode_ext_info,
> +	.scan_type =3D {
> +		.sign =3D 'u',
> +		.endianness =3D IIO_BE,
> +	},
> +};
> +
> +static int ad4130_set_channel_pga(struct ad4130_state *st, unsigned int =
channel,
> +				  int val, int val2)
> +{
> +	struct ad4130_chan_info *chan_info =3D &st->chans_info[channel];
> +	struct ad4130_setup_info *setup_info =3D &chan_info->setup;
> +	unsigned int pga, old_pga;
> +	int ret =3D 0;
> +
> +	for (pga =3D 0; pga < AD4130_MAX_PGA; pga++)
> +		if (val =3D=3D st->scale_tbls[setup_info->ref_sel][pga][0] &&
> +		    val2 =3D=3D st->scale_tbls[setup_info->ref_sel][pga][1])
> +			break;
> +
> +	if (pga =3D=3D AD4130_MAX_PGA)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
> +	if (pga =3D=3D setup_info->pga)
> +		goto out;
> +
> +	old_pga =3D setup_info->pga;
> +	setup_info->pga =3D pga;
> +
> +	ret =3D ad4130_write_channel_setup(st, channel, false);
> +	if (ret)
> +		setup_info->pga =3D old_pga;
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int ad4130_set_channel_freq(struct ad4130_state *st,
> +				   unsigned int channel, int val, int val2)
> +{
> +	struct ad4130_chan_info *chan_info =3D &st->chans_info[channel];
> +	struct ad4130_setup_info *setup_info =3D &chan_info->setup;
> +	unsigned int fs, old_fs;
> +	int ret =3D 0;
> +
> +	mutex_lock(&st->lock);
> +	old_fs =3D setup_info->fs;
> +
> +	ad4130_freq_to_fs(setup_info->filter_mode, val, val2, &fs);
> +
> +	if (fs =3D=3D setup_info->fs)
> +		goto out;
> +
> +	setup_info->fs =3D fs;
> +
> +	ret =3D ad4130_write_channel_setup(st, channel, false);
> +	if (ret)
> +		setup_info->fs =3D old_fs;
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int _ad4130_read_sample(struct iio_dev *indio_dev, unsigned int c=
hannel,
> +			       int *val)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D ad4130_set_channel_enable(st, channel, true);
> +	if (ret)
> +		return ret;
> +
> +	reinit_completion(&st->completion);
> +
> +	ret =3D ad4130_set_mode(st, AD4130_MODE_CONTINUOUS);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D wait_for_completion_timeout(&st->completion,
> +					  msecs_to_jiffies(1000));
> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	ret =3D ad4130_set_mode(st, AD4130_MODE_IDLE);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4130_DATA_REG, val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4130_set_channel_enable(st, channel, false);
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad4130_read_sample(struct iio_dev *indio_dev, unsigned int ch=
annel,
> +			      int *val)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&st->lock);
> +	ret =3D _ad4130_read_sample(indio_dev, channel, val);
> +	mutex_unlock(&st->lock);
> +
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int ad4130_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	unsigned int channel =3D chan->scan_index;
> +	struct ad4130_setup_info *setup_info =3D &st->chans_info[channel].setup;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		return ad4130_read_sample(indio_dev, channel, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		mutex_lock(&st->lock);
> +		*val =3D st->scale_tbls[setup_info->ref_sel][setup_info->pga][0];
> +		*val2 =3D st->scale_tbls[setup_info->ref_sel][setup_info->pga][1];
> +		mutex_unlock(&st->lock);
> +
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D st->bipolar ? -BIT(chan->scan_type.realbits - 1) : 0;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&st->lock);
> +		ad4130_fs_to_freq(setup_info->filter_mode, setup_info->fs,
> +				  val, val2);
> +		mutex_unlock(&st->lock);
> +
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4130_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	unsigned int channel =3D chan->scan_index;
> +	struct ad4130_setup_info *setup_info =3D &st->chans_info[channel].setup;
> +	const struct ad4130_filter_config *filter_config;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals =3D (int *)st->scale_tbls[setup_info->ref_sel];
> +		*length =3D ARRAY_SIZE(st->scale_tbls[setup_info->ref_sel]) * 2;
> +
> +		*type =3D IIO_VAL_INT_PLUS_NANO;
> +
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&st->lock);
> +		filter_config =3D &ad4130_filter_configs[setup_info->filter_mode];
> +		mutex_unlock(&st->lock);
> +
> +		*vals =3D (int *)filter_config->samp_freq_avail;
> +		*length =3D filter_config->samp_freq_avail_len * 2;
> +		*type =3D IIO_VAL_FRACTIONAL;
> +
> +		return filter_config->samp_freq_avail_type;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4130_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan,
> +				    long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4130_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	unsigned int channel =3D chan->scan_index;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4130_set_channel_pga(st, channel, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4130_set_channel_freq(st, channel, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4130_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static int ad4130_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	unsigned int channel;
> +	unsigned int val =3D 0;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	for_each_set_bit(channel, scan_mask, indio_dev->num_channels) {
> +		ret =3D ad4130_set_channel_enable(st, channel, true);
> +		if (ret)
> +			goto out;
> +
> +		val++;
> +	}
> +
> +	st->num_enabled_channels =3D val;
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return 0;
> +}
> +
> +static int ad4130_set_fifo_watermark(struct iio_dev *indio_dev, unsigned=
 int val)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	unsigned int eff;
> +	int ret;
> +
> +	if (val > AD4130_FIFO_SIZE)
> +		return -EINVAL;
> +
> +	eff =3D val * st->num_enabled_channels;
> +	if (eff > AD4130_FIFO_SIZE)
> +		/*
> +		 * Always set watermark to a multiple of the number of
> +		 * enabled channels to avoid making the FIFO unaligned.
> +		 */
> +		eff =3D rounddown(AD4130_FIFO_SIZE, st->num_enabled_channels);
> +
> +	mutex_lock(&st->lock);
> +
> +	ret =3D regmap_update_bits(st->regmap, AD4130_FIFO_CONTROL_REG,
> +				 AD4130_FIFO_CONTROL_WM_MASK,
> +				 FIELD_PREP(AD4130_FIFO_CONTROL_WM_MASK,
> +					    ad4130_watermark_reg_val(eff)));
> +	if (ret)
> +		goto out;
> +
> +	st->effective_watermark =3D eff;
> +	st->watermark =3D val;
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info ad4130_info =3D {
> +	.read_raw =3D ad4130_read_raw,
> +	.read_avail =3D ad4130_read_avail,
> +	.write_raw_get_fmt =3D ad4130_write_raw_get_fmt,
> +	.write_raw =3D ad4130_write_raw,
> +	.update_scan_mode =3D ad4130_update_scan_mode,
> +	.hwfifo_set_watermark =3D ad4130_set_fifo_watermark,
> +	.debugfs_reg_access =3D ad4130_reg_access,
> +};
> +
> +static int ad4130_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret =3D ad4130_set_watermark_interrupt_en(st, true);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D irq_set_irq_type(st->spi->irq, st->inv_irq_trigger);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D ad4130_set_fifo_mode(st, AD4130_FIFO_MODE_WM);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D ad4130_set_mode(st, AD4130_MODE_CONTINUOUS);
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int ad4130_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	unsigned int i;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret =3D ad4130_set_mode(st, AD4130_MODE_IDLE);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D irq_set_irq_type(st->spi->irq, st->irq_trigger);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D ad4130_set_fifo_mode(st, AD4130_FIFO_MODE_DISABLED);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D ad4130_set_watermark_interrupt_en(st, false);
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * update_scan_mode() is not called in the disable path, disable all
> +	 * channels here.
> +	 */
> +	for (i =3D 0; i < indio_dev->num_channels; i++) {
> +		ret =3D ad4130_set_channel_enable(st, i, false);
> +		if (ret)
> +			goto out;
> +	}
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops ad4130_buffer_ops =3D {
> +	.postenable =3D ad4130_buffer_postenable,
> +	.predisable =3D ad4130_buffer_predisable,
> +};
> +
> +static ssize_t hwfifo_watermark_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct ad4130_state *st =3D iio_priv(dev_to_iio_dev(dev));
> +	unsigned int val;
> +
> +	mutex_lock(&st->lock);
> +	val =3D st->watermark;
> +	mutex_unlock(&st->lock);
> +
> +	return sysfs_emit(buf, "%d\n", val);
> +}
> +
> +static ssize_t hwfifo_enabled_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct ad4130_state *st =3D iio_priv(dev_to_iio_dev(dev));
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4130_FIFO_CONTROL_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	val =3D FIELD_GET(AD4130_FIFO_CONTROL_MODE_MASK, val);
> +
> +	return sysfs_emit(buf, "%d\n", val !=3D AD4130_FIFO_MODE_DISABLED);
> +}
> +
> +static ssize_t hwfifo_watermark_min_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", "1");
> +}
> +
> +static ssize_t hwfifo_watermark_max_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", __stringify(AD4130_FIFO_SIZE));
> +}
> +
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);
> +static IIO_DEVICE_ATTR_RO(hwfifo_enabled, 0);
> +
> +static const struct attribute *ad4130_fifo_attributes[] =3D {
> +	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> +	NULL
> +};
> +
> +static int _ad4130_find_table_index(const unsigned int *tbl, size_t len,
> +				    unsigned int val)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < len; i++)
> +		if (tbl[i] =3D=3D val)
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
> +#define ad4130_find_table_index(table, val) \
> +	_ad4130_find_table_index(table, ARRAY_SIZE(table), val)
> +
> +static int ad4130_get_ref_voltage(struct ad4130_state *st,
> +				  enum ad4130_ref_sel ref_sel)
> +{
> +	switch (ref_sel) {
> +	case AD4130_REF_REFIN1:
> +		return regulator_get_voltage(st->regulators[2].consumer);
> +	case AD4130_REF_REFIN2:
> +		return regulator_get_voltage(st->regulators[3].consumer);
> +	case AD4130_REF_AVDD_AVSS:
> +		return regulator_get_voltage(st->regulators[0].consumer);
> +	case AD4130_REF_REFOUT_AVSS:
> +		return st->int_ref_uv;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4130_parse_fw_setup(struct ad4130_state *st,
> +				 struct fwnode_handle *child,
> +				 struct ad4130_setup_info *setup_info)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	u32 tmp;
> +	int ret;
> +
> +	tmp =3D 0;
> +	fwnode_property_read_u32(child, "adi,excitation-current-0-nanoamp", &tm=
p);
> +	ret =3D ad4130_find_table_index(ad4130_iout_current_na_tbl, tmp);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Invalid excitation current %unA\n", tmp);
> +	setup_info->iout0_val =3D ret;
> +
> +	tmp =3D 0;
> +	fwnode_property_read_u32(child, "adi,excitation-current-1-nanoamp", &tm=
p);
> +	ret =3D ad4130_find_table_index(ad4130_iout_current_na_tbl, tmp);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Invalid excitation current %unA\n", tmp);
> +	setup_info->iout1_val =3D ret;
> +
> +	tmp =3D 0;
> +	fwnode_property_read_u32(child, "adi,burnout-current-nanoamp", &tmp);
> +	ret =3D ad4130_find_table_index(ad4130_burnout_current_na_tbl, tmp);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Invalid burnout current %unA\n", tmp);
> +	setup_info->burnout =3D ret;
> +
> +	setup_info->ref_bufp =3D fwnode_property_read_bool(child, "adi,buffered=
-positive");
> +	setup_info->ref_bufm =3D fwnode_property_read_bool(child, "adi,buffered=
-negative");
> +
> +	setup_info->ref_sel =3D AD4130_REF_REFIN1;
> +	fwnode_property_read_u32(child, "adi,reference-select",
> +				 &setup_info->ref_sel);
> +	if (setup_info->ref_sel >=3D AD4130_REF_SEL_MAX)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid reference selected %u\n",
> +				     setup_info->ref_sel);
> +
> +	if (setup_info->ref_sel =3D=3D AD4130_REF_REFOUT_AVSS)
> +		st->int_ref_en =3D true;
> +
> +	ret =3D ad4130_get_ref_voltage(st, setup_info->ref_sel);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Cannot use reference %u\n",
> +				     setup_info->ref_sel);
> +
> +	return 0;
> +}
> +
> +static int ad4130_validate_diff_channel(struct ad4130_state *st, u32 pin)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +
> +	if (pin >=3D AD4130_MAX_DIFF_INPUTS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid diffreential channel %u\n", pin);
> +
> +	if (pin >=3D AD4130_MAX_ANALOG_PINS)
> +		return 0;
> +
> +	if (st->pins_fn[pin] =3D=3D AD4130_PIN_FN_SPECIAL)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Pin %u already used with fn %u\n", pin,
> +				     st->pins_fn[pin]);
> +
> +	st->pins_fn[pin] |=3D AD4130_PIN_FN_DIFF;
> +
> +	return 0;
> +}
> +
> +static int ad4130_validate_diff_channels(struct ad4130_state *st,
> +					 u32 *pins, unsigned int len)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i =3D 0; i < len; i++) {
> +		ret =3D ad4130_validate_diff_channel(st, pins[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4130_validate_excitation_pin(struct ad4130_state *st, u32 p=
in)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +
> +	if (pin >=3D AD4130_MAX_ANALOG_PINS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid excitation pin %u\n", pin);
> +
> +	if (st->pins_fn[pin] =3D=3D AD4130_PIN_FN_SPECIAL)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Pin %u already used with fn %u\n", pin,
> +				     st->pins_fn[pin]);
> +
> +	st->pins_fn[pin] |=3D AD4130_PIN_FN_EXCITATION;
> +
> +	return 0;
> +}
> +
> +static int ad4130_validate_vbias_pin(struct ad4130_state *st, u32 pin)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +
> +	if (pin >=3D AD4130_MAX_ANALOG_PINS)
> +		return dev_err_probe(dev, -EINVAL, "Invalid vbias pin %u\n",
> +				     pin);
> +
> +	if (st->pins_fn[pin] =3D=3D AD4130_PIN_FN_SPECIAL)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Pin %u already used with fn %u\n", pin,
> +				     st->pins_fn[pin]);
> +
> +	st->pins_fn[pin] |=3D AD4130_PIN_FN_VBIAS;
> +
> +	return 0;
> +}
> +
> +static int ad4130_validate_vbias_pins(struct ad4130_state *st,
> +				      u32 *pins, unsigned int len)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i =3D 0; i < st->num_vbias_pins; i++) {
> +		ret =3D ad4130_validate_vbias_pin(st, pins[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4130_parse_fw_channel(struct iio_dev *indio_dev,
> +				   struct fwnode_handle *child)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	unsigned int resolution =3D ad4130_resolution(st);
> +	unsigned int index =3D indio_dev->num_channels++;
> +	struct device *dev =3D &st->spi->dev;
> +	struct ad4130_chan_info *chan_info;
> +	struct iio_chan_spec *chan;
> +	u32 pins[2];
> +	int ret;
> +
> +	if (index >=3D AD4130_MAX_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
> +
> +	chan =3D &st->chans[index];
> +	chan_info =3D &st->chans_info[index];
> +
> +	*chan =3D ad4130_channel_template;
> +	chan->scan_type.realbits =3D resolution;
> +	chan->scan_type.storagebits =3D resolution;
> +	chan->scan_index =3D index;
> +
> +	chan_info->slot =3D AD4130_INVALID_SLOT;
> +	chan_info->setup.fs =3D AD4130_FILTER_SELECT_MIN;
> +	chan_info->initialized =3D true;
> +
> +	ret =3D fwnode_property_read_u32_array(child, "diff-channels", pins,
> +					     ARRAY_SIZE(pins));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4130_validate_diff_channels(st, pins, ARRAY_SIZE(pins));
> +	if (ret)
> +		return ret;
> +
> +	chan->channel =3D pins[0];
> +	chan->channel2 =3D pins[1];
> +
> +	ret =3D ad4130_parse_fw_setup(st, child, &chan_info->setup);
> +	if (ret)
> +		return ret;
> +
> +	fwnode_property_read_u32(child, "adi,excitation-pin-0",
> +				 &chan_info->iout0);
> +	if (chan_info->setup.iout0_val !=3D AD4130_IOUT_OFF) {
> +		ret =3D ad4130_validate_excitation_pin(st, chan_info->iout0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	fwnode_property_read_u32(child, "adi,excitation-pin-1",
> +				 &chan_info->iout1);
> +	if (chan_info->setup.iout1_val !=3D AD4130_IOUT_OFF) {
> +		ret =3D ad4130_validate_excitation_pin(st, chan_info->iout1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4130_parse_fw_children(struct iio_dev *indio_dev)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &st->spi->dev;
> +	struct fwnode_handle *child;
> +	int ret;
> +
> +	indio_dev->channels =3D st->chans;
> +
> +	device_for_each_child_node(dev, child) {
> +		ret =3D ad4130_parse_fw_channel(indio_dev, child);
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4310_parse_fw(struct iio_dev *indio_dev)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &st->spi->dev;
> +	u32 ext_clk_freq =3D AD4130_MCLK_FREQ_76_8KHZ;
> +	unsigned int i;
> +	int avdd_uv;
> +	int irq;
> +	int ret;
> +
> +	st->mclk =3D devm_clk_get_optional(dev, "mclk");
> +	if (IS_ERR(st->mclk))
> +		return dev_err_probe(dev, PTR_ERR(st->mclk),
> +				     "Failed to get mclk\n");
> +
> +	st->int_pin_sel =3D AD4130_INT_PIN_INT;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ad4130_int_pin_names); i++) {
> +		irq =3D fwnode_irq_get_byname(dev_fwnode(dev),
> +					    ad4130_int_pin_names[i]);
> +		if (irq > 0) {
> +			st->int_pin_sel =3D i;
> +			break;
> +		}
> +	}
> +
> +	if (st->int_pin_sel =3D=3D AD4130_INT_PIN_DOUT)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Cannot use DOUT as interrupt pin\n");
> +
> +	if (st->int_pin_sel =3D=3D AD4130_INT_PIN_P2)
> +		st->pins_fn[AD4130_AIN3_P2] =3D AD4130_PIN_FN_SPECIAL;
> +
> +	device_property_read_u32(dev, "adi,ext-clk-freq-hz", &ext_clk_freq);
> +	if (ext_clk_freq !=3D AD4130_MCLK_FREQ_153_6KHZ &&
> +	    ext_clk_freq !=3D AD4130_MCLK_FREQ_76_8KHZ)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid external clock frequency %u\n",
> +				     ext_clk_freq);
> +
> +	if (st->mclk && ext_clk_freq =3D=3D AD4130_MCLK_FREQ_153_6KHZ)
> +		st->mclk_sel =3D AD4130_MCLK_153_6KHZ_EXT;
> +	else if (st->mclk)
> +		st->mclk_sel =3D AD4130_MCLK_76_8KHZ_EXT;
> +	else
> +		st->mclk_sel =3D AD4130_MCLK_76_8KHZ;
> +
> +	if (st->int_pin_sel =3D=3D AD4130_INT_PIN_CLK &&
> +	    st->mclk_sel !=3D AD4130_MCLK_76_8KHZ)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid clock %u for interrupt pin %u\n",
> +				     st->mclk_sel, st->int_pin_sel);
> +
> +	st->int_ref_uv =3D AD4130_INT_REF_2_5V;
> +
> +	/*
> +	 * When the AVDD supply is set to below 2.5V the internal reference of
> +	 * 1.25V should be selected.
> +	 * See datasheet page 37, section ADC REFERENCE.
> +	 */
> +	avdd_uv =3D regulator_get_voltage(st->regulators[0].consumer);
> +	if (avdd_uv > 0 && avdd_uv < AD4130_INT_REF_2_5V)
> +		st->int_ref_uv =3D AD4130_INT_REF_1_25V;
> +
> +	st->bipolar =3D device_property_read_bool(dev, "adi,bipolar");
> +
> +	ret =3D device_property_count_u32(dev, "adi,vbias-pins");
> +	if (ret > 0) {
> +		if (ret > AD4130_MAX_ANALOG_PINS)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Too many vbias pins %u\n", ret);
> +
> +		st->num_vbias_pins =3D ret;
> +
> +		ret =3D device_property_read_u32_array(dev, "adi,vbias-pins",
> +						     st->vbias_pins,
> +						     st->num_vbias_pins);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to read vbias pins\n");
> +
> +		ret =3D ad4130_validate_vbias_pins(st, st->vbias_pins,
> +						 st->num_vbias_pins);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D ad4130_parse_fw_children(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void ad4130_fill_scale_tbls(struct ad4130_state *st)
> +{
> +	unsigned int pow =3D ad4130_resolution(st) - st->bipolar;
> +	unsigned int i, j;
> +
> +	for (i =3D 0; i < AD4130_REF_SEL_MAX; i++) {
> +		int ret;
> +		u64 nv;
> +
> +		ret =3D ad4130_get_ref_voltage(st, i);
> +		if (ret < 0)
> +			continue;
> +
> +		nv =3D (u64)ret * NANO;
> +
> +		for (j =3D 0; j < AD4130_MAX_PGA; j++)
> +			st->scale_tbls[i][j][1] =3D div_u64(nv >> (pow + j), MILLI);
> +	}
> +}
> +
> +static void ad4130_clk_disable_unprepare(void *clk)
> +{
> +	clk_disable_unprepare(clk);
> +}
> +
> +static int ad4130_set_mclk_sel(struct ad4130_state *st,
> +			       enum ad4130_mclk_sel mclk_sel)
> +{
> +	return regmap_update_bits(st->regmap, AD4130_ADC_CONTROL_REG,
> +				 AD4130_ADC_CONTROL_MCLK_SEL_MASK,
> +				 FIELD_PREP(AD4130_ADC_CONTROL_MCLK_SEL_MASK,
> +					    mclk_sel));
> +}
> +
> +static unsigned long ad4130_int_clk_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	return AD4130_MCLK_FREQ_76_8KHZ;
> +}
> +
> +static int ad4130_int_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct ad4130_state *st =3D container_of(hw, struct ad4130_state, int_c=
lk_hw);
> +
> +	return st->mclk_sel =3D=3D AD4130_MCLK_76_8KHZ_OUT;
> +}
> +
> +static int ad4130_int_clk_prepare(struct clk_hw *hw)
> +{
> +	struct ad4130_state *st =3D container_of(hw, struct ad4130_state, int_c=
lk_hw);
> +	int ret;
> +
> +	ret =3D ad4130_set_mclk_sel(st, AD4130_MCLK_76_8KHZ_OUT);
> +	if (ret)
> +		return ret;
> +
> +	st->mclk_sel =3D AD4130_MCLK_76_8KHZ_OUT;
> +
> +	return 0;
> +}
> +
> +static void ad4130_int_clk_unprepare(struct clk_hw *hw)
> +{
> +	struct ad4130_state *st =3D container_of(hw, struct ad4130_state, int_c=
lk_hw);
> +	int ret;
> +
> +	ret =3D ad4130_set_mclk_sel(st, AD4130_MCLK_76_8KHZ);
> +	if (ret)
> +		return;
> +
> +	st->mclk_sel =3D AD4130_MCLK_76_8KHZ;
> +}
> +
> +static const struct clk_ops ad4130_int_clk_ops =3D {
> +	.recalc_rate =3D ad4130_int_clk_recalc_rate,
> +	.is_enabled =3D ad4130_int_clk_is_enabled,
> +	.prepare =3D ad4130_int_clk_prepare,
> +	.unprepare =3D ad4130_int_clk_unprepare,
> +};
> +
> +static int ad4130_setup_int_clk(struct ad4130_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	struct device_node *of_node =3D dev_of_node(dev);
> +	struct clk_init_data init;
> +	const char *clk_name;
> +	struct clk *clk;
> +
> +	if (st->int_pin_sel =3D=3D AD4130_INT_PIN_CLK ||
> +	    st->mclk_sel !=3D AD4130_MCLK_76_8KHZ)
> +		return 0;
> +
> +	if (!of_node)
> +		return 0;
> +
> +	clk_name =3D of_node->name;
> +	of_property_read_string(of_node, "clock-output-names", &clk_name);
> +
> +	init.name =3D clk_name;
> +	init.ops =3D &ad4130_int_clk_ops;
> +
> +	st->int_clk_hw.init =3D &init;
> +	clk =3D devm_clk_register(dev, &st->int_clk_hw);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	return of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
> +}
> +
> +static int ad4130_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &st->spi->dev;
> +	unsigned int int_ref_val;
> +	unsigned long rate =3D AD4130_MCLK_FREQ_76_8KHZ;
> +	unsigned int val;
> +	unsigned int i;
> +	int ret;
> +
> +	if (st->mclk_sel =3D=3D AD4130_MCLK_153_6KHZ_EXT)
> +		rate =3D AD4130_MCLK_FREQ_153_6KHZ;
> +
> +	ret =3D clk_set_rate(st->mclk, rate);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D clk_prepare_enable(st->mclk);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev, ad4130_clk_disable_unprepare,
> +				       st->mclk);
> +	if (ret)
> +		return ret;
> +
> +	if (st->int_ref_uv =3D=3D AD4130_INT_REF_2_5V)
> +		int_ref_val =3D AD4130_INT_REF_VAL_2_5V;
> +	else
> +		int_ref_val =3D AD4130_INT_REF_VAL_1_25V;
> +
> +	/* Switch to SPI 4-wire mode. */
> +	val =3D  FIELD_PREP(AD4130_ADC_CONTROL_CSB_EN_MASK, 1);
> +	val |=3D FIELD_PREP(AD4130_ADC_CONTROL_BIPOLAR_MASK, st->bipolar);
> +	val |=3D FIELD_PREP(AD4130_ADC_CONTROL_INT_REF_EN_MASK, st->int_ref_en);
> +	val |=3D FIELD_PREP(AD4130_ADC_CONTROL_MODE_MASK, AD4130_MODE_IDLE);
> +	val |=3D FIELD_PREP(AD4130_ADC_CONTROL_MCLK_SEL_MASK, st->mclk_sel);
> +	val |=3D FIELD_PREP(AD4130_ADC_CONTROL_INT_REF_VAL_MASK, int_ref_val);
> +
> +	ret =3D regmap_write(st->regmap, AD4130_ADC_CONTROL_REG, val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure all GPIOs for output. If configured, the interrupt function
> +	 * of P2 takes priority over the GPIO out function.
> +	 */
> +	val =3D  AD4130_IO_CONTROL_GPIO_CTRL_MASK;
> +	val |=3D FIELD_PREP(AD4130_IO_CONTROL_INT_PIN_SEL_MASK, st->int_pin_sel=
);
> +
> +	ret =3D regmap_write(st->regmap, AD4130_IO_CONTROL_REG, val);
> +	if (ret)
> +		return ret;
> +
> +	val =3D 0;
> +	for (i =3D 0; i < st->num_vbias_pins; i++)
> +		val |=3D BIT(st->vbias_pins[i]);
> +
> +	ret =3D regmap_write(st->regmap, AD4130_VBIAS_REG, val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, AD4130_FIFO_CONTROL_REG,
> +				 AD4130_FIFO_CONTROL_HEADER_MASK, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* FIFO watermark interrupt starts out as enabled, disable it. */
> +	ret =3D ad4130_set_watermark_interrupt_en(st, false);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup channels. */
> +	for (i =3D 0; i < indio_dev->num_channels; i++) {
> +		struct ad4130_chan_info *chan_info =3D &st->chans_info[i];
> +		struct iio_chan_spec *chan =3D &st->chans[i];
> +		unsigned int val;
> +
> +		val =3D FIELD_PREP(AD4130_CHANNEL_AINP_MASK, chan->channel) |
> +		      FIELD_PREP(AD4130_CHANNEL_AINM_MASK, chan->channel2) |
> +		      FIELD_PREP(AD4130_CHANNEL_IOUT1_MASK, chan_info->iout0) |
> +		      FIELD_PREP(AD4130_CHANNEL_IOUT2_MASK, chan_info->iout1);
> +
> +		ret =3D regmap_write(st->regmap, AD4130_CHANNEL_X_REG(i), val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4130_soft_reset(struct ad4130_state *st)
> +{
> +	int ret;
> +
> +	ret =3D spi_write(st->spi, st->reset_buf, sizeof(st->reset_buf));
> +	if (ret)
> +		return ret;
> +
> +	fsleep(AD4130_RESET_SLEEP_US);
> +
> +	return 0;
> +}
> +
> +static void ad4130_disable_regulators(void *data)
> +{
> +	struct ad4130_state *st =3D data;
> +
> +	regulator_bulk_disable(ARRAY_SIZE(st->regulators), st->regulators);
> +}
> +
> +static int ad4130_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4130_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	memset(st->reset_buf, 0xff, sizeof(st->reset_buf));
> +	init_completion(&st->completion);
> +	mutex_init(&st->lock);
> +	st->spi =3D spi;
> +
> +	/*
> +	 * Xfer:   [ XFR1 ] [         XFR2         ]
> +	 * Master:  0x7D N   ......................
> +	 * Slave:   ......   DATA1 DATA2 ... DATAN
> +	 */
> +	st->fifo_tx_buf[0] =3D AD4130_COMMS_READ_MASK | AD4130_FIFO_DATA_REG;
> +	st->fifo_xfer[0].tx_buf =3D st->fifo_tx_buf;
> +	st->fifo_xfer[0].len =3D sizeof(st->fifo_tx_buf);
> +	st->fifo_xfer[1].rx_buf =3D st->fifo_rx_buf;
> +	spi_message_init_with_transfers(&st->fifo_msg, st->fifo_xfer,
> +					ARRAY_SIZE(st->fifo_xfer));
> +
> +	indio_dev->name =3D AD4130_NAME;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &ad4130_info;
> +
> +	st->regmap =3D devm_regmap_init(dev, NULL, st, &ad4130_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	st->regulators[0].supply =3D "avdd";
> +	st->regulators[1].supply =3D "iovdd";
> +	st->regulators[2].supply =3D "refin1";
> +	st->regulators[3].supply =3D "refin2";
> +
> +	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
> +				      st->regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	ret =3D regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulator=
s);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, ad4130_disable_regulators, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to add regulators disable action\n");
> +
> +	ret =3D ad4130_soft_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4310_parse_fw(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4130_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4130_setup_int_clk(st);
> +	if (ret)
> +		return ret;
> +
> +	ad4130_fill_scale_tbls(st);
> +
> +	st->gc.owner =3D THIS_MODULE;
> +	st->gc.label =3D AD4130_NAME;
> +	st->gc.base =3D -1;
> +	st->gc.ngpio =3D AD4130_MAX_GPIOS;
> +	st->gc.parent =3D dev;
> +	st->gc.can_sleep =3D true;
> +	st->gc.init_valid_mask =3D ad4130_gpio_init_valid_mask;
> +	st->gc.get_direction =3D ad4130_gpio_get_direction;
> +	st->gc.set =3D ad4130_gpio_set;
> +
> +	ret =3D devm_gpiochip_add_data(dev, &st->gc, st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
> +					      &ad4130_buffer_ops,
> +					      ad4130_fifo_attributes);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_request_threaded_irq(dev, spi->irq, NULL,
> +					ad4130_irq_handler, IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request irq\n");
> +
> +	/*
> +	 * When the chip enters FIFO mode, IRQ polarity is inverted.
> +	 * When the chip exits FIFO mode, IRQ polarity returns to normal.
> +	 * See datasheet pages: 65, FIFO Watermark Interrupt section,
> +	 * and 71, Bit Descriptions for STATUS Register, RDYB.
> +	 * Cache the normal and inverted IRQ triggers to set them when
> +	 * entering and exiting FIFO mode.
> +	 */
> +	st->irq_trigger =3D irq_get_trigger_type(spi->irq);
> +	if (st->irq_trigger & IRQF_TRIGGER_RISING)
> +		st->inv_irq_trigger =3D IRQF_TRIGGER_FALLING;
> +	else if (st->irq_trigger & IRQF_TRIGGER_FALLING)
> +		st->inv_irq_trigger =3D IRQF_TRIGGER_RISING;
> +	else
> +		return dev_err_probe(dev, -EINVAL, "Invalid irq flags: %u\n",
> +				     st->irq_trigger);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad4130_of_match[] =3D {
> +	{
> +		.compatible =3D "adi,ad4130",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad4130_of_match);
> +
> +static struct spi_driver ad4130_driver =3D {
> +	.driver =3D {
> +		.name =3D AD4130_NAME,
> +		.of_match_table =3D ad4130_of_match,
> +	},
> +	.probe =3D ad4130_probe,
> +};
> +module_spi_driver(ad4130_driver);
> +
> +MODULE_AUTHOR("Cosmin Tanislav <cosmin.tanislav@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD4130 SPI driver");
> +MODULE_LICENSE("GPL");

