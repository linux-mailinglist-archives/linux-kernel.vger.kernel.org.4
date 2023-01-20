Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861B0675F17
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjATUsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjATUsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:48:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD0E2916E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:48:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C184B82A58
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 20:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F3BC433EF;
        Fri, 20 Jan 2023 20:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674247691;
        bh=HLJz5mVXt+pHy3+fwjL5Cb4NBiJCx55ZoB36nq8D6y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/42VN/+vvPkBrILi7fgsYKOcd32Jkk1apuhCWlIHw4UkYn2t5ESvhcePsFACYhB9
         q8eR1otdpqog/vZ0V2HERjTGp7jOixGvHHFKp1IBPtwajNJ9VeHIBC+3z8IFWgv6lL
         V29x+M3OQJBoXUNLIfNL3xqFw7VuGJvaOVU1Z8/vk3ShRSxpuQV6oOpBduEEzaz3+Z
         Ocn/g7s4J3DumXs/Y/gVD3uep1UXSdWUgQO2TWaQG0CwLnt8u7ZnSxxCV5pClU11KO
         S3+8B6i9pfuLO9RjNeEHfiJ+8/4dBZ5J9Gryd6EylT6ezemUcsq2VCmhICTd0S6k/Z
         nydhIGDb5Yv7Q==
Date:   Fri, 20 Jan 2023 20:48:07 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v1 1/2] riscv: Kconfig: Allow RV32 to build with no MMU
Message-ID: <Y8r+B3TZpeI32iTz@spud>
References: <20230119052642.1112171-1-Mr.Bossman075@gmail.com>
 <20230119052642.1112171-2-Mr.Bossman075@gmail.com>
 <Y8pJ4y7FyBDQPqIT@wendy>
 <056f0d30-d340-fdc4-3744-1cdedd8b4048@gmail.com>
 <Y8r9GuyUAfJWYY5Z@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eI6pjRJiLt/IAbwd"
Content-Disposition: inline
In-Reply-To: <Y8r9GuyUAfJWYY5Z@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eI6pjRJiLt/IAbwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2023 at 08:44:10PM +0000, Conor Dooley wrote:
> On Fri, Jan 20, 2023 at 12:39:06PM -0500, Jesse Taube wrote:
> > On 1/20/23 02:59, Conor Dooley wrote:
> > > Since you'll have to re-submit, making sure that allowing !MMU on rv32
> > > doesn't break the build due to canaan k210 drivers being enabled desp=
ite
> > > relying on 64-bit divisions, I've got some nits for you.
> > Not sure what driver needs 64bit, but sense !MMU was only selected by 6=
4BIT.
>=20
> LKP reported a build error for it:
> https://lore.kernel.org/linux-riscv/202301201538.zNlqgE4L-lkp@intel.com/
>=20
> > This should work.
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 69774bb362d6..b9835b8ede86 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -43,7 +43,7 @@ config SOC_VIRT
> >=20
> >  config SOC_CANAAN
> >         bool "Canaan Kendryte K210 SoC"
> > -       depends on !MMU
> > +       depends on !MMU && 64BIT
> >         select CLINT_TIMER if RISCV_M_MODE
> >         select SERIAL_SIFIVE if TTY
> >         select SERIAL_SIFIVE_CONSOLE if TTY
>=20
> I don't think this is the correct fix for the problem - the drivers
> really should not do implicit 64-bit divisions IMO.
> Linux has division helpers for them in math64.h.
> None of the other SoCs have a dependency on 64BIT and I'd not been keen
> on adding on here.
>=20
> I suspect the fix is as simple as the below, but I'd need to go test it.
>=20
> Thanks,
> Conor.
>=20
> --- 8< ---
> From ecfa79ad1b24f68cfccb77d666e443293d52d066 Mon Sep 17 00:00:00 2001
> From: Conor Dooley <conor.dooley@microchip.com>
> Date: Fri, 20 Jan 2023 20:36:29 +0000
> Subject: [PATCH] clk: k210: remove an implicit 64-bit division
>=20
> The K210 clock driver depends on SOC_CANAAN, which is only selectable
> when !MMU on RISC-V. !MMU is not possible on 32-bit yet, but patches
> have been sent for its enabling. The kernel test robot reported this
> implicit 64-bit division there.
>=20
> Replace the implicit division with an explicit one.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-riscv/202301201538.zNlqgE4L-lkp@intel=
=2Ecom/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Since it was always guarded such that it only ever built for 64-bit, I
> am not sure that a fixes tag is needed, but it would be:
> Fixes: c6ca7616f7d5 ("clk: Add RISC-V Canaan Kendryte K210 clock driver")
> ---
>  drivers/clk/clk-k210.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk-k210.c b/drivers/clk/clk-k210.c
> index 67a7cb3503c3..17c5bfb384ad 100644
> --- a/drivers/clk/clk-k210.c
> +++ b/drivers/clk/clk-k210.c
> @@ -495,7 +495,7 @@ static unsigned long k210_pll_get_rate(struct clk_hw =
*hw,
>  	f =3D FIELD_GET(K210_PLL_CLKF, reg) + 1;
>  	od =3D FIELD_GET(K210_PLL_CLKOD, reg) + 1;
> =20
> -	return (u64)parent_rate * f / (r * od);
> +	return div_u64(parent_rate * f, r * od);

Nope, that's wrong. I omitted the cast...

	return div_u64((u64)parent_rate * f, r * od);

>  }
> =20
>  static const struct clk_ops k210_pll_ops =3D {
> --=20
> 2.39.0
>=20



> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


--eI6pjRJiLt/IAbwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8r+BwAKCRB4tDGHoIJi
0lIiAP9JEWs8JgsWVeOrMTPG5dN2vOcAFqgntTONudKYjMh8PQD/VL9eO7dqi1SC
VejMrIZYqYtonWbl99n60ESam8WynQk=
=HAcZ
-----END PGP SIGNATURE-----

--eI6pjRJiLt/IAbwd--
