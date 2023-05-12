Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01286701227
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 00:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbjELW1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 18:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjELW1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 18:27:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADE01FDA;
        Fri, 12 May 2023 15:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03378652F3;
        Fri, 12 May 2023 22:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA94C433D2;
        Fri, 12 May 2023 22:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683930468;
        bh=yotOQtdEH6rCCF1UokNJsyz14i9QXPrLX0CaR5Gj1jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QOkQfjvbQElQo2Q2BSeL3euoR4smHoogkxZNaHfne7A75YEbUtQYzHRXiX7P1ETxi
         AJnA0P3BO4rK0q8+YmVSkEQWsGsvGB6pxlSAiTYgLkRukaCPACbi7AMBQlr8TTkNjZ
         Ep0U58R2PwWtuJSWG5u44UIPOeAH+U5OcRCpJAdENH0tbmZW3+DypvM4peUl6YWCYR
         TcDAupbBd/yQS0h1q8BuXA+mZLXsKDPBrTjit914UHuvy0fE4FPiLt030zL6GRb1WV
         L2BduV/N74pCi6Sa8CxsNBNDQzSIzutQHRu1F2KWbzKNudFqgtFycK8/qY6PAEI2oq
         hrWA5nkASuonw==
Date:   Fri, 12 May 2023 23:27:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, walker.chen@starfivetech.com
Subject: Re: [PATCH v1 2/2] riscv: dts: starfive: jh7110: Add watchdog node
Message-ID: <20230512-barrack-catchable-1f4072b9355b@spud>
References: <20230509151723.84989-1-xingyu.wu@starfivetech.com>
 <20230509151723.84989-3-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8JU6x6woKhLCHwoo"
Content-Disposition: inline
In-Reply-To: <20230509151723.84989-3-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8JU6x6woKhLCHwoo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 11:17:23PM +0800, Xingyu Wu wrote:
> Add the watchdog node for the Starfive JH7110 SoC.

Emil or Walker, could I get a review on this please?
It's the only dts patch on the list right now for the jh7110 that I can
actually apply, so it'd be nice to do so.

Thanks,
Conor.

>=20
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 4c5fdb905da8..47c163ec0bf1 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -469,6 +469,16 @@ sysgpio: pinctrl@13040000 {
>  			#gpio-cells =3D <2>;
>  		};
> =20
> +		watchdog@13070000 {
> +			compatible =3D "starfive,jh7110-wdt";
> +			reg =3D <0x0 0x13070000 0x0 0x10000>;
> +			clocks =3D <&syscrg JH7110_SYSCLK_WDT_APB>,
> +				 <&syscrg JH7110_SYSCLK_WDT_CORE>;
> +			clock-names =3D "apb", "core";
> +			resets =3D <&syscrg JH7110_SYSRST_WDT_APB>,
> +				 <&syscrg JH7110_SYSRST_WDT_CORE>;
> +		};
> +
>  		aoncrg: clock-controller@17000000 {
>  			compatible =3D "starfive,jh7110-aoncrg";
>  			reg =3D <0x0 0x17000000 0x0 0x10000>;
> --=20
> 2.25.1
>=20

--8JU6x6woKhLCHwoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF69XwAKCRB4tDGHoIJi
0udqAP4tKOaHjuSPwwqts5hXwNP+jpgONumVl4re6oLMfdh5fAEA4kRfEXdNqmD1
pUcjCp6fw2W4wFgttfmyY+0JRcLSRQ8=
=nlcN
-----END PGP SIGNATURE-----

--8JU6x6woKhLCHwoo--
