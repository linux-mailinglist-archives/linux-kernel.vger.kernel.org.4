Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B11608BEB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiJVKss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiJVKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:48:05 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6C736DF4;
        Sat, 22 Oct 2022 03:05:42 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 42D611C09E5; Sat, 22 Oct 2022 12:04:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1666433091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dglD9eYSoY+3krortBgXrhoLYnL9pFjbZFahJEBGrus=;
        b=jxD7H1772uFc+xkDEUXOUxBX27YukDMzrm02WH+qL6K+4jZpBm1L5ruhpOlDDRiaQAZeir
        KJtHd1k3R/xh+mcnTUgeuwTtZxLGOqbvWtv+mD1yOefh0HA65FNeRFDfWHtDrYtvMu2jJV
        3PqU5vBktC1N4TFkfKMSBirTMEFzrHc=
Date:   Sat, 22 Oct 2022 12:04:50 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-leds@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 12/21] leds: remove s3c24xx driver
Message-ID: <20221022100450.GD10427@duo.ucw.cz>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-12-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline
In-Reply-To: <20221021203329.4143397-12-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The s3c24xx platform is gone, so the led driver can be
> removed as well.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

git am failed, but I guess this is not critical...

Best regards,
								Pavel
							=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1PAQgAKCRAw5/Bqldv6
8j2UAJ9TSLqUb87pUMzXln9X7UAKeZvTRgCfWgHUaFpSlcgtO7F7LJE9R5khcUs=
=pSY8
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
