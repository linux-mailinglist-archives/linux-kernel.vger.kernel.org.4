Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A4E69328A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBKQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBKQkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:40:18 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504D52116;
        Sat, 11 Feb 2023 08:40:17 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 270C31C0AB3; Sat, 11 Feb 2023 17:40:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1676133616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3h0VX5bASt3ctXi2byYNb7ypoULGRSu0WCTdkOgs5uk=;
        b=eXUhmpyCBHnZ2ZK6rh74BL1hESFgCe5Bca+vyIaoveiTyFI8Vrkz930LnxtFEXCkvYQTzP
        Sq7j0w1nZWJdUzmKXl7KAMmO15CTbInQOplCIim0sGTrSa3bHMKvSzmLPbkCIt77Ze4yj1
        rS3CY0Ks9RRntSDbq0VWmnJ2NmagZt0=
Date:   Sat, 11 Feb 2023 17:40:14 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Gergo Koteles <soyer@irl.hu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm845-oneplus: add
 tri-state-key
Message-ID: <Y+fE7gIMD4BDCffy@duo.ucw.cz>
References: <20230209232556.91554-1-soyer@irl.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QtnDXKWpFdENi7Om"
Content-Disposition: inline
In-Reply-To: <20230209232556.91554-1-soyer@irl.hu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QtnDXKWpFdENi7Om
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -52,6 +52,43 @@ key-vol-up {
>  		};
>  	};
> =20
> +	tri-state-key {
> +		compatible =3D "gpio-keys";
> +		label =3D "Tri-state key";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&tri_state_key_default>;
> +		state-top {
> +			label =3D "Tri-state key top";

"top/middle" is not too useful. Do we need the label at all? If so,
should it say "loud/vibrations only/mute"?

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--QtnDXKWpFdENi7Om
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY+fE7gAKCRAw5/Bqldv6
8qazAJ4tTbEaN/jTDm/HvuDKLvkjqEsbigCgjyR3Jf17uJg1F3quUSWtJIkQgV0=
=mHMW
-----END PGP SIGNATURE-----

--QtnDXKWpFdENi7Om--
