Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09115638DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKYP6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiKYP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:58:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B003620F77
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:58:07 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oyb5V-0000US-OT; Fri, 25 Nov 2022 16:58:01 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:339c:bb17:19c8:3a96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1D186129D53;
        Fri, 25 Nov 2022 15:58:00 +0000 (UTC)
Date:   Fri, 25 Nov 2022 16:57:58 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     Jean Delvare <jdelvare@suse.de>, linux-can@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: [PATCH] can: ctucanfd: Drop obsolete dependency on COMPILE_TEST
Message-ID: <20221125155758.ji5djevvycduuykt@pengutronix.de>
References: <20221124141604.4265225f@endymion.delvare>
 <202211241556.38957.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgiokipfrunhfoxf"
Content-Disposition: inline
In-Reply-To: <202211241556.38957.pisa@cmp.felk.cvut.cz>
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


--lgiokipfrunhfoxf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.11.2022 15:56:38, Pavel Pisa wrote:
> Thanks for the care. I cannot judge change on my personal opinion.
> But if that is general direction even for other drivers
> then I confirm the change.

Should I convert this into a formal Acked-by: :)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--lgiokipfrunhfoxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOA5gQACgkQrX5LkNig
0126nAgAmQENpZVa9otLOFgzFEV1oEzIeRqc6j4hnszkBtl/kNJjog8EwjgJMjWS
HxTUxRsXLpksjPMCugGYyH5CcRINn9JguvWKYvri3ObrreRR29lcTRvHVAjXcmYo
hauiaXdPEgnlPeIpZkAnqNVULpgoNTSnBv/V+oOpj01bQxIrAJkHeut8GpRqN1aq
LHwL0isX0Mjd8FjrQHnymv2dfyWMThjvAOqPcMccEOh/E+C5omwH1PoTH8Od2LaT
hQ2S5IpgzYViTm+UnJkO2jvgpc9aF6JpclM0zvzGX/TJ/OIAXlyodJjyv7JxwIJl
c+RDAmfiv7CH5RnMDmxO5JgJLg33lg==
=tafn
-----END PGP SIGNATURE-----

--lgiokipfrunhfoxf--
