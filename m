Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA7A719CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjFAMzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjFAMzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:55:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA8A128;
        Thu,  1 Jun 2023 05:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E878C60DBE;
        Thu,  1 Jun 2023 12:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086C2C433D2;
        Thu,  1 Jun 2023 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685624109;
        bh=ZqxTQp6PSUQnFN/2lX8WhB9VL0uNNxw4eFDlQcou2hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJ6uDVxIcnDi9PdUqw02PEj1p95RcNg3MKp1wDy2TmBbS8pVmptiCPIseJN4xU9QU
         kCgcelTnYnYjNuM9MVgFFW/yyFFlTJnCMPoHbJDdn9kHKQLlmF1rRPYLM1lQzzD5EG
         KyDzNREX23EwoNey1cXeLk+/T8tv9lioMokqQx5kX3+zkQW8G8Y8fRcgTnBCD18yy8
         /EKy68ttRK3uJdPkQ/ThWUGhZHitOz32UyIBcu03OMN+zwruzur0h5baKkACR6bah4
         oEcgapiMgotduxHfGYnTsBxn2ErLhl12AP08PsIBfn0o6ZdsMq4Xr8iOJHCJAe3sd0
         Nl6oJX4aveXvg==
Date:   Thu, 1 Jun 2023 13:55:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 17/43] dt-bindings: spi: Add Cirrus EP93xx
Message-ID: <b2fc1733-4841-42e9-8bf7-1534a5d1a1b4@sirena.org.uk>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-18-nikita.shubin@maquefel.me>
 <d6bc264b-9c52-49c0-8012-b938da37337f@sirena.org.uk>
 <20230601154154.57ae1b93@redslave.neermore.group>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V3JKa2O2njgMRI99"
Content-Disposition: inline
In-Reply-To: <20230601154154.57ae1b93@redslave.neermore.group>
X-Cookie: Positively no smoking.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V3JKa2O2njgMRI99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 03:41:54PM +0300, Nikita Shubin wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Jun 01, 2023 at 08:34:08AM +0300, Nikita Shubin wrote:

> > > +  cirrus,ep9301-use-dma:
> > > +    description: Flag indicating that the SPI should use dma
> > > +    type: boolean =20

> > My previous feedback on this property still applies.

> > > +  cirrus,ep9301-use-dma:

> The reason is that ep93xx DMA state is not quite device-tree ready at
> this moment, and clients use it with the help of:

> https://elixir.bootlin.com/linux/v6.4-rc4/source/include/linux/platform_d=
ata/dma-ep93xx.h

> I was hoping to slip by without changing much in ep93xx DMA driver, so

You're definign new ABI here, that's not a good thing to do for a
temporary workaround.

> I can move "use-dma" to module parameters, if this is acceptable.

That's less bad.  I guess you could also define the bindings for the DMA
controller so that the properties are there then instead of properly
using the DMA API in the clients just check to see if the DMA properties
are present and then proceed accordingly?

--V3JKa2O2njgMRI99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR4lSYACgkQJNaLcl1U
h9DnQAf/dOQ5yJ4O/a6/eDXnlTKTJomQveH4SJUqEYc9Jr5rTiC4ZpD8YGXTKLfJ
rh8ZtJo8V7AL5gxaaHy3elU7nGppA0IgAAvPhhw2hKYdCMMP3Yo2Lan3R7c/VK6R
4z8kiUZM2elNvLEa5bG4cw/OGFBl4jFG/pZs7SsgBuvJ+4kU/eAqztvoAWo88FSU
UUA4V2Zbj5ojJ9ihe8eB5WeGXCnFbSSUIEzfoicwJ30dj/fO4RKsXscp0G9gMJyn
k/yLGSkYe171xoNnkwvOyTjsLGBgCfheKXX36+SCi5qR70cNONx5xsnstT5UJNrh
jka8g3Gz6KZCu2BNk1BckqDOMeWwEA==
=b0C9
-----END PGP SIGNATURE-----

--V3JKa2O2njgMRI99--
