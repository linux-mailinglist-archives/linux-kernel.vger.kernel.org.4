Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CA8635311
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbiKWIpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiKWIpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:45:51 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49C123EA4;
        Wed, 23 Nov 2022 00:45:49 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d6so2527551pll.7;
        Wed, 23 Nov 2022 00:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZBF8K0cqo1XxroCT8+8Aao6E/CEIYX213gx54pBiGg=;
        b=M5F3AYMfKdwI/yDiUE/h5ylmNETVyGZWyZ/9349Z8JF33+dcqqGZqi7/S71/TrBH8u
         Z9ksFb14bj1C6fcTWcFJIc5oyWrK7PY8bJ/NKG0Q/dNAkb8brpWn4Vxd+tjtnAPDS7i4
         VVZaaQZhZD2SPYjGOMSIOIF9jdcJC/K7u97Cpoa4Q12K8Gonf7TDlo6Mb48P/N5i0ZtQ
         ZZCEdWneu0yxlynMvjMqURoDhxqfWyJxdlb4leW6+9NoR6z24exhJyM2hykU74jELSww
         iA/kobUCST9W5zQ6nYxqcPFcadICLq7Gr2o3V5otoZ9mtjbmCWOg9dYoW1HZUiMgLOhn
         urrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZBF8K0cqo1XxroCT8+8Aao6E/CEIYX213gx54pBiGg=;
        b=5SXoIHgQ6govizSFMKg1xqj86gkzTFggslcIVLD2a7zuEzn5eBacGdWPHIlu98gw4c
         zQZp17W3w8PeuziIid51nIixPx0qrr84wXICgCS4/qnMJv29C7PQXjy8EOXMHzjoruXU
         EPowrx7AKaP9DyrtkL8DPlxMzho9tz4yJOvSQYvA+Y/lv0/Jd3yvYG2iNuHElVOKq/8i
         nEWt1Uv2faf6Mj0oPzdoX4EDwYCGbWTmTshbVRiG6XUc9090ryEXVTBjZeWdxyGCvrTi
         GZiXGIphMqKsU/TXeHfRE5ZaUYc8GpUnAXOORf7EbCpPu1KCP+vSC5X9Q37CVC2fcFej
         Lr1g==
X-Gm-Message-State: ANoB5plTkGCHdq/Gd/Jkek00gWZhD/txrZGOiqNF9gAEFMTK8adBLHmA
        RXEV3ALHXSEsTWc9wUmdcmA=
X-Google-Smtp-Source: AA0mqf4jIwDCVAAg0TznbSNmzpqVz8yL39dOREeFq0Dhb07wOzc23GXd567FoO2yF1M+OOdwnLMlZg==
X-Received: by 2002:a17:90a:7344:b0:218:a049:cc0f with SMTP id j4-20020a17090a734400b00218a049cc0fmr17781965pjs.176.1669193149476;
        Wed, 23 Nov 2022 00:45:49 -0800 (PST)
Received: from debian.me (subs03-180-214-233-3.three.co.id. [180.214.233.3])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001785fa792f4sm13624971plh.243.2022.11.23.00.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 00:45:48 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 747DD1041A8; Wed, 23 Nov 2022 15:45:46 +0700 (WIB)
Date:   Wed, 23 Nov 2022 15:45:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        lee@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [v4 5/5] hwmon: Add Aspeed ast2600 TACH support
Message-ID: <Y33duvUVQ0AJsgAv@debian.me>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-6-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Wdr+NIs+nU2Ts8sL"
Content-Disposition: inline
In-Reply-To: <20221123061635.32025-6-billy_tsai@aspeedtech.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wdr+NIs+nU2Ts8sL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2022 at 02:16:35PM +0800, Billy Tsai wrote:
> diff --git a/Documentation/hwmon/tach-aspeed-ast2600.rst b/Documentation/=
hwmon/tach-aspeed-ast2600.rst
> new file mode 100644
> index 000000000000..4f9501b783a1
> --- /dev/null
> +++ b/Documentation/hwmon/tach-aspeed-ast2600.rst
> @@ -0,0 +1,24 @@
> +Kernel driver tach-aspeed-ast2600
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +Supported chips:
> +	ASPEED AST2600
> +
> +Authors:
> +	<billy_tsai@aspeedtech.com>
> +
> +Description:
> +------------
> +This driver implements support for ASPEED AST2600 Fan Tacho controller.
> +The controller supports up to 16 tachometer inputs.
> +
> +The driver provides the following sensor accesses in sysfs:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +fanX_input	ro	provide current fan rotation value in RPM as reported
> +			by the fan to the device.
> +fanX_div	rw	Fan divisor: Supported value are power of 4 (1, 4, 16
> +                        64, ... 4194304)
> +                        The larger divisor, the less rpm accuracy and th=
e less
> +                        affected by fan signal glitch.
> +fanX_pulses	rw      Fan pulses per resolution.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

I found htmldocs warnings:

Documentation/hwmon/tach-aspeed-ast2600.rst:2: WARNING: Title underline too=
 short.

Kernel driver tach-aspeed-ast2600
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Documentation/hwmon/tach-aspeed-ast2600.rst:18: WARNING: Unexpected indenta=
tion.
Documentation/hwmon/tach-aspeed-ast2600.rst:19: WARNING: Block quote ends w=
ithout a blank line; unexpected unindent.
Documentation/hwmon/tach-aspeed-ast2600.rst:23: WARNING: Definition list en=
ds without a blank line; unexpected unindent.

I have applied the fixup:

---- >8 ----

diff --git a/Documentation/hwmon/tach-aspeed-ast2600.rst b/Documentation/hw=
mon/tach-aspeed-ast2600.rst
index 4f9501b783a11b..8faa00f6ad47c2 100644
--- a/Documentation/hwmon/tach-aspeed-ast2600.rst
+++ b/Documentation/hwmon/tach-aspeed-ast2600.rst
@@ -1,5 +1,5 @@
 Kernel driver tach-aspeed-ast2600
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Supported chips:
 	ASPEED AST2600
@@ -13,7 +13,8 @@ This driver implements support for ASPEED AST2600 Fan Tac=
ho controller.
 The controller supports up to 16 tachometer inputs.
=20
 The driver provides the following sensor accesses in sysfs:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
 fanX_input	ro	provide current fan rotation value in RPM as reported
 			by the fan to the device.
 fanX_div	rw	Fan divisor: Supported value are power of 4 (1, 4, 16

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Wdr+NIs+nU2Ts8sL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY33dugAKCRD2uYlJVVFO
o4VPAP9OVgcEc9GRXdOZWL9ta8mpZLXWh61q7ErF/EdcKKz/YwEAjFBWtmXNVi7P
XnbIMa0wezzy+QvZXMhp+uQ6u1BsdQc=
=uc2g
-----END PGP SIGNATURE-----

--Wdr+NIs+nU2Ts8sL--
