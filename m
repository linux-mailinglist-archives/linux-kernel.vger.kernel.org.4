Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD867634AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiKVXJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiKVXJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:09:04 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D7CB7017;
        Tue, 22 Nov 2022 15:08:58 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 68DFE1C09DB; Wed, 23 Nov 2022 00:08:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1669158536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GI2Ao1YqhqfVzFF9Hmgl8saIhBJq+Op5pO2DH3V+ATc=;
        b=HDD6E1tmXtPABW9ZhoYTHGxiZauYH+pPH3M3EJUh2mAamz0zi6mDrgk+P55nJRO6vAHJQF
        MQqXP7WsQdDE1FNulV18PGRBRX2AV4Jpqjf2FQOSq++4ObGA1nHcbYiOGsjDiOOJHMRkDz
        /DqW5IdvQaGrjdzx8qtBRJ4os7RVJo0=
Date:   Wed, 23 Nov 2022 00:08:55 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: leds-wm831x-status: init chip_pdata before access
Message-ID: <Y31Wh3z/QU6NWZ68@duo.ucw.cz>
References: <20221122204837.11611-1-skhan@linuxfoundation.org>
 <Y305hfVdhs9zwOi/@duo.ucw.cz>
 <a77c38d1-1633-5421-6fab-6886b642fe66@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x4sEWpz0m1JkPymp"
Content-Disposition: inline
In-Reply-To: <a77c38d1-1633-5421-6fab-6886b642fe66@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x4sEWpz0m1JkPymp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2022-11-22 15:39:35, Shuah Khan wrote:
> On 11/22/22 14:05, Pavel Machek wrote:
> > Hi!
> >=20
> > > wm831x_status_probe() accesses status from chip_pdata before
> > > initializing it. Fix it.
> > >=20
> > > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> >=20
> > Does it? ARRAY_SIZE() will be compile-time constant, no?
> >=20
> > What is the bug? Did you test the code?
> >=20
>=20
> Is ARRAY_SIZE() safe when accessing the status chip_pdata->status?
> I wasn't sure. If so, this change isn't necessary.

I think so. Feel free to quite C standard to prove me wrong :-).

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--x4sEWpz0m1JkPymp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY31WhwAKCRAw5/Bqldv6
8k76AJ9rMhV61HT+oU3PrDTjKlwjBHxh0ACghvisv1NhzFrW//h09qSKpeGsxY0=
=x3py
-----END PGP SIGNATURE-----

--x4sEWpz0m1JkPymp--
