Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612BB645EEF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiLGQbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLGQbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:31:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C776415;
        Wed,  7 Dec 2022 08:31:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 301D5B81B90;
        Wed,  7 Dec 2022 16:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948CAC433D6;
        Wed,  7 Dec 2022 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670430667;
        bh=XvN8Ts/aGY98RQx6MBG9BJW4THmGenJBnAKFdbfEvqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=grIXzLSeWgfDquG6NpQcjVrZqcnCG3wwRYOCRKHk+W2cdIe+wUHnXajGIXMExoSS9
         4PHxIHKXoVTplMw50ZbIhQYWJ6yJNUTH71wNzzo4Br+p6JnoorOS63spkZlZLQICtL
         X1VNo0K1JuGlyyXUZxDX9vV8ShanaIEu15UqIkMK7CK6yyPd3vHSzSgm5GGrUFWw+a
         btwsMh7jolMibDEHTgL7YFLgW2JeXbvrKYIguEjodrby6J1tvaQNrCOQB56Nt5frTp
         kNsHp0KGyj9h1qRgN1pMVrZL1C/o9084Z2/Op6tsb6pnvg+8B1KxK/VG5wxfGbbefX
         GPRQEoPYjduQQ==
Date:   Wed, 7 Dec 2022 16:31:03 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: Add mmc node
Message-ID: <Y5C/x80p8+6Tosk/@spud>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-4-william.qiu@starfivetech.com>
 <c0b84752-443f-d935-0ed8-c8ed4d212c2e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nYE+9nWOMu6Q6hJB"
Content-Disposition: inline
In-Reply-To: <c0b84752-443f-d935-0ed8-c8ed4d212c2e@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nYE+9nWOMu6Q6hJB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 04:14:53PM +0100, Krzysztof Kozlowski wrote:
> On 07/12/2022 14:17, William Qiu wrote:
> > This adds the mmc node for the StarFive JH7110 SoC.
> > Set sdioo node to emmc and set sdio1 node to sd.
> >=20
> > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> > ---
> >  .../jh7110-starfive-visionfive-v2.dts         | 25 ++++++++++++
> >  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 38 +++++++++++++++++++
> >  2 files changed, 63 insertions(+)
> >=20
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2=
=2Edts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> > index c8946cf3a268..6ef8e303c2e6 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> > @@ -47,6 +47,31 @@ &clk_rtc {
> >  	clock-frequency =3D <32768>;
> >  };
> > =20
> > +&sdio0 {
> > +	max-frequency =3D <100000000>;
> > +	card-detect-delay =3D <300>;
> > +	bus-width =3D <8>;
> > +	cap-mmc-highspeed;
> > +	mmc-ddr-1_8v;
> > +	mmc-hs200-1_8v;
> > +	non-removable;
> > +	cap-mmc-hw-reset;
> > +	post-power-on-delay-ms =3D <200>;
> > +	status =3D "okay";
> > +};
> > +
> > +&sdio1 {
> > +	max-frequency =3D <100000000>;
> > +	card-detect-delay =3D <300>;
> > +	bus-width =3D <4>;
> > +	no-sdio;
> > +	no-mmc;
> > +	broken-cd;
> > +	cap-sd-highspeed;
> > +	post-power-on-delay-ms =3D <200>;
> > +	status =3D "okay";
> > +};
> > +
> >  &gmac0_rmii_refin {
> >  	clock-frequency =3D <50000000>;
> >  };
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot=
/dts/starfive/jh7110.dtsi
> > index c22e8f1d2640..e90b085d7e41 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > @@ -331,6 +331,11 @@ aoncrg: clock-controller@17000000 {
> >  			#reset-cells =3D <1>;
> >  		};
> > =20
> > +		sys_syscon: sys_syscon@13030000 {
>=20
> No underscores in node names, generic node names (syscon or
> system-controller)
>=20
> > +			compatible =3D "syscon";
>=20
> This is not allowed alone.
>=20
> > +			reg =3D <0x0 0x13030000 0x0 0x1000>;
> > +		};
> > +
> >  		gpio: gpio@13040000 {
> >  			compatible =3D "starfive,jh7110-sys-pinctrl";
> >  			reg =3D <0x0 0x13040000 0x0 0x10000>;
> > @@ -433,5 +438,38 @@ uart5: serial@12020000 {
> >  			reg-shift =3D <2>;
> >  			status =3D "disabled";
> >  		};
> > +
> > +		/* unremovable emmc as mmcblk0 */
> > +		sdio0: mmc@16010000 {
> > +			compatible =3D "starfive,jh7110-sdio";
> > +			reg =3D <0x0 0x16010000 0x0 0x10000>;
> > +			clocks =3D <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
> > +				 <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> > +			clock-names =3D "biu","ciu";
> > +			resets =3D <&syscrg JH7110_SYSRST_SDIO0_AHB>;
> > +			reset-names =3D "reset";
> > +			interrupts =3D <74>;
> > +			fifo-depth =3D <32>;
> > +			fifo-watermark-aligned;
> > +			data-addr =3D <0>;
> > +			starfive,sys-syscon =3D <&sys_syscon 0x14 0x1a 0x7c000000>;
>=20
> This does not match your bindings at all. "&sys_syscon" is a phandle,
> not a number of tuning retries, as you expect in your bindings.

Additionally, a Link: to the documentation for where-ever these "random"
numbers that are being used would be nice.

+static int dw_mci_starfive_parse_dt(struct dw_mci *host)
+{
+	struct of_phandle_args args;
+	struct starfive_priv *priv;
+	int ret;
+
+	priv =3D devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret =3D of_parse_phandle_with_fixed_args(host->dev->of_node,
+						"starfive,sys-syscon", 3, 0, &args);
+	if (ret) {
+		dev_err(host->dev, "Failed to parse starfive,sys-syscon\n");
+		return -EINVAL;
+	}
+
+	priv->reg_syscon =3D syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
+	if (IS_ERR(priv->reg_syscon))
+		return PTR_ERR(priv->reg_syscon);
+
+	priv->syscon_offset =3D args.args[0];
+	priv->syscon_shift  =3D args.args[1];
+	priv->syscon_mask   =3D args.args[2];

Given the driver, the property description just seems incorrect and this
is actually the bit of the syscon that is relevant to the tuning process
(perhaps where the find the tuning values?). Without public docs or a
better description it is hard for (me at least) to know :)

+
+	host->priv =3D priv;
+
+	return 0;
+}

--nYE+9nWOMu6Q6hJB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY5C/xwAKCRB4tDGHoIJi
0jk2AP9Do21/KrvdLHeize3eZ8BVU/CtKfDVdT3HO5AAwF0HvQEAkVhgyA+vpmpH
+06lNw1rMoHAqo+Po4oo80d5HRfPCAs=
=xHlT
-----END PGP SIGNATURE-----

--nYE+9nWOMu6Q6hJB--
