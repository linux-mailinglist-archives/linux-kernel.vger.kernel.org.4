Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E1660CF0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 09:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjAGIN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 03:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjAGIN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 03:13:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF69B840BD;
        Sat,  7 Jan 2023 00:13:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NptJc2Rqzz4xxJ;
        Sat,  7 Jan 2023 19:13:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673079233;
        bh=INp7h11ApBNNIpcU5O7lBDeC8Cm27wzbBsdKK1Bm4cc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QzEIWZ8VPTHWJcqKn85S08QiYyVc6Ncpf6qzCFmYfn+gqgAz0l1agUr8jxPvx1hCV
         Y9AQUNXKbLbdMutOt+n7D4Mwjj2s+9RqCLbXK572r/5kAZU20e84Adzmn1xSvuXbgF
         rKefRsCmexz0ysal63XwirLO/VWWEd1FOUqk+2QS7SrsqcqOnHKWlRkht+6Htu8qT+
         cg9HOtGxbw5GvSVUH+D1UiJ1g+3XyDuTh0euZgnn1UPlsMKD7cqtU7Mvq6lp9bKfV/
         xBs/5gev0TZLEhmGqy8/iSGpHCf+zUam3rKXcuQBudSxXY6xIgaKC9c/tI7LmDnM6C
         GZCs2xCEoBvNw==
Date:   Sat, 7 Jan 2023 19:13:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] SCSI fixes for 6.1-rc2
Message-ID: <20230107191331.57ccf298@canb.auug.org.au>
In-Reply-To: <20230107182826.1ae7b32c@canb.auug.org.au>
References: <f0bc7090c04bc6c0b08471494324a3a577c2d2a1.camel@HansenPartnership.com>
        <20230107182826.1ae7b32c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9tsCmtXOeBNO0j8bRxAkmBI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9tsCmtXOeBNO0j8bRxAkmBI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, 7 Jan 2023 18:28:26 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi James,
>=20
> On Fri, 06 Jan 2023 22:37:10 -0500 James Bottomley <James.Bottomley@Hanse=
nPartnership.com> wrote:
> >
> > Lukas Bulwahn (1):
> >       scsi: core: Remove leftovers due to pktcdvd being removed =20
>=20
> I thought that this one was to be removed as the pktcdvd drivers
> removal is being reverted in the block tree in linux-next (and the
> revert caused a build failure in linux-next due to this scsi commit).

And I see that driver revert is now in Linus' tree ...

--=20
Cheers,
Stephen Rothwell

--Sig_/9tsCmtXOeBNO0j8bRxAkmBI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO5KasACgkQAVBC80lX
0Gywnwf+PNYhvHNw48IOuDXMqVgDhSKWm9obi1vk+48sGZKVAN2Fz7HnoyPcbzoa
sHR5ZUi50E1jDQnzudcy2iCLfvqvQgYFzr2U5sBjm9tGJuJPBfcmshcRvzE8Azlh
eZoLX7xX2B6O2rX0RvRnVP7g5PMX1fxccWOeLA4uWwAvCurMFmYfHW77x0ejSbWW
Ci2WLKmebY2g1fJ2A82fXyvrKubLpkS0yWTng9Nrx3QOypDbnBPSyaICbb+dDQLO
gwkyHOxUTB1ydCtS8o63qCUAWW6+2yEZCG+AkoGmyiTNFai5bj/jkS6GSkFLP6Y9
YyC+IUkhm1XsxyhKP9EIluMcd33i6w==
=7n6P
-----END PGP SIGNATURE-----

--Sig_/9tsCmtXOeBNO0j8bRxAkmBI--
