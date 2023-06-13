Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC6072DB8A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbjFMHwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240133AbjFMHwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:52:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6273910CE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:52:09 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1q8yok-0004Z3-T8; Tue, 13 Jun 2023 09:51:54 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 828D81D8690;
        Tue, 13 Jun 2023 07:51:52 +0000 (UTC)
Date:   Tue, 13 Jun 2023 09:51:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, gcnu.goud@gmail.com,
        git@amd.com, michal.simek@xilinx.com, linux-can@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] can: xilinx_can: Add debugfs support for ECC
Message-ID: <20230613-unless-childish-c417cfef6988-mkl@pengutronix.de>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
 <1686570177-2836108-4-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eder6kmsgdh7yawb"
Content-Disposition: inline
In-Reply-To: <1686570177-2836108-4-git-send-email-srinivas.goud@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eder6kmsgdh7yawb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.06.2023 17:12:57, Srinivas Goud wrote:
> Create debugfs entry for reading all the FIFO ECC errors.

Please attach the stats to the ethtool stats interface:
| https://elixir.bootlin.com/linux/v6.3/source/include/linux/ethtool.h#L826

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--eder6kmsgdh7yawb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSIIBUACgkQvlAcSiqK
BOiTKggAi7834euAG6+WGilu7aEggvAACdPEx7RZa+dXex5R6b20pIikGtsi3dZZ
R3dy6YPeTu084R/FV9aBBExI4aJmpChHlAqtYfMnn+7heDVOZhtt1ci/jgwCsTiE
7lqfU4bD7Z7Jwmou2tYdQyxyPwtY+Z3jf3JZpTTWX0cffY3QdOeQueIsE/37MuhG
kKXfVTjvD6031L77U2+owQ129Q/etdbq5/4eqkNzWwMGZRDDARCxYeuooM77HjfA
ff0IeDQ4zhe0MpDFGtT/GBjzFzHR/5O22URHSenGjVWyUFmtov4/ktBSevdP+WCZ
ldjUr78dBdJGb6nox+NI36nri9Wbww==
=wMnb
-----END PGP SIGNATURE-----

--eder6kmsgdh7yawb--
