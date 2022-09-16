Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4B05BB54F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiIQBTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIQBTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:19:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ACBE0F5;
        Fri, 16 Sep 2022 18:19:36 -0700 (PDT)
Received: from mercury (dyndsl-095-033-170-064.ewe-ip-backbone.de [95.33.170.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D35F7660204C;
        Sat, 17 Sep 2022 02:19:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663377574;
        bh=IsuXn3QptS+dxxrin6TxULXzoMk1Gf4+cQTcLgbCwmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpdI9QuGAegny+PcB1Lyr+xDl3mlldCBg20Q1qjxiqgRleQnsj8g4ABqRNU3+bMsA
         N6y138Rg9o6kSKT+Cflq3SN9EEZwt/HjzZ6wrby5eahIpZOUF34/Cpb90i9KTxhprK
         9YlExzv3QIrbA45DpgmdH/zLE84awO5MYZjUkBG8b9EvaLeRAqRz79wzcMVWWEyNEk
         WRQb8uS1vr+oYpJKmxhoNexQsHNXxHSfzEvyxud9KqzWKsS00gEZxEOACXNTjXXryP
         Ruv/T1IlB1BPrU3hRtQQl4c+zN02gpBCmlyYxFr7MGo0eM7fcf3D41OWOttTD6qGK6
         DFtere756kpSQ==
Received: by mercury (Postfix, from userid 1000)
        id 752CE1060849; Fri, 16 Sep 2022 20:08:23 +0200 (CEST)
Date:   Fri, 16 Sep 2022 20:08:23 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] Documentation: power: rt9471: Document exported
 sysfs entries
Message-ID: <20220916180823.p672rojsrjbpy4ft@mercury.elektranox.org>
References: <1663173015-7934-1-git-send-email-u0084500@gmail.com>
 <1663173015-7934-4-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g5wty46coo2wjhpl"
Content-Disposition: inline
In-Reply-To: <1663173015-7934-4-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g5wty46coo2wjhpl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 15, 2022 at 12:30:15AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> Document the settings exported by rt9471 charger driver through sysfs ent=
ries:
> - sysoff_enable
> - port_detect_enable
>=20
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v5:
> - Recover all the change in sysfs-class-power.
> - New a sysfs-class-power-rt9471 file.
> - Remove 'charge_term_enable' sysfs entry, directly integrate it in
>   'charge_term_current' power supply property control.
>=20
> ---
>  Documentation/ABI/testing/sysfs-class-power-rt9471 | 29 ++++++++++++++++=
++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9471
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documen=
tation/ABI/testing/sysfs-class-power-rt9471
> new file mode 100644
> index 00000000..ad5b049
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
> @@ -0,0 +1,29 @@
> +What:		/sys/class/power_supply/rt9471-*/sysoff_enable
> +Date:		Oct 2022
> +KernelVersion:	6.1
> +Contact:	ChiYuan Huang <cy_huang@richtek.com>
> +Description:
> +		This entry allows enabling the sysoff mode of rt9471 charger devices.
> +		If enabled and the input is removed, the internal battery FET is turned
> +		off to reduce the leakage from the BAT pin. See device datasheet for d=
etails.
> +		It's commonly used when the product enter shipping stage.
> +
> +		Access: Read, Write
> +		Valid values:
> +		- 1: enabled
> +		- 0: disabled

I still fail to see why this needs to be controllable at runtime.
This looks like a hardware property. Are there any known products,
which need this disabled?

> +What:		/sys/class/power_supply/rt9471-*/port_detect_enable
> +Date:		Oct 2022
> +KernelVersion:	6.1
> +Contact:	ChiYuan Huang <cy_huang@richtek.com>
> +Description:
> +		This entry allows enabling the USB BC12 port detect function of rt9471=
 charger
> +		devices. If enabled and VBUS is inserted, device will start to do the =
BC12
> +		port detect and report the usb port type when port detect is done. See
> +		datasheet for details. Normally controlled when TypeC/USBPD port integ=
rated.
> +
> +		Access: Read, Write
> +		Valid values:
> +		- 1: enabled
> +		- 0: disabled

So basically this depends on the hardware integration (e.g. it
should be disabled when power source is a DC barrel jack instead
of USB) and is not supposed to change at all during runtime? Then
the information wether it needs to be enabled should be derived
=66rom the device tree.

-- Sebastian

--g5wty46coo2wjhpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMku4wACgkQ2O7X88g7
+ppIIQ//UtV9sEuUQW1evu3Xg9UgdWAbELRCg6IJI5rkE/6z8dy1y0u6jTz93BzP
G/AV4jY8Lk1agbW0SpwXONH//7DHqv7b2EQvOB+SmY2IlDIBxFQYYBkI5oXJ9HO4
gvBX6xWN/khnQEUuA075AlzUKzL0l9MSTjHbx1bHbuq3jHoAj6Oo+jduofD8OAfI
hGFyq2icRuJoUGeUREoTc0vIApTjSyWANLwBM1P1sQ0ivJG3R6acPUJQgznQo+W+
2CKfCZ+QWCyjTAisfTvfPdM+F0mxgpaF2QHHnwa6gP9F5yycxYPEciYq/sNTdL43
v2aX6A34enMOpMr4BCpieS/bXoPTqxiA1sHE60ZYQNUV4azFkyFw9SMATSAzKYnE
N9yMthiUuV4TWFTQKdCSPYsf79foJqeDi2UZaSnc92mcTtqMLgT5Lgmairjp/xpw
QxNDVxRzd9gLeeYU4HTYCpLwxxvilWtXa4pUyR1W+NT+Aaa9o+IMrXSIfOEB2wBU
YTBrCaH3XVu4l85W5tA3VuSH0KUTkq5kNfNaX8cbZY844aZCcX6NAh1BLm7S3r5i
msA1hioHCD1OBxh0e7Jt6yL8AIMuJm14Gc7LPa2rRzS9X9slKhFsD8+/VKGdDh+v
Lztv+jlo/yE6cE+T9mGW6aJddY6zLwldGCQ+THIFHcGRWbLoivw=
=kE+V
-----END PGP SIGNATURE-----

--g5wty46coo2wjhpl--
