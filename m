Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65618698912
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjBPAGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBPAGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:06:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055443AAC;
        Wed, 15 Feb 2023 16:06:36 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C5130660206C;
        Thu, 16 Feb 2023 00:06:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676505994;
        bh=ilI/10v5PJHrttNszyQv4HKgv/kX2fQrPAogzLEUmLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CGhhDI3X55N6XQ6XTTyAKis7UV7HjrOviPyti7t5sgqYMgxWv/uUFTVvfmdyPxmaA
         0siYj9OwOfBSViwYAhc9QuZghkCQVt0KGv20LaTbhxcQuwNYGXtv8MMow7PGdifBgn
         aPtSTDH/qiHtZd2b40CSV4l9oAntETrWEOSOSm0OTdRluCaBTgEFVYdKFawn7J6nSd
         6fPQlQ/5SHUeELuNRas8YSIqumiT68MjyDHeNmJz7O4+Ndy9lHzDKQmlC20S+kcfCn
         EKhnIF6XYblCLJLpm3I8+mOR/tP0GY6CHPjK8v846WI+w06jCs/v3PK1iolb68LSWJ
         b3nJAQS2R6MmQ==
Received: by mercury (Postfix, from userid 1000)
        id B779B10603FE; Thu, 16 Feb 2023 01:06:31 +0100 (CET)
Date:   Thu, 16 Feb 2023 01:06:31 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: pm8941-coincell: Add
 PM8998 compatible
Message-ID: <20230216000631.2vpwbgajr7u5ysnc@mercury.elektranox.org>
References: <20230214090849.2186370-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vsxp4rzne67m5cq4"
Content-Disposition: inline
In-Reply-To: <20230214090849.2186370-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vsxp4rzne67m5cq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 14, 2023 at 10:08:47AM +0100, Konrad Dybcio wrote:
> Add a specific compatible for the coincell charger present on PM8998.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Thanks, queued.

-- Sebastian

> v1 -> v2:
>=20
> - Pick up ab
>=20
>  .../bindings/power/supply/qcom,pm8941-coincell.yaml       | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-c=
oincell.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-c=
oincell.yaml
> index 0450f4dd4e51..b7b58aed3f3c 100644
> --- a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell=
=2Eyaml
> @@ -16,7 +16,13 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    const: qcom,pm8941-coincell
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,pm8998-coincell
> +          - const: qcom,pm8941-coincell
> +
> +      - const: qcom,pm8941-coincell
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.39.1
>=20

--vsxp4rzne67m5cq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPtc4cACgkQ2O7X88g7
+ppwjg/+OflPejHjoX4Jx2r0sgHANAq5wme+KIdm/jJxHIIbzG8XS54rTp82vbP7
UCBL4S8tEn6AJuvembTJmIcw89EWwZydOipaWFLWKOqX38rtvG0VyRHg8W18901c
JYsuFguR/xpJRCaK118e40ZWJHCOvAibu+3WU4/euJAe4yMbP+ljZPu5/l1DvSDi
05eSNlinA36XgswvFvLpESSS/PW5loCr/F1S5iZxd10aAMe0eDeM+qZn8aSvQcH4
kZybBqw4ED+SZ4ZpzR9cpfR2CcRTpZYN+ZQ6FcIqpv7crpxMnqTnP/k1dTxG8TH/
HreQN6SyAOCQbYEROdz60TENNR116EWpCAJtLQsGUiiFZD83+g5vekPEy7kap1sX
3sDqtnkH6mLu5ZQKsnwIz9/YSeBOl2YFOiD0+qyVqx12xIpLSSQHSsNqnvKdlzAZ
nExfMfpJtRM94xvROwFfFDhjmSh12DFEI+MUfz+rPwAe9vKJcbbVNMufQzzKTsrQ
39SLnsNX1y6WLnJ+GY9ov6NojlWmx7C/hOBim9Pac3VbIW1mGdF2guF4a/I1cFqj
QYqKtwkY7KX6ZuFHNLRJnMQKSRju0vIEW3CLukKrhc9390//jprIm4iiLuaqnfvB
UXinkYvJ9IaOM+yJFmDbaDNSybO/a7Ml34DxkyLWAkvt4ogA9bc=
=9WL4
-----END PGP SIGNATURE-----

--vsxp4rzne67m5cq4--
