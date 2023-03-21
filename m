Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CFA6C2853
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCUCux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCUCuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:50:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28F1193C9;
        Mon, 20 Mar 2023 19:50:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pgbh86DJ9z4xDw;
        Tue, 21 Mar 2023 13:50:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679367049;
        bh=9YGAkTXTTyj32FuD1vcOXMQCBItl89iL/WXYepSW4to=;
        h=Date:From:To:Cc:Subject:From;
        b=Vf2LocVmX2Vfrq4b7bgQcwU+7yROWAD7YUWpe1qqqYqGUiQQxGVFOT3E9K8bHxhSV
         bA/Z/N20GDh/O6sHIS+fDOlCUU+z54g9JEUw6AtwEiS7SfTnNCOeAwC9fWFS4zm33A
         Titep/YJrzOwqk7rHR5znXUJ5SnEw7dJu5n6cC7THfQupzcBye0flTZnEQVLItgWiu
         5InjLZ1KxrK8WYwccwUiHwNOiLyBvImcjj2milX7Gj3W7T/e68Ny/uI6SBl/NJMhFI
         pbTjSTXlm2389OdTtVwDIOYexGKrpTwTgWsoXthOYaHLoxKBEjHplr+Ggs2bH1B6v2
         NVUygibignhPA==
Date:   Tue, 21 Mar 2023 13:50:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the rcu tree
Message-ID: <20230321135047.740fbe70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Xi6vpBIB+38oRizy4vxx=pm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xi6vpBIB+38oRizy4vxx=pm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/srcu.h:106: warning: This comment starts with '/**', but isn'=
t a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Annotations provide deadlock detection for SRCU.

Introduced by commit

  57e98b73317b ("rcu: Annotate SRCU's update-side lockdep dependencies")

--=20
Cheers,
Stephen Rothwell

--Sig_/Xi6vpBIB+38oRizy4vxx=pm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQZG4gACgkQAVBC80lX
0GwiawgAlerAOZNxCZCT5z6IEinb5PcrMMAAbSGndV4ODDCKghd4s1UKLIviINH4
5FcJ9MTUP/PZQcnys3iH4Xxj2bdEem4uoRJfOdO0Q23UQOfqolIUGWXC7BrTZBD7
htXkUWd7Ye1YeUaPKQXFMwv+tpPBe5m+MgqNQhvuM2I4VMYny1biHFsl7GVvndaX
BXUyIKlGWlSU+xExm1D1ezZHNyJ7Uy1CHgrcNE5i2QsgOZ4PlmQlYrqEYgSFZS60
GA/O0ki1b65v90RuXA0MasGnMUTO8S3Cxnc1jvXfERWlgZgbshgw2VaiBmSLnXF4
2foBEYR8MbI9ocG42e/JBnMYKRXv/g==
=oceQ
-----END PGP SIGNATURE-----

--Sig_/Xi6vpBIB+38oRizy4vxx=pm--
