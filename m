Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2C670D07
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjAQXPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAQXNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:13:44 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6B823D81;
        Tue, 17 Jan 2023 13:00:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NxLrX2sSnz4wgq;
        Wed, 18 Jan 2023 08:00:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673989228;
        bh=TvjsuWVe/jimLnnhv8ZPYbL1dSk2gO/J5KkKBSDGN44=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dRFN2+sIB4kHANZ2jz3f4qg4/PSICtmsEiH2340T8EQkW3vyGUfdJAmUuEzHbqMS8
         5w1mEfsD76faP5mPWD72INNBxFPkxFjISQIahA2xhu+CUdhDCV4ecMg7zNE9taFlR/
         eix1vMR1NyI6CEwhWA9b9T7vlJPYUcuann7cGp/5eQmqSawxJkyx9mWevCRSAqtHB6
         o9yK3Y+aq4QuAuT20t9/yFweIJFwr35rJ6NBJ9M42oXVzT5zOwe54Y7Kr6lkofn5kV
         ABkzs6Y/eJfRrL952EDEGLKTWBuzdxUQRmygC/Fglhd1Ux9H8DbyWtGxtFZdkTAPrt
         IMqX1aqzchr8g==
Date:   Wed, 18 Jan 2023 08:00:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nfsd tree
Message-ID: <20230118080027.300ab7b5@canb.auug.org.au>
In-Reply-To: <C72F2CC7-EB89-44D4-AC4A-C33EBED4B120@oracle.com>
References: <20230113101326.09b1250e@canb.auug.org.au>
        <53DEC27F-0AAC-4EFA-AB6E-0B5D44AACFB9@oracle.com>
        <F7CFC18D-6AAC-4DAD-AA43-5C718FC1100E@oracle.com>
        <20230117115228.13b55d07@canb.auug.org.au>
        <C72F2CC7-EB89-44D4-AC4A-C33EBED4B120@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z_gqi+wXmEB.PxIERkNeBOk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/z_gqi+wXmEB.PxIERkNeBOk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

On Tue, 17 Jan 2023 14:28:42 +0000 Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>
> > On Jan 16, 2023, at 7:52 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> >=20
> > Hi Chuck,
> >=20
> > On Mon, 16 Jan 2023 14:33:06 +0000 Chuck Lever III <chuck.lever@oracle.=
com> wrote: =20
> >>=20
> >> Sorry, I wasn't clear. I need nfsd's for-rc to be picked
> >> up and merged into linux-next before I send a PR.
> >>=20
> >> I've trimmed for-next to temporarily remove the duplicate
> >> commit, so you should now be able to continue merging both
> >> into linux-next without an issue. =20
> >=20
> > I am not sure what you mean.  Your for-rc branch has been in linux-next
> > for a long time and the current version (SHA 7c24fa225081) was merged
> > last Friday. =20
>=20
> My bad. I was looking in the wrong place.

No worries.

> > For clarity, the cel-fixes tree and the nfsd tree are both branches of
> > git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux - the for-rc
> > and for-next branches respectively.
> >=20
> > Maybe I should rename cel-fixes to be nfsd-fixes? =20
>=20
> Renaming my source branch as well would make things a little more clear.
>=20
> How about I name the branches in my repo nfsd-next and nfsd-fixes?

Yes, that sounds good.  Let me know when you have done that and I will
update my end.  In the mean time, I will rename the cel-fixes tree to
nfsd-fixes.

--=20
Cheers,
Stephen Rothwell

--Sig_/z_gqi+wXmEB.PxIERkNeBOk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPHDGsACgkQAVBC80lX
0GxDYwgAnWbXTN9CRsZalZ224Vx2jOxrPzmThkbNG9cQz8Lh5F9XaQ2gJ6Cj574P
K/xyfjwSi5Y0vfRIHKZ5iXGP8Iuoyj5WWQptZBWfwBm0oa5eKey/32nQD6je2V2X
ifYyZAP0DZPSGEMCKBJGDXXW9xxHn7F/HUgsZat//ij5mULt5BFH5bRff8u0Z2kP
p2yi9YQ6vyDAxFytdRyn1HXU1FKy8BQzJfYcTpPlOfr/CjBmk00Gd10YmbyU4ULH
K0l+k89t03NcYh5hTVfTw0tdurr9KwUf3NWS0GrqmKygfQMIAaZVjxRSM/MR7NFt
UU/XtT3LJHhEp2uiOOQ+iNgMEfzwXA==
=fMR/
-----END PGP SIGNATURE-----

--Sig_/z_gqi+wXmEB.PxIERkNeBOk--
