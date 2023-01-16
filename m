Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2750366B661
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjAPDqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjAPDpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:45:17 -0500
X-Greylist: delayed 643 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Jan 2023 19:43:53 PST
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA35A257;
        Sun, 15 Jan 2023 19:43:53 -0800 (PST)
Received: by air.basealt.ru (Postfix, from userid 490)
        id 7442A2F20227; Mon, 16 Jan 2023 03:23:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
Received: from localhost (broadband-188-32-10-232.ip.moscow.rt.ru [188.32.10.232])
        by air.basealt.ru (Postfix) with ESMTPSA id 4228C2F20226;
        Mon, 16 Jan 2023 03:23:55 +0000 (UTC)
Date:   Mon, 16 Jan 2023 06:23:55 +0300
From:   "Alexey V. Vissarionov" <gremlin@altlinux.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Alexey V. Vissarionov" <gremlin@altlinux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the pci tree
Message-ID: <20230116032354.GA8107@altlinux.org>
References: <20230116081425.43ff9e39@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20230116081425.43ff9e39@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-01-16 08:14:25 +1100, Stephen Rothwell wrote:
 > In commit
 > 58d4c63d0a27 ("PCI/IOV: Enlarge virtfn sysfs name buffer")
 > Fixes tag
 > Fixes: dd7cc44d0 ("PCI: add SR-IOV API for Physical Function driver")
 > has these problem(s):
 > - SHA1 should be at least 12 digits long

Full SHA1 is dd7cc44d0bcec5e9c42fe52e88dc254ae62eac8d
First 12 digits would obviously be dd7cc44d0bce


--=20
Alexey V. Vissarionov
gremlin =F0=F2=E9 altlinux =F4=FE=EB org; +vii-cmiii-ccxxix-lxxix-xlii
GPG: 0D92F19E1C0DC36E27F61A29CD17E2B43D879005 @ hkp://keys.gnupg.net

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJjxMNKAAoJEFv2F9znRj5Kn88P/jelyECGQOvg8aUTlUA5BOZv
1FsMQwIETjuSf444zZ5zEv3eX0VozqDFSJIis2+RMcL1Kx6HV6v6gia1+RX5nhzG
sF9BE2qX0yxuBgpDFZ0h3wzfWDEFZiPvtUWwrwr8C76h8NccC9MY/gkXCN/KrFJ+
XlQ8FnYxXDLgS8Ii6cPBXxUq3fZteAUxsR8m/sYMm78/NY1O9DBqLJOwRHS2iFIF
RY2bk3kLKsJpjpNiUmT4OG4n7wLRcHzzGSj2785NtJwTJnzydI8kYVfcMoM9EeJL
9+TJONb1X7JHu0gctRpYnS4vFUtZGJl8/zv9sWee3WoEiFCiph+wG/J2o4VqGDDX
dnH9fbb/llSf+sOeCZ2k88bZZUiCvMbzRvJeYkrrAPDtF87BmS4Xo1hQUJSlT0nX
CRuivqXHTqmWHEpW+2OfvPqjeczHBYNAm+vjP52+/8BEuoqmnDgL3Wd4mn4reKxe
lhqIxa/NNFqAMIJcBw6DzmBj4zegNBeBVMIF0pxtO4CTYk/afhUbBOH/jxCEuWCy
XbRwww9JIs8VZOOa0K+nU1Rj8NzE0AKiw0nwecvoeXpAIYwUoP0SA/X64+WhPBXg
PmB0CMmUGJ7iWOagQrTNBp+iO4x7nO7l8KhfxZ5jMs4MN9K09La20toErc2xHceI
ZTbWit7ZyUb2h0iAet0G
=bYks
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
