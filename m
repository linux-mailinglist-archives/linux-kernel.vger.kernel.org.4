Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153266D39F9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 21:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjDBTTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 15:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBTTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 15:19:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374C9BBB9;
        Sun,  2 Apr 2023 12:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6AB5B81002;
        Sun,  2 Apr 2023 19:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23E0C433EF;
        Sun,  2 Apr 2023 19:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680463187;
        bh=inEW+jtO8y4n3Uvc+E4dflVytHhuhEnZfJdXbyiVNQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sd8FP0S9LEIbmuopOGvYgeBYVUgWX9q8cUDUakVOjKeHCvx83hNM9Lj0HSCygouZj
         ot8ftyp97Cho3JQVGFZolvn5+2pz0QN8wTdwpkAHxntMKMW1q04TjaSp4IOZLghZjz
         4PwkLxDnovGltyZ+9WsJzmhL/dIs2gbbEemDql+UaAU7kaIvkzMahAkNY1RZzbVB8P
         hZS/Zp+zlNZ4zt0TYDx2wBwsGHNKxfL9DAKLJtiTK/nqbI3gW/8VLNjxQgVRq0SGFP
         SskcGRhhcyAUOYkpLHbR7BRJBbTPbDtXV2dN1aRIXQTuk6bR+KbpIlI4ZuiiqLOG3b
         SpubQ4ePEAxew==
Date:   Sun, 2 Apr 2023 20:19:41 +0100
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
Subject: Re: [PATCH v7 00/22] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Message-ID: <acb36897-8085-4f41-9b68-b243467ffc6f@spud>
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SO2Uk5pRGCbZdMav"
Content-Disposition: inline
In-Reply-To: <20230401111934.130844-1-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SO2Uk5pRGCbZdMav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Hal,

On Sat, Apr 01, 2023 at 07:19:12PM +0800, Hal Feng wrote:
> This patch series adds basic clock, reset & DT support for StarFive
> JH7110 SoC.
>=20
> @Stephen and @Conor, I have made this series start with the shared
> dt-bindings, so it will be easier to merge.

Thanks. I probably should have asked for that, makes my life easier
that's for sure!

> @Conor, patch 1, 2, 16~21 were already in your branch. Patch 22 is the
> same with the patch [1] I submitted before, which you had accepted but
> not merge it into your branch.

I hadn't merged that into anywhere, so I just went and dropped the
original incarnation of that branch and have re-created it.
I don't recall there being a maintainers pattern error (from running
scripts/get_maintainer.pl --self-test=3Dpatterns) with what I had done in
my branch, but with your patch 1 applied I see one. To save myself a
complaint from LKP, I stripped out the MAINTAINERS bits from patch 1
into their own patch that can go with the clock/reset bits.

I squashed 22 into "riscv: dts: starfive: Add initial StarFive JH7110
device tree" since there's no reason to add something knowingly
incorrect IMO.

I've gone and pushed out the following as riscv-jh7110_initial_dts:
riscv: dts: starfive: Add StarFive JH7110 VisionFive 2 board device
riscv: dts: starfive: Add StarFive JH7110 pin function definitions
riscv: dts: starfive: Add initial StarFive JH7110 device tree
dt-bindings: riscv: Add SiFive S7 compatible
dt-bindings: interrupt-controller: Add StarFive JH7110 plic
dt-bindings: timer: Add StarFive JH7110 clint
dt-bindings: clock: Add StarFive JH7110 always-on clock and reset generator
dt-bindings: clock: Add StarFive JH7110 system clock and reset generator

And the rest as riscv-jh7110_clk_reset:
MAINTAINERS: generalise StarFive clk/reset entries
reset: starfive: Add StarFive JH7110 reset driver
clk: starfive: Add StarFive JH7110 always-on clock driver
clk: starfive: Add StarFive JH7110 system clock driver
reset: starfive: jh71x0: Use 32bit I/O on 32bit registers
reset: starfive: Rename "jh7100" to "jh71x0" for the common code
reset: starfive: Extract the common JH71X0 reset code
reset: starfive: Factor out common JH71X0 reset code
reset: Create subdirectory for StarFive drivers
reset: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
clk: starfive: Rename "jh7100" to "jh71x0" for the common code
clk: starfive: Rename clk-starfive-jh7100.h to clk-starfive-jh71x0.h
clk: starfive: Factor out common JH7100 and JH7110 code
clk: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
dt-bindings: clock: Add StarFive JH7110 always-on clock and reset generator
dt-bindings: clock: Add StarFive JH7110 system clock and reset generator

<https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/refs>

As it looks like everything has been resolved in terms of comments on
v6, provided LKP doesn't complain or people don't spot something else,
my plan is to send Stephen a PR around Wednesday for the driver bits.

Please LMK if I screwed up anything,
Conor.

--SO2Uk5pRGCbZdMav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCnVTQAKCRB4tDGHoIJi
0kgSAP0ZhGnMAGUiJ+KlSFzyP2jt+4RI/2QTwN1oKvhgmXYp9gEA51va6jlAkqWF
g5FAbwRJR2vtVawWCI8Mfw/SSpp/jQk=
=ZYkW
-----END PGP SIGNATURE-----

--SO2Uk5pRGCbZdMav--
