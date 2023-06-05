Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC487226FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjFENKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjFENKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9368110A;
        Mon,  5 Jun 2023 06:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19C0B61380;
        Mon,  5 Jun 2023 13:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B49C433D2;
        Mon,  5 Jun 2023 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685970609;
        bh=8t0gkV9hWjiig7w5I4yHeDTMFMGcx/Jyz/6tkmCgSoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nd1JPUajNDC/wWeim6ogdtSqR67wDOUNJO3b2DkXSQO/WkSYzPddM7y1dTYAy2K5x
         H6rjCGl115Y3k3S4nURPI9Jb/KWqxb9vPzUVuIj/Id9q9b/gJx5qn5zzI30frs21W3
         /pismtZHdU885Oa0twIPxiuGw6V6RLfS34NVCP/Aw/WsEgQ9haWnvHmVPmncM86kea
         VWhVwib5Qt0OFqv7DonkL6LECjUSx4SMQXPpqSda4KtXTny85AqBwDPDIhrDaY2gpK
         LjiHYO4yMDVm8WicxMD92HdxxksX5T7tZ8hkELZ6blc0A+6lDKxeyB8vNeJogPVmE0
         xKxUEpxOEAvSg==
Date:   Mon, 5 Jun 2023 14:10:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH v6 00/11] Add Renesas PMIC RAA215300 and built-in RTC
 support
Message-ID: <31b1f83f-6baf-46de-a04c-373ad20a6c24@sirena.org.uk>
References: <20230602142426.438375-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fxj1hlNTcF5u98yi"
Content-Disposition: inline
In-Reply-To: <20230602142426.438375-1-biju.das.jz@bp.renesas.com>
X-Cookie: Biggest security gap -- an open mouth.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fxj1hlNTcF5u98yi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 02, 2023 at 03:24:15PM +0100, Biju Das wrote:

> Biju Das (11):
>   i2c: Enhance i2c_new_ancillary_device API

I assume there's some dependency from this patch in the others but
you've not copied me on it so I can't tell what the status is...

--Fxj1hlNTcF5u98yi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR93qoACgkQJNaLcl1U
h9BxWgf9FAJyuVrS2WcSNAN9m3gAk0kbXuVuoLus9F/P8QSnNvee70LfC/Amw0A8
uaajAJDRaaHA4y3l7ErG4NmZZYdbfKRgNWcYYHmiWtIPD9iEuTQkZ6OBv9sTd7KD
RL7L/qtzCAmjb9K24NJK6atj8+nKGZ2oom84wrnMPFSmsWJ+KXwgUW/h0sVksiNS
Zwu6vtomkk3jGwgxd7HCqKTtFiQvRQfJBrdBb8tVcL8M81HR/tp7UCDdP99FOW4k
hxCQPmoKmsLoigBn0s6s2kaJep+9lbmE1ETef+e7E6wnm0LqVHReSikjEraXBq8l
AXhwwhJpQAUurCinETNh2mpBoZCFzA==
=r1fj
-----END PGP SIGNATURE-----

--Fxj1hlNTcF5u98yi--
