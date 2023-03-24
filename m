Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82F86C8598
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjCXTGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCXTGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:06:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C546A1ABE3;
        Fri, 24 Mar 2023 12:05:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 464E6B822D8;
        Fri, 24 Mar 2023 19:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10FEC433EF;
        Fri, 24 Mar 2023 19:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679684739;
        bh=McKaNQzEbk0xTIOMEdajlR1Z4xozs8VyLrhP53addwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knZIVMw5PE0f38FQxhO/H2qZ9SlfUvGpoYT6je9qZqDcGO566VsxxbqdUSmFV+IoM
         +W02Vis+mamyc/jIhA4q9/ubjwWA8TVwJncHgz7F9RFRnTFweg1w8CWah1ORB0iHPQ
         MiScVR2neGJUkdQWVN47fAgdGNc2qEBAOykq1AAiQQEtA3RD3nZZC27cDV6+F+5i3I
         N3MTA5M+vuuXp7kmUnYmM4ZCE71xmNG7Hlz1q6YSelCF8prqW8rVHaiaO79mYnF2Yc
         OJCvL0vNEEMbfbsNSxaWSMkQkP6V3REab2Mv6d2jXCWOGq3iMJ4DvqRsYb5e+hFQAw
         Y+kSa1yx8GoPw==
Date:   Fri, 24 Mar 2023 19:05:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: starfive: jh7110: Correct the properties
 of S7 core
Message-ID: <225945e3-2610-4fec-8ee5-5893d26641b4@spud>
References: <20230324064651.84670-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WqfTepoKbm4XihPt"
Content-Disposition: inline
In-Reply-To: <20230324064651.84670-1-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WqfTepoKbm4XihPt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 02:46:51PM +0800, Hal Feng wrote:
> The S7 core has no L1 data cache and MMU, so delete some
> related properties.
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>=20
> Hi, Conor,
>=20
> This is a correction for the S7 entry.

Again going off the latest version of the u74-mc core complex, this
looks to be correct, thanks.
I need to go read the Emil email from earier today, but I've
provisionally gone and put this on the riscv-jh7100_initial_dts branch
with a Fixes: tag.

Thanks,
Conor.

> This patch depends on patch [1].
>=20
> [1] https://lore.kernel.org/all/20230320103750.60295-20-hal.feng@starfive=
tech.com/
>=20
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index d484ecdf93f7..4c5fdb905da8 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -20,21 +20,12 @@ cpus {
>  		S7_0: cpu@0 {
>  			compatible =3D "sifive,s7", "riscv";
>  			reg =3D <0>;
> -			d-cache-block-size =3D <64>;
> -			d-cache-sets =3D <64>;
> -			d-cache-size =3D <8192>;
> -			d-tlb-sets =3D <1>;
> -			d-tlb-size =3D <40>;
>  			device_type =3D "cpu";
>  			i-cache-block-size =3D <64>;
>  			i-cache-sets =3D <64>;
>  			i-cache-size =3D <16384>;
> -			i-tlb-sets =3D <1>;
> -			i-tlb-size =3D <40>;
> -			mmu-type =3D "riscv,sv39";
>  			next-level-cache =3D <&ccache>;
>  			riscv,isa =3D "rv64imac_zba_zbb";
> -			tlb-split;
>  			status =3D "disabled";
> =20
>  			cpu0_intc: interrupt-controller {
> --=20
> 2.38.1
>=20

--WqfTepoKbm4XihPt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZB30fgAKCRB4tDGHoIJi
0m0jAQDgN9auzDIiU9HW1TSUC9HzDRYLzr+VbgtP30QtgUTeaQEA/UXn5IKUTjFn
P2TdB0HAjMnHLaEvUPI8++IcsnQWdAs=
=x47n
-----END PGP SIGNATURE-----

--WqfTepoKbm4XihPt--
