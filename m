Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD269A27A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 00:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjBPXid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 18:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBPXib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:38:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABBE50358;
        Thu, 16 Feb 2023 15:38:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2432611A9;
        Thu, 16 Feb 2023 23:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CB3C4339C;
        Thu, 16 Feb 2023 23:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676590709;
        bh=jVUoz8hTKqk5/k7Dxb/+B4XO7xlnmBaryxiFTIp1qEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLHohTEQPjGNatQu1M1UM62ut4M2goLfnKgdGSWYZB9mDi0moGaGYFV2DpK4frfEg
         BCIcds6sD9kLm5YteQ8ehDCB0WHN6+MxB7nfc6Yn4wBiJm7pfW2nMSgnTg1PbPiI/N
         yIfIYbYyQG97L2X8eDR/t6ssUZ8DOiRVT9JDeVNFioXiDXG6Gwfbao77kaLrmcL3nd
         jL6qzzekyD07HlQ1QsmANrlmWFJlnlRtT7IVA4CUGKi9OT21YJoGiUJr3w9NhBAlGr
         KQACbGPe1Sz+cc8MsjdrZEihsJRo0Y+3riW/iZwD2+AwQuRHyuG67A2MDwBfT94u4i
         CvX18s7LsIjvg==
Date:   Thu, 16 Feb 2023 23:38:23 +0000
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
Message-ID: <Y+6+bwLqqCsgwjjX@spud>
References: <Y+5vczghnTF5nUut@spud>
 <20230216191632.GA3325180@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cVG82M06RkxZIBEi"
Content-Disposition: inline
In-Reply-To: <20230216191632.GA3325180@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cVG82M06RkxZIBEi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 01:16:32PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 16, 2023 at 06:01:23PM +0000, Conor Dooley wrote:
> > On Thu, Feb 16, 2023 at 11:43:33AM -0600, Bjorn Helgaas wrote:
>=20
> > ...
> > I noticed that (as requested!) Nick dropped the change to the microchip
> > driver.
> > Would you like me to resend patch 3/11 of [1] to clear the decks of
> > "incorrect" MODULE_LICENSE usage?
>=20
> Thanks for noticing that.  I removed MODULE_LICENSE from
> pcie-microchip-host.c for now.  We can easily add it back when [1] is
> merged.
>=20
> I haven't talked to Lorenzo about the series [1] is part of, but just
> from the mailing list traffic, it looks like there are a couple open
> questions (MSI config probing [2], "ranges" and address translation
> stuff [3,4]), so that will likely miss this merge window.

Yah, I know the series itself is going to miss the mw, which is why I
mentioned resending 3/11 specifically. It's grand though, will just have
to add the license back when the series gets respun.

> > 1 - https://lore.kernel.org/linux-pci/20230111125323.1911373-4-daire.mc=
namara@microchip.com/
>=20
> [2] https://lore.kernel.org/r/Y9uiWscjKQpD7JvE@lpieralisi
> [3] https://lore.kernel.org/r/Y9uebWEvuJYO31j1@lpieralisi
> [4] https://lore.kernel.org/r/8dfc14be-a978-d84b-52e4-d421599fc783@arm.com

--cVG82M06RkxZIBEi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+6+bwAKCRB4tDGHoIJi
0tZmAQComWSerbIi81ZZzLrEqxzrF83yEBkSIlcd908CoX6wAQEAkpZ3G/oM7Ps1
7wGotiMYdvlClrmYv8gG0AAAVWBtOQY=
=XdlY
-----END PGP SIGNATURE-----

--cVG82M06RkxZIBEi--
