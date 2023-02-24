Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802AD6A1626
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 06:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBXFLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 00:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXFLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 00:11:37 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E13498B8;
        Thu, 23 Feb 2023 21:11:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PNJ016NFbz4x5Q;
        Fri, 24 Feb 2023 16:11:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677215490;
        bh=swUVYw+NnQ5VQTBiw3V/dI9vwxKuaVHMm+CA9qDLHy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HvFCpxFcs0LyotnZudzdyy61jqcr3M76/FjgnAHXxKO/fC2Bmm4ItFIHk8gx7b1pU
         Z6kZX64CmuREd5hyc3mb8nhUIJjga3a+WdHhLmnvmqX8iVpRQbddyFLYD7Rsj+r3f4
         ESH3ZgD4tXg+q1MoW1MMB/VkBMOliLPF9CmqRSRcj92HzJvQL5sl32JX9qt3+eCriD
         HkZXf0BRfGKGRHOUScN68WrkPZuxzpAFcLuaI2Gk0IWjL0bWIqf5G/vBVyUD8xZmNH
         ehJsQABKRzrxVm2iUwCNa5kaT2YZpTvx43E7+Wt/jvcxZTiQgmgRjdTxGDQC9r9vXL
         lEzivhNrX/L/A==
Date:   Fri, 24 Feb 2023 16:11:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: manual merge of the mm-stable tree with the ext4
 tree
Message-ID: <20230224161128.0949d8ae@canb.auug.org.au>
In-Reply-To: <5f228150-0e29-6d58-3dcf-776bc2a630b7@gmail.com>
References: <20230220152938.45f62d5a@canb.auug.org.au>
        <Y/ODNJ3MfoD6dUru@casper.infradead.org>
        <20230221175436.599166f9@canb.auug.org.au>
        <20230223144722.635ab483@canb.auug.org.au>
        <5f228150-0e29-6d58-3dcf-776bc2a630b7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sbrNITcxUzfZ4jFYiJWMZxZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sbrNITcxUzfZ4jFYiJWMZxZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bagas,

On Fri, 24 Feb 2023 09:42:49 +0700 Bagas Sanjaya <bagasdotme@gmail.com> wro=
te:
>
> On 2/23/23 10:47, Stephen Rothwell wrote:
> > I still have not been able to figure out a merge resolution for this,
> > so the ext4 tree still has had no testing in linux-next and the merge
> > window is progressing.  Does anyone want to help with this?
>=20
> I think at worst, Linus will have to resolve this mess himself when PR
> for ext4 is submitted and merged in this merge window.

In which case we will have an ext4 filesystem in Linus' kernel that has
no testing ... and if someone has done the testing, then they can at
least supply the merge resolution that they tested.

--=20
Cheers,
Stephen Rothwell

--Sig_/sbrNITcxUzfZ4jFYiJWMZxZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP4RwAACgkQAVBC80lX
0GxQ1wgAktbKKGHw5ZwbhA8J+xunum9Y/ZDj7J7d3uMMyJiPZ13p6Na7f3bobtaV
mzDskpoE17Br45UUr3HI9FpTTN9Go5fkfvd6y5NpGEe5CYnHP5EHSGaT1OT8hHB3
YTEZNYKbTBW6ButXBsLhULqIljvhraQk+ujbx6JhoO08VpoZXTHmdp7Zu6sxTCjD
sj6dO3qGU6Mub93JrgD0ZQHcVvyBA1Eh92GrUFX6j78ODGojdEpa+/4AgYPYJJ1j
DpqVs4HtnMnMkeu9b9euLGaTYDWjjrUpeZTX7vXlcW37TQ5kxL+p1BIPH6JfGbY6
iYQxDOZR/Ts5qDUNOiWGVFrKooW5xQ==
=vyOX
-----END PGP SIGNATURE-----

--Sig_/sbrNITcxUzfZ4jFYiJWMZxZ--
