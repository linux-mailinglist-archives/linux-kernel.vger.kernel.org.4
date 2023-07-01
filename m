Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882FD744BB3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 01:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGAXFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 19:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGAXFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 19:05:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E3310DC;
        Sat,  1 Jul 2023 16:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB7A260A72;
        Sat,  1 Jul 2023 23:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2E7C433C7;
        Sat,  1 Jul 2023 23:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688252742;
        bh=CtjmbMV6hgSJLwjZdBZjw6qZiEGab/wtFzurXmkUtsw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=cxwWM7J5w6vVG7bnFAhc1D+5ZPOy3GciLuv39i8XnQeYgxxZfDApxabmegBcnNK6O
         vXHtFK7Jx6qqd2F5KA9Lt2TCosxuB4kvfrzaNsXpmuS55EZsJyi/dDcq7atfrMtfSk
         R+ccQSiMwJBdHVOHHYtZtMgkvmYf6bKypyehNR1el9uIhd8CYzZPgsGsP/VaseALTH
         wraRgIyo9hoN5z7oNWnOBeFjTjQrCGuH4VJXRceR1qykGCGLLVZ/uYtuynHKBwyMyo
         RwS83XFaDhwl0/hXddrTEP+sIjCJKzSB/XQ8ImetN6bGWp9KSXZS6vgsLuYSmuoL0q
         yxy5EwsSjmGsg==
Date:   Sun, 2 Jul 2023 00:05:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     jiajie.ho@starfivetech.com, Palmer Dabbelt <palmer@rivosinc.com>,
        olivia@selenic.com, herbert@gondor.apana.org.au,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kernel@esmil.dk, Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 3/3] riscv: dts: starfive: Add TRNG node for
 VisionFive 2
Message-ID: <20230702-ajar-stingy-3eb04f334575@spud>
References: <20230117015445.32500-4-jiajie.ho@starfivetech.com>
 <mhng-348475f1-5880-4951-9692-78210a17acd3@palmer-ri-x1c9a>
 <ZKCgXvcbWBGWZnsU@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ej1htFhOe1EwGlXT"
Content-Disposition: inline
In-Reply-To: <ZKCgXvcbWBGWZnsU@aurel32.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ej1htFhOe1EwGlXT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 01, 2023 at 11:53:34PM +0200, Aurelien Jarno wrote:
> On 2023-03-14 18:45, Palmer Dabbelt wrote:
> > On Mon, 16 Jan 2023 17:54:45 PST (-0800), jiajie.ho@starfivetech.com wr=
ote:
> > > Adding StarFive TRNG controller node to VisionFive 2 SoC.
> > >=20
> > > Co-developed-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> > > Signed-off-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> > > Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> > > ---
> > >  arch/riscv/boot/dts/starfive/jh7110.dtsi | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >=20
> > > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/bo=
ot/dts/starfive/jh7110.dtsi
> > > index 4ac159d79d66..3c29e0bc6246 100644
> > > --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > > @@ -455,5 +455,15 @@ uart5: serial@12020000 {
> > >  			reg-shift =3D <2>;
> > >  			status =3D "disabled";
> > >  		};
> > > +
> > > +		rng: rng@1600c000 {
> > > +			compatible =3D "starfive,jh7110-trng";
> > > +			reg =3D <0x0 0x1600C000 0x0 0x4000>;
> > > +			clocks =3D <&stgcrg JH7110_STGCLK_SEC_HCLK>,
> > > +				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
> > > +			clock-names =3D "hclk", "ahb";
> > > +			resets =3D <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
> > > +			interrupts =3D <30>;
> > > +		};
> > >  	};
> > >  };
> >=20
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> It appears that this patch has never been applied, although the rest of
> the series has already been merged.

Ditto here, depends on the stgcrg, so it can't be applied yet.

> Unfortunately it doesn't apply
> anymore due to other changes to that file.
>=20
> Could you please rebase and resend it?

No harm in a resend of course, given it doesn't apply.

Cheers,
Conor.

--ej1htFhOe1EwGlXT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKCxQQAKCRB4tDGHoIJi
0lmZAP0SNjqkT8s0n5wtApbSeSzlCFqL+QWYwc90EmHZ2nvUAAD6AyyO6yS2S+0w
9vMPZEB+a1Y4AmHnkfKGkzunks9MQw8=
=Mc7t
-----END PGP SIGNATURE-----

--ej1htFhOe1EwGlXT--
