Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D7660A265
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiJXLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiJXLlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:41:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F6F1146D;
        Mon, 24 Oct 2022 04:39:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5971B81134;
        Mon, 24 Oct 2022 11:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10C3C43145;
        Mon, 24 Oct 2022 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666611455;
        bh=UDRWxHpUXDQtdc7IHgSsaUbIHdAv+fVPeKI+Z5q2R7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1/RhpNpP5X66qZOSkZ/SwPbAZJJql5Op19GBWa2Cv5z9rMTTBl710vhuUWLPlDQq
         f7MNtNVWjAIHjSyCQ74f8WBsovclqRuUmKZCaCIN0TI1KU9fE1xNIE1UmiLnLZNWwQ
         wZ2dUnbwUOdYmEsAti8y11OcTuko/8IxUgPh2Dgjt+aN8PJmoodGd/OKfZXCr8sznf
         Ov/iwdbfelClyfgY9pmFp8mIa9ordG2agLrZMxIyNfYrEiYmuwyT/SpgKRtCPnJD+W
         42fgGIoJvzayes1fBd7U2jnUBWgIjfew33P+7tCo+cHJqQctu3k3cK+lwXHYIYOK+z
         cU5oe+b+47SlA==
Date:   Mon, 24 Oct 2022 12:37:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 04/21] ARM: s3c: remove adc.c
Message-ID: <Y1Z4+Vx1/eBEJidP@sirena.org.uk>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TjBesAEwJjzbs13b"
Content-Disposition: inline
In-Reply-To: <20221021203329.4143397-4-arnd@kernel.org>
X-Cookie: You will forget that you ever knew me.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TjBesAEwJjzbs13b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 21, 2022 at 10:27:37PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This driver could not be enabled on s3c64xx for a long time
> because of the ARCH_MULTIPLATFORM dependency, so remove it.

Acked-by: Mark Brown <broonie@kernel.org>

--TjBesAEwJjzbs13b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNWePgACgkQJNaLcl1U
h9Cf+Af/VN6wHC7CvPwnkEZPiQwmDfKJ0zUj9sK6e4yTi+q9JBbCWo70NXs7QDV+
qJ1IdJUjYtDMLuJugV+1A9yk/M73HakD9OTK4drZk3Tq6skDI+2h30RWtbezGSEO
j9pIF9eGWAPJrLr2wEk2fdHc4p96G5ecRED9DXIgxtJiXIzlUMvft+Y4AYr8gNdc
RDssoGSqZwJOMa2w+WalYCffJcxJUh2B2vzog0VzxdkgoQX+V6eCTJeG4/px/ZTP
PCXR/8DwYgbpXADG2bAycARKy4s2WaKHAsU4znv0xoVIDn8EGxAoUqQ/xdNQij/K
ciNCJA7tstlKnbjcuYMUvmFOetwO1g==
=QtEb
-----END PGP SIGNATURE-----

--TjBesAEwJjzbs13b--
