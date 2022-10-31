Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF25F6140E1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJaWuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJaWuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:50:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBEF2DC2;
        Mon, 31 Oct 2022 15:50:17 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C1516602392;
        Mon, 31 Oct 2022 22:50:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667256615;
        bh=kVDDQeMOdM+UVteLf3u36rrJFa9xVLBf4adP3dt8wlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=feFsJnBaq5RKiulZzAexRlfaGop5Sb05DyqHBVwWh6HcV/ctJHn/5NNwyDSuvzGMi
         Ymj0qcAYRAEZJ41a9SidzaB2fpaOSdkBzZa33Is2naG9n0ByfFmubrIGjCB15WUuqr
         niyy3OGiRwt6XREovnwWwQ0zfMGj3hSg34k784D8sXkQrr1iqt0BRvd8LZNJn1dQUP
         5ERLSLmQOtjAuFNLsyCon8TsMjpV0sRUXIOi1W31RyLN/EnpM9WVhqdvqc31eKVKTA
         blXcNjSmKtP5GE5KV5mH+lYAhJ+8XIa4idq4ZuYjeXiqFRTVsokd3fo6p+bx+5LR/u
         ihzYy3iFxzRXA==
Received: by mercury (Postfix, from userid 1000)
        id 34CAC1061C6E; Mon, 31 Oct 2022 23:50:13 +0100 (CET)
Date:   Mon, 31 Oct 2022 23:50:13 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: core: repair kernel-doc for
 power_supply_vbat2ri()
Message-ID: <20221031225013.aax5tsvenbykzp7e@mercury.elektranox.org>
References: <20221031151808.826-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="umduf3gx7xxv6ica"
Content-Disposition: inline
In-Reply-To: <20221031151808.826-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--umduf3gx7xxv6ica
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 31, 2022 at 04:18:08PM +0100, Lukas Bulwahn wrote:
> The function power_supply_vbat2ri() does not have a parameter called tabl=
e,
> despite it being mentioned in the kernel-doc comment. The table is actual=
ly
> obtained from the info parameter, the battery information container. Henc=
e,
> ./scripts/kernel-doc -none drivers/power/supply/power_supply_core.c warns
> about this excess function parameter.
>=20
> Adjust the kernel-doc comment for power_supply_vbat2ri() for make W=3D1
> happiness.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 4b5fb172fa99..9035e349bf53 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -870,7 +870,6 @@ EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
>   * power_supply_vbat2ri() - find the battery internal resistance
>   * from the battery voltage
>   * @info: The battery information container
> - * @table: Pointer to battery resistance temperature table
>   * @vbat_uv: The battery voltage in microvolt
>   * @charging: If we are charging (true) or not (false)
>   *
> --=20
> 2.17.1
>=20

--umduf3gx7xxv6ica
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNgUSEACgkQ2O7X88g7
+poksA//SZmYISwCudqSe/7w94/UPtbVBb9eqqoGwhGaIb99BlieQWRQcGKmgQ1J
sjS1zna2/j5AzhkLhD3R7EqyfAb29BIOML0AtjRHH6niAdluXRakPf/ldZ7QddB0
OvJ7RQGRio+2GXrflB9Hi6F3rbZAMN5ND2XLMdA4xcfJCncRZi1TgrsNhd67WIq5
lShHmeuQodySfX2uIwe9dGoNpTBni8Afe0UaR7GxPIyshxDQnOwjEQbHq9BTtog2
TKe1LWx3AEek1S5tsNPQIGvbJBK0Vjwfvi3ilTN3WHnfLK8ZwHimvUWfaksf0vmS
eVowYLli2Zk9VmHbx9svoKkIFjmFRQ18wmucK4KBjSq/cSBnsn0xqMLcsbGqXSUV
b0BI0HjZmIQMIufzO6Cj3J9cg/LTypzELAMYEu9m9UT0SQ+qY6cqe6+z/I9d97B3
RdR9rFE4XpTjxSLcw/8x/btfUu2vLaFoNrj8IjZe7tH8hqs/+tJCzdA0mgYR2GEb
MJaLXga1V7sQsGXeLnZbm4+mF+XNyLgEwole372onymfaf0bk/Yt8VK2z7bqa6m8
s8KvFVjmUzWSQeEBb3QS/i7MiutijSz2UJyQzNGt6yGGDGULHxTRrvpPqhuWbLts
fBZkbHhr3JnBA9Lp4k4dvrF2qT+vD467qjhPQFAWYE/Hp1G/C7c=
=K8mD
-----END PGP SIGNATURE-----

--umduf3gx7xxv6ica--
