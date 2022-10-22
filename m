Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20D0608BBF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJVKj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiJVKjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:39:35 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06EE4D81B;
        Sat, 22 Oct 2022 02:57:05 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5BF0A1C09E5; Sat, 22 Oct 2022 11:55:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1666432557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3VXcTy4dq33vF1Lw5N+gimui6R5xNr99W5cU2xOMgEc=;
        b=k2zcvC8MJnqwGgPO5l+yOAAOtuoTRLM/xm7iKdUkJDIHH5oHYAORwxubH6dYAnO+IgiJPL
        X11DQNjjenSPrJR7fOiT7MgbhA1A2s4InzFtOkgYpdDsObwVZLEJkwwH1FK4QPHMHvUXXn
        NjsSEmCmBayAEwSZA3Hyvi1+1PDS554=
Date:   Sat, 22 Oct 2022 11:55:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] leds: max8997: Don't error if there is no pdata
Message-ID: <20221022095556.GA10427@duo.ucw.cz>
References: <20221020114442.22215-1-paul@crapouillou.net>
 <20221021131145.GB16264@duo.ucw.cz>
 <ADU3KR.HZPTLZCKPHT63@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <ADU3KR.HZPTLZCKPHT63@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >  The driver works just fine if no platform data is supplied.
> > >=20
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >=20
> > Does it? Bad Paul, bad Andy.
>=20
> Yes, it does.

Sorry, I misread the patch. Applied now.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1O+LAAKCRAw5/Bqldv6
8tY9AJ4qH2WFR1LgBtpTzKMQOvH8E++gvgCgomNJ4BSK068ZjOv1z3gfG5+glqA=
=horM
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
