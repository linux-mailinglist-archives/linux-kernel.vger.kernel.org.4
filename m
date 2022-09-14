Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575445B817A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiINGVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiINGVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:21:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B7771739;
        Tue, 13 Sep 2022 23:21:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MS9FT0GQ1z4xD1;
        Wed, 14 Sep 2022 16:21:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663136461;
        bh=s8fMUb9zGfi7piJxreN/Y3Vnb/N+scSkvNoUAV1BKB8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iCrIdvtScY16V9gEhU4wFS0rB5zzQ6lewsGlZFcBy6IftRUUjwi/B+mCOkCMPMdbx
         9d9nmN10ZlVrr+m1mF84MxSZK5nLQXv8xCx1ZvLcHmJD1UkbwT9uH7eLMTvhWLCRdM
         8Im2ejl783RXrxTMReANCeCEv8sF+B/3ZlapsDRi87zhAGxTB9qIWuPtpq52lPklYt
         JHfmLqX4LXtC8LBZi3NL1Q42xRN3mo6UvN0nxxAYkcKzgX7rFGo3XIFrovs8XWiBXH
         p1WdT0bMhukXe2r9rtgZIuTEskCqeuFj8phA7ibZBPVlu5QLJfapszv0najnR6lhrG
         UzzRyXzs3syVg==
Date:   Wed, 14 Sep 2022 16:20:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with the execve tree
Message-ID: <20220914162059.731b0461@canb.auug.org.au>
In-Reply-To: <20220913230302.00a8c826a2d4ae9a6ef2a90d@linux-foundation.org>
References: <20220914155533.70c10493@canb.auug.org.au>
        <20220913230302.00a8c826a2d4ae9a6ef2a90d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KPkTiEwoE0n1ic_=ht096hX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KPkTiEwoE0n1ic_=ht096hX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

[Readded cc's]

On Tue, 13 Sep 2022 23:03:02 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Wed, 14 Sep 2022 15:55:33 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>=20
> > Today's linux-next merge of the mm tree got a conflict in:
> >=20
> >   fs/exec.c
> >=20
> > between commit:
> >=20
> >   33a2d6bc3480 ("Revert "fs/exec: allow to unshare a time namespace on =
vfork+exec"")
> >=20
> > from the execve tree and commit:
> >=20
> >   33a2d6bc3480 ("Revert "fs/exec: allow to unshare a time namespace on =
vfork+exec"")
> >=20
> > from the mm tree. =20
>=20
> Confused.  They're the same commit?

Sorry about that (still getting used to copy/paste in a VM on a Mac :-()

The latter one should have been:

  65d31cfbc445 ("mm: multi-gen LRU: support page table walks")

--=20
Cheers,
Stephen Rothwell

--Sig_/KPkTiEwoE0n1ic_=ht096hX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMhcssACgkQAVBC80lX
0GxMuAf+IX2p+j/qM0JF0IUR1G5vup6LlgQnsoaagfGVym3hC2J+cSTU162bXmkG
rY7DCgjM3AiQFCCFTQnpPR0wflIlW8iMvooL6NdD95CHD2KXY5L4K63eeoxeQOmb
Vf0m2gTtGEbusc+4L+yjApZcIytydOcjATkr8COT9aop7anAVlZu1sukWXotWnqz
6pl2//YbqDjWzjin7ct2ThWOfgVzW7KihMSh55GekATH6aP87aoGhUeVHpyj3oC2
2b7U/SUS95R/0kRDAnBIJOR/oxoeRLAwZpZmFXB5nVZi5foEFdT7pZt1Fo55KUZN
91D+NzFGFhOTvmSyMzfGwfnkNxTMxA==
=JaIK
-----END PGP SIGNATURE-----

--Sig_/KPkTiEwoE0n1ic_=ht096hX--
