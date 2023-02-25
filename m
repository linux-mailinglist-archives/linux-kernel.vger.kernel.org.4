Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E346A281C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 10:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBYJNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 04:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYJNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 04:13:45 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A7911E9D;
        Sat, 25 Feb 2023 01:13:43 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2F90A1C0AB2; Sat, 25 Feb 2023 10:13:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1677316421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vSGD016VSliM8iYt5hXOdqQTHiF7OfjIaZHqRxtbcps=;
        b=RbyMdpNrIH7P3FMWlF1hE/phucMmLtKkw+a97ArYLe4bVN+DO4rCZWxfLywxB6v4Wo5Tne
        qoRyk3O5bhPvoy7jHZ9jqQ/6M+bD/4zpqa0Ob23eFn+nU0VMIXAtCXU4x1GUiDp7jXyRQb
        mRX8Ufkcx6+AdO8woEwsGvK/MBB6toQ=
Date:   Sat, 25 Feb 2023 10:13:40 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Michael Everitt <gentoo@veremit.xyz>,
        Christian Eggers <ceggers@arri.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-6.1-rt ?
Message-ID: <Y/nRRHo1XtRenC6u@duo.ucw.cz>
References: <12136223.O9o76ZdvQC@n95hx1g2>
 <208196df-d0b2-5cf6-29b3-4570a0946e77@veremit.xyz>
 <Y7/cYsEXHpCEGwwa@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Hrxy3MuuQA4PAN0i"
Content-Disposition: inline
In-Reply-To: <Y7/cYsEXHpCEGwwa@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hrxy3MuuQA4PAN0i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > You probably want this: https://www.spinics.net/lists/linux-rt-users/ms=
g26345.html
> >=20
> > You may wish to wait for the maintainer to complete their processes!
>=20
> There is a 6.1-RT but it hasn't been updated for a while. There should
> be a 6.2-RT later today.
> As for the link [1] it has not been confirmed nor denied that v6.1 will
> be a LTS kernel. Once the version 6.1 left its Schr=F6dinger state then
> there will be an update (or not).

Apparently 6.1 left the Schr=F6dinger state, and it is confirmed as LTS.

If there are any news regarding 6.1-rt, world wants to know :-), but
maybe that is better discussed on realtime meeting?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Hrxy3MuuQA4PAN0i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY/nRRAAKCRAw5/Bqldv6
8l4eAJ97T4kgiw4pmSNSrNTNy/kj/TtDtACeK/zt9ibLW+G4i1QJJfwCECa/nJA=
=92e+
-----END PGP SIGNATURE-----

--Hrxy3MuuQA4PAN0i--
