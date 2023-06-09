Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578737295A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241757AbjFIJlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242087AbjFIJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E79749EB;
        Fri,  9 Jun 2023 02:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE7565601;
        Fri,  9 Jun 2023 09:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78341C433EF;
        Fri,  9 Jun 2023 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686303263;
        bh=ZR3MdKdRrMCqf1CdxP5r4I764sOlFGDXjTuTAXUuEcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LocausrQ/ylY9MspZ3g3GMyPmB7derqIPsd8A6CaCVvURoYDflCz288Z00Tzbktin
         A0Ds7n0xEfhaP22IwEnO+i52qDkUknIREXy0xF06z4zclV1RhrWjSnnzK/VQCNGX6C
         Vmn7EpY813pIAen6KS0W5XAHwHwIugQKLMSVs5o4mtnsk9whc7UaJqsQwiaevzyOsS
         JOM+d7NEsog/mDAhTgFTnCeRTIhaWawMF5kVenq76Vn22ZybAwDUdybVDvkXWidCPI
         2F2Eqz14ypR2EZYlN9iPuDlxpOd2QyKkro4j5k4XvIm+KGUyBTdLH+ZaKmprKaT9QY
         JgtPjKs45DFrg==
Date:   Fri, 9 Jun 2023 10:34:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
Message-ID: <c46e93a3-3af0-4e83-b8b0-0100b3392422@sirena.org.uk>
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
 <3241150.44csPzL39Z@steina-w>
 <CACRpkda2yQefuUMn6Ot8Ns6nNgfC25i9nwmzwxOy5fUg=A44hQ@mail.gmail.com>
 <4784636.LvFx2qVVIh@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/xKfjPLJIhW1eCkZ"
Content-Disposition: inline
In-Reply-To: <4784636.LvFx2qVVIh@steina-w>
X-Cookie: Tom's hungry, time to eat lunch.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/xKfjPLJIhW1eCkZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 11:13:39AM +0200, Alexander Stein wrote:
> Am Freitag, 9. Juni 2023, 10:42:04 CEST schrieb Linus Walleij:

> > I don't think command line arguments are necessarily global by
> > nature, AFAIK it's fine to invent something like pl022.4.rt_sched=3D1
> > where 4 is the instance number. Parsing it is just code.

> Now we are touching the topic of non-deterministic device names/numbers. =
This=20
> gets worse if your SPI controller is attached to some other device, altho=
ugh=20
> RT capabilities are rather limited in that case anyway.

I would use the address rather than the device number, and you could use
the compatible if you're worried about a stable name for the name part.

--/xKfjPLJIhW1eCkZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSC8hkACgkQJNaLcl1U
h9Ah7QgAgny1oDjl3V8Q/owHtp1XxyvTTrkOspkcNEjTidw28fstt0EfUZVmCd+R
UDaEa9OC0iWD6IUGZ9OoThHGwpj7kn03mm3YafrFN+mxpsyxflmJGbEs/zwEZzTP
gNY5KpCN37j5RipBdSqAlz2t5O4LnfY23WfVGzoNXyXTq/dcnSl+I1KCK0yzxUVR
OfZWHEoUZPDiy4x0qyxqXEsgUQhIJPXesfZ1BdVHWIeo4nSLKzImGGffcltsWJnM
N5oUrO5fXYQFo2Ndk6Txd5JBnwdNd+uHuUJPwdMIBtxYzAGlykdt8KN6ytbcOjOS
4nRC4C4IBOOU0lsYpQlAgvBX8gQmIw==
=k0PW
-----END PGP SIGNATURE-----

--/xKfjPLJIhW1eCkZ--
