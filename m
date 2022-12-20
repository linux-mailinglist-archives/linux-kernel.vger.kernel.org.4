Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72DF652824
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiLTU64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiLTU6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:58:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E595A1DF13;
        Tue, 20 Dec 2022 12:58:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1D67B8133B;
        Tue, 20 Dec 2022 20:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06EBC433D2;
        Tue, 20 Dec 2022 20:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671569924;
        bh=x403go0noSlBok3l6ETWm1H3es1ov0ErW3hoGi/bwMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aU3RHF9M+DZ4tI565UV/fbP23ssYCNG9RrmVtrLxQP6C9Dyad3GbQN4ByNAkRnWmH
         +GmPE6SFXeBFvKJAT6EGzTHjzr+KXLxVhYwmT9jgY/DIZ5hjEuFw1Iasw5UEiBKqnO
         gmYqW96z3Yi5oJZUotd5OAhXnvIn010Ou4Z7YcnMfEpT52Vpdt4euSQNhNXSBwVK5y
         y7ToHcx3su6+z+LttHYc6iyjqUjp9ytxuocCKPkMUilZbeh9TfZyCbPnP6E78VxZFu
         pjYfvZPm/TtMp6Q0531Jv63rNcAOsKFKyQNpMqdBJOieMWweCVeBWCOeVi3t64LBP0
         YQVDkK43LtMBQ==
Date:   Tue, 20 Dec 2022 20:58:38 +0000
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
Subject: Re: [PATCH v3 1/7] dt-bindings: riscv: Add StarFive JH7110 SoC and
 VisionFive 2 board
Message-ID: <Y6Ih/oG661gkA9Rd@spud>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-2-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QuMAt+cWIHQmpruC"
Content-Disposition: inline
In-Reply-To: <20221220011247.35560-2-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QuMAt+cWIHQmpruC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 09:12:41AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Add device tree bindings for the StarFive JH7110 RISC-V SoC
> and the VisionFive 2 board equipped with it.
>=20
> VisionFive 2 board has version A and version B, which are
> different in gmac and phy chip. The version A board has one
> 1000Mbps and one 100Mbps Ethernet ports while the version B
> board has two 1000Mbps Ethernet ports.
>=20
> Link: https://doc-en.rvspace.org/Doc_Center/jh7110.html
> Link: https://doc-en.rvspace.org/Doc_Center/visionfive_2.html
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Unless Emil objects, I'll queue this for 6.3 once -rc1 has been tagged.

Thanks,
Conor.
=20

--QuMAt+cWIHQmpruC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6Ih4QAKCRB4tDGHoIJi
0ow7AQCts2dR5OUFsLgM+2Wp9kFTFTakGv8Ot3caCKUwNJ8MxQD+KvD5x2VCii5O
85RYKGwAvcTntvHA9kodjRaPru06QAY=
=bgMZ
-----END PGP SIGNATURE-----

--QuMAt+cWIHQmpruC--
