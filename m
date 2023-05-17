Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7127070C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjEQS3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjEQS3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:29:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A55213C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:29:39 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzLtz-0000Pe-TX; Wed, 17 May 2023 20:29:31 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CB9A51C7510;
        Wed, 17 May 2023 18:29:29 +0000 (UTC)
Date:   Wed, 17 May 2023 20:29:29 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 5/5] ARM: dts: stm32: add CAN support on stm32f746
Message-ID: <20230517-doing-humorous-ee72fbcf740c-mkl@pengutronix.de>
References: <20230427204540.3126234-1-dario.binacchi@amarulasolutions.com>
 <20230427204540.3126234-6-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dfmegg2limou4kpi"
Content-Disposition: inline
In-Reply-To: <20230427204540.3126234-6-dario.binacchi@amarulasolutions.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
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


--dfmegg2limou4kpi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.04.2023 22:45:40, Dario Binacchi wrote:
> Add support for bxcan (Basic eXtended CAN controller) to STM32F746. The
> chip contains three CAN peripherals, CAN1 and CAN2 in dual peripheral
> configuration and CAN3 in single peripheral configuration:
> - Dual CAN peripheral configuration:
>   * CAN1: Primary bxCAN for managing the communication between a secondary
>     bxCAN and the 512-byte SRAM memory.
>   * CAN2: Secondary bxCAN with no direct access to the SRAM memory.
>   This means that the two bxCAN cells share the 512-byte SRAM memory and
>   CAN2 can't be used without enabling CAN1.
> - Single CAN peripheral configuration:
>   * CAN3: Primary bxCAN with dedicated Memory Access Controller unit and
>     512-byte SRAM memory.
>=20
>  -------------------------------------------------------------------------
> | features | CAN1              | CAN2               | CAN 3              =
 |
>  -------------------------------------------------------------------------
> | SRAM     | 512-byte shared between CAN1 & CAN2    | 512-byte           =
 |
>  -------------------------------------------------------------------------
> | Filters  | 26 filters shared between CAN1 & CAN2  | 14 filters         =
 |
>  -------------------------------------------------------------------------
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

I initially upstreamed this patch as 0920ccdf41e3 ("ARM: dts: stm32: add
CAN support on stm32f746"), but it depends on "dt-bindings: mfd:
stm32f7: add binding definition for CAN3" [1], which is missing in
net/main, resulting in parsing errors in the "stm32f746.dtsi".

This patch is reverted by [2], so please upstream it via the platform
maintainers.

regards,
Marc

[1] https://lore.kernel.org/all/20230423172528.1398158-2-dario.binacchi@ama=
rulasolutions.com
[2] https://lore.kernel.org/all/20230517181950.1106697-1-mkl@pengutronix.de

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dfmegg2limou4kpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRlHQYACgkQvlAcSiqK
BOjyEQf/aWrP70IM+PLkOxyyzdSFXZNts5KYn9gvAzbtWKcHJv25ppouGeg4aTxz
gye9TQwUmW8hfzy6geTXaLuQmefpCUvBg+yESzHFHL6jLXM2gwzkhenwdTDeSow5
JoEAOmQR9gl5W+vK8o9MtMmOsoQ574crp2UV3Xn4tBP9xDBqVUxXla4RQpTsx6Db
OJMnWAYl6mheQsIkPwfxuafXkVvu2yH1ah89dPko0oQeCZFMOpnLorKUG9SAzOEV
LUKzryIlvWpklji2KpLf1RTqrUUTEcMmPaBKEM99QhR/51yr3pLPgKHTMJwpbvJz
abfH52OdzM13H/oBWKxLuHHzseSgeg==
=O32s
-----END PGP SIGNATURE-----

--dfmegg2limou4kpi--
