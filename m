Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A3B6565F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 00:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiLZXCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 18:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiLZXCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 18:02:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666BCFE3;
        Mon, 26 Dec 2022 15:02:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CADB6B80DC4;
        Mon, 26 Dec 2022 23:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF9CC433F0;
        Mon, 26 Dec 2022 23:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672095717;
        bh=SX0BmzYTkCHs1PHSbj2Sqc0jerZcZXqTrHn2k8779eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwGcph3jDWpdUjn8PKQaR9ejzHI5fqrV9b9P06X97nG5sMCTGDO9HQEg4Pr2/eI/o
         26/EW4ZJtG/QB2pl8o7gVPQlUMO4rlXHGuWslxcfAjdDTwnowdgwEh2YLgjJhz+j9W
         rS2UUxD1E2L4jO0YsAF7YCBGUvCBJNAVcNc7CicZ79UdXix73w1xxENYjX06V5aflU
         OreCAkz3XI3DbWaFkU72O8EXH/OqtM7aSMxClJqxr+OIl01r4PXSJxpCesBTKPixtt
         M+CLKKuDRxlnj3AJc9/fJP31FSrDJpk5Ox0gYpzJ3QEsJv+lHzr6r1qKjy0aG2LqxT
         eMcMcjS8+O7QQ==
Date:   Mon, 26 Dec 2022 23:01:51 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
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
Message-ID: <Y6on34WC2u3PSBHl@spud>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f/iFEOT8SIj34xAh"
Content-Disposition: inline
In-Reply-To: <20221220011247.35560-1-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f/iFEOT8SIj34xAh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 20, 2022 at 09:12:40AM +0800, Hal Feng wrote:
> This patch series adds basic device tree support for StarFive JH7110 SoC.
> This patch series depends on series [1] and [2]. You can simply get or
> review the patches at the link [3].
> Emil Renner Berthing (7):
>   dt-bindings: riscv: Add StarFive JH7110 SoC and VisionFive 2 board

I've applied this one to riscv-dt-for-next
https://git.kernel.org/conor/c/97b7ed072784

>   dt-bindings: timer: Add StarFive JH7110 clint
>   dt-bindings: interrupt-controller: Add StarFive JH7110 plic

>   dt-bindings: sifive,ccache0: Support StarFive JH7110 SoC
>   soc: sifive: ccache: Add StarFive JH7110 support

And these two to riscv-soc-for-next
https://git.kernel.org/conor/c/1caf002efa22
https://git.kernel.org/conor/c/6635e91648ce

>   riscv: dts: starfive: Add initial StarFive JH7110 device tree
>   riscv: dts: starfive: Add StarFive JH7110 VisionFive 2 board device
>     tree

The rest I can take with maintainer Acks alongside the DT, or they can
go via subsystem trees.
The DT is waiting for the clock/reset & pinctrl binding headers anyway,
so IDC which it is.

Thanks,
Conor.


--f/iFEOT8SIj34xAh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6on3wAKCRB4tDGHoIJi
0tjwAP9w54bxRzyxyIptYDA+Fq7fMvb7SJHNF9qgWs6aGwBT1gD+OOPrBoNFXa9g
/EJQoDkPAke1E2T/1IuPwS5c7HAnUgU=
=r4lC
-----END PGP SIGNATURE-----

--f/iFEOT8SIj34xAh--
