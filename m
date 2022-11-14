Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148DF627906
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiKNJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbiKNJbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:31:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36433A1A9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:31:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ouVny-0006Sz-7y; Mon, 14 Nov 2022 10:31:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ouVnv-004D8f-IL; Mon, 14 Nov 2022 10:31:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ouVnv-00GVUS-P7; Mon, 14 Nov 2022 10:30:59 +0100
Date:   Mon, 14 Nov 2022 10:30:59 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        weiyongjun1@huawei.com, yusongping@huawei.com
Subject: Re: [PATCH v2] mtd: lpddr2_nvm: Fix possible null-ptr-deref
Message-ID: <20221114093059.bbmefffkkcmygvye@pengutronix.de>
References: <20221114090240.244172-1-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m7dizcf5p7ztwwln"
Content-Disposition: inline
In-Reply-To: <20221114090240.244172-1-tanghui20@huawei.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m7dizcf5p7ztwwln
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2022 at 05:02:40PM +0800, Hui Tang wrote:
> It will cause null-ptr-deref when resource_size(add_range) invoked,
> if platform_get_resource() returns NULL.
>=20
> Fixes: 96ba9dd65788 ("mtd: lpddr: add driver for LPDDR2-NVM PCM memories")
> Signed-off-by: Hui Tang <tanghui20@huawei.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m7dizcf5p7ztwwln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNyCtAACgkQwfwUeK3K
7AnL0Qf9GGiXuVY0Pw3AI7AtmvG6E34XsI28qAbN4u+PGF57LIrJKUoFBP1tneJZ
uKFAlm1j1d6BBlXMXknz1K/kBw7ojoYA2N8Tv9A3ja6jQ8RmI8AkgM+NtssvG6K8
l1mJdpjhP/xWiVBSbH6lb9VZDDvVlH7cglE6HHuLIOX4TpXBUSMgEobSwJgHBNpE
EUh23sbP22orwrIW9LWmptVT3JJ/sOsR2qyaGS1skqOaU+jpshNNWw4fVuXfORte
KtySmHYpCDB3JxjQaNYHdhCaU0Wyjf/eR/HlAWfEimj560BP2gDrsDVIyh0cwGS1
MZ8AOvLzDMoAQ05Mf7Frp4JWJ9svKQ==
=MAEr
-----END PGP SIGNATURE-----

--m7dizcf5p7ztwwln--
