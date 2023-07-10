Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8183174D393
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjGJKdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjGJKcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:32:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82F4B2;
        Mon, 10 Jul 2023 03:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688985165;
        bh=oRijPJJKzfq1q9MD5wWegjOEj9xa6p+4w7cHkx2LsuI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZRc2WuaisazJtOAj/p5cakHlyrDzTc9rDj7duH8GHe08yjJP9ZGbPAK/i0NFdwzxv
         XxwfDBPR77h6SA5YgV0XoVHjY/UmfJLSCfynBtYrqvdxqy/cwvFnl41nw1WYIOeI00
         CURSNB1hokQ7Q2P8jb8TuAbYcks+4nzoWraMW7t5Yd/E1qyc++4FsRjtQlRbSr493F
         kJ9f5RBJiKU/2hHD2QF/XLmMNBVJ7eOfeaCDUqPJXKzSI8xidyiKjpua/fGg+fsknJ
         720b0i8UKArh+nVZucBvsRAwroHDdG3KCz7TGSWq8OaGPpCMcfwrNhJoMDXXlQw6p5
         SmPNVwZ3Un03Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R00gv3T2Cz4wZw;
        Mon, 10 Jul 2023 20:32:43 +1000 (AEST)
Date:   Mon, 10 Jul 2023 18:40:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Florian Westphal <fw@strlen.de>
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
        Vineet Gupta <vgupta@kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: linux-next: branches to be removed
Message-ID: <20230710184054.5463d3da@canb.auug.org.au>
In-Reply-To: <20230710074656.GA32562@breakpoint.cc>
References: <20230710172602.05d32c03@canb.auug.org.au>
        <20230710074656.GA32562@breakpoint.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/92SqFP_2XhIt5Lio6uLtm7Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/92SqFP_2XhIt5Lio6uLtm7Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Mon, 10 Jul 2023 09:46:56 +0200 Florian Westphal <fw@strlen.de> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > netfilter		2022-05-23 14:33:38 -0700
> >   git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git      maste=
r =20
>=20
> The tree changed to
> git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git   main
>=20
> > netfilter-next		2022-05-23 21:19:17 -0700
> >   git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git maste=
r =20
>=20
> This changed to
> git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git   main

Thanks.  I have resurrected the branches in their new location.

--=20
Cheers,
Stephen Rothwell

--Sig_/92SqFP_2XhIt5Lio6uLtm7Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSrxBYACgkQAVBC80lX
0GwrYwf/feK6vFsaw4LwE+Z2Oj8CZV6KtKFQApLMuszrh3xAA6XnF6mAG56zs1sw
d0CLnsyZhu11Dey5gkyJ81eFpbetBc1lmInYuwt1EhqWZt4nr00XGvgwIuLYHY4F
ikd6igeX2RNodjL1tdUVzV4U06FcsSPqGILwuSoffys9pHCXKAAq2oaqLmlpm0oR
qZljjyxK17T35ehnqFVK2VzFiAVHGfGc/wwXx6PlEADnN/FG9zDE+Pa/JgLFiqqs
V50lVqG3c5exnsmqi+uxFNFbQ6Mxzt4Gr1ySeDOSXUJl5SL1rTpSEu79tEX4doUp
EGzCp1wbM9FM0xVZyXl7nWO+fuRuqw==
=hsEX
-----END PGP SIGNATURE-----

--Sig_/92SqFP_2XhIt5Lio6uLtm7Q--
