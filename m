Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192C2610583
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiJ0WSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiJ0WR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:17:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A55AEA3B;
        Thu, 27 Oct 2022 15:17:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mz0Rh5RP9z4wgr;
        Fri, 28 Oct 2022 09:17:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666909073;
        bh=osOuUd+91D7hH5ciGKQB1pAb31O19p9ymqMsmjTvtDY=;
        h=Date:From:To:Cc:Subject:From;
        b=Z5VZFegtxWUd6v0/luiIUNQlKAPqlQtuP7QckNeBUbUKhQBOYjdDp/KdDwtXbd/XF
         DJkddcbjJvtl91TiRBtZ5F6ZuZwAyASPt1kg4lEh7Huru5uRB9N8AaUi6AkuDIf0XA
         U6iX5m1uWdv/4fnn6N8R3wch3BeCUebELcXdQmDein4eBfFLy2Vp14f3/qqdtG5TRE
         HQWw3ReTQ9DEHXiw7HOquC+qhOBqLzJd93HX4J4+CQ234tPyhF3lKgW7clBV+qv3k5
         O2tzEoCYMp0gLKA1jWdDx4LE7ankveoya6elbYKVUY64hfnp+ZPM2QDZvC7H+2gN+y
         yiIg7CqGz0JqA==
Date:   Fri, 28 Oct 2022 07:19:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the rdma-fixes tree
Message-ID: <20221028071943.30659de2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z2Wx=U5U0q0zQiNGV4VjgpI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z2Wx=U5U0q0zQiNGV4VjgpI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rdma-fixes tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

WARNING: modpost: drivers/infiniband/core/ib_core.o: section mismatch in re=
ference: .init_module (section: .init.text) -> .nldev_exit (section: .exit.=
text)

Introduced by commit

  ad9394a3da33 ("RDMA/core: Fix null-ptr-deref in ib_core_cleanup()")

--=20
Cheers,
Stephen Rothwell

--Sig_/Z2Wx=U5U0q0zQiNGV4VjgpI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNa598ACgkQAVBC80lX
0GwjCwf/SBNTCdg5qQ4Q/wzvU9mJ55pkQep28OzfA+a3VtUjZ5b4CnY2sep/viZU
FdGQ1vE7qhwVf+qcIJx62fE/9qOF3R+CP82LGTPDoEYHHOlStfKM4et9T2gv06hQ
tu6bVYlWqkghJ+xVgPJlIXGJskYAiUbu2mwjvRfUYbTMQltEosxwjlAmFhDRjX9T
2vkDCi1YST5SlehdprYQYFg98Pr/XRtGSwPZ9GLa9DhpENWU6B1H4qsoZ0s86KNQ
MkC0CEKuUtHuqxPQ6Bs+InM3w38tYc51cQSEGRUa5YVPMqxxxkSrnMJgJpyP090M
7I8Bwye9bAMOBWgBq8u1ptp6KvKSPg==
=O8N+
-----END PGP SIGNATURE-----

--Sig_/Z2Wx=U5U0q0zQiNGV4VjgpI--
