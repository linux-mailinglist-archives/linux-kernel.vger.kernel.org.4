Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB94611436
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJ1ONm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJ1ONk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:13:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7861E0463;
        Fri, 28 Oct 2022 07:13:39 -0700 (PDT)
Received: from mercury (unknown [37.84.150.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22D2B6602925;
        Fri, 28 Oct 2022 15:13:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666966418;
        bh=nM5tFpA0TeTXJ/Ok53S2f4MGmJ15PZ4YbuZYY3wW38c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7tLHyZNuJV4WSuR2oKHx43F6+z47icAIob1weaSB1G4B+JWPvACyjOX13q43X5Yy
         dlsgaiJl2FSE8zq7tQAQDEt1/x77L74W44yoQShD6XzLuwdbi8agFY5l0kczPPlGNO
         oIYivf/bPpl2gcqyJiXXLapPqlkHRYdOUQ9XmU5Wl9o402Lqx1QZdWVEngDCFLpuSd
         DV5fgRHvvZdU7W7D/ygyusPiEl24YMXARKDwBSDtKIL5Qay0NCPMNEEamq6uLnrji2
         wbM4I5y488h8avMJGy8YanIH/IKZ4tdJJxuyaghq4kVhAGBGK+K7YBaMRoKkos+7+A
         KKa/SGpssfKag==
Received: by mercury (Postfix, from userid 1000)
        id D918010607E8; Fri, 28 Oct 2022 16:13:35 +0200 (CEST)
Date:   Fri, 28 Oct 2022 16:13:35 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: lp8788: make const array name static
Message-ID: <20221028141335.zqzr5p4ludmpnxse@mercury.elektranox.org>
References: <20221005161348.321971-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="isucbwil5mwzhop7"
Content-Disposition: inline
In-Reply-To: <20221005161348.321971-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--isucbwil5mwzhop7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 05, 2022 at 05:13:48PM +0100, Colin Ian King wrote:
> Don't populate the read-only array name on the stack but instead make
> it static. Since the data and the pointers don't change also add in
> a missing const. Also makes the object code a little smaller.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/lp8788-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply=
/lp8788-charger.c
> index 56c57529c228..802c9491fcdb 100644
> --- a/drivers/power/supply/lp8788-charger.c
> +++ b/drivers/power/supply/lp8788-charger.c
> @@ -520,7 +520,7 @@ static int lp8788_set_irqs(struct platform_device *pd=
ev,
>  static int lp8788_irq_register(struct platform_device *pdev,
>  				struct lp8788_charger *pchg)
>  {
> -	const char *name[] =3D {
> +	static const char * const name[] =3D {
>  		LP8788_CHG_IRQ, LP8788_PRSW_IRQ, LP8788_BATT_IRQ
>  	};
>  	int i;
> --=20
> 2.37.3
>=20

--isucbwil5mwzhop7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNb448ACgkQ2O7X88g7
+ppQ6xAAotyuOrN0/HRsHEJr6M3Hm2T+Ol0BItzGauQWFEYjP3N/b0eKOUL5bW4J
RnVvwaNw9Z3BjxvCt9y3VR58oJ/zHTSzIUCAMrFs9YAMOTDfvbkFvF6kCv/iC2QP
nwhQjOzmeA6t/FlGG5F4fITCgI068feeaTImSiL1omNYkAy3lFr1DnuYthtA3ovD
nFlbnxf8oKT6Jet0vMhNAfnDMn2ar+TXPJpr8Mnly+LJBR0dKv6+nVEE0/Ohp8He
gul7FTlqhsWH8XB6+k9b09fJZQz6doJF39ke0XRBr56gFwqz8P3ztCQaKKLXch7p
sXzyCXVF1Mo6o2QPGharOf1Bo23tHKVsnx6QJBhqgwFUADdwl25MPepQzZhRQt7I
n+Y59Yk1LuelH5fI+QFuw8VIw1shJmY3GK/ELukIfqgh1ALpu+qd4/IKzQEaqt5Z
eG160/CCzcDLtNeCTYazdY8AItWbRZyAakBQ9xMFRde7q8w0N0g3QylM7lBWhy5D
u9FpZWr+yhnFD9UwUIS0kHDIeVVzwv5B2BLUTqgAQPkqmVL2RivDm7OY1cv4Nq3k
9HJFDcJtobIa9PaiYEdbYntMgB9jtm2AKlTaVEePPNaY1qDlAqSAb5LNMLwSnTzv
7n/ZX8zQHwmMIyrmAYLvR5/2r9ukqu+znvMHvEtNBYPmFhqh97k=
=aTzf
-----END PGP SIGNATURE-----

--isucbwil5mwzhop7--
