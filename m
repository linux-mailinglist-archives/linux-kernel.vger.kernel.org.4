Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243AE6AD7A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjCGGtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGGtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:49:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CBD39B9A;
        Mon,  6 Mar 2023 22:49:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PW5dl2NJSz4x7y;
        Tue,  7 Mar 2023 17:49:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678171755;
        bh=C57doB76oZtZeB1izZFMORaRw6d8p4PWKsCdpVl0ZLs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=esVyxfiMajTrWwa/bVhOhDpzhsXV+TcX5uSE0i9Vp986crLOqYBkR3Ib7gQepSyy8
         Yy1nzVa36446HTH5JRfxmq/G3ZWVi6OmmBHxkbYv1Yq4g7GeC6ChV3w3vEfdwo2UYY
         iBu4jCMgAt1IP493jrsbEj+0tj4UH9wu4io9qynKu9cGMKvckbnUZURfzNC/Alvb6j
         4BoLywbKUGj0bPehG0TvWMaveMcKl8fbMZ+n8Bkd92F/DtoLU/ZmD1xzOGuSSnoosg
         hMvt+eAtovdIWr2fsqK1ZU+LBf9ZdIxPAa8D7wZuyzPQoQ6SYVIA4c/7BNvrG9ArSN
         WABozHESGmcgA==
Date:   Tue, 7 Mar 2023 17:48:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warning after merge of the driver-core tree
Message-ID: <20230307174855.73b474df@canb.auug.org.au>
In-Reply-To: <ZAbaXeEKfUJY+hYx@kroah.com>
References: <20230307134313.1b2aa555@canb.auug.org.au>
        <ZAbaXeEKfUJY+hYx@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fhv/M53NODkifjJe4MxJr_u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fhv/M53NODkifjJe4MxJr_u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, 7 Mar 2023 07:31:57 +0100 Greg KH <greg@kroah.com> wrote:
>
> On Tue, Mar 07, 2023 at 01:43:13PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the driver-core tree, today's linux-next qemu boot
> > (powerpc pseries_le_defconfig) produced this boot time warning:
> >=20
> > HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
> > sysfs: cannot create duplicate filename '//block' =20
>=20
> That is odd.  What type of userspace are you running this with?  And is
> there a pointer to the .config anywhere?  No one should be needing this
> old config option anymore, but maybe I messed something up in removing
> it...
The userspace is a trivial PowerPC LE initramfs that just shuts down
after it boots.  However, the warning occurs before the initramfs is
even unpacked.

I have attached the generated .config

--=20
Cheers,
Stephen Rothwell

--Sig_/fhv/M53NODkifjJe4MxJr_u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQG3lgACgkQAVBC80lX
0Gy4Pwf9Gh50vWys0zmFYMiMv8YhhVF2V1DcGwwBFGkHGTONTcpUqcS9OqXM9kSc
JgcL+YsBfzGqNPZB3JjLJ1IrtKldZDZcP6DwhLi8EPcWmSPSH7tELSA1JgXH+iha
6/MVwxsUOzo88z5LlxB8BeaaYcgbI3HBV4YbtQqiQxppOi+N22qo/TOkK/KsX0nw
OcBhFgbaa7mhbgysa8wzaSAdQYvkwUnB2xmfZWt/C3u3Zpz74Ob1wKOmIgrOMog/
bD4cb+cnuwtmBd2P/JEkpw9PjVD8qWsV9a19vHwnUg1MXfXSaOD0u2tzFt/XGMf0
+y0KySGZBOnWnvR9z3aQymm+Rvn7DQ==
=JF3a
-----END PGP SIGNATURE-----

--Sig_/fhv/M53NODkifjJe4MxJr_u--
