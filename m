Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C626A4A13
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjB0Soq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjB0Som (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:44:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C828925BB2;
        Mon, 27 Feb 2023 10:44:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E5FE60F0F;
        Mon, 27 Feb 2023 18:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B478BC433EF;
        Mon, 27 Feb 2023 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677523479;
        bh=6Gbe71x5s6Das+rBasyVyMZPahwt8g5CfHY7P0xaV0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgoDyO3SaxmaL2rc+B4Y/Cvh+rq1kpg3+novn8WDLalswop2VSt+HRibd1IR+eRaW
         1DrjQvRg4s0HWXjh9tqdLkPlMtU8YHRLGFQiTi97UrkBs0+ad7tCIM0LZiY5a9r1BL
         Z2DX9ehl4dq9xj0klov0z35W3rKridHvpfWBl0Vv7Ez113qvcbK+jrqn7VbOYHNcVR
         WNHzbNd36Pswlq8HmTxxL6v0QyB0/nVZUJzyyw7lzVzYp5y50j/X6mahH95nj3o57G
         TTqG7dFuqiNEB1JvDUMb04OLWNEaWK8K/MsbFbB4VV9M0uq8BKn6qb5+aOzUx8gtQ6
         R/s/L0u2Tf3YA==
Date:   Mon, 27 Feb 2023 18:44:32 +0000
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
Message-ID: <Y/z6EB+0beX2Ji2h@sirena.org.uk>
References: <20230224010814.504016-1-ryan.lee.analog@gmail.com>
 <0fb47fe7-719b-0773-fc14-3d62d7d33619@linux.intel.com>
 <Y/zsqjOWFKrpDtl8@sirena.org.uk>
 <d95d15f3-34c3-32df-1a50-0ebce35bf81f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ETdG2/4g/8e9VlgA"
Content-Disposition: inline
In-Reply-To: <d95d15f3-34c3-32df-1a50-0ebce35bf81f@linux.intel.com>
X-Cookie: On the eighth day, God created FORTRAN.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ETdG2/4g/8e9VlgA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2023 at 01:19:15PM -0500, Pierre-Louis Bossart wrote:
> On 2/27/23 12:47, Mark Brown wrote:
> > On Mon, Feb 27, 2023 at 10:17:45AM -0500, Pierre-Louis Bossart wrote:

> >> That seems wrong, why would you declare standard registers that are
> >> known to the bus and required to be implemented?

> > This is the register defaults table, it gets used to initialise the
> > register cache and optimise resync after suspend - all this does is
> > supply defaults for the cache.  That said...

> > I would suggest it's better to not supply defaults for ID registers and
> > read them back from the device otherwise things might get confused.

> The 'device_id' register is the good counter example: it includes a
> 'unique_id' field to deal with cases where there are identical devices
> on the same link. The unique_id is usually set with board-specific
> pin-strapping, so there's no good default value here. In previous Maxim
> 98373 amplifier configurations the unique IDs were 3 and 7 IIRC. The
> codec driver should not, rather shall not, assume any specific value here.

Yes, as I said above ID registers in particular are often better off
handled as volatile even ignoring any potential for them to show
variable configuration information.

> > ...if there's an issue with the SoundWire core modifying the registers
> > directly then the driver would need to mark all the core registers as
> > volatile so that they're not cached otherwise there will be collisions.
> > Or is it the case that we always need to go via the SoundWire core for
> > the generic registers, so they should just never be written at all?

> It's really that the SoundWire core will 'own' or take care of all
> 'standard' programming registers. There is no good reason for a codec
> driver to interfere with standard port programming or clock stop. The
> bus provides a set of callbacks that can be used for vendor-specific
> registers and sequences.

> Put differently, SoundWire codec drivers should only deal with
> non-standard vendor-specific registers.

OK, it'd be good to be clear about what the issue is when reviewing
things.  The registers *are* in the device's register map but the driver
shouldn't be referencing them at all and should instead be going via the
SoundWire core for anything in there.

--ETdG2/4g/8e9VlgA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP8+g8ACgkQJNaLcl1U
h9ADvQf/TF6iszJg1jS/syn57MxUDtIGV3fgPQgc4CW0PGD6IbOIlZoZo/LxNtj2
IZOxJw9/JXgHLa+M3YZkN3v1ijbY5mO3oP1OinM4dPccncR6Nx9SycL/aKXwByF+
k06peYefJBZBadEihj1grRhnSjxXUZIDSqQeqPVR+L3IRquhcuOwUZssJwyHBKcP
aaJFrHPf/dpBy5eSQcZ/aq8ccH6Ch6aoI/nwg4OuitZWHvoCDZ4DWqJMWBnRtLh1
auV6gbe2GlzUdTsjJ9VGxmp+0wOH+VDxbUHDxVOwRCQjLLLBOV6IvOuPoklpmcHx
U9PzG5c8H97Tn95P4tUH/JZeONIh2Q==
=YBbv
-----END PGP SIGNATURE-----

--ETdG2/4g/8e9VlgA--
