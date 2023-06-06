Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2305C723600
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjFFEBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFFEBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:01:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC5012D;
        Mon,  5 Jun 2023 21:01:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZxbf2GMFz4x1N;
        Tue,  6 Jun 2023 14:01:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686024063;
        bh=+W5S8yQ4Igf3B9WcTMEsVIvZatCAq6RteP00gqMa7po=;
        h=Date:From:To:Cc:Subject:From;
        b=Lsx3f+DE1tRl7k06VywJStm5kTlUvu7TKUbRnRW38oAzkZSqV4/CPzYFkVG/waiq8
         uzSJ66VXuDo0tzcQPhJjlM25w55UwFLVa2XHwOx0kwGRnHYs6vPT3SkN/IBJZWi/sh
         8/rXa9eCDtRJgLK/e3LuNDV6Tby9+cOu9NKnzPtvIwQ9NCfI53/CBOpiw6Mvu75zcm
         aZgtbFwJTeVlu6mgzdPXxQbAfPpfxE/HPsDduh6OPhzaf95dx8BJO9A1OfMlH7JwUr
         maZfL1cvqRak+IouoYhm2vgJQ2e/4k6DYDgAUc1moo/1uJNDZtWyrl5nwM83u7feec
         gp5D2Ty8qaRCw==
Date:   Tue, 6 Jun 2023 14:00:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20230606140059.61caed8b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9BH_dDnaiZar.C.1LUifcOO";
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

--Sig_/9BH_dDnaiZar.C.1LUifcOO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (htmldocs)
produced this warning:

block/bdev.c:863: warning: Function parameter or member 'hops' not describe=
d in 'blkdev_get_by_path'

Introduced by commit

  0718afd47f70 ("block: introduce holder ops")

--=20
Cheers,
Stephen Rothwell

--Sig_/9BH_dDnaiZar.C.1LUifcOO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR+r3sACgkQAVBC80lX
0Gw4LAf8DMXjuh+fw0ybsV7LksYwoqzjw2Zvmf0DuXMy7168Ml86JUYXwRXxfStJ
H0Ol+/KA/ZpK1dmWc4jDLg+tnlImwSZHmcpWnzt19earx6myZVMMVRJJ3qNoEAGI
g2U61nAKKLGrjo8T/F2io2j+XBzv/b00tGYHEax9o+hofsMajl+g6r+Xlpmc/4cU
Zx+5DM64BtPkUWSdCoMJzrjOGhUauZXfkamRp1wIY88LRGYgWo6jYaG5YzkgBQ9u
8OTjvngCAK5Jch2Qv1aN8h5nZtGiwlYHQuj2SXPXbwF4yZMHPOhC+It0XItW6fu6
49Oa6+ncFjFTkJhOfSBthBdNxShmVw==
=yUdr
-----END PGP SIGNATURE-----

--Sig_/9BH_dDnaiZar.C.1LUifcOO--
