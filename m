Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7225B8F70
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiINUAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiINUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:00:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA13221E3A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 13:00:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYYY5-0003Q5-Ss; Wed, 14 Sep 2022 21:59:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYYY5-000ksF-Sj; Wed, 14 Sep 2022 21:59:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYYY3-000w08-9p; Wed, 14 Sep 2022 21:59:51 +0200
Date:   Wed, 14 Sep 2022 21:59:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 2/4] riscv: dts: fix the icicle's #pwm-cells
Message-ID: <20220914195946.eadkppkgqwgwdace@pengutronix.de>
References: <20220824091215.141577-1-conor.dooley@microchip.com>
 <20220824091215.141577-3-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xhs4rna6j2neqkiv"
Content-Disposition: inline
In-Reply-To: <20220824091215.141577-3-conor.dooley@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xhs4rna6j2neqkiv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Aug 24, 2022 at 10:12:13AM +0100, Conor Dooley wrote:
> \#pwm-cells for the Icicle kit's fabric PWM was incorrectly set to 2 &
> blindly overridden by the (out of tree) driver anyway. The core can
> support inverted operation, so update the entry to correctly report its
> capabilities.
>=20
> Fixes: 72560c6559b8 ("riscv: dts: microchip: add fpga fabric section to i=
cicle kit")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/=
arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
> index 0d28858b83f2..e09a13aef268 100644
> --- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
> +++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
> @@ -8,7 +8,7 @@ core_pwm0: pwm@41000000 {
>  		compatible =3D "microchip,corepwm-rtl-v4";
>  		reg =3D <0x0 0x41000000 0x0 0xF0>;
>  		microchip,sync-update-mask =3D /bits/ 32 <0>;
> -		#pwm-cells =3D <2>;
> +		#pwm-cells =3D <3>;
>  		clocks =3D <&fabric_clk3>;
>  		status =3D "disabled";
>  	};

there are no phandles on that PWM, so there is nothing that needs a
followup adaption.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xhs4rna6j2neqkiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMiMq8ACgkQwfwUeK3K
7Ak7Zwf+OlC3O2dW/x6W5h0S9s75i5/nHm6Qx6dJ+U0/9ukUC7hv6MpgLDPI08d4
MQwDXMwEZ3G1Y/UnlbOKWRhtqI3lJ+CPy3yvjpnL5JfmuOh2dpAApo2qjOTZUhqA
MW7+voTOO667MO4uTXK2BEm+2mbT5NQUkvpGK/EOyPMADNo/VOVu/+c6oQu42v9f
G7trOzs9N5WUSZ6egtXHuY53p5LU1I0yReOzWPZsE03JN0xMUJWp3itac/mb7jU/
5ANyCAfTNzhZG9AGCv6jVnk5wSvlglLYV243HG/tELYR5cULQuxhSdY+IwSZmfXq
JtnxMFPz+BxcgoLtxTFO+/Tb31Nr0Q==
=l8aw
-----END PGP SIGNATURE-----

--xhs4rna6j2neqkiv--
