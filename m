Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5736979C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjBOKWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjBOKWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:22:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22893346D;
        Wed, 15 Feb 2023 02:22:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C5CEB81F81;
        Wed, 15 Feb 2023 10:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057BBC433EF;
        Wed, 15 Feb 2023 10:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676456554;
        bh=CZtjdlZHpemY/bmUXegAh65vvUy+GqQ4slAml0d/DVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eeDLCPzo4K9ri9suTobgjrJ3hd5X79inzJX4asmWpkGxPP+7GpzhAX700eFER6Tk2
         OWP0bVNMWuNAdGAhZUN/evb8VfByeF5IcvfGRjw5yyYuTol/IvxmjW3vvuvp88Pnwq
         BGlYIC7lDpCvp9Ky4Y5ZlGBEDI74G8fdvmZjMxma/bFfdlc4mSFtGh5XH/OXStdIjt
         MAT01po3Z1DmNiKJdnNKDdm2ywURHHetmo+v6po09DAlPg7TBdIAdegVWiq8kXSsLA
         zWqUIlxk/T5xjFktdWZkp5zwM9VKsYGr+AXVq3rqg6Uim4aKh2xj4RJrsOg7Q+8VCJ
         kz7NNdJiFRJ7A==
Date:   Wed, 15 Feb 2023 10:22:29 +0000
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] StarFive's SDIO/eMMC driver support
Message-ID: <Y+yyZaBITDmEFUyB@spud>
References: <20230203081913.81968-1-william.qiu@starfivetech.com>
 <CAPDyKFqei-GjKpBUQnDZUbYnSyn-JS5f_EnTLOuA1U4PdYTyVA@mail.gmail.com>
 <CAJM55Z8gpBDu9818GPLRYJ9DBa+NfXW0uo76_bkwWm6RS1S9wg@mail.gmail.com>
 <3ee9b726-10db-5d05-b24a-010c8bf5b59d@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UvkJAdnlfiLhyd8H"
Content-Disposition: inline
In-Reply-To: <3ee9b726-10db-5d05-b24a-010c8bf5b59d@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UvkJAdnlfiLhyd8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2023 at 06:16:35PM +0800, William Qiu wrote:
>=20
>=20
> On 2023/2/15 18:00, Emil Renner Berthing wrote:
> > On Tue, 14 Feb 2023 at 13:21, Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> >>
> >> On Fri, 3 Feb 2023 at 09:19, William Qiu <william.qiu@starfivetech.com=
> wrote:
> >> >
> >> > Hi,
> >> >
> >> > This patchset adds initial rudimentary support for the StarFive
> >> > designware mobile storage host controller driver. And this driver wi=
ll
> >> > be used in StarFive's VisionFive 2 board. The main purpose of adding
> >> > this driver is to accommodate the ultra-high speed mode of eMMC.
> >> >
> >> > The last patch should be applied after the patchset [1]:
> >> > [1] https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@star=
fivetech.com/
> >> >
> >> > Changes since v2:
> >> > - Wraped commit message according to Linux coding style.
> >> > - Rephrased the description of the patches.
> >> > - Changed the description of syscon regsiter.
> >> > - Dropped redundant properties.
> >> >
> >> > The patch series is based on v6.1.
> >> >
> >> > William Qiu (3):
> >> >   dt-bindings: mmc: Add StarFive MMC module
> >> >   mmc: starfive: Add sdio/emmc driver support
> >> >   riscv: dts: starfive: Add mmc node
> >> >
> >> >  .../bindings/mmc/starfive,jh7110-mmc.yaml     |  77 ++++++++
> >> >  MAINTAINERS                                   |   6 +
> >> >  .../jh7110-starfive-visionfive-2.dtsi         |  23 +++
> >> >  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  37 ++++
> >> >  drivers/mmc/host/Kconfig                      |  10 +
> >> >  drivers/mmc/host/Makefile                     |   1 +
> >> >  drivers/mmc/host/dw_mmc-starfive.c            | 185 +++++++++++++++=
+++
> >> >  7 files changed, 339 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,j=
h7110-mmc.yaml
> >> >  create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
> >> >
> >>
> >> Patch 1 and patch 2 applied for next, thanks!
> >>
> >> Note that I fixed some checkpatch errors/warnings. Next time, please
> >> run ./scripts/checkpatch.pl before you submit your patches.
> >=20
> > Hi,
> >=20
> > Something here is not right. The bindings document "starfive,sysreg",
> > but the code is looking for "starfive,syscon".
> > William, did you test this and run dtbs_check before sending this serie=
s?
> >=20
> > /Emil
>=20
> Hi Emil,
>=20
> Sorry about that, it's my negligence that I did dtbs_check without

dtbs_check would be okay though, no? The binding and dts (from checking
with eyeballs!) are consistent & it is just the driver that is looking
for the wrong property name, no?

> checking the configuration of CONFIG_SOC_STARFIVE. I made a modification=
=20
> in the next version and add binding for all the syscon at the same time. =
Next
> time I'll make sure the check is correct.I'm sorry again for this oversig=
ht.
> I'll send v4 patch series today.

Ulf's subsystem & his rules, but I would just send a follow-on patch
fixing the driver to use the property that is in the dt-binding.

Sorta unrelated, but please remind me about the dts patch once the base
dts is merged. It's still in the RISC-V patchwork so *should* be fine,
but in case the base dts takes a while it may get automatically
archived.

Thanks,
Conor.


--UvkJAdnlfiLhyd8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+yyZQAKCRB4tDGHoIJi
0qUcAP92thHyY+JVbUzE+IDz7yRfLo/nradx86cQ1UK9LspcsQEAsYL++31GQKhE
XYviEZdxkDnknLoYmV07qJaxdO+bnAI=
=2MVB
-----END PGP SIGNATURE-----

--UvkJAdnlfiLhyd8H--
