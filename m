Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769356C0D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCTJk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjCTJk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:40:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392FB1285D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:40:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1peC0Z-00034b-RY; Mon, 20 Mar 2023 10:40:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peC0V-005QQr-V7; Mon, 20 Mar 2023 10:40:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peC0V-006PDg-6i; Mon, 20 Mar 2023 10:40:47 +0100
Date:   Mon, 20 Mar 2023 10:40:47 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     lizhe <sensor1010@163.com>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1] nubus: Remove redunant driver match function
Message-ID: <20230320094047.bepgy6kud7e23nf2@pengutronix.de>
References: <20230319040816.232446-1-sensor1010@163.com>
 <3d77744b-ea67-a5bd-8126-f3d56e608add@linux-m68k.org>
 <4cd5783e.1665.186f9882231.Coremail.sensor1010@163.com>
 <20230319142058.cfu3ftjfaut3pqzt@pengutronix.de>
 <04bd0e13-d866-22f4-2b7a-200a31722a46@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m2rzkgzxqqkppypu"
Content-Disposition: inline
In-Reply-To: <04bd0e13-d866-22f4-2b7a-200a31722a46@linux-m68k.org>
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


--m2rzkgzxqqkppypu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Finn,

[Cc +=3D Geert]

On Mon, Mar 20, 2023 at 02:49:41PM +1100, Finn Thain wrote:
> On Sun, 19 Mar 2023, Uwe Kleine-K=F6nig wrote:
>=20
> > On Sun, Mar 19, 2023 at 07:01:33PM +0800, lizhe wrote:
> >=20
> > > u.kleline-koenig, please
> > >       delete the path you submitted, this patch does not belong to you
> >=20
> > Even if I'd agree, I couldn't. That's up to Finn (I think) to drop this=
=20
> > patch again from his queue and then accept a similar patch from you.=20

Iff the patch under discussion is considered for applying: I just
noticed we want:

	$Subject ~=3D s/redunant/redundant/

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m2rzkgzxqqkppypu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQYKh4ACgkQj4D7WH0S
/k5Q8Qf/eM0TX5AUY35OMQjbh4bhF+9sECQUMmh5bp/qII6VCm4DkHHwCR6dR4f9
3rjwYQJoXb42WF1+wXB1ztcZBRMUn7DbmiyIxDntkObtE5LbiUIOVFzerl+oZyUs
+mTAD8/0OAPIVjWfIbeJKQ39D+kbOQSfOWyRNRCjnkYI0GqC4fJY9rjF3K4+vWub
QMWIe7HgKMdBFzIX9mjWRlRzRe2JV44+rDxvlYTv2uZiKrvbpeTU8gChGvy0aFj0
K5J92UOVjCUoy0UuSoFQD9N3Uw9k9NsQWMICYgSMGwWLbmCVuZuBdDvqz4tLKuR2
4XZzozC0JSWX5V6HRSONJgFVOxQsog==
=xAEy
-----END PGP SIGNATURE-----

--m2rzkgzxqqkppypu--
