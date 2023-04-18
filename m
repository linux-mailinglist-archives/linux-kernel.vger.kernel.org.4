Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CAD6E6047
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDRLrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDRLrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:47:09 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7252F65BF;
        Tue, 18 Apr 2023 04:46:40 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 40AFD1C0AB3; Tue, 18 Apr 2023 13:46:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681818381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vFfTEWZN/QfJxsdttGPsJNhEC2b2eErSmVYMSIiXHn8=;
        b=NqD/kBaNYpSxueau2Ond/wNTUnAKS65SUiqmQQfaDj3VOukpDoSnzQtfcwLaGr0n8Kop7c
        9i02+BLTiPt9N4xYfNODul+TwQoj3Ir0sPOl3br9U5rIzcPuKER62zskghD5vNNhBadmg1
        kKoMQY7HLb7hoG0tpihe4vNeY1W+pvA=
Date:   Tue, 18 Apr 2023 13:46:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Alexander Dahl <ada@thorsis.com>
Cc:     linux-doc@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee@kernel.org>,
        Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH] docs: leds: ledtrig-oneshot: Fix spelling mistake
Message-ID: <ZD6DDHJpzYiO7G/l@duo.ucw.cz>
References: <20230418113402.188391-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="agLCbShxrR2XL0x1"
Content-Disposition: inline
In-Reply-To: <20230418113402.188391-1-ada@thorsis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--agLCbShxrR2XL0x1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2023-04-18 13:34:02, Alexander Dahl wrote:
> It's no comparision, but a "first this, then that" situation.
>=20
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Acked-by: Pavel Machek <pavel@ucw.cz>



--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--agLCbShxrR2XL0x1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZD6DDAAKCRAw5/Bqldv6
8vf3AKCx+edVFtllBS6M1DflWeTErqnY/gCgv81JZn3sSDHDtfIqfXlHNvcaeDc=
=4kXR
-----END PGP SIGNATURE-----

--agLCbShxrR2XL0x1--
