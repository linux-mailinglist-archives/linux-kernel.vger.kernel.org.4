Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB93706850
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjEQMi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjEQMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:38:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC171FC2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:38:53 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzGQQ-0006A2-A0; Wed, 17 May 2023 14:38:38 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1246C1C716F;
        Wed, 17 May 2023 12:38:37 +0000 (UTC)
Date:   Wed, 17 May 2023 14:38:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] Fine-Tune Flow Control and Speed
 Configurations in Microchip KSZ8xxx DSA Driver
Message-ID: <20230517-flyer-quiver-79e2f624a460-mkl@pengutronix.de>
References: <20230517121034.3801640-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t4ca6c4672tg6ybh"
Content-Disposition: inline
In-Reply-To: <20230517121034.3801640-1-o.rempel@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t4ca6c4672tg6ybh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.05.2023 14:10:32, Oleksij Rempel wrote:
> changes v2:
> - split the patch to upstrean and downstram part
                       upstream     downstream

In patches please fix spelling, too:
s/upstram/upstream/
s/downstram/downstream/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--t4ca6c4672tg6ybh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRkyskACgkQvlAcSiqK
BOj1eAf/bdH8oLih24Q4glFjP7ngLrOfL8iIK2nS2yTsCbqlr6x7wSuy3PxUnPhi
K+U53oJM152NYO/YTe0yQ7gYmeEibo0yHCauEo6ZoDgnQ8hAtTuyOgVNTeKFeEk9
cT4f14m6+KhdcttfWvmezO0ZrgeCaO3RrnHlLPOj3sCwk9UqQY0+1KCRKR5xfS8E
2hOGsTDqMVGG+AIfInh6ACOfTe3VxzGE3gDcBR8s/4d6ZXthiNcCC9zbdyh0uKgQ
/geD3UpybQRRtNhroMcaZlRSoKto8gyklT1oAdKy3/l2LCELED8XdpOQSheFBlXn
/l/J5fqqeGJnyxdWtdgBw5gMrfBJRg==
=1F0K
-----END PGP SIGNATURE-----

--t4ca6c4672tg6ybh--
