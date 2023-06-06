Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A999724B64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbjFFS2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjFFS2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C9A11D;
        Tue,  6 Jun 2023 11:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B63B2636B1;
        Tue,  6 Jun 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A157C433D2;
        Tue,  6 Jun 2023 18:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686075820;
        bh=T+JI2ckyFu8VOR3qL8ljjpZpkbu8FJMpdeuRNK5j1WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdOOJgmvG/YB+5sHAaFhY5A1/u8H5VgzQ7ybtKfQFNamKSS9dJ4/2MKitMx+RX8YA
         Y32N4YPmL+OSm1EWmcEEE0K0IKBbZ3PLd883eAlzxXu7mAkzMSlzYk7vflhxq/8Vh/
         7IEOHX+NR72Q1mUOV1QALhWSQGgfMKj3bP61tpr5DGD6dFraRH6orAyBAFf0ESBwgf
         JYajhMXowNPNKau/sp5QRce4Vb2fnSrBLEUv4700TxaqE/6t7QDZqkSsccwKU/brf8
         Qhcze7tgo6uoSPF8KFW8zEhMbc+Tm6W2qexRbJrzVaIgoGWiGtOjB4qy+n+mVFxjei
         07Q0q5FHVkpRg==
Date:   Tue, 6 Jun 2023 19:23:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tommaso Merciai <tomm.merciai@gmail.com>,
        jacopo.mondi@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
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
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <20230606-create-catchable-e16113afac82@spud>
References: <20230606155416.260941-1-tomm.merciai@gmail.com>
 <20230606155416.260941-3-tomm.merciai@gmail.com>
 <20230606163656.GI25679@pendragon.ideasonboard.com>
 <20230606-jaundice-womankind-7e583789fb7a@spud>
 <20230606181752.GC14101@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/wO+rvK5rRihXazv"
Content-Disposition: inline
In-Reply-To: <20230606181752.GC14101@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/wO+rvK5rRihXazv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 09:17:52PM +0300, Laurent Pinchart wrote:
> On Tue, Jun 06, 2023 at 07:07:42PM +0100, Conor Dooley wrote:
> > Hey Laurent, Tommaso,
> >=20
> > On Tue, Jun 06, 2023 at 07:36:56PM +0300, Laurent Pinchart wrote:
> > > On Tue, Jun 06, 2023 at 05:54:03PM +0200, Tommaso Merciai wrote:
> >=20
> > > > +  alliedvision,lp2hs-delay-us:
> > > > +    maxItems: 1
> > > > +    description:
> > > > +      Low power to high speed delay time in microseconds.
> > >=20
> > > You can drop "in microseconds", that's implied by the suffix.
> > >=20
> > > > +      The purpose of this property is force a DPhy reset for the p=
eriod
> > > > +      described by the microseconds on the property, before it sta=
rts
> > > > +      streaming. To be clear, with that value bigger than 0 the Al=
vium
> > > > +      forces a dphy-reset on all lanes for that period. That means=
 all
> > > > +      lanes go up into low power state. This may help a csi2 rx ip=
 to
> > > > +      reset if that IP can't deal with a continous clock.
> > >=20
> > > I'd like to propose what I think is a clearer version:
> > >=20
> > >     description: |
> > >       Low power to high speed delay time.
> > >=20
> > >       If the value is larger than 0, the camera forces a reset of all
> > >       D-PHY lanes for the duration specified by this property. All la=
nes
> > >       will transition to the low-power state and back to the high-spe=
ed
> > >       state after the delay. Otherwise the lanes will transition to a=
nd
> > >       remain in the high-speed state immediately after power on.
> > >=20
> > >       This is meant to help CSI-2 receivers synchronizing their D-PHY
> > >       RX.
> >=20
> > Question about the property.
> > Why not make it have a minimum value of 1 and drop the special-case
> > behaviour for zero?
>=20
> The property is optional, so it can indeed be omitted if no delay is
> desired. I have no strong preference on whether or not to allow 0 as a
> valid value.

FWIW, I prefer the semantics of the property if it doesn't have the
limbo state of being present but doing nothing.

Cheers,
Conor.

BTW, I seem to get bounces from shawnx.tu@intel.com, who is listed in
MAINTAINERS for several drivers. Do you know if they have a non-intel
address to replace those entries with, or should they be dropped?

--/wO+rvK5rRihXazv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH95pAAKCRB4tDGHoIJi
0ku3AP4ggWo9VZWGTA9FT9GGznavW3AY/aadgCo0GxyloBybbgEAzzzwXaC7fzis
PR8yODKfvMxBuv0CdqCLPm6e3sft8AI=
=hRQC
-----END PGP SIGNATURE-----

--/wO+rvK5rRihXazv--
