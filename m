Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B7B6A5E99
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjB1SGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB1SGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:06:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C57922A3B;
        Tue, 28 Feb 2023 10:06:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2819610A1;
        Tue, 28 Feb 2023 18:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A322C433EF;
        Tue, 28 Feb 2023 18:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677607603;
        bh=2rrPrh+K63elL1eQoqGcoJYDst8N+5jDNSgkcC6esto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbDhW8EsytBpqdpPdVqId3xBtB6/7iUHA3cNPJC9ladfQXz8e5KHXmIdKSYxhFloj
         mIAmRTnv+EFW8KNAUUTA0O88Z2fN9rVkIBKLUFgyRWdJSQMkFCSUeo4NL14XX/3Wmb
         7PlV+IpqYwxqX8GfHP7G4DQ+ZDP5Xr2+fgrbZm1iNcnT/3JZSpbaA+UdnpGrgR/vnq
         pR7JZZRm2N/4AV3WpJEt+VVyzEdIvHBhU7pZ3ul2apuStiU2xqGngGFMRD7Ke247mK
         maf1iPqHTOg8iJIgcen3M89SFzvPBSUZgz554zYusOYOaEPZKeWLa4vkhSOtHkSFK3
         eoQM0TSwIk9lg==
Date:   Tue, 28 Feb 2023 18:06:38 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
Message-ID: <Y/5Crl+76wcviHKo@spud>
References: <20230220234335.GA615198-robh@kernel.org>
 <348796cc-72d9-4dcf-9f09-4c2aa55cb858@starfivetech.com>
 <20230227222904.GC1048218-robh@kernel.org>
 <f8d2b665-ce5d-81f8-8c55-81f1a4cb62b9@starfivetech.com>
 <54f51fa0-7821-b67b-b782-eb9a35b7bba9@linaro.org>
 <CAJM55Z85fitjBOcCLqad9W-a7h3iN9bxtctVGzPgqCbf5fWobw@mail.gmail.com>
 <a0168d89-3c30-55e1-cf4c-37f7fe90aae4@linaro.org>
 <CAJM55Z8dR4TDJNeO-qiS9CurfCWM1ccNigOA1fDb7S1VKCxv2Q@mail.gmail.com>
 <be911895-4944-e983-1af5-b11ff5e8e7cc@linaro.org>
 <CAJM55Z99FZteGkzFC-cSCrTKD_qBn8huzcnynM9Xd7-4F_9rGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgGewJrsqlCKMN24"
Content-Disposition: inline
In-Reply-To: <CAJM55Z99FZteGkzFC-cSCrTKD_qBn8huzcnynM9Xd7-4F_9rGQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgGewJrsqlCKMN24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 06:31:46PM +0100, Emil Renner Berthing wrote:
> On Tue, 28 Feb 2023 at 17:59, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 28/02/2023 15:59, Emil Renner Berthing wrote:
> > > On Tue, 28 Feb 2023 at 12:28, Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:

> > > I see what you mean, but if you look into what the registers in the
> > > SYSCON blocks actually do it's not clear to me that they should be
> > > grouped with the clocks/resets any more than say the pinctrl/GPIO
> > > node. Maybe it's my fault for not giving you the full picture. Eg. for
> > > "system" and "always-on" there are blocks:
> > >
> > > SYS CRG
> > > SYS SYSCON
> > > SYS IOMUX
> > > AON CRG
> > > AON SYSCON
> > > AON IOMUX
> > >
> > > ..and it really don't see why eg. SYS CRG and SYS SYSCON should be
> > > thought of as one device, but not include SYS IOMUX then.
> >
> > ... include sys iomux as well, just like GPIO is included for AON.
>=20
> This would at least take the view that the blocks named alike should
> be thought of as a single device to its logical conclusion.
> Unfortunately we're a bit late for that. The pinctrl/GPiO bindings and
> drivers are already merged:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dd6e0a660097dcdb80e7c5c859eb12f776060b02e
>=20
> > >
> > > As an examly the SYS SYSCON includes registers to control:
> > > - remapping of different peripherals from SD controller to video enco=
ders
> > > - voltage select for certain GPIO pins
> > > - phy interface selection for ethernet and CAN
> > > - QuadSPI delay chain and SRAM configuration
> > > - PLL configuration
> > > - endian selection for the SD controller
> > >
> > > To me this is pretty much exactly described by the syscon device tree=
 binding:
> > > "System controller node represents a register region containing a set
> > > of miscellaneous registers. The registers are not cohesive enough to
> > > represent as any specific type of device. [..]"
> > > In any case it's clear that however the SYSCON blocks are represented
> > > in the device tree, a driver for it would need to export registers in
> > > the SYSCON block for other drivers to use.
> >
> > You started entire sentence with "but" so you disagree but with what
> > exactly? The naming? But syscon is fine - hardware manual calls it like
> > that.
> >
> > The point was that AON is one device (consisting of multiple blocks).
>=20
> Yes, and what I'm trying to explain is that I'm not convinced that's
> the right model. The CRG blocks and IOMUX blocks don't really have
> anything in common other than the name StarFive gave them. You can
> argue that the CRG and IOMUX blocks overlap with the corresponding
> SYSCON block, but so do a lot of other peripherals as you can see from
> the list above.
>=20
> I think the IOMUX and SYSCON blocks are just named after the clock
> domain they're under, but a lot of other peripherals are also under
> the SYS and AON clock domains and we don't model them as one big
> device.

I went and bothered Rob/Krzysztof on IRC about this.
Not gonna speak for them, but I think they're now okay with keeping the
SYS_CRG (clock+reset block) separate from the SYS_SYSCON block ("random
collection of registers"). Possibly there was just confusion due to the
naming used here, thinking that "SYS", "STG" and "AON" were devices with
two register blocks, as opposed to being the name of a clock/power domain
on the SoC.

I'll leave it up to them to confirm that though!

Cheers,
Conor.


--OgGewJrsqlCKMN24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/5CrgAKCRB4tDGHoIJi
0pKjAQDTeT+TZc/EBmewPaKfdSLP7DCjgM+V1bTyEZ6/CVuCUAD+M46W4w/Jg86q
jFnVxeqFklXmTiTe/VWnQwOzTfrw1ws=
=adFT
-----END PGP SIGNATURE-----

--OgGewJrsqlCKMN24--
