Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E6274E1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGJXEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGJXEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:04:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9181A11D;
        Mon, 10 Jul 2023 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689030268;
        bh=dpPyTCvCNzCOS0I/wq9mgI37mF5FOhPHWJw+BqGKOic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hSGtaLbGqwyIlRZtWiS4+QY6D9VfSa/bgDs+I2Jfj+MeZoXqDjxNdqtumUu/O8KPX
         puF6zNRhBVhvxUJmXNsvrhkYjWJstoxDXxjOYVFHf8HrNkQ8CHUegrlNL/Ldix6LGO
         qVUybQ1XxzFtzkGLYeN2YgAqXmuQIpAVAifTf6/gfXvlj7k3BAsOhuF8S8YPwkZY4Y
         OXmbyrx1yYMKW2eZ+Vl55VwSbrrgWKeDSI3fIVvbh3fCdcHZannN9GJyFzLKZuh61H
         6fTduG+zBYGwZ3jp2sLqmpC/NhTGKx5ATWYj9H5ZEX8jUu2nDo7gonD3QYXELE0bod
         dCxiA+4Lc/SpA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R0KMJ2Pftz4wbP;
        Tue, 11 Jul 2023 09:04:28 +1000 (AEST)
Date:   Tue, 11 Jul 2023 09:04:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Leo Li <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: linux-next: branches to be removed
Message-ID: <20230711090427.27e07509@canb.auug.org.au>
In-Reply-To: <ccc0f8d4-3900-a766-7303-85e44bffd875@kernel.org>
References: <20230710172602.05d32c03@canb.auug.org.au>
        <ccc0f8d4-3900-a766-7303-85e44bffd875@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3vFqHq=aVl19w0aZkeK6IpR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3vFqHq=aVl19w0aZkeK6IpR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vineet,

On Mon, 10 Jul 2023 10:52:08 -0700 Vineet Gupta <vgupta@kernel.org> wrote:
>
> On 7/10/23 00:26, Stephen Rothwell wrote:
> >
> > Tree			Last commit date
> > ----			----------------
> > arc			2022-06-05 17:18:54 -0700
> >    git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git    for-=
next =20
>=20
> Would request to please keep arc next around even though upstream dev is =
slow'ish these days.
> I do have some patches for absolute near future as well.

I have added it back.

--=20
Cheers,
Stephen Rothwell

--Sig_/3vFqHq=aVl19w0aZkeK6IpR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSsjnsACgkQAVBC80lX
0Gwjjwf+JRALHHIzdiKIFJl5oIuw8MRM1/opTQ0dixMqTpErLdnO2pxz1r1/q/In
CDZGU87lhgbyLcVGEgdW7y3YcRgjonrraitnFADZmozUEqS3PHkP4OLEOWeYuqQv
aHxzCNLdCgA0nRewLV3ahkHK+zyeOg/OUmlLE3T83C1ETPlgowZDpj2HdfRdPP5/
YBSTQUi1y7wJeKyM1MKehHEU7xv9xi1Fzlt5iHlXrOsRIBFedo2/w7/CWTCgwSL0
4xHpyKKUV4W3/gVevjPDq2UTD2shbnjiBIhcxAECzXjpxNNKadSupYM/LpFr+g9N
nXKFTc3zGCuiyKNNYtrJL5fo4wHn+g==
=jgep
-----END PGP SIGNATURE-----

--Sig_/3vFqHq=aVl19w0aZkeK6IpR--
