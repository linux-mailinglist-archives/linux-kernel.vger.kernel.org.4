Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14BC6A4BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjB0T4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjB0T4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:56:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C91265AB;
        Mon, 27 Feb 2023 11:56:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0CDAB80DB5;
        Mon, 27 Feb 2023 19:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DADC433EF;
        Mon, 27 Feb 2023 19:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677527759;
        bh=DjIqsPnT/P7Nb9ik2W2lylfV6VqLezNxb1W9cXM7Lok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTo7yHiyyI0Iy/gk4xwQhWsCnctsjKnYmAGkr3S4rZhc+RuLbBft/Wga1az1DY8Zy
         21Bsjdmdcu5hUF2sH3sN72xRIAPgGqlsYLEKe0O7eDoL0DqfAvVSGYO28AZvGxWpFV
         Ugn74Yf/7PWlP7ppFhVMxIpa61KispFq6koVNg385RN0iqw8MVo/ZqoFRVuBaZLfOQ
         zdgSPR+nOaKc0sdUewRstc1fal75bStw+jVMt123XVsAiTXucWfe+fowhCRNQHTrX3
         a4EJpS/i1tVheHQPiBFoZbn/DtDfyf7+FgbFvAgoriKrWSDfesTbJ+ZmCVS+1QAZvM
         +LI1vycra9sCg==
Date:   Mon, 27 Feb 2023 19:55:53 +0000
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
Subject: Re: [PATCH v2 10/11] riscv: dts: starfive: jh7110: Add DVP and HDMI
 TX pixel external clocks
Message-ID: <Y/0KyeK3DU8xtL2V@spud>
References: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
 <20230221083323.302471-11-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="80O6WFjF/KFbBM/N"
Content-Disposition: inline
In-Reply-To: <20230221083323.302471-11-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--80O6WFjF/KFbBM/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 04:33:22PM +0800, Xingyu Wu wrote:
> Add DVP and HDMI TX pixel external fixed clocks and the rates are
> 74.25MHz and 297MHz.
>=20
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../dts/starfive/jh7110-starfive-visionfive-2.dtsi   |  8 ++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi             | 12 ++++++++++++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index c2aa8946a0f1..27af817a55aa 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -86,6 +86,14 @@ &mclk_ext {
>  	clock-frequency =3D <12288000>;
>  };
> =20
> +&dvp_clk {
> +	clock-frequency =3D <74250000>;
> +};
> +
> +&hdmitx0_pixelclk {
> +	clock-frequency =3D <297000000>;
> +};
> +
>  &uart0 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&uart0_pins>;
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 005ead2624d4..a5e6fb3ad188 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -245,6 +245,18 @@ mclk_ext: mclk-ext-clock {
>  		#clock-cells =3D <0>;
>  	};
> =20
> +	dvp_clk: dvp-clk-clock {
> +		compatible =3D "fixed-clock";
> +		clock-output-names =3D "dvp_clk";
> +		#clock-cells =3D <0>;
> +	};
> +
> +	hdmitx0_pixelclk: hdmitx0-pixelclk-clock {
> +		compatible =3D "fixed-clock";
> +		clock-output-names =3D "hdmitx0_pixelclk";
> +		#clock-cells =3D <0>;
> +	};
> +

Hmm, would you mind adding these entries with no unit addresses in
alphanumerical order? Both in the soc & board dtsi files.

Thanks,
Conor.

--80O6WFjF/KFbBM/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/0KyQAKCRB4tDGHoIJi
0knlAP4gxK3Mbjl2AkyLpBX/t9oBm8JZ4D9vjdv9xR18sXlfWAEAyd9ChdmJfaU+
6uId/QPwKqq/N0jQBRejvZsi+pIjngA=
=tSXU
-----END PGP SIGNATURE-----

--80O6WFjF/KFbBM/N--
