Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC256FDD06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbjEJLmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbjEJLm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:42:28 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A5D2D68;
        Wed, 10 May 2023 04:41:54 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0ECEE1C0E50; Wed, 10 May 2023 13:41:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1683718894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdN8t02fmRh9vkqJqVA59w45T3a05/sMi3HibvKFFa8=;
        b=kIpZKNAk2P1inmFqA6lGpH23mXEVzcB+NIABIWn2Yh4ZiuVvzWt2DnIMp1i7EpHTklsCow
        l0GWi18+Ukv9KO9ApmbLUCpi7xywua/pDTwzThClQwK0EPcydKWY0TUupfGnppGiFMUeh4
        HJwgySBwmbUJYV1z9ck8NwGRxSrYRbU=
Date:   Wed, 10 May 2023 13:41:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Donald Buczek <buczek@molgen.mpg.de>
Cc:     Pietro Borrello <borrello@diag.uniroma1.it>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>,
        Carlo Caione <carlo@endlessm.com>, Lee Jones <lee@kernel.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Sven Eckelmann <sven@narfation.org>,
        linux-leds@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH 0/5] HID: manually unregister leds on device removal to
 prevent UAFs
Message-ID: <ZFuC7VEMJzdBulg/@duo.ucw.cz>
References: <20230125-hid-unregister-leds-v1-0-9a5192dcef16@diag.uniroma1.it>
 <288ed0da-8903-7dda-eb4e-f17037031e68@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oLZX/WVIO2dMMT7L"
Content-Disposition: inline
In-Reply-To: <288ed0da-8903-7dda-eb4e-f17037031e68@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oLZX/WVIO2dMMT7L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2023-05-10 12:12:50, Donald Buczek wrote:
> Is this series in a queue somewhere? Seems rather important and I don't f=
ind progress.
>=20
> Also, should be cc: stable@vger.kernel.org , right?
>=20
> CVE-2023-25012

It has Fixes, stable will pick it up.

And yes, "crafted USB device" can do a bad stuff. Severity is not too
high.

BR,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--oLZX/WVIO2dMMT7L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZFuC7QAKCRAw5/Bqldv6
8o4SAJ0XWyKFkKk54eQqqwQ/pknUOC9fgwCghvzorskvXsprzjSdqwvvm/Zr/B4=
=RYtg
-----END PGP SIGNATURE-----

--oLZX/WVIO2dMMT7L--
