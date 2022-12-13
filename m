Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B44364AC92
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiLMAm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiLMAmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:42:54 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9210A175B9;
        Mon, 12 Dec 2022 16:42:51 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWKTk1PBFz4xP9;
        Tue, 13 Dec 2022 11:42:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670892170;
        bh=SBEnFVbGyIZf4zr83m5p1pj4zUPpzH4Y4I/0VbEKNPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SfcMh/EXaG6qDGycSNFE3L9XYrqoBGk/mtWOkchXDzlQbCyJY4vIBsx7IVtdGEqJZ
         xlcMfznvYRl7cZs+Uv1DvrrLhpxqov+F0vEMpem4hpKNBWJpy7zKTVLHsePZC+32vx
         tXHMWSDxCrG7iCDoClBbrEFdc08y6vObw+fn6UICTGRiOxfWErLLbDWTz5aZtMEt8p
         36kRLp4I5jiGklc2TX7C3OC9AO72o74qP+b362ohN3fYHHF8H+jL83xo/zYQcH/8ke
         FmyfskMEFt3ldWAgXyqApgWYvjsvKVx+8moRnCoERzKeH/pXdjfR5iNWgU10smyR5m
         lIF3Nv75Q9zDw==
Date:   Tue, 13 Dec 2022 11:42:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the ftrace tree
Message-ID: <20221213114249.1bac79ce@canb.auug.org.au>
In-Reply-To: <20221212175642.77cba577@gandalf.local.home>
References: <20221213085200.772ddd94@canb.auug.org.au>
        <20221212175642.77cba577@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mf7S=zQ7Bi5fs1VypkRn_u6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mf7S=zQ7Bi5fs1VypkRn_u6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Mon, 12 Dec 2022 17:56:42 -0500 Steven Rostedt <rostedt@goodmis.org> wro=
te:
>
> Bah, not sure how this happened. I thought I pulled these patches directly
> from Masami. Does a rebase change the committer tags? As I probably rebas=
ed
> them on top of my branch.

=46rom "git help rebase"

       --signoff
           Add a Signed-off-by trailer to all the rebased commits. Note that
           if --interactive is given then only commits marked to be picked,
           edited or reworded will have the trailer added.

So this is not done by default.  Yet another reason to avoid rebasing
others work unless absolutely necessary.

--=20
Cheers,
Stephen Rothwell

--Sig_/mf7S=zQ7Bi5fs1VypkRn_u6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOXyokACgkQAVBC80lX
0Gya2wgAizpr7vYZH8O/GtSKri+e2SFsCi/yFO4PvZcDLvE1pGI9YFDHn975z7mT
4XMR+SeK1sVgUOBVvHVXvqVF8Xt/iMJWvRfyYPBdAKcKVt1AbBHlkzey0M8RNUqo
AU5OHQ1irunF1+FTNS9VgmeFVY/IYYZucVCC6QOL7qRLCGFi9QbB7Vdg56qbe8Sk
qxKrNMmbZa/maahWB9m/GHIU2D6MnrehEn9Ag0/z5yX0XhGnOW8pDioT6SzB8tlI
hZFgUacVc/PIhjeOhJ1HbZyuc/aQk8QrWZCzkNeLb4ulBn5mhj6arJN0r1AE/QGX
u4WPCM7PqRcsJ0MFNkgFWBT2LQKK+Q==
=s2Vn
-----END PGP SIGNATURE-----

--Sig_/mf7S=zQ7Bi5fs1VypkRn_u6--
