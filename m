Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B3D656BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiL0OUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0OUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:20:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AB7FEA;
        Tue, 27 Dec 2022 06:20:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 449E461169;
        Tue, 27 Dec 2022 14:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC432C433EF;
        Tue, 27 Dec 2022 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672150851;
        bh=eszlHNnwyNqenWwhKzQ+6Bi2gaQg/fCsFC2uNABjCnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YjNkSZobSLITUsrFDYjjw5wWsL5+U+K1fNc+qPZLS4I3pTDDKea1l7/BVRuqMabBH
         IYcUeJVMXeF2SourDqOTfpVeitr9w3SEGC3Exx5duAKS1ePBqb3JgtGnOhuIBFBp/y
         m5651OY2LIOGPN4G9tw7k4lTgLsyS5zVKroND//oZFHNUILRaPj8+liO7kXw08+Em4
         yCIPvOmAa5p0lvMvIaFHRtO/aC0io+9/ye7yo2S95nXy3LLRbGGXeQ0ljbdCONj+1Q
         nhmHBf9DA6yZ7mbIykq02XytDyrR9xAtblDkOJxOCijvRhKm00X70eLFqD5XD0dT/J
         tHB1wVY+Yjd2A==
Date:   Tue, 27 Dec 2022 14:20:45 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Basic device tree support for StarFive JH7110
 RISC-V SoC
Message-ID: <Y6r/Pa6mxzIiYnuC@spud>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <Y6on34WC2u3PSBHl@spud>
 <7cc1078e-744a-c68f-98d2-6c68d2784df2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FU7aTXDCvLLRKW0J"
Content-Disposition: inline
In-Reply-To: <7cc1078e-744a-c68f-98d2-6c68d2784df2@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FU7aTXDCvLLRKW0J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 27, 2022 at 08:58:01AM +0100, Krzysztof Kozlowski wrote:
> On 27/12/2022 00:01, Conor Dooley wrote:
> > On Tue, Dec 20, 2022 at 09:12:40AM +0800, Hal Feng wrote:
> > The DT is waiting for the clock/reset & pinctrl binding headers anyway,
>=20
> Which were sent with build warnings/errors...

Yah, DW chief - I'm not in a rush. Figure it'll take a few more
iterations.

Errors/warnings aside, responding to the clock series again is in my
todo list, not convinced by the clock binding itself.


--FU7aTXDCvLLRKW0J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6r/HgAKCRB4tDGHoIJi
0gYeAQCeWz9Cz2cqX8w05FRvSFr+0vhC8blylBRMdd0k4kNzCwD/RcbCjRaC4y1l
3MMyFlRE9sQKhQSovtr0C9rIztbO9wI=
=anTB
-----END PGP SIGNATURE-----

--FU7aTXDCvLLRKW0J--
