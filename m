Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653ED6B670F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCLOAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCLOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:00:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255C137F09;
        Sun, 12 Mar 2023 07:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF02DB80B74;
        Sun, 12 Mar 2023 14:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0531C433D2;
        Sun, 12 Mar 2023 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678629629;
        bh=wFICklcUPI9u10LmkC+Q32v0zLcHQBj1RUk9RVPheC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNSZvUlBwhDTbciaIRdrh2VcNDuAQhU39vfJX9Ds7rbIQaFekNjLpxEg8zoYYTv9V
         J7MDgE6GkXe4hJk7yBJ3vqJvpg8A/4y+xj++a4cacYWb/p2hG1XLt9wA8h+BotdIbQ
         XNx44pIH7SbR/3KnkheH/OvxtbYra9MtZhCsSDm9e2e8ebEIgCi2NKvldBXCP7hBs6
         16BEm1V9gAYIocE0J6VG6NfVCLTJvNY0TlZlKYVY/h5qK5gPmuD9ubLaJL39HMEZL1
         8cfNxAknrbH4TrFL3SjuDeR7vKWiVXBJG1LqVEIioM/DFY3OwhjTgY4zrULJfuY49u
         TupX2N/e8u/JQ==
Date:   Sun, 12 Mar 2023 14:00:23 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/21] clk: starfive: Rename clk-starfive-jh7100.h to
 clk-starfive-jh71x0.h
Message-ID: <c7e5a23a-16f9-4e30-adc7-a422abeb50ef@spud>
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
 <20230311090733.56918-4-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5IeCIlJW+LRtrZaq"
Content-Disposition: inline
In-Reply-To: <20230311090733.56918-4-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5IeCIlJW+LRtrZaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 11, 2023 at 05:07:15PM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Rename clk-starfive-jh7100.h to clk-starfive-jh71x0.h for making
> the code to be common.
>=20
> Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../clk/starfive/{clk-starfive-jh7100.h =3D> clk-starfive-jh71x0.h} | 0

So this patch has broken the build :(
https://patchwork.kernel.org/project/linux-riscv/patch/20230311090733.56918=
-4-hal.feng@starfivetech.com/

I would imagine it is because you can't rename the header without also
changing the users of the header.

Cheers,
Conor.

--5IeCIlJW+LRtrZaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZA3a9wAKCRB4tDGHoIJi
0gBGAQCqn9Dop3s+ZM1ku4OZOOw18V5mmdfyZ6fqN4sUWFtnVQD8D7anScl1VOZH
DBmBF/QCBa4RJq2bZCOK4qh28+oj/wQ=
=VFFQ
-----END PGP SIGNATURE-----

--5IeCIlJW+LRtrZaq--
