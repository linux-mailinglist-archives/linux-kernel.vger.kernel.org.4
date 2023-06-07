Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59369726DF2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjFGUqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbjFGUqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:46:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A656D1FE6;
        Wed,  7 Jun 2023 13:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8658A6468C;
        Wed,  7 Jun 2023 20:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147B7C4339C;
        Wed,  7 Jun 2023 20:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686170771;
        bh=P8ZCgAgE7eJNpObN9ulXK7dYFZR0bu+3Ud3lNgO0Mp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yv43UkipVp0C0NbjhZvh3jiu1Q1wtLXoD8HPny5UdmmSVRhsATUlhSMZ4yLeBzyk7
         gHjIz0AH+lVZ5fedId1zuzYFTalH+CQZRh3juI0pqprgPKx4P7pG9hYQIhBR62i/VE
         bTFLwpJv8gax8mTW4sFQMfHYQMKa3aU/Ago60WQPV83O6jEBgxbL1q2LSSZYxPri3+
         Z/vVLxZJTJJbiJhZ9P1CkrIUewIoLbGfHyscobxzWSOmZF7NO/cuaenJSEG4dkWtAH
         TCCxvhIFtcr4jn7RYRyx5pbvBEq7El460k6IG9zkbhTAqwujWwiLaYb00Fw8kFiY0g
         z/acrZAdmuAoA==
Date:   Wed, 7 Jun 2023 21:46:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <20230607-camisole-unstaffed-d19110b9cc1c@spud>
References: <20230607131936.382406-1-tomm.merciai@gmail.com>
 <20230607131936.382406-3-tomm.merciai@gmail.com>
 <20230607-pyromania-germinate-b5e3dbd54632@spud>
 <ZIDfPigYN5CgW65L@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zh+mAJfF+m3FUP5K"
Content-Disposition: inline
In-Reply-To: <ZIDfPigYN5CgW65L@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zh+mAJfF+m3FUP5K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 09:49:18PM +0200, Tommaso Merciai wrote:
> On Wed, Jun 07, 2023 at 06:16:19PM +0100, Conor Dooley wrote:
> > On Wed, Jun 07, 2023 at 03:19:24PM +0200, Tommaso Merciai wrote:

> You are suggesting the following solution:
>=20
> minimum: 1
> maximum: 150000
>=20
> Right?
>=20
> Personally I prefer to keep also 0 but never mind
> is ok also this solution. :)
>=20
> Let me know if I have understood correctly pls.
> Thanks in advance :)

Yup, you got it.

> > > +static int alvium_get_dt_data(struct alvium_dev *alvium)
> > > +{
> > > +	struct device *dev =3D &alvium->i2c_client->dev;
> > > +	struct device_node *node =3D dev->of_node;
> > > +	struct fwnode_handle *endpoint;
> > > +	int ret =3D 0;
> > > +
> > > +	if (!node)
> > > +		return -EINVAL;
> > > +
> > > +	ret =3D fwnode_property_read_u32(dev_fwnode(dev),
> > > +			  "alliedvision,lp2hs-delay-us",
> > > +			  &alvium->lp2hs_delay);
> > > +	if (ret)
> > > +		dev_info(dev, "lp2hs-delay-us not found\n");
> >=20
> > And this print, which I also don't understand the presence of as
> > well behaving driver should be quiet, goes away.
>=20
> Then you are suggesting to drop this print right?

Yeah, in general we do not want drivers to be printing things while they
are behaving correctly & not having the property isn't an error ;)

Cheers,
Conor.

--Zh+mAJfF+m3FUP5K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIDsiwAKCRB4tDGHoIJi
0q9zAQC2+ywrAVVGvaY1M6RjFfgakbNDoepfWiSruvSCGW+KgAEAzM3oT1TOJiam
GAkQmQisyBkMd5TvlpoI+nzDyfIoqQA=
=AyUX
-----END PGP SIGNATURE-----

--Zh+mAJfF+m3FUP5K--
