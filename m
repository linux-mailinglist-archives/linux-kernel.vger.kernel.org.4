Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD44636CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiKWWAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKWWA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:00:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19E7682B4;
        Wed, 23 Nov 2022 14:00:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NHZmy2WdWz4x1T;
        Thu, 24 Nov 2022 09:00:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669240818;
        bh=pn5dxXgRedwzbeQJVcZVkNwl1pYjs8U9KGA6c55QAh4=;
        h=Date:From:To:Cc:Subject:From;
        b=cs0JAuVfDz7BK9qNdj9JOmglDcHA0E1euRtRCRxd5XTQEbWXtzgPUZnFIk/mUyZz7
         4JREqfwO9vKkkoW6fYCh3y0GWf14k2eHcc4hXH7HtThNkZ6GmQakx2q8jyi4jbFUru
         4VxTv1ei6a0HqS4PNvHKTkeuHz+MItzigEPpSZGvOVPqupH3KmDTn/YGN8ZpWSpIrj
         TcdM0jmPVEv9+zN/KdX+KGT+GyjxA3+Gy4DngVVKjcyWYjWHkjBhJH8/GtzRKIexOZ
         xfjbCNZdV1ihh+xYzeh+dZvYH+Geg6BltwV2MiwUzOgwlxhYyVs4MuFnT8rdyxl0H2
         gBZn4EPdo2uTg==
Date:   Thu, 24 Nov 2022 09:00:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20221124090015.0c5a65f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eqEIo7r4=9NUbK+Mh=3+YHM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eqEIo7r4=9NUbK+Mh=3+YHM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5d956020603d ("mm/khugepaged: invoke MMU notifiers in shmem/file collapse=
 paths")

Fixes tag

  Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem=
 p=3D

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Please do not split Fixes: tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/eqEIo7r4=9NUbK+Mh=3+YHM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN+l+8ACgkQAVBC80lX
0GzQOwf/fdNEfu4yOTN1i2+7WMkBQWayqx6pM0ze2oH2TXfhzgwufEVwhwM8axLv
Y7fm/qqjAUzfcCvoRdBkG9qH35vSKzG/A6eJvXaMPzjMvzzgKvKlLXG1AMgJuuqU
4mcAiBtNZKdtJjn9PcWkDPHzUzdhwK4QLMlThAR+YkwMu+zE/s34bFxCoyJmSClf
/CrXElvN1TEZ3Km98+1NEDWLv3vqk5Hf10dcN3kyq49cokulxg2B5Xg9eb+vhRb/
dy7RvCOGfwFXKXbcVNnuA3jagai8PY/vPdWcBevShjykzauor9H/EnFbSpJRcTct
js2lSEh2lJhzLI0zWmWU2sktpy2OGA==
=bZdT
-----END PGP SIGNATURE-----

--Sig_/eqEIo7r4=9NUbK+Mh=3+YHM--
