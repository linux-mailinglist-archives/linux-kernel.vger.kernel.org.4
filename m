Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD1C65B07B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjABLXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjABLW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:22:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E485F61
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:22:55 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pCItp-0002cs-TJ; Mon, 02 Jan 2023 12:22:37 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7091:c01f:f4cb:ae36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8137314C969;
        Mon,  2 Jan 2023 11:22:32 +0000 (UTC)
Date:   Mon, 2 Jan 2023 12:22:23 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: fix single *.ko build
Message-ID: <20230102112223.krzgmpqn4vt2jymb@pengutronix.de>
References: <20230101060709.208512-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tjot2qx5fabcwhlr"
Content-Disposition: inline
In-Reply-To: <20230101060709.208512-1-masahiroy@kernel.org>
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


--tjot2qx5fabcwhlr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.01.2023 15:07:09, Masahiro Yamada wrote:
> The single *.ko build is broken since commit f65a486821cf ("kbuild:
> change module.order to list *.o instead of *.ko").
>=20
> Fixes: f65a486821cf ("kbuild: change module.order to list *.o instead of =
*.ko")
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--tjot2qx5fabcwhlr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOyvm0ACgkQrX5LkNig
012fxgf/XmORDICRnvwSatENccvD/tAT3cHdeeJja3WQ9QAWK2800LrAbYvaevr1
7g2lnzENm47jK3B//b8kYhg2jECjfz9a3TIApFa6uYrmOhp5Wf6kEZoc27jrFhjs
4b6vjFdoAD0bfn5oGnlau8NqWPblRG4jWtoyBRaY7b/j6/za19gCe99nyhXOprmr
zse6onUjx8EhAXFyrVoUpIOBm87tawd9zvZnjUAOiofFM7xGzI60g0Qj0kicjg0/
nnH0oEN5ueCGuPLaJeWvUsS6Aiy4WWj7Yb+m/pJeKqoX8ExWNDFkbAJ3QIYt7ktm
tB7IC2zVw0/sziaSyBLbumvaw5xWUg==
=HwDw
-----END PGP SIGNATURE-----

--tjot2qx5fabcwhlr--
