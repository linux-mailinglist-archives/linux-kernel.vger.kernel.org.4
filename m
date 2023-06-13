Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2246B72EBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjFMTRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFMTRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:17:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1FEC6;
        Tue, 13 Jun 2023 12:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC3F63A09;
        Tue, 13 Jun 2023 19:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48515C433F1;
        Tue, 13 Jun 2023 19:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686683867;
        bh=oD280Kq4hv47N+S/pekjBlHMpeiY3mor5pFjsES0eBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFaMCiooc9xqA+b6v8Ydxm4bW3t48zVN7o+ZLd9NGw0ecZInTVWNcNVsWdohpUWeo
         7gyZ+f7Fvo+wbFePOydPko9zAxcfOd9DIrYPdthKHDBIeCVt4ky2Ij8rwjLsNHQubN
         xD8g7S9oYJDWPtaqKcvrJQuI2BM5Th+SNP49XhZ/8Odl42JApkWMPYNhpk7Ew8WaDY
         EG8c8EXeDjvhfvXO1CRLI6P6m0PV9kVbx1JOM/88yXzfkbaRfxamz9PEnqw/v4zPYN
         pU+F39Ep5YJVdAkMNbgHDVeg1/P0gISYAIbp2N+sQCLKy/NZxNoWjLI7j3YTD/Bkk9
         RImaTm1CyiEPA==
Date:   Tue, 13 Jun 2023 20:17:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 3/7] dt-bindings: clock: jh7110-syscrg: Add PLL clock
 inputs
Message-ID: <20230613-vessel-gallantly-d8c7393c9aca@spud>
References: <20230613125852.211636-1-xingyu.wu@starfivetech.com>
 <20230613125852.211636-4-xingyu.wu@starfivetech.com>
 <75508c4d-d86e-f88f-191f-dd870ebe7bd7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4FpC5bN6KyvzAt5G"
Content-Disposition: inline
In-Reply-To: <75508c4d-d86e-f88f-191f-dd870ebe7bd7@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4FpC5bN6KyvzAt5G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 08:34:25PM +0200, Krzysztof Kozlowski wrote:
> On 13/06/2023 14:58, Xingyu Wu wrote:
> > Add optional PLL clock inputs from PLL clock generator.
>=20
> Are you sure that PLLs are optional? Usually they are not...

They're not. What's happening here is the original binding was defined
without these clocks (obviously, since they're only being added now) so
for the driver they are still "optional" to keep compatibility.
In mainline, the driver takes the "osc" input and registers some
fixed-factor clocks to mimic these PLLs & after this patchset that is
only done as a fallback if the clock inputs to the clock controller,
=66rom the PLLs, are missing.
They should not be optional in the dt-binding because they're not
optional in the hardware afaik!

Cheers,
Conor.

--4FpC5bN6KyvzAt5G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIjA1QAKCRB4tDGHoIJi
0olYAQCUKGw49UtQ9fn/beKhbR7EyT1pRj5cgqbV4cYpDu9U9AEAqbt+eklBEBlT
/UHn1MIfOjSf0NW68hlORp8JzD6gSgw=
=aTi3
-----END PGP SIGNATURE-----

--4FpC5bN6KyvzAt5G--
