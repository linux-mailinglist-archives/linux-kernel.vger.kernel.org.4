Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2726B098C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjCHNjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjCHNiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:38:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC92515DF;
        Wed,  8 Mar 2023 05:37:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE588B81CB5;
        Wed,  8 Mar 2023 13:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0E1C433D2;
        Wed,  8 Mar 2023 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678282607;
        bh=OWt+d3tO5ov32xGG5qMASavRsXPbCxmg5AnjKjZWCQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1+WSDpglc0KQHoGoeALrFnjtOEecp+1lZU/z1//Lcn5pU0D11ODzFYixZPHhO4s3
         9wkMK/yg4dvTxbqvX2lyP8pLm/7d9PbjlWS13FReTUtQLlHwQYDUUuXs5Z4Gn17/uB
         0O6fSaBNA8q2o5lFGKU8vsB0a/VzPd4EIW4Zv5HHzVRZEneGCCnR+k5ViVqS4ncGTx
         V7dQtFyJcQw7DGz+7AdTpqJRdYEnwZ34J0WliqDc18fD8FOcBJMc9YyYXqvdnos0P2
         ckAZaJMejCTT9jcTozelYzYnUmu8FKNsI5/jeP8+Ep/toXkl7Bhl00bhYQVKY5fjQD
         HyBkHk7ruAvDA==
Date:   Wed, 8 Mar 2023 13:36:41 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Hal Feng <hal.feng@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
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
Subject: Re: [PATCH v4 00/19] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Message-ID: <4c071642-e3c8-4716-a580-5b42e25efb1c@spud>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <3a605bc8-104e-0935-4fd8-2da16ab9053b@starfivetech.com>
 <ZAb7JVghuiwZF1Q5@wendy>
 <2f03dfb2-5cf8-e954-913c-f0c27db6bcf5@starfivetech.com>
 <ZAh/UeSlUeGoKxki@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1Q9Amaw99NjcnKrY"
Content-Disposition: inline
In-Reply-To: <ZAh/UeSlUeGoKxki@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1Q9Amaw99NjcnKrY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2023 at 01:28:01PM +0100, Tommaso Merciai wrote:
> On Tue, Mar 07, 2023 at 06:08:53PM +0800, Hal Feng wrote:

> > The above two methods can fix the problem. Here are my test results.
> > The VisionFive board can boot up successfully if and only if all above
> > two applied.
> > The VisionFive 2 board can boot up successfully if I merge Linus's new
> > changes.
>=20
> Tested also on my side. Hope this can be helpfull.
>=20
> > Hope your fix will be merged in rc2. Thank you for your reply.
>=20
> Fully agree.

If you only have a VisionFive 2, it shouldn't matter to you, as you
don't need to fix up any SiFive errata (at the moment at least).
Linus' fix is already in his tree, so should be in -rc2!
The fix for the VisionFive was applied to Palmer's RISC-V fixes tree
last night:
https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=
=3Dfixes&id=3Dbf89b7ee52af5a5944fa3539e86089f72475055b

Thanks,
Conor.

--1Q9Amaw99NjcnKrY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAiPVwAKCRB4tDGHoIJi
0jkLAQDPFRsrm3jV2o7oZA41VzOVHxBFtUn0CPkVOzvVlHguFwD/eEMsCXuhUN65
gD5cpKcLgiGCltbgB7imErj+jrsFrQg=
=11W4
-----END PGP SIGNATURE-----

--1Q9Amaw99NjcnKrY--
