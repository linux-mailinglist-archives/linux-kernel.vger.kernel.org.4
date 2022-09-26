Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF05E9DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiIZJaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiIZJ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:29:18 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9217669;
        Mon, 26 Sep 2022 02:28:22 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C714B1BF208;
        Mon, 26 Sep 2022 09:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664184500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i4eAWY2bCZloQbtUvwHPDqDRZ7KYya4jLR9cP3JLjAs=;
        b=li4fsrvQKROc8CKyC+R4/UqgUDDRf5Pyf3nmR8WsGj2LsPjSm2DXYnriOdYqBtWaBzIEfJ
        aPpFUw0GNfdcsQFrEo2FekF7QUX2HElU4qThZXF49qqomyXti/u962WhJO4BGj0RLdne+D
        UifQsQSI4/je59Fszumgs/JjVROG/4mPjrv1Wt0PdcinEsgEkulCHooWwaZGyX6d8fel63
        snUGu35xFnH8vlZHAn/RB08j7h1oGS9cD8aGwaqOpgArhUbtcut/tNBAWpIvfE15XJ2aPA
        pDj1a+u2YgoAV1bopgP/rpdWwxHwdxvqiA6WhqIQx0tJc6X1RWcTL5KG8SX5sQ==
Date:   Mon, 26 Sep 2022 11:28:18 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/8] dt-bindings: sun6i-a31-mipi-dphy: Add the interrupts
 property
Message-ID: <YzFwst0GpdRBx/9l@aptenodytes>
References: <20220812075603.59375-1-samuel@sholland.org>
 <20220812075603.59375-2-samuel@sholland.org>
 <c85ec3a3-fa6e-aa71-a847-22062b9683e9@linaro.org>
 <0d2bf232-8aa6-2dc1-121d-f0439bfd7b54@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RtKXtsMKKEGalrQn"
Content-Disposition: inline
In-Reply-To: <0d2bf232-8aa6-2dc1-121d-f0439bfd7b54@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RtKXtsMKKEGalrQn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Fri 12 Aug 22, 17:19, Samuel Holland wrote:
> On 8/12/22 5:45 AM, Krzysztof Kozlowski wrote:
> > On 12/08/2022 10:55, Samuel Holland wrote:
> >> The sun6i DPHY can generate several interrupts, mostly for reporting
> >> error conditions, but also for detecting BTA and UPLS sequences.
> >> Document this capability in order to accurately describe the hardware.
> >>
> >> The DPHY has no interrupt number provided in the vendor documentation
> >> because its interrupt line is shared with the DSI controller.
> >>
> >> Fixes: c25b84c00826 ("dt-bindings: display: Convert Allwinner DSI to a=
 schema")
> >=20
> > I don't understand what is being fixed in that commit. That commit did
> > not have interrupts in D-PHY, so what was broken by it?
> >=20
> > The Fixes tag annotates the commit which introduced a bug.
>=20
> The binding had a bug because it did not accurately describe the hardware.

[...]

Coming back to this series, I don't really get the point of introducing the
interrupt in the bindings and the device-tree sources if the interrupt is n=
ot
required for normal operation. I would just drop it.

I recall I was in the same situation for the MIPI CSI-2 controllers, which =
also
have a dedicated interrupt but only useful for debugging/error reporting.
I was asked not to introduce it back then, so I suppose the same should app=
ly.

What do you think?

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--RtKXtsMKKEGalrQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMxcLIACgkQ3cLmz3+f
v9F45QgAgRfNk3+SZO+L1kab89gYMzHlxi/cF34heKSAUZslSgtSK1TAlLPy3L5W
d6tKc1hk1xLdzi+lxA+Z+mR8giHn+7zbVRSCzsiRttdT8rBCZueqwHJrUSSXpwEp
MLN/2J5kNEM0lQeZSXOXUmB9FhjD+KFlHP3k7vTkTS/TaeuqjRZWtyn1339W6lU0
bN6cjE4c2caEqJE3u6lLMdSVMAZm4OVMXf8YWuwo+7IaTbKkyo30UFCXXubk0aRo
/L6SedS/uAl6xmYaCrOQvS1ooSFFKsy8hHvpt5JliG5xtblYw4P67FbEcdRlNsCI
Wgu0Ky5ajXx1ApZjDWfuVSOeITQwFQ==
=LwNy
-----END PGP SIGNATURE-----

--RtKXtsMKKEGalrQn--
