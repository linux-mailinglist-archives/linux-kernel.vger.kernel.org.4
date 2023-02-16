Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627A9699BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjBPSBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBPSBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:01:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3494B37737;
        Thu, 16 Feb 2023 10:01:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A98556206A;
        Thu, 16 Feb 2023 18:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C3AC433A0;
        Thu, 16 Feb 2023 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676570489;
        bh=SzjWMharL5BVkMeITsO0QpFnp+xa7N7JpLQmTdJjQvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOyk6NcFlRjqOvc6teiOBsWYFMj1Z/x9mQypLNRlwYamJ2+25VbmwtVSyzZZXklIa
         1XJSU7zsCinkDvmcod8XhNdSE35L807Viv2mmcGb0QBnOYtj4ohg1sogZtOkAI+HVn
         /3h654Q5dawnRVZVJUbeUMFdcgMLXvb/lJvXl2MxIFTGX/e5Lq2u2KxddSBHnxAmAV
         3r201OvTDzKJEC8M+aJ+OyNcjZZ/Qtn+7ghHxo0Np3LlkmV5UnSQOzs+nfNNqrDXaT
         Jfr3/3pqYWOs9ZO/oJFGaiVTR+PKawMQ19qY411QUbDq/ADEyWZ2opb20JXM8l4GH8
         neL4hkUaWMkMw==
Date:   Thu, 16 Feb 2023 18:01:23 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: Re: [PATCH v2 0/7] MODULE_LICENSE removals, first tranche
Message-ID: <Y+5vczghnTF5nUut@spud>
References: <20230216152410.4312-1-nick.alcock@oracle.com>
 <20230216174333.GA3313434@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a5mFg0TScSQyp1V2"
Content-Disposition: inline
In-Reply-To: <20230216174333.GA3313434@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a5mFg0TScSQyp1V2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 11:43:33AM -0600, Bjorn Helgaas wrote:
> [+cc PCI folks, who got the patches but not this cover letter, and
> participants from the v1 posting]

Thanks Bjorn..

> On Thu, Feb 16, 2023 at 03:24:03PM +0000, Nick Alcock wrote:
> > This series, based on current modules-next, is part of a treewide clean=
up
> > suggested by Luis Chamberlain, to remove the LICENSE_MODULE usage from
> > files/objects that are not tristate.  Due to recent changes to kbuild, =
these
> > uses are now problematic.  See the commit logs for more details.
> >=20
> > (The commit log prefixes and Cc lists are automatically determined using
> > the script mentioned below.  I've eyeballed them, and they seem reasona=
ble:
> > my apologies if they are not.)
> >=20
> > This is a small initial tranche to see if the general approach is valid:
> > larger tranches can follow if desired and if these patches seem OK.
> > I'll be sending a second 24-patch tranche in a few hours if this
> > one meets with general approval.
> >=20
> > (In total, there are 121 patches in this series.)
> >=20
> >=20
> > Differences from v1:
> >  - just remove MODULE_LICENSE, don't comment it out
> >  - Cc: paid maintainers as well as unpaid ones
> >  - improvements to the prefix determination code (notable in
> >    PCI: versatile in particular)
> >=20
> > The series at a whole can be found here:
> >   https://github.com/nickalcock/linux module-license
> >=20
> > The patch splitter (not for upstreaming!) used to prepare these
> > commits can be found here:
> >   https://github.com/nickalcock/linux mass-split
> >=20
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: linux-modules@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> >=20
> > Nick Alcock (7):
> >   kbuild, PCI: versatile: remove MODULE_LICENSE in non-modules
> >   kbuild, PCI: mobiveil: remove MODULE_LICENSE in non-modules
> >   kbuild, PCI: tegra: remove MODULE_LICENSE in non-modules
> >   kbuild, PCI: endpoint: remove MODULE_LICENSE in non-modules
> >   kbuild, PCI: hip: remove MODULE_LICENSE in non-modules
> >   kbuild, shpchp: remove MODULE_LICENSE in non-modules
> >   kbuild, PCI: dwc: remove MODULE_LICENSE in non-modules
> >=20
> >  drivers/pci/controller/dwc/pcie-histb.c              | 1 -
> >  drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c | 1 -
> >  drivers/pci/controller/pci-tegra.c                   | 1 -
> >  drivers/pci/controller/pci-versatile.c               | 1 -
> >  drivers/pci/controller/pcie-hisi-error.c             | 1 -
> >  drivers/pci/endpoint/pci-ep-cfs.c                    | 1 -
> >  drivers/pci/endpoint/pci-epc-core.c                  | 1 -
> >  drivers/pci/endpoint/pci-epc-mem.c                   | 1 -
> >  drivers/pci/endpoint/pci-epf-core.c                  | 1 -
> >  drivers/pci/hotplug/shpchp_core.c                    | 1 -
> >  10 files changed, 10 deletions(-)
>=20
> I squashed these and applied to pci/kbuild for v6.3, thanks!
>=20
> I added examples from the v1 posting to the commit log; let me know if
> I got anything wrong:

I noticed that (as requested!) Nick dropped the change to the microchip
driver.
Would you like me to resend patch 3/11 of [1] to clear the decks of
"incorrect" MODULE_LICENSE usage?

Thanks,
Conor.

1 - https://lore.kernel.org/linux-pci/20230111125323.1911373-4-daire.mcnama=
ra@microchip.com/

--a5mFg0TScSQyp1V2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+5vXwAKCRB4tDGHoIJi
0vAXAP9wqH8kAZKEp4gF7i5IvSwidaBjokwtxIxYEfYUq2wFjgD+KmMseKK3OoCk
1VsDBH0Q+s4Ok7vTRdd4Vj1l4ZFj1Qo=
=nNB3
-----END PGP SIGNATURE-----

--a5mFg0TScSQyp1V2--
