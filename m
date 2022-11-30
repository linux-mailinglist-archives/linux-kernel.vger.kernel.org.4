Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3DA63D33F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiK3KYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiK3KYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:24:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0680B131
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:24:02 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1p0KFv-0001Om-FF; Wed, 30 Nov 2022 11:23:55 +0100
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:38ad:958d:3def:4382])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3361E12DD1E;
        Wed, 30 Nov 2022 10:23:54 +0000 (UTC)
Date:   Wed, 30 Nov 2022 11:23:53 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     Jean Delvare <jdelvare@suse.de>, linux-can@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        =?utf-8?B?TWF0xJtq?= Vasilevski <matej.vasilevski@gmail.com>
Subject: Re: [PATCH] can: ctucanfd: Drop obsolete dependency on COMPILE_TEST
Message-ID: <20221130102353.npbsl47zip5yhyyj@pengutronix.de>
References: <20221124141604.4265225f@endymion.delvare>
 <202211241556.38957.pisa@cmp.felk.cvut.cz>
 <20221125155758.ji5djevvycduuykt@pengutronix.de>
 <202211270909.57804.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="teyyivr27qvpsygw"
Content-Disposition: inline
In-Reply-To: <202211270909.57804.pisa@cmp.felk.cvut.cz>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
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


--teyyivr27qvpsygw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.11.2022 09:09:57, Pavel Pisa wrote:
> On Friday 25 of November 2022 16:57:58 Marc Kleine-Budde wrote:
> > On 24.11.2022 15:56:38, Pavel Pisa wrote:
> > > Thanks for the care. I cannot judge change on my personal opinion.
> > > But if that is general direction even for other drivers
> > > then I confirm the change.
> >
> > Should I convert this into a formal Acked-by: :)
>=20
> I you prefer formal one and agree with the change then yes.
>=20
> Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Thanks, the 'b4' tool picks up the Acked-by automatically.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--teyyivr27qvpsygw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOHLzYACgkQrX5LkNig
013bygf/bmJz3SMI+2ihr+T6oEhaAPRgqinH9RFVO2cJaroOLn51D7Fbdjn5kMJf
tnKyglQVHRSdWnG1JnLPjxvSmPKqRpxQnhXcdn2XxsQpKnyivx3jH7lscdZeqeO1
FxX1ypNPAZvEwhSQrZLn+aeswbmnotY06ZsGocLdpaEl3BtgQCLwIlq7fQrRHsR8
k2qlWsrOka9eKpLRoldHyVF5j+H/usIA9Wki0LxfhgRKP1DDl+ewC6xk1Am9vb1H
gYkV+kuBM8OcrVEvMNNPzTDLD8saZ0LluroHPHH6LY+xK6GDVcrjm+Z+vYe3KSGt
LCarylL8nNtsTVurqqy/LVbsSrQC9A==
=0Y03
-----END PGP SIGNATURE-----

--teyyivr27qvpsygw--
