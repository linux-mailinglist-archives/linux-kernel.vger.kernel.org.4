Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3096CB1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjC0Wua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjC0Wu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:50:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CA01FF3;
        Mon, 27 Mar 2023 15:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61BD1B819A9;
        Mon, 27 Mar 2023 22:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D19C433D2;
        Mon, 27 Mar 2023 22:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679957424;
        bh=G4vSpWRXFWHWcZZEwCKRH35BlIP0Tx29Xiu9ic3cC+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMmsuv/6IS08xb8zGe9H3FWIyEKz6OniqOjQXIT87SwSRPVrWdIwk/Kheo3XNHSwG
         QkgPaD37hY4OZUmZ3eEXXnWVDMvs/ZP2cUQReHavAZqtSG88rKAlJiO0s5VqmgmgpA
         cnjT6i18JHQ2Ks4w3I1R5D3jsgE1oNX9YfR2Mvp2K2ClJRdUpRz9uuxZReXhoTXBZ4
         b+Ph66gsdGpGBnxY3P1nRhd7BrY7C9utjzOKb74fYPaC2rfVEErWeSV0arGw7582ko
         L52jSXanh62mr+eUSOuEj+mkf/4G+LbcUWGfX0l3Nh6kB0UZnwecOpRkk8i+l11NPz
         HDPzGsKeVgUeg==
Date:   Mon, 27 Mar 2023 23:50:18 +0100
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
Subject: Re: [PATCH v6 00/21] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Message-ID: <29ba8a8d-940d-4b49-bd86-5cd5df002c23@spud>
References: <20230320103750.60295-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EvmgkiZ1lEXclYTa"
Content-Disposition: inline
In-Reply-To: <20230320103750.60295-1-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EvmgkiZ1lEXclYTa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Hal,

On Mon, Mar 20, 2023 at 06:37:29PM +0800, Hal Feng wrote:
> This patch series adds basic clock, reset & DT support for StarFive
> JH7110 SoC.

Probably obvious at this point given the number of outstanding comments
on this version, but I'm gonna mark this series as "Changes Requested"
on the RISC-V patchwork. I'm not sure what Stephen's cutoff for stuff is,
but I'd like to have stuff ready to go to Arnd for -rc6, so you still
have some time for another revision I think :)

Cheers,
Conor.

--EvmgkiZ1lEXclYTa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCIdqQAKCRB4tDGHoIJi
0vYmAP4tJIxpbqPo89Mr6eQyscwzz5HyB5of8DCc+nuX/2v38gD/dP3dUrOdOFC5
HnIQm3HIRolqC9lBVMIu9urkf6xrGwA=
=cdfk
-----END PGP SIGNATURE-----

--EvmgkiZ1lEXclYTa--
