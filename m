Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4918711939
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbjEYVgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjEYVgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:36:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DF0FB;
        Thu, 25 May 2023 14:36:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C03964B5F;
        Thu, 25 May 2023 21:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF05C433D2;
        Thu, 25 May 2023 21:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685050604;
        bh=fTgLUP/spX/1v/xhm+T8su551vODX+MVDzEHLjJVyC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6HB27VGJXeCbOAxlYtTT4a/HviFAW5evDIB38A/SneV95u29fkdGgrymnoPTo9I+
         N+1wGdd2laYimC/zV2VmgRYK0AxX7Z4cJFe5S6azRUhhQ0ikqPnaR0tVA+w31A/nld
         3aoR4MKfsMFBp0nYThfSCYlSUOV/GTkQnfRDr+3Xhm9Q31tEqI1QwTYy/Ylw5sCGZr
         iPhV8IKeaVW5UOlpgf+fDQ2HMupdEVzNe0dWTYF1Qfzn8ch9qm5j6gYjBMJumbt4bW
         geZTTXszI+HNd1PJlJt0hTGxbH7aY4sE2RUSKE1MkUPLqKgDlsOjv0WHs1Ar1rEwqB
         1sidF7owc0fWQ==
Date:   Thu, 25 May 2023 22:36:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v6 7/7] riscv: dts: starfive: Add USB dts configuration
 for JH7110
Message-ID: <20230525-cross-daybreak-24dfed69e5d0@spud>
References: <20230518112750.57924-1-minda.chen@starfivetech.com>
 <20230518112750.57924-8-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Vw7uD/P9k0KbWgXU"
Content-Disposition: inline
In-Reply-To: <20230518112750.57924-8-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vw7uD/P9k0KbWgXU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greg,

On Thu, May 18, 2023 at 07:27:50PM +0800, Minda Chen wrote:
> Add USB wrapper layer and Cadence USB3 controller dts
> configuration for StarFive JH7110 SoC and VisionFive2
> Board.
> USB controller connect to PHY, The PHY dts configuration
> are also added.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 71a8e9acbe55..b65f06c5b1b7 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -366,6 +366,59 @@
>  			status =3D "disabled";
>  		};
> =20
> +		usb0: usb@10100000 {
> +			compatible =3D "starfive,jh7110-usb";
> +			ranges =3D <0x0 0x0 0x10100000 0x100000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			starfive,stg-syscon =3D <&stg_syscon 0x4>;
> +			clocks =3D <&stgcrg JH7110_STGCLK_USB0_LPM>,

Please don't pick this patch, if the rest of the series is applicable,
as this will break building the dtb as stgcrg does not yet exist in any
maintainer tree.

Thanks,
Conor.

--Vw7uD/P9k0KbWgXU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG/U5gAKCRB4tDGHoIJi
0kaRAP4zsAQYWPoPnIY4GaVky+W0yED4WO9LFF+YaELQTfg7DQEAzHPY2f/ioXn1
ujSP13F9xiLniw+VP2XQjb6uPGHmOwc=
=LWIh
-----END PGP SIGNATURE-----

--Vw7uD/P9k0KbWgXU--
