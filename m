Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6CC6461DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLGTsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGTsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:48:20 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6003F6A771;
        Wed,  7 Dec 2022 11:48:19 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 340371C09FA; Wed,  7 Dec 2022 20:48:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670442498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pV76Hk4p0gjF+gJbarX3/LanlORlaqG71wu1jjPudTQ=;
        b=sLR9/oMouvcL32NbZJimF6TpSzQPqeuQ/6VAEev31ORxE/dWz+YsalktZgFCOXEu00HPSv
        Op4JMLeOAvXa4ii9suInQPjrxbOW9xjNctlygmR9wC/DRY3lT8Rjp/pO5yRtYZulNW8m3X
        s8ZmQ7ZXYNTdBYfKs+AXWXjVUHdz5wE=
Date:   Wed, 7 Dec 2022 20:48:17 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Martin Kurbanov <MMKurbanov@sberdevices.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 2/2] leds: add aw20xx driver
Message-ID: <Y5DuAVKu/nSXMkUa@duo.ucw.cz>
References: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
 <20221124204807.1593241-3-mmkurbanov@sberdevices.ru>
 <ba4918dd-309c-5e6e-dc0a-eb5f1c4b1dfa@linaro.org>
 <cb9e8610-588e-6e56-ee33-8716008e7905@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YPyNi6T0Sa/IOl4J"
Content-Disposition: inline
In-Reply-To: <cb9e8610-588e-6e56-ee33-8716008e7905@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YPyNi6T0Sa/IOl4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2022-11-28 17:45:22, Martin Kurbanov wrote:
> On 25.11.2022 11:19, Krzysztof Kozlowski wrote:
> >> +    $ ls -l /sys/bus/i2c/devices/xxxx/pattern0/
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 clear_le=
ds
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 fall_time
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 loop_beg=
in
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 loop_end=
_on
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 max_brea=
thing_level
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 min_brea=
thing_level
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 mode
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 off_time
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 on_time
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 ramp
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 repeat
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 rise_time
> >> +    -r--r--r--    1 root     root          4096 Jan  1 00:00 running
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 select_l=
eds
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 start
> >> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 toggle
> >=20
> > sysfs documentation goes to Documentation/ABI/
>=20
> Should I add it to Documentation/ABI/testing/sysfs-class-led-driver-aw200=
xx?
> Is my understanding correct?
> Is KernelVersion parameter required?

You really should take a look at pattern trigger. You should probably
use same API as it does, perhaps documenting which patterns this
particular driver can do in hardware.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--YPyNi6T0Sa/IOl4J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5DuAQAKCRAw5/Bqldv6
8mObAJ9Ttr9cl0QqYrY6QtBoeasPg7J9GQCgoMy2SRCGRLopishZ74EE2vYnnhM=
=E94U
-----END PGP SIGNATURE-----

--YPyNi6T0Sa/IOl4J--
