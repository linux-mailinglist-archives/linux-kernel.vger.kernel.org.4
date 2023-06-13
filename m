Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419A772DB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbjFMHxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbjFMHxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:53:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B6F13E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:53:05 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1q8ypg-0004eD-8Q; Tue, 13 Jun 2023 09:52:52 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7EBB71D8693;
        Tue, 13 Jun 2023 07:52:51 +0000 (UTC)
Date:   Tue, 13 Jun 2023 09:52:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, gcnu.goud@gmail.com,
        git@amd.com, michal.simek@xilinx.com, linux-can@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: can: xilinx_can: Add ECC =?utf-8?Q?p?=
 =?utf-8?B?cm9wZXJ0eSDigJh4bG54LGhhcy1lY2PigJk=?=
Message-ID: <20230613-outskirts-dove-e3e39b096647-mkl@pengutronix.de>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
 <1686570177-2836108-2-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gfouff2zqh7p75fw"
Content-Disposition: inline
In-Reply-To: <1686570177-2836108-2-git-send-email-srinivas.goud@amd.com>
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


--gfouff2zqh7p75fw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.06.2023 17:12:55, Srinivas Goud wrote:
> ECC feature added to Tx and Rx FIFO=E2=80=99s for Xilinx CAN Controller.
> Part of this feature configuration and counter registers
> added in IP for 1bit/2bit ECC errors.
> Please find more details in PG096 v5.1 document.
>=20
> xlnx,has-ecc is optional property and added to Xilinx CAN
> Controller node if ECC block enabled in the HW.
>=20
> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>

Is there a way to introspect the IP core to check if this feature is
compiled in?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gfouff2zqh7p75fw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSIIFAACgkQvlAcSiqK
BOjKDwgAlNy9S49d1vTFVaE5fAeBhMbJplQd8FKSbkYGF6MXkNDlr5ssTknhrupO
hPTwZGr+BVRZdKgreESP807jjAQd4A0jQPyMW7Lxg0furEASZQgsBszMo8JoHWyM
eiGroJ6qbesB+Fy+6zZz0waZ5jXALg5rWET4Bp/D26IkkgMv7CmS4sFNXiw9LwHA
Km8rSmSkLJicymQdz/itR2wu+TyKxCq9fBgM3WDhqPUFvyWUR56Gl+xsvVs9jmuw
8zA5HUtClC+2rzItZlkbdmjc9pzqgnEMhx4mqz1W2n+hp4whSVr/GYTXs1XGMWvF
FiFueSYvLZCdS9Xii7D8MkecA17uwQ==
=flTR
-----END PGP SIGNATURE-----

--gfouff2zqh7p75fw--
