Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FF96B2CB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCISLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCISLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:11:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EF3E8CF8;
        Thu,  9 Mar 2023 10:11:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3EF7FCE235E;
        Thu,  9 Mar 2023 18:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184F5C433D2;
        Thu,  9 Mar 2023 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678385503;
        bh=N6Wj3AQY5fxCb5ci7bzQ52zTXB3Nk+OsjegljZXqjpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRS4L/VR71sl4K8yevfuM0ECGp9XVDoFrcir8SSeH5FHo0z+6WWcTlBJiw9a/Tljh
         TEj8Lou6Bi9L1VRLZK6MVxEVno1MV1rR0vcNHrMvBJeeHJMNZuf3Q4Va5gVTTC6fUa
         hQgD61WU2VjKA726UIjFqRRisnwPM/Bf8eKhL6Gcc1jLACbQp4RWFVXj30902L34FX
         trN+WOR5hMBvdbYgWFZj31extQgavPplIP0zaf7dNEUMWDbbxG3wmhgsZ8wRIUVHIK
         9BfWG4TUPrcHEMhqS+fDg6csHSpZe2xtkHJBtKlEOeOg34c45ap7kcNNNmr5hIoPox
         bDv7I6E0L1icw==
Date:   Thu, 9 Mar 2023 18:11:37 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Hal Feng <hal.feng@starfivetech.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
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
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/19] clk: starfive: Add StarFive JH7110 always-on
 clock driver
Message-ID: <032f9254-482a-4b97-8e7e-4afb1f78eb21@spud>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-13-hal.feng@starfivetech.com>
 <CAJM55Z8H4qmy_BiD0SHW-w5ifzhzokdO-QxpUUz9aeUd+htrZg@mail.gmail.com>
 <8c30220a-abef-7518-cb44-abcea91408e2@starfivetech.com>
 <49ab1072-98ba-f364-9b66-68658566e732@starfivetech.com>
 <CAJM55Z9YGjD+1haWcXEZNkHnWNRZckdBmTTykTt7QZV_LUohgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BsPusMLI7B8oDAmr"
Content-Disposition: inline
In-Reply-To: <CAJM55Z9YGjD+1haWcXEZNkHnWNRZckdBmTTykTt7QZV_LUohgQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BsPusMLI7B8oDAmr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 03:06:13PM +0100, Emil Renner Berthing wrote:
>  On Thu, 9 Mar 2023 at 10:44, Hal Feng <hal.feng@starfivetech.com> wrote:

> > The AON clock driver provides clocks for gmac0 which is used frequently.
> > So I think it would be more convenient if we set "default y" here.

> You're right that if we default y for the ethernet driver then the aon
> clock/reset should also default y. Personally I don't think we should
> default y for every ethernet driver that might be used on some
> supported risc-v platform, but I see now that
> arch/riscv/config/defconfig already contains CONFIG_MACB=3Dy,
> CONFIG_E1000E=3Dy, CONFIG_R8169=3Dy and CONFIG_MICROSEMI_PHY=3Dy, so maybe
> I'm wrong or just too late.

The defconfig really needs a good bit of cleanup (one of the many things
that I am telling myself I will do as part of kconfig.socs cleanup).

w.r.t defconfig Palmer said it pretty well earlier on IRC: "defconfig
should be useful for kernel devs, which means it should boot on the
common dev boards".

IMO, that means enough to boot an initramfs and poke the thing to see
that it is alive, so: ethernet & serial, and the clocks/resets/pinctrl
stuff required to get those going can all be set to y in defconfig.

In the driver Kconfig entries, to me, it's more or less the same.
I guess, answer the question "Will your customer's board get to the
point where it can load a module ithout building this into the kernel?".
If the answer to that question is yes, then don't make it default y.

That's my =E2=82=AC0.02!

--BsPusMLI7B8oDAmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAohWQAKCRB4tDGHoIJi
0v/JAP94ulofNy+GppyQaKtW1Xy2+zpJyXSF00negiy+E6OD1AEA5XbUBFuifxqA
NFwySuVpSd4k8Gw3ygG1xTBXYFvBsAg=
=EJc4
-----END PGP SIGNATURE-----

--BsPusMLI7B8oDAmr--
