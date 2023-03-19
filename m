Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ADB6C025E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCSOVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjCSOVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:21:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2837C1D906
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:21:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdtuK-0001j9-50; Sun, 19 Mar 2023 15:21:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdtuB-005FIQ-4t; Sun, 19 Mar 2023 15:21:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdtuA-006A3C-E9; Sun, 19 Mar 2023 15:21:02 +0100
Date:   Sun, 19 Mar 2023 15:20:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     lizhe <sensor1010@163.com>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] nubus: Remove redunant driver match function
Message-ID: <20230319142058.cfu3ftjfaut3pqzt@pengutronix.de>
References: <20230319040816.232446-1-sensor1010@163.com>
 <3d77744b-ea67-a5bd-8126-f3d56e608add@linux-m68k.org>
 <4cd5783e.1665.186f9882231.Coremail.sensor1010@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6yuzzdzry6sztqir"
Content-Disposition: inline
In-Reply-To: <4cd5783e.1665.186f9882231.Coremail.sensor1010@163.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6yuzzdzry6sztqir
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lizhe,

On Sun, Mar 19, 2023 at 07:01:33PM +0800, lizhe wrote:
>       Fthain.
>       I was the first to submit this patch,

You sent a patch doing this conversion to several drivers at once[1]
back in May 2022. You were asked to split up by subsystem and I cannot
find anything more recent; neither in my inbox nor on
lore.kernel.org[2]. So unless I missed something I wouldn't claim you
already sent this patch.

> u.kleline-koenig, please
>       delete the path you  submitted, this patch does not belong to
>       you

Even if I'd agree, I couldn't. That's up to Finn (I think) to drop this
patch again from his queue and then accept a similar patch from you. If
that's what Finn want's to do and it makes you happy, I won't oppose for
the sake of resolving that argument.

Having said that I didn't even remember your patch. I just stumbled over
this patch opportunity while doing some treewide cleanups.

Best regards
Uwe

[1] https://lore.kernel.org/linux-kernel/20220506045952.136290-1-sensor1010=
@163.com
[2] https://lore.kernel.org/all/?q=3Ddrivers%2Fnubus%2Fbus.c

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6yuzzdzry6sztqir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQXGkoACgkQj4D7WH0S
/k7CaQf9HQmGYLu7JLJnM/pOMKBhOQ7vR9IUB87LaD064XcX5coS61AJnLfhnQYi
SlfE/J0qdMNMCTIMhhBdfgcc3juDQDkVDZUN69EKCIbIUsjaDfGqW9E5K+pXvKp0
rVoH9OgHG67sbZKYxJMmjEgxfAboNoBtVhNOYPkPbouzYuNB2wtssHAN6yFZbQ2O
vuR4ZTabxkSP4PBNR4LJejxd6/J6x0TiVAFrilbBoYDUC/Z1m9uoQRMDoIOIcdYZ
Y7tZJQlSzVdurHLPQmsf7bZb2y0Y+ixNjHc0LhfUPZYfqLA4BSa6Vd2OGklrNYhP
dc4wXQvCW67wX6Et4HWKx2BYhY2AeQ==
=3HW7
-----END PGP SIGNATURE-----

--6yuzzdzry6sztqir--
