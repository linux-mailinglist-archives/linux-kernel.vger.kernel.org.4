Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB246E6AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjDRR2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjDRR2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:28:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EF9E48;
        Tue, 18 Apr 2023 10:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A740F61202;
        Tue, 18 Apr 2023 17:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45827C433D2;
        Tue, 18 Apr 2023 17:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681838886;
        bh=QCLMTGp0pSAawzsOxfqUZWtyxa1SJnm6R5Qw5FlWiBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uajfv6Bwv+DD9Vq+CBn1cSZzOAhNjxs/u0hDkHONopDzprf3D+R802y8LyxP7Axon
         qJHKI8fH26kJHfUplSOuPamB6lmAygGxhqpCxi2wBKQSmOnQB7v3uCAXossgh/KMPZ
         INkYU72upEymEGPZSfFJrjTiLGPdQdH18tsrCXbu6+JMLz7ePZYzj1ruFDnsquBDJy
         BzU8GbNffHY01LIbbPjRejT9+1bs2/yPPIK5lcv2xDNh/Asdq98ARGXs5mgcMHRzGZ
         PHyFfBxhZjyco+9k0ioy5ObdPJTrLC1xvHVGcHljsKBRVkhd1ZVdF8YB+JjXsm7JTp
         5lyv7LgnxzNBw==
Date:   Tue, 18 Apr 2023 18:28:00 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mason Huo <mason.huo@starfivetech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] riscv: dts: starfive: Add cpu scaling for JH7110
 SoC
Message-ID: <20230418-talcum-unthread-618a5bd2758a@spud>
References: <20230417063942.3141-1-mason.huo@starfivetech.com>
 <20230417063942.3141-4-mason.huo@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YJMzqe/hzL7IbIYs"
Content-Disposition: inline
In-Reply-To: <20230417063942.3141-4-mason.huo@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YJMzqe/hzL7IbIYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Mason,

Just one minor comment in passing..

On Mon, Apr 17, 2023 at 02:39:42PM +0800, Mason Huo wrote:
> Add the operating-points-v2 to support cpu scaling on StarFive JH7110 SoC.
> It supports up to 4 cpu frequency loads.
>=20
> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 17 ++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 33 +++++++++++++++++++
>  2 files changed, 50 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index cca1c8040801..b25e6d68ce53 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -227,3 +227,20 @@ &uart0 {
>  	pinctrl-0 =3D <&uart0_pins>;
>  	status =3D "okay";
>  };
> +
> +&U74_1 {
> +	cpu-supply =3D <&vdd_cpu>;
> +};
> +
> +&U74_2 {
> +	cpu-supply =3D <&vdd_cpu>;
> +};
> +
> +&U74_3 {
> +	cpu-supply =3D <&vdd_cpu>;
> +};
> +
> +&U74_4 {
> +	cpu-supply =3D <&vdd_cpu>;
> +};
> +

Applying: riscv: dts: starfive: Add cpu scaling for JH7110 SoC
/stuff/linux/.git/rebase-apply/patch:30: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

Cheers,
Conor.


--YJMzqe/hzL7IbIYs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZD7TDAAKCRB4tDGHoIJi
0nCIAQCGgCe1FJP8wpMrSgS8zFRx/3XZ/tG/QuMA8ezQyFQiwQD9E+NV9PcHcbsD
Ws7d9iEVlnQj6SVvRbx4tpMKsAV1ew0=
=1AIw
-----END PGP SIGNATURE-----

--YJMzqe/hzL7IbIYs--
