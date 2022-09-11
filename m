Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106D55B584F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiILK2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiILK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:28:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D32386A2;
        Mon, 12 Sep 2022 03:28:36 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC71E6601FDA;
        Mon, 12 Sep 2022 11:28:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978514;
        bh=ZEjOqcEs8UemzryfvkFGudAoimW3KpHbLmOmTnb3MWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cphF1e7wrEpfrUgokRA2c2sSl8BylhzTDoO7fjGOQoln9OmqY/uC+IXPhyTg2FgMR
         Tq6xNcZIuzQNGWI7B7lEE/EKgEAMBgDmbBAStTu3tytLnEV84oA+HdhANfFPAYDsBk
         RRYCl7dTOe2lRd35X2eWPpPBPRIyj2yxI5Klu4/5a7qD9TskExnZDNYm2Sv3rLU6Wr
         4MKodllyHFwtCFmgdG1F32WSh0qpE9vpRxIOxOmyBXSxoEgJnDdA3u4OhSaD7v35dw
         VbJDMI1tXi1ui91yKn3RydMH/IXpkb8lLiupH9fefK3yxwLiwuAF/U7uRFepx3bx5V
         KJXiXl+3RqaFQ==
Received: by mercury (Postfix, from userid 1000)
        id 00529106335D; Sun, 11 Sep 2022 14:34:43 +0200 (CEST)
Date:   Sun, 11 Sep 2022 14:34:43 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tom Rix <trix@redhat.com>
Cc:     linus.walleij@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500: remove unused static local
 variable
Message-ID: <20220911123443.uyezfayi2qwtlhmo@mercury.elektranox.org>
References: <20220719022743.305189-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kojtgi2dfwfvwzhf"
Content-Disposition: inline
In-Reply-To: <20220719022743.305189-1-trix@redhat.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kojtgi2dfwfvwzhf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 18, 2022 at 10:27:43PM -0400, Tom Rix wrote:
> cpp_check reports
> [drivers/power/supply/ab8500_chargalg.c:493]: (style) Variable 'ab8500_ch=
argalg_ex_ac_enable_toggle' is assigned a value that is never used.
>=20
> From inspection, this variable is never used. So remove it.
>=20
> Fixes: 6c50a08d9dd3 ("power: supply: ab8500: Drop external charger leftov=
ers")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Thanks, queued into power-supply's fixes branch.
Sorry for the delay.

-- Sebastian

>  drivers/power/supply/ab8500_chargalg.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/suppl=
y/ab8500_chargalg.c
> index ae4be553f424..05146d436a6a 100644
> --- a/drivers/power/supply/ab8500_chargalg.c
> +++ b/drivers/power/supply/ab8500_chargalg.c
> @@ -490,8 +490,6 @@ static int ab8500_chargalg_kick_watchdog(struct ab850=
0_chargalg *di)
>  static int ab8500_chargalg_ac_en(struct ab8500_chargalg *di, int enable,
>  	int vset_uv, int iset_ua)
>  {
> -	static int ab8500_chargalg_ex_ac_enable_toggle;
> -
>  	if (!di->ac_chg || !di->ac_chg->ops.enable)
>  		return -ENXIO;
> =20
> --=20
> 2.27.0
>=20

--kojtgi2dfwfvwzhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMd1eMACgkQ2O7X88g7
+prxpw//b64FEro+osFjtCJqs6be/hUV+KVfatZOPUXIzy0QZzBqFuC2LvvQWJIv
LneApTqXf2Yhje4L+xowTXp0DgRSCjoYsXRFcNMkv2aeHo/g6hekPVoW+vFGNat/
Uj1ho47vob2XdTwQLwrrxuT81pRMJfAPJDQT6lNPldLakKflNJiz31trw6mkd6j9
4HV/zlzEHy26hIJYFkUXUFs+vVbZEDKzaf/J/SHW8AttxS33shbBx4oHVsQ1LOWV
4AwR+UjoDFM4PQrSL877wNVUEPHhrPLu3WmqcV/qWtcF49NFAi9mL3r1aaOL8OA0
bo67+k7P9kDiTk9LATryfGJJjC63obzLz+R+5Yub/PbQ50NK2JjPQsAG/iGutsr4
bf08apeIARxbyq5ZDYlZV3APOLnVdaivQf5twn4sKMdT5WlkoRRv9x6sqpQbY9aS
glOoAyLL8a4SUXl1CEWuBefb2pSGY1W7BncIRpQ6e4lpeWJmJgJpYGUF/gi+5I+n
DY+TbHPQo4/SFj/hVEMFeg/urF2G2W/g8KGQYIbEBScKeKcfUNx/0n+ajnobQIK4
O0Xc3HDbmPJaBA/p+3ci090sAzZ57Ub5QHHCoarsUnQJVm3pDAZiBYH2wFt5QVKF
6VvM3u6YJ8CBo5DNzzDnMeD6SHUPp+/I/DKtoB+037iU+cmE99s=
=mRsW
-----END PGP SIGNATURE-----

--kojtgi2dfwfvwzhf--
