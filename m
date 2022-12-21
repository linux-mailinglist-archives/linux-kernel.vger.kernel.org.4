Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D88653125
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiLUM5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiLUM46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:56:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDFA22BC3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:56:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 377A4617A5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48C9C433EF;
        Wed, 21 Dec 2022 12:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671627416;
        bh=QYUPrh0xRHefZnfrGY5wAxRVNz8ZP8GkZAyaS+vKipU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pxS5anZXA8oCYW67bGhLjpNJ344zEygIzHug/YgEZAocqgZAPo/skVCS6cAiiYkKC
         ECY4karUFQlPijBV47af4L3jRLYhAn7P1aI1cQW2mSv1fuXGU9Onbc+V+FAuKkiaty
         /byEaNqjHuB0pa5RaGzW2SnTrxriz9i/fd2sP5af1FylkilcPXMJNcThOWR0jwPnX4
         nLOqtp2zhLbRkDm0s03KmLbw4Va3iyEB0ja5f6/j41MnqGKOxaQ9VA7nXzw1Q5/bC7
         PKsqhzxq7jaPZStSRyAxBPdZikVTkU28oUxRc1jO5TekC4+shCq6gTkA83rYv3HOWd
         Yatktf/kBZKGg==
Date:   Wed, 21 Dec 2022 12:56:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Lu <luminlong@139.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        shenghao-ding@ti.com, kevin-lu@ti.com, navada@ti.com,
        peeyush@ti.com
Subject: Re: [PATCH v1] ALSA SoC: Texas Instruments TAS2781 Audio Smart Amp
Message-ID: <Y6MCkZb3ooOuqLYN@sirena.org.uk>
References: <20221220151157.2247-1-luminlong@139.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GA5+8HlyMrJr9eG/"
Content-Disposition: inline
In-Reply-To: <20221220151157.2247-1-luminlong@139.com>
X-Cookie: Programming is an unnatural act.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GA5+8HlyMrJr9eG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 20, 2022 at 11:11:57PM +0800, Kevin Lu wrote:

> The TAS2781 driver implements a flexible and configurable register setting
> for one, two, even multiple TAS2781 chips. All the register setting are in
> a bin file. Almost no specific register setting can be found in the code.

This driver needs a very substantial rework to fit within the relevant
kernel frameworks, even from a coding style level it's clearly not well
integrated kernel code and the integration with several kernel
frameworks all look to need rework.

> +++ b/sound/soc/codecs/tas2781-dsp.c
> @@ -0,0 +1,2483 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier

Please make the entire comment a C++ one so things look more
intentional.

> + * Copyright (C) 2022 - 2023 Texas Instruments Incorporated
> + * https://www.ti.com

Given that it's still 2022 I rather doubt the 2023 copyright, though I
guess we'll see some changes in 2023...

> + * The TAS2781 driver implements a flexible and configurable register setting
> + * for one, two, even multiple TAS2781 chips. All the register setting are in
> + * a bin file. Almost no specific register setting can be found in the code.

This isn't how we generally do drivers in Linux, we expect the device
settings to be controlled via the ALSA userspace and kernel APIs.
Downloadable firmwares are of course OK, and there are things like
coefficient data which are naturally binary data, but normal device
control should be done via the standard interfaces.  Some of this does
look like it might fit with firmware stuff but I'm not clear that it's
all of it and the code generally doesn't look like it's trying very hard
to fit within the standard kernel frameworks.

Given this I've not read too far into the driver, just skimmed it.

> +#define TAS2781_CAL_BIN_PATH	("/lib/firmware/")

Let request_firmware() figure this out.

> +struct TYCRC {

> +const unsigned int BinFileformatVerInfo[][2] = {

> +static int fw_parse_block_data_kernel(struct TFirmware *pFirmware,
> +	struct TBlock *pBlock, const struct firmware *pFW, int offset)

Please follow the kernel coding style for naming things, this makes it
quite hard to read a lot of the code.

> +static const unsigned char crc8_lookup_table[CRC8_TABLE_SIZE] = {
> +	0x00, 0x4D, 0x9A, 0xD7, 0x79, 0x34, 0xE3, 0xAE,

We have lib/crc8.c.

> +static const struct i2c_device_id tasdevice_id[] = {
> +	{ "audev", GENERAL_AUDEV },

audev?

> +static bool tasdevice_volatile(struct device *dev, unsigned int reg)
> +{
> +	return true;
> +}
> +
> +static bool tasdevice_writeable(struct device *dev, unsigned int reg)
> +{
> +	return true;
> +}

These are pointless, remove them.

> +static const struct regmap_config tasdevice_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.writeable_reg = tasdevice_writeable,
> +	.volatile_reg = tasdevice_volatile,
> +	.cache_type = REGCACHE_FLAT,
> +	.max_register = 1 * 128,
> +};

Given that the device has pages and books which aren't modelled here I
can't see how a cache is going to work well, though since the driver
marks every register as volatile it'll never do anything.

> +static const struct of_device_id tasdevice_of_match[] = {
> +	{ .compatible = "ti,audev" },
> +	{ .compatible = "ti,tas2781" },
> +	{},
> +};

This is adding a DT binding, the DT binding must be documented but is
not.

> +static int tas2781_digital_getvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{

This is just a straightforward register read, I don't see why it's not
using the standard helpers.

> +	if (tas_dev->tas2781_set_global != NULL) {
> +		ret = tasdevice_dev_write(tas_dev, tas_dev->ndev,
> +			mc->reg, val);
> +		if (ret)
> +			dev_err(tas_dev->dev,
> +			"%s, set digital vol error in global mode\n",
> +			__func__);
> +	} else {
> +		for (i = 0; i < tas_dev->ndev; i++) {

This appears to be trying to open code some mechanism for tying
multiple devices together.  Don't do that, if that feature is needed
implement it at the framework level rather than trying to open code it
in the driver.

The function is also failing to generate events, running mixer-test on a
card with the device included should show this and potentially other
issues.

> +static int tasdevice_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)

This doesn't actually appear to interact with the device which means it
won't actually do anything.  This is a problem with a lot of the
callbacks.

> +static void tasdevice_enable_irq(
> +	struct tasdevice_priv *tas_dev, bool enable)
> +{
> +	struct irq_desc *desc = NULL;
> +
> +	if (enable) {
> +		if (tas_dev->mIrqInfo.mb_irq_enable)
> +			return;
> +		if (gpio_is_valid(tas_dev->mIrqInfo.mn_irq_gpio)) {
> +			desc = irq_to_desc(tas_dev->mIrqInfo.mn_irq);
> +			if (desc && desc->depth > 0)
> +				enable_irq(tas_dev->mIrqInfo.mn_irq);
> +			else

Drivers really shouldn't be peering inside irq descriptors, if you need
to do this it generally indicates that whatever is done is a bad idea.

> +				dev_info(tas_dev->dev,
> +					"### irq already enabled\n");

Please don't spam the logs in normal operation, this is a problem
throughout the driver.

> +static int tasdevice_mute(struct snd_soc_dai *dai, int mute, int stream)
> +{

> +	tasdevice_set_power_state(tas_dev, mute);

mute is not a power management function, it should mute and unmute only.
Power managment should be integrated with DAPM.

> +static irqreturn_t tasdevice_irq_handler(int irq,
> +	void *dev_id)
> +{
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *)dev_id;
> +;
> +	/* get IRQ status after 100 ms */
> +	schedule_delayed_work(&tas_dev->mIrqInfo.irq_work,
> +		msecs_to_jiffies(100));
> +	return IRQ_HANDLED;
> +}

Why this delay?

> +	rc = of_property_read_u32(np, dts_glb_addr_tag,
> +			&(tas_dev->glb_addr.mnDevAddr));
> +	if (rc) {

Please just put the DT properties into the code directly rather than
adding a layer of indirection liek this, look at what other drivers do.

> +static int tasdevice_regmap_write(
> +	struct tasdevice_priv *tas_dev,
> +	unsigned int reg, unsigned int value)
> +{
> +	int nResult = 0;
> +	int retry_count = TASDEVICE_RETRY_COUNT;
> +
> +	while (retry_count--) {
> +		nResult = regmap_write(tas_dev->regmap, reg,
> +			value);
> +		if (nResult >= 0)
> +			break;
> +		usleep_range(5000, 5050);

Is the device really so unstable that it always needs multiple attempts
to do any I/O?

> +static int tasdevice_change_chn_book_page(
> +	struct tasdevice_priv *tas_dev, enum channel chn,
> +	int book, int page)
> +{

regmap has generic support for register paging, use it.


--GA5+8HlyMrJr9eG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOjApEACgkQJNaLcl1U
h9AIWgf/Qvpp6HB6C/wq5OW2nxjvriGTdXJvQccnUXfIxIyHGqQBnpxCMRaoTS8e
bjWlDdFDslveFs7X8T4MdNOH2J/OMRS3f8nmSw6RUK4kEX+BqUCo7J0s/PsLm6DK
+82KZrCI2uM1KCcTvYEdY5Y63Jt0MKDhNkb8Kre5LTMYXwn1kOdrvvDpAjDfTI3z
F8uZ9po87Ybmyywg4ZI+1pYf+yxPoRznpLz0Us2A+3xn381+QTOIknHEEVic+zi0
/2Igd2wzEMmA55MQwvAzJRgOIcjNb2NevNsiCSFa20vRUuS6cDK0HxQsDOqkQ2DO
W7GI6vsJluHFPzfyjSY2qNCQRaRgFw==
=M+KV
-----END PGP SIGNATURE-----

--GA5+8HlyMrJr9eG/--
