Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDE0728D3D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbjFIBnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbjFIBno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:43:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AB5132;
        Thu,  8 Jun 2023 18:43:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QckPm36dHz4x3g;
        Fri,  9 Jun 2023 11:43:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686275021;
        bh=IbAM1ZFJjS09oYvaFYfvvboSiciLydFb4Nc3bZhIAs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IPqTD60B4KtEHz93DGPNa+xb2HN74yJNZTzrNfB+G+i5p8Vtq2JAmq2Wx5A38xQnm
         Cp35LTU1+dJpwlOUJoX7ofP8Hq23qIr2y+zIthWLD4mEGPnwTBB+EUD4bzr7JSPKmI
         Itv/eyYeqZmLFKRdI9lXVJerropmCXKpfx3qrCzRejB20yJ1t5q5vfYyJ/iH2Yh+eA
         omXKvvEYwXGjBLlPtuTghMJn89JtkTsKnjauarTpGiI5c76htNBeOOp1qn8oqKm76q
         nh0ArH0zXjMNJm9hmEA8aSs7v1T9Vv1kB2w2z+aqLLACzaPo622JzSv5g837UpcTUh
         UrmA6xphhZDfw==
Date:   Fri, 9 Jun 2023 11:43:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Networking <netdev@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: linux-next: manual merge of the net-next tree with the
 asm-generic tree
Message-ID: <20230609114338.72c7da7a@canb.auug.org.au>
In-Reply-To: <20230609104037.56648990@canb.auug.org.au>
References: <20230609104037.56648990@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/id79zsS.mfjh/UScvatQX_=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/id79zsS.mfjh/UScvatQX_=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 9 Jun 2023 10:40:37 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   fs/netfs/iterator.c
>=20
> between commit:
>=20
>   ee5971613da3 ("netfs: Pass a pointer to virt_to_page()")
>=20
> from the asm-generic tree and commit:
>=20
>   f5f82cd18732 ("Move netfs_extract_iter_to_sg() to lib/scatterlist.c")
>=20
> from the net-next tree.
>=20
> I fixed it up (I used the file from the former and applied the patch
                                          ^^^^^^ latter

--=20
Cheers,
Stephen Rothwell

--Sig_/id79zsS.mfjh/UScvatQX_=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSCg8sACgkQAVBC80lX
0Gxj4wf/UcJL8Mz5lNAnEhzKXymGzYWRMn6kHEkKgO6lqzkYiPOW5P1ySQKhTGxE
xjSGa+mCA5WNsYN/ItHC5YPb8XGr4CosBppaWlgmHw9NApr6Ql5p4JXORM2uE+jA
wt9eHrMItC37p0iSX9mLvT5E+wFgOU77sAukAO5FcqXgiqVHmHxu7E5MmW7xWw8A
hlFvYMAwNwiXm4Np6DZMR5jGYcr3DD06lmvn4cxcaCpzNCpqz/8BQmiziXTA0xzz
nd+95elFTBp7FbtuHZai31qMYc09nqThy38MAoKBQ/9tGfoblt0N/3pz1LinGoVY
D5LgsF6OfkJY8ySIhEt25c2vTiNvbg==
=npVF
-----END PGP SIGNATURE-----

--Sig_/id79zsS.mfjh/UScvatQX_=--
