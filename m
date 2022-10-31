Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31386613596
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiJaMP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiJaMPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:15:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC73AF58C;
        Mon, 31 Oct 2022 05:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 986C9B81600;
        Mon, 31 Oct 2022 12:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23E8C433D6;
        Mon, 31 Oct 2022 12:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667218545;
        bh=Ef0W9FuoGDPdO4zKMVlrGyTZfrkEq8UbTUD28FiKRag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+iA4gyWU/jnn43e+kWoV4GiKk0s/JeKh7LlUD5I/laKaGMYT91w4GqbYLRBtJE7V
         Q0BUxSVHW53TryBbQHes16JEzqGW0rvbUbdbaS2nm4Zs+OZhVVM21Cmxh00L0r0LFs
         QdjrUTUSBLIMujDYupLOehoy7qdjM4G8d0KCemtBs4jOr3wWjFVKWiisVmQX1bdpGS
         2/riTQX+d2qnw2qiLKWwYuBM9TPgJeZV8hyFntv8YM8pQZO2dXVPQXK0ysBNpcOKMm
         2A3C3Brgoj2yiSVTPkyjzLwU8pOTUdPNJD1qs9MIRIgHQl8q+anWKIs9ioHFCh+oHM
         4i4Ek4kz1KFcQ==
Date:   Mon, 31 Oct 2022 12:15:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     paul@crapouillou.net, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tsbogend@alpha.franken.de,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: ingenic,aic: Remove unnecessary
 clocks from schema
Message-ID: <Y1+8a397G5jwOPmR@sirena.org.uk>
References: <20221028103418.17578-1-aidanmacdonald.0x0@gmail.com>
 <20221028103418.17578-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N901two7N9pSy3Od"
Content-Disposition: inline
In-Reply-To: <20221028103418.17578-2-aidanmacdonald.0x0@gmail.com>
X-Cookie: Sign here without admitting guilt.
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N901two7N9pSy3Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2022 at 11:34:16AM +0100, Aidan MacDonald wrote:
> The AIC needs only the first two clocks: "aic" is a gate that's used
> for gating the I2S controller when it's suspended, and "i2s" is the
> system clock, from which the bit and frame clocks are derived. Both
> clocks are therefore reasonably part of the AIC and should be passed
> to the OS.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--N901two7N9pSy3Od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNfvGoACgkQJNaLcl1U
h9Cnswf/ZAuU22Y9Yiq2KpvaB2q8KrqZ6K+ZSo62Ba4+8vTUklrQSWDDd6rRYhpg
a6wup56FbqCzhIhuL8sRf8SI1T21vM8uMluer89ww/q75rIfpll4Yub6fHhpi7b3
clsOwOE2BJrLONcfkPS5Ln8EfedsXF7JZRR6fTwgOONfkUGkRf4lUtSfIgTAHNjw
KgStQUCJ/ah5jCarlGQsB4PMq6QcbEJmjLlBI4RDb2fkSWUuoXFtKzRenRrafc7C
QEAi5knsfYKq3MOfZYjOQfvrYqlaUtlEsQUAzO39m/vxrMagIZcgFNZz8YOzRlfs
rbUJ4GaCQrVbBh3k/8atGG9LQRqLog==
=CzgJ
-----END PGP SIGNATURE-----

--N901two7N9pSy3Od--
