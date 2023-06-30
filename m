Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3AD743674
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjF3IFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjF3IFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:05:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D53591
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:05:06 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qF97V-0001Tn-Fn; Fri, 30 Jun 2023 10:04:45 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1178B1E5785;
        Fri, 30 Jun 2023 08:04:42 +0000 (UTC)
Date:   Fri, 30 Jun 2023 10:04:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Srinivas Goud <srinivas.goud@amd.com>, wg@grandegger.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, gcnu.goud@gmail.com, git@amd.com,
        michal.simek@xilinx.com, linux-can@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] can: xilinx_can: Add ECC feature support
Message-ID: <20230630-drop-down-sloped-d00e26bd9085-mkl@pengutronix.de>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
 <20230616-unneeded-denote-eaa4053514d8-mkl@pengutronix.de>
 <8bda5b4b-54ac-0b20-4167-686856347e54@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l4i42uioh2eh4lok"
Content-Disposition: inline
In-Reply-To: <8bda5b4b-54ac-0b20-4167-686856347e54@amd.com>
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


--l4i42uioh2eh4lok
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.06.2023 09:48:16, Michal Simek wrote:
> Hi Marc,
>=20
> On 6/16/23 13:12, Marc Kleine-Budde wrote:
> > On 12.06.2023 17:12:54, Srinivas Goud wrote:
> > > ECC feature added to Tx and Rx FIFO=E2=80=99s for Xilinx CAN Controll=
er.
> > > Part of this feature configuration and counter registers added
> > > in Xilinx CAN Controller for 1bit/2bit ECC errors count and reset.
> > > Please find more details in PG096 v5.1 document.
> >=20
> > The document "PG096 (v5.1) May 16, 2023 CAN v5.1" [1] lists the
> > XCAN_ECC_CFG_OFFSET as reserved, although it has a section "ECC
> > Configuration Register".
> >=20
> > [1] https://docs.xilinx.com/viewer/book-attachment/Bv6XZP9HRonCGi58fl10=
dw/ch1ZLpOt4UKWNub7DXjJ7Q
> >=20
> > The other registers (XCAN_TXTLFIFO_ECC_OFFSET, XCAN_TXOLFIFO_ECC_OFFSET,
> > XCAN_TXOLFIFO_ECC_OFFSET) are also listed as reserved and not even
> > mentioned on the document. Am I missing something?
>=20
> We cross check available public documentation with HW team and there is no
> public documentation for this feature yet. We didn't get any exact day wh=
en
> documentation is going to be released.

It's a pity, but's that the way it's sometimes is.

> Unfortunately it is not the first or even last time when this is happening
> but I still think is good to get this feature done properly till the time
> when documentation catch it up. Please let me know if you have any concern
> about it.

No problem, update the cover letter and mention that the documentation
is not public available, yet. For reference we can keep the reference to
the internal doc (and mention that).

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--l4i42uioh2eh4lok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSejIkACgkQvlAcSiqK
BOgQDAgApM6bEsPxOTvK98GSqYgvFZHiuJ5Ikc7xLbAKqQcvTOcM24fzd4+NeXm7
DKj1h5BUg1TyiOUueBAhsf4jaKS1cRgi/MGLbKpcLn6nanhl5fhO7hnMcfk3cylg
gp/dVEwcIC/zCq8waYVD6zAbkKSzsK6UUO8u7+d0+wlWxK8XF9SfQBXN46bCD26+
4sP2Cm/S2Z9LIi36XZgKLAUoSdo8MnHkwcYYCSgAdZMcvG5d5sPPvMtU40cmmQhZ
fgvnU7lL8SP8/gtrTYG5/IH9BBP1/Af/quEspcu7JgOcelQftPdpun6rQT/P2O5B
kqNatB6pvlHBIkZY0pwWRGnjaNTqDA==
=sUaS
-----END PGP SIGNATURE-----

--l4i42uioh2eh4lok--
