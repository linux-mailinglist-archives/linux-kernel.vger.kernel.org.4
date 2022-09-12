Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A11E5B590E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiILLMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiILLMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:12:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C002731DE5;
        Mon, 12 Sep 2022 04:12:05 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 56EBB6601FDD;
        Mon, 12 Sep 2022 12:12:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662981124;
        bh=Gp9A2fQl73ZyLrnlWhsrPpz2tEWHWALZC2NoG8+cS9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4BO6VgCytBp7s77/ESjAuP7e+bivpGEiU9tUgdbv6DiXFW5CtbnYyxoBHcm8VFV0
         WDNvUQXWRY6BBnAKy7izR5A5FiWERGjrS6sR/FoZj1oJe2cOImFpLj+LQXTs4U589c
         CK6f5OYpustIAUPF6uSSzJgTZJJGqX5AUaXvVPoFPwqsnsXCbE5nNKiEpAeYneZlwV
         vhHoEFC6ChWrvfas4BXcZjD+7JM2CXDUHvrvBCI3HCO17zYWTDnT59gyDyzQPJL81B
         SVNvKdAV4k4fjhmD9EZuyTBjkpd+6ahMAdO1PMWsyajPJ+mfP96/f8vXV/zur9DBET
         VmRpcxhSAX0rQ==
Received: by mercury (Postfix, from userid 1000)
        id 5D88F106084A; Mon, 12 Sep 2022 13:12:01 +0200 (CEST)
Date:   Mon, 12 Sep 2022 13:12:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] Documentation: power: rt9471: Document exported
 sysfs entries
Message-ID: <20220912111201.nxjgqzpa7pftzwlb@mercury.elektranox.org>
References: <1661742391-11378-1-git-send-email-u0084500@gmail.com>
 <1661742391-11378-4-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pameyxirnllnovkl"
Content-Disposition: inline
In-Reply-To: <1661742391-11378-4-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pameyxirnllnovkl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 29, 2022 at 11:06:31AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> Document the settings exported by rt9471 charger driver through sysfs ent=
ries:
> - sysoff_enable
> - charge_term_enable
> - port_detect_enable
>=20
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 44 +++++++++++++++++++++++=
++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index a9ce63c..1f8afe5 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -768,3 +768,47 @@ Description:
> =20
>  		Access: Read
>  		Valid values: 1-31
> +
> +What:		/sys/class/power_supply/rt9471-*/sysoff_enable
> +Date:		Sep 2022
> +KernelVersion:	6.1
> +Contact:	ChiYuan Huang <cy_huang@richtek.com>
> +Description:
> +		This entry allows enabling the sysoff mode of rt9471 charger devices.
> +		If enabled and the input is removed, the internal battery FET is turned
> +		off to reduce the leakage from the BAT pin. See device datasheet for d=
etails.
> +
> +		Access: Read, Write
> +		Valid values:
> +		- 1: enabled
> +		- 0: disabled

This is not a very good description of what the control does. When
do you expect users to control this?

> +What:		/sys/class/power_supply/rt9471-*/charge_term_enable
> +Date:		Sep 2022
> +KernelVersion:	6.1
> +Contact:	ChiYuan Huang <cy_huang@richtek.com>
> +Description:
> +		This entry allows enabling the charge termination function of rt9471 c=
harger
> +		devices. If enabled, the battery charging current, and the battery vol=
tage
> +		reachs charge termination condition, the internal battery FET will be =
turned off
> +		to optimize the battery life. See device datasheet for details.
> +
> +		Access: Read, Write
> +		Valid values:
> +		- 1: enabled
> +		- 0: disabled

Just write 0 to .../charge_term_current to disable it.
No need for a custom property.

> +What:		/sys/class/power_supply/rt9471-*/port_detect_enable
> +Date:		Sep 2022
> +KernelVersion:	6.1
> +Contact:	ChiYuan Huang <cy_huang@richtek.com>
> +Description:
> +		This entry allows enabling the USB BC12 port detect function of rt9471=
 charger
> +		devices. If enabled and VBUS is inserted, device will start to do the =
BC12
> +		port detect and report the usb port type when port detect is done. See
> +		datasheet for details.
> +
> +		Access: Read, Write
> +		Valid values:
> +		- 1: enabled
> +		- 0: disabled

Why would one want to disable this?
Can't the driver just enable it unconditionally?

-- Sebastian

--pameyxirnllnovkl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMfE/wACgkQ2O7X88g7
+poN5A//e2GwrsU29B5CvHNwF9pakLNcbw8DuGqSelVL2J3+8mEODmWMv1TWsxaU
D4w898MpRUBS40c9wA+yt+Fu0HO9Cz9egXIGUJAmAVkD8x9HtaJ4WMLrOrxxwQsk
Jt4o81fB6dGEeC1sQy7GVzLADTqHDk8nMziX7XmExXXxIT2XzolRFIagx63U3JSz
+whjNgpxOUsEY24r8DpWe7V/bK4i55EU+9bx7uHH61453Wj0hLNuTV9lt5EHykha
YlDUzgMogWAxavSI0r8sfNcaqlAsQ2Gcn/Tkj6RDDTR2WCycZrt4UrpNfKZDE8ic
3GaI396kawRm6VzPz8MNMGNiw06CaI+nZP+jjK1SkY8BCk+4Hzu5WCqAoniBH6E1
8n0Do7nOsIgOprMiBxlL6LOa2SadVLFaeufppHridMZhuB5n0y0CjWBj3ntAYv0u
fv9Al8Y/Gv5vYuFedEjlBD+72oQltri2soeOVDXOfHDV2sp8MSEIP0eCOSj0htLk
IGlWbqoVnrVf9EVNGe842DXZj0PjQtUGzEnnNOxdW3AgPCf9GqZPOw0EQns1dP6P
bOnayVbdRolfvqgbedXvgygu3QOPlo0WKfWqY98HTjSUP66bCGPyGfGGg7GC3afY
rQ4fAw4j8Cm16NYu59Zgc61zWRpzYISbU5CPYn8C0NthGn8u32Y=
=xo/s
-----END PGP SIGNATURE-----

--pameyxirnllnovkl--
