Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06D3646202
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLGUDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGUDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:03:49 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8592E13D7C;
        Wed,  7 Dec 2022 12:03:48 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 52F5D1C09FA; Wed,  7 Dec 2022 21:03:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670443427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rvBWmN92kGuv4fv/6ip6ueTE56gLU2bWdfROfEqlZ5g=;
        b=QR8nW8zLXeYKFhsit8Lj69jLySPPDtB65qjAol0T1EQooKt1nxtSXUouXJ5YXDDRb7+EHN
        3sSuWbKGaMSv5qhhwdgjmGUYVfKZkIH456EUjQI5H0WI5G7aIXM/VsrjsEkrt04p8+XOqv
        ua50iGNl9l0QZTvEZlwZCRoCYZsMqmE=
Date:   Wed, 7 Dec 2022 21:03:46 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-leds@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: is31fl319x: Fix setting current limit for
 is31fl319{0,1,3}
Message-ID: <Y5DxoqlDdcOma+jC@duo.ucw.cz>
References: <20221129212901.1049085-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="llhJ/jVmylD8gtto"
Content-Disposition: inline
In-Reply-To: <20221129212901.1049085-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--llhJ/jVmylD8gtto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2022-11-29 22:29:01, Luca Weiss wrote:
> The current setting lives in bits 4:2 (as also defined by the mask) but
> the current limit defines in the driver use bits 2:0 which should be
> shifted over so they don't get masked out completely (except for 17.5mA
> which became 10mA).
>=20
> Now checking /sys/kernel/debug/regmap/1-0068/registers shows that the
> current limit is applied correctly and doesn't take the default b000 =3D
> 42mA.

Thank you, applied.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--llhJ/jVmylD8gtto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5DxogAKCRAw5/Bqldv6
8ibUAKCum3Kn5eVHgiC3K+xRT6VRbR3QiACgvWpVcAiDbap9igfW/1HEjaDvYac=
=g+e4
-----END PGP SIGNATURE-----

--llhJ/jVmylD8gtto--
