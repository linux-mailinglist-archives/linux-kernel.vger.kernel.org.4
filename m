Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8173A8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjFVTTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjFVTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:19:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D78CEA;
        Thu, 22 Jun 2023 12:18:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2952B618E3;
        Thu, 22 Jun 2023 19:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6573EC433C8;
        Thu, 22 Jun 2023 19:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687461538;
        bh=ybabzQEiU1jUWVXW9BBypST+YvZoqUjQP5qCTQf4nps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPJxKIhMSMfwvH5DktiLadi8u7k0A+Ej12hAhFdGWPeqKOv0+Ta6oMpATVq1PxRIY
         3dTFgq46Wj9JvG0A8Zkr0UigN/3+PSTsoooRb2IfQ0IG7+3yhyCy9Vyv/n0GaGTAQK
         DBvVLV/7jjKucLr7Jr+GMC/0kHn1CenHUL02OBZk1h7LL5y+vhp64C3jhcHAFiJsFO
         T2kfOubKEBGSoEDtmCBNc4sINJp/wb9rD1f3f9j+HDoghsNRTgULoWChyBFzRhget0
         Sm2je1TXP9q4Ob/MppIrYXlAH8VOJMsLV8mbMR8wOF6oTsbZoR2Nx60Tg8oiSiR3q3
         3dWnmlBbM3DPA==
Date:   Thu, 22 Jun 2023 20:18:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     kah.jing.lee@intel.com
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: Re: [PATCH 1/2] arch: arm64: boot: dts: Updated QSPI Flash layout
 for UBIFS
Message-ID: <20230622-campsite-uncloak-37c292c37862@spud>
References: <20230622085319.562868-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NOZVfU//uCalvVia"
Content-Disposition: inline
In-Reply-To: <20230622085319.562868-1-kah.jing.lee@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NOZVfU//uCalvVia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 04:53:19PM +0800, kah.jing.lee@intel.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
>=20
> This patch is to update the QSPI flash layout to support UBIFS in mtd
> root partition.

That much is clear from the diff. Surely it'd be better to explain *why*
this change is being made, no?

Thanks,
Conor.

>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 8 ++++----
>  arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arc=
h/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> index 38ae674f2f02..12b960b9183c 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> @@ -202,12 +202,12 @@ partitions {
> =20
>  			qspi_boot: partition@0 {
>  				label =3D "Boot and fpga data";
> -				reg =3D <0x0 0x03FE0000>;
> +				reg =3D <0x0 0x04200000>;
>  			};
> =20
> -			qspi_rootfs: partition@3FE0000 {
> -				label =3D "Root Filesystem - JFFS2";
> -				reg =3D <0x03FE0000 0x0C020000>;
> +			root: partition@4200000 {
> +				label =3D "Root Filesystem - UBIFS";
> +				reg =3D <0x04200000 0x0BE00000>;
>  			};
>  		};
>  	};
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/ar=
m64/boot/dts/intel/socfpga_agilex_socdk.dts
> index 07c3f8876613..608017e6e36a 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> @@ -128,12 +128,12 @@ partitions {
> =20
>  			qspi_boot: partition@0 {
>  				label =3D "Boot and fpga data";
> -				reg =3D <0x0 0x03FE0000>;
> +				reg =3D <0x0 0x04200000>;
>  			};
> =20
> -			qspi_rootfs: partition@3FE0000 {
> -				label =3D "Root Filesystem - JFFS2";
> -				reg =3D <0x03FE0000 0x0C020000>;
> +			root: partition@4200000 {
> +				label =3D "Root Filesystem - UBIFS";
> +				reg =3D <0x04200000 0x0BE00000>;
>  			};
>  		};
>  	};
> --=20
> 2.25.1
>=20

--NOZVfU//uCalvVia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJSengAKCRB4tDGHoIJi
0iIHAQDqf/4QTbMLRWbau04J+oH+gmsUEGjqswKbSS1iRPgujQD/WYs72WN7X8cQ
Kyh5apQuOAG+A15BRctp0ltJ/65I+Ac=
=vLev
-----END PGP SIGNATURE-----

--NOZVfU//uCalvVia--
