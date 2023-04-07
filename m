Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC65E6DB655
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjDGWM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDGWM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:12:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5C5CA06;
        Fri,  7 Apr 2023 15:12:54 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 49CC666031D8;
        Fri,  7 Apr 2023 23:12:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680905573;
        bh=OPJye7DnMqvYT4X5PPg+ptLV0htYygit7gJuZ9US0xE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QkrJMLXuRtXS5BG0Hg2Htaz9x0Zsc7bFuEPRHS58enkmuEelE7u3Uj2z9HivNcL8h
         QeH681j3s+oaTH8cAp3T/7r5+AooOT84psdSfBIKFSGFgCjQX3oXRUnj14MCnFGsag
         QWhXt4VAXuecaSU1mtIAQHPOklGX9umo+qTUku9w/ROrmNG88jHc0eV0cvgzWgh9V6
         FnoQW10vnXolDfEmeEEGKB8/RykPT3IFFkGFQjMJZtRsbfmp7RHXxYNVw4Zkpn1n+q
         zg8b8ka0ozdh9qMZL3XzOwveFNLMLv/22ACL20aPL6THLWVujfCuLfbcnRQUBKT1ID
         xvWRTGCCkDQaA==
Received: by mercury (Postfix, from userid 1000)
        id 27EEB1063103; Sat,  8 Apr 2023 00:12:50 +0200 (CEST)
Date:   Sat, 8 Apr 2023 00:12:50 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] power: supply: hwmon: constify pointers to
 hwmon_channel_info
Message-ID: <20230407221250.xt2e7yuj62rlotkd@mercury.elektranox.org>
References: <20230407150326.80183-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rd7nj3bva35lr4pn"
Content-Disposition: inline
In-Reply-To: <20230407150326.80183-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rd7nj3bva35lr4pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 07, 2023 at 05:03:26PM +0200, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be
> made const for safety.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> This depends on hwmon core patch:
> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@=
linaro.org/
>=20
> Therefore I propose this should also go via hwmon tree.
>=20
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/power_supply_hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> index a48aa4afb828..c97893d4c25e 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -293,7 +293,7 @@ static const struct hwmon_ops power_supply_hwmon_ops =
=3D {
>  	.read_string	=3D power_supply_hwmon_read_string,
>  };
> =20
> -static const struct hwmon_channel_info *power_supply_hwmon_info[] =3D {
> +static const struct hwmon_channel_info * const power_supply_hwmon_info[]=
 =3D {
>  	HWMON_CHANNEL_INFO(temp,
>  			   HWMON_T_LABEL     |
>  			   HWMON_T_INPUT     |
> --=20
> 2.34.1
>=20

--rd7nj3bva35lr4pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQwlV4ACgkQ2O7X88g7
+pqvBA//RGvJH9yu+zEp0cu+ZHkJQYBy6lNJBVX+33uLpxMpF6RJE3uRaXlayaRm
fcWRhuP3Xn4MO+Bi467oXg97iIKGk5nRPoFVh4LoYz9fsLuW9L00p5lAkR0Q1jxM
eoNDfAWlHXpwOw0IF7mVnRlEKuigLwFOciA8XmQxPnfLCQfK0aX4o+arHSYaYU6x
ixsfyCjcvEpbd/25XuUOxEGuJ2Z5NYEzC5zdnj+aDPiKLY4wRCsBYDr/IsMt0ePH
0pJMmqFzBUmPRoSIlLFmP2pbroj9TRCsfDyMRD4OltzkWzmmF5729D0MEX6S9MfP
1H3StzhfPyIzv01clQkzTF+0Qc4LmKsexjU58y4a01H7DHCPUp3X8w3D2z9VbHmE
q2AvzFPx4xmRpotK8RjZpS0Lx5MawwOeqe4G0iSgX9iIDviZ2ePlZQMJYhDsMgMv
0ZGi0Ldh7qNhT+O9gmLfqdgH6/btZQtjBbSVOiBnPeH+BdCLcfaNE0PfVptEnkvB
EwzoSQbrgmm14n/xaMBOV8UmubK55LwYvA7vYK/PxfUcFUdyq8SiE03QMHpTdeb9
OutuHcbxKV+GU+TcllZREOskC8BwDaoGXHgA62BJ6VeIUWw7FtgGK+52IINQ2Vck
6IdlN3UyduzvfGVggiAWjHLgdevWb33lle23I6YmXn6W4X67RJw=
=LYJV
-----END PGP SIGNATURE-----

--rd7nj3bva35lr4pn--
