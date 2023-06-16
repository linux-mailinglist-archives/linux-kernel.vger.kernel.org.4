Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CC3732F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345021AbjFPLMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344767AbjFPLMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:12:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0222297D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:12:24 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qA7NE-0001v0-5f; Fri, 16 Jun 2023 13:12:12 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BD13B1DAC62;
        Fri, 16 Jun 2023 11:12:10 +0000 (UTC)
Date:   Fri, 16 Jun 2023 13:12:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, gcnu.goud@gmail.com,
        git@amd.com, michal.simek@xilinx.com, linux-can@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] can: xilinx_can: Add ECC feature support
Message-ID: <20230616-unneeded-denote-eaa4053514d8-mkl@pengutronix.de>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e3lc5j2mdmuoewkc"
Content-Disposition: inline
In-Reply-To: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
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


--e3lc5j2mdmuoewkc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.06.2023 17:12:54, Srinivas Goud wrote:
> ECC feature added to Tx and Rx FIFO=E2=80=99s for Xilinx CAN Controller.
> Part of this feature configuration and counter registers added=20
> in Xilinx CAN Controller for 1bit/2bit ECC errors count and reset.
> Please find more details in PG096 v5.1 document.

The document "PG096 (v5.1) May 16, 2023 CAN v5.1" [1] lists the
XCAN_ECC_CFG_OFFSET as reserved, although it has a section "ECC
Configuration Register".

[1] https://docs.xilinx.com/viewer/book-attachment/Bv6XZP9HRonCGi58fl10dw/c=
h1ZLpOt4UKWNub7DXjJ7Q

The other registers (XCAN_TXTLFIFO_ECC_OFFSET, XCAN_TXOLFIFO_ECC_OFFSET,
XCAN_TXOLFIFO_ECC_OFFSET) are also listed as reserved and not even
mentioned on the document. Am I missing something?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--e3lc5j2mdmuoewkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSMQ4cACgkQvlAcSiqK
BOif0gf9ENiFw1zub+JvpO4Z15pvxtf+Ge2LoyL6btmGQClJQngT0seWbZwx+qw/
3HsN9fpCmDNQuRiujWa+1otoTC8VnFsbTewdIl3LNGe676uECIytmeptA2SFQN6J
DGSaR4rMdK7yzVlj9Ku0vQxIs8zCEdEFRXsJ4mkgfW2enDNy6CZOd4cYMd8PfaI7
0mXfcuUi4AYXqPWRZMR+ufem1daUvBBHPH77I6JzAtZKF3cc4SgFhrn1e6ywEduP
GCwTUhP4cNVHAGxTVNlXPV+uXe5wwV9WTjtTTPuMhXiAyIz1sDhm2nPaXXnKQoQi
jDvSFgZQlq+i2YRY8lOK4/f0V/FLUg==
=9ddr
-----END PGP SIGNATURE-----

--e3lc5j2mdmuoewkc--
