Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3B5691065
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBIShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBIShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:37:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8F331E0E;
        Thu,  9 Feb 2023 10:36:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2D0561B7C;
        Thu,  9 Feb 2023 18:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0322AC433D2;
        Thu,  9 Feb 2023 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675967811;
        bh=cA+dRECer0ig6WPe93m+aZhMCEF/NVpjI+9dwFw7KB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uL9jQeG2kyhbs16DqROePM9WuIbIYb5SD+pKtQXNSvm8tAyeWNJlB6YR6FZ+dTDxu
         nEmE25wD66A7vITtA56jPidBHvLPwQ5e8YIKjxCdkJPnEsRuZbOZEra3Jq3JrV/Eef
         Ej54XRoL0CtcLmJ3J5RohSkNnUO84ggpB17TDG78sVRJw6UNvdi2+JupoJswSu9Hab
         WtfzWy5P9CVEA6EEUZ/6hjhz+BEHywr5gPOeXkecCdNxK/SO3WRl/tGnykXaOME/rA
         sS3eaZgX1vqSne3Dsk+ZXODXceE9cA2u9HIFbP71VhHwLvDpOXjOxkQi+HBQ2Xwn8N
         Apy1oEzHMDX0w==
Date:   Thu, 9 Feb 2023 18:36:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] spi: bcm63xx-hsspi: driver and doc updates
Message-ID: <Y+U9PKGLXSYqnavN@sirena.org.uk>
References: <20230207065826.285013-1-william.zhang@broadcom.com>
 <167596308461.673456.2324521897149973878.b4-ty@kernel.org>
 <ac6591f3-0420-3cd0-28b5-8b2ea333d723@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GAiDI2eAEhSaKSHt"
Content-Disposition: inline
In-Reply-To: <ac6591f3-0420-3cd0-28b5-8b2ea333d723@gmail.com>
X-Cookie: Anger is momentary madness.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GAiDI2eAEhSaKSHt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2023 at 10:34:34AM -0800, Florian Fainelli wrote:
> On 2/9/23 09:18, Mark Brown wrote:

> > [03/15] ARM: dts: broadcom: bcmbca: Add spi controller node
> >          (no commit info)
> > [04/15] arm64: dts: broadcom: bcmbca: Add spi controller node
> >          (no commit info)

> Usually we have SoC maintainers pick up the DTS patches affecting the
> platforms they cover to avoid conflicts... I suppose that is fine.

Hence the "no commit info" - there's no commit for those changes.

--GAiDI2eAEhSaKSHt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPlPTwACgkQJNaLcl1U
h9DY2Qf+JaoFXk8tUqSvhr5cAPLdoynTj2X3ZooLhSr5Y9HRp9lBU11hSgSZqgjV
q1pZB+BFrTydI5u1H0+K4nimfFRLNxC8j6NQ2D7DIrCAvBSN7ocNvAiSkW2UcA8T
1WQ4VjUSCeC2uUyrQA/j8RWTLn+H2nK6OsdWnBwss3iHTt63H6GvZ2Fd4mUbtTIJ
qz7qCeTAglrjIasuIUsOR7ppT81MDDMw1eTJSh+3L+CNMlRyaSSZ1rrM+K9vfogQ
+7VniKjirsda4FvN6SjNrjxJV10FMoytm4YaYGa1iCivmcOWI1qEmXbnvEF4iKJz
wFchrA17sU/EAYSWsvKGmfY/xmhCgw==
=WbbJ
-----END PGP SIGNATURE-----

--GAiDI2eAEhSaKSHt--
