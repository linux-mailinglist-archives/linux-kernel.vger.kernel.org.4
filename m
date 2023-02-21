Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50DB69DB64
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjBUHmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjBUHmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:42:33 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B6C23313;
        Mon, 20 Feb 2023 23:42:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLWTZ5DBWz4x7W;
        Tue, 21 Feb 2023 18:42:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676965347;
        bh=NNJlaJnQ2uPkWB+DfoayA3t3cxA5NsFvq1iXGovK7i8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uEKYT9n5GowZYqmKQyQe7GLQWOMY5xtrsVELMLHUNRNdxVwa3+CNDrXH0pKuzxTrt
         bn+2QDW0/uJikzxH/loMMRamEh4psbNsuE6JhXtN9VugqAngirjulmxi87bMMdv0KS
         PQqaFbxDZ88IxhqWBlyaSsKJcHLae53X74wel273xx5/tWHtKzFnZSibV/U6wqJoGj
         HSGvph8gBtmPn/WySkyIOrfsh0PUbmOgapsXadPJlWxSScBucwviFYUgw7ewfVPVNP
         NV8pSIUGb1lnzYRbE7fjlNy0Dm7CGqOZF3bCbWh5trSN44hT4f85LyMNgFMLGWsu8r
         7nJQOns+fm2Ug==
Date:   Tue, 21 Feb 2023 18:42:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs
 tree
Message-ID: <20230221184225.0e734f0e@canb.auug.org.au>
In-Reply-To: <2351091.1676963957@warthog.procyon.org.uk>
References: <20230221174401.7198357d@canb.auug.org.au>
        <20230220152933.1ab8fa4a@canb.auug.org.au>
        <Y/N8hVWeR3AjssUC@casper.infradead.org>
        <20230220190157.3b43b9a7@canb.auug.org.au>
        <Y/Pe2xHklSr1hDtz@casper.infradead.org>
        <2351091.1676963957@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BQfQQmO37yFZXaMtd6DZd.r";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BQfQQmO37yFZXaMtd6DZd.r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 21 Feb 2023 07:19:17 +0000 David Howells <dhowells@redhat.com> wrot=
e:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > in the cifs tree introduces a new usage of it in code that is used in
> > the cifs code ... so someone has to figure out what the merge
> > resolution is between the 2 trees (how to replace that new usage) and
> > let me know and then we need to test that combination for a while
> > before asking Linus to take it. =20
>=20
> It seems I can't fix my patch and give Steve a replacement patch because =
the
> new filemap_get_folios_tag() that I would need to use hasn't been added
> upstream yet.  Do we have any idea when the mm tree might land?

Andrew has already asked for it to be merged, so its up to Linus.

You could fetch it yourself and do a trial merge and send me your
resolution ..

git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023-0=
2-20-13-37

--=20
Cheers,
Stephen Rothwell

--Sig_/BQfQQmO37yFZXaMtd6DZd.r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP0deEACgkQAVBC80lX
0Gy8agf+NF0EKA/5akG/J9oSYE2bLsctMt1AaZRa4fQtEEpPBmPM//r95sTGbIMd
V/UnrtBpjAlI5ibR6MCMGFK2PpXYZEqgKhl02988ggKRhlwrN/AwuN+uEKzlY0Sd
dAnQUW8RfqvgcwFmwD1tsxuJRM6HxXSccx8s8RGFaBlwzAhQiOh4/pyD0lsy/bhY
NGQTDDzTniZ2naiXJPESWJ1l2jOr+qQWoZOuwbcFjOH1na/78RKX3LZPj2e6hZ0u
Z0/foMjQiGmvfz0M5ulTghTkKEDOIiwpI33JYQsxKHypW2n76UTMMsrJkPnB3i5+
5PiAoW4a6sugyxAB1lGMAvoc0FixJg==
=gC/P
-----END PGP SIGNATURE-----

--Sig_/BQfQQmO37yFZXaMtd6DZd.r--
