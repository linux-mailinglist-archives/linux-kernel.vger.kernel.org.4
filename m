Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08346706AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjEQORV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjEQORQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:17:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184A33C3B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:17:11 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzHxX-0005eR-EI; Wed, 17 May 2023 16:16:55 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4E94F1C72FC;
        Wed, 17 May 2023 14:16:53 +0000 (UTC)
Date:   Wed, 17 May 2023 16:16:52 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-can@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/4] dt-bindings: mfd: stm32f7: add binding definition
 for CAN3
Message-ID: <20230517-corset-pelvis-5b0c41f519c9-mkl@pengutronix.de>
References: <20230423172528.1398158-1-dario.binacchi@amarulasolutions.com>
 <20230423172528.1398158-2-dario.binacchi@amarulasolutions.com>
 <20230424090229.GB8035@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q5imvd4u3okupx2w"
Content-Disposition: inline
In-Reply-To: <20230424090229.GB8035@google.com>
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


--q5imvd4u3okupx2w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Lee Jones,

On 24.04.2023 10:02:29, Lee Jones wrote:
> On Sun, 23 Apr 2023, Dario Binacchi wrote:
>=20
> > Add binding definition for CAN3 peripheral.
> >=20
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >=20
> >  include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> Applied, thanks

I upstreamed the v2 of this series
(https://lore.kernel.org/all/20230427204540.3126234-1-dario.binacchi@amarul=
asolutions.com/)
that doesn't contain this change to net/main without noticing that the
DT changes in that series depend on it.

This broke the DT compilation of the stm32f746.dtsi in the net/main
tree. I don't see the stm32f7-rcc.h changes in linus/master so I'm
afraid this will break mainline too :/

What are the possible solutions? I see:
1) revert the stm32f746.dtsi changes via net/main
2) upstream the stm32f7-rcc.h changes via net/main, too
3) upstream the stm32f7-rcc.h changes via you tree, so that it hits
   mainline in the v6.4 release cycle.

I'm in favor of solution number 1. Thoughts?

Sorry for the mess,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--q5imvd4u3okupx2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRk4dAACgkQvlAcSiqK
BOikxAf2M/Ykg/MJoF/7udP97hi5VrUGxB6DSWdGY2T6kl8FVmJbHgx+vib1h2X2
/sj75GpkMhGNwdyysYP0KSFtzVnvI5bt/YHDwT/JnbljFw6xETEOllILKQbw5tat
29kjQUDmlVwzC8+L3itlu//IEu0NpQzNDPc+H5sxxlqVOIm8//kp8EUAjlWnD4LN
1fVKXi8UgK9paGixIiKbWYdvdLoYR5PcJFYFvWUEZEl0A7VtL0lXvZqdrnCo8ol5
Iza8FIAN6dBUlxAIzw7u96gg7r4jo9Q+IjtVXbr4DrAQyA4eJ638VJKOU5fiHVzE
qdyGlnD8b0opJO3QJPclwaQl3g/Q
=epl8
-----END PGP SIGNATURE-----

--q5imvd4u3okupx2w--
