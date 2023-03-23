Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E226C5CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCWC6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCWC6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:58:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CD81F5FD;
        Wed, 22 Mar 2023 19:58:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PhqmD3xL5z4xD8;
        Thu, 23 Mar 2023 13:58:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679540317;
        bh=UQAPrN7XsgfRg6iLJqAw79IfPdvF2StjqSdgLJhFe6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q/wCuaYj7idT/Lf1TPqNZlpniheAsLVUOdBRhfOWq742iYzeTS2ve+idu98nWTShX
         HgkJ+QkZU7zJXHgEKLtbtrOKUedb5HQn8akARbrk+QowCy6SdahA70HgSx91BQFera
         ZzqtvT5LObhVDWLsEFj7UEjSpv+EM7BOlF9FjJ/cZQECq53sMHfQ2QNIblqq6IJEhZ
         l6nz1db/5hZMRjAEmOruKZlOCV2uGwum9pYFLEe4ZUS7qWop92QPPW5HCSRA/hCaSg
         6LOnZa8v9iYR5Y+dEDyw4ZGECzIf4p/8Xn1sSkFn2VWSJcdZGBzCH+anFNKyUnHh4e
         UkzLb2evvt/ng==
Date:   Thu, 23 Mar 2023 13:58:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <20230323135835.747893ef@canb.auug.org.au>
In-Reply-To: <20230320144721.663280c3@canb.auug.org.au>
References: <20230320144721.663280c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4zbmP/qwyIE+obDy.cOhjiX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4zbmP/qwyIE+obDy.cOhjiX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Mar 2023 14:47:21 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the mm tree, today's linux-next build (sparc64 defconfig)
> produced this warning:
>=20
> In file included from include/linux/wait.h:11,
>                  from include/linux/swait.h:8,
>                  from include/linux/completion.h:12,
>                  from include/linux/mm_types.h:14,
>                  from include/linux/uio.h:10,
>                  from include/linux/vmalloc.h:12,
>                  from include/asm-generic/io.h:994,
>                  from arch/sparc/include/asm/io.h:22,
>                  from arch/sparc/vdso/vclock_gettime.c:18:
> arch/sparc/include/asm/current.h:18:30: warning: call-clobbered register =
used for global register variable
>    18 | register struct task_struct *current asm("g4");
>       |                              ^~~~~~~

This has come back today.  Did my fix up get dropped accidentally?

--=20
Cheers,
Stephen Rothwell

--Sig_/4zbmP/qwyIE+obDy.cOhjiX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQbwFsACgkQAVBC80lX
0GwcwAf9Hos0FSI1AqSEPVziwbCmRIe2kvjCXRUnojtivP4HC3krSjwOtd3XiCUT
erVxz3NBuaOTz67B6Aynl3VqFzzLTixNbL3k/KhLheCyj+FNfHOWNXVdVfWOTZRs
/gflYFZes+zFQqxPwaZAZzamLEwa64QkMoyR1be63xoUZ1M0jF3mBtNqfGym/7dp
7ypMJ/+Gu9WS+D+/SU2OGIopdh5qKWaMGjOCqGL9nt012HSIt/ZOFRerb+5MbOdv
JrKV/e7Csqd9R/3/RJ9+29d/fsrchhnfy9NJzJUACs81f1+VfRclYYSEqtxaO7HA
tRfiYmv7/MqAPlUzbxOm1XyTFMiB7A==
=DFKA
-----END PGP SIGNATURE-----

--Sig_/4zbmP/qwyIE+obDy.cOhjiX--
