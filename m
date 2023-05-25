Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09494711951
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbjEYVmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjEYVmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:42:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF9E99;
        Thu, 25 May 2023 14:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B07164B50;
        Thu, 25 May 2023 21:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCC5C433EF;
        Thu, 25 May 2023 21:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685050971;
        bh=FjzpokD3KlPp8OLgmScsmPYAiivMUvZd0d1dgeN/VZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJoyh+4n68Ju6BaUjIkoD3sxPvcYo48wGZOVliY/Qu5DJK2G8lxGnOhq0PfX6XdHg
         PrxvI42P/D4vV/+J3ljjgB2+p9eNhClm1ROwAa72bND4XzUJc+IiMkz7VY7/YHNSJE
         qeJC8d9HwMEzfpkb9KRxUzoHpzH7DH7nMOQyTgwX7XWcrrujDbXu1foblWM9mXi2x1
         Gsy3oHLog8I4eL2JMhJhRlRfxxtZ6I6J2/RQFsqLoHh4wyCgzfD+tPhLFsinVpEFRd
         aOeZSfWeBwcAGoLQKl2RRuu/ifXDJpF/hazBAFos9poa1PJrDGqHjqHM6fCsBZn26q
         hkyW07t/y2KPQ==
Date:   Thu, 25 May 2023 22:42:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 09/11] riscv: dts: starfive: jh7110: add pmu
 controller node
Message-ID: <20230525-unwarlike-mule-f37ec29cf7c5@spud>
References: <20230518101234.143748-1-xingyu.wu@starfivetech.com>
 <20230518101234.143748-10-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ammaxlZe6GO1q9SH"
Content-Disposition: inline
In-Reply-To: <20230518101234.143748-10-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ammaxlZe6GO1q9SH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 06:12:32PM +0800, Xingyu Wu wrote:
> From: Walker Chen <walker.chen@starfivetech.com>
>=20
> Add the pmu controller node for the Starfive JH7110 SoC. The PMU needs
> to be used by other modules such as VPU, ISP, etc.
>=20
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>

Firstly, this is missing your SoB - but more importantly this is already
in my tree as 6a887bcc4138 ("riscv: dts: starfive: Add PMU controller
node").

Thanks,
Conor.

> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 4c5fdb905da8..30e1f34d5cf8 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -496,5 +496,12 @@ aongpio: pinctrl@17020000 {
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  		};
> +
> +		pwrc: power-controller@17030000 {
> +			compatible =3D "starfive,jh7110-pmu";
> +			reg =3D <0x0 0x17030000 0x0 0x10000>;
> +			interrupts =3D <111>;
> +			#power-domain-cells =3D <1>;
> +		};
>  	};
>  };
> --=20
> 2.25.1
>=20

--ammaxlZe6GO1q9SH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG/WVQAKCRB4tDGHoIJi
0utfAP4iYxhTjF7eRb0ilQrW5LNMGhk1Qr4ecLfvdWIrU21NsAEA1DnG2vnKfoRI
nCZWaxxfvH6O1DXPEMFiiEh8Evllvgk=
=MphS
-----END PGP SIGNATURE-----

--ammaxlZe6GO1q9SH--
