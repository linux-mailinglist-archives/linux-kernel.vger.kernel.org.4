Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA23D66B543
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjAPBb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjAPBbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:31:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48DB18C;
        Sun, 15 Jan 2023 17:31:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwDyc0XzDz4xN6;
        Mon, 16 Jan 2023 12:31:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673832712;
        bh=kJvqvGC7aNDcWuqJvVUP3VSlLFWz0esC7Uc5hslRaNY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JZ/FO3T0juH/e5YnWgeXFhA/ma7Yzh2l7LoEcK1yD+wv7NE9J4c1T7nzAS+ehzYIB
         FW0tSQSv/ozVOUqSedrk7PtvQSclTFmpOXgaquvnBG3BEGUg5qTNQhL2NUMQtrdxq0
         +hINFFIV3lxrG28OVSk3X69o+tJ7WHJIvfeSOS1M3BChWlaRibijBZbqN9PdyK1qko
         0O9BjV7qvU480IscP3Ckgk19DV6cEiY0rbb9YI/KND5WBXfapARIU3peWwCU1/lWld
         vf6ht5JnIrouGZn+O3lUnMMgAU7VeLgTFTfhiMLYNi+9aoo2RvKb7QQxvSkAx4PWRL
         tAVjbkZuVwYow==
Date:   Mon, 16 Jan 2023 12:31:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     David Teigland <teigland@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <20230116123151.3a491801@canb.auug.org.au>
In-Reply-To: <20230109101117.2a55e070@canb.auug.org.au>
References: <20230109101117.2a55e070@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MlBNX4CZhfNE3u5Ea4n1W4O";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MlBNX4CZhfNE3u5Ea4n1W4O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 9 Jan 2023 10:11:17 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> The following commit is also in the dlm tree as a different commit
> (but the same patch):
>=20
>   2674cc2403f8 ("fs/dlm: Remove "select SRCU"")

This is now commit 7d470a3572f9 in the rcu tree ...
--=20
Cheers,
Stephen Rothwell

--Sig_/MlBNX4CZhfNE3u5Ea4n1W4O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPEqQcACgkQAVBC80lX
0GyMyQf+Juvna8neRXtFHrzgIHxi63+oQwYdeNQRAsLCG+a/IA/H9VAMnkoE7G/n
z3myqiDp3mGT/Z06SuVgusQG3dTp+EzuXszFkuzQxzgoCoJiiu4U5pi83nuSnPeJ
1xXMIHsys9TAW2QetnXI7xQPkULvBUIqTliSVZjGKZuggwfvphviJIKT17chPWky
+INb1a/TuVE/wpmYThjNKJGyihKgF+3i3EjcdUER/QuMDeQDRRW7oZcOWkYpVa9m
kCWID0/8zgjTco6cePUeTuhaIAskSr0JSgpgTNuHZVnjEUNszt4lNhEqbW6qsCNn
1zjWRcMl1igJC0aYKlS1hZkJ48abcg==
=pSJM
-----END PGP SIGNATURE-----

--Sig_/MlBNX4CZhfNE3u5Ea4n1W4O--
