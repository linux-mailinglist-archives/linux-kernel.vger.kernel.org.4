Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D7A6FC62C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbjEIMW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjEIMW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:22:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C86D40C6
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:22:20 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pwMM2-0004Zj-En; Tue, 09 May 2023 14:22:06 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B3EC51C0DDB;
        Tue,  9 May 2023 12:22:04 +0000 (UTC)
Date:   Tue, 9 May 2023 14:22:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     dario.binacchi@amarulasolutions.com, wg@grandegger.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] can: bxcan: Remove unnecessary print function dev_err()
Message-ID: <20230509-sensitive-upper-bd97c6e9abe1-mkl@pengutronix.de>
References: <20230506080725.68401-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uke4yzmz6wgdsbsm"
Content-Disposition: inline
In-Reply-To: <20230506080725.68401-1-jiapeng.chong@linux.alibaba.com>
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


--uke4yzmz6wgdsbsm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.05.2023 16:07:25, Jiapeng Chong wrote:
> The print function dev_err() is redundant because
> platform_get_irq_byname() already prints an error.
>=20
> ./drivers/net/can/bxcan.c:970:2-9: line 970 is redundant because platform=
_get_irq() already prints an error.
> ./drivers/net/can/bxcan.c:964:2-9: line 964 is redundant because platform=
_get_irq() already prints an error.
> ./drivers/net/can/bxcan.c:958:2-9: line 958 is redundant because platform=
_get_irq() already prints an error.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D4878
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied to linux-can-next

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uke4yzmz6wgdsbsm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRaOukACgkQvlAcSiqK
BOgvnAgAtQPyQ1WfKt2BrYRfZ8kxWYSXEQ4y8VEhvujRjZUvbCLLaZPzAPVM5lBN
gBdiEuwbid/nlRlB70y/ihG0m1LLnex9IRlgoaVid/QYocRLQ+u9x+tNHh5Q/igQ
o2WPJTsiV5QNxsY3rVqSWUG9iB/JOhlA/DEa5fNBxrYrgXbsfRf6GczLtx85FEZG
Ixp4onofSdOLZ9eKwDNXP5Kz92lm35XnEKtEpv0cTtG/q4kd170kxowDMhfu8cUU
Omx1iZfQ9tO//jN+7D9/eOe5dkqYTm2OVYdY2zfhbeZ6bcbGaA5Q5x3N/sEqO2wy
1jj1OrFrgRLt7Kl82CupH1/mHevfAw==
=JG2b
-----END PGP SIGNATURE-----

--uke4yzmz6wgdsbsm--
