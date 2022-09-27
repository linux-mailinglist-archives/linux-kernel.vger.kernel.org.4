Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66665EBEC0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiI0JgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiI0JgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:36:17 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C92D96749;
        Tue, 27 Sep 2022 02:36:14 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C7D6410000B;
        Tue, 27 Sep 2022 09:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664271373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lztctaXpuBh23+RJMFSBb8KRhYG7OptTx91tvx4/3kk=;
        b=iXC2/jH+tpxbpJ3YGexQykGVbYGfOQ1qtFA8gzE8O6LntvgnmBum8FmgxImkSNDCME4ME/
        LhB4PXeGlQ6T0Dv67wBbuU1JyTAEVIZK9+6dwUeaXizW2pMJYRA46xh3a1BknMPl7e1/CE
        tss8HJBzyax0/dJCQk0Djk3bYXyX5UDHu4oxn04t1gdtNgFrU8GmzJy46K7YhjKXe7PGoR
        N8hZFQwixvw5fDmwoZL83zvkvj0am66kV92BOVUv68j7ek3iFN+8bm8dBvCAK0pPvrL1kH
        AbDoDnEyAJBkAz/IG69ULOhioern06HvZjAr4nzFoNMe6v945CUHjrrUmhsVcA==
Date:   Tue, 27 Sep 2022 11:36:02 +0200
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
Message-ID: <YzLEApjzpGaDxKni@aptenodytes>
References: <20220812075603.59375-1-samuel@sholland.org>
 <20220812075603.59375-2-samuel@sholland.org>
 <c85ec3a3-fa6e-aa71-a847-22062b9683e9@linaro.org>
 <0d2bf232-8aa6-2dc1-121d-f0439bfd7b54@sholland.org>
 <YzFwst0GpdRBx/9l@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PiLFU6KiWb8KPWLq"
Content-Disposition: inline
In-Reply-To: <YzFwst0GpdRBx/9l@aptenodytes>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PiLFU6KiWb8KPWLq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon 26 Sep 22, 11:28, Paul Kocialkowski wrote:
> Hi Samuel,
>=20
> On Fri 12 Aug 22, 17:19, Samuel Holland wrote:
> > On 8/12/22 5:45 AM, Krzysztof Kozlowski wrote:
> > > On 12/08/2022 10:55, Samuel Holland wrote:
> > >> The sun6i DPHY can generate several interrupts, mostly for reporting
> > >> error conditions, but also for detecting BTA and UPLS sequences.
> > >> Document this capability in order to accurately describe the hardwar=
e.
> > >>
> > >> The DPHY has no interrupt number provided in the vendor documentation
> > >> because its interrupt line is shared with the DSI controller.
> > >>
> > >> Fixes: c25b84c00826 ("dt-bindings: display: Convert Allwinner DSI to=
 a schema")
> > >=20
> > > I don't understand what is being fixed in that commit. That commit did
> > > not have interrupts in D-PHY, so what was broken by it?
> > >=20
> > > The Fixes tag annotates the commit which introduced a bug.
> >=20
> > The binding had a bug because it did not accurately describe the hardwa=
re.
>=20
> [...]
>=20
> Coming back to this series, I don't really get the point of introducing t=
he
> interrupt in the bindings and the device-tree sources if the interrupt is=
 not
> required for normal operation. I would just drop it.
>=20
> I recall I was in the same situation for the MIPI CSI-2 controllers, whic=
h also
> have a dedicated interrupt but only useful for debugging/error reporting.
> I was asked not to introduce it back then, so I suppose the same should a=
pply.

Coming back to this, my memories were wrong and the interrupt was in fact a=
dded
to the binding and the dt description.

Nevermind my previous comment, I guess it does make sense to have it in the=
 dt
hardware description even if the driver does not use it.

Sorry for the noise,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--PiLFU6KiWb8KPWLq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMyxAIACgkQ3cLmz3+f
v9HwAgf/duJh5AF/wrOPWoxEDWSWSf/54+O5EtPf1cpHo1tW2RMzwVgVNSiFXlUW
Wef8LOxHWLSYdC+Aq7EmPa8t/3PW0t3j2leA4FPIUY6LArocr2HUFzoh90ivZxJE
r8VR1P1ZbubureBZQJwFhDflDqR67qnUwEM9be++4LcBUM0RWZzYKhD1YmR6GxbV
OVn+VWkeDSdb3fK4Prmh3ogRivMorGs7GvyFM3QJFv+arKCDBSG9/NVmVIbzgr1k
Xa+M/cWNMfxvSuyTltrI0kAeQPpqjEDnaL6unrG/le9MZsducKOSOyGOlxPDYHqm
lu1MFlBQGEhhcv/hIQFmJhI2e8JkTA==
=3Zbu
-----END PGP SIGNATURE-----

--PiLFU6KiWb8KPWLq--
