Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B80073F5A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjF0H1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjF0H1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:27:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E108F273F;
        Tue, 27 Jun 2023 00:26:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qqx933pw2z4wb6;
        Tue, 27 Jun 2023 17:26:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687850792;
        bh=n0kaDdU1G9s0eIw1MyosuyIup7SvCvW3CNugYT3+DRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EPgY9Ts+jGquAQEeh8kB3fOuUtnFd1XdMiBGYQfDKL4ZvzhAaT3QGq5VQtuHtlCiZ
         OkEAwdMf3wZHFGzDXxzRLDeJTZwRXdEYTB/Jm0+J2NEtYVFZyBc7U0D4jBZNMbNyhL
         gA2ya9q9uo8Kx9EBo5kkhxzL8WDZf++WXgLlsR43GpheEbDyetJ6aoPy3NhhqCgHAe
         RyTyfuuCOGw0rk9oM24r3Q4EhDEzdACAuWs5sr3ezpColSEEIAlbK6M4WufSOD/YDl
         mFWXKrq12pnd2G34cAQ8wGQ1gQrMO2y0OIRHbD6EMv0Ou4k22HrPTaWCc2T+KU62og
         JHpcqfFVyd0MA==
Date:   Tue, 27 Jun 2023 17:26:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the ext4 tree with Linus' tree
Message-ID: <20230627172630.55b07ef8@canb.auug.org.au>
In-Reply-To: <20230627063753.GA18674@lst.de>
References: <20230627103900.04fa564f@canb.auug.org.au>
        <20230627063753.GA18674@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nSf6sxyGv=Wrun9NFa6oPQT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nSf6sxyGv=Wrun9NFa6oPQT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Tue, 27 Jun 2023 08:37:53 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jun 27, 2023 at 10:39:00AM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Today's linux-next merge of the ext4 tree got a conflict in:
> >=20
> >   fs/ext4/ioctl.c
> >=20
> > between commit:
> >=20
> >   97524b454bc5 ("ext4: split ext4_shutdown")
> >=20
> > from Linus' tree and commit:
> >=20
> >   c4d13222afd8 ("ext4: fix to check return value of freeze_bdev() in ex=
t4_shutdown()") =20
>=20
> Hmm, I can't actually find the latter commit in linux-next and the context
> below also doesn't make it obviously cler to me what the conflict was.

That is probably because today's tree had not been released yet ..
please refetch and try again.

--=20
Cheers,
Stephen Rothwell

--Sig_/nSf6sxyGv=Wrun9NFa6oPQT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSajyYACgkQAVBC80lX
0GyTiwf/WNPqOdK7ZI6dPcAUYShnSrcTSFdY1E2S9B9I4pHTHfvKAjZcfVYk7ZQn
goIpioU405S4pYoF9jld2nqwP6bj6jArgNGxp/KeW6GlPnPGvrQ46HUw8Iof260q
jKDX1YOVAaJj+SMIVTY5Am5Sy5ed/XTCvf/ikiCXTWEpKNc0twID/F7pD20Wf87i
zrbDIP/+CdpuRZGnAnDHWK815d1pz3OnxRBjMB3D9LxKTzyeGeUV/1u7P5rE3oG+
O5UU7A46MqYVGVR/4lw9bmPK4k/KrBXqW8dP63hh+sCaKnxootsfOldQlShze5J3
WbnOhEj+zVrrs5XUuPgV1g2OohIP5Q==
=oDAc
-----END PGP SIGNATURE-----

--Sig_/nSf6sxyGv=Wrun9NFa6oPQT--
