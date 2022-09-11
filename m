Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0325B5856
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiILK2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiILK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:28:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C64839B85;
        Mon, 12 Sep 2022 03:28:36 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C5B4B6601FDC;
        Mon, 12 Sep 2022 11:28:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978514;
        bh=noCD4Vn0gQctXT6PZ5PVeVGjRqehLrCvawqnBuNLM/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a69AioX32wH+19CMGAxoJVnEgkUXvqRiFoivla+Ol5/mnkBMeJC03NkGRs9Oj5H47
         /cSfwf863iVfR1i+pdcZv/fXgdUtU6Id+sRfDtX1U/6WBxxFGUH9CUHPtAF2TxNz2J
         JH6VBWNEAfbMao+zfqgGpnOkSTFKF49PyYZetquYcEYS1X3N+nEwoeq10RcluFssVm
         oc/t1aZJfMUg9fMbdzLyLfjz6fL8cx5T0sN0N9lcY3H2T0IwkIkXt7feGB4DEbYnk3
         vPiuhnARxsMiF16Vduod7uleUUFTTYjzCDiRHcRQa/YjpXvak2uoMecWZBYS9i7YJi
         oICNwHjbF3xXA==
Received: by mercury (Postfix, from userid 1000)
        id 095231063358; Sun, 11 Sep 2022 14:20:03 +0200 (CEST)
Date:   Sun, 11 Sep 2022 14:20:03 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: tps65217: Fix comments typo
Message-ID: <20220911122003.yefvbj5egmkp36lo@mercury.elektranox.org>
References: <20220831154905.1513-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ha33etfo6tlveimr"
Content-Disposition: inline
In-Reply-To: <20220831154905.1513-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ha33etfo6tlveimr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 31, 2022 at 11:49:05AM -0400, Shaomin Deng wrote:
> Delete the unneeded word "the" in comments.
>=20
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/tps65217_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supp=
ly/tps65217_charger.c
> index ba33d1617e0b..a4bc9f2a10bc 100644
> --- a/drivers/power/supply/tps65217_charger.c
> +++ b/drivers/power/supply/tps65217_charger.c
> @@ -50,7 +50,7 @@ static int tps65217_config_charger(struct tps65217_char=
ger *charger)
>  	 * tps65217 rev. G, p. 31 (see p. 32 for NTC schematic)
>  	 *
>  	 * The device can be configured to support a 100k NTC (B =3D 3960) by
> -	 * setting the the NTC_TYPE bit in register CHGCONFIG1 to 1. However it
> +	 * setting the NTC_TYPE bit in register CHGCONFIG1 to 1. However it
>  	 * is not recommended to do so. In sleep mode, the charger continues
>  	 * charging the battery, but all register values are reset to default
>  	 * values. Therefore, the charger would get the wrong temperature
> --=20
> 2.35.1
>=20

--ha33etfo6tlveimr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMd0nIACgkQ2O7X88g7
+poUXRAAlUvSGtaOyDfbKtJ7kXqJo+hCP8/IjfeaEdcv1SvXI2iF5noaUOVWvtbg
q/HlWZv56QN7PxrwfXZdz54ba26+3cWmtCwlyCnxJe5sTQSpjdZJuhZsjyNhHynM
rmc5PFYwhcGeMvsES7kyG54qlpF7jmNnlXR1NBH0X4xhjyxfpR2XDuppThwgWDJf
XUHOeyhYuixlf8mofn5j04BJ+YFu7DD1a7/EW8ovDl4ezGeUfq+J9TPOBwBsBlSp
wxxQ70AhPJNtqQcVUNuGux8+wQS4IJtFULC1ALVcECfTGNPSKV/7R3GonvbQtteZ
XOlvguuqfmvvrKaM968Or7zkmsPo1iozPHqvZEZLIifZ0j/U/7yeF0Wxmw0pQ3Rw
vp/9Y0vmNEuqEgUih4sUoU0RcDbMTG/SeI2r9EKyNMO0/vjDjlr+xwZMkrcqKNw0
lxTx1A1zmQ4FFrlZ7OPKGHEjP1IFZ4Nuxx2hJlAwsbqEWYXQmvo99OKoY1ouNy3k
ADrEbopYwEFJaf6c6t0njqRkB574FNlmC0WerUgKSPQ4oIp4dRsexz7yY4Zf3xyB
u0PApKyBIVQGNlol43TTKLQfeCFENXTphqVYqpvfL71ihzzKQfrLf5fSn8iJBLNd
by4+OZVo8BIgJq7Iq8XUD3BwghM/xRCmSmmg7nvuhKPe8rnFIiQ=
=wHkV
-----END PGP SIGNATURE-----

--ha33etfo6tlveimr--
