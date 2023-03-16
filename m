Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1776BD455
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjCPPtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjCPPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:49:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C963C27
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:49:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pcpqX-0008TT-5q; Thu, 16 Mar 2023 16:48:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pcpqV-004a3N-TO; Thu, 16 Mar 2023 16:48:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pcpqU-005PJw-QC; Thu, 16 Mar 2023 16:48:50 +0100
Date:   Thu, 16 Mar 2023 16:48:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/30] clk: scpi: Convert to platform remove callback
 returning void
Message-ID: <20230316154850.wxwiztump5de3xt4@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
 <20230312161512.2715500-16-u.kleine-koenig@pengutronix.de>
 <20230316150144.2aap5otmgblj24ty@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5mrnsz43afupa3b4"
Content-Disposition: inline
In-Reply-To: <20230316150144.2aap5otmgblj24ty@bogus>
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


--5mrnsz43afupa3b4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[put the clk maintainers in To:]

On Thu, Mar 16, 2023 at 03:01:44PM +0000, Sudeep Holla wrote:
> On Sun, Mar 12, 2023 at 05:14:57PM +0100, Uwe Kleine-K=F6nig wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is (mostly) ignored
> > and this typically results in resource leaks. To improve here there is a
> > quest to make the remove callback return void. In the first step of this
> > quest all drivers are converted to .remove_new() which already returns
> > void.
> >=20
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> >
>=20
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>=20
> Let me know if you want me to pick up instead.

Honestly I don't know. I expected that the series is applied completely
via the clk maintainers, but the samsung patch was already taken
individually.

Michael and Stephen: It would probably be helpful if you shared your
thoughs about this. For me both options are fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5mrnsz43afupa3b4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQTOl8ACgkQwfwUeK3K
7AkNqQf/UA7zXQz4+AFWQFgpi30qcC1O218m/8U75zgzwkIyDgraoGDl+NQJDp0l
o1tHfdO6/7ghxY+Fm0853gWP8+dBoui1wkjaqZA6MyMmS5PPPtK0sGiyrubm3ZPs
5ReuoNPdPr4IdHNhihYxp872N5IBCmjijbyw+8o8Zbgk7ADLIjP+CIAb4YWuDLy7
6CZMDBTImHiAZW0/fB2PQK8iGVosNObpqlQWR67lze7LtVJ+ioPKyQOLgo0yLxym
AldCyyUdMPmoGxLP4gOfZqpgBrdorfE+uUfU1OiEVPK4xZRvyDo+DSxSxOdefEEb
bttxdh9rF8T6mU5OFnv7tWYbwp/11A==
=KvDT
-----END PGP SIGNATURE-----

--5mrnsz43afupa3b4--
