Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3393960A317
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiJXLu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiJXLtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9433B6DAD0;
        Mon, 24 Oct 2022 04:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6E36612B4;
        Mon, 24 Oct 2022 11:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48252C433D7;
        Mon, 24 Oct 2022 11:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666611671;
        bh=A6/oipM71dqfAOwoHLSoCZr4TU1lNCTmy5FXPcGzouo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbS82jc0CZ1yyefji8RT33SmBxwpPrpttejfn+Zfe+r42CJe9fZxMMFa/WhmVXcz3
         3RZ8e/+Z5pgPlEI+COlTJ9K256TfTaTUjsB8oZmZ1OIBOQbD4u7hBmgbdpvA6M1b0m
         8XzJhVJg6EjxxZvI9/sLyLwozToT0XKxJ0BvPwTbc6jbdrkSBDVjYYF6FsBA5fzkLC
         VvRz57xySik+kE5hU5lAkgtJusvZurWmieD1D0uZW3MQOP96nF7jaCt0SqDRxSjd4g
         QBo/i/Rl3fGtY/35fvYHyNn4iPXHq0EoafhmMbgtzrlp3LWX64nDvtt+fxMrn+dtPG
         zlJCme3YuxgyQ==
Date:   Mon, 24 Oct 2022 12:41:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 05/21] ARM: s3c: simplify platform code
Message-ID: <Y1Z50S/PNmN8AC80@sirena.org.uk>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9pGWQfBvLlZkCvgv"
Content-Disposition: inline
In-Reply-To: <20221021203329.4143397-5-arnd@kernel.org>
X-Cookie: You will forget that you ever knew me.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9pGWQfBvLlZkCvgv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 21, 2022 at 10:27:38PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Following down the now unused symbols and header files, some additional
> content can be dropped that is used by neither the s3c64xx DT support
> nor the crag6410 board.

Acked-by: Mark Brown <broonie@kernel.org>

--9pGWQfBvLlZkCvgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNWedAACgkQJNaLcl1U
h9ArOQf+K5qqoOOxAGzLopphyCLIbse0iafJnFcSrDjVkLggygiFXAq8cE0AcwTZ
dBQ76sL/NMCgdghnaM0S7iwRqc0SXfciE31GgnjqnbZdgImxEAfDe5N0lbUBVjOQ
eF8EjYasv7LH/sVfk0fKP109S8Qb5KAxVzVAe1Dn6k7NkiqPsMk9iorBsUP5z22R
+KmhrB0unrOe8HaR8htn9AF15fJgMKENsOkxr1guNotYz4VtdrS3ozKavFkPJzxh
xe3aIgJaHRwuUH/NYsJ25Y3xrUO2i5nNUpRIlto3YqbxXxg+bWKKnYcMDM5RBKno
KKKyUfGrF2TYP8icVtKAI8w3OCSAfg==
=wtbH
-----END PGP SIGNATURE-----

--9pGWQfBvLlZkCvgv--
