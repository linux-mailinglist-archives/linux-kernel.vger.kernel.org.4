Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299D2693262
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjBKQWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBKQWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:22:41 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71346C156;
        Sat, 11 Feb 2023 08:22:40 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 18F731C0AB3; Sat, 11 Feb 2023 17:22:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1676132558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9MA2R+ukwKIZdrFyWQ9sTnRT2vNwccSFG0gi0U7XPxI=;
        b=AOsavdwZV2EmOlJUcSrj4r+eIstCnlFpC/VQ6vuEtrcjXeWcHhv+3BAZGTqb1yi2lknd+W
        EiN6hrFdWdgx3VCNBDJygHi7iLeN9jnjp/xEBc/EXs0LyPrNAn6PHUhpMfSX3nmBhiC35i
        x1O9coyTodbBDDPZEi4pMrfpfTv/CHs=
Date:   Sat, 11 Feb 2023 17:22:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add
 notification LED
Message-ID: <Y+fAzHJ8IYc7J0Vv@duo.ucw.cz>
References: <20230122-msm8974-bacon-features-v1-0-4049f565c24c@z3ntu.xyz>
 <20230122-msm8974-bacon-features-v1-5-4049f565c24c@z3ntu.xyz>
 <02e5bf79-3e2d-02c8-67e7-61bbff32ba29@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bW9GpFOL43NjRAIR"
Content-Disposition: inline
In-Reply-To: <02e5bf79-3e2d-02c8-67e7-61bbff32ba29@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bW9GpFOL43NjRAIR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Unfortunately the driver currently supports neither multicolor API nor
> > using the properties function & color, so we use label instead.
> >=20
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >  .../arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 28 ++++++++++++++=
++++++++
> >  1 file changed, 28 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts b/arch=
/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
> > index ffb486ceb6a6..a672c45d7070 100644
> > --- a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
> > +++ b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
> > @@ -114,6 +114,34 @@ led@0 {
> >  			default-brightness =3D <80>;
> >  		};
> >  	};
> > +
> > +	led-controller@68 {
> > +		compatible =3D "si-en,sn3193";
> > +		reg =3D <0x68>;
> > +
> > +		shutdown-gpios =3D <&tlmm 45 GPIO_ACTIVE_HIGH>;
> > +
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		led@1 {
> > +			reg =3D <1>;
> > +			label =3D "red:status";
>=20
> These should be colors and functions.

Yep. Plus this is one LED, not three, so it should use the multicolor
class.

And then we should have an entry in
Documentation/leds/well-known-leds.txt so that we have same ABI on all
the phones.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--bW9GpFOL43NjRAIR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY+fAzAAKCRAw5/Bqldv6
8kP9AJ9bQSFFlPkmtgHnZ4ko2yKeOT7z0QCfY/T9jkp9mOxkiIa2zbuslhnk1Ag=
=/jxy
-----END PGP SIGNATURE-----

--bW9GpFOL43NjRAIR--
