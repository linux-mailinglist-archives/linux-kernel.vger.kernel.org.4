Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D286645915
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiLGLd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiLGLdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:33:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533CC1A238;
        Wed,  7 Dec 2022 03:33:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8BBCB81D75;
        Wed,  7 Dec 2022 11:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258F9C433D7;
        Wed,  7 Dec 2022 11:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670412799;
        bh=3iUZUuHkcIvwtOgND+IUFfeLoZ05Y/NDVmrMzsGnk6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ceUfHsLwXidT2LV0zG8VgVjdgYF4UGdMFkvTuXrhlY0aeDko6+bV9FLQBG8LWBLy7
         cmg2RaLjmQ/rvewb1fYfc4F7hRB5ToX7sXDEWyKnn2eYkOur76Pp0rgzAPQK2Txa1h
         aXKDsv+IGMQV/A2xrTcSbl/i6tmss4V9t6Zruzww/xfcXpNHlEpZ96jZbgdtFi0IPm
         oAfZqyTIwGcQ0DovBu3IHwpp0ZQ09nOv+/9iLL+XN6KX8K8o8VMeyCZ54b4ElXDa9Y
         E/W6HpQ/Bj1jxdDIbPOC5KRwwXqsJMeljL8jmgHI9DhNquqvbdMAeSXG0pPxI5KyLD
         GbpYPCdOWr4Rw==
Date:   Wed, 7 Dec 2022 11:33:14 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: timer: sifive,clint: add comaptibles
 for T-Head's C9xx
Message-ID: <Y5B5+vUjYxepn53g@spud>
References: <20221121041757.418645-1-uwu@icenowy.me>
 <20221121041757.418645-2-uwu@icenowy.me>
 <34fe4161718e395f5e9890f9358a25f697af9e24.camel@icenowy.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JWqOn8OBCdKsE8RV"
Content-Disposition: inline
In-Reply-To: <34fe4161718e395f5e9890f9358a25f697af9e24.camel@icenowy.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JWqOn8OBCdKsE8RV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 06:47:26PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2022-11-21=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 12:17 +0800=EF=
=BC=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A
> > T-Head C906/C910 CLINT is not compliant to SiFive ones (and even not
> > compliant to the newcoming ACLINT spec) because of lack of mtime
> > register.
> >=20
> > Add a compatible string formatted like the C9xx-specific PLIC
> > compatible, and do not allow a SiFive one as fallback because they're
> > not really compliant.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
>=20
> Hi, could this patch be picked ASAP? Becuase it will be used then in
> further OpenSBI patches to enable proper operation of T-Head timer.
>=20
> I know the following 2 patches are in doubt and further rework for them
> are needed.

Since it's me that's asking the questions about the other patches, but
have no comments about this particular one:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

HTH Icenowy!

> > ---
> > =C2=A0Documentation/devicetree/bindings/timer/sifive,clint.yaml | 8
> > ++++++++
> > =C2=A01 file changed, 8 insertions(+)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > index bbad24165837..aada6957216c 100644
> > --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > @@ -20,6 +20,10 @@ description:
> > =C2=A0=C2=A0 property of "/cpus" DT node. The "timebase-frequency" DT p=
roperty
> > is
> > =C2=A0=C2=A0 described in Documentation/devicetree/bindings/riscv/cpus.=
yaml
> > =C2=A0
> > +=C2=A0 T-Head C906/C910 CPU cores include an implementation of CLINT t=
oo,
> > however
> > +=C2=A0 their implementation lacks a memory-mapped MTIME register, thus
> > not
> > +=C2=A0 compatible with SiFive ones.
> > +
> > =C2=A0properties:
> > =C2=A0=C2=A0 compatible:
> > =C2=A0=C2=A0=C2=A0=C2=A0 oneOf:
> > @@ -29,6 +33,10 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - starfive,jh7100-clint
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - canaan,k210-clint
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: s=
ifive,clint0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - allwinner,sun20i-d1-clint
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: thead,=
c900-clint
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: s=
ifive,clint0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: r=
iscv,clint0
>=20
>=20

--JWqOn8OBCdKsE8RV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY5B59wAKCRB4tDGHoIJi
0l5EAP0d8+bmSdQwOL1zh+4ekUZkbwUid4O2E8SRuJ//7ZbjjAD/cbWLeF0c/mVr
WKzBDTFx9jlc7gXrewlZxdymFvnXZwQ=
=5Qqt
-----END PGP SIGNATURE-----

--JWqOn8OBCdKsE8RV--
