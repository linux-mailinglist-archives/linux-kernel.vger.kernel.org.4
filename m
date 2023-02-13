Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963AE695302
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBMV1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMV1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:27:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6466E88;
        Mon, 13 Feb 2023 13:27:37 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 23FD46602090;
        Mon, 13 Feb 2023 21:27:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676323656;
        bh=n4QstRajKwsidWrD3waRe8l+jV02T583FDk2wKXJ4Bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DfKKTld0fmngSP+3cBAH2rOqqxL0ELSTINCDO1AIkHsEYst2ZFB4uXCFgP47LrYwI
         QmXvaWl5bE/Q62ZLQRN/GR9PJP4Co4yzFQH2s1vREwxSvMvI8pyJO02uLHf7MGPht2
         TnFJyqa7UtrARMV8wlu2pBLW6PXU4sI/74IVCAhUMMebedGJ/tuCm77kYIGpMb8wf2
         MncK2y4H4lXx4a/qPZJ5MGqC8fsRmCOjQgp/Ru27OJyzNcg5a9LqhI80elIVyZ2Kfd
         VhCaSypcfUdNvS9MGWlnQqnUXuEC+5Fc4F4Rp1KwR0ruot9CuDYWlKDOCynr2J8ja3
         KnMZqu/FqB7Bw==
Received: by mercury (Postfix, from userid 1000)
        id F3E9210603FE; Mon, 13 Feb 2023 22:27:33 +0100 (CET)
Date:   Mon, 13 Feb 2023 22:27:33 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: power: supply: pm8941-coincell: Don't
 require charging properties
Message-ID: <20230213212733.rhvuzrshfrvzgo4a@mercury.elektranox.org>
References: <20230213204950.2100538-1-konrad.dybcio@linaro.org>
 <20230213204950.2100538-2-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xnyd3uljxpwhjej6"
Content-Disposition: inline
In-Reply-To: <20230213204950.2100538-2-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xnyd3uljxpwhjej6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 13, 2023 at 09:49:49PM +0100, Konrad Dybcio wrote:
> It's fine for these properties to be absent, as the driver doesn't fail
> without them and functions with settings inherited from the reset/previous
> stage bootloader state.
>=20
> Fixes: 6c463222a21d ("dt-bindings: power: supply: pm8941-coincell: Conver=
t to DT schema format")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Please update the description of these properties to describe the
default behaviour.

-- Sebastian

>  .../devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml  | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-c=
oincell.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-c=
oincell.yaml
> index b7b58aed3f3c..d62e3af55560 100644
> --- a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell=
=2Eyaml
> @@ -43,8 +43,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - qcom,rset-ohms
> -  - qcom,vset-millivolts
> =20
>  additionalProperties: false
> =20
> --=20
> 2.39.1
>=20

--xnyd3uljxpwhjej6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPqq0UACgkQ2O7X88g7
+po78A//bVo5Xgptil+punVVBZKT+BHiyWTdzQWG87fNi0i4QIBiQEvyu8yWd/lN
WFH15bPq0ANQvT0V5DdQpG3H/dIjaKU81FtZ0mwvFBCqxthflEQD93ki9itUKZ/Z
aYecjoJcTqAK0Nam3DQSuH2gnTgtCMT267csPBElsyI1ayxZJxFM1Xp8WKWQ69Ba
eRnlaiRURcLnMLz2aOYqOEaGV/jQvofy0tdalnmaaCDdtR9yLnKHAg5huhCaq+of
oJPa+CekqPEiLuliMf+V6DAXuNUEo0LYHbefqfHAs85RBAMH0OwK9/19LaKawWFY
TRJazxiMlhw3Ueriu9tDdJaLkLGOesmxntcCcZW0evRbKVmxrEcBx9guOUKGwlF6
3Txv6I9Bm51FZcNNjsVk2DyiLSO4E38BJlAdpFqBXYKKK9e4wb+gH6mR8z4zZ6Fh
giTLLclF9atMNRpNVzOel4KEgkXBUU1wSJ4uJI8zbVky08Mu3ytGO38YuUIbv2Bp
C+ak69WooIMHund5cFtAJKqRGXTAHvDwxSFVZ4SUiak0rGH8mVAOtREAjysQ8j++
M0a6f5g/+GBCk49Yz6Pa0kxMBnX/Aa8xac817V15ABHn7gqymzgBqXxYK4QC7WI+
JiCHTVOdKPNNeDa73MFbwCwHvL/aOqpvANH2EwGyKu/M3lpGgro=
=KPUL
-----END PGP SIGNATURE-----

--xnyd3uljxpwhjej6--
