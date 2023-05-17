Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271A97070B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjEQSWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjEQSWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:22:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F53AAD15
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:22:41 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzLmh-0007yW-S9; Wed, 17 May 2023 20:21:59 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 93EA41C74F0;
        Wed, 17 May 2023 18:21:57 +0000 (UTC)
Date:   Wed, 17 May 2023 20:21:57 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
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
Message-ID: <20230517-prescribe-duller-5457a674a3af-mkl@pengutronix.de>
References: <20230423172528.1398158-1-dario.binacchi@amarulasolutions.com>
 <20230423172528.1398158-2-dario.binacchi@amarulasolutions.com>
 <20230424090229.GB8035@google.com>
 <20230517-corset-pelvis-5b0c41f519c9-mkl@pengutronix.de>
 <28889e6c-0040-5adb-25e1-f8284931947a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qnusropkbmgywkyd"
Content-Disposition: inline
In-Reply-To: <28889e6c-0040-5adb-25e1-f8284931947a@linaro.org>
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


--qnusropkbmgywkyd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.05.2023 17:23:13, Krzysztof Kozlowski wrote:
> On 17/05/2023 16:16, Marc Kleine-Budde wrote:
> > Hey Lee Jones,
> >=20
> > On 24.04.2023 10:02:29, Lee Jones wrote:
> >> On Sun, 23 Apr 2023, Dario Binacchi wrote:
> >>
> >>> Add binding definition for CAN3 peripheral.
> >>>
> >>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >>> ---
> >>>
> >>>  include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>
> >> Applied, thanks
> >=20
> > I upstreamed the v2 of this series
> > (https://lore.kernel.org/all/20230427204540.3126234-1-dario.binacchi@am=
arulasolutions.com/)
> > that doesn't contain this change to net/main without noticing that the
> > DT changes in that series depend on it.
> >=20
> > This broke the DT compilation of the stm32f746.dtsi in the net/main
> > tree. I don't see the stm32f7-rcc.h changes in linus/master so I'm
> > afraid this will break mainline too :/
> >=20
> > What are the possible solutions? I see:
> > 1) revert the stm32f746.dtsi changes via net/main
> > 2) upstream the stm32f7-rcc.h changes via net/main, too
> > 3) upstream the stm32f7-rcc.h changes via you tree, so that it hits
> >    mainline in the v6.4 release cycle.
> >=20
> > I'm in favor of solution number 1. Thoughts?
>=20
> DTS should never go with driver changes or with driver trees, not only
> because it hides ABI breaks but also for above reasons. The best if you
> just drop or revert DTS commits, so they can go via platform maintainer.

Reverted: https://lore.kernel.org/20230517181950.1106697-1-mkl@pengutronix.=
de

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qnusropkbmgywkyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRlG0IACgkQvlAcSiqK
BOgvtggAs1aeq0u5rmdza+38M15JChcsOtvTbSMIoePcRPC8ygd/ZihgaHb7qs2y
i1+Nf64kuyjBt787Gf3/YsL72Rs5SOSYXXMJZNX3tNmNQSAgatZqrNSR308SVars
DfBTlhgmMsDj5fnDF7NL9XZHOSG20oRNWJ9dwZ5FIOwMuxP6rXtR7wAA8A9d51Y1
ZTDzYvBp5qkxqqfeD+Ap4s6kQ6G9r8Csj2h/C3nm1aNo82T8yrgtq6bAslk3rpTE
+NVp9T5olP/H7BayFdy/BlRS6lu+o7g58HQw6KCEKrFGYk4OkbAze/Vo1pq/+o0p
chq9aL6I5s9k2EwKMJvmg1Y2Cl+byg==
=8ejs
-----END PGP SIGNATURE-----

--qnusropkbmgywkyd--
