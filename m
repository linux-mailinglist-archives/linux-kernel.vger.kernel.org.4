Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD2E648FF7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 18:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiLJRPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 12:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiLJROq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 12:14:46 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7449DCE1;
        Sat, 10 Dec 2022 09:14:36 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D5C421C09F6; Sat, 10 Dec 2022 18:14:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670692473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80WcLoHKqeSS0b27wIQAfQcpCvbdZiyOk/DnuqmgX2A=;
        b=hsgKXY8TClZYyEU1c4oj7VPIUQhLbSHuVQxNbkh5qsnEZWg/OFN7lX/N0LZM6WBR4BMfMj
        cdoCQ0IHrQyL1WQK2W6MXQeXEq+F1jiPpAzP7NxY1itLMs718T5QjvCNvUk9T6vJqPnBrh
        woB/16Zm5f1D4CZDp8GZ8Fo0HlOKUwo=
Date:   Sat, 10 Dec 2022 18:14:33 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: pm6150l: add spmi-flash-led node
Message-ID: <Y5S+eUnn9UauVbrS@duo.ucw.cz>
References: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
 <20221209-fp4-pm6150l-flash-v1-2-531521eb2a72@fairphone.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wyVEfKsp86X4iaBk"
Content-Disposition: inline
In-Reply-To: <20221209-fp4-pm6150l-flash-v1-2-531521eb2a72@fairphone.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wyVEfKsp86X4iaBk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2022-12-09 14:54:07, Luca Weiss wrote:
> Add a node describing the flash block found on pm6150l.
>=20
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Acked-by: Pavel Machek <pavel@ucw.cz>


> ---
>  arch/arm64/boot/dts/qcom/pm6150l.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/=
qcom/pm6150l.dtsi
> index 90aac61ad264..86e659fcbba6 100644
> --- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> @@ -112,6 +112,12 @@ pm6150l_lsid5: pmic@5 {
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> +		pm6150l_flash: led-controller@d300 {
> +			compatible =3D "qcom,pm6150l-flash-led", "qcom,spmi-flash-led";
> +			reg =3D <0xd300>;
> +			status =3D "disabled";
> +		};
> +
>  		pm6150l_wled: leds@d800 {
>  			compatible =3D "qcom,pm6150l-wled";
>  			reg =3D <0xd800>, <0xd900>;
>=20


--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--wyVEfKsp86X4iaBk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5S+eQAKCRAw5/Bqldv6
8jp0AJ9+Bi1jsFkyWvDuuR9d1JCXoukodQCfUW8l65JIIeXGODF+oeTZuBLI0rA=
=A5co
-----END PGP SIGNATURE-----

--wyVEfKsp86X4iaBk--
