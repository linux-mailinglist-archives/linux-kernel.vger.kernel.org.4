Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72C69B9DD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBRLtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRLtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:49:19 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CBD1716E;
        Sat, 18 Feb 2023 03:49:18 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 15A701C0E0B; Sat, 18 Feb 2023 12:49:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1676720957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MrT/EFdUKIU+QQlz/ufzFcdq3rjNr1BzPWs3Kp+y7A4=;
        b=orNXhvI09gvhvis+8LFhbtk6jzrig675VbX0ZbGHnaVtQsbOqzjQ7d3f11ovcxUTFiYSjQ
        guCwjvGFYpoUsQzgH5Fr8L+9A2HBmZiHDj2qtjDLOxDcNv7w1BYCNe1vJJjNqW3YqofvEe
        T9626V/IGoDJgp99ABxEutYlW/4EhgU=
Date:   Sat, 18 Feb 2023 12:48:32 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Brian Geffon <bgeffon@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: hibernate: don't store zero pages in the image
 file.
Message-ID: <Y/C7EO5xUHh4p/MS@duo.ucw.cz>
References: <20230113193006.1320379-1-bgeffon@google.com>
 <20230114001518.1378049-1-bgeffon@google.com>
 <CAJZ5v0geG==MmZfvFBZgkuOuWE17BXYSMEzcYmyz6CALp6w2Fw@mail.gmail.com>
 <CADyq12wAkX+hAzuFgHj7k_Woy=G+3PLwpTc+UUxjp4bPe46_cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jyqNYtISB/UAdYjy"
Content-Disposition: inline
In-Reply-To: <CADyq12wAkX+hAzuFgHj7k_Woy=G+3PLwpTc+UUxjp4bPe46_cw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jyqNYtISB/UAdYjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I need some more time to go through this in more detail, so it is
> > likely to miss 6.3.  Sorry about that.
>=20
> No problem, consider this more of an RFC, it seems like a
> low-risk/low-cost way to reduce image sizes so I was just hoping to
> get feedback. Take your time reviewing.

Seems like special case of compression, really, it might be better to
leave it to compression algorithm to solve that.

Not sure if lzo is optimal if you want max speed, but things like gzip
should be "almost free", too.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--jyqNYtISB/UAdYjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY/C7EAAKCRAw5/Bqldv6
8jYYAJ9Jesunbjudh4VRVUkCCIX0APEW7gCfRo3vne1VvjeV9QbgWj4um19wWf0=
=bp9r
-----END PGP SIGNATURE-----

--jyqNYtISB/UAdYjy--
