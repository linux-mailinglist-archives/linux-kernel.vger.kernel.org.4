Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875DC6B6BFE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 23:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjCLWdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 18:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjCLWdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 18:33:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C2E195;
        Sun, 12 Mar 2023 15:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABA3F61015;
        Sun, 12 Mar 2023 22:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E16C433D2;
        Sun, 12 Mar 2023 22:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678660387;
        bh=nBc93sXiAYACx3pnXIOgQiKft2dOHkoo3DbtvkGwrhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VLunBXe9caBebWSZsNdpGBdxw9FDt8RDwFx+3LLZZYdgRhf7yrxVwLreCV63Uktwa
         GrlzrdCFnTa3CHvPt2nAzRRcqPyYi4F9eo4QpilzTvdRhnyTUKBJBuQ2qZZWFBiwZu
         J1xFbemJyogYZf1ooclZSoItUdjzgS19i2FllucOEmEuDPjhdtKGq6lzunyvJaKiaX
         3c3zwFH7UPuAz7g1U4MOFDMGamFwxpLSaw7mvf0tEtHgu2h+WvEvdOrmcK2MFLjgNX
         hAEbN2JCXoFx46vOq5jtFb3tYmOa+4SYeRZCAPQZpSgL9MbK+EmOpWD+AsnlV3EJTC
         iACg0W264zEIg==
Received: by mercury (Postfix, from userid 1000)
        id 45E5D1060FD4; Sun, 12 Mar 2023 23:33:04 +0100 (CET)
Date:   Sun, 12 Mar 2023 23:33:04 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: qcom-pon: drop of_match_ptr for ID table
Message-ID: <1fdf00a0-4830-465a-801c-147472fdcd22@mercury.local>
References: <20230310200652.19926-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwm4btwbb7qrunf7"
Content-Disposition: inline
In-Reply-To: <20230310200652.19926-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwm4btwbb7qrunf7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 10, 2023 at 09:06:52PM +0100, Krzysztof Kozlowski wrote:
> The Qualcomm SoC power-on driver is specific to ARCH_QCOM which depends
> on OF thus the driver is OF-only.  It's of_device_id table is built
> unconditionally, thus of_match_ptr() for ID table does not make sense.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Thanks, queued to power-supply's for next branch.

-- Sebastian

>  drivers/power/reset/qcom-pon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-po=
n.c
> index 16bc01738be9..ebdcfb28c4a0 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -91,7 +91,7 @@ static struct platform_driver pm8916_pon_driver =3D {
>  	.probe =3D pm8916_pon_probe,
>  	.driver =3D {
>  		.name =3D "pm8916-pon",
> -		.of_match_table =3D of_match_ptr(pm8916_pon_id_table),
> +		.of_match_table =3D pm8916_pon_id_table,
>  	},
>  };
>  module_platform_driver(pm8916_pon_driver);
> --=20
> 2.34.1
>=20

--rwm4btwbb7qrunf7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQOUx8ACgkQ2O7X88g7
+pp8Qg/9G1xja6Ebkw+FSgJqDaWl6nsDyIYfZU9jLtyj3lQ6jUcSBmcj/qDcaJNr
7HcVLK3foFmDrwPzU+ETv18OBnKRn2yZ+WNZoWO9MjUoNiYs/4mevKzgdKmsqwdn
nSGU9zOG4IHlVKBUkiPQUVPu+k0gxRX8r9aMuCMcdnhDPDpy3h4e2WqG5N5JwnEE
jXhVFHM/y6qSdpVvyI4iHluMy+Ws5jnCO7aIuQltbzwVyHWyAdSMU/gAsfF1HivM
UaBd523CxX0GtNz48QdrY7NgzsUKA1DvSez/z90maxzE9Wem3rOXgpq/i86GbDhB
JB0junRCZgitQp6hsWL/e0nUPxWTWoC7NMvblniMts9NUAkHA/IWMkGkaO6wrwPG
q1ZxiOloJxYgW5penPyJNFYZhLdAuYF8FC3ovV2raA0vsXC+0Hu+rroEDG3UbUqV
xBa4SclUQm3lspe6+1ItYc51h9MUYyR8W90Qc1m2JuX6iLCHmswYfU2ICNjNqpC2
2cp2Aiqw3cjQHfxvuVBiQQ2t2r+UXuU+pen0LwLUJGT909V3RvGbuNJGhahyDuBD
6HKBHI5CBOJv2/J5HCg6Tc4ojIiBsq4RBhFXgazXB/QfnfwfAW8PcALAv2/ASr8n
8ku4E3Fuc0xbL1Bg+O5xL+Abijf+l7oSq7c3HIQ3CR50OsEA9PI=
=Vt6K
-----END PGP SIGNATURE-----

--rwm4btwbb7qrunf7--
