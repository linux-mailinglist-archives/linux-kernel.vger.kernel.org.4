Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725EE6C585B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjCVVCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCVVB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:01:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586F012596
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:01:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pf5aY-0006RO-BY; Wed, 22 Mar 2023 22:01:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pf5aW-00600B-VU; Wed, 22 Mar 2023 22:01:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pf5aW-0078GS-7J; Wed, 22 Mar 2023 22:01:40 +0100
Date:   Wed, 22 Mar 2023 22:01:40 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4] staging: greybus: remove unnecessary blank line
Message-ID: <20230322210140.xocbx7t4opo2tqmi@pengutronix.de>
References: <20230322113735.31214-1-eng.mennamahmoud.mm@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r7q7putkqdcorqid"
Content-Disposition: inline
In-Reply-To: <20230322113735.31214-1-eng.mennamahmoud.mm@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r7q7putkqdcorqid
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 01:37:34PM +0200, Menna Mahmoud wrote:
> Remove unnecessary blank line before struct as reported
> by checkpatch:
>=20
> " CHECK: Please don't use multiple blank lines "
>=20
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>

Looks good to me now. Thanks for not giving up.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r7q7putkqdcorqid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQbbLMACgkQj4D7WH0S
/k7wQgf+ONVndGTHzhy+YKot/A+pZ9zlWAAJfJnxJbCjhLQnmIepoZGbGLY35dXs
kxnpfkm4+BOxJ8XaMh17TTit9MgoaDNbAajhI3D3ssvjL3ty5NK/aU5FbtYK7cB5
H9rufT4+ew9h59P+OkndlFdArjEOKuNx8YY2KUkdc2kOsKAJXwOnM44MKwRmM40X
hnNRfcF5UeHA7inux3952me5wzdiym2JUq6x9xowrKU0TOdUklDZhUwxlO//NeBK
T57BaRK7NBPl5WG2NA6rLVeRHnzADSR7W2AXYJTV8ZFSjvelvwjaJd7Bf4UTZk9N
kPnHTdnkBKbzNXqw5yQXHAWe5Xcbfg==
=sOsU
-----END PGP SIGNATURE-----

--r7q7putkqdcorqid--
