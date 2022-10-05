Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24C95F4D2E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 02:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJEAsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 20:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJEAsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 20:48:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BBC67CBE;
        Tue,  4 Oct 2022 17:48:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhwtM2WYfz4x1D;
        Wed,  5 Oct 2022 11:48:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664930924;
        bh=xadJLZowUNykSxMfzGuYiKAkknwm+uxebc9gBL+u634=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FZtV0W23ViuBa13OO1zh4+P30HXC3g41kRC5YRJIqcwSwiZRgZGPbP0z4lGLCih5j
         21i2pIDflHC0OjgMn1A92PiQ21ikhWCWO/PStFM4RkdoaVUuk8jzLluHtJzdyihJ1s
         OPrfwumwyx4oZphThzJJDRnByQ4ETnMuKjTKIvbl+mrw60x1OmwZ9uIRAAfU2VDV+3
         Eo5TjA0nF8po8V7DjjFyRHJw/4KtXYcjqcBT54BMVZ3pGAFJquoN6yu/44X0t90oAn
         yxPQzbzqGfZHB5FtdDbhet/GtiNFVRu4feWlkPjxq1TtGhI0IKdmeiEEkUWiHC4gSq
         fteVrojMXDp/A==
Date:   Wed, 5 Oct 2022 11:48:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: build warnings after merge of the broadcom tree
Message-ID: <20221005114841.4540d325@canb.auug.org.au>
In-Reply-To: <20220831091654.45d5ed41@canb.auug.org.au>
References: <20220725095913.31e859ec@canb.auug.org.au>
        <df8f4765-a804-cb50-bbb5-475925ba2036@milecki.pl>
        <20220815105419.4df1005b@canb.auug.org.au>
        <20220831091654.45d5ed41@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_nWp+i_1NAS4S_vEdqbZ0bT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_nWp+i_1NAS4S_vEdqbZ0bT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 31 Aug 2022 09:16:54 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> On Mon, 15 Aug 2022 10:54:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Mon, 25 Jul 2022 12:33:48 +0200 Rafa=C5=82 Mi=C5=82ecki <rafal@milec=
ki.pl> wrote: =20
> > >
> > > On 25.07.2022 01:59, Stephen Rothwell wrote:   =20
> > > > After merging the broadcom tree, today's linux-next build (arm
> > > > multi_v7_defconfig) produced these warnings:
> > > >=20
> > > > arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge):=
 /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
> > > > arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge):=
 /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
> > > > arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge):=
 /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge) =
    =20
> > >=20
> > > This is expected. My commit ef126d3f58d25 ("ARM: dts: BCM5301X: Add
> > > basic PCI controller properties") reduced following warnings:
> > >=20
> > > arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'devi=
ce_type' is a required property
> > >          From schema: /lib/python3.9/site-packages/dtschema/schemas/p=
ci/pci-bus.yaml
> > > arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'rang=
es' is a required property
> > >          From schema: /lib/python3.9/site-packages/dtschema/schemas/p=
ci/pci-bus.yaml
> > > arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: '#add=
ress-cells' is a required property
> > >          From schema: /lib/python3.9/site-packages/dtschema/schemas/p=
ci/pci-bus.yaml
> > > arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: '#siz=
e-cells' is a required property
> > >          From schema: /lib/python3.9/site-packages/dtschema/schemas/p=
ci/pci-bus.yaml
> > >=20
> > >=20
> > > down to this one:
> > >=20
> > > arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'rang=
es' is a required property
> > >          From schema: /lib/python3.9/site-packages/dtschema/schemas/p=
ci/pci-bus.yaml
> > >=20
> > >=20
> > > and basically does the right thing (adds required properties).
> > >=20
> > >=20
> > > I'm fully aware "ranges" need to be added (it's mentioned in the comm=
it)
> > > and it's one of next things on my BCM5301X list.
> > >=20
> > > So while my commits triggers that problem it also reduces warnings so
> > > I'd say it's acceptable. =20
>=20
> Not from my point of view:  I was not getting any warnings and now I am
> getting 254 lines of warnings :-(
>  =20
> > So, is something being done about these introduced warnings? =20
>=20
> I am still seeing these warnings.
>=20
> The above commit is now
>=20
>   61dc1e3850a6 ("ARM: dts: BCM5301X: Add basic PCI controller properties")

Has any progress been made with this?  This commit is now in the
arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/_nWp+i_1NAS4S_vEdqbZ0bT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM81GkACgkQAVBC80lX
0GxAHgf/fpyDOMuQjU0U1kK6TTF4Fn3ZwtPJe0JAzWw0SURwH3zZsxCKlbp3so34
ydPrzaX6FB5lFkvpuzQZ6PTe5df/dHc7iep81VQ4tIx+D+2AS7GtcDWSloXM//UE
2w50c6IBAMPshczMORuCxkqHseKEei4/6YUr5krJk0Hpfth/CbunnQdSfa5wHRd8
XpBycOv17XExJeoZbmSXHgVXU4V2MNWh6WpGmd0Nn679NaJd54R/ygspiYQ4k2Ag
HkjrryuXtaw5xl3Bvk0gvybcRkQ10SeYqvJlEG+jk0B5PmhKaNkYCIuXYBpy9tYI
8Ex7jc65JB+uDUxPEiw0YenyyRSsoQ==
=yxJY
-----END PGP SIGNATURE-----

--Sig_/_nWp+i_1NAS4S_vEdqbZ0bT--
