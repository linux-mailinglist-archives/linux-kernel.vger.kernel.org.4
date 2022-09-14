Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF82A5B8BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiINP0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiINP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:26:44 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03297E823;
        Wed, 14 Sep 2022 08:26:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 46870E04A4;
        Wed, 14 Sep 2022 08:26:12 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ToQhBhfMY8wI; Wed, 14 Sep 2022 08:26:11 -0700 (PDT)
Date:   Wed, 14 Sep 2022 17:26:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1663169171; bh=GRd0Er8cQRzg8b9o6N6209YQvGuoI3bMVzGgJgqeQA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vbsktjz81ajC+5URgeBDFHzm9asyXTsk/lvVl5hh4Ug11pxkXCjvoyQtp9AJMBwVL
         whUfKjM+oRL4NC7qxBlXwl0gnfsiV/TK4XcdYMCWfvxniOn3o6YaPCICI83oHoJFaE
         dihOYCJON3j/TWtds+c2BhuONlpycZRFDxXSWSCfZ0Ki886HwdQLjIAlklqtNsLpgm
         DwePa7+CO2LW8g0pv2yA+rM4FX1XEus/SGXPhGJydnklF3a3nPZu2JfA5uWOG/u8/o
         fhYMOGtbn7+AaIySt6cIlFsBQsIiXB1/UpeswuLeXBSj7HWKQMqFSi7i11G6jhJTRJ
         XX5dGQ3I0MiYw==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: imx: Round line size to 4 bytes
Message-ID: <20220914172600.0666326b.dorota.czaplejewicz@puri.sm>
In-Reply-To: <YyHlXMHuUHBqipd0@kadam>
References: <20220914113436.1503790-1-dorota.czaplejewicz@puri.sm>
        <YyHlXMHuUHBqipd0@kadam>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j8w0hyz.ZiK=Yh=0nN_TgSS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j8w0hyz.ZiK=Yh=0nN_TgSS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 14 Sep 2022 17:29:48 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Wed, Sep 14, 2022 at 01:58:08PM +0200, Dorota Czaplejewicz wrote:
> > This has been broken in e352833d, which does not actually copy the logic
> > from 056f9af9.
> >  =20
>=20
> There is no commit 056f9af9.  Always the human readable subject for the
> patch.  Also use 12 characters and not 8 so we don't get two commits
> with the same hash.

Thanks. Unbeknownst to me, no one ever applied or rejected the patch series=
 I sent and saw under 056f9af9.

I'll send a fresh series in a moment.

Cheers
--Dorota
>=20
> Please add a Fixes tag.
> Fixes: e352833d32e6 ("media: staging: media: imx: imx7-media-csi: Import =
format helpers")
>=20
> A Fixes tag can be used to automatically determine if a patch needs a
> backport or not.  It's just useful information as well.
>=20
> > Section 13.7.6.13 "CSI Image Parameter Register" of the
> > i.MX 8M Quad Applications Processors Reference Manual
> > states that the line size should be divisible by 8 bytes.
> > However, the hardware also accepts sizes divisible by 4 bytes.
> >=20
> > This patch accepts line sizes divisible 4-bytes in non-planar mode.
> >=20
> > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > ---
> > Hi,
> >=20
> > in recent kernels, I've noticed that the Librem 5 camera driver no long=
er works. The s5k3l6xx out of tree sensor driver uses sizes divisible by 4 =
and not by 8, for which I submitted the patch 056f9af9 . The new kernels no=
 longer accept sizes divisible by 4.
> >  =20
>=20
> This information needs to be in the commit message.  Otherwise the
> commit message just sounds like theory and abstraction which we do not
> care about.  We do care about real hardware which is not working and
> especially if it used to work.
>=20
> I'm not really qualified to review the details of this patch.
> Laurent is best qualified to review this.  He'll get this message
> because he's subscribed to the lists but it's also good to CC him as
> well because he's probably drowning in email like the rest of us.  I've
> added him.
>=20
> regards,
> dan carpenter
>=20


--Sig_/j8w0hyz.ZiK=Yh=0nN_TgSS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmMh8ogACgkQADBpX4S8
Znfllw/+LcG/SOyQ3hwUs7MwKwIDVZJe14dBhMUAqEyfl2dq+UapNpAQC9kl7+Nz
XJn4ix4mhtK9X6W180uCMwQmARWpp/SqLENvyY+3WFDSubQ+prOVhSZ0F2SPeig0
H0/CdwbXJcSNzpUhm1k3Zyp0UaOzGKxAUVTr87jJYr3GchqM3m5ZVREtf8vEE48G
q5SucKQ1Rc1B6cwqCAHJMF0Jj8do8Fs0NousILkaUCaPt/sH07nN0S43LiiFrH7z
xPvGc2lQP2e82TfflARa42nXYap2LUOf4fEdSe2+VSQmpunpT/uMX0VkT4QpTSsf
GwlaK6obeh/4CvI57t4hNRkJD9A8gr3L2zkEN4sQuFkesnE3sROiSXzKZLvBEoWx
i4aTPLvkC95HgoycjK9D9A+Nbf6g/laIa5C4CVRQuKkfnuY05jdIQ+uXjI/0IwQC
CJY3XPfMkd60PfiE7dZK6iAD92u7WbNCH8jrzQhE1+h3YVhXsIudRRQ7VGecLWZK
wnPn0nMg3fjs5Vh7QI4WZG2bzH3kXVrZx/vQigsOBOdDakchAPl1mZNGuv1L6Gww
rp+HMiPudloJG1d+eurZhLFzQRKUtB+WRFZ/7LmxnuXRIkpe6XqStvGr6KXE0471
+EQd6VVf+WSOYiRHkYtgQSh/mCbyefJkHZlfjXYIhZR2kztY7DY=
=JWjV
-----END PGP SIGNATURE-----

--Sig_/j8w0hyz.ZiK=Yh=0nN_TgSS--
