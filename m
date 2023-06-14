Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2709772F8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbjFNJQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbjFNJQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:16:24 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40E610C2;
        Wed, 14 Jun 2023 02:16:23 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35E9GDf0116018;
        Wed, 14 Jun 2023 04:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686734173;
        bh=jZILcimbO8H9jFnvBhpps4l+5iwNtwlePffU+vZJXl0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XPHxjyw0Q7oAQVl0HaGg0DsbErpLF/2yHp2cFQrxaDra2hCcgbwXRtd6I8bVRZWc2
         LTIAOuzc2I4Di4+3FYEf2jzUywDZ3MnEfww+FFx89L3FH0O3gUoyronjc+Sq7hrdYd
         6ft9mxHheH7h29GzgP17/DOaCRCin+ka57WhE/kE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35E9GDaN031427
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Jun 2023 04:16:13 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Jun 2023 04:16:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Jun 2023 04:16:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35E9GCeN044274;
        Wed, 14 Jun 2023 04:16:12 -0500
Date:   Wed, 14 Jun 2023 14:46:14 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: ti,tlv320aic3x: Add missing type for
 "gpio-reset"
Message-ID: <zzblrbz4mqddye6pphgtjdeh5nrxtefgiom7j2xksrasozlma4@ohvdju6vpas6>
References: <20230613201006.2822985-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w3legnfqvlxrn5cn"
Content-Disposition: inline
In-Reply-To: <20230613201006.2822985-1-robh@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--w3legnfqvlxrn5cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Jun 13, 2023 at 14:10:05 -0600, Rob Herring wrote:
> "gpio-reset" may be deprecated, but it still needs a type.

Oops, I missed that in the original patch. Thanks for the fix.

>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Jai Luthra <j-luthra@ti.com>

> ---
>  Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml =
b/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
> index e8ca9f3369f8..206f6d61e362 100644
> --- a/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
> +++ b/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
> @@ -61,6 +61,7 @@ properties:
>        GPIO specification for the active low RESET input.
> =20
>    gpio-reset:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>      maxItems: 1
>      description:
>        Deprecated, please use reset-gpios instead.
> --=20
> 2.39.2
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--w3legnfqvlxrn5cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmSJhV0ACgkQQ96R+SSa
cUUQ8xAApoeSPSomSMZ+WWp0ASO4pt7Svz982hz5vN+LvVw11igutkPuQFvZvwW3
2PpYD1HxN9hLLRw45vT7Vci7Z1NC3DflLGiF+AG8VgiYOpp1d+8Kxad7Mp9qMIbx
ffjoxoC0BHHR492ZjKsO9BOwbTVwiqZj4KQNbCZFkNweEwK0qPBG0p0PvCrET69H
iJbL4/8d1F9zVyBQs00af22aiVXVRb1KZHiefPyibbrAyrxII7tFZHMUjfNI5Nud
yusX1T1AhCPYzIvWmSbDWRUBQ2hh+qUWVz2CvXoCi8YLAxXGHmN/WH4zNh24TcFO
zzJP77JFFAXD0HhyUwEHDsnP92kBEoWD2jZeBIUKpHvL4KPZ0tYImC99Ud6yh+gZ
CeMZDCmMNessck7+MhCXn/JpA9Lh5y4Y7jASCRNtz/NhxWPOIPG9tPsVoCDAsevT
5mUCmFppsu3U71srU/as1XQjAJmFvnO6abC4a713bMMqFYKTQK3CAsU15iByu/7X
UztO40yTu37pX1/1liPXc0ghOSlbdSY5QQhrJdHIRHQxz56IXQw+kOfXHsGScBU9
3O95//qF4cBXrTIk9cl3aEInxe2pl7SLtCe34VuE8Ibf6mYkGZ/j3Tdrj4OtDIwP
2S2ETGoa+QPqi3D//0Ws6a2GdPISb4M7w+mAnHVV+/ylxs1MKxw=
=rfjt
-----END PGP SIGNATURE-----

--w3legnfqvlxrn5cn--
