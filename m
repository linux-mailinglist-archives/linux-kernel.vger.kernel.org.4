Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096A664DE39
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLOQKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLOQKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:10:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9030731DF9;
        Thu, 15 Dec 2022 08:10:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 417ADB81AAC;
        Thu, 15 Dec 2022 16:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46F1C433D2;
        Thu, 15 Dec 2022 16:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671120599;
        bh=75qsygyEYXqcr+pywz0PhGBqH3J09FtbdMv+diptvgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+Asg/OGm1kVbP/PG/O1rChNh7cpi9x6sxLebrbSjW6v387faHJ1TWdeW4q3ptQWB
         wnlzTWGLB4QM+fVfCO7+AvUxUt7UDsUpa8Cu+nhyuiFfP0oo0JmguJzSgV0W+1QbJA
         UH/VzOuVigptGEZBwr7AIEET8J5cn5gn7fX8DTtuT4CqUc+wZADQFxuPBDBGoT8Gee
         /Q31eYblIFnigfqf4mCedQcpDa0zucn/7L4rj2zl5VX5jrJbdy+tzei6O/dwmM3jy7
         BSrePBvVEC7ah2ZwvuLf2Xc6E1UnFXqsj9he9sOuuICS9AbBl71gkDhEqo/MBo3K9b
         6u6+QQ/FcuZJA==
Date:   Thu, 15 Dec 2022 16:09:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     jerome Neanne <jneanne@baylibre.com>
Cc:     Wadim Egorov <W.Egorov@phytec.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jeff@labundy.com" <jeff@labundy.com>, "afd@ti.com" <afd@ti.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "j-keerthy@ti.com" <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] DONOTMERGE: arm64: dts: ti: Add TI TPS65219 PMIC
 support for AM642 SK board.
Message-ID: <Y5tGzjgcAWPqdFNE@sirena.org.uk>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-2-jneanne@baylibre.com>
 <d0d7e315-ce86-0420-8ef5-fe2e4aefd5b4@phytec.de>
 <e2bc53fe-3a0c-cf24-8b29-ca377aba3721@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="anoyA9LaY/gDcS8e"
Content-Disposition: inline
In-Reply-To: <e2bc53fe-3a0c-cf24-8b29-ca377aba3721@baylibre.com>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--anoyA9LaY/gDcS8e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2022 at 04:51:40PM +0100, jerome Neanne wrote:
> On 15/12/2022 16:09, Wadim Egorov wrote:

> > I am testing your PMIC patches on a AM62 based board with a similar set=
up and
> > running into the following error

> >   =A0=A0 VDDSHV5_SDIO: bypassed regulator has no supply!
> >   =A0=A0 VDDSHV5_SDIO: will resolve supply early: ldo1
> >   =A0=A0 VDDSHV5_SDIO: supplied by regulator-dummy
> >   =A0=A0 VDDSHV5_SDIO: failed to get the current voltage: -EINVAL

> > Have you noticed problems with LDO1 and bypass mode?

> I did not noticed this on am642 board but IIRC this rail was not used. I
> heard about similar issue reported to me by Nishanth M with a fix proposal
> here:
> https://gist.github.com/nmenon/e4dd6ef6afe31bc9750fa6cbee8d3e25

That proposal looks really non-idiomatic and quite unusual, if there's a
fixed voltage supply to the LDO I'd expect to see it modeled as a fixed
voltage regulator.  I'm not sure what the use of bypass here is trying
to accomplish TBH.

--anoyA9LaY/gDcS8e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmObRs0ACgkQJNaLcl1U
h9DROwf7Blis2co9b1vk/lwNjHztgy0KnqViuctcaTlTVYkb+V6RhFAqjiLnCPef
CjaaHwcJJIi4NYJcpDPR2BjKxrKbbKtCtcGez4QGNvRXwvQLqtuxNhYV8+Z5uxFi
cwlGtOdiwfGmpci42d7e6Uc2R/mlTKUVi6W3qgjMNIkX/mR9fYljdEmR3/zOZ/Cx
A3ogZf79cpQm86Cq4bq0xUkqIk4iniLOJGjRHU7iXPew163il5JRSElLvmkIx96n
VDhX7JAHQwVMmg4lvVeBT7+MFm2NF4VrE87ULtBxb1SbBHl7+etRlst4eCUvdvLD
dyuEsKTAvt6hU329mYRXcbe1VgAvOA==
=Dq0K
-----END PGP SIGNATURE-----

--anoyA9LaY/gDcS8e--
