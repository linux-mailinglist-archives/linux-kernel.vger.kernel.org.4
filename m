Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D275B6F2608
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 21:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjD2Tol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 15:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjD2Tok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 15:44:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7FA1997;
        Sat, 29 Apr 2023 12:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B921C600BE;
        Sat, 29 Apr 2023 19:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB656C433EF;
        Sat, 29 Apr 2023 19:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682797478;
        bh=1vAfFF7pQl4va7eJ2p/ginKbfhAgJVw9IcZoARLUmIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7GZAFVTh1EMpJnECYZBWFvvbcRzVa7ybfWlUPHPl3qreRnfA32+bwaMqp5UyrgsT
         8Q1CiJaOHehQPI2nk/ygcfT5Jgloo3VRRp/H+awqfkwlOg2ISUBeQcrYH1ntLyjlL0
         0rM7cn+InaEenrifPOTIRQ30OffTZNOC7an0FD0nPvJyNpoqRYTU1ze5aVwjX+peZK
         6Sm8ajPV8s9MjCmx7inFpl6+I+drmIrrLVUTAh9OyiiqLnRgITyVWE1FXCtpqDhIf/
         GqoJTLVjGhtqZy5ZiD2tt8Ku+IAt6OegGasvBSy1R4+ZX33bRxNeGubWhwCEkAWYL5
         NLl1prAPy/DTQ==
Received: by mercury (Postfix, from userid 1000)
        id E655A1066F52; Sat, 29 Apr 2023 21:44:34 +0200 (CEST)
Date:   Sat, 29 Apr 2023 21:44:34 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: input: pwm-vibrator: Add enable-gpio
Message-ID: <20230429194434.ah5tkawy6wjptpld@mercury.elektranox.org>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <20230427-hammerhead-vibra-v1-1-e87eeb94da51@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="42gflmsjqmxzkixs"
Content-Disposition: inline
In-Reply-To: <20230427-hammerhead-vibra-v1-1-e87eeb94da51@z3ntu.xyz>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--42gflmsjqmxzkixs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 27, 2023 at 10:34:26PM +0200, Luca Weiss wrote:
> Some pwm vibrators have a dedicated enable GPIO that needs to be set
> high so that the vibrator works. Document that.

Reviewed-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  Documentation/devicetree/bindings/input/pwm-vibrator.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.yaml b/=
Documentation/devicetree/bindings/input/pwm-vibrator.yaml
> index d32716c604fe..6398534b43c3 100644
> --- a/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
> +++ b/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
> @@ -32,6 +32,8 @@ properties:
>      minItems: 1
>      maxItems: 2
> =20
> +  enable-gpios: true
> +
>    vcc-supply: true
> =20
>    direction-duty-cycle-ns:
>=20
> --=20
> 2.40.0
>=20

--42gflmsjqmxzkixs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRNc5cACgkQ2O7X88g7
+poS5A//ctoKIcarHo1EVAh8U0gtFGeQ5bJPP/bz0Abdlx/L91XCikbInUuTYLN9
/vrPOj/Tpr/KRYTzxJUenHxLigrUfhRRSGFcJZk8stCtOAdAzpPdPMTdVWWruu3/
XOpu4gu79vJrYtqmLybs99d+uI1SiR228ZeRireO92Dw64hSUWLDL5yoAj2bp3Ot
80dXpla3hDmbXbeaDrC3+RuTinPAVWrWJh8gV72GLr8llSDePUm5iGhVe/03aaLd
5i73lL5WuhVW+OElEALDuOcHjPcoW1Qc6JjH9cvXMEU0ghOEfqn3KSHfd19yvYEM
YdyVqUZIZOLu3Dt/X1o+KJ0g0JzUHXmpSSCMejoZVG4nTcaO3ed/fker+JZ4my6B
rut65hrpS83GO/m2iNj1wV8krZqQ6+J7Fr0H2xLgIuwIcIqSPMEFS3SChQHXKY6N
FA+qllsKdKuq/zsIKiLBbfRflHbBy49MYFTked9kwLNIIwa+tS4IS2ALp4WFvJXN
M4z+4QpvMIZjbvBuMkvaq6sgO4RnlLT6eiVTgblSVpS/Rnhb6/CWm+e1glgObEwW
wcPObDZ17kaQdNQQYLx2K1FblPbpoqIPpovoB0Vx/NhLevWX+4jQnObnCjgtrW+C
PI51cakTNX8oHbO/u/1jJlJjrILN//fGA1ZFfyV5zao0YuT5ezU=
=4cvQ
-----END PGP SIGNATURE-----

--42gflmsjqmxzkixs--
