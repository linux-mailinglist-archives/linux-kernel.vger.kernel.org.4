Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B0B6FDAD3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbjEJJfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbjEJJfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:35:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C5D3A9D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:35:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwgDi-00082D-D1; Wed, 10 May 2023 11:34:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwgDf-002RI0-RR; Wed, 10 May 2023 11:34:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwgDf-0032a5-9B; Wed, 10 May 2023 11:34:47 +0200
Date:   Wed, 10 May 2023 11:34:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marcin Wierzbicki <mawierzb@cisco.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Roger Quadros <rogerq@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com, danielwa@cisco.com, olicht@cisco.com,
        Bartosz Wawrzyniak <bwawrzyn@cisco.com>
Subject: Re: [PATCH v2] phy: cadence: Sierra: Add single link SGMII register
 configuration
Message-ID: <20230510093447.6hwro4ukv6i2dzve@pengutronix.de>
References: <20230508160142.2489365-1-mawierzb@cisco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5lq3blnkoglk22z"
Content-Disposition: inline
In-Reply-To: <20230508160142.2489365-1-mawierzb@cisco.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
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


--r5lq3blnkoglk22z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, May 08, 2023 at 04:01:40PM +0000, Marcin Wierzbicki wrote:
> Add single link SGMII register configuration for no SSC for
> cdns,sierra-phy-t0 compatibility string.
> The configuration is based on Sierra Programmer's Guide and
> validated in Cisco CrayAR SoC.
>=20
> Co-developed-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
> Signed-off-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
> Signed-off-by: Marcin Wierzbicki <mawierzb@cisco.com>
> Change-Id: Id4c093a1bbf409f3176736b5326854a1396391c1

The Change-Id footers are not supposed to appear in the kernel's
history, so it's better to leave them out when submitting a patch.

(I didn't look at the remaining patch, so me not criticizing more
doesn't implicitly mean the rest is fine. (But of course it also doesn't
mean it is not fine.))

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r5lq3blnkoglk22z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRbZTYACgkQj4D7WH0S
/k5e9wf7BD/40i1IpW6aw9iKJlA3bkyq1AcSzzOC14YRCDtape7DV04T8NvZ3DG5
/V0ciqepiiym+BrHWScWSxVaDEBrf3828UT313ZnTXPtCN27J8caTjakmbjzhlCh
pp32eUZJDpmDWb62jfCotwNzSEa7GJgMQb7Trd7tNf65CMpSJu7chvFgf6hGtI52
vWBM5fOlQlUf3TvC3HNnFf078/J6oAvhX2z0ZsiXap5uTE/ECMl0Fo3GFHRTxpZO
/6ri2k1BSAjEC8fDNV2XF8Xvz39miNDjIabuV6ULzsdITgP/TJLWOJVnogXDnTk2
N/+txaYC/AoTFV8/7j0lYKOsxRBiDA==
=w/AR
-----END PGP SIGNATURE-----

--r5lq3blnkoglk22z--
