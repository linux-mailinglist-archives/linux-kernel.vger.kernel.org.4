Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A265E8AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjAEKME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjAEKL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:11:59 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC829167D9;
        Thu,  5 Jan 2023 02:11:57 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 745C94000D;
        Thu,  5 Jan 2023 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672913516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HcbHSpYObowCaPT4UZ67tf0/71I4pFvPVyqK6Lz3L44=;
        b=jXzx+L6tMjJ/USRyD6sSJATAagtFUQ4jkgSTOgGoJn4Gwcyvp4mF8bUmipoeszJb48ECR0
        pfK7EITgdG0LtJ+xY9uNyVKlJ6Pz5w1BK6x82rh5BSM7I4dhBROudBF6FEbt2VZ+nnkohR
        +1b4RgGssBKe9cfJAq33LDfZm6FKRS45r2s9/SKq+9aSKhpr9HnHZu6vYRgRAJCJ/5fR0d
        N7aJu9yYvUsLYHXHIo9FhEmlkCLgP5PjGMlwA+cJKBIfvUb2SMV3ItTV6vXXBp8l51zWEx
        QL5m4YB0sWbk1uIFDlePYihSEAp83TsknTSdEX9BgQwlFfbrMEgFn7GkAQggyA==
Date:   Thu, 5 Jan 2023 11:11:49 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/4] riscv: dts: allwinner: d1: Add video engine node
Message-ID: <Y7aiZdjI8L5h1Ca3@aptenodytes>
References: <20221231164628.19688-1-samuel@sholland.org>
 <20221231164628.19688-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uvNAlR/ImeHHAZfH"
Content-Disposition: inline
In-Reply-To: <20221231164628.19688-5-samuel@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uvNAlR/ImeHHAZfH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Sat 31 Dec 22, 10:46, Samuel Holland wrote:
> D1 contains a video engine which is supported by the Cedrus driver.

Does it work "outside the box" without power domain management?
If not, it might be a bit confusing to add the node at this point.

Cheers,

Paul
=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/ris=
cv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> index dff363a3c934..4bd374279155 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -34,6 +34,17 @@ soc {
>  		#address-cells =3D <1>;
>  		#size-cells =3D <1>;
> =20
> +		ve: video-codec@1c0e000 {
> +			compatible =3D "allwinner,sun20i-d1-video-engine";
> +			reg =3D <0x1c0e000 0x2000>;
> +			interrupts =3D <SOC_PERIPHERAL_IRQ(66) IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_VE>,
> +				 <&ccu CLK_VE>,
> +				 <&ccu CLK_MBUS_VE>;
> +			clock-names =3D "ahb", "mod", "ram";
> +			resets =3D <&ccu RST_BUS_VE>;
> +		};
> +
>  		pio: pinctrl@2000000 {
>  			compatible =3D "allwinner,sun20i-d1-pinctrl";
>  			reg =3D <0x2000000 0x800>;
> --=20
> 2.37.4
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--uvNAlR/ImeHHAZfH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmO2omUACgkQ3cLmz3+f
v9HoZQf/dl3gdDFnL9ptToBux9CndvEW3DuATq08dsu8Tuomejp5iBjKgLFwl1qW
B5pIbqJw3GD3OKjU0qHE5Y0bjYg9wWKVQf48VY5tAE5xnM+uae1Rijw64Rvj1ZM0
zjUCHo39JknTfE6kH8lXOkK1oxRfwqHs7oaAps/jZ2CPs/DBOPYhx/OhhvWqfui2
QvZHgD/PqhGuYS9a7+G4mczarvORKkG36ICiHmBh5JxLkpvG/5B+KEH6CE5wyAdt
E846talSC/BKaiMBngOwgQxLCHsVuROOBsxyfhVpgsWmQpyvDLmqLK+Ak0dgKby6
9PH3omA3Vc7/cGWT64Yd1JglMkiD8w==
=EMF0
-----END PGP SIGNATURE-----

--uvNAlR/ImeHHAZfH--
