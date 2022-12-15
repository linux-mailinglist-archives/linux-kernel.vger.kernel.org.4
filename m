Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5944E64DCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLOOXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLOOXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:23:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7751E2A25B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:23:29 -0800 (PST)
Received: from mercury (dyndsl-095-033-168-084.ewe-ip-backbone.de [95.33.168.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 329456602C62;
        Thu, 15 Dec 2022 14:23:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671114208;
        bh=kiDCewceedZp5pIKfOwtRscKxt3i3OPSRMqQVMT5Dd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nz7a11TvHvh8PUR6ozb4Cbk7dXEVjOLGG/Na45Q8PpGJhpcGu2+Xi1xeYtHZQYrlO
         n1NP6duOgEadwJXWZQW1uDRl6Qvtal8hG6rZzeqUNCKDycHSoUxb0lG6qZh3gtyDYN
         XbePz4Cmk1AigP87cHuxTkXJ+8NzjaJ5lGyiRT9SQvbwv4gv4lZPOftJTxyuUfm2tx
         rBNW6lyqrq4sVZM5NTMSxXMtpGJ+vztUCtBxyKqmxDSSOO6/u7ghZ5KgxbJA5vQihG
         ucuOhCIpiwlSeIoBEpj7eGd/YfYADFM80y5aKUQmkzE1wtEdMwO2ublMQLkzBKY8TD
         ioYLDsrvbWYjw==
Received: by mercury (Postfix, from userid 1000)
        id E44FD1060F45; Thu, 15 Dec 2022 15:23:25 +0100 (CET)
Date:   Thu, 15 Dec 2022 15:23:25 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv2 1/1] ARM: improve Cortex A8/A9 errata help text
Message-ID: <20221215142325.rtwle6xxmrfd72mi@mercury.elektranox.org>
References: <20221214175327.57703-1-sebastian.reichel@collabora.com>
 <e81df256-cd0f-403a-9405-a126aac7447d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="22s4wwwcvtt2bqz7"
Content-Disposition: inline
In-Reply-To: <e81df256-cd0f-403a-9405-a126aac7447d@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--22s4wwwcvtt2bqz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 15, 2022 at 02:58:43PM +0100, Arnd Bergmann wrote:
> On Wed, Dec 14, 2022, at 18:53, Sebastian Reichel wrote:
> > Docuemnt that !ARCH_MULTIPLATFORM is necessary because accessing
> > the the errata workaround registers may not work in non-secure
> > mode and mention that these erratas should be applied by the
> > bootloader instead.
> >
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Can you add this to Russell's patch tracker?

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=3D9281/1

-- Sebastian

--22s4wwwcvtt2bqz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmObLdIACgkQ2O7X88g7
+pq/8RAAijv/8qT0qI2XuBa2k4bwxg9MQYDEkGqMqA1acdXcQCDA3uvUyqU87w1l
prD+UNnKbsh2Whn3ObXv1PyeZAmw5eQLovFc5UDzw/7oUPNXSzFWD0pIXqSQ89z9
BDEE1ZVl6s2bVk75Zcs3xUU0zZYMEQuOQP0Vm8NCFjQl/bXMN6BM5MkNjeWyEJYg
M/fvcqUHp9JLiPQ/jvCibKQ1TyJKy5FiHW874QOmPKO4ztVUj7uVLtmg0MTzx1eD
zMUkg2wtucpkuHsTAFCbz3YX1q/qdzCoV1iWPP4ctpN9Pa3GogxfX8xUNyOO2FzD
v5n6aNHuG7688M1biA/wnIQ+cg1u//oreXy50HV6Nty6H8rlfS2YoCaUWIMXDhvn
53V61s4QO0zUzUAnu7iJkxoXPubiArtz+LsBB68mxkRCsOHdnhLl14iRtf2zm9gQ
A5R6qKyZiIE5vfGj0+w7uE4gCHGVAcXtNv/f2LN/UXjLJGDcy3ScVLohSX2vOnuA
Pyexc9a3eDGUvvITaBUwxX4Dtm7Ug3AgGIJR5KLmpK5MPetUSfRgsQSKsiPeAd3y
2MtTUi3OOCwgug82RhX4s+HDEgrZ0WcDauzIgAIqO3YTGLyN3HaMqlDeQdTxU6vx
Ue/TG1v6A6PByqPOXw409HkOSQUYQyU3to1wEqwxbHIMrN9TjKs=
=G1cM
-----END PGP SIGNATURE-----

--22s4wwwcvtt2bqz7--
