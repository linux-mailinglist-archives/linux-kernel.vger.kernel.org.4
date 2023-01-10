Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8135B664372
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjAJOlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjAJOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:41:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB0F15FC5;
        Tue, 10 Jan 2023 06:41:11 -0800 (PST)
Received: from mercury (dyndsl-091-096-058-120.ewe-ip-backbone.de [91.96.58.120])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 580276602D2B;
        Tue, 10 Jan 2023 14:41:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673361669;
        bh=ih+qFrGOQatuJW9eim85q1HuwKhYowiedHzl5h9XqOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cgQjU5SXFtONVGfeQp/tCmSmTZRnJnYLEmQ+y0u3qEC0HXxQfvdAH5EwL4ALF4jjV
         gHJTWLSmGBDJx8AyLhjlRdXz9JMFESIVNtUaLuKXzWT1pDd6OLdPWQ1Hb0hcllBsiS
         ZM6/9p+k3jF0P9uPhxgKLCONs3Tus+ppx6CZvDlZbM5BR34oFGDKgOCPQ659mf8fVC
         nLPYkpRocTuHZgxaD7H349oG5vigTLnZVo/+DX1qWMykWjL6mJ4/SdevDyNE6S9HZX
         2YQzYkY5qgiRhBhCGX2iyyNov3V0obQlSVHHhyu2V4ErJ/Y5NkFJ6aLG4AYrkGvNMV
         R6LgNvn45ifgQ==
Received: by mercury (Postfix, from userid 1000)
        id CA2061060774; Tue, 10 Jan 2023 15:41:06 +0100 (CET)
Date:   Tue, 10 Jan 2023 15:41:06 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianqun Xu <jay.xu@rock-chips.com>,
        kernel@collabora.com, Shengfei Xu <xsf@rock-chips.com>,
        Damon Ding <damon.ding@rock-chips.com>,
        Steven Liu <steven.liu@rock-chips.com>,
        Jon Lin <jon.lin@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Subject: Re: [PATCHv8 2/7] arm64: dts: rockchip: Add rk3588 pinctrl data
Message-ID: <20230110144106.wwm4lsp4bfxriupm@mercury.elektranox.org>
References: <20230109155801.51642-1-sebastian.reichel@collabora.com>
 <20230109155801.51642-3-sebastian.reichel@collabora.com>
 <3079565.88bMQJbFj6@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qgvbvo33i4lmbt5a"
Content-Disposition: inline
In-Reply-To: <3079565.88bMQJbFj6@diego>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qgvbvo33i4lmbt5a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 10, 2023 at 02:31:08PM +0100, Heiko St=FCbner wrote:
> Hi Sebastian,
>=20
> Am Montag, 9. Januar 2023, 16:57:56 CET schrieb Sebastian Reichel:
> > From: Jianqun Xu <jay.xu@rock-chips.com>
> >=20
> > This adds the pin controller data for rk3588 and rk3588s.
> >=20
> > Signed-off-by: Shengfei Xu <xsf@rock-chips.com>
> > Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> > Signed-off-by: Steven Liu <steven.liu@rock-chips.com>
> > Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> > Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> > Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> > [port from vendor tree merging all fixes]
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> From: Jianqun Xu <jay.xu@rock-chips.com>
> ...
> Co-Developed-by: Shengfei Xu <xsf@rock-chips.com>
> Signed-off-by: Shengfei Xu <xsf@rock-chips.com>
> Co-Developed-by: Damon Ding <damon.ding@rock-chips.com>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Co-Developed-by: Steven Liu <steven.liu@rock-chips.com>
> Signed-off-by: Steven Liu <steven.liu@rock-chips.com>
> Co-Developed-by: Jon Lin <jon.lin@rock-chips.com>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> Co-Developed-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> [port from vendor tree merging all fixes]
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
>=20
> is how it looks now, please shout if you think otherwise :-)

LGTM.

-- Sebastian

--qgvbvo33i4lmbt5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmO9eP8ACgkQ2O7X88g7
+pqU5A/+JD0zC3rI3iZ9QqOslq3c1tRtIJUCreagi93cfiXdWdYDyr34/muhBWDZ
eEzMAG+O7A0jOjRsrZNnW8QSnAlrLhAVdb9DO1e8+I5FTRBxNIkydTWL5dWpfYSi
7ouVwknAYFLv1dstzKz5E+s+iaMlb+KSyyz/FoKxGhNNvJgry0gmPr8JmKjzADht
iVDQeK5uCWI1tZp+4UljsXGfNm/sMhXvUyLiqTa/kYdgq18KzBcTSKfq3oEp7iUf
rGgovDB5qI2ogCGj6ueft8xUx3wZPd9XApaixRF0h1iiUkCQIcUG6MkmJq3FilsK
fEE2476/5q09QUDPZCWtbGQnSNsHovAp+EjbJ+4DOhLh++IuNmi+gb9Az7JMtE+1
umvxIkldBQaTuy6AuJBSxp9EkIc+hX8x39Quxmkipc+XE8mQM1gEwej1m/X1E7KT
kg74NxwQQOGlxI5pEKpJJu1MmEz7SWmStSOgTE2Rf6z8YA/Cm59bi9bWV37EWSfb
KTsXIH6uFotEnY5me2pLLoHPCmd2rBOcm+e9f2GPO+3cFHq++shU9hGbuFffYLRK
Fmflv+cxd53cj/y6YSxqS03SvRAerYKvcZ1eQ8usdUmLi6I7BROUxd/HAEWusPnU
KsL/Yd0KGdM32LcDOQEXx1BOY8af7qN8xzposzhXNCNB3JpKzn8=
=jdLw
-----END PGP SIGNATURE-----

--qgvbvo33i4lmbt5a--
