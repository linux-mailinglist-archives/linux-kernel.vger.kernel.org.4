Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686BD6B14C1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCHWGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCHWGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:06:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D68C8882;
        Wed,  8 Mar 2023 14:06:42 -0800 (PST)
Received: from mercury (unknown [185.209.196.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D5796603007;
        Wed,  8 Mar 2023 22:06:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678313199;
        bh=JP5CvWoVUxLCYdS7QZE8O+uhSW8n3OGmxvj7aci/EpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jetUC/bTggYdhXJ0HOVXs6JTe73KwBlZ7GQAUCI3LNgAknEXlq4Z+hEnveBkLn1wa
         HtmQcfqyxus8WgRmnYfVpzejX0k5DPKtzsn6TZEtqaf4tvn+2mEhJ44s9HgR33m/Aj
         s66MOcOwi7lXNNS9K2s/uhO2ByPfZ80afjhgmLJpCIqUr6pOGlZ9pm9c4gYf7nK8Et
         V8OLHJfNu4Lmn+7gTfkgfUwJTp3vr8RumDDnWFhburk8nU4hiuj/YwXMPJurc90EU3
         uXkQ/N3bhj3hg21B37Hadqkze12e1JIqS/ox+iMnECI+Q3IcDQTYEh8JAB4WCQQYK7
         v301CplekT+AA==
Received: by mercury (Postfix, from userid 1000)
        id 0DB94106083B; Wed,  8 Mar 2023 23:06:36 +0100 (CET)
Date:   Wed, 8 Mar 2023 23:06:35 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 03/21] of: Rename of_modalias_node()
Message-ID: <fca549f7-a79a-4d8f-b609-efef830becd2@mercury.local>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
 <20230307165359.225361-4-miquel.raynal@bootlin.com>
 <20230308001903.GA513330-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j6wpdwdpkitl36cp"
Content-Disposition: inline
In-Reply-To: <20230308001903.GA513330-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j6wpdwdpkitl36cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 07, 2023 at 06:19:03PM -0600, Rob Herring wrote:
> On Tue, Mar 07, 2023 at 05:53:41PM +0100, Miquel Raynal wrote:
> > This helper does not produce a real modalias, but tries to get the
> > "product" compatible part of the "vendor,product" compatibles only. It
> > is far from creating a purely useful modalias string and does not seem
> > to be used like that directly anyway, so let's try to give this helper a
> > more meaningful name before moving there a real modalias helper (already
> > existing under of/device.c).
> >=20
> > Also update the various documentations to refer to the strings as
> > "aliases" rather than "modaliases" which has a real meaning in the Linux
> > kernel.
> >=20
> > There is no functional change.
> >=20
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: Wolfram Sang <wsa@kernel.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/acpi/bus.c                |  7 ++++---
> >  drivers/gpu/drm/drm_mipi_dsi.c    |  2 +-
> >  drivers/hsi/hsi_core.c            |  2 +-
>=20
> These should not have been using this function. The matching on just the=
=20
> product was a relic from I2C and SPI which we don't want to propogate.=20
> No clue why ACPI needed it...
>=20
> If you respin or want to fixup while applying, can you add a kerneldoc=20
> comment to not add new users of the function. Not that anyone will=20
> follow that... :(
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

I just checked and HSI is not using the data for matching. Instead
it uses the returned data to set the device name. Matching happens
using the full compatible.

FWIW the MIPI HSI standard never became a big thing, so we have only
one HSI DT driver upstream and that is the Nokia N900 modem driver.

Anyways:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com> # for HSI

-- Sebastian

>=20
> >  drivers/i2c/busses/i2c-powermac.c |  2 +-
> >  drivers/i2c/i2c-core-of.c         |  2 +-
> >  drivers/of/base.c                 | 15 ++++++++-------
> >  drivers/spi/spi.c                 |  4 ++--
> >  include/linux/of.h                |  2 +-
> >  8 files changed, 19 insertions(+), 17 deletions(-)

--j6wpdwdpkitl36cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQJBuMACgkQ2O7X88g7
+pq8tA//dfZ7GtpO1P3CEg/QoZwn+UupbXuO8DQwKADWWTMSmK39RdCUOhyy1VR/
OZsp/pifZ/vM1FlnCKdzBNgRXWxYP4li7WeKWUoV12eQkPV7SsnyffnXFishOhSe
63hZxb70SHBXCuW1iZmjt7RkgV2kmxnVzV2EcIAPoAMWDbbBARAjvsUsgoF3cr7h
jH1aeQGaVpp4weu69RU4m7ySS0lgFAV8EzSbWq6QUH5EAegQHpUKFIrqeCUIBxvL
fpR5ZW7Ca9PzqSBHik8avUiND5ZyUs9QOZA9swhy8C1lsIki/NjajDI8aspU+yZq
HlP7U2c6vLN1GYnrVLrfV8cf8ocIB3cO54oVPbJVIdenaWzCKv8yK3KUigI8UwRQ
8HabDuwJ55zKQW8Sk0lgfA1Exnd8mtTy9bBCa9qI5fUe11Nxxi9q6rWrk+p4ZaSU
yi5WNTq2raocgZnphiJhxjMjDHWhkE0/CV8H221DVgZtDcFDitQ3gq7x+5pPK3mT
6AW9JvitpIinCa3koOgr0oIHiVueEcszstHIhetDGGVTn4KgeH3vl5qSd/YNXbxf
AeeM0HOviFnJnS39oaMXpAdDtjEDVBgKwNRqX16Wl8GndMuHXDc3zTz7TSl2hbVQ
LpZ4QommfGZjUoL52eSp/JKjZkKSQXvonfF4IhgNxlJvrvUzV+w=
=SbPM
-----END PGP SIGNATURE-----

--j6wpdwdpkitl36cp--
