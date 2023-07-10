Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB31E74D551
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjGJMZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjGJMZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:25:26 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35196C7;
        Mon, 10 Jul 2023 05:25:25 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9E6E01C0DE7; Mon, 10 Jul 2023 14:25:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1688991922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=curtjXJ4kh1o3mohtu+aJ/JbgLuBaXO5IEHSOZ/VY6Y=;
        b=ipCCBXeP6UgFbO0lrBtxzDHdRZxO/ZB/XNP6zbsIokZWNHaNlzsSmoAOXV+a9C9OeLH6zJ
        2l/I+JoW0lYszs9Gsna+Kg2JmXdTGJoLk1kBeXWzkYiXbawZlU11OVbeFBWXDx2KyMZ2x9
        03Ts3JrIsZtEybBZtZNuyyWqvpJw5cc=
Date:   Mon, 10 Jul 2023 14:25:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bulk LED API
Message-ID: <ZKv4sj+dsUx/K5/u@duo.ucw.cz>
References: <5324811.I0CZgJUjXn@archbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bDNwW0r18BQ1vT5m"
Content-Disposition: inline
In-Reply-To: <5324811.I0CZgJUjXn@archbook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bDNwW0r18BQ1vT5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Beyond LED strips, LED matrices exist too. I'm not sure if those
> would rather be best implemented as DRM panels instead however.
>=20
> So here are my questions:
>=20
> 1. Am I correct in my assumption that such an API currently does
>    not exist?
>=20
> 2. Does mainline Linux care about addressable LED strips enough
>    to theoretically accept some of the concepts proposed in this
>    message, ignoring the fine details for now?

Yes, matrices exist. I'd suggest treating them as DRM/FBDEV. If you
have 1000 leds in a strip, it may make sense to treat them as 1000x1
display, too.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--bDNwW0r18BQ1vT5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZKv4sgAKCRAw5/Bqldv6
8rCTAKC41WnawvH9ecVuAQ5ugSkn7Gb3ewCgvsEAJT/Hh57Ig3dz63RkL5f1foc=
=7/w8
-----END PGP SIGNATURE-----

--bDNwW0r18BQ1vT5m--
