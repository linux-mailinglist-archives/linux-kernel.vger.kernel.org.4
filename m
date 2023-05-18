Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E17084BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjERPPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjERPPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:15:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A064ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:15:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzfLK-0007MS-P5; Thu, 18 May 2023 17:15:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzfLK-00172X-2o; Thu, 18 May 2023 17:15:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzfLJ-005gn6-BF; Thu, 18 May 2023 17:15:01 +0200
Date:   Thu, 18 May 2023 17:15:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v18 2/2] MAINTAINERS: add pwm to PolarFire SoC entry
Message-ID: <20230518151501.axcvsv6ll4tfab6e@pengutronix.de>
References: <20230518-reactive-nursing-23b7fe093048@wendy>
 <20230518-headrest-puppet-d6cf2e11e340@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tcwogrdt3dklavo2"
Content-Disposition: inline
In-Reply-To: <20230518-headrest-puppet-d6cf2e11e340@wendy>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tcwogrdt3dklavo2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Thu, May 18, 2023 at 01:29:21PM +0100, Conor Dooley wrote:
> Add the newly introduced pwm driver to the existing PolarFire SoC entry.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tcwogrdt3dklavo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRmQPQACgkQj4D7WH0S
/k5AlAgAjlaA+EtbFPPHn/tWfErr2QMPiIRDBQXamI2qTWzBt3YeJC2X2h+czojY
QEJhdmbo+HL5E5/ybhvNUC9Gj9X6i0/8Qj5/UxFVugAoOTv5B+oQLMoytnsYBilF
YfLm+4y3/UyyoiHpJd/MJRudBePC3i4UTT7FXzc4Qoy+NArdbFazOpWyUJHOOtFi
C4utb2rWPHGXiqj/3YCSJqDCAPpiZu+W3fZ92NnpIJ+o8HkXtiL9+madBsH/fknY
TIZrict64V7S1zyT4nAKJLYLuS5LuGZXC9M5XfIzbwn6E74u3MDV6uNYAMjav2+V
rDPwy/8fIJH0Sk1cfmoXh6cpoNJ81Q==
=4UxA
-----END PGP SIGNATURE-----

--tcwogrdt3dklavo2--
