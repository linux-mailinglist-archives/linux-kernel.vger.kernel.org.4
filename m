Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14E15B5858
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiILK2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiILK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:28:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699D83A140;
        Mon, 12 Sep 2022 03:28:36 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E071B6601FDE;
        Mon, 12 Sep 2022 11:28:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978515;
        bh=4CZBeKwudw4wTgOkyL8oZ/k9BQw4jaIjUo27u+Ykp1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hut/lcNzeQmK0dY1/j3ZmIT8JPcBNPW3c9XHCo6iwaFBqifAJ6CaWSvihsW0DM3vl
         wC5KMKRBZ8AEz28tv1OSrUOV4Pd4Q1bX762KADF0nVAee0nXthULdkhoRNDP9jmZHk
         D3AsXnG2GQALO58chV8WY9onDJrZl2HmaYJW9PYQ5kEDn62i4eRNXyH6V/H7Ar4Kmk
         taUufKRdkxM5kuj+vgEoDwrhoDiMLYpapLw3FkHQiJAtyV4e9eDHbDdkjHDO7hWoOh
         TsPsMC+EIkEJHR8qjt0eis9uMxGy/FvZ50dOkNHWxKHrolLbNqxvo5sJ9heQTY6t2V
         Dt1nKA0y0MIeA==
Received: by mercury (Postfix, from userid 1000)
        id D00BA1063352; Sun, 11 Sep 2022 14:17:18 +0200 (CEST)
Date:   Sun, 11 Sep 2022 14:17:18 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power/supply: fix repeated words in comments
Message-ID: <20220911121718.hhnurnb66gzdhpez@mercury.elektranox.org>
References: <20220821144942.48960-1-wangjianli@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="abhhb4dm5s3nunzv"
Content-Disposition: inline
In-Reply-To: <20220821144942.48960-1-wangjianli@cdjrlc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--abhhb4dm5s3nunzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 21, 2022 at 10:49:42PM +0800, wangjianli wrote:
>  Delete the redundant word 'on'.
>=20
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---

Thanks, queued with fixed Subject.

-- Sebastian

>  drivers/power/supply/cpcap-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/=
cpcap-charger.c
> index 60e0ce105a29..be9764541d52 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -5,7 +5,7 @@
>   * Copyright (C) 2017 Tony Lindgren <tony@atomide.com>
>   *
>   * Rewritten for Linux power framework with some parts based on
> - * on earlier driver found in the Motorola Linux kernel:
> + * earlier driver found in the Motorola Linux kernel:
>   *
>   * Copyright (C) 2009-2010 Motorola, Inc.
>   */
> --=20
> 2.36.1
>=20

--abhhb4dm5s3nunzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMd0c4ACgkQ2O7X88g7
+prMeg//RX/gWlm7D46cyHsVR8vjjAIbajeJDytiJCBRYsjVW8wgoK2jj4MOA+9b
B3OAFKOV/OyZGemj307uJs7m+05S4drsXufuYgS76LcIi5SRTHzwCcz75sXySY7D
I/jYBDdifxN+JKsEOr6PyQqc+hX1vSqp5b4buSesH/HnwyqluOkbww15jfTDD6CP
XaigEY7rBBn/acpFzoyPTdhTojnUX6D7KPSnInpp5L3i3spCJwXroc2pcM1S8s+A
z1RjwcAcDOEJuxKVBAtQxLPP+x7zE+vHBmKbI/CJWNWCyd4znfC+np/gbGKsJ/jr
3EJOwN8fkM378TiE8WpknQSGOfMCWMUOqUBrXhD43Tjz5oeUWy0novhBbQjt2gEk
Iopiy/kfYqI/a0GAG/og2LRu6KprW4Lt5hCCgaHf0Xt9udzR/TweVEwAEcmVAfJZ
/wDilI6omF7fXVNDsfDY8aDWrJSBQZwNH7TlW74Ecl6Vz/RGVCYv1rfq3fspig0e
+g8yUpevOeqCME7A+eZx0OntrP997gUbK32dhxX/nQF0OZr/Uvoy55jjXfDvgkP/
Y44N7TCushNuK4IWIMQ9bWca0q2F+zgoaakq4f7PezwXm2o70DGDF48qkdIDv3eb
V77gR61PCUZ4NTaDs+GBgjtrY9CmeGhEpgOG5J34dcdxlMC05WM=
=LEQm
-----END PGP SIGNATURE-----

--abhhb4dm5s3nunzv--
