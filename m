Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B55974CD9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjGJGti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjGJGth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:49:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B005AA6
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:49:36 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qIkhz-0004j7-25; Mon, 10 Jul 2023 08:49:19 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3A4901ECAA5;
        Mon, 10 Jul 2023 06:49:15 +0000 (UTC)
Date:   Mon, 10 Jul 2023 08:49:14 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Su Hui <suhui@nfschina.com>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, uttenthaler@ems-wuensche.com,
        yunchuan@nfschina.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v2 09/10] can: ems_pci: Remove unnecessary
 (void*) conversions
Message-ID: <20230710-parachute-dispersal-208e1a406b78-mkl@pengutronix.de>
References: <20230710064138.173912-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vliygvx23paytwk4"
Content-Disposition: inline
In-Reply-To: <20230710064138.173912-1-suhui@nfschina.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vliygvx23paytwk4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.07.2023 14:41:38, Su Hui wrote:
> From: wuych <yunchuan@nfschina.com>
>=20
> Pointer variables of void * type do not require type cast.

I like the idea. Please add my Acked-by: Marc Kleine-Budde
<mkl@pengutronix.de>, after you've fixed the issue:

> Signed-off-by: wuych <yunchuan@nfschina.com>

This patch is not Signed-off-by the contributing person.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vliygvx23paytwk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSrqecACgkQvlAcSiqK
BOiTlQf+KaGq+RQKecV2KZC82/U90JGtuIisVjkNKRh/mMhg+6CPgj37A36dJopA
B309j3311kHTCuBsPWfD+IXLkOunPKJRGtxL+IxsXWtcAClti6YDG7HqUYGl9Mpi
f0vyLf1xV60WUFTu6yJ2w6Rn25G79SM+071PWHHgDGqqb2vSYZFIY8d2hhnh/as8
oKl3x8v+Fskg/so9Z8QKZ3cydmNhH/FOFwu6kNk7ofEzNokpcVQ5Os6Fk6nt5VJT
HjeB7kAV+JuKO07gyMqZKKPfOm5z4f+tsWB3RkSRnKPMM9J6+U/5Gwl/v7X21+5e
d8sLIAYPaGagxcB1uQXk9Djy+S3kbg==
=dqfX
-----END PGP SIGNATURE-----

--vliygvx23paytwk4--
