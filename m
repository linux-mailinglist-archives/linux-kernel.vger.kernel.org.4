Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627EF71068E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbjEYHik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjEYHiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:38:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8883710C4
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:36:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q25We-0004vQ-Pz; Thu, 25 May 2023 09:36:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q25Wc-002fnD-G8; Thu, 25 May 2023 09:36:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q25Wb-007mL8-T6; Thu, 25 May 2023 09:36:41 +0200
Date:   Thu, 25 May 2023 09:36:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, soc@kernel.org,
        William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: broadcom: Enable device-tree overlay
 support for RPi devices
Message-ID: <20230525073641.macyt5h6uiylbytb@pengutronix.de>
References: <20220410225940.135744-1-aurelien@aurel32.net>
 <20220410225940.135744-2-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s2mw4zp2wclyjf5b"
Content-Disposition: inline
In-Reply-To: <20220410225940.135744-2-aurelien@aurel32.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s2mw4zp2wclyjf5b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[expanded Cc: to include William Zhang and Florian Fainelli]

On Mon, Apr 11, 2022 at 12:59:39AM +0200, Aurelien Jarno wrote:
> Add the '-@' DTC option for the Raspberry Pi devices. This option
> populates the '__symbols__' node that contains all the necessary symbols
> for supporting device-tree overlays (for instance from the firmware or
> the bootloader) on these devices.
>=20
> The Rasbperry Pi devices are well known for their GPIO header, that
> allow various "HATs" or other modules do be connected and this enables
> users to create out-of-tree device-tree overlays for these modules.
>=20
> Please note that this change does increase the size of the resulting DTB
> by ~40%. For example, with v5.17 increase in size is as follows:
>=20
>   bcm2711-rpi-400.dtb       26481 -> 36830 bytes
>   bcm2711-rpi-4-b.dtb       26537 -> 36886 bytes
>   bcm2711-rpi-cm4-io.dtb    26426 -> 36945 bytes
>   bcm2837-rpi-3-a-plus.dtb  14133 -> 19740 bytes
>   bcm2837-rpi-3-b.dtb       14310 -> 20006 bytes
>   bcm2837-rpi-3-b-plus.dtb  14670 -> 20474 bytes
>   bcm2837-rpi-cm3-io3.dtb   13680 -> 19266 bytes
>=20
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  arch/arm64/boot/dts/broadcom/Makefile | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/=
broadcom/Makefile
> index 5082fcd1fea5..0aa8ee2afdd5 100644
> --- a/arch/arm64/boot/dts/broadcom/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> @@ -1,4 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +# Enables support for device-tree overlays
> +DTC_FLAGS_bcm2711-rpi-400 :=3D -@
> +DTC_FLAGS_bcm2711-rpi-4-b :=3D -@
> +DTC_FLAGS_bcm2711-rpi-cm4-io :=3D -@
> +DTC_FLAGS_bcm2837-rpi-3-a-plus :=3D -@
> +DTC_FLAGS_bcm2837-rpi-3-b :=3D -@
> +DTC_FLAGS_bcm2837-rpi-3-b-plus :=3D -@
> +DTC_FLAGS_bcm2837-rpi-cm3-io3 :=3D -@
> +DTC_FLAGS_bcm2837-rpi-zero-2-w :=3D -@

Instead of setting these all explicitly a single

DTC_FLAGS :=3D -@

would work, too, without changing how the dts in subdirs are compiled.
IMHO this would be suiteable for arch/arm64/boot/dts/broadcom.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s2mw4zp2wclyjf5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRvEAkACgkQj4D7WH0S
/k6oCggAgumevLsiZb0L7EgnrAbT9p/8jCBn/6Fj3sxTeILFFAl5+fj2/DNvaOxh
EOU4KxfAYrWB+RCnCBgF+KkNbwMUu0vSZLkR/zQrXCYxYpbCCkwcr0SnygdR9mka
+42Br0w2kZXH/PeniQfa+8jb6YWEnjOVEyMXderruUt6X3kO+JrFfBGS5QMFJZjK
b0S/UZZKKfaGwDpRMqEjxOPxGyqyg6Wm0VVaa7rgf/e4g3ifAq4L6H3auR+uJmBF
NAKJ7P5FfeXIt4KYFNVGQQlC1AhrGNfDtYNs5nnDPO0rLkMY7ALCjCzhJqM8V7E5
5YJ+ugJ4w9glR9YKMgwb8wl1GHRWIw==
=4STT
-----END PGP SIGNATURE-----

--s2mw4zp2wclyjf5b--
