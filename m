Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0079D5EB2F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiIZVSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIZVSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:18:05 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BCB7E80D;
        Mon, 26 Sep 2022 14:18:04 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 980AB1C0017; Mon, 26 Sep 2022 23:18:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1664227082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uHN29aw8Ael4kXC3mFMWHH6lL2txDyW+9yNOhYFHFyU=;
        b=GKROv+ztxHRiKx38LumNvHDMBLABxrJWb1GMVS0/b5OkTG5TK3TMsTw805H0d6e6dV5xPR
        Z1NCgXXb8TL8ZYDSRLa1iy2R1iE0qC9/iwJtmJG0VuULxhA9F/JWdRwkr+c+b4qE9jGtRX
        7yqarXZzkx08S/dw8NXIfirjfCV0/0U=
Date:   Mon, 26 Sep 2022 23:18:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     broonie@kernel.org
Cc:     Bernardo Rodrigues <bernardocrodrigues@live.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the leds tree
Message-ID: <20220926211801.GA18066@duo.ucw.cz>
References: <20220926205301.614077-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20220926205301.614077-1-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> After merging the leds tree, today's linux-next build (x86 allmodconfig)
> failed like this:
>=20
> /tmp/next/build/drivers/leds/leds-pca963x.c: In function 'pca963x_registe=
r_leds':
> /tmp/next/build/drivers/leds/leds-pca963x.c:355:3: error: this 'if' claus=
e does not guard... [-Werror=3Dmisleading-indentation]
>   355 |   if (hw_blink)
>       |   ^~
> /tmp/next/build/drivers/leds/leds-pca963x.c:357:4: note: ...this statemen=
t, but the latter is misleadingly indented as if it were guarded by the 'if'
>   357 |    led->blinking =3D false;
>       |    ^~~
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>    fd6dd9584ed3ee6deb ("leds: pca963x: fix blink with hw acceleration")

Thanks, fixed and pushed out. Someone please check my fix is right.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYzIXCQAKCRAw5/Bqldv6
8rr2AJsHxmPgkAUb+LSbYmMfBR0Jp2zJeQCfZCZjcyPCk3g4N7RQU8B7QfwIrSU=
=8SPO
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
