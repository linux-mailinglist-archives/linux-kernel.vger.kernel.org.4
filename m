Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD127025AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbjEOHH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbjEOHHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:07:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E854E10FA
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:07:23 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pySID-00010b-A3; Mon, 15 May 2023 09:06:49 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 899EF1C40AE;
        Mon, 15 May 2023 07:06:43 +0000 (UTC)
Date:   Mon, 15 May 2023 09:06:43 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Peter Hong <peter_hong@fintek.com.tw>
Cc:     kernel test robot <lkp@intel.com>, wg@grandegger.com,
        michal.swiatkowski@linux.intel.com, Steen.Hegelund@microchip.com,
        mailhol.vincent@wanadoo.fr, oe-kbuild-all@lists.linux.dev,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, frank.jungclaus@esd.eu,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, hpeter+linux_kernel@gmail.com
Subject: Re: [PATCH V7] can: usb: f81604: add Fintek F81604 support
Message-ID: <20230515-uniquely-prodigy-47c74080839b-mkl@pengutronix.de>
References: <20230509073821.25289-1-peter_hong@fintek.com.tw>
 <202305091802.pRFS6n2j-lkp@intel.com>
 <20230509-exert-remindful-0c0e89bf6649-mkl@pengutronix.de>
 <39d076f3-e569-4b3b-84bf-95222cd61084@fintek.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="glikuaxsspn5nww5"
Content-Disposition: inline
In-Reply-To: <39d076f3-e569-4b3b-84bf-95222cd61084@fintek.com.tw>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--glikuaxsspn5nww5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.05.2023 09:11:34, Peter Hong wrote:
> Hi Marc,
>=20
> Marc Kleine-Budde =E6=96=BC 2023/5/9 =E4=B8=8B=E5=8D=88 08:14 =E5=AF=AB=
=E9=81=93:
> > Replaced "%lu% by "%zu" while applying the patch.
>=20
> Should I fix the warning and resend the patch as v8? or you will modify t=
he
> v7 before apply it?

I have applied to patch to my tree and replaced "%lu% by "%zu", no need
to resend.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--glikuaxsspn5nww5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRh2gAACgkQvlAcSiqK
BOgmZwf/XVm9uzh7dxBQFJ8L0dU5BOP7tqJ03EyEFQVC/b9GWJEkg2d32t1/Psdl
BuDj5kbrDkgYR6vHUKkjUpnfzXUNgfwSQkjj+qBlNM6aUztayan72c3x58v2mkOl
/bsLY093SdGAoiJ8TtmO49bVW7GB6+1wlpNmZO7yh+TRm28N722n/VcGuZf6ITi+
FYCIVoPLbO8OHcU7xowpk5+Rc2OEao7/5libji/ahgo6VD6h62u2I4bNvPIeMPiS
c7GYI3bvTi97ZKdfzQnaKhxb4oDI74gfVCU/fuKX/DVDHLxKnsC3Vs4YDZsV82or
f/p7ntxSZ6r5CmLHwxPNUzSRqb8AWQ==
=+qml
-----END PGP SIGNATURE-----

--glikuaxsspn5nww5--
