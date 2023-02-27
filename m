Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27106A4884
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjB0Rrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjB0Rrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:47:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CED18F;
        Mon, 27 Feb 2023 09:47:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ED2560EEE;
        Mon, 27 Feb 2023 17:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC39C433D2;
        Mon, 27 Feb 2023 17:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677520049;
        bh=je6Bz/Pb53L7AJRKDXmLUBTm/Pxb0Qt9+y/hqaITn18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XVrT/nnMvPYu6UzG9YF0HNpeuGQhj+LuLQX66SXtYRTyunL5K5XjWYt2R/chjUB0L
         ABjkS9XDUbz9wDdqOS+LzWiXqzB+BWP+5SeZ0xd8oXuKg3b2oR+e40lw9G7nxMMYa/
         KfPUmbmXpn11A64K2xAUgBFQ2YHGzYaZnFHfv4BAa9Srop7qfPIwxXuBB3p3EBQTdI
         M3HOHIluptoMazcnOnX2NT0nQ6kEga61TmLI+knHe00KjyiBbhm5ztOsNzkPzj21wI
         sGpbnMi4PUYZUO2T+1gQ6AQeflLhje8/4QfyuiSGMhlQeK74Dh54v3lESIzpxfyILA
         5Sjd1BjhM2L6A==
Date:   Mon, 27 Feb 2023 17:47:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     =?utf-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        krzysztof.kozlowski@linaro.org, rf@opensource.cirrus.com,
        ckeepax@opensource.cirrus.com, herve.codina@bootlin.com,
        wangweidong.a@awinic.com, james.schulman@cirrus.com,
        ajye_huang@compal.corp-partner.google.com, shumingf@realtek.com,
        povik+lin@cutebit.org, flatmax@flatmax.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        ryans.lee@analog.com
Subject: Re: [PATCH 1/2] ASoC: max98363: add soundwire amplifier driver
Message-ID: <Y/zsqjOWFKrpDtl8@sirena.org.uk>
References: <20230224010814.504016-1-ryan.lee.analog@gmail.com>
 <0fb47fe7-719b-0773-fc14-3d62d7d33619@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X8+/QatuS77Fl/Hx"
Content-Disposition: inline
In-Reply-To: <0fb47fe7-719b-0773-fc14-3d62d7d33619@linux.intel.com>
X-Cookie: On the eighth day, God created FORTRAN.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X8+/QatuS77Fl/Hx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2023 at 10:17:45AM -0500, Pierre-Louis Bossart wrote:

> > +static struct reg_default max98363_reg[] = {
> > +	{MAX98363_R0040_SCP_INIT_STAT_1, 0x00},
> > +	{MAX98363_R0041_SCP_INIT_MASK_1, 0x00},
> > +	{MAX98363_R0042_SCP_INIT_STAT_2, 0x00},
> > +	{MAX98363_R0044_SCP_CTRL, 0x00},
> > +	{MAX98363_R0045_SCP_SYSTEM_CTRL, 0x00},
> > +	{MAX98363_R0046_SCP_DEV_NUMBER, 0x00},
> > +	{MAX98363_R004D_SCP_BUS_CLK, 0x00},
> > +	{MAX98363_R0050_SCP_DEV_ID_0, 0x21},
> > +	{MAX98363_R0051_SCP_DEV_ID_1, 0x01},
> > +	{MAX98363_R0052_SCP_DEV_ID_2, 0x9F},
> > +	{MAX98363_R0053_SCP_DEV_ID_3, 0x87},
> > +	{MAX98363_R0054_SCP_DEV_ID_4, 0x08},
> > +	{MAX98363_R0055_SCP_DEV_ID_5, 0x00},

> That seems wrong, why would you declare standard registers that are
> known to the bus and required to be implemented?

This is the register defaults table, it gets used to initialise the
register cache and optimise resync after suspend - all this does is
supply defaults for the cache.  That said...

I would suggest it's better to not supply defaults for ID registers and
read them back from the device otherwise things might get confused.

> > +static const struct regmap_config max98363_sdw_regmap = {
> > +	.reg_bits = 32,
> > +	.val_bits = 8,
> > +	.max_register = MAX98363_R21FF_REV_ID,
> > +	.reg_defaults  = max98363_reg,
> > +	.num_reg_defaults = ARRAY_SIZE(max98363_reg),
> > +	.readable_reg = max98363_readable_register,
> > +	.volatile_reg = max98363_volatile_reg,

> I don't see why the SoundWire standard registers are part of regmap?

...if there's an issue with the SoundWire core modifying the registers
directly then the driver would need to mark all the core registers as
volatile so that they're not cached otherwise there will be collisions.
Or is it the case that we always need to go via the SoundWire core for
the generic registers, so they should just never be written at all?

> > +	if (max98363->dvddio) {
> > +		ret = regulator_enable(max98363->dvddio);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	if (max98363->vdd) {
> > +		ret = regulator_enable(max98363->vdd);
> > +		if (ret < 0)
> > +			return ret;
> > +	}

> that is very very odd. It's the first time we see a SoundWire codec
> driver that has a power dependency, and it's quite likely that it's too
> late to enable power resources *AFTER* dealing with all the
> initialization and enumeration.

> It's not even clear to me how this device would be enumerated.

> You'd need to explain what part of the amplifier is controlled by those
> regulator, otherwise it's impossible to review and understand if the
> driver does the 'right thing'

It's also buggy to have regulators treated as optional unless they may
be physically absent.

--X8+/QatuS77Fl/Hx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP87KkACgkQJNaLcl1U
h9Bv7Qf/YeP3QSU5T9ffyKOEPzEa0RwdpuLjBCjiDvdaCTaKpPSEZ74eMbh7LDJa
Pp+Nl3FhE3e3gYMZgJsU92VB2blKAyJ2ucRVdVon2R4KibZcmQo5uzJMm2Atc65e
psqnyn8ivHkOD7VNLgISErLRKchM+1tWbpchvxGXFrB/1atwRQ0w4I8AAr7tAeya
ArpGpzwcry/mZxUkqNlaVPkvCWnVQ2bSTBFg1VRGPkDAd3Ut97UWE8rN3/JVdUbL
GucL8qXeDkpIQsS9e6oNOgS6smmVpl7tMVOY+P1B1O6K8mZywLJW/1SKvuj9f8fl
yokBKgAoCkD7b0UzeepBdGDDtu7Vkg==
=FsGr
-----END PGP SIGNATURE-----

--X8+/QatuS77Fl/Hx--
