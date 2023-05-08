Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B2B6FB56E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbjEHQoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjEHQoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:44:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7E13C15;
        Mon,  8 May 2023 09:44:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF3AC62E17;
        Mon,  8 May 2023 16:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E4AC433D2;
        Mon,  8 May 2023 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683564250;
        bh=bfEBgQKWZzeEo35Bvckm2RInCVZk3NagszRRmsAUo84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmSnpb1rRnVd/dO0C57DZLRTEKBbSkHJ/M0dzc4AYqy9Tr5fPDhdEzYtDVoU90k9U
         LS0Bk/i82G2ob1NhIS0C1dUl32rAjPRqFHJjE0lPrxSJaXzVcAe/w+IkXqSF8nnDza
         EqFgkOWfDQp8H9LP4gtmxNJHUBEx3zSQNyXfsz/cTJvSczQ1keZVm+LJnJzjdom86c
         r5qEKNJrDIt5otchrglakxktHX7HFfzVNWIdFvvp4SBTUbBNKA+4pxQIxTrXoI08HN
         Q/mDxknGXSiLGyb2v30nab5oGsgC6iQeHAK+6oPzI3gOhk/4Yw9DmRQd0qeMGTW23N
         MHQY83Ry9b8rg==
Date:   Mon, 8 May 2023 17:44:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        heiko@sntech.de
Subject: Re: [PATCH 3/5] riscv: dts: add initial T-HEAD light SoC device tree
Message-ID: <20230508-unmoved-unvocal-9a6c5fc0c629@spud>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-4-jszhang@kernel.org>
 <20230507-calamari-gentleman-bbe62af06f92@spud>
 <ZFkiotPacIMUghDP@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SF2X7dyBkYPnhHIF"
Content-Disposition: inline
In-Reply-To: <ZFkiotPacIMUghDP@xhacker>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SF2X7dyBkYPnhHIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 12:26:10AM +0800, Jisheng Zhang wrote:
> On Sun, May 07, 2023 at 10:35:12PM +0100, Conor Dooley wrote:
> > On Mon, May 08, 2023 at 02:23:02AM +0800, Jisheng Zhang wrote:
> >=20
> > > +		c910_0: cpu@0 {
> > > +			compatible =3D "thead,c910", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> >=20
> > Does this support more than "rv64imafdc"?
> > I assume there's some _xtheadfoo extensions that it does support,
> > although I am not sure how we are proceeding with those - Heiko might
> > have a more nuanced take.
> >=20
> > > +		reset: reset-sample {
> > > +			compatible =3D "thead,reset-sample";
> >=20
> > What is a "reset-sample"?
>=20
> This node is only for opensbi. The compatible string is already in
> opensbi. Do we also need to add dt-binding for it in linux?

If it's to be included in the kernel's dts, then yes, you do need a
dt-binding. If you remove it, then you don't :)

That said, "thead,reset-sample" is a strangely named compatible, so if
you do keep it it may end up needing a rename!

Cheers,
Conor.


--SF2X7dyBkYPnhHIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFkm1AAKCRB4tDGHoIJi
0sW2AQDXJJbO5yD00A0FYT9OCSkvX0JlUUm5rAnhGLMxzDjE+QD/bkvjCep2sIjo
fz26Q9tH3VixEleafSwINv87ub4bjAc=
=ql70
-----END PGP SIGNATURE-----

--SF2X7dyBkYPnhHIF--
