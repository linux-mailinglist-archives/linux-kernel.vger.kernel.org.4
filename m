Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D1169B0D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjBQQ2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjBQQ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:28:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F7714993;
        Fri, 17 Feb 2023 08:27:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E41561E5D;
        Fri, 17 Feb 2023 16:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319E9C433EF;
        Fri, 17 Feb 2023 16:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676651259;
        bh=/7n/cDvLrD1MXgANvvSLbsLrYC+ZynSXWqXQNtEzktE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JQHjgKLShFCu5HAbOO1K5ZDvuKqqVeT7xE/idx4eN0YIW/K0UasNEHeI3XABJC7I9
         Vf5wgVsQzkFPIwCfpt3c9eZdigzQg4aNmrJZSGmmiK2lz0UfEvfR/4jjdedtkYDNE1
         EypnzsRRkRIINmCxlBMRnv6LLfYPj113Outk3HAZifmYM3D12C/SBUJ5jGrsmzmuRp
         5D3t+Meu4JZbcHIdsLu31iFzIpa4tIukVg3SJZsGOWHlAWdOliy4k4XYnv+Ndj+JYF
         8+b169D7idvuqlNoQvr5zKdjwlJL5jGkL26fSVg6/dFJtlAOC3MEaUN/ilmSWruiIA
         xBJgpKnd6Lnsw==
Date:   Fri, 17 Feb 2023 16:27:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/11] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Message-ID: <Y++q9ln8P3XegqfN@spud>
References: <Y6JB37Pd5TZoGMy4@spud>
 <7a7bccb1-4d47-3d32-36e6-4aab7b5b8dad@starfivetech.com>
 <Y6tSWB2+98a8k9Qw@spud>
 <5cf0fe71-fd17-fb28-c01e-28356081ba76@starfivetech.com>
 <Y+5z8skN2DuvxDEL@spud>
 <68e61f28-daec-ce72-726a-1fffe8e94829@starfivetech.com>
 <Y+8x/KSujhgNLAd6@wendy>
 <d3b06d0b-ff17-ebab-bae5-e1ec836fe667@starfivetech.com>
 <Y++B43uCnPQlRYFi@wendy>
 <dcba75b5-7b62-35aa-6836-5d5edd785002@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SyOFsqOpDx+l/Uu8"
Content-Disposition: inline
In-Reply-To: <dcba75b5-7b62-35aa-6836-5d5edd785002@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SyOFsqOpDx+l/Uu8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2023 at 04:47:48PM +0100, Krzysztof Kozlowski wrote:
> On 17/02/2023 14:32, Conor Dooley wrote:
> >>>> Yes, it is.
> >>>
> >>> Which would then make GMAC1 RGMII RX optional, rather than required?
> >>
> >> If thinking in this way, I must say yes, it is optional. But actually
> >> GMAC1 RGMII RX feeds gmac1_rx by default.=20
> >> For a mux, it usually works if you populate only one input to it.
> >> Does it mean all the other inputs are optional? And how can we define
> >> which input is required?
> >=20
> > I'm not sure, that is a question for Krzysztof and/or Rob.
>=20
> That's a long thread, please summarize what you ask. Otherwise I have no
> clue what is the question.

Sorry. I tried to preserve the context of the conversation the last time
I cropped it so that things would be contained on one email.

For me at least, I am wondering how you convey that out of a list of
clock inputs (for example a, b, c, d) that two of the clocks are inputs
to a mux and it is only required to provide one of the two (say b & c).

> Does the mux works correctly if clock input is not connected? I mean,
> are you now talking about real hardware or some simplification from SW
> point of view?

I'm coming at this from an angle of "is a StarFive customer going to show
up with a devicetree containing dummy fixed-clocks to satisfy dtbs_check
because they opted to only populate one input to the mux".
I don't really care about implications for the driver, just about
whether the hardware allows for inputs to the mux to be left
un-populated.

Cheers,
Conor.


--SyOFsqOpDx+l/Uu8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY++q5AAKCRB4tDGHoIJi
0of0AP9b4nngiPS2EpyTXEZ+/C7SPEoZpvSl1nRB1hqHGRePTgD/e/wC+yu8sTRR
cTy0Wvob6bxyC4j38a5p5UnXb+ZTtgw=
=Wk+p
-----END PGP SIGNATURE-----

--SyOFsqOpDx+l/Uu8--
