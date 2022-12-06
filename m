Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA269644359
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiLFMme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiLFMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:42:22 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99AB2A25E;
        Tue,  6 Dec 2022 04:42:14 -0800 (PST)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5052E85453;
        Tue,  6 Dec 2022 13:42:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1670330531;
        bh=iI5SeUL51UC7eISdgdq26IjAocTkIL/OIraEMeV0ztw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kohTwBtNeMzWD5rKFY2zLgtxNV3zwHgzPawC0atjqRcJLpxirfFpg13Hq82Zwlamu
         sfG576AIyFhd/Y/MTkXpXEnLyuM+Zk9sC/hSq1SPR8vCaVL4EnDUdWyaApDZb5s27p
         YAnrTzcZdILPc37J49JVyzpBuiShP8+xmX55o7rEVlH7cxE7PZXcOvonhLMUeedo3q
         CtiVJdkmWSLBAQJN6rYBO7RdsT1BbqwBzYB1uws42EYmwaGMvKpPFxZn7atebPiuUP
         /CYp2V0pE+b7s1z+DnntkIPisnI5a62ezTyrL82FZCx252xmaDV0+TWNdHMtXwVwqF
         USZMAjXhOD3VQ==
Date:   Tue, 6 Dec 2022 13:42:01 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Quentin Schulz <foss+kernel@0leil.net>,
        Samuel Holland <samuel@sholland.org>,
        Bastien Nocera <hadess@hadess.net>,
        Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Angus Ainslie <angus@akkea.ca>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Andy Gross <agross@kernel.org>,
        Aleksei Mamlin <mamlinav@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        David Jander <david@protonic.nl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 4/9] ARM: dts: imx: fix touchscreen reset GPIO
 polarity
Message-ID: <20221206134201.703ad352@wsk>
In-Reply-To: <b37272ae-a939-1dce-de47-e237c6363a0f@kontron.de>
References: <20221103-upstream-goodix-reset-v3-0-0975809eb183@theobroma-systems.com>
        <20221103-upstream-goodix-reset-v3-4-0975809eb183@theobroma-systems.com>
        <b37272ae-a939-1dce-de47-e237c6363a0f@kontron.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wSkO.yKQ_Y+Ill11MbjpZ3n";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wSkO.yKQ_Y+Ill11MbjpZ3n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Dec 2022 12:25:29 +0100
Frieder Schrempf <frieder.schrempf@kontron.de> wrote:

> On 05.12.22 14:40, Quentin Schulz wrote:
> > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> >=20
> > The reset line is active low for the Goodix touchscreen controller
> > so let's fix the polarity in the Device Tree node.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > ---
> >  arch/arm/boot/dts/imx6q-kp.dtsi            | 2 +-
> >  arch/arm/boot/dts/imx6ul-kontron-bl-43.dts | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi
> > b/arch/arm/boot/dts/imx6q-kp.dtsi index
> > 1ade0bff681d6..dae14aaf803a8 100644 ---
> > a/arch/arm/boot/dts/imx6q-kp.dtsi +++
> > b/arch/arm/boot/dts/imx6q-kp.dtsi @@ -188,7 +188,7 @@
> > touchscreen@5d { interrupt-parent =3D <&gpio1>;
> >  		interrupts =3D <9 IRQ_TYPE_EDGE_FALLING>;
> >  		irq-gpios =3D <&gpio1 9 GPIO_ACTIVE_HIGH>;
> > -		reset-gpios =3D <&gpio5 2 GPIO_ACTIVE_HIGH>;
> > +		reset-gpios =3D <&gpio5 2 GPIO_ACTIVE_LOW>;
> >  	};
> > =20
> >  	ds1307: rtc@32 {
> > diff --git a/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts
> > b/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts index
> > 0c643706a158b..767ef5da76136 100644 ---
> > a/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts +++
> > b/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts @@ -29,7 +29,7 @@
> > touchscreen@5d { pinctrl-0 =3D <&pinctrl_cap_touch>;
> >  		interrupt-parent =3D <&gpio5>;
> >  		interrupts =3D <6 IRQ_TYPE_LEVEL_LOW>;
> > -		reset-gpios =3D <&gpio5 8 GPIO_ACTIVE_HIGH>;
> > +		reset-gpios =3D <&gpio5 8 GPIO_ACTIVE_LOW>;
> >  		irq-gpios =3D <&gpio5 6 GPIO_ACTIVE_HIGH>;
> >  	};
> >  }; =20
>=20
> The imx6ul-kontron-bl-43.dts misses a working panel node, so I'm
> pretty sure it is not used and nobody will bother about change
> breaking compatibility. I don't have the hardware at hand at the
> moment to perform a test, so for now:
>=20
> Acked-by: Frieder Schrempf <frieder.schrempf@kontron.de> #
> imx6ul-kontron-bl-43.dts

Reviewed-by: Lukasz Majewski <lukma@denx.de>

For imx6 TPC70 device.

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/wSkO.yKQ_Y+Ill11MbjpZ3n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmOPOJkACgkQAR8vZIA0
zr3LxAf/cTdBTk+iiToN5yxnqM4qT8HJEan6BzkjWYMZcb6PMMKqHZW+Zsr/SP8o
O+3ChkrLogmz7NjwQqaA09s4IIqYJA5+Wfqd/AqYxjoed5hnRK7tsItBPzJtBmtc
wHxhAkrz/cMcALf8pTfzM3SL1dTB4y+8rPr7O1vhMGS7GPTZMdfXa0WU/QGi6TtZ
GgBZjk8Qutd0SjxaHiqH0FuciHrBNXGX3cLKytigm+WFgtqSFYw9+cU41SyN1Kdx
TodH+8TTz1tURnTAd5vBcq8INdx9N0C2xyeq228bGO2xfnGxjsuOmA00EUzsOmbU
pp/MnwgcQS0r4qXma8E7t1o19CU7Dg==
=buG3
-----END PGP SIGNATURE-----

--Sig_/wSkO.yKQ_Y+Ill11MbjpZ3n--
