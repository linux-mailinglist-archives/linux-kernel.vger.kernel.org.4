Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F531655AB5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 17:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiLXQYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 11:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiLXQYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 11:24:36 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A5D2DF2;
        Sat, 24 Dec 2022 08:24:34 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B17E21C09F4; Sat, 24 Dec 2022 17:24:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1671899072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLSwP1mqtD+5aHUsmlzOAFN5IZw+LcyyPNXjFF5e900=;
        b=mzWh/mRCvlNvshHprDT3Bxkgop1//gpHSN0N/WiSGmDYhWKK5jZus8/a2WR3aR3Ftu9yMk
        g61AyNqtDd0L8lGQAyutXo/dz7lC5+LnfRe3SCq8UlgMbFqXIN080H/ag+mK2Wl1ttRujw
        uulOZ7bFoDvm4VJ8E9ITwDM6b6Vom1A=
Date:   Sat, 24 Dec 2022 17:24:32 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-ID: <Y6cnwA9ULyMXlL2j@duo.ucw.cz>
References: <20221202182758.1339039-1-gregkh@linuxfoundation.org>
 <20221224095353.w32xhmyzlft6qi4v@pali>
 <Y6bObzIoHrJMotI3@kroah.com>
 <20221224101139.sgvhr2n3pbrs4agm@pali>
 <Y6bvh48kTTzbMX6M@kroah.com>
 <20221224133425.vlcxbaaynihiom4a@pali>
 <Y6cXRbGUsarzoJEw@zn.tnic>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4TKnUpmhT+oKcbQi"
Content-Disposition: inline
In-Reply-To: <Y6cXRbGUsarzoJEw@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4TKnUpmhT+oKcbQi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> On Sat, Dec 24, 2022 at 02:34:25PM +0100, Pali Roh=E1r wrote:
> > And asking question back is not the best way too.
>=20
> Maybe I'm missing something here but is there a logic/rule somewhere
> which says to inform *you* when this driver gets removed?!

You are not exactly polite here.

Anyway, we have rule saying "no regressions" and that includes "we
don't remove drivers people use".

(And yes, at some point we do ask people using the code to also
maintain it...)

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--4TKnUpmhT+oKcbQi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY6cnwAAKCRAw5/Bqldv6
8ksdAJ9aN8MdVErtcgkxx40yUgWSeREK5QCgwUBBGfnXB9UWlmNIP7fVzm82WyQ=
=eBRl
-----END PGP SIGNATURE-----

--4TKnUpmhT+oKcbQi--
