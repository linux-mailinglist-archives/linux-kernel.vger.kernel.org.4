Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFD97040BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245698AbjEOWI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242789AbjEOWI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:08:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CCB55AD;
        Mon, 15 May 2023 15:08:15 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6CEC666031CE;
        Mon, 15 May 2023 23:07:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684188423;
        bh=v8vpwcoUaIp3G4K2PrmGZvzyz7zZrz4LAh0DP6wGPmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jg7jXjjroP9kArM2b3nnQvgDQIbUSTuOeXM+2rCOKwidOshojk1wI0G7U1ROJrLtB
         A0TM5gOj5RXIJ7OoP3ENjGbbvvNvwsVHs8ccTIL62R5452v6jgpZlPEOJFmNt2qyyb
         /JPGZSA72d0s8O/bAaDal73w9YmTWV9mVV5i407hFZFUunrDyp+MoCktwODwXDkmov
         Xv9rRoQWE2AYVdw4a28I62G5RoDtvfvZQeDWA6Auv6m9P24IXvixSfCD+EdFQyerso
         69f/baw94jJQmRptQx8cDNqqycvnGuW0BfgkK0ho9LUnRLPkc5Ko6x+zZnuAmODhDI
         ySZVGGXh35/Yw==
Received: by mercury (Postfix, from userid 1000)
        id 5B1A2106138C; Tue, 16 May 2023 00:07:01 +0200 (CEST)
Date:   Tue, 16 May 2023 00:07:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: sbs: Fix INHIBITED bit for Status reg
Message-ID: <20230515220701.ot2u747n7kx2yrfp@mercury.elektranox.org>
References: <20230424182559.92271-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ueouxaucu6i7mkq4"
Content-Disposition: inline
In-Reply-To: <20230424182559.92271-1-dnojiri@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ueouxaucu6i7mkq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 24, 2023 at 11:25:58AM -0700, Daisuke Nojiri wrote:
> CHARGE_INHIBITED bit position of the ChargerStatus register is actually
> 0 not 1. This patch corrects it.
>=20
> Change-Id: I08630b264eddd09b94c8f6d299724c39218e958a
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> ---

Thanks, queued to power-supply's fixes branch with Change-Id line replaced =
by

Fixes: feb583e37f8a8 ("power: supply: add sbs-charger driver")

-- Sebastian

>  drivers/power/supply/sbs-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sb=
s-charger.c
> index 75ebcbf0a788..a14e89ac0369 100644
> --- a/drivers/power/supply/sbs-charger.c
> +++ b/drivers/power/supply/sbs-charger.c
> @@ -24,7 +24,7 @@
>  #define SBS_CHARGER_REG_STATUS			0x13
>  #define SBS_CHARGER_REG_ALARM_WARNING		0x16
> =20
> -#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(1)
> +#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(0)
>  #define SBS_CHARGER_STATUS_RES_COLD		BIT(9)
>  #define SBS_CHARGER_STATUS_RES_HOT		BIT(10)
>  #define SBS_CHARGER_STATUS_BATTERY_PRESENT	BIT(14)
> --=20
> 2.40.0.634.g4ca3ef3211-goog
>=20

--ueouxaucu6i7mkq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRirP4ACgkQ2O7X88g7
+ppwWQ/9FvQ/E06GpGp6TBhZie010tYZ7nHdMGK38Jq/5JiJvOi33NDJDvAnS9DF
MoRwOUAcSWpWjZNfcSN+a51T5YZDXrS5iuPHZlKgCHDuKsfzRtS0AzG2NH4WETRb
bw1Rj4IPkQED2EeypWs7ypheDT7K6sbQ+UmCwvfhXVvnLTxMn0qgfvWXM73v3FGZ
og3p/NvGqjQDYiza1Lgok51TLFNhzNB3dVmfsXZH+8emeCDWvry23XCbwMLk7Hwm
GacjmKDRtPcXmBYbY2n+HRdAHcTPVpBFzPzSnuh3F0x9jiU9Kt7cC/NR8LrWE+nu
vl6bW80jtkbikrLtAUdEkK5ngxB5QTpy8W3nogkpArTadbfnCMao/PrYjZNLDcq6
PKNKQ3SjZiyxaxFm9ZRoK4nMs/vknFIZn3rMzPWa8r3wJyvnUVs8ewBjVw4wEYz0
7Nyf/tAy6FEDC/BuWFhfABRkEymkooKX2H3eniJ/YB+wB3wJbAu6WwQajL+z1xTJ
cDXH8G6JdZwtAzjq/gXFvlVq/R7yAF+Xo/uouj4Y2j44S3yn4ZiK7WeyqVXfAKk0
238rwhq2NEi//8F9iYA67uR+av+v34DG8MSrKusI+wk77DBc/y+Aypyu31huP1rE
RfViUb0Rakd+GiXSfcNURd2wFq8stG0YbmHI2LvcCbYIsHm5GZQ=
=Xx7x
-----END PGP SIGNATURE-----

--ueouxaucu6i7mkq4--
