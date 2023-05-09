Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959826FC69E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjEIMjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjEIMjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:39:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559AD4693
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:39:16 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pwMcO-0008Rr-Nx; Tue, 09 May 2023 14:39:00 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 44B371C0EEE;
        Tue,  9 May 2023 12:38:56 +0000 (UTC)
Date:   Tue, 9 May 2023 14:38:55 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-can@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/5] can: bxcan: add support for single peripheral
 configuration
Message-ID: <20230509-silt-gullible-a010971857fc-mkl@pengutronix.de>
References: <20230427204540.3126234-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eomgn2hsx2rjfnda"
Content-Disposition: inline
In-Reply-To: <20230427204540.3126234-1-dario.binacchi@amarulasolutions.com>
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


--eomgn2hsx2rjfnda
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.04.2023 22:45:35, Dario Binacchi wrote:
>=20
> The series adds support for managing bxCAN controllers in single peripher=
al
> configuration.
> Unlike stm32f4 SOCs, where bxCAN controllers are only in dual peripheral
> configuration, stm32f7 SOCs contain three CAN peripherals, CAN1 and CAN2
> in dual peripheral configuration and CAN3 in single peripheral
> configuration:
> - Dual CAN peripheral configuration:
>  * CAN1: Primary bxCAN for managing the communication between a secondary
>    bxCAN and the 512-byte SRAM memory.
>  * CAN2: Secondary bxCAN with no direct access to the SRAM memory.
>    This means that the two bxCAN cells share the 512-byte SRAM memory and
>    CAN2 can't be used without enabling CAN1.
> - Single CAN peripheral configuration:
>  * CAN3: Primary bxCAN with dedicated Memory Access Controller unit and
>    512-byte SRAM memory.
>=20
> The driver has been tested on the stm32f769i-discovery board with a
> kernel version 5.19.0-rc2 in loopback + silent mode:
>=20
> ip link set can[0-2] type can bitrate 125000 loopback on listen-only on
> ip link set up can[0-2]
> candump can[0-2] -L &
> cansend can[0-2] 300#AC.AB.AD.AE.75.49.AD.D1

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--eomgn2hsx2rjfnda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRaPt0ACgkQvlAcSiqK
BOhyFwf+PqGLrg+vLzJWWVhXSlxbs7zJUuh4QzPlJkTwI76JjJp5X2Vy/HdpdG7I
UYyat8KbWFgGyoAmZnSE/wPG00PmUljaDInUuIpn07ESHRle8PsR9ZlUhtfhCtgS
CoDyuRfQwU7LTkLZ1ZAXqTmYzyCl+LHlk6PAOWZV34tE+QvjJTDxf3IZRN5KrD+O
xy+AxbVyFd9UUVxygtEIk2DYd2iZZzw/2w3Y8EQa5dqNzNcTa34z/3n/v3nN0ydi
XOr5ujvuY2ojwirz20QWxVZLCUfzozk73LSqAXbs4EcKYtAZ4zWOtTCFdjJWkA+x
HcXh9SpoQJIZ/TTCUj6J74pQavg5+A==
=7c+/
-----END PGP SIGNATURE-----

--eomgn2hsx2rjfnda--
