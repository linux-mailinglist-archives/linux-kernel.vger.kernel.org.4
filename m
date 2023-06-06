Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08227724AC5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbjFFSCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbjFFSCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:02:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDD31706;
        Tue,  6 Jun 2023 11:02:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 551866341A;
        Tue,  6 Jun 2023 18:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC47C433D2;
        Tue,  6 Jun 2023 18:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686074559;
        bh=dFwKeulfNWCG8UJG4DaHFrjsPfB1yDRqXJKDxpAVLdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pNT9+YCLC8Hkr1JN7fnvDLqgrYCGGM9hXMTQFQO2Ji0Eecg1iW5gouf6kpGqSOLH8
         jSko7oQg4HS5nopGiYhw3wzvN1u9TspP4NvwQ9K896NyndK0H7jjSSBiy3O28j2VoI
         xuGu0Pl4Q+haguo9suObFX7Yq5YOZTJ+jOg1qCuKJARORdW3qr92YNxwIEby5iqZPy
         Wd5qHY9+3d7V9hjjvl1YpePfqQLShPBKx3PEeMm1c3BRjd9ds8nWTg7OYg6hRfX+gy
         +fzDxMFKVPy4g3rIdPMKShA4whjcqQzQ8IXMZOm65qRdsKQvQ7xKaDzq1rQgEU2X2x
         DCb+9JUZ3A8lg==
Date:   Tue, 6 Jun 2023 19:02:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tommaso Merciai <tomm.merciai@gmail.com>,
        jacopo.mondi@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add prefix
 alliedvision
Message-ID: <20230606-stopper-posting-0cb541626f4a@spud>
References: <20230606155416.260941-1-tomm.merciai@gmail.com>
 <20230606155416.260941-2-tomm.merciai@gmail.com>
 <20230606162911.GH25679@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K/kHIo6bma44g0Jo"
Content-Disposition: inline
In-Reply-To: <20230606162911.GH25679@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K/kHIo6bma44g0Jo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 07:29:11PM +0300, Laurent Pinchart wrote:
> Hi Tommaso,
>=20
> Thank you for the patch.
>=20
> On Tue, Jun 06, 2023 at 05:54:02PM +0200, Tommaso Merciai wrote:
> > Add a vendor prefix entry for Allied Vision Inc.
> > (https://www.alliedvision.com)
> >=20
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--K/kHIo6bma44g0Jo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH90twAKCRB4tDGHoIJi
0rMeAQCoIRgZojaBE1obkHs+f87CH6LARNQ5uWCzpwgpIwRbRgEA86YPQXzYLjOX
+espViovxfVXGjq3GGjrrDbaO3szOgk=
=b4vR
-----END PGP SIGNATURE-----

--K/kHIo6bma44g0Jo--
