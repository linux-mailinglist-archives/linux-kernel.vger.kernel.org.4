Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2326C7149
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCWTrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCWTrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:47:16 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F112A23A77;
        Thu, 23 Mar 2023 12:47:14 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BB4FD1C0E45; Thu, 23 Mar 2023 20:47:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679600833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jO6LrVvIvaoZRRQInuGap71JZS49bDrPQGqmKWF5rrU=;
        b=n4w0mIWMyNHiS0aD9D2kP5WHTqBCnHgX4iIiBs4becnTbyxVU6Pz5wo+xqbIJEy/pc5bHI
        lfMgBgcaLJkXV5+4R2Fk1RZcqGG0U1mrfFLOg3WpSmQSUhu1BD4XZ0+ChEShPx4oUhCJPt
        GmpRiGBg5KEjnhmPwcNHwtrkYmw1cl8=
Date:   Thu, 23 Mar 2023 20:47:13 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tom Rix <trix@redhat.com>
Cc:     lee@kernel.org, quic_fenglinw@quicinc.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: flash: set varaiables mvflash_3,4ch_regs
 storage-class-specifier to static
Message-ID: <ZByswXZdvtaLOT02@duo.ucw.cz>
References: <20230317191341.1670660-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MlvgGa6aPZUA/Ytr"
Content-Disposition: inline
In-Reply-To: <20230317191341.1670660-1-trix@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MlvgGa6aPZUA/Ytr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2023-03-17 15:13:41, Tom Rix wrote:
> smatch reports
> drivers/leds/flash/leds-qcom-flash.c:103:18: warning:
>   symbol 'mvflash_3ch_regs' was not declared. Should it be static?
> drivers/leds/flash/leds-qcom-flash.c:115:18: warning:
>   symbol 'mvflash_4ch_regs' was not declared. Should it be static?
>=20
> These variables are only used in leds-qcom-flash.c,
> so it should be static.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

BR,
								Pavel
							=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--MlvgGa6aPZUA/Ytr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZByswQAKCRAw5/Bqldv6
8hQMAKCEU+lvVVTeYJd+VCSdUYTHj6c4cgCgijcjRaytSXdJ8jS6QfD1udDiL0s=
=zJ1D
-----END PGP SIGNATURE-----

--MlvgGa6aPZUA/Ytr--
