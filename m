Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BDA74681D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 05:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGDDv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 23:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGDDvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 23:51:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3165BD;
        Mon,  3 Jul 2023 20:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688442710;
        bh=jPnurMM5cAmrp26T4bxCA7RPH8TaSXemYs2nA77cq3g=;
        h=Date:From:To:Cc:Subject:From;
        b=GA0XAyK81iGYZa9HMeJmIiVqPh8DWg/HgUDJO6JCTab/IvP8Y8kx2d/BNafMJ+Fbf
         HSjvRLYJzYMs9mlI855FD9d8VbzvDByRPwh5OsjT4m9T/SAOVxb7I0y29B0QfzGLxc
         X3YndeGfBS5Ze14C5qljx64rMNg3WV1iLB9FT9QblVMmkymuiOFMW2lrbwySrw8ibt
         H6YmgbUJ/KNp5Gj2tv9fJHiaZUIa6aqztYCqo0Tsv7mrvShzJplxgUOmE7HKTfxjgX
         Tkcirabs2zLL0Uy/wbEORHfY1tmFxHz+YK2gtKUzsRxlnJ0QHpImw545oGKEE2oyHL
         agW63jwJsTyMw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qw8456DNvz4wZw;
        Tue,  4 Jul 2023 13:51:49 +1000 (AEST)
Date:   Tue, 4 Jul 2023 13:51:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vfs-brauner tree
Message-ID: <20230704135149.014516c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X/yjNzOrjPzi6T=T9y7QebP";
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

--Sig_/X/yjNzOrjPzi6T=T9y7QebP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build
(htmldocs) produced this warning:

Documentation/filesystems/locking.rst:119: ERROR: Malformed table.
Text in column margin in table line 27.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ops             i_rwsem(inode)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
lookup:         shared
create:         exclusive
link:           exclusive (both)
mknod:          exclusive
symlink:        exclusive
mkdir:          exclusive
unlink:         exclusive (both)
rmdir:          exclusive (both)(see below)
rename:         exclusive (all) (see below)
readlink:       no
get_link:       no
setattr:        exclusive
permission:     no (may not block if called in rcu-walk mode)
get_inode_acl:  no
get_acl:        no
getattr:        no
listxattr:      no
fiemap:         no
update_time:    no
atomic_open:    shared (exclusive if O_CREAT is set in open flags)
tmpfile:        no
fileattr_get:   no or exclusive
fileattr_set:   exclusive
get_offset_ctx: no
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commit

  7a3472ae9614 ("libfs: Add directory operations for stable offsets")

--=20
Cheers,
Stephen Rothwell

--Sig_/X/yjNzOrjPzi6T=T9y7QebP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSjl1UACgkQAVBC80lX
0GxG5wf/WcDCcoItg8deiRtj+fs7lapP3cb6gLlwInKYv+5swyjU1xXmqYKtzeYH
ibuBkY7KZXjCDNVN00CyVn6NjY9PuvsQNkXcy1m8XtC47asSWdvE48kc/kloyh5p
FjayJoENOAJNJC5Zzx7wDpmyHIu2h1gtkpE3+a2gtCGiA4GlE8ZUbnVbbPiXumn3
S8zNhCqW79rCBEscvEJg1PQFkUBBmU6jwE4R5e7ERdBzBuRMOnk86CqSqbxxjuRf
5OP2BzTuqReEeUNoeCEbu/eV3mNysgvP0sbOrz0QTduvUCp5GEQlugwbEQoN3sUy
eoHeycUXAXfbyw+j8x26e8Xap1glUw==
=dk7K
-----END PGP SIGNATURE-----

--Sig_/X/yjNzOrjPzi6T=T9y7QebP--
