Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A9E6D8AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjDEWgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjDEWg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:36:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB02CBA;
        Wed,  5 Apr 2023 15:36:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsKH8663kz4x1N;
        Thu,  6 Apr 2023 08:36:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680734181;
        bh=kchzhiTNfDkeFdUBWqlrk86s+qL8CAqBJRXd7j5JM/Y=;
        h=Date:From:To:Cc:Subject:From;
        b=lHT9MV5r/eDZVYIApFFUNSZUnggLNrE2CC80v4GRpl6yI8O4onviz9ypqzGPyVdYj
         608DMDNra9H2aj1z/aX4QVA5IpaYa7OrHJC5ws/i/+YKk2OtFczN0RXoFtkqd2b5sU
         B8Nm+MD5FInuqMjQn2KGXTbR5uwxZSeasSixabwxJkkZ7KBIFbQCq/FmMU/mkkxzqV
         Vu85xFG7HfAq0ptvYjHBuA7NhNFk54RSnhk5ITkY07L2iIojtEbB3S8wHdP6T9qlSK
         eEkAmwZ+eIemTuCoD/3bHeoT/gq4104rIf9lXhLir45jgVJIfgFgle7Yb6wyOvkJ1B
         FR5lzz8ExTs5A==
Date:   Thu, 6 Apr 2023 08:36:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ziwei Dai <ziwei.dai@unisoc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the rcu tree
Message-ID: <20230406083619.65dee33a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ff+NGDCp+vSVwV89XzoV=yL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ff+NGDCp+vSVwV89XzoV=yL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  acdc79917d65 ("rcu/kvfree: Avoid freeing new kfree_rcu() memory after old=
 grace period")

Fixes tag

  Fixes: 0392bebebf26 ("rcu/kvfree: Avoid freeing new kfree_rcu() memory af=
ter old grace period")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Maybe you meant:

Fixes: 0392bebebf26 ("rcu: Add multiple in-flight batches of kfree_rcu() wo=
rk")

--=20
Cheers,
Stephen Rothwell

--Sig_/ff+NGDCp+vSVwV89XzoV=yL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQt9+MACgkQAVBC80lX
0Gwh8Af7BDl+3OJJaUzP7xRY1sKO9EiHDKzsKcmrgkRJPxzMm8D5tYjuzkPGoA06
CMrlLqEF158raMQKai7l5Wt9LDm+Ts1xkhJo8PfQ/sYZ1Fu7vG0JzuN8FUNWnJzb
BsTrG1q2RPDGW8c+JlML4vi8fA3ZyFl3x/vb7As1aJMKWHp7HCTfVFaBYzWCUkEQ
4PhTJMemGfm7UdQcCtsxEE3cQPOA/HS+vvD1L3cCBwQsAwpLqJ5ceGn7GIR209xq
aGjPhCrikDn8uUUUiB8Imz0jBfc9TR/GTKhYamsx4AsJLJ7tPu3B+z02yeA3ZNQW
LnJpQPtCPvaFLy7grV3QvaoV3PPUuA==
=spye
-----END PGP SIGNATURE-----

--Sig_/ff+NGDCp+vSVwV89XzoV=yL--
