Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C262F66625E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjAKR5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjAKR5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:57:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC21D13F6D;
        Wed, 11 Jan 2023 09:57:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F6B5B81BB2;
        Wed, 11 Jan 2023 17:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D18C433D2;
        Wed, 11 Jan 2023 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673459828;
        bh=5LEMMpXQx+KS8TLTTFnQlUbDjTjiKY0h3Mr8CfUFdvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDESBZtZH7EP7mR0FGphTdgKzxeINhHnh+GR70l9rvjNmzzk1xOQH0zPKMcDOIkLV
         i+T18lEc3o61C285ufWmcacpNrJi1k7L8SoINvoPH8noTR3xuZ5v7mhU8LpgXGqNpP
         ebxP3zbRH/YhDXqn8A8PtzvXfLCGFy5eM0qBoc+6Er+Ttqu4/QnSM5RF20m0E6Evmq
         erLxkoH0l3hU3Jrlmhvr0+0vGPVML+fGuY0mi+iE4tAU4nTmc4j0/JDy9IGzQ6+eMt
         R4uTy4dve95u484svFyJOfBb+D/+SmnG60M46RInIWhEabWqiDQZ/9sut7lzCQ0IWl
         LMK+rxvDpW8sQ==
Date:   Wed, 11 Jan 2023 17:57:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/3] ASoC: codecs: Add support for the Renesas IDT821034
 codec
Message-ID: <Y774bY4icD8RuMnX@sirena.org.uk>
References: <20230111134905.248305-1-herve.codina@bootlin.com>
 <20230111134905.248305-3-herve.codina@bootlin.com>
 <Y77DKSdZf27qE+xl@sirena.org.uk>
 <20230111174022.077f6a8c@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FW/lrGorzYH/UUN+"
Content-Disposition: inline
In-Reply-To: <20230111174022.077f6a8c@bootlin.com>
X-Cookie: Life is not for everyone.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FW/lrGorzYH/UUN+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 11, 2023 at 05:40:22PM +0100, Herve Codina wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Jan 11, 2023 at 02:49:04PM +0100, Herve Codina wrote:

> > Without knowing why things are written in this way or what it's trying
> > to accomplish it's hard to comment in detail on what specifically should
> > be done.

> Yes, I use regmap to ease the integration of controls and use the
> already defined controls macros but the device registers do not fit
> well with regmap.

If this doesn't fit into regmap then don't try to shoehorn it into
regmap, that just makes it incredibly hard to follow what's going on.

> The device registers are not defined as simple as address/value pairs.
> Accesses contains one or more bytes and the signification of the
> data (and bytes) depends on the first bits.
> - 0b10xxxxxx means 'Control register' with some data as xxxxxx
>   and one extra byte
> - 0b1101yyyy means 'Configuration register, slic mode' with
>   some other data as yyyy and one extra byte
> - 0b1100zzzz means 'Configuration register, gain mode' with
>   some other data as zzzz and two extra bytes

So really the device only has three registers, each of different sizes
and windowed fields within those registers?  I love innovation,
innovation is great and it's good that our hardware design colleagues
work so hard to keep us in jobs.  It seems hardly worth it to treat them
as registers TBH.  This is so far off a register/value type thing that I
just wouldn't even try.

> Of course, I can describe all of these in details.
> Where do you want to have this information ? All at the top
> of the file ? Each part (low-level, virtual regs, ...) at
> the beginning of each part in the code ?

I'm not sure what problem it solves to use regmap or have virtual
registers in the first place.  I think you would be better off with
custom _EXT controls, you almost have that anway just hidden in the
middle of the fake register stuff instead of directly there.  My sense
is that the result would be much less code.  If you are trying to map
things onto registers you probably want comments at every level since
you don't know where people are going to end up jumping into the code.

Perhaps it's possible to write some new SND_SOC_ helpers that work with
just a value in the device's driver data rather than a regmap and have
a callback to trigger a write to the device?  I suspect that'd be
generally useful actually...

--FW/lrGorzYH/UUN+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO++GwACgkQJNaLcl1U
h9ArFgf+O3HGWDePtn5hoFUxSB5AcANrqXbqzjNhuBkCGYrBvgjW4OpJVDkAYKAq
64TpDiANcIFWChMfdNoOgJjdEvq0JnooViFhAKp4hAXvhfGzMzN58LgYSy98tL8Q
N/lFjWN1qAtBMT5WtJahyzZs/AKpTXGFxTre1KwzvqSxQTZxCSSIg6P56WV4GD8X
WtQnRlaaef2V0O/j52Ah0+4Q/OgUrxXVZDpE5AgNnVCGYf1zoXKt9roOfdN9yVMB
w1WvYbXJG0bbPo3onWcyqkzDwW6N8FUX5vnBk8ZXiyLRn7dEe6JdTKO3Y9JTv5yP
9+0CqC/gxRPWoc4cFBBclomIuSP3pg==
=xtx3
-----END PGP SIGNATURE-----

--FW/lrGorzYH/UUN+--
