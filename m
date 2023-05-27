Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A48713599
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjE0QKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjE0QKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 12:10:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20BAC7;
        Sat, 27 May 2023 09:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4354C60A76;
        Sat, 27 May 2023 16:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B32C433A1;
        Sat, 27 May 2023 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685203806;
        bh=eYi0KoVqRaCZj53f5St8xfkV5WSzW6/adalhh5yjO5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NToIqw7h4ZEb9k677fFUyLipUn0vVSvUlPzhK+IxLoJS8HkRkpjAHalN+kH9G18A/
         QYHPfhTqt3uBkV+XhpKupYGF6rPLTUQSHmoSRxS8Kqrqmau7HOgsacyzjBnGfe62Rr
         ZOzhkGerr14FbySyAr5GLvIaB5Ku8Tkl9W75ahAERiLhsLVvGTntWd8al/XCbWcktY
         ZSaS72asRQK10/ydAHUgGS1YD1qY6J39J9N5k1oXAw/Y72Ae9LegcD6hoSK60Z4drM
         jw/sjdrzdnp73kNL8SflfNdWkpTgfaF1xDx3WoRtbC/Lf0F9gWE0YTePOD9wjDY6/H
         511JtK7Jortkg==
Date:   Sat, 27 May 2023 17:10:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [EXT] Re: [PATCH 1/2 v8] dt-bindings: watchdog: marvell GTI
 system watchdog driver
Message-ID: <20230527-wiring-coping-88eba4d91f3f@spud>
References: <20230526062626.1180-1-bbhushan2@marvell.com>
 <20230526-bondless-slather-5de0a5659353@spud>
 <DM5PR1801MB188350DD9CFDBB3E240AC838E3449@DM5PR1801MB1883.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i/8waHnABoAqzrco"
Content-Disposition: inline
In-Reply-To: <DM5PR1801MB188350DD9CFDBB3E240AC838E3449@DM5PR1801MB1883.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i/8waHnABoAqzrco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 27, 2023 at 02:53:25PM +0000, Bharat Bhushan wrote:
> From: Conor Dooley <conor@kernel.org>
> > On Fri, May 26, 2023 at 11:56:25AM +0530, Bharat Bhushan wrote:

> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - marvell,cn9670-wdt
> > > +      - marvell,cn9880-wdt
> > > +      - marvell,cnf9535-wdt
> > > +      - marvell,cn10624-wdt
> > > +      - marvell,cn10308-wdt
> > > +      - marvell,cnf10518-wdt
> >=20
> > static const struct of_device_id gti_wdt_of_match[] =3D {
> >        { .compatible =3D "marvell,cn9670-wdt", .data =3D &match_data_oc=
teontx2},
> >        { .compatible =3D "marvell,cn9880-wdt", .data =3D &match_data_oc=
teontx2},
> >        { .compatible =3D "marvell,cnf9535-wdt", .data =3D &match_data_o=
cteontx2},
> >        { .compatible =3D "marvell,cn10624-wdt", .data =3D &match_data_c=
n10k},
> >        { .compatible =3D "marvell,cn10308-wdt", .data =3D &match_data_c=
n10k},
> >        { .compatible =3D "marvell,cnf10518-wdt", .data =3D &match_data_=
cn10k},
> >=20
> > This is a fat hint that you should be using fallback compatibles here.
> > You even had a fallback setup in your last revision, but you seem to ha=
ve
> > removed it alongside the removal of the wildcards. Why did you do that?
>=20
> Not sure I understand this comment, Compatible in last version was as bel=
ow:
>=20
> + properties:
> + compatible:
> +    oneOf:
> +      - const: marvell,octeontx2-wdt
> +      - items:
> +          - enum:
> +              - marvell,octeontx2-95xx-wdt
> +              - marvell,octeontx2-96xx-wdt
> +              - marvell,octeontx2-98xx-wdt
> +          - const: marvell,octeontx2-wdt
> +      - const: marvell,cn10k-wdt
> +      - items:
> +          - enum:
> +              - marvell,cn10kx-wdt
> +              - marvell,cnf10kx-wdt
> +          - const: marvell,cn10k-wdt
>=20
> By fallback do you mean " const: marvell,cn10k-wdt" and
> "const: marvell,octeontx2-wdt" ? If yes I removed because "octeontx2"
> and "cn10k" are soc family name and no a specific soc.

No, I meant that you should permit
	compatible =3D "marvell,cn9880-wdt", "marvell,cn9670-wdt";
and
	compatible =3D "marvell,cnf9535-wdt", "marvell,cn9670-wdt";
and
	compatible =3D "marvell,cn9670-wdt";
so the driver only needs to contain
	{ .compatible =3D "marvell,cn9670-wdt", .data =3D &match_data_octeontx2},
instead of=20
	{ .compatible =3D "marvell,cn9670-wdt", .data =3D &match_data_octeontx2},
	{ .compatible =3D "marvell,cn9880-wdt", .data =3D &match_data_octeontx2},
	{ .compatible =3D "marvell,cnf9535-wdt", .data =3D &match_data_octeontx2},

Note that using fallback compatibles is separate from using wildcards,
and I was not suggesting that you go back to wildcards ;)

Cheers,
Conor.

--i/8waHnABoAqzrco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHIrWgAKCRB4tDGHoIJi
0oljAP9BZ+U+Gavc0JHV6lcykTQcnIwApXH+ucFGpHXTj7rimwEA01pzJJKx8ZD4
ZicT1xosEaCSzPSn19gB/nLqKKlyuQU=
=vtmJ
-----END PGP SIGNATURE-----

--i/8waHnABoAqzrco--
