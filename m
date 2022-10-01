Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF985F1F39
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 22:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJAUQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 16:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJAUQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 16:16:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB6436879;
        Sat,  1 Oct 2022 13:16:08 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 678D96601F54;
        Sat,  1 Oct 2022 21:16:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664655366;
        bh=TrZHAsF5Dyd5x510BkR/KuhalBTsHT0tTgBVGqk/XVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iugp6NIoOkFPhWcQA4Zm6UjTXz87E9RFB/QLRuB8Z/D4OBuGzctk4Z2xg4vuMmrMA
         nYsI6YOskCKMoHbGzBB0znzNQKgFY3KEsmASFWMmup4uAr6w0lfQFx7CWQ51MeEpBl
         KlSw8F0k/ZWa8ndw8B0qGKvMci/fUyKZB5YJU5DAvy7kyQA6j8hUGpNOUBr2d3B6qp
         C9itmWdDLwH80EaSr7RfqrCF0cuwlq7g40YmNxZCgex9DdnrLrOXMCmvq95NjWBhEp
         LKd8LP+MGHL2z5heN5GeHvYs/CZiZsoKGoLZyKdNnjQDdZShCnqWShFv50ljFt+z7j
         1LVA2gQ5wOw4w==
Received: by mercury (Postfix, from userid 1000)
        id 074B9106090C; Sat,  1 Oct 2022 22:16:04 +0200 (CEST)
Date:   Sat, 1 Oct 2022 22:16:04 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, ChiaEn Wu <chiaen_wu@richtek.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: mt6370: uses IIO interfaces, depends on
 IIO
Message-ID: <20221001201604.b7cp2a74qr3yjn6b@mercury.elektranox.org>
References: <20220929062940.27538-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v7u5xn5m7c6v5fun"
Content-Disposition: inline
In-Reply-To: <20220929062940.27538-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v7u5xn5m7c6v5fun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 28, 2022 at 11:29:40PM -0700, Randy Dunlap wrote:
> The mt6370-charger driver uses IIO interfaces and produces build
> errors when CONFIG_IIO is not set, so it should depend on IIO.
>=20
> ERROR: modpost: "iio_read_channel_processed" [drivers/power/supply/mt6370=
-charger.ko] undefined!
> ERROR: modpost: "devm_iio_channel_get_all" [drivers/power/supply/mt6370-c=
harger.ko] undefined!
>=20
> Fixes: 233cb8a47d65 ("power: supply: mt6370: Add MediaTek MT6370 charger =
driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: ChiaEn Wu <chiaen_wu@richtek.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/power/supply/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>=20
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -623,6 +623,7 @@ config CHARGER_MT6370
>  	tristate "MediaTek MT6370 Charger Driver"
>  	depends on MFD_MT6370
>  	depends on REGULATOR
> +	depends on IIO
>  	select LINEAR_RANGES
>  	help
>  	  Say Y here to enable MT6370 Charger Part.

Thanks, queued.

-- Sebastian

--v7u5xn5m7c6v5fun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmM4oAMACgkQ2O7X88g7
+ppichAAlMOQ326ISIwCBCD+jVz/vqsKXBuxRENl+wPBWaynBg2pp3Z52vnaL+Ug
mBC6S77StiysK3jo8l+axuNLdmR7xhO24PoeJS05eDh/RDNi4KHWXhLN9gBHDWwG
MyZVqcikdXOkWZqnFzaLBuyxWBjwSIQ3nVECGc287VyCz4HEsN2MdECCOSZ33b82
vh5jdu7fzFZXI6jiazzfBoY/pOKbkmZyEQKivkxuqI18C6JJb1gLNok/4l8cgCMB
nrvtoBKykJxVBl4DSprN0QELnrjLXAUzigezYdKfZIobxYob2qDgiiTjHc9DTp8T
UJgKEvAYPLR5e2VwOhWI1z36dFuEEwQG51TCI1pEBQs8gUi1JMuTzhXC7MUumqNt
4299CUjLPtX3urPw/RjKQG/rMbrqj2a03Zkt5cP9cF79aLoGBIbenAjtc4X0k0xn
vYwCg7Hv6Ze7Yn42VeoHjFaJl9BxY6LnVfFhRw0kaj8YgKt9n90mxTui0uHhkrHH
WEsIXG3KCnbrLg3l0OEv9D/pzDkqHt0YkfWVFIvuXZvv7St0c8aPCshbm9tVULq+
xNYwTLovBm+uAVrdsxVv97NDKjj7+r4gEON7yycuaoGLNqrlHeOLWF+7bVjvYTUo
OSoPgx3qqjDaMS/u8u5ovaXBwdYZZUqekVmKyeqoEJXnu+Zhs3Q=
=7DTF
-----END PGP SIGNATURE-----

--v7u5xn5m7c6v5fun--
